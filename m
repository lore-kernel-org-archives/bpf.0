Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781386;
	b=i8/yf7XkIP/Eflq3vKOGRpVlLW9NwwU+Js6JdMg+MfbsCPBPIktzWl33lBlYCpJrgdRI
	 CMC/PaWjFyuNIOd1IqH5/j5EgNg0kXP7dC32/ppbpQ83dFj12bKTrKitoCsH1uNRoDqJY
	 dVyVukZUw7lBQEX6P8BnzdoNimRGNvYA2NlPjgTIpz+mXdWaJWKS2nQkX6XST8JaMI7P6
	 m6S0ltrbQx5rbK7PUeKJRD+K6JSwG9WNCs1E5AJ9uiP31lIXCg1HKcklIr0JY6dQ15gA/
	 i+twvEWS8i57W1jou1G1pjwLq13aHNm+MVxa0xECdijBFCvaYhsk9hzpwTuu9xkJnSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type;
	bh=kRn+RRijVRpoCV8xutnfH1OUHDfITNNqfJwRjbr2SSA=;
	b=U7xV0jd0a7InPP9NCQB3D8ESmgw9fbYMJm254L0+twd1n8xVPACdmjcN4oPQ49pFqHi8
	 tpN3IlNtIWVjZsgiSpr7K3s/jV+2NRa/H5og8JCyHoTC2sIkoE9sxx9nELkeU9z3q/67w
	 ZUAbbqe67De2GuDp8JHBPOgB9lmTtgdwxveWX/AXflMQQihqYyF9yss8TVHBW+ck7ZhEN
	 88BBj89QHKKMrSXJ3KswHX/UmIxmeJPjX6OxN15ZS71kRUchXP8D9lfhm0cXaTFAOjrxk
	 NG3fFZQ2xD8sNSFZNFo9M8UmZRVT0Ua07HyYM46ulZus6pYut3pKo7iyk7yGHsi/pYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CBNfolMm;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B27606A31E
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 18:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B27606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=CBNfolMm
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so371204466b.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792781384; x=1793386184; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kRn+RRijVRpoCV8xutnfH1OUHDfITNNqfJwRjbr2SSA=;
        b=CBNfolMm4kvuPGCm3aw48sfTmwamlA4qa5/vBQ95rOYiggajn+gMzrmTHIQ5se8bfd
         5iAav3K3pe0+du1vF8WmI8rnFgrHQJoZc0S5MX7X3QuFeHa0yQH4HLO8GIscToZ6FwP7
         6GB6PADZv2EyQ7VDIgrn+naV6TqlwX+/CXiv+i9HNqyaODrT2YRYgROSGhiKfstwVd4I
         fSfr6616v2A2NPQj6BWKl5CN8M1RRZWA7vRI1aQbuGgtC0eaBuhKAZvlfaOBAbQDZPhp
         83o5K2qqPT61QXkHLAmJeduOlxv7G2gXps0TsDYY2XpzJ7VnCMPm/YmaqKzbi14hR+mI
         Npzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781384; x=1793386184;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kRn+RRijVRpoCV8xutnfH1OUHDfITNNqfJwRjbr2SSA=;
        b=o04PiinTJcGSqnrmeT7a6wRieUNZgX7MsOs2MQxFIPnQ/dIsP2AeiLtHH9nHFMlOVl
         ecAMmZp7MiTJ6y14ClFuxCaqUGESOxO32Wv9LxUg9+nlTdUQ1zx6YJHABR4HuRanvjTb
         GuSPvuJxeWsnV3wSuBEOaTm+W9XmOzruqesZDslYZHYhENv04qRPNZjFLsrEouV7sIxN
         O5RdxKhBeNqcjii275roBJUaV8hs3rbQphnSOpkEowipjLm+QMMVXLDrN9CYUEQwVc/f
         QtayhacvlUj9Gqc4etDTNwVpewBC2/Gq/59zssTYI5h2Jf+XrM+opahxgjGDk/urViq9
         PETQ==
