Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472DC43219
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 18:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDD12067C
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WKLk98Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfDYSbF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:31:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46033 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfDYSbF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 14:31:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id b3so1185645qtc.12
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=D/kZyn/4tq4ZLf38SwqqVZtsGzY1j/oPfDwDTUgFD4M=;
        b=WKLk98XfncMw6fw8vi0QBc0wazKBhEQOO8q+MWXsz3HqkS0UCHO4X566kdD25Lcjv+
         DgZfF+OECo/WZGz6GS6tmqz2wpGVswNtVose04XbCQnweeZ2k4XKeiSmFoi/GfcafqmG
         cBzAG44qX0esDSg+2kJE87SY6NEcjFKq5usYMx7uTCvMRpLI4oCv4Gt1WeV+X3Fs5pTG
         daS/0MS3AmZrg4QAazLo2LIXydpXVY/72u//H6ZCascGjULEJV0tJIXZVBwo+pTptoHg
         hUCTj78Rwnx/CZgrFs4f/UwOJ+TJ46KbsiKhMc3PmJTKMhu7pXG7PAtDYtoKtSID+ZFQ
         Wv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=D/kZyn/4tq4ZLf38SwqqVZtsGzY1j/oPfDwDTUgFD4M=;
        b=adf7GXh2L9Ka3q6WVScxYyIBFDMGeCF+NPATMZ5SKJn60xt+lvIf2GYvuparT1UnUY
         5fJtn4RaivD/uzo/J/g6a6P2W3gc8nYQwkyeIpwOlykywGUXGgHEB3lrXHnFUcXBeLIg
         xWJnffZxlIepQ+AR0aEgFxXXilqDvWGIx8lRDPr886qxDnOq+dGlP9jN4wayKCrCzipI
         WQYRoI8xZ/Rk9FSu+Lo+9tCURH2Cfuvt3PadPG4TRfmPEr6VOL+Ln40ucb00bV7M8V1z
         gwDRtB7XmgcmmrboukcWTSmrms6W6gmbSs1JLfE+gKN/eYiMGwpJ3L8N0ssApUxR+fG2
         yjrw==
X-Gm-Message-State: APjAAAXULn3Zyif7cBY6yE03zchEWV1/OhnnDZ4K4T1XVNpzi+YRpWDi
        IkS/lAydTU1nNGtm9sgwpS12vg==
X-Google-Smtp-Source: APXvYqyNFX6RAV/KcPV7bDKlhkvdMP04n5ynBxf5LHAe5fV0hw3p7+MA0m7Y3kzV+4kHOCp+tv25yw==
X-Received: by 2002:a0c:adb3:: with SMTP id w48mr9851283qvc.117.1556217064067;
        Thu, 25 Apr 2019 11:31:04 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y189sm2694680qke.34.2019.04.25.11.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:31:03 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:30:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/3] sockmap/ktls fixes
Message-ID: <20190425113059.2a6f7eee@cakuba.netronome.com>
In-Reply-To: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Apr 2019 09:02:50 -0700, John Fastabend wrote:
> Series of fixes for sockmap and ktls, see patches for descriptions.
> 
> v2: fix build issue for CONFIG_TLS_DEVICE and fixup couple comments from
>     Jakub.

Ah, right my comment about the rx side sleeping was fairly nonsensical,
the locking issues is that the work queue tries to lock the same socket.

But I'm hitting some nasties, there is a UAF on a non-offload socket,
and offload dies fairly hard.  It _could_ be my offload patches on top,
but "they worked yesterday".  Digging deeper on the offload side,
here's the UAF:

