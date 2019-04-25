Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA2C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A58420717
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 18:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ti+2V40d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfDYStd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:49:33 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54733 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfDYStd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 14:49:33 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so1785244ite.4;
        Thu, 25 Apr 2019 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wm+w4EiGAu6/0vIcg2nxzQq+S7pifkcMY9Pxw2BYv0s=;
        b=ti+2V40dtdFugv8N3x9qiA3XLeVJovN8bz1HC+o7nG9+iuwT9FFkMTqM+ePPSrvx8E
         MjXGDXQpTW81sI1k2HY+MlmRl9RdfOGrMl/3OmvtNDOjXsrSwx81BqupJIveOBjWztou
         RQaYc+AOnbCkDnz77V87l5SbrHpuWhPUFDhqzgdZedgi5gmgKCtCaopEjjF5eau2gf8J
         7jvvADDjM3ju+4VITmEgsVVWktNaURb5vLd864p2Dpb9viJ5d/93cfzT0s5fgm8jSxEs
         13IZmp5P3fHstfI4h2b7EMW10y0Ci/MZpoIlNT2KY9Gf874zLx0KhGxZ3OI8BqBx0MpJ
         J3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wm+w4EiGAu6/0vIcg2nxzQq+S7pifkcMY9Pxw2BYv0s=;
        b=aCX3HgqSL9ygZmqHfH3nNQCN8mifmFz/fTAGrawxte4/zQMebykkFZUt+ZmC7bOyd9
         NMYiMkFxKHVBPoqufbnuuukM1+ie2GDgSSeScRNJQlpV7gkkHVgXSBhiZjZjBfjnObiG
         U9N6GPgrKQaIQ5pl5yaj+tFeCNvtYycyvyMjoNXV6aniJquyBj0XawyvymU0U9qZy1tE
         7p81AsGIrFxEAoEjJGMxekuB0a7nxaidtNDnXCCvEM3yeGW/MDF35Dp17aLJkfY59gCb
         REHX6AbDM7jJmuuZZ40nm1YexqryDy/EitfSK2D61EpgpvbPMLfcp4C6QIPYNxpkgHzy
         rYBw==
X-Gm-Message-State: APjAAAUXK/q8rrn1hxcF6jEkckBx7CLoTXiniWX3RE1pgKzwQgO0zqH+
        UUiNSa1sIHOpRbKUV5EJ5YcyyAOD/rU=
X-Google-Smtp-Source: APXvYqwhvQ5KbdEvRBxUA8QWYXtuRoyzdpGHKLwgF7Fu2DOl9rRBA634ChOm6IIZ/T6DpRgC9a72aA==
X-Received: by 2002:a24:df02:: with SMTP id r2mr5555763itg.104.1556218172308;
        Thu, 25 Apr 2019 11:49:32 -0700 (PDT)
Received: from [192.168.86.29] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id m81sm11167780itm.33.2019.04.25.11.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:49:31 -0700 (PDT)
Subject: Re: [bpf PATCH v2 0/3] sockmap/ktls fixes
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
 <20190425113059.2a6f7eee@cakuba.netronome.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <42a59b4b-3684-e7c5-d0dc-a46cf37dc8bb@gmail.com>
Date:   Thu, 25 Apr 2019 11:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425113059.2a6f7eee@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/19 11:30 AM, Jakub Kicinski wrote:
> On Thu, 25 Apr 2019 09:02:50 -0700, John Fastabend wrote:
>> Series of fixes for sockmap and ktls, see patches for descriptions.
>>
>> v2: fix build issue for CONFIG_TLS_DEVICE and fixup couple comments from
>>     Jakub.
> 
> Ah, right my comment about the rx side sleeping was fairly nonsensical,
> the locking issues is that the work queue tries to lock the same socket.
> 

Right.

> But I'm hitting some nasties, there is a UAF on a non-offload socket,
> and offload dies fairly hard.  It _could_ be my offload patches on top,
> but "they worked yesterday".  Digging deeper on the offload side,
> here's the UAF:

