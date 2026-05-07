Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE82C15AC
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170482; cv=none; b=rqxXiALFNlFkSHoi6wqwRZt9kqkPPvrnU6lBZ/8g+sUSlwTL5DP/9vATSavUyWmARYKlqiGwRjyGQNoj8I9D8Ok94PTwi1Xh4QnviOzauCdYFJaxYhYG0HlB9QtvXjkke2d5PrKFCCar3MXmxndgKPLkiKoHja2GUKelgpqR59c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170482; c=relaxed/simple;
	bh=IRdvWd+Y7ef0GcL/rHx5T/YbaE0HlAnE/hNYVyOy6fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqGw+g8zDIrR9kHVVHVqlOnfm4sMHp9REYx3jW2kAlsZ7dcMHICobv579Wqr+1Z50g97jCf4oLsrhCfxIJYFZwKsGV90TqTcAnm42YkG6/XH4k8YAgOOTU6Xr24Bx56MVyRHEdKcAqkaynbeQ2j8mzGlJCz4xj+6T8/scF7yK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6Afax7l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6Afax7l"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso6676725e9.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 09:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170479; x=1778775279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wB0rM1KhcaIcHlKRpuQ74zqT7tXJlYASuqEk50O+icY=;
        b=k6Afax7l8tSw7qaOc79V2l+VGBK1OkcIF2R3qeuWHIVxE6m59/lM6XhRPQHBUg5So3
         aC5qUPhR9qNBwyj8D08wdeScGOCHhWTBWAtk3hNhzWvZv20cQPz3sKlC28JOyj8nJfSG
         Unzes/isy4izGSglHGZ4xD8cyebu14t1eR26UY1uPFZPV6VIRp3UbbOKWTdaHCnQlD1d
         1R22wiIn+3L/T5P+MiJsVoEJdgDxXPyJtk8rGicJrKpB6xKCnBVVLkmPvFXAwRngMnGj
         8+VR1GsUQ/uz65eBURgHjFI4Wxfuul5QSC8KQ4E2gJY4QLJ/YDMMbsQpiSnZ0EzKTLAd
         fymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170479; x=1778775279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wB0rM1KhcaIcHlKRpuQ74zqT7tXJlYASuqEk50O+icY=;
        b=TZJ/bncCuvaNdmcVockmpTZAS9XcOV7vdNmSIsa7ddH97fWZj0ju9x49dhB7ONs8yN
         9wWxd3Z5Ef56Adj+Hjvj+8A0ZpyGjaPEap6PIExeAqj55kKBNLGtef2RmIx3zR5Gtisu
         9Hc6bygDMuO6RDpVFy9RPSagqvmQYQipdXP0ke4jN4MbekOhiGjqBTtOFNs0B2t2FD/Z
         q5Z/P2Ru50fa/+fmwsJ7ZKj0ORdquwzOlEcsc+e9b4KDg6s8+sMfNDAh2hyUAX63v1cy
         9nUGxJgHFRlS9bMqZ1lSR63ZDnCnr2wBqdrJzL++W0lX2oUxlPXd/NxmUWBZ9Yb0hgr4
         YBbA==
X-Gm-Message-State: AOJu0YwchZ2D30060F/JwC1ZfIEcjIba87QcFmT3zbrqEl5UTCSp+4fP
	M8xdZqNQNVX91UHHby603YM4FQ+W/Wmn4fz6XX0CH9rsOM74Ftko6Sa7
X-Gm-Gg: AeBDievi1Yq0nli122kcDq9xAJgPG7q65tfVzpjjOX5DE+/Jlk5Nreh9D0Xil87RIn8
	KZLNt+a0yNuuBH4dEvU+IWl0KyCwB/tYAxdB6JYG4psmrKikRheh98npTaAjY5qJFm7oTvTv86v
	iksTCNgc+qKPdMbjCHspnYNFx9yb+rOePXztyvCjSuY01iHP5dnnIguH5zk/lxxirEMPS/mIF6E
	18AgQhZ0dAHb07l4rebngUGmDd26JMzk+zgfgLCQRyyfle4ODBp8Kbz+rbAW1VarbQu3j/HbUMS
	0iyVGNzxe9TNJlIUSjHuAVXmUzxh4FXxkSQ8R1WQVlEFqGJNhSAmohNnp1iAGBp+NJmnle3hpYM
	PGdZGhYIzqNodFAhEDQl1VEJKVLHPY79hI6Wx7DDnnapIoVzC70xrHYc5m/Sudnl35H5E5tbrGC
	J6dh+qZ7Z6nNsA+aZxAldfLzT9LSTY3B8LaRTRyAl7TQWcSxKrhEYROGiB2cnVCYlCzlnakE3u/
	oRo38+BqxU=
