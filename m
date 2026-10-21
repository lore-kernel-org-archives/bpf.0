Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549246;
	b=AkTK5QB4ySfTvd96T0MR16K/pugMRiDK+uQr2iOOSLIyEuJ6GnKQSiY/QqVln7GASlvn
	 5WvlcArMUTx6OX7kH3CB2vbM0sSQNM7hSiMSfoiTQpxrjjH/b2kjZMis0ozkRudMiPhZz
	 qh7RiuWPAgtWLpxLLUQc5vATJAPrX6l7hQw9dOCwO4yVTnINoY9CgeyPwmEVxDVpf8Hxm
	 jQ7IO4UOnx3GRtmqLnu8EkQj4T+f6pNoZhaUp6DrmO8ZUWd+1R+cL2ypuyf+kAOSGyQ17
	 9VZtcuYiduc0xrnRyAcf1+jqcepk6YWAtAg3hNEN3tHmmPz86anQ632pMgJomSso4MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549246;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NocAOHMH6ZadGhcdFlGDkQVTqkooGtFHz+dU9O9aSI0=;
	b=3TE88ZRc8j/xHo8D5sRxrQspRuSZrmE+frERbh94hG462EO47+3INYHROeAjqSWXzfsW
	 RAMhr6B7OcOirxw8VHhSeBvTdr2M18sPOTH3iGfDo541Eg4l3fLAA26Dg1XBzlPgE8dYf
	 pn8xSUAAisgwkFYNB/zo0aEkUQ9ejOmJVtAO5vZQLcnht5Dyw27F/M1/jL2qBZU+nDn9m
	 Dt3OsCkOIIcN1nBeGqLQ1qYqBJDljke7C+enZAeynIzWcaq2BRKjssgkKLXycj8aYddfO
	 5PT/Kc9U2RhoU6zvzOok+IFdzRiOBz+rKkxHpau96UhO89LbHaoLG+B7d/X5Spm8WAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDqRpOQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CA606A31A;
	Wed, 21 Oct 2026 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDqRpOQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C951F000C9;
	Wed, 21 Oct 2026 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549246;
	bh=NocAOHMH6ZadGhcdFlGDkQVTqkooGtFHz+dU9O9aSI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eDqRpOQ2bE+iyzSRe3m73wPzbWFaXM6EuccCMNjaoDPcspO9z0Ei6l07Ep1hpJous
	 t8xHRPhC8l56vmKc8PnTPi0K63njCACZ+4pI1uYrv4DNBLLyti42MMf0I/klNITLxZ
	 43W1EixzDYWLtsYdCWk6YE5hQeoyIqOFNtowZh6QdEq4NGHVXn2hohd6FL0UbGqFFU
	 u4mgG+UhEhCwVLPqxPzDP956VnJuUluQ281rBLd+uEeQUERJXHxnXZTSnVeUm4SSob
	 c1TrOoBLo6mSpcCKdHIBIpau2cYdh2AtwhPFlTZ34SQWstWA0RJZAUl4dVB/r1rcIs
	 KVMP33K/7yUEQ==
Date: Tue, 20 Oct 2026 19:20:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 josef@toxicpanda.com, mason@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
Message-ID: <20261020192044.7c3a58a1@kernel.org>
In-Reply-To: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
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

On Sat, 17 Oct 2026 01:39:12 +0000 Alexei Starovoitov wrote:
> -	if (bpf_sk_storage_clone(sk, newsk))
> +	if (bpf_sk_storage_clone(sk, newsk)) {
> +		xfrm_sk_free_policy(newsk);
>  		goto free;
> +	}

why not add a new jump target and add the unwind at the end 
of the function?
-- 
pw-bot: cr