hmm OK I see what is happening. I could also only enable the unhash for
SW/SW  base proto. So only with,

  prot[TLS_SW][TLS_SW].unhash

There is this on the offload side did I smash it somehow?

   prot[TLS_HW_RECORD][TLS_HW_RECORD].unhash       = tls_hw_unhash;

Also I have this in my stack,

commit 01628cbabdf2fbf0b710a399f54ae005d0963f3f (HEAD -> ktls-fixes,
refs/patches/ktls-fixes/bpf-sockmap-only-stop-strp-if)
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Wed Apr 24 15:55:55 2019 -0700

    bpf: sockmap, only stop/flush strp if it was enabled at some point

    If we try to call strp_done on a parser that has never been
    initialized, because the sockmap user is only using TX side for
    example we get the following error.


      [  883.422081] WARNING: CPU: 1 PID: 208 at kernel/workqueue.c:3030
__flush_work+0x1ca/0x1e0
      ...
      [  883.422095] Workqueue: events sk_psock_destroy_deferred
      [  883.422097] RIP: 0010:__flush_work+0x1ca/0x1e0


    This had been wrapped in a 'if (psock->parser.enabled)' logic which
    was broken because the strp_done() was never actually being called
    because we do a strp_stop() earlier in the tear down logic will
    set parser.enabled to false. This could result in a use after free
    if work was still in the queue and was resolved by the patch here,
    1d79895aef18f ("sk_msg: Always cancel strp work before freeing the
    psock"). However, calling strp_stop(), done by the patch marked in
    the fixes tag, only is useful if we never initialized a strp parser
    program and never initialized the strp to start with. Because if
    we had initialized a stream parser strp_stop() would have beencalled
    by sk_psock_drop() earlier in the tear down process.  By forcing the
    strp to stop we get past the WARNING in strp_done that checks
    the stopped flag but calling cancel_work_sync on work that has never
    been initialized is also wrong and generates the warning above.

    To fix check if the parser program exists. If the program exists
    then the strp work has been initialized and must be sync'd and
    cancelled before free'ing any structures. If no program exists we
    never initialized the stream parser in the first place so skip the
    sync/cancel logic implemented by strp_done.

    Finally, remove the strp_done its not needed and in the case where
    we are using the
    stream parser has already been called.

    Fixes: e8e3437762ad9 ("bpf: Stop the psock parser before canceling
its work")
    Signed-off-by: John Fastabend <john.fastabend@gmail.com>

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 782ae9eb4dce..4b4b9ad4bb86 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -555,8 +555,12 @@ static void sk_psock_destroy_deferred(struct
work_struct *gc)
        struct sk_psock *psock = container_of(gc, struct sk_psock, gc);

        /* No sk_callback_lock since already detached. */
-       strp_stop(&psock->parser.strp);
-       strp_done(&psock->parser.strp);
+
+       /* Parser has been stopped */
+       if (psock->progs.skb_parser)
+               strp_stop(&psock->parser.strp);
+               strp_done(&psock->parser.strp);
+       }

        cancel_work_sync(&psock->work);


> 
> [  258.559962] =================================================================
> [  258.568212] BUG: KASAN: use-after-free in tls_sk_proto_close+0x1a9/0x1e0 [tl]
> [  258.576398] Read of size 8 at addr ffff88871d1edf18 by task ktls_source/2542
> [  258.584369] 
> [  258.586121] CPU: 18 PID: 2542 Comm: ktls_source Not tainted 5.1.0-rc5-debug-7
> [  258.596445] Hardware name: Dell Inc. PowerEdge R730/072T6D, BIOS 2.4.3 01/177
> [  258.604968] Call Trace:
> [  258.607796]  dump_stack+0x7c/0xc0
> [  258.611594]  print_address_description.cold.2+0x9/0x239
> [  258.617528]  kasan_report.cold.3+0x78/0x92
> [  258.622200]  ? tls_sk_proto_close+0x1a9/0x1e0 [tls]
> [  258.627745]  ? tcp_check_oom+0x390/0x390
> [  258.632221]  tls_sk_proto_close+0x1a9/0x1e0 [tls]
> [  258.637573]  inet_release+0xd6/0x1b0
> [  258.641661]  __sock_release+0xc0/0x290
> [  258.645942]  sock_close+0x11/0x20
> [  258.649735]  __fput+0x244/0x730
> [  258.653341]  task_work_run+0xfe/0x180
> [  258.657530]  exit_to_usermode_loop+0x10d/0x130
> [  258.662589]  do_syscall_64+0x2ff/0x400
> [  258.666875]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  258.672630] RIP: 0033:0x7fb42bbe2421
> [  258.676723] Code: f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00
> [  258.697857] RSP: 002b:00007fffaabd9428 EFLAGS: 00000246 ORIG_RAX: 00000000003
> [  258.706526] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb42bbe2421
> [  258.714595] RDX: 00007fb41ffbf000 RSI: 000000000bebd000 RDI: 0000000000000003
> [  258.722664] RBP: 0000000000000003 R08: 00000000ffffffff R09: 0000000000000000
> [  258.730735] R10: 0000000000000022 R11: 0000000000000246 R12: 00007fb42b7df210
> [  258.738805] R13: 00007fb41f923010 R14: 0000000000004113 R15: 0000000000000000
> [  258.746875] 
> [  258.748645] Allocated by task 2542:
> [  258.752655]  create_ctx+0x46/0x2d0 [tls]
> [  258.757129]  tls_init+0xd2/0x470 [tls]
> [  258.761410]  tcp_set_ulp+0x235/0x4bf
> [  258.765499]  do_tcp_setsockopt.isra.5+0x28b/0x1d90
> [  258.770944]  __sys_setsockopt+0x10e/0x1d0
> [  258.775514]  __x64_sys_setsockopt+0xba/0x150
> [  258.780378]  do_syscall_64+0x96/0x400
> [  258.784578]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  258.790308] 
> [  258.792057] Freed by task 2542:
> [  258.795656]  kfree+0xe5/0x300
> [  258.799060]  tls_sk_proto_destroy+0x1c7/0x400 [tls]
> [  258.804615]  tls_sk_proto_close+0x8a/0x1e0 [tls]
> [  258.809870]  inet_release+0xd6/0x1b0
> [  258.813953]  __sock_release+0xc0/0x290
> [  258.818231]  sock_close+0x11/0x20
> [  258.822023]  __fput+0x244/0x730
> [  258.825620]  task_work_run+0xfe/0x180
> [  258.829799]  exit_to_usermode_loop+0x10d/0x130
> [  258.834855]  do_syscall_64+0x2ff/0x400
> [  258.839136]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  258.844880] 
> [  258.846649] The buggy address belongs to the object at ffff88871d1ede88
> [  258.846649]  which belongs to the cache kmalloc-512 of size 512
> [  258.860764] The buggy address is located 144 bytes inside of
> [  258.860764]  512-byte region [ffff88871d1ede88, ffff88871d1ee088)
> [  258.874002] The buggy address belongs to the page:
> [  258.879450] page:ffffea001c747a00 count:1 mapcount:0 mapping:ffff88881e411080
> [  258.892014] flags: 0x2ffff0000010200(slab|head)
> [  258.897169] raw: 02ffff0000010200 ffffea001c88b208 ffffea00204bb208 ffff88880
> [  258.905940] raw: ffff88871d1ed7c8 0000000000250019 00000001ffffffff 000000000
> [  258.914711] page dumped because: kasan: bad access detected
> [  258.921048] 
> [  258.922797] Memory state around the buggy address:
> [  258.928245]  ffff88871d1ede00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc c
> [  258.936435]  ffff88871d1ede80: fc fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
> [  258.944635] >ffff88871d1edf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
> [  258.952830]                             ^
> [  258.957401]  ffff88871d1edf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
> [  258.965591]  ffff88871d1ee000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb b
> [  258.973778] =================================================================
> 