X-Forwarded-Encrypted: i=1; AKwUvBykgJ0KzRwAIzHS7hPj6DLBFYdx49u7KRFvR/ozuOUXWxGouiiv3DRndsJDtL5GY+De6ig=@vger.kernel.org
X-Gm-Message-State: AFq9FYJR6dewTD8d/tAAidmFApy4lE9EhnE39o/yOd9Q/42lKqb3nQLO
	t3cxjM482TX/NMAgHyQBlWaT5DlBoLOba0txFgkRVDryE8bh7e34oQRMG1LS/jsRmn0=
X-Gm-Gg: AYBFou0pjX99uvdWdzLaXqgxBrtpPU4slWIh0+nzKvo1MsXqTO8nDWzEdrb+FQrjJVR
	PLTC5DKRBgf/X3G8sQ4DzosokXHaDhINxJkistf3+z4em5HARmWp3CD5bWq6030M8sghUQxyXp0
	ka8GC2aT2aIZaFtCJR4QznNbGTdWgnusnDEsaLcP9995OYlRRgaJhmmfGwxAfG58vlZwcehd87w
	R9uu363q+p9uT4wmTgBNNxKGxhWqJ179LxK3ykg90pPs5NJgvJeKIzv3bM8ARPFDeDgQFcx75ny
	yK+SBZom6eXT5KXyw2wkFhHtGmCesXym1IVDXlr1twue63UVrZbvAeDkt/eW59pJnAD9U5/fZvZ
	vJv7Be5ci0VC2T9gO0vwFKT30xdbUHt18pvUc5uinKHIsAvXtHSz/cV9eOf6ANN811k/cIwApis
	FHP5glAUzGjejnObQIVLzaGMnCv/Kxtgy+2Hr7PTawXSbKQgXXOehAq8nMiMfUrjTxmd8jluspZ
	3b99nCtZY/O8KV/7HMkBsg5E782hy+NTW5tV/NfABiDSAtA
X-Received: by 2002:a17:907:160e:b0:c31:71f4:819d with SMTP id a640c23a62f3a-c468d8d2fabmr938278666b.30.1792781384549;
        Fri, 23 Oct 2026 11:49:44 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:5067:295f::41f:29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46b8ce40b5sm30863166b.58.2026.10.23.11.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:49:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Dudu Lu"
 <phx0fer@gmail.com>
Cc: <john.fastabend@gmail.com>,  <jiayuan.chen@linux.dev>,
  <netdev@vger.kernel.org>,  <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
In-Reply-To: <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> (Alexei Starovoitov's
	message of "Thu, 22 Oct 2026 15:40:17 +0000")
References: <20261021155629.68813-1-phx0fer@gmail.com>
	<20261022054811.35008-1-phx0fer@gmail.com>
	<DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 23 Oct 2026 20:49:42 +0200
Message-ID: <871p9g6ym1.fsf@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 22, 2026 at 03:40 PM GMT, Alexei Starovoitov wrote:
> On Wed, Oct 21, 2026 at 10:48 PM Dudu Lu <phx0fer@gmail.com> wrote:
>> Annotate every one of these accesses with READ_ONCE()/WRITE_ONCE(),
>> matching the existing convention for the same fields: sk->sk_data_ready
>
> This makes KCSAN quiet and leaves the race where it is.
>
> sock_map_link() runs under the sock lock. sock_map_delete_elem() doesn't
> take it. sk_callback_lock is the only lock they share and sock_map_link()
> takes it after psock_set_prog() and sock_map_init_proto().
> So two tcp_bpf_update_proto(sk, psock, false) can run in parallel:
>   cpu0: sock_map_link() for a map with msg_parser sees
>         psock->progs.stream_verdict and picks TCP_BPF_TXRX
>   cpu1: sock_map_del_link() stops the verdict and stores TCP_BPF_TX
>   cpu0: stores TCP_BPF_TXRX

