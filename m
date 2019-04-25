Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05457C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1562077C
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="ZOHd/ed0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDYTMx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:12:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40073 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYTMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:12:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id w20so431681qka.7
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2019 12:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Es+bKKo5d+/gXKrdHHa8u+avyIagjJRhqZTx6qGdw4k=;
        b=ZOHd/ed0KaSiFcnPpqJuS/ZDKP1Ia4MvdEYD2F0ugHgffDwLf2613T3zMS1097BToG
         mMursFKNPtBY1v6KXJ7B0Tlyf0MjpSRV//TyF5kh1hXqY6ONY1+btjaguR1lUVcI809U
         6b5D2GpZgMxYSkialKsHHSeReZ8Mlq8YQr1dNpCvACLDJhJZ2/TZhuWwgNLmOiFYKMbd
         IS2Ab0rUlP3ozcVl+DqmeGk4cWQppe/rPmFERzRWV7XXarvITJXwG3/5RXRgfsB9nHhr
         70J4K6EBxynP/LHaSTdusvnYqYowYHaXTxmXsnOnz3dnzXWd7UDhXmyfFvY6oltt8eED
         +9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Es+bKKo5d+/gXKrdHHa8u+avyIagjJRhqZTx6qGdw4k=;
        b=rogmBWD0T7PunFXCy0c7pvKV6Z8071gkf4GFu/Sn59Ciu87vhdC5ULcbu+pj6avy2P
         Psj3/zHLTQCQIRJZZ5IdP+pUc1EwI1QaQsnQc/ORxFchrl9VSLJx8t6WuiBVpkbWSigQ
         VQCUhfmkJV6c54KEP/oRWx5V4cwOuVwIq4/+YMluyQr/7IF0vR7b8yZxSngO5FzXdGjK
         /6pAmf1GaFVSWMF1j+XZA0szZ6I60I0VP2SfqXY+cmsv7c7Lcy2AwIBUj026fov2hPAo
         Bdi2315LNiKaWc7kVxZakRxcpNmKNy3FwKxgM69mWSo8pxKcsIpvN007O6hhW26ORYEO
         EHkw==
X-Gm-Message-State: APjAAAXMBfF05MBGySesYOCkpJFOe3PQ62xFpzs6xN0+uPc++AwIYoUg
        6Yzvsokz7AknTynsxdoGrGNX5w==
X-Google-Smtp-Source: APXvYqxDB2zz+8IpXqI+HezASOJAcWGiFM4aw96IAN8bO+IwaAP0uolSxzV8x3X3RB51iCTQhrPO1g==
X-Received: by 2002:a37:b88:: with SMTP id 130mr2180445qkl.83.1556219571667;
        Thu, 25 Apr 2019 12:12:51 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id q29sm5727205qkm.1.2019.04.25.12.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:12:51 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:12:44 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/3] sockmap/ktls fixes
Message-ID: <20190425121244.20f88505@cakuba.netronome.com>
In-Reply-To: <42a59b4b-3684-e7c5-d0dc-a46cf37dc8bb@gmail.com>
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
        <20190425113059.2a6f7eee@cakuba.netronome.com>
        <42a59b4b-3684-e7c5-d0dc-a46cf37dc8bb@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Apr 2019 11:49:18 -0700, John Fastabend wrote:
> On 4/25/19 11:30 AM, Jakub Kicinski wrote:
> > On Thu, 25 Apr 2019 09:02:50 -0700, John Fastabend wrote:  
> >> Series of fixes for sockmap and ktls, see patches for descriptions.
> >>
> >> v2: fix build issue for CONFIG_TLS_DEVICE and fixup couple comments from
> >>     Jakub.  
> > 
> > Ah, right my comment about the rx side sleeping was fairly nonsensical,
> > the locking issues is that the work queue tries to lock the same socket.
> >   
> 
> Right.
> 
> > But I'm hitting some nasties, there is a UAF on a non-offload socket,
> > and offload dies fairly hard.  It _could_ be my offload patches on top,
> > but "they worked yesterday".  Digging deeper on the offload side,
> > here's the UAF:  
> 
> hmm OK I see what is happening. I could also only enable the unhash for
> SW/SW  base proto. So only with,
> 
>   prot[TLS_SW][TLS_SW].unhash
> 
> There is this on the offload side did I smash it somehow?
> 
>    prot[TLS_HW_RECORD][TLS_HW_RECORD].unhash       = tls_hw_unhash;


Um, I think you're good there, note that the TLS_HW_RECORD thing is not
the nice packet-based offload, it's the TOE stuff from Chelsio.  I'm
using TLS_HW.

> Also I have this in my stack,

Thanks, I will toss this in.

> commit 01628cbabdf2fbf0b710a399f54ae005d0963f3f (HEAD -> ktls-fixes,
> refs/patches/ktls-fixes/bpf-sockmap-only-stop-strp-if)
> Author: John Fastabend <john.fastabend@gmail.com>
> Date:   Wed Apr 24 15:55:55 2019 -0700
> 
>     bpf: sockmap, only stop/flush strp if it was enabled at some point
> 
>     If we try to call strp_done on a parser that has never been
>     initialized, because the sockmap user is only using TX side for
>     example we get the following error.
> 
> 
>       [  883.422081] WARNING: CPU: 1 PID: 208 at kernel/workqueue.c:3030
> __flush_work+0x1ca/0x1e0
>       ...
>       [  883.422095] Workqueue: events sk_psock_destroy_deferred
>       [  883.422097] RIP: 0010:__flush_work+0x1ca/0x1e0
> 
> 
>     This had been wrapped in a 'if (psock->parser.enabled)' logic which
>     was broken because the strp_done() was never actually being called
>     because we do a strp_stop() earlier in the tear down logic will
>     set parser.enabled to false. This could result in a use after free
>     if work was still in the queue and was resolved by the patch here,
>     1d79895aef18f ("sk_msg: Always cancel strp work before freeing the
>     psock"). However, calling strp_stop(), done by the patch marked in
>     the fixes tag, only is useful if we never initialized a strp parser
>     program and never initialized the strp to start with. Because if
>     we had initialized a stream parser strp_stop() would have beencalled
>     by sk_psock_drop() earlier in the tear down process.  By forcing the
>     strp to stop we get past the WARNING in strp_done that checks
>     the stopped flag but calling cancel_work_sync on work that has never
>     been initialized is also wrong and generates the warning above.
> 
>     To fix check if the parser program exists. If the program exists
>     then the strp work has been initialized and must be sync'd and
>     cancelled before free'ing any structures. If no program exists we
>     never initialized the stream parser in the first place so skip the
>     sync/cancel logic implemented by strp_done.
> 
>     Finally, remove the strp_done its not needed and in the case where
>     we are using the
>     stream parser has already been called.
> 
>     Fixes: e8e3437762ad9 ("bpf: Stop the psock parser before canceling
> its work")
>     Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 782ae9eb4dce..4b4b9ad4bb86 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -555,8 +555,12 @@ static void sk_psock_destroy_deferred(struct
> work_struct *gc)
>         struct sk_psock *psock = container_of(gc, struct sk_psock, gc);
> 
>         /* No sk_callback_lock since already detached. */
> -       strp_stop(&psock->parser.strp);
> -       strp_done(&psock->parser.strp);
> +
> +       /* Parser has been stopped */
> +       if (psock->progs.skb_parser)
> +               strp_stop(&psock->parser.strp);
> +               strp_done(&psock->parser.strp);
> +       }
> 
>         cancel_work_sync(&psock->work);
