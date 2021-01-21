Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC417C433E0
	for <bpf@archiver.kernel.org>; Thu, 21 Jan 2021 07:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EEB323788
	for <bpf@archiver.kernel.org>; Thu, 21 Jan 2021 07:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAUHQA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jan 2021 02:16:00 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:47752 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbhAUHOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 02:14:52 -0500
Received: by mail-io1-f72.google.com with SMTP id t15so1829977ioi.14
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 23:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xo9ghie0HmQTCVFE6esqYP8OmOHWlrtIq/GxNkUwj5U=;
        b=or6tUxjkX+h+qHwaIUwyRwC4bJEm2fsRHkZyqNb6O5StyXkVPxjAKnDgjqnZWI2ZTx
         zwmpBHjvnSUS3z6DPiviUTTNJ7twzqwLOqRta7vWFH2YYo79QL/l0LP+OzSJVFrIH/Z6
         RV7KXjieptYdAEsR63ucDPDGiw4a8IUCvhW9ympMZu4t6yrYAeCcPTQWVGDgdAaky3Xi
         dy68wJXQa0BEK/9KVYUZfg+psZGHv3cPZ55lYE7Fe/os7E+67+JIOTZDs4ij+64n2SMk
         GdcZnZNnQD0UZMoOE3lOiuk/VWt2S66viP+H8OD5GbK0PkPQ6R+Rln5YDiUQg6DdDv0l
         jCSA==
X-Gm-Message-State: AOAM530NLfs5Ek2HVeRW3A06jnG4+OQU5YQ0PU6cBFeGIov4SD4sCp9c
        uvUeEP+x4/jFXmgSZ+auR0F4LdTtsiTJt9COomrxDX5v/AmO
X-Google-Smtp-Source: ABdhPJzDLnqdQook2ZXZb3CUnas5dN6lgKAj1/BZrrphe7tOta2u+ZsyZ5hzlDABjpjcMMegIBs85pqV27tUbqqi6hEb5rGPe9sv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:: with SMTP id g5mr10839151ilf.257.1611213251877;
 Wed, 20 Jan 2021 23:14:11 -0800 (PST)
Date:   Wed, 20 Jan 2021 23:14:11 -0800
In-Reply-To: <000000000000c8dd4a05b828d04c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000891f4605b963d113@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Read in bpf_trace_run7
From:   syzbot <syzbot+fad5d91c7158ce568634@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        netdev@vger.kernel.org, rostedt@goodmis.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this issue to:

commit 8b401f9ed2441ad9e219953927a842d24ed051fc
Author: Yonghong Song <yhs@fb.com>
Date:   Thu May 23 21:47:45 2019 +0000

    bpf: implement bpf_send_signal() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=123408e7500000
start commit:   7d68e382 bpf: Permit size-0 datasec
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=113408e7500000
console output: https://syzkaller.appspot.com/x/log.txt?x=163408e7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7843b8af99dff
dashboard link: https://syzkaller.appspot.com/bug?extid=fad5d91c7158ce568634
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1224daa4d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dfabd0d00000

Reported-by: syzbot+fad5d91c7158ce568634@syzkaller.appspotmail.com
Fixes: 8b401f9ed244 ("bpf: implement bpf_send_signal() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