X-Received: by 2002:a05:600c:3420:b0:48e:51f5:2764 with SMTP id 5b1f17b1804b1-48e51f52779mr88572135e9.27.1778170479265;
        Thu, 07 May 2026 09:14:39 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e530c1e84sm43857065e9.10.2026.05.07.09.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 09:14:38 -0700 (PDT)
Message-ID: <232803d2-cdbb-4fdf-b782-6d6f8f77d89f@gmail.com>
Date: Thu, 7 May 2026 17:14:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs over
 vmlinux kfuncs
To: Song Chen <chensong_2000@126.com>, andrii@kernel.org, eddyz87@gmail.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054707.38965-1-chensong_2000@126.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260430054707.38965-1-chensong_2000@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 6:47 AM, Song Chen wrote:
> Change the kfunc resolution order in find_ksym_btf_id() to search
> module BTFs before vmlinux BTF. This allows kernel modules to override
> vmlinux kfuncs with the same name, enabling a form of live-patching
> for kfuncs.
> 
> Previously, vmlinux kfuncs were always preferred, making it impossible
> for modules to provide enhanced or fixed versions of existing kfuncs.
> With this change, modules can now override kernel kfuncs, while
> programs that don't use module BTFs remain unaffected.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Song Chen <chensong_2000@126.com>
> ---
>  tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..9c308930bddb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8538,29 +8538,31 @@ static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
>  {
>  	struct module_btf *mod_btf;
>  	struct btf *btf;
> -	int i, id, err;
> +	int i, id = 0, err;

nit: I think you can keep id uninitialized, it's set below 
unconditionally.

>  
> -	btf = obj->btf_vmlinux;
>  	mod_btf = NULL;

nit: It looks like you don't need setting mod_btf to NULL here,
 both code paths set it anyway.

> -	id = btf__find_by_name_kind(btf, ksym_name, kind);
>  
> -	if (id == -ENOENT) {
> -		err = load_module_btfs(obj);
> -		if (err)
> -			return err;
> +	err = load_module_btfs(obj);
> +	if (err)
> +		goto search_vmlinux;
>  
> -		for (i = 0; i < obj->btf_module_cnt; i++) {
> -			/* we assume module_btf's BTF FD is always >0 */
> -			mod_btf = &obj->btf_modules[i];
> -			btf = mod_btf->btf;
> -			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
> -			if (id != -ENOENT)
> -				break;
> -		}
> +	for (i = 0; i < obj->btf_module_cnt; i++) {
> +		/* we assume module_btf's BTF FD is always >0 */
> +		mod_btf = &obj->btf_modules[i];
> +		btf = mod_btf->btf;
> +		id = btf__find_by_name_kind_own(btf, ksym_name, kind);
> +		if (id != -ENOENT)
> +			goto found;

very nit: Perhaps setting *res_btf and *res_mod_btf here inline
and return will make code a bit easier to follow and allow
removing found label.

Overall it looks like the refactoring looks correct, module
btf is processed before the vmlinux btf.

Acked-by: Mykyta Yatsenko <yatsenko@meta.com>

>  	}
> -	if (id <= 0)
> +
> +search_vmlinux:
> +	btf = obj->btf_vmlinux;
> +	mod_btf = NULL;
> +	id = btf__find_by_name_kind(btf, ksym_name, kind);
> +	if (id == -ENOENT)
>  		return -ESRCH;
>  
> +found:
>  	*res_btf = btf;
>  	*res_mod_btf = mod_btf;
>  	return id;

