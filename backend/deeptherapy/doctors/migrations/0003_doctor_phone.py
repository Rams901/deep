# Generated by Django 3.0.3 on 2022-05-29 01:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('doctors', '0002_auto_20220529_0039'),
    ]

    operations = [
        migrations.AddField(
            model_name='doctor',
            name='phone',
            field=models.CharField(default=0, max_length=20),
            preserve_default=False,
        ),
    ]
