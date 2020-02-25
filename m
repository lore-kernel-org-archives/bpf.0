Return-Path: <SRS0=/C52=4N=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9004C35E01
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44222084E
	for <bpf@archiver.kernel.org>; Tue, 25 Feb 2020 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582651344;
	bh=q+DOof4oroaO5Yi7qwHVuCfgAP+NNk5JLaWkvo7r3+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CEd5AYU9DZTpQfDMZM7IGcE4XqP7BAM3PZhQ5azmpLVDA8f/cOHgFDyKxHPNI29y8
	 rs+M0yZHo9DNiSmK0gk7Qit+Ro9mR6VifWMRd4Ut1n8rieNJS9XAnD4dwv3nSghVGx
	 H5zfruscCBf+8tpE1UTtnk8yBKFfGE7LQzfh7anA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgBYRWY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:22:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:54328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgBYRWY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 12:22:24 -0500
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F41C20CC7;
        Tue, 25 Feb 2020 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582651343;
        bh=q+DOof4oroaO5Yi7qwHVuCfgAP+NNk5JLaWkvo7r3+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0qz1INtfsDhFxaC9mkZJFhW/djubDGAGn7BRbJk7BELA6BFxPT3E1G1B701uVTDDq
         8WVu0YP84hD1XFnNoAm4q5T7Ys+G0anUNtSW2loDhRHRW5PmwVGxfDdv/RA1mLAHEt
         zpVtIILLVrdAmjm7XJZ7Z8/63Q4U5ztVr9fODFvo=
Received: by mail-lj1-f169.google.com with SMTP id n18so14928446ljo.7;
        Tue, 25 Feb 2020 09:22:23 -0800 (PST)
X-Gm-Message-State: APjAAAXRtTWYMOQjbyTxTF92vxVZI51hYnntci1fAKlupJWqHmzvehhc
        uFeIcGs+ZTM5bQw9lRSWBfbHCBH3kNSUp/GQbc0=
X-Google-Smtp-Source: APXvYqyzNsL9L7+nRjBe8EoA+mHWLJQMcUQPmCkFK5Iuyndmyg0IqB48EKf4BLcsNb21/9kikLvNgA6tSWebIf8RFsI=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr76722ljn.64.1582651341444;
 Tue, 25 Feb 2020 09:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20200225135636.5768-1-lmb@cloudflare.com> <20200225135636.5768-3-lmb@cloudflare.com>
In-Reply-To: <20200225135636.5768-3-lmb@cloudflare.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 25 Feb 2020 09:22:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW48_Hd1Ei-NckYjitXqFV6D8P_uVW7bH5RgkD_4NXZ2jQ@mail.gmail.com>
Message-ID: <CAPhsuW48_Hd1Ei-NckYjitXqFV6D8P_uVW7bH5RgkD_4NXZ2jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: sockmap: move generic sockmap hooks
 from BPF TCP
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 25, 2020 at 5:57 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> The close, unhash and clone handlers from TCP sockmap are actually generic,
> and can be reused by UDP sockmap. Move the helpers into the sockmap code base
> and expose them.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  include/linux/bpf.h   |  4 ++-
>  include/linux/skmsg.h | 28 ----------------
>  net/core/sock_map.c   | 77 +++++++++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_bpf.c    | 55 ++-----------------------------
>  4 files changed, 79 insertions(+), 85 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 49b1a70e12c8..8422ab6a63d8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1355,6 +1355,8 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
>  #if defined(CONFIG_BPF_STREAM_PARSER)
>  int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog, u32 which);
>  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
> +void sock_map_unhash(struct sock *sk);
> +void sock_map_close(struct sock *sk, long timeout);

I think we still need dummy version of these two functions in the #else
cause?
