Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531424;
	b=Q6nPUBTGT2pK/32zMB1eJiiyPGUG0V1s6lzIUcUG+ZDEB5ezry+a7SFyI+QB0dr5XE/a
	 1/KaL3C5Nx0qpRtFvFTldJjLNL04KVhzGyptfs8SS/TArG80rJ4h4KlwG8ihms4oC4FC5
	 yCiXHdpKHK/BwavprFm0McctZw0qI1Z+awEORof69SK/T+D9Dg8GMF71zxPxk1qB9gR/r
	 EySTFYSpzW7quEwu8eeZb9FLnKPzvPIISJMvkNWagSdDyqtmAsar4CerdTgIfCW4dq2+p
	 lqCkp4YoX0/RNyozk+OpDZEAcp8WGxMSpX/OZeEE5S6GJDIxNQHHHVlDfn9GiFG6bMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531424;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZxazoxFfvQjoDUQqiz+xsumUrKhuZ1mAIEpNZ6TX/OQ=;
	b=ORZAjmJDXkX+qdpnX/xLoVKx8EFIxbQhFz0fMUhQGrExd9LX6uO7cXhtz/JG46DmgF6w
	 wyTyy+VaKQ5f7X+A53WnN5mHsser+hxZ10NKGp6hVcu/tMLz+Jguu33hhftX7Fc0IWaJ9
	 BLk6svkXvlan+Q82uUXKYojeS/F13I5roHf1HJrfqyHtyC1+W7VlLbKAjPet/DspPkWKe
	 /QChuGRpV7c8tBl5qDHcKfv+th1oIW4h9Lq6CoFeEvOJAccTxaq6ygEB25K+zOprvFzbJ
	 48rbQUXrGeg1n3kcSYZYdXbMeS+0XinAHn6i8ASgdHhWbuRiRlk6PgKapVenVJfYyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtmX4Jkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1AB606A31D;
	Tue, 20 Oct 2026 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtmX4Jkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878D11F000C9;
	Tue, 20 Oct 2026 21:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531424;
	bh=ZxazoxFfvQjoDUQqiz+xsumUrKhuZ1mAIEpNZ6TX/OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KtmX4JkjicdIgW4yniqHaYolaj2KOqRElrhRQt5w4Tc7+mQRgQnLWrYEQzyiXiTFJ
	 /ek+IFdIBcctA8AQMnEVXAIaPQvaU/YfgCSx695SLIC0EAQ3OdbBhSOdHE++ISxkBB
	 YFSL+EBmhLcDPTsW6TSLliMGbsVdDXfsdIvurVubCRED1rw2mUj6BreWkrOqCaWJP4
	 e/r3c6f/GGBLdKP0/hf78xHAjt4AKFCYw3ahqMg72H/gKOTRp2RFO2BGmvS+HpDRKM
	 2BvI7In55xO+3pCS9qjrOnmBGsAHgu+lZH2GNATuHUav7PQh12wX74f4Psj4nMy3VV
	 Ecegorc+NXB9g==
Date: Tue, 20 Oct 2026 14:23:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Cc: quanyeyang@proton.me, John Fastabend <john.fastabend@gmail.com>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan
 Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] tls: annotate lockless access to
 sk->sk_err
Message-ID: <20261020142342.4d9ef62c@kernel.org>
In-Reply-To: <20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me>
References: <20261015-tls-fix-sk-kcsan-err-v4-0-391d788327f3@proton.me>
	<20261015-tls-fix-sk-kcsan-err-v4-1-391d788327f3@proton.me>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 20:31:36 -0700 Quanye Yang via B4 Relay wrote:
>  	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	int ret = 0;
> +	int skerr;
>  	long timeo;

reverse xmas tree

>  	/* a rekey is pending, let userspace deal with it */
> @@ -1107,10 +1114,14 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
>  	timeo = sock_rcvtimeo(sk, nonblock);
>  
>  	while (!tls_strp_msg_ready(ctx)) {
> -		if (sk->sk_err) {
> -			if (has_copied)
> -				return -READ_ONCE(sk->sk_err);
> -			return sock_error(sk);
> +		if (has_copied) {
> +			skerr = READ_ONCE(sk->sk_err);
> +			if (skerr)
> +				return -skerr;
> +		} else {
> +			skerr = sock_error(sk);
> +			if (skerr)
> +				return skerr;
>  		}
>  
>  		if (ret < 0)
> @@ -1132,10 +1143,14 @@ tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
>  		 * sk_err here so a connection abort surfaces as the
>  		 * actual error rather than a clean EOF.
>  		 */
> -		if (sk->sk_err) {
> -			if (has_copied)
> -				return -READ_ONCE(sk->sk_err);
> -			return sock_error(sk);
> +		if (has_copied) {
> +			skerr = READ_ONCE(sk->sk_err);
> +			if (skerr)
> +				return -skerr;
> +		} else {
> +			skerr = sock_error(sk);
> +			if (skerr)
> +				return skerr;

duplicating this now longish check twice in the same function is ugly
this needs to be refactored somehow
-- 
pw-bot: cr
