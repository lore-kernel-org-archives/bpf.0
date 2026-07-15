Received: from mail-ej2-f1.google.com (mail-ej2-f1.google.com [74.125.228.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CE3EC69B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139520; cv=none; b=eBbaULuypCjIIEGaz6g0neHmMRfzKCxujzk2QH3fxwde+OXUSkbm/LaUMZpYhzVQEw6kQuLBEPIep70PW8K3OxFM2cGTxofJXRXcOuy1Q6LfWpgFMX5ZtNZFVvL0WR76ybqOX25dp8PN5a5Z+hMoSRwO8U2dZwt40ETUectyyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139520; c=relaxed/simple;
	bh=CGnwrvxBZUBJNsGDc5J38Smj3FbBScJs1UW9f6LEfxU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=srJeV6vgxnmdxL+xvNFo4k4PYLnEWeVR5WmJ0EaNnnjy10xGqv9yCUhvg4UaZntn/67btRguMsx/nQQUcslecXdHLuwvfYoaC/RlfyofRHm8MKOYx9gyZElW+rbDI/VexBuIvrPKjSLYAxxahJnmJ6iNKZbEceGZ0OaEFL4G7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heIJXOwj; arc=none smtp.client-ip=74.125.228.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heIJXOwj"
Received: by mail-ej2-f1.google.com with SMTP id a640c23a62f3a-c15be3ef521so70241766b.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139516; x=1784744316; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YL44ie3Qr6HiLZb3x0pAWallDq/vLBABEZmepMhurnA=;
        b=heIJXOwjYQKFPHWkuCaHpLcsye7Ssa6Pvk53YxiuzPICpmcT9BgBjksJbLx9zImUgz
         o+ZfmxAj/Yuni8SZidzI0sAarpWUWbseUXI0VDNFUXBP89Uk2sHDKQbtgLGgzhVyHDxp
         tjWZzzpFcTLa681GC4llZU2Ue1w20vOTTfZJbX0IRkLXG5vbPUqOsOr8Gmba9dnPoAjT
         Epg7TeXI/lO6pFb9eN22g8pODfo0PagZDFDPjuUF+dUQYU892WASWBzMbpk2mKkLNW1Y
         Key4Y9BWj2CgF6UjLYheOAoGBGpfXfkgVpVAsMc91u89kyv3nItQVGwwPxghQYZms3q+
         d7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139516; x=1784744316;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YL44ie3Qr6HiLZb3x0pAWallDq/vLBABEZmepMhurnA=;
        b=oQrW7JGepyAKqbbHFFNmW9Sd4aM49TInWuzcRyoZzJAPZmXdVTcnqNtkA4rREe33pF
         i8WPeshL805YjZrbPZTP0/5ntLGnvBAINQf6Q4AujKv40LMA0vdEgNSy7GzA/ie2RaLr
         RlCEZXby1sEkSRUSW/HKRppPn/dp+KSTA62WY9yiUxIzf5GI3jmUtLP6YzdRRFWP5Y8T
         +iOunia1DXUv03EG14s/eRVVR33r+n9pr6yDz8Abs6/4UCehTQrox3HcgnWojbiSIgFg
         uaa2ky5/p2hFWbk4QaRDCndRwOv4P97qyBJz8WdZZ7qnvHrsZdzO6OHW5Y/YiOV3zQLD
         dVNw==
X-Forwarded-Encrypted: i=1; AHgh+RqlyZeqqQsBm9pq55mmXRmfBPu/knEwKtNW10T1Sra4BQTbOYtbvvssJQjHirN86ZL7ok4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsmg6biTFBvqK3QzRfC6hf038Mr8O3JOmEef1F+fusc8+fEWsv
	RDT33lJa1+Nhebi6sQs0B0K3yM6qJZwpkm2l3Mle7rrvCLMWju9tgVyD
X-Gm-Gg: AfdE7cl4rZw3oky6Tcu6a8AUSgB0doSnLXQXVLtE5Vhqxqa0i031PdU81uE9bgcUavj
	iIgVWHd9iv5cRXpjZjSMAUVyKNA86CzHlw4gBh9gMrB0FdcmoXCx+NkI7Js5pT61ZS+pGes11jT
	dY9QZjVu3UEmoRrguZE0G9eVzr2JngpaxVEZ3q9MYe8Jzj3iCFr3rhozD3OY+ZScFNidbTYPZ2I
	dRtsVbf6nPEQXRYEK5hNqfYzaNXKiE+RGoJEpnQ91rdtVTmgYZi46vCL1dv7j8sW9+gem/Yl0bx
	IRzlTGaWpSZVydJh99qQnsHcxK3N7PVdFU4er8RlbCn7TdwRNc7kLwNYVRNKPNJm2c59lSOevYD
	YNDaQKMChHQDM9PEBRZLgpUr3TnzN8IP9lqkcoLqcpihGhP/HIJJBuQrNHQumQvNXnmVJf6rCC6
	5UNCps0LnHaLLyLM+4VM8Ka3IY9LVLDxhr98S0ZiK9rm3jMCB1KKKWVHD84Pnpb6/aXUvu7wvAK
	nsdT5Bf1aXRiqinkwBLa1y+MuxGcZ5TdRtL4AGJx+o6031+Y6jGqyo=
X-Received: by 2002:a17:907:707:b0:c16:11c0:c5ad with SMTP id a640c23a62f3a-c168bbdb733mr41224266b.31.1784139515461;
        Wed, 15 Jul 2026 11:18:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871962cesm75862666b.25.2026.07.15.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:18:34 +0200
Message-Id: <DJZCO9XPTTSK.2AA711NJSYRFD@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filter
 map_peek
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <alexei.starovoitov@gmail.com>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <kernel-team@meta.com>
X-Mailer: aerc 0.21.0
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-2-ameryhung@gmail.com>
In-Reply-To: <20260715172127.2416388-2-ameryhung@gmail.com>

On Wed Jul 15, 2026 at 7:21 PM CEST, Amery Hung wrote:
> For a bloom filter, the value argument of bpf_map_peek_elem() is always
> an input. Therefore, the verifier should not allow passing uninitialized
> stack memory to it to avoid information leak.
>
> bpf_map_peek_elem() tags its value argument ARG_PTR_TO_MAP_VALUE |
> MEM_UNINIT, telling the verifier the callee fills the buffer. This holds
> for queue/stack maps, but not for a bloom filter, which reads the buffer
> as an input to test set membership and never writes it.
>
> As a result, a program can pass an uninitialized stack buffer to
> bpf_map_peek_elem() on a bloom filter. The verifier accepts it and marks
> the buffer initialized on return, letting the program read back leftover
> kernel stack memory. Bloom maps require CAP_BPF to create, so this is a
> CAP_BPF-gated stack infoleak that bypasses the boundary CAP_BPF is meant
> to enforce (arbitrary kernel reads are gated behind CAP_PERFMON).
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index de816063ae63..c87e5fec5a85 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8422,6 +8422,15 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg,
>  			verifier_bug(env, "invalid map_ptr to access map->value");
>  			return -EFAULT;
>  		}
> +
> +		/*
> +		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The hel=
per reads
> +		 * the value buffer as an input rather than filling it.
> +		 */
> +		if (meta->func_id =3D=3D BPF_FUNC_map_peek_elem &&
> +		    meta->map.ptr->map_type =3D=3D BPF_MAP_TYPE_BLOOM_FILTER)
> +			meta->arg_raw_mem.regno =3D 0;
> +

Sigh. Such unfortunate misuse of semantics.