Right, so:
- map_update_elem syscall vs close(fd) - OK (lock_sock protected),
- map_update_elem syscall vs map_delete_elem syscall - RACY,
- map_update_elem syscall vs TCP RST (destroy) - RACY,
- map_update_elem from BPF vs close(fd) - RACY.

> The socket is left with tcp_bpf_recvmsg_parser() and no verdict prog.
> That's what commit c0d95d3380ee fixed.
> Take the lock earlier. Then psock_update_sk_prot needs no annotation.
>
> All accesses to saved_data_ready are under sk_callback_lock except the
> three reads in sock_map_del_link(). Move that check under the lock instead
> of annotating it. No need to touch skmsg.c and skmsg.h.
>
> Only the two lockless reads of sk->sk_prot need READ_ONCE().
>
> Something like this (compile tested only):
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 38df842..20fb605 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -152,11 +152,11 @@ static void sock_map_del_link(struct sock *sk,
>  			struct bpf_map *map = link->map;
>  			struct sk_psock_progs *progs = sock_map_progs(map);
>
> -			if (psock->saved_data_ready && progs->stream_parser)
> +			if (progs->stream_parser)
>  				strp_stop = true;
> -			if (psock->saved_data_ready && progs->stream_verdict)
> +			if (progs->stream_verdict)
>  				verdict_stop = true;
> -			if (psock->saved_data_ready && progs->skb_verdict)
> +			if (progs->skb_verdict)
>  				verdict_stop = true;
>  			list_del(&link->list);
>  			sk_psock_free_link(link);
> @@ -164,8 +164,11 @@ static void sock_map_del_link(struct sock *sk,
>  		}
>  	}
>  	spin_unlock_bh(&psock->link_lock);
> -	if (strp_stop || verdict_stop) {
> -		write_lock_bh(&sk->sk_callback_lock);
> +	if (!strp_stop && !verdict_stop)
> +		return;
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +	if (psock->saved_data_ready) {
>  		if (strp_stop)
>  			sk_psock_stop_strp(sk, psock);
>  		if (verdict_stop)
> @@ -173,8 +176,8 @@ static void sock_map_del_link(struct sock *sk,
>
>  		if (psock->psock_update_sk_prot)
>  			psock->psock_update_sk_prot(sk, psock, false);
> -		write_unlock_bh(&sk->sk_callback_lock);
>  	}
> +	write_unlock_bh(&sk->sk_callback_lock);
>  }
>
>  static void sock_map_unref(struct sock *sk, void *link_raw)
> @@ -202,7 +205,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
>  	rcu_read_lock();
>  	psock = sk_psock(sk);
>  	if (psock) {
> -		if (sk->sk_prot->close != sock_map_close) {
> +		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
>  			psock = ERR_PTR(-EBUSY);
>  			goto out;
>  		}
> @@ -284,6 +287,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  		}
>  	}
>
> +	write_lock_bh(&sk->sk_callback_lock);
>  	if (msg_parser)
>  		psock_set_prog(&psock->progs.msg_parser, msg_parser);
>  	if (stream_parser)
> @@ -298,11 +302,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
>  	 */
>  	ret = sock_map_init_proto(sk, psock);
>  	if (ret < 0) {
> +		write_unlock_bh(&sk->sk_callback_lock);
>  		sk_psock_put(sk, psock);
>  		goto out;
>  	}
>
> -	write_lock_bh(&sk->sk_callback_lock);
>  	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
>  		if (sk_is_tcp(sk))
>  			ret = sk_psock_init_strp(sk, psock);
> @@ -536,7 +540,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
>
>  static bool sock_map_sk_is_suitable(const struct sock *sk)
>  {
> -	return !!sk->sk_prot->psock_update_sk_prot;
> +	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
>  }
>
>  static bool sock_map_sk_state_allowed(const struct sock *sk)

Code LGTM
