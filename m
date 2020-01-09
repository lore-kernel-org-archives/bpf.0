Return-Path: <SRS0=lXkO=26=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F35BC33C9E
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614A820705
	for <bpf@archiver.kernel.org>; Thu,  9 Jan 2020 01:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578533675;
	bh=L3mfRJUcGGHYyqz8ZxVIXWFWXUrULZcPO95byLbD5Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=etVP5KWXxOEw6b9kNRJzs7Ij1W4LYT3MhfE2cZ1D2r6/P1AH5/TFDCva/YZPtrv+K
	 r723wlKZBlR7nl+1+f7m95gkAgXedKCVpoclnKE5OGqmTfWczosOK2fGuobLqLi1vE
	 mj9dYaqd46JHGePfxw8k6Vq3B+5phT/0jK41F2Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgAIBef (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Jan 2020 20:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgAIBee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jan 2020 20:34:34 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9B62070E;
        Thu,  9 Jan 2020 01:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578533674;
        bh=L3mfRJUcGGHYyqz8ZxVIXWFWXUrULZcPO95byLbD5Q4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VfZ1bfONB7euu3xny3swkkuOh6BM6ZGdMC5qvE5MUNKqWutpdV7tw5Uy0yorNVwa1
         6WRHuLJiREmnaQkkKo14/7wKF1w2bCFg68MJY6aFNzyuIXVbaTqOfcFPx90PYkdKyO
         GqiZqFYxslOiHGA7vbwWr4DSfTYxK4SQxkpxnGZo=
Received: by mail-qk1-f170.google.com with SMTP id c16so4572544qko.6;
        Wed, 08 Jan 2020 17:34:33 -0800 (PST)
X-Gm-Message-State: APjAAAVxDLacwsLfsNPXZss6w8G1wTZZPbMXjY1/jf5rUjDJWpv1v8Fl
        wvKI3NbQjj3MXmTONeA9648VntmX7BfB0PfmQmQ=
X-Google-Smtp-Source: APXvYqwXApudmZ/cAtPrPB4ISgJr9rZ56Kzrhq6ZQwXMkjMet8n2YFg4yW5vbUEckgM18C1ehfd9lwhHXaijlr3oZDg=
X-Received: by 2002:ae9:f502:: with SMTP id o2mr6851044qkg.89.1578533673038;
 Wed, 08 Jan 2020 17:34:33 -0800 (PST)
MIME-Version: 1.0
References: <157851776348.1732.12600714815781177085.stgit@ubuntu3-kvm2> <157851804766.1732.2480524840189309989.stgit@ubuntu3-kvm2>
In-Reply-To: <157851804766.1732.2480524840189309989.stgit@ubuntu3-kvm2>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jan 2020 17:34:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6CR20_81kkmp5k=h9uhZWMyLEwyeD2K5yd3RzK+pVgww@mail.gmail.com>
Message-ID: <CAPhsuW6CR20_81kkmp5k=h9uhZWMyLEwyeD2K5yd3RzK+pVgww@mail.gmail.com>
Subject: Re: [bpf PATCH 1/9] bpf: sockmap/tls, during free we may call
 tcp_bpf_unhash() in loop
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 8, 2020 at 1:14 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> When a sockmap is free'd and a socket in the map is enabled with tls
> we tear down the bpf context on the socket, the psock struct and state,
> and then call tcp_update_ulp(). The tcp_update_ulp() call is to inform
> the tls stack it needs to update its saved sock ops so that when the tls
> socket is later destroyed it doesn't try to call the now destroyed psock
> hooks.
>
> This is about keeping stacked ULPs in good shape so they always have
> the right set of stacked ops.
>
> However, recently unhash() hook was removed from TLS side. But, the
> sockmap/bpf side is not doing any extra work to update the unhash op
> when is torn down instead expecting TLS side to manage it. So both
> TLS and sockmap believe the other side is managing the op and instead
> no one updates the hook so it continues to point at tcp_bpf_unhash().
> When unhash hook is called we call tcp_bpf_unhash() which detects the
> psock has already been destroyed and calls sk->sk_prot_unhash() which
> calls tcp_bpf_unhash() yet again and so on looping and hanging the core.
>
> To fix have sockmap tear down logic fixup the stale pointer.
>
> Fixes: 5d92e631b8be ("net/tls: partially revert fix transition through disconnect with close")
> Reported-by: syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Cc: stable@vger.kernel.org
Acked-by: Song Liu <songliubraving@fb.com>
