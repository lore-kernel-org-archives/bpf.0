Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AC3612CF
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303952; cv=none; b=Y4zySt3dQ2udKFDk1fD9QKDMKCGjNV+mX+tFSEuAR2Gm0jq0zWzgBxC1YM21geMSV6mTSwR1J3UVYqq2JUmJjV7iagb3883vRIJkwzZ9VuA+9dW0qrp3ah+5N0SzrKkSV8XqJk3XC67uPksaIUP/RO97B5nDwU+GRhqZs1/0lPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303952; c=relaxed/simple;
	bh=4Nrwj8V7kFFv4LKN1AV12PUOMiDIUX0q5YXokCtB84k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K346dDYoCB91NJFyjcq/vv7KmO0EvKCdn/hy+vMRQTO00OofFs+WNnl2qCz7pmjCJPHtsHNbk0+najEXYbf0k6GCo5QVvJ+5vOY26EppbGt3APLgeJXoNHik85OW/pSEUwbKXcZpWMkvCJnOHlLqSIizlQK4y32ea9v2V1RGMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=xgfJKfSL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="xgfJKfSL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e27035206so631373b3a.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785303946; x=1785908746; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h4j8/bcJx2sqaNy1FkkD1tKrJ77EePT5Y3UEZ3HBUKo=;
        b=xgfJKfSLWn+8ol107LlGs4YbMA6idVfWeJGe9C30EOEbiUI1xhcXbaxtH/2DfSVR+H
         4i0N1LsL/3SSPvGYfLB30HY9kDJU7By6GOomuSztIttVikTZ1DnK4xgQH3RIXCxeqFzA
         xgpgOTFjYJbMiHaiea/gBh4tHJ7vK8A42IsXgY8u1jziO5amafraZ95Po+FcxLO/ZTW5
         smfEh05pFJFBVjiYUmjdfxOh7Ev4Vlr4uZxyYAKlBb0NahyGnY0yD8gOynd4RPMIVrvd
         GkDIVkst/xrIWc2jg7lPz+/V4/nZBlT3yG4rbtLDfm9GQZ2fk1YWZfgi8aunUx5FZ3Q2
         EaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303946; x=1785908746;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h4j8/bcJx2sqaNy1FkkD1tKrJ77EePT5Y3UEZ3HBUKo=;
        b=hMz4paB+4zt+dkaamhszK6WqwLTNsPgm9Nd6p6WTtbRzI72wrvjg9OkppjJE/t9Zut
         pgTkFemE/MSanf9H0H0Btzj5Iejz8CcJirArbKVk9tTVJNWbBwgZo/HmPjeA8bLQlotw
         u7qSoniO9GJNV+3Uexqqy4JJe+UrPMEwDX1JSIcoFgnuoM2zPlvrDTpXFXvmGsFbk927
         OIcaRfzdYxlRaMWPzKJU/Bbf5l5hQxsudllaGYpE5/h4AeamfgaanjhNUMgszALKN8lK
         oDESpvB6l5cmbWBaDxRyW5Uvp6Lrizpxe+w07UAfyMNvDim0/TCs/773J5AlbUYmHZSq
         hpug==
X-Forwarded-Encrypted: i=1; AHgh+RpCd3ud3mLDblcusnmihBJ8dB1TecGWzQ5T1AIXHWQZeKQDPVWRpkPvOXgNVAAQhX2CPZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbisxy3trY4JQpWDXwfSCUbQngRbB6WmGbrok+QFMiqKR2a1lw
	Ap1VuZZMwAtoiWkRSPq5XUp4dXZr0iO6xFp4rXtkgyUAMNS3XB/wHEb3CsH89YAJ+qg=
X-Gm-Gg: AR+sD109wceYO9IYmOgOdK8n28m+mt559zQQLb1qob9HtbX+x4yt78ztQ4StjDn1Jtb
	Rnj6DSnvnIdgO510e0UD5PqDBTZvrXoKS2ynMm+rK0ecJ6+pUlQlDQKC7FAP7rPsnG+MPb0ZWt6
	42P5DrpZceYt4+rwP3x9R1r64aECA0SLH/nAYlt0BD6Ys4hVujn2SzHn01PT/5VuL1r/ZDMy3N6
	5q98p2d8TeZSPEbORVzZvga13TvPLmhHgle/L12QJgTx+8Hr9Hx9lITSmpUQsD01m0ReC65esM3
	wgn1UGhbSf5kXCnwQRFciENHF/lqfz+IiDHQ7eFt/xRDFCUGEYilSBvXuH+dS6riCqrp7URoopN
	iVyHSm7CRGLWKe/k2ALh5QLO1HoRspm8bqAuq0H8tn+OV3agiG29kCmyRkg1mUAFsDkgTPUX2CR
	+FyHIhJjBStGAIMj+JhYP8GO9p3EDBk36hpp+bNZcAoz/8FHUBAj6WRzHmmOu3p8sTXsM5pKh4W
	Msj2tpP35Rn9tzo6A==
