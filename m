Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1B485511
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014212; cv=none; b=PVAW7MpwbRucx5aOHiw+Paz57Wgt8pLXXNGLacVOfgK1tgPVIMP/TTvWD0Q1Hdz4uQiescbYsxsHMzr81rQhWVJFB1B/WwCfaq4NxFlh4TQcjnjnQIptE3mxZ35Ikopc7Ohh4Kk75y4xM9ipNYp0eeTJFkqzmgn3uKp/PV0SnFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014212; c=relaxed/simple;
	bh=byBtH3BxUDIE7qs5aYTVDd+2WmmM+GHRmoQ5ASLwyF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVrcBWp9yb1aK7VjNV/R4kJ/ZEI95k3zX32ptBDz1zBEr6zIZh+KD4M3gY9LLUl5xOrkASKGCf8Hq5Zjk6u4gew6lkerXF3mIOd2CMErfkKmRe/oPfkv3Jw0ZHluaF8W4QSdJhDyiGq0OwNUlZahLDIDUwQnykHRet9w/TuofLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQFN3SoX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQFN3SoX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2911304f8f.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014209; x=1792619009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=91pnyBJUIdrkAEtrIHjYWq/5kjAJWx1bteqLl5iO8Ds=;
        b=TQFN3SoXCKI3l1bCm9TtOAdwEw/o9F3TY6CDVp0vl9jagL9hJ/6NQQ4Ryini0NkZ+s
         EcEXKHrh5kq/SbLf+Oo+f3Fybd9skW9GfAhR8ua1gAFbEsDZdGZ6ghhK2bU9V/tiSUT3
         USbsSMl0IIKeKxk4m5yWe8cVlj0sgfR4pStajYdvU0FZzoRrzWpPwuFFCGwi2yT6KZfg
         V5S644UZkyv3jSvk1Du2jbqz3A6AKuVC2UHfkdzJdL7OjlsZ2AWnOphBWByLAfodX7Pe
         6Tse5jglv+pShx7D4RR2r9Ru7PulPnqx/9riNsUM4HNRfBB3IWO6s7unn/CMvy5RzGDw
         QyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014209; x=1792619009;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=91pnyBJUIdrkAEtrIHjYWq/5kjAJWx1bteqLl5iO8Ds=;
        b=GQ318hmh2JXnFcuLSY+pyyaW73pKdUvQBzYx9mL2bh11ug7viiyA78hvr2jboOnSk7
         AAYJz14CfYBE5CLmV4tgIgQLKT1pSq9/px1dKu8jt6bwrYBJ2lm4f7p/hyPVo+/dzBMY
         1dNwQw5+bKEJKrO9OE6aRKwMFBG1hXiP/nUBopgkmor/l3z++RzTF7JMt1BYGt+mAPcH
         SMZfJQ0sOPFGAIaa/EUEkLapXVWotNOs+f/iCUWCuRUiP/OiZ24K6pTjzxxS2iNPUMqH
         ZVgSHxsAQdB/TlotayUcfu/DtG87ExMJjOnRBS9zvAvoMZmokUMBQTyAynmghZfG6AtH
         /OKA==
X-Gm-Message-State: AFq9FYKq9ZJ4jUfU0oa5dKsW7a/puwGhF7YVBQCj8UXjyaShn6ANeVBu
	ZLh84xW9l3JUuiV3murQRFt0K1ZSpbkDixWH3NbnlV072N1/MjLekWpw
X-Gm-Gg: AYBFou1mW4OfuwuOnftccjUm8wczPV27259NUM84RLisUKsq2Mu/mzc694xHob3oLhB
	oqJ5prdzU7YZkpvOJbviAv/JlBJIcTQFRrRz6fSzFZOAps8DXqHHAFa8HUANZzgAj3NEW9gejtK
	i1NKrnVHsFrX/l9ElmkhCgvJqxrmsbIzdHusqE3BkMT30WDchjGZYs+oMzDV8rtv0xaUQGFJeRN
	9PCg4aRaeuVGYFc+2TiMOQV0Bh6Pj+54F1ZvRIiWOCQtQ9trAnWgT3Ap7zmfrYXAsavvDjgAfMO
	d6ah78bikAv/u8aKt5GilfIwQACFmZkQ3FR/wK2eujktQ+seK2KYYD5mhQNa9gVdFyDyVxgj3CC
	X74rEMusiHIp9NryiqhpN1e4Gc9wz0H6G/Yu96SMQJnzuNy9+Zn/3xok/VCEF01TV9MDKqFwiA7
	ItLsVZAEq/NEzZY75o9+pBZ/G+LHkiqQNBeBG6wH0BFQn0mNvrWwhAKSexWw==
X-Received: by 2002:a05:6000:468a:b0:48d:c162:571a with SMTP id ffacd0b85a97d-48dc1625761mr19135537f8f.4.1792014208703;
        Wed, 14 Oct 2026 14:43:28 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaaebsm14712909f8f.14.2026.10.14.14.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:43:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:43:24 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 01/21] bpf: Initialize ftrace_managed in
 bpf_trampoline_get()
Message-ID: <as_3fBGujYXJbCR2@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-2-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:03PM +0800, Leon Hwang wrote:
> A trampoline managed by ftrace is determined by its target, that said
> ftrace_managed is already known when the trampoline is initialized. so,
> set 'ftrace_managed = tr->ip != 0' in bpf_trampoline_get() instead of
> relying on the first regular or tracing_multi attachment to set it.
> 
> This makes the backend selection independent of attachment order and keeps
> the registration callbacks focused on installing the trampoline.
> 
> No functional change intended.
> 
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  kernel/bpf/trampoline.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 24edb59238f3..17f2a8133f61 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -475,18 +475,11 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
>  			   void *data __maybe_unused)
>  {
>  	void *new_addr = im->image;
> -	void *ip = tr->func.addr;
> -	unsigned long faddr;
>  	int ret;
>  
> -	faddr = ftrace_location((unsigned long)ip);
> -	if (faddr) {
> +	if (tr->func.ftrace_managed) {
>  		if (!tr->fops)
>  			return -ENOTSUPP;
> -		tr->func.ftrace_managed = true;
> -	}
> -
> -	if (tr->func.ftrace_managed) {
>  		ret = direct_ops_add(tr, new_addr);
>  	} else {
>  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
> @@ -1286,6 +1279,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  
>  	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
>  	tr->func.addr = (void *)tgt_info->tgt_addr;
> +	tr->func.ftrace_managed = tr->ip != 0;
>  out:
>  	trampoline_unlock(tr);
>  	return tr;
> @@ -1649,7 +1643,6 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
>  	if (bpf_trampoline_use_jmp(tr->flags))
>  		addr = ftrace_jmp_set(addr);
>  
> -	tr->func.ftrace_managed = true;
>  	ftrace_hash_add(data->reg, data->entry, ip, addr);
>  	tr->cur_image = im;
>  	return 0;
> -- 
> 2.55.0
> 