[  258.559962] =================================================================
[  258.568212] BUG: KASAN: use-after-free in tls_sk_proto_close+0x1a9/0x1e0 [tl]
[  258.576398] Read of size 8 at addr ffff88871d1edf18 by task ktls_source/2542
[  258.584369] 
[  258.586121] CPU: 18 PID: 2542 Comm: ktls_source Not tainted 5.1.0-rc5-debug-7
[  258.596445] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/177
[  258.604968] Call Trace:
[  258.607796]  dump_stack+0x7c/0xc0
[  258.611594]  print_address_description.cold.2+0x9/0x239
[  258.617528]  kasan_report.cold.3+0x78/0x92
[  258.622200]  ? tls_sk_proto_close+0x1a9/0x1e0 [tls]
[  258.627745]  ? tcp_check_oom+0x390/0x390
[  258.632221]  tls_sk_proto_close+0x1a9/0x1e0 [tls]
[  258.637573]  inet_release+0xd6/0x1b0
[  258.641661]  __sock_release+0xc0/0x290
[  258.645942]  sock_close+0x11/0x20
[  258.649735]  __fput+0x244/0x730
[  258.653341]  task_work_run+0xfe/0x180
[  258.657530]  exit_to_usermode_loop+0x10d/0x130
[  258.662589]  do_syscall_64+0x2ff/0x400
[  258.666875]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  258.672630] RIP: 0033:0x7fb42bbe2421
[  258.676723] Code: f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00
[  258.697857] RSP: 002b:00007fffaabd9428 EFLAGS: 00000246 ORIG_RAX: 00000000003
[  258.706526] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb42bbe2421
[  258.714595] RDX: 00007fb41ffbf000 RSI: 000000000bebd000 RDI: 0000000000000003
[  258.722664] RBP: 0000000000000003 R08: 00000000ffffffff R09: 0000000000000000
[  258.730735] R10: 0000000000000022 R11: 0000000000000246 R12: 00007fb42b7df210
[  258.738805] R13: 00007fb41f923010 R14: 0000000000004113 R15: 0000000000000000
[  258.746875] 
[  258.748645] Allocated by task 2542:
[  258.752655]  create_ctx+0x46/0x2d0 [tls]
[  258.757129]  tls_init+0xd2/0x470 [tls]
[  258.761410]  tcp_set_ulp+0x235/0x4bf
[  258.765499]  do_tcp_setsockopt.isra.5+0x28b/0x1d90
[  258.770944]  __sys_setsockopt+0x10e/0x1d0
[  258.775514]  __x64_sys_setsockopt+0xba/0x150
[  258.780378]  do_syscall_64+0x96/0x400
[  258.784578]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  258.790308] 
[  258.792057] Freed by task 2542:
[  258.795656]  kfree+0xe5/0x300
[  258.799060]  tls_sk_proto_destroy+0x1c7/0x400 [tls]
[  258.804615]  tls_sk_proto_close+0x8a/0x1e0 [tls]
[  258.809870]  inet_release+0xd6/0x1b0
[  258.813953]  __sock_release+0xc0/0x290
[  258.818231]  sock_close+0x11/0x20
[  258.822023]  __fput+0x244/0x730
[  258.825620]  task_work_run+0xfe/0x180
[  258.829799]  exit_to_usermode_loop+0x10d/0x130
[  258.834855]  do_syscall_64+0x2ff/0x400
[  258.839136]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  258.844880] 
[  258.846649] The buggy address belongs to the object at ffff88871d1ede88
[  258.846649]  which belongs to the cache kmalloc-512 of size 512
[  258.860764] The buggy address is located 144 bytes inside of
[  258.860764]  512-byte region [ffff88871d1ede88, ffff88871d1ee088)
[  258.874002] The buggy address belongs to the page:
[  258.879450] page:ffffea001c747a00 count:1 mapcount:0 mapping:ffff88881e411080
[  258.892014] flags: 0x2ffff0000010200(slab|head)
[  258.897169] raw: 02ffff0000010200 ffffea001c88b208 ffffea00204bb208 ffff88880
[  258.905940] raw: ffff88871d1ed7c8 0000000000250019 00000001ffffffff 000000000
[  258.914711] page dumped because: kasan: bad access detected
[  258.921048] 
[  258.922797] Memory state around the buggy address:
[  258.928245]  ffff88871d1ede00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc c
[  258.936435]  ffff88871d1ede80: fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
[  258.944635] >ffff88871d1edf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
[  258.952830]                             ^
[  258.957401]  ffff88871d1edf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
[  258.965591]  ffff88871d1ee000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
[  258.973778] =================================================================
