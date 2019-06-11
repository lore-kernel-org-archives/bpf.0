Return-Path: <SRS0=fZcT=UK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40014C4321A
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 07:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140362089E
	for <bpf@archiver.kernel.org>; Tue, 11 Jun 2019 07:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LCGuTjO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391274AbfFKHAW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 Jun 2019 03:00:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51187 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391233AbfFKHAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jun 2019 03:00:22 -0400
Received: by mail-it1-f195.google.com with SMTP id j194so3163472ite.0
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2019 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI5acHmkA6nTEYfV591ATb0I6pQPEbOKaKN82hg7RCM=;
        b=LCGuTjO2TxUrUxb2CuUCMlbw+aT+V48pldHb/E8/HyXyhAcJadkKRTydOYZaLbyaYO
         UFtSG+6oLe+7212hqKM3zKI58XosqcuQN5yr4MZTfClkV+lP9X7WQ/TXCkIwp6yJyjYQ
         UYYS+sSWMxLJRYXgoadzaDdOX6wf0CZSQJTjNdkoB9ahn/djzXI9gOhXuteD/YeX64dQ
         kxqaZKYtwHJQb9V6J8l+PKkw8OWqZtUF+CpghawnAHXjJ4dMpEi47ZhScw6UcIjjTkLw
         Ir++FWv/LC5oeZcD0gs7t5aN3QQ4bQIAvrA1jbE5wf551c9FBya6Q1MR/VSJ8vNZZ7Uw
         RBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI5acHmkA6nTEYfV591ATb0I6pQPEbOKaKN82hg7RCM=;
        b=aTCkxbIDnlpyBSDzOmjvmjyVg9QGSHr05bNrFzo/LICFWCAGt3HuL8GNASb+pe079i
         UHTtnJsor4E+/+28fRrKQw7WQexjkKLyCcxLKwbQmaQ8Aq7OKuVsQRUUv/ZfD4ggqImc
         Gg0/ra0OTz0u+RW4LBBSPsQkdxSU2HOoFf6pkW5fcSTt4HizPaN3Z9FBT8U4wKG5tkwg
         +ykZk+rfEuH1tvCWAOeX4EFnD8IVShGPPV1KZJ/RZLU1nzz7r104h0PRCAfiEE8gylw4
         LMx4nTN5GUqPbClsQsmLlliMyhqkNlWarFmbAtLa628UCvn7lCpBsG7G4eiPHR0LvIMP
         MeJw==
X-Gm-Message-State: APjAAAXsL77U0Q7ca1v3gryzCMtr8s8mcHkzD++Efk7tNVOjFakh68j2
        klv9LirDSqvEDxDj1sbH2fhsgFtmce73iy1hzgUMJw==
X-Google-Smtp-Source: APXvYqw5L3QgsGUT/uUiUEEf1cTR2kRkCU5zFtdPavouBPiFq6joDoKrg25++85Cx9Pi97zf+dP+doMtRgFU6BvEKSk=
X-Received: by 2002:a24:9083:: with SMTP id x125mr17320288itd.76.1560236421302;
 Tue, 11 Jun 2019 00:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0d84e058ad677aa@google.com> <87ftoh6si4.fsf@xmission.com>
In-Reply-To: <87ftoh6si4.fsf@xmission.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Jun 2019 09:00:09 +0200
Message-ID: <CACT4Y+btAivG8iYQFM=Qy_qMoE0SFNhx-ngjN=1hgf7UGrNViw@mail.gmail.com>
Subject: Re: general protection fault in mm_update_next_owner
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alexei Starovoitov <ast@kernel.org>, avagin@gmail.com,
        Daniel Borkmann <daniel@iogearbox.net>, dbueso@suse.de,
        John Fastabend <john.fastabend@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        prsood@codeaurora.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 10, 2019 at 11:27 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> syzbot <syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com> writes:
>
> > syzbot has bisected this bug to:
> >
> > commit e9db4ef6bf4ca9894bb324c76e01b8f1a16b2650
> > Author: John Fastabend <john.fastabend@gmail.com>
> > Date:   Sat Jun 30 13:17:47 2018 +0000
> >
> >     bpf: sockhash fix omitted bucket lock in sock_close
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e978e1a00000
> > start commit:   38e406f6 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> > git tree:       net
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=17e978e1a00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13e978e1a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=60564cb52ab29d5b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=f625baafb9a1c4bfc3f6
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1193d81ea00000
> >
> > Reported-by: syzbot+f625baafb9a1c4bfc3f6@syzkaller.appspotmail.com
> > Fixes: e9db4ef6bf4c ("bpf: sockhash fix omitted bucket lock in sock_close")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> How is mm_update_next_owner connected to bpf?


There seems to be a nasty bug in bpf that causes assorted crashes
throughout the kernel for some time. I've seen a bunch of reproducers
that do something with bpf and then cause a random crash. The more
unpleasant ones are the bugs without reproducers, because for these we
don't have a way to link them back to the bpf bug but they are still
hanging there without good explanation, e.g. maybe a part of one-off
crashes in moderation:
https://syzkaller.appspot.com/upstream#moderation2

Such bugs are nice to fix asap to not produce more and more random
crash reports.

Hillf, did you understand the mechanics of this bug and memory
corruption? A good question is why this was unnoticed by KASAN. If we
could make it catch it at the point of occurrence, then it would be a
single bug report clearly attributed to bpf rather then dozens of
assorted crashes.
