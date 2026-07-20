Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA43859FA
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587447; cv=none; b=FyF/jTo++CVAv+CYj0iMh0jNnUYNYEWPhSPnlPpqGpLUEZsg0X9wiSTWcW7FJjN9JW5+oGEcIranBgQu1bQZ/99VBxCzFvOQnOE1YH3jDqM25689A9BKi+UO85TJG5QJxFG/49D8BCQnI9HQCaMdVc3zXuwh4nh9mDkLAs9B7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587447; c=relaxed/simple;
	bh=UAnmD8MRiVXJVh3huQyVUpw11+DCPW3NSPi1HAKy4vg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UWNqREoWUa08RjlOLoXh8Gr77UXREsUphAsbpyF+lorxaCSC9GVgpPvuonrIFM6SsajYCbMGdTUwenwJhNe9q0PA0yKq5KefzLCgQ5YwgH+iJ7EmUZ2gzET1bxhc2dFubNqoVeJKJpTerQ1coq2qq7mElCoabu2aCJiMJbaaMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=pHdkc/G5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="pHdkc/G5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2dcede83so9948182b3a.3
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784587445; x=1785192245; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h6im8+oe/f5SvINFb11d7E71SvjLtjbM1xm28LAgh2E=;
        b=pHdkc/G5TfPaA0S7wTPkRdbsh/3GQkoyGFJbLQnH3MqojWMyaWdgDJbaXAconlRKBl
         t/N4Nd5HcyZQK8F1DQxeHdcrMuOvptWWwzHVkJfAt3RwUsQVDv04uy7c1NSFKx34WPPr
         H1iC/ExsiKHJeBoBBd4ulotp4xfZUAXq+tNyDgotHpBDyfpL+dNhVzxwjDPB3BvYyQbu
         KSqwu7QydJy/c56J7Ya4zR6UgSvETQn4ELRZjUfLlBAKKX/Hysd45ef0B9jtTC+iMszq
         eaN3sT3m/i2SapzY4KwYaIdZeI4mwVT8dMZAyov+e9wcP5yAvQ6OWBf8E5wHt3n3cEDS
         V6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587445; x=1785192245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6im8+oe/f5SvINFb11d7E71SvjLtjbM1xm28LAgh2E=;
        b=SOb+wyMmqF61yNei87SioQGxu9iSGDeAJuirSYgsA7Hoqhl8BkwfflQ9e9i5XEca4M
         6h2WedVDgkGoALk4ZKj1+dOZ7PT5SGROEDCQB6s456fRWMqD0RyNBd8O88AeJgLW/B4a
         +sYE3DX3RgpsSIe03d4gkVeBEqsN7fJ33DrD+8q4h1q8w06t4v238J37bmp/72x9OWFe
         OrSLweTVmJhzHCFN7MaShwDnq1hFiiBvOIEcncU7I/+p2UOUK72sFFHujJk5TVgB49Fb
         a6VZ/jI+yw9oscVPwfZkGfIHyJrm6fYuziA0swggmQMRdu9oSa3Y6GjKCgeyduf9z776
         mk7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkghEhWolaWn5CrLoE85cVjh0TgcIt1RrO3LD6fW+enbzteLKl9ii/QRh2/Mh+Glm+0sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdjyJ4K8w8n/FbACeGNNmQYfj/Cmha/h6v1eKpDS8XltHTclsc
	aY8F4QqZgZmT67Zy2L5HqHOhAxBDpx4zcGA6TvMvAfUGBw4hewWrM9PPUOtB9Only9s=
X-Gm-Gg: AfdE7cmnXoxUA5zTn2yASQwG9QFGoa91E5sKP6Jn4PkPUjZ+QGFVIuidPrghA4Tu/ik
	nEJj0JO6m9J3Tln/Pw6i13/9vYOUJGjrO5Gsq143NdcBCogg1FTaoFvd1qL35kzlUJERSkXcFvS
	Gq5n4Pk3T7yPz6dk3j/iXVo/OssOfEs9SWXKpRy1wur14P5tFUz0l+jzqNUgCNF3HwSszEsKhRt
	kod8YvN71LVGsLhkMK7hWW8MIY065TzS/Hg5OF5TF/QqbHQSSGQRSYUdiSf66XZ1ElI0Qs3q4wc
	JHRs149ejV5rZZp2xKdh6tZSef2GG0YNRh6nL5ciQ2UhauYEyZ1c3ag1ohgRfke3gEhpeA8zfMf
	WikLOP1qslt+5pgLR+Ckz4Q5K8SX/xynZTlUMMBVSInqMbXEKujPoN+yqnlOXuJYRpS1OWcq8B6
	xbQ/B35lDREIaWwVc/NQv3cCSH8eFRHKc=
X-Received: by 2002:a05:6a00:a20e:b0:845:c5d5:3745 with SMTP id d2e1a72fcca58-84c293053c9mr16338911b3a.34.1784587445425;
        Mon, 20 Jul 2026 15:44:05 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6fb02sm6382181b3a.47.2026.07.20.15.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 15:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Jul 2026 18:44:04 -0400
Message-Id: <DK3RGA4XHQVV.308VNH9PEVP1S@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next] bpf: Zero queue and stack outputs on lock
 failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260719125419.1782196-1-memxor@gmail.com>
In-Reply-To: <20260719125419.1782196-1-memxor@gmail.com>

On Sun Jul 19, 2026 at 8:54 AM EDT, Kumar Kartikeya Dwivedi wrote:
> Queue and stack pop/peek helpers accept an uninitialized output buffer
> because the verifier expects the helper to initialize it. The empty-map
> error path clears the buffer, but a failed lock acquisition returns
> -EBUSY without writing it.
>
> Clear the output before returning -EBUSY so BPF programs cannot observe
> uninitialized stack contents after a failed helper call.
>
> Fixes: a34a9f1a19af ("bpf: Avoid deadlock when using queue and stack maps=
 from NMI")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/queue_stack_maps.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.=
c
> index 9a5f94371e50..c1c9dee4dcdd 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -99,8 +99,10 @@ static long __queue_map_get(struct bpf_map *map, void =
*value, bool delete)
>  	int err =3D 0;
>  	void *ptr;
>
> -	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> +	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
> +		memset(value, 0, qs->map.value_size);
>  		return -EBUSY;
> +	}
>
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);
> @@ -130,8 +132,10 @@ static long __stack_map_get(struct bpf_map *map, voi=
d *value, bool delete)
>  	void *ptr;
>  	u32 index;
>
> -	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> +	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
> +		memset(value, 0, qs->map.value_size);
>  		return -EBUSY;
> +	}
>
>  	if (queue_stack_map_is_empty(qs)) {
>  		memset(value, 0, qs->map.value_size);
> --
> 2.53.0

