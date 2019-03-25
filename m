Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97D8C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 08:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DDC2087F
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 08:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCYITC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:19:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:55081 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfCYITC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 04:19:02 -0400
Received: by mail-it1-f198.google.com with SMTP id l140so585775ita.4
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2019 01:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LmSePle1Q7i5E3TFfLKW5E6iW6MEwWhgLXyiDGhpcX0=;
        b=NE8pripYiptAWLJx05uZtusn+4c1V1yrhpQ3ZcGLOnCwIgIkNCOjN7UmbMoQ7tAU27
         T2/a0JSu7QzjLf4wVF7M/Fy8yvZh8TKZ8XscBoms5clkStkzjUy7WQ0OZnTQyC8zEVES
         4FQFuwFa+PlgewjCzvv2MN5K32JnOZkCDos0Uixkpycf9dDED5+SPZS0QzJ9ua0FhCgP
         FZRNI+DvYpwe8Vi+5CX42YGQN1yfFEsbmrsWwW/V0g3wZ/pLVmAcJiDsUy+7qYyTAHZR
         Jqknp6Jsb/Wm8s6iBoFoUZKQrH8+8OYViKWhAceWKdZrQFog8fR5QBmFHEElZ/1aUJ/6
         0FVw==
X-Gm-Message-State: APjAAAUU55fxFSkX4mepfnza6sY2S1DL3yBwqSCeqRJ5Strd1LgsdaCh
        TfD+K2ZvuoRzXY3r1hIQSEkKWaVSfB+p1y/p9RYSbJ9tSzGt
X-Google-Smtp-Source: APXvYqxDyvOvfTDynESsGWWfoBj2nByndNyQH5qgj2QkqS/d+yEtb9ezpEpB0RvV0mJL5zgcBtfv81eQIuoakQVvuQDTkdXXgyFC
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25a:: with SMTP id w26mr16507161jaq.112.1553501941215;
 Mon, 25 Mar 2019 01:19:01 -0700 (PDT)
Date:   Mon, 25 Mar 2019 01:19:01 -0700
In-Reply-To: <0000000000003ba80905783e9189@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d37e60584e6db01@google.com>
Subject: Re: KASAN: use-after-free Write in skb_release_data (2)
From:   syzbot <syzbot+580be3953ed99133804f@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, lirongqing@baidu.com,
        magnus.karlsson@intel.com, maximmi@mellanox.com,
        netdev@vger.kernel.org, pabeni@redhat.com, soheil@google.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        vincent.whitchurch@axis.com, willemb@google.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 472c2e07eef045145bc1493cc94a01c87140780a
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Mar 22 15:56:39 2019 +0000

     tcp: add one skb cache for tx

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17abf52b200000
start commit:   68cc2999 Merge branch 'devlink-small-spring-cleanup'
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=146bf52b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=106bf52b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ab5bbbbf283c99a
dashboard link: https://syzkaller.appspot.com/bug?extid=580be3953ed99133804f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123a3d3b200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d34f93200000

Reported-by: syzbot+580be3953ed99133804f@syzkaller.appspotmail.com
Fixes: 472c2e07eef0 ("tcp: add one skb cache for tx")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
