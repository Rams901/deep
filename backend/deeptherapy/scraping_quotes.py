from selenium import webdriver
from bs4 import BeautifulSoup
import pandas as pd


# //For later development
# quotes = []
# quotes_by_class = []
# driver = webdriver.Chrome("D:/Fluts/chromedriver")
# driver.get('https://www.shopify.com/blog/motivational-quotes')
# print(driver.page_source)

# content = driver.page_source
# soup = BeautifulSoup(content)
# for a in soup.findAll('h3'):
#     print(a)
#     for 

# name=a.find('div', attrs={'class':'_3wU53n'})
# price=a.find('div', attrs={'class':'_1vC4OE _2rQ-NK'})
# rating=a.find('div', attrs={'class':'hGSR34 _2beYZw'})
# products.append(name.text)
# prices.append(price.text)
# ratings.append(rating.text) 

quotes = {'Anxiety':['“We cannot solve problems with the kind of thinking we employed when we came up with them.” — Albert Einstein',
'“Learn as if you will live forever, live like you will die tomorrow.” — Mahatma Gandhi',
'“Stay away from those people who try to disparage your ambitions. Small minds will always do that, but great minds will give you a feeling that you can become great too.” — Mark Twain',
'“When you give joy to other people, you get more joy in return. You should give a good thought to happiness that you can give out.”— Eleanor Roosevelt',
'“When you change your thoughts, remember to also change your world.”—Norman Vincent Peale',
'“It is only when we take chances, when our lives improve. The initial and the most difficult risk that we need to take is to become honest. —Walter Anderson',
'“Nature has given us all the pieces required to achieve exceptional wellness and health, but has left it to us to put these pieces together.”—Diane McLaren',
'"Success is not final; failure is not fatal: It is the courage to continue that counts." — Winston S. Churchill',
'"It is better to fail in originality than to succeed in imitation." — Herman Melville',
'"The road to success and the road to failure are almost exactly the same." — Colin R. Davis',
"“Success usually comes to those who are too busy looking for it.” — Henry David Thoreau",
"“Develop success from failures. Discouragement and failure are two of the surest stepping stones to success.” —Dale Carnegie",
"“Nothing in the world can take the place of Persistence. Talent will not; nothing is more common than unsuccessful men with talent. Genius will not; unrewarded genius is almost a proverb. Education will not; the world is full of educated derelicts. The slogan 'Press On' has solved and always will solve the problems of the human race.” —Calvin Coolidge",
'“There are three ways to ultimate success: The first way is to be kind. The second way is to be kind. The third way is to be kind.” —Mister Rogers',
'“Success is peace of mind, which is a direct result of self-satisfaction in knowing you made the effort to become the best of which you are capable.” —John Wooden',
'“I never dreamed about success. I worked for it.” —Estée Lauder',
'“Success is getting what you want, happiness is wanting what you get.” ―W. P. Kinsella',
'“The pessimist sees difficulty in every opportunity. The optimist sees opportunity in every difficulty." — Winston Churchill',
'“Don’t let yesterday take up too much of today.” — Will Rogers',
'“You learn more from failure than from success. Don’t let it stop you. Failure builds character.” — Unknown ',
'“If you are working on something that you really care about, you don’t have to be pushed. The vision pulls you.” — Steve Jobs',
'“Experience is a hard teacher because she gives the test first, the lesson afterwards.” ―Vernon Sanders Law',
'“To know how much there is to know is the beginning of learning to live.” —Dorothy West',
'“Goal setting is the secret to a compelling future.” — Tony Robbins',
'Shopify Academy Course: Goal Setting with Daymond John',
"“Concentrate all your thoughts upon the work in hand. The sun's rays do not burn until brought to a focus. “ — Alexander Graham Bell",
"“Either you run the day or the day runs you.” — Jim Rohn",
"“I’m a greater believer in luck, and I find the harder I work the more I have of it.” — Thomas Jefferson",
"“When we strive to become better than we are, everything around us becomes better too.” — Paulo Coelho",
"“Opportunity is missed by most people because it is dressed in overalls and looks like work.” — Thomas Edison",
"“Setting goals is the first step in turning the invisible into the visible.” — Tony Robbins",
"“Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it.” — Steve Jobs",
"“It’s not about better time management. It’s about better life management” — Alexandra of The Productivity Zone"], "Depression": ["“You've got to get up every morning with determination if you're going to go to bed with satisfaction.” — George Lorimer",
"“Education is the most powerful weapon which you can use to change the world.” — Nelson Mandela",
"“The most difficult thing is the decision to act, the rest is merely tenacity.” —Amelia Earhart", 
"“You’ll find that education is just about the only thing lying around loose in this world, and it’s about the only thing a fellow can have as much of as he’s willing to haul away.” —John Graham",
"“Take the attitude of a student, never be too big to ask questions, never know too much to learn something new.” —Augustine Og Mandino",
"“The elevator to success is out of order. You’ll have to use the stairs, one step at a time.” — Joe Girard",
"“Be a positive energy trampoline – absorb what you need and rebound more back.” — Dave Carolan",
"“People often say that motivation doesn’t last. Well, neither does bathing – that’s why we recommend it daily.” — Zig Ziglar",
"“Work until your bank account looks like a phone number.” — Unknown ",
"“I am so clever that sometimes I don’t understand a single word of what I am saying.” — Oscar Wilde",
"“People say nothing is impossible, but I do nothing every day.” — Winnie the Pooh",
"“Life is like a sewer… what you get out of it depends on what you put into it.” — Tom Lehrer",
"“I always wanted to be somebody, but now I realise I should have been more specific.” — Lily Tomlin",
"“Talent wins games, but teamwork and intelligence win championships.” — Michael Jordan",
"“Individual commitment to a group effort—that is what makes a team work, a company work, a society work, a civilisation work.” — Vince Lombardi",
"“Teamwork is the ability to work together toward a common vision. The ability to direct individual accomplishments toward organizational objectives. It is the fuel that allows common people to attain uncommon results.” — Andrew Carnegie",
"“Coming together is a beginning. Keeping together is progress. Working together is success.” — Henry Ford",
"“Alone we can do so little, together we can do so much.” — Helen Keller",
"“Remember, teamwork begins by building trust. And the only way to do that is to overcome our need for invulnerability.” — Patrick Lencioni",
"“I invite everyone to choose forgiveness rather than division, teamwork over personal ambition.” — Jean-Francois Cope",
"“You can get everything in life you want if you will just help enough other people get what they want.” —Zig Ziglar",
"“Inspiration does exist, but it must find you working.” —Pablo Picasso",
"“Don't settle for average. Bring your best to the moment. Then, whether it fails or succeeds, at least you know you gave all you had.” —Angela Bassett",
"“Show up, show up, show up, and after a while the muse shows up, too.” —Isabel Allende",
"“Don't bunt. Aim out of the ballpark. Aim for the company of immortals.” ―David Ogilvy",
"“I have stood on a mountain of no’s for one yes.” —Barbara Elaine Smith",
"“If you believe something needs to exist, if it's something you want to use yourself, don't let anyone ever stop you from doing it.” —Tobias Lütke",
"“Don't look at your feet to see if you are doing it right. Just dance.” ―Anne Lamott",
"“Someone's sitting in the shade today because someone planted a tree a long time ago.” —Warren Buffet",
"“True freedom is impossible without a mind made free by discipline.” ―Mortimer J. Adler",
"“Rivers know this: there is no hurry. We shall get there some day.” ―A.A. Milne",
"“There is a vitality, a life force, an energy, a quickening that is translated through you into action, and because there is only one of you in all time, this expression is unique. And if you block it, it will never exist through any other medium and will be lost.” ―Martha Graham",
"“Small is not just a stepping-stone. Small is a great destination itself.” ―Jason Fried",
"“He that can have patience can have what he will.” ―Benjamin Franklin",
"“The only one who can tell you “you can’t win” is you and you don’t have to listen.” —Jessica Ennis",
"“Set your goals high, and don’t stop till you get there.” —Bo Jackson",
"“Take your victories, whatever they may be, cherish them, use them, but don’t settle for them.” —Mia Hamm"],
'Family':["“Life can be much broader once you discover one simple fact: Everything around you that you call life was made up by people that were no smarter than you. And you can change it, you can influence it… Once you learn that, you'll never be the same again.” —Steve Jobs",
"“Life is like riding a bicycle. To keep your balance you must keep moving.” —Albert Einstein",
"“What you do speaks so loudly that I cannot hear what you say.” —Ralph Waldo Emerson",
"“I have never let my schooling interfere with my education.” —Mark Twain",
"“If you can't yet do great things, do small things in a great way.” ―Napoleon Hill",
"“If you really want to do something, you'll find a way. If you don't, you'll find an excuse.” ―Jim Rohn",
"“Be sure you put your feet in the right place, then stand firm.” ―Abraham Lincoln",
"“Live out of your imagination, not your history.” —Stephen Covey",
"“Do not wait for the perfect time and place to enter, for you are already onstage.” —Unknown",
"“The greater the difficulty, the more the glory in surmounting it.” ―Epicurus",
"Courage doesn't always roar. Sometimes courage is a quiet voice at the end of the day saying, 'I will try again tomorrow.' —Mary Anne Radmacher",
"“If the decisions you make about where you invest your blood, sweat, and tears are not consistent with the person you aspire to be, you’ll never become that person.” ―Clayton M. Christensen",
'“Fear of what other people will think is the single most paralyzing dynamic in business and in life. The best moment of my life was the day I realized that I no longer give a damn what anybody thinks. That’s enormously liberating and freeing, and it’s the only way to live your life and do your business” — Cindy Gallop',
'“The only way of discovering the limits of the possible is to venture a little way past them into the impossible.” ―Arthur C. Clarke',
'"Worry is a misuse of imagination." —Unknown ',
"“Courage is the most important of all the virtues because without courage, you can't practice any other virtue consistently.” ―Maya Angelou",
'"I never look back, darling. It distracts from the now." —Edna Mode',
'"A year from now you will wish you had started today." —Unknown',
'"The reason we struggle with insecurity is because we compare our behind-the-scenes with everyone else’s highlight reel." —Steve Furtick',
'"Somewhere, something incredible is waiting to be known.” —Carl Sagan',
'“I will not lose, for even in defeat, there’s a valuable lesson learned, so it evens up for me.” —Jay-Z',
'“I do not try to dance better than anyone else. I only try to dance better than myself.” —Arianna Huffington',
'“If you don’t risk anything, you risk even more.” —Erica Jong',
"“Failure is simply the opportunity to begin again, this time more intelligently.” — Henry Ford",
"“Our greatest glory is not in never falling, but in rising every time we fall.” — Confucius ",
"“If you change the way you look at things, the things you look at change.” — Wayne Dyer",
"“We must reach out our hand in friendship and dignity both to those who would befriend us and those who would be our enemy.” — Arthur Ashe",
"“It's fine to celebrate success but it is more important to heed the lessons of failure.” — Bill Gates",
"I can’t tell you how many times I’ve been given a no. Only to find that a better, brighter, bigger yes was right around the corner.” — Arlan Hamilton",
"“We need to accept that we won’t always make the right decisions, that we’ll screw up royally sometimes – understanding that failure is not the opposite of success, it’s part of success.” — Ariana Huffington",
"“When everything seems to be going against you, remember that the airplane takes off against the wind, not with it.” — Henry Ford",
"“You cannot always control what goes on outside. But you can always control what goes on inside.” — Wayne Dyer",
"“We are what we repeatedly do. Excellence, then, is not an act, but a habit.” — Aristotle",
"“Start where you are. Use what you have. Do what you can.” — Arthur Ashe",
"“Hustle beats talent when talent doesn’t hustle” – Ross Simmonds"]}

print(len(quotes['Depression']), len(quotes['Anxiety']), len(quotes['Family']))