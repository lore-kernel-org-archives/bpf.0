Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8114C433EF
	for <bpf@archiver.kernel.org>; Thu, 24 Mar 2022 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245450AbiCXILr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiCXILq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 04:11:46 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876CE55BE3
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 01:10:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id q6-20020a056e0215c600b002c2c4091914so2356171ilu.14
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 01:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t+jbwm74WRfF5Vzd3FgH+0bxmCGjbH06Iytwh85LND0=;
        b=3u9UkyMdEBLMolc8Dnci991CWYSqynYVyLIoAt8YJOEwQI+EMwuYsm786nAVDsmMYU
         vo2yY3/mGsQeSgh1tUvZiLm20RVFNon3q+AQvsNYnWeA43ZU/+Xvu6xVCn51YZxVuBj/
         OOtzk2N6j4iw3lmyX7Cn2nIqr4Hf6lNk8kKvipRPUm5guRskLF9pmM7NKM8vRVLwl9h0
         pNHCVbIOHIbTOHeMND+wCgdck2WPGWN9WSpaYz/ieEE9JxIUzPajpvZHqqk7wqEiipQL
         tJ5ZZF129z0BAtecfwQDLbOFa2NwuZ5lwQkXfpQ1igq1mRULs/dvPfW2SaveCDksLZof
         Etzg==
X-Gm-Message-State: AOAM532aFDyedn4IucZQSOq7iySdb4p3JYbvLbJeO1oaKC/sDVCKHy/j
        k/CTjmkrf1OX/SYeTUyEfRbI7PBWgT8BvFbWXpcBJzu9tVRL
X-Google-Smtp-Source: ABdhPJyewI41637tag9ZsdIiPUiLSCN1R04hKibsAvdjzY7pq62g5U8s4PEmwEA7W0dpXwluG2x0yCZviUScU4ZAte2D/dJNwK6b
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:2c7:e33f:2557 with SMTP id
 i3-20020a056e021d0300b002c7e33f2557mr2273855ila.15.1648109414852; Thu, 24 Mar
 2022 01:10:14 -0700 (PDT)
Date:   Thu, 24 Mar 2022 01:10:14 -0700
In-Reply-To: <000000000000acf1e405daebb7c7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000392f6005daf26000@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in __tcp_transmit_skb
From:   syzbot <syzbot+090d23ddbd5cd185c2e0@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, john.fastabend@gmail.com, kafai@fb.com,
        kgraul@linux.ibm.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit f2f2325ec79970807012dfc9e716cdbb02d9b574
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Feb 4 20:15:46 2022 +0000

    ip6mr: ip6mr_sk_done() can exit early in common cases

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16299d7b700000
start commit:   36c2e31ad25b net: geneve: add missing netlink policy and s..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15299d7b700000
console output: https://syzkaller.appspot.com/x/log.txt?x=11299d7b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a15e2288cf165c9
dashboard link: https://syzkaller.appspot.com/bug?extid=090d23ddbd5cd185c2e0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171eadbd700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cacda3700000

Reported-by: syzbot+090d23ddbd5cd185c2e0@syzkaller.appspotmail.com
Fixes: f2f2325ec799 ("ip6mr: ip6mr_sk_done() can exit early in common cases")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
