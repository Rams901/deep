import pickle
import os
import datetime
# df = pd.read_csv("Admission_Predict.csv")

# X = df.loc[:,'gre_score':'research']
# y = df['chance_of_admit']>=.8

# x_train, x_test, y_train, y_test = train_test_split(X,y, random_state=0, test_size=0.2)
# dt = DecisionTreeClassifier(max_depth=2, ccp_alpha=0.01,criterion='gini')
# dt.fit(x_train, y_train)

# # y_pred = dt.predict(x_test)
# print(dt.score(x_test, y_test))
# print(accuracy_score(y_test, y_pred))


#show directory and find the correct path to model.pkl

def generate_results(x):
    options = ['Completely agree','Somewhat agree','Neutral','Somewhat disagree','Completely disagree']
    cases = ['Depression', 'Anxiety', 'Family Issues']

    print(x)
    
    print(os.listdir())
    print(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    print('hi')
    model = pickle.load(open('doctors/model.pkl','rb'))
    print(x)
    train = [(lambda x: 0 if x == "No" else (1 if x == "Yes" else int(x)))(i) for i in x[:4]]
    print([train])
    pred = model.predict([train])
    print(pred)
    case = dict([(cases[i], options.index(option)) for i, option in enumerate(x[4:7])])
    print(case)

    report = {'Progress': float(pred), 'activities': [x[-2]],'count': 1, 'link_id': '123', 'Date': datetime.datetime.now(), **case}
    print(report)
    # data = x["additional"]
    # print(data)
    # x['additional']
    # model.predict(data)

    return report