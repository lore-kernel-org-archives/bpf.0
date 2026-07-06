Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CA3955CD
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351723; cv=none; b=F1pSwyZAgMIQuYUPs7jvLNizvGATMMPiLwzGSa+VpBXwobw9lPer5Py2Bo22kRs2wnkJqsxVOG81F/LAsS76R1yAbIKgO2+lSdStVMn2WU7aKWU5yKuB8MQTQPYezjPOft9NZAnLYJh7SFz13NlV8qprVmf+uDzkmDytefRNXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351723; c=relaxed/simple;
	bh=15t0/qvIPb1m6EhxMeWqoRsVHolGR6WdnX9O2YeniAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPbUxs1F2uJkcOetaGeUgfaIKO/SyTUYs6rxXkLQT1s/aRaAWfJKmvyQ3XJbJ22c3qXLZZeZ6PoMxGkyjNHUnoM50PW3oN7tl9UCAND4MMU4yqxas+YnMUtno5lT9AotmrDYqeFVul1eyo4rYUqsEzghydnPtNx00HsrWqq55rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQ7DIJh1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ7DIJh1"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493b966dd74so10726105e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783351721; x=1783956521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfJaHoVGgMxmKw1/mr0PURm5kBPKEP+5FPobOp8bfyg=;
        b=DQ7DIJh1SQQhXa4vc9BDjG9OQ0jt1ib71DyWW6DVs8eSHI1xCHY5/iS4SducTMaEnl
         Ro2CM5AgP7+voT2A2HlNaEkT07YVL7Ry9NnM1oy++cy/7b8kZBjcOuHzfcgGgMq0QdfH
         y+GL2zXjq7Xkbr8amo8kWYcC26jN7SmH0reXkHqjlgP42PtRuBxd5WqWb5PZ+OdYO9wN
         k3URRZN+FG2tXutYg5jsgVmh+Wg1uTQIooYDb1/N6TIt2jeaAXmuV5UuirOkB153LYT/
         8DTYKeD56huaHYUUP4if/trQncweLf02E0AWe3Kp5DPPAgWJtae0Gw+XWQJwSfns+3qZ
         Yobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351721; x=1783956521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfJaHoVGgMxmKw1/mr0PURm5kBPKEP+5FPobOp8bfyg=;
        b=QA487fe6fYEyr0P7YbejwMKyuzucinKNI3GDtnvtnND8ib/fFNAFcDntrKIS13t0R0
         wlbhBR6/YRJgl/sLqU6a2is0I2Yx4AD7ynSLmiI8W2Gg7NIH5tOzJMU5+kvc3lzTYj6b
         mBANSBeUxeQX6cHYlZX+01z0uA0WLL2Y9Q7T/A4vUjeEHUHpHXiqQaJzVCWDMv4qd5cS
         c0BNb0BGyPgGZqzHRiv2dKqy9P8bLCkrjjETegAZMxCN/EORsdKZqQnYiP3FoLEwFkLh
         nkYi9itHyq9GEn088oB5neZWmwxJuNaRDJV45OHTZ4/3RYL3hdUwzjE7QSYqkTXMHl+T
         0hOQ==
X-Gm-Message-State: AOJu0Yx0sVyvEkC16O+NiUKW6cJGfCBoDieE/20Zs5Kp2gRAj544IuzJ
	aW5znjiDvi2RV1NVCZO9Cr7e+VjOrGwM3PrzypQ5pre50ht93QZGj/QR
X-Gm-Gg: AfdE7cnTrUL1dVmCOdJso5TWXB2xRIORv4ciBqpp3eYc1LWn4wDMSbhzbeQDIxdV4xw
	I4aQROniz+gFUHNd2OhcRLvjyfMf0LnBXyLR0Fx/aWBYKIufJOGS+VCTfBeWvzUNDsL55sBEFbn
	2VTr5QcrY5VL2dRslKzdYM+YOJzgYYecUiuzt7VMpytw3UECGNEOLeCkkjzqN+A+yKYHRVzI7K+
	NgJHZq3sJLmWub0tSS+tib5hX9ffmfa8xL1DajWyZK7Q+E2j3CvRhSsbjarjZT9EEIuCqkc/Zw2
	Roe5EPY8RjkwbFaULGG9dY+E7un9nwlPid1yjMYGZel7QuxHu1MYaX4gvUptUK+TyVnODdIwaqf
	DDE2khIpAEpubedHPFIMn9iMKinZQOAjvY0asHXuWRzMGmSbemnA4DUXHHwtEM+FxU+Zspln/t1
	C5EdnBSrjeuSAqT4JiUJAnrXWoQ+/WbkO9hERXXXsiU1Ei
X-Received: by 2002:a05:600c:4187:b0:493:aa24:792b with SMTP id 5b1f17b1804b1-493df26ed69mr5504085e9.22.1783351720354;
        Mon, 06 Jul 2026 08:28:40 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039bcdasm26402301f8f.21.2026.07.06.08.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:28:39 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:28:37 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akvJpSXmBOn88GtV@gmail.com>
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
 <268078861c26e02c25e9e882bccc607bedf580ae3c1d7e06562c48b85450f1a7@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268078861c26e02c25e9e882bccc607bedf580ae3c1d7e06562c48b85450f1a7@mail.kernel.org>

On Mon, Jul 06, 2026 at 10:30:04AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > new file mode 100644
> > index 000000000000..8bde734bc917
> > --- /dev/null
> > +++ b/net/core/bpf_ksock.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,516 @@
> 
> [ ... ]
> 
> > +static int __init bpf_ksock_kfunc_init(void)
> > +{
> > +	int ret;
> > +	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] = {
> > +		{
> > +			.btf_id = bpf_ksock_dtor_ids[0],
> > +			.kfunc_btf_id = bpf_ksock_dtor_ids[1],
> > +		},
> > +	};
> > +
> > +	ret = register_pernet_subsys(&bpf_ksock_net_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_init_kfunc_set);
> > +	if (ret) {
> > +		unregister_pernet_subsys(&bpf_ksock_net_ops);
> > +		return ret;
> > +	}
> > +
> > +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> > +					&ksock_kfunc_set);
> > +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> > +					       &ksock_kfunc_set);
> > +	return ret = ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> > +						 ARRAY_SIZE(bpf_ksock_dtors),
> > +						 THIS_MODULE);
>                                 ^^^^
> 
> This isn't a bug, but in the final return statement the assignment
> to ret looks like a dead store since the value is returned right
> away. Could this just be:
> 
>     return ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
>                                               ARRAY_SIZE(bpf_ksock_dtors),
>                                               THIS_MODULE);

Indeed, this is relic of changes trying to get the cleanup part right,
see the other message from sashiko on the same patch.

> 
> > +}
> > +
> > +late_initcall(bpf_ksock_kfunc_init);
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28783010022

