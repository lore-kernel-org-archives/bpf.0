Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9156D33B6D1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226056; cv=none; b=GF9gk/A7LvrAOcN/SheMecxGsYOUkvYDb9GN0ajPx0LlbSxujHfJXf2s7VZpSD65zyp6Oa9PJxCdbkPMD4O6AtriO3nN/GzI4dh+yngYvCOdmfcUz26413jHrxK6vsjztZxRI21KqXl7Sxxla4dt7QyOynW4+D5QfDE0eKSl+Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226056; c=relaxed/simple;
	bh=PoGa0+e1EeWSWe+zjxnJzhtyYQguwcmAtnVxI//Bmuk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yv+ve90OGxxEoTt5b8/OgA6/nxnxoum5LyBXhTzA6SQgWA1OovNEX1NYjkWy9TGcAuFa0YWYPRPBsm8OPCY1eLmU1Z+RM2vr4KTIhWwZCXncI83oMUqfnuP/Hzs11CGG3XtCTZQ7OolkrtYO65AXnsOrp2j+qMEidLVOY+VV5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9nyFWIz; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9nyFWIz"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86212a185dcso1223677b3a.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790226055; x=1790830855; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XF8qbJRHNQk5QYze31Q85ClbZ98Ab31yX8q5+VveF04=;
        b=p9nyFWIzy1mrQiY2x7gpZbozVPkSclyraYFMmZabMgk4yYIpHiJ43x4XY5ba9rTywB
         X0stE5NsfdsIDO5T5Th3aamMt6WC5s14bGT2PSgppyMlXVBjJ9iX+Mv86oQ9rYBum19Z
         k24h27kcA6ryTh5Dh0R6CmWsPSwHNwWG/xwicRtSlZPFIVWBR/gns+UhcCNLHb4/9lsP
         +wn+I9ehfMZ4nafccSAaHzFGbyW2R2lBWZMHFrYQXsCf6UoWBxla0jh6rubFnDm9oGVo
         jQko6kBAPf/xRq1q/csjlDDPutH8rNysbCDapyG21fNG1BClMzRDTkpV5G2fnCQntup3
         t9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790226055; x=1790830855;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XF8qbJRHNQk5QYze31Q85ClbZ98Ab31yX8q5+VveF04=;
        b=M/rITFX6qSadsOWCd9uPNZMhIucAuyo/3HT0rqw19CIckFoSaXnxCi5OByCKyZB5op
         W9v3zIkoETBm6aJyIFlCYRHdaCfN4Icc5/bY6qVHrvp120+7f0kNcSJkittk/5h1uw6B
         5w0xfFPPMwEzAeEdwlQhC8BJaQ70E7yns5J8jilkAuezZP6JHojzyWRKIqvVQT3nCd/A
         KfVm7Xnk4kx9CUE/64G5VeZQTPWiYHnVnK0LjnOroM53XKsVFVLmVYr+D/CDK8X+ftac
         azNgBah4RCPqyCVZe1ahbwXdDWh5OuxFhwcSPqHz2vfjUSSFj8W3HZTv9h0yO8rw+CrL
         XTsg==
X-Forwarded-Encrypted: i=1; AKwUvBymc6pGDE+IUdrvy3spgbgICEAKVAGhZEZwzEfS5mYPs/WwUYR1Joe79j0SMg1ggvZIXxU=@vger.kernel.org
X-Gm-Message-State: AFuF++ndzEKvHPC8vmDxY+XhaW61EbT9wnk8or67RI89lPUhcMDrAZkb
	V8yZJRPZ8uPpCUgbQdA6cyf5o5HxjvxiPOVIG0lCS7dywFUHu8F4BIIq
X-Gm-Gg: AYBFou2oA1CMcHeMa7OjeLCHWYB28qlIKK+Yvh+a30Vm768QobxQ2msnqIuXwy/budN
	efHF2OKi1bSia4fppdL7+EqrOC+OBeuhrfw5JsHM7GJnXgNjc6xDmE1cSNiHH6Uog6Zet7ekjPz
	5vCLeX8RXN/9ZwTpb0vlxS/aDUBoydBgqr3ygy1jisudDAVuUyX5eOZKncqOYBTaYa/bE7cpiEz
	A1LBrYRV3a3640+qA5ce2JuxE8RNpTtWE8fZT1x0/mtIYaSqcHCoxx2BfIcKUiAr/5v1urI3pIJ
	BYN/+pKIPj7uuJiEfQaCVppE42XWmLUpKkA4T+x7xA2ojneGqv1IH/fZ+2caO+qFVA9AHjiRKqM
	mw3ccJsFn/P1vQdaZQaH72kp4unWiMeNVGUXnkG59diSCPUGA9Kx+RDKdphaeaCsN1hLyTRR8Mx
	xRGZBt2EL8xdrJ+6jinLL9lZ7IiHliqbHdIcc3YdDW/t1y+8BLyh+okGuGO7WARNFzYGJ9uTUr3
	+Rk9ACBW0NZBBwdWTGtoD+bOsmKbjErzE5gfA==
X-Received: by 2002:a05:6a00:10c9:b0:871:41fa:d1d6 with SMTP id d2e1a72fcca58-87e9cb21bc2mr1077889b3a.14.1790226054493;
        Wed, 23 Sep 2026 22:00:54 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1cfc09fasm2230407b3a.9.2026.09.23.22.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:00:54 -0700 (PDT)
Message-ID: <bad0996bd4b9850e2889c2fc09ca102e0bb24ffd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/17] bpf: Add callx calls to the call graph
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Date: Wed, 23 Sep 2026 22:00:51 -0700
In-Reply-To: <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
	 <20260924031042.1690890-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-24 at 03:10 +0000, Alexei Starovoitov wrote:

...

>  /*
>   * Sort subprogs in topological order so that leaf subprogs come first a=
nd
>   * their callers come later. This is a DFS post-order traversal of the c=
all
>   * graph. Scan only reachable instructions (those in the computed postor=
der) of
>   * the current subprog to discover callees (direct subprogs and sync
>   * callbacks).
> + *
> + * The callees of callx are not known before the main verification pass.
> + * When callx is used the sort is repeated after it with the recorded ca=
llx
> + * edges added to the call graph to reject recursion through indirect ca=
lls.
>   */
>  static int sort_subprogs_topo(struct bpf_verifier_env *env)
>  {

Changes to sort_subprogs_topo() and the second sort call are unnecessary.
After changes to check_max_stack_depth_subprog() in patch #1 of this
series the recursion will be detected there.

...

> @@ -21978,6 +22069,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
>  	ret =3D do_check_main(env);
>  	ret =3D ret ?: do_check_subprogs(env);
> =20
> +	/* reject recursion through the callx edges found by the main pass */
> +	if (ret =3D=3D 0 && env->callx_edges)
> +		ret =3D sort_subprogs_topo(env);
> +
>  	if (ret =3D=3D 0 && bpf_prog_is_offloaded(env->prog->aux))
>  		ret =3D bpf_prog_offload_finalize(env);