X-Received: by 2002:a05:6a00:2d84:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84e9315a58cmr5454901b3a.21.1785303946026;
        Tue, 28 Jul 2026 22:45:46 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03cbd1csm792779b3a.53.2026.07.28.22.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 22:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 01:45:44 -0400
Message-Id: <DKATFHMTL31E.272MMJP3JGDGG@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf, sockmap: Fix sk_redir use-after-free in send
 verdict
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Neal Cardwell" <ncardwell@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "open list:BPF [L7 FRAMEWORK]
 (sockmap)" <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260719152207.2892156-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719152207.2892156-1-nicoyip.dev@gmail.com>

On Sun Jul 19, 2026 at 11:22 AM EDT, Chengfeng Ye wrote:
> sk_psock_msg_verdict() takes a socket reference for psock->sk_redir.
> tcp_bpf_send_verdict() copies that pointer while holding the source socke=
t
> lock, but does not take a reference for the local copy before dropping th=
e
> lock around tcp_bpf_sendmsg_redir().
>
> When apply_bytes keeps the cached verdict active, another sendmsg() on th=
e
> same source socket can consume the remaining bytes and release the cached
> reference while the first thread still holds only the raw local pointer:
>
>   CPU 0                                  CPU 1
>   sk_redir =3D psock->sk_redir
>   apply_bytes remains nonzero
>   release_sock(sk)
>                                          lock_sock(sk)
>                                          apply_bytes reaches zero
>                                          psock->sk_redir =3D NULL
>                                          release_sock(sk)
>                                          tcp_bpf_sendmsg_redir(sk_redir)
>                                          sock_put(sk_redir)
>   tcp_bpf_sendmsg_redir(sk_redir)
>
> The final sock_put() can free sk_redir before CPU 0 dereferences it.
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in tcp_bpf_sendmsg_redir+0xf39/0x1020
>   Read of size 8 at addr ffff888108537090 by task poc/87
>   Call Trace:
>    tcp_bpf_sendmsg_redir+0xf39/0x1020
>    tcp_bpf_sendmsg+0x977/0x1a50
>    __sys_sendto+0x32c/0x3a0
>    __x64_sys_sendto+0xdb/0x1b0
>   Allocated by task 85:
>    sk_prot_alloc+0x56/0x210
>    sk_clone+0x6f/0x14b0
>    inet_csk_clone_lock+0x24/0x740
>    tcp_create_openreq_child+0x25/0x2710
>    tcp_v4_syn_recv_sock+0x10a/0xe00
>   Freed by task 0:
>    __kasan_slab_free+0x43/0x70
>    slab_free_after_rcu_debug+0xa6/0x1e0
>    rcu_core+0x50a/0x1850
>   Last potentially related work creation:
>    __sk_destruct+0x3da/0x540
>    sk_psock_destroy+0x81e/0xab0
>    process_one_work+0x63a/0x1070
>
> Take a temporary socket reference while the source socket lock still
> protects psock->sk_redir, and drop it after tcp_bpf_sendmsg_redir()
> returns.  This keeps each unlocked use independent of cached-verdict
> ownership.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/ipv4/tcp_bpf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8e905b50dead..69cc8bc33bcd 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -469,6 +469,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, stru=
ct sk_psock *psock,
>  	case __SK_REDIRECT:
>  		redir_ingress =3D psock->redir_ingress;
>  		sk_redir =3D psock->sk_redir;
> +		sock_hold(sk_redir);
>  		sk_msg_apply_bytes(psock, tosend);
>  		if (!psock->apply_bytes) {
>  			/* Clean up before releasing the sock lock. */
> @@ -489,6 +490,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, stru=
ct sk_psock *psock,
> =20
>  		if (eval =3D=3D __SK_REDIRECT)
>  			sock_put(sk_redir);
> +		sock_put(sk_redir);
> =20
>  		lock_sock(sk);
>  		sk_mem_uncharge(sk, sent);

