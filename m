Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51445C43461
	for <bpf@archiver.kernel.org>; Thu,  1 Apr 2021 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D61E610C7
	for <bpf@archiver.kernel.org>; Thu,  1 Apr 2021 18:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhDASIq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:08:46 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35478 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhDASBJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 14:01:09 -0400
Received: by mail-io1-f71.google.com with SMTP id v24so4552427ion.2
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 11:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=t1PSBwAKPIxSsjyHhjvOvydGcJv2nwxNeNnnB0pN5z4=;
        b=rSt7iSZd0mqZi9GuQkNacon4s1czTrHm0Kz/t0QawrtZ2jRlgh0smsRsdAFVlhL0DD
         7U531k5PPubQxHkZkoumKC5apiwcgHzgtPSnzBfpKzmUcBcE6zJMeJ/MZXDw+FnSwKyr
         p9GeV0CiBQrH5VnSnGNiKB+HGDNPH8Au4pya9+lrtHW4GABtI1uyezQyzRWHYXzZckVZ
         GgjGe+UaWl1MIjvVucNFqsTHnm8RTgKPWaTawkLqBlJlmRXGnxfmAAVSYBqOZTKMvgxs
         Be2lUO8QZ5PXhaGHG3bOfDxyMa0oXn+yQBSd0ygtE/uD0dTFI9Qgeerc5teZJFdyRnv6
         GW8g==
X-Gm-Message-State: AOAM531I4PPHA2kbKpHAVEoaRccU3TDEv+Qyelo10Xxl793J2InoWSkm
        dQsosy12DkgpA1p6CshHcisBxQ6eruKax38znrZ85Kf1x7kA
X-Google-Smtp-Source: ABdhPJyvO0s22tKhZ9WnikY25h0lMQFGQxk3fm8YQuGAfS4QejjBrmdhMtUZGFynSyNRa1nHaVnvvFGyw+hSTQlenTkj1ltd289T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170c:: with SMTP id u12mr7856308ill.100.1617300067465;
 Thu, 01 Apr 2021 11:01:07 -0700 (PDT)
Date:   Thu, 01 Apr 2021 11:01:07 -0700
In-Reply-To: <000000000000680f2905afd0649c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000043f2c05beed04d8@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in bpf_trace_run2
From:   syzbot <syzbot+cc36fd07553c0512f5f7@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, mingo@redhat.com, mmullins@mmlx.us,
        netdev@vger.kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit befe6d946551d65cddbd32b9cb0170b0249fd5ed
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Wed Nov 18 14:34:05 2020 +0000

    tracepoint: Do not fail unregistering a probe due to memory failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f0260ed00000
start commit:   12450081 libbpf: Fix native endian assumption when parsing..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ac0d21536db480b
dashboard link: https://syzkaller.appspot.com/bug?extid=cc36fd07553c0512f5f7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1365d2c3900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d5f08d900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: tracepoint: Do not fail unregistering a probe due to memory failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
