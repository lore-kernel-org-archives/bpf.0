Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DE9224AF2
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555985; cv=none; b=cCAiRdSDYD+PGGHyJm4LYSlMJtGCe/uTvR5W8Je4NIAhg0Onh1rG49mjn9AvfcBYHBa+7zPTJOWDYDejpWTB2ofEXzfUhHAzQNM9WsDozcGAsqYZlU72aGSkss1M42RU9J9pdHrnu/a0VGK2PpB6yDXZUZsVtgDawPEhqef2+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555985; c=relaxed/simple;
	bh=medTpp1+ubZpLW7u98bqsr2y6jOcsxNAzaUI1c08Iuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TYbgYV90NjdahrgoLFU8BGGjJsWPfO3KEU4WHva0EMncHs+jkBwYnBM3wpuPMQvGxPNhQo/RH+7FrAe/e5PG3R4oumFwIIOr6cT6XT9JwY/8iJCtPBXifsJlkRn09WFKgLUHTp8m5R7lDRQtpN6LG89rrEugYLcylv9Bh+hEvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vBnVpV0C; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vBnVpV0C"
Message-ID: <a439f19e-1a47-46ce-8a2c-c53c9f038b8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778555982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FD4CnqGDwmMzl090mnvOF6QJvwtEtyPI+rqx4RMQuS4=;
	b=vBnVpV0C/HQfSTpHPp6vWgYOyaPQWy568oiEyuU9XGlcd1bSfOnbzE2bzH9t9dBfwXlqnV
	lY+a5vwrw/1F6O2/OdHzgWBw7I3kPExvu9Pdbp8Ho2wxKaDGxReMkIPLkxNLyAUBXFjm7X
	PA11qhizZkc9mwYPet0s6OXFbsbyMa0=
Date: Tue, 12 May 2026 11:18:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/2] tools/lib/bpf/libbpf: Prioritize module kfuncs
 over vmlinux kfuncs
To: Song Chen <chensong_2000@126.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, alexei.starovoitov@gmail.com,
 jolsa@kernel.org, haoluo@google.com, kpsingh@kernel.org, song@kernel.org,
 linux-kernel@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me
References: <20260510030136.27876-1-chensong_2000@126.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260510030136.27876-1-chensong_2000@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/10 11:01, Song Chen 写道:
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
> 
> ---
> changelog:
> v1 -->  v2:
> 1, introduce namespace to specify which module the kfunc belongs to, like:
> modulea__foo
> moduleb__foo
> foo
> As a result, kfunc foo can co-exist in modulea, moduleb and vmlinux, ebpf
> code owner can specify which one he wants to call.
> ---
>  tools/lib/bpf/libbpf.c | 60 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 45 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0be7017800fe..9c9e5ff4d754 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8532,35 +8532,65 @@ static int bpf_object__read_kallsyms_file(struct bpf_object *obj)
>  	return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>  
> +static void split_module_from_ksym(const char *ksym_name,
> +			const char **module_name,
> +			size_t *module_name_len,
> +			const char **kfunc_name)
> +{
> +	const char *sep = strstr(ksym_name, "__");
> +
> +	if (!sep) {
> +		*module_name = NULL;
> +		*module_name_len = 0;
> +		*kfunc_name = ksym_name;
> +	} else {
> +		*module_name = ksym_name;
> +		*module_name_len = sep - ksym_name;
> +		*kfunc_name = sep + strlen("__");
> +	}
> +}

I don't think overloading "__" in ksym_name is safe.

1. "__" itself is very common in kernel symbol names. Forcibly
   treating the first "__" as the separator between the module name
   and the kfunc name is seriously ambiguous. We cannot rule out
   existing kfuncs, either defined by a module or by the core kernel,
   whose names already contain "__".

2. ksym_name is not used only locally inside find_ksym_btf_id(). If
   ext->name / ext->essent_name becomes inconsistent with the actual
   kfunc name, it may affect other code paths as well.

It seems that there are two problems to solve here:

1. Allowing kernel modules to override vmlinux kfuncs with the same
   name.

   This should be relatively straightforward to implement by matching
   names in kernel modules first, and then falling back to vmlinux.

2. Handling the case where different kernel modules have kfuncs with
   the same name.

   Could we use a new libbpf API to establish the mapping manually?
   for example:
       bpf_object__set_ksym_btf(obj, "kfunc_name", "module_name")

   Or define a new attribute, for example:
       extern void kfunc_name(void) __ksym __module("module_name");

   We probably need to hear suggestions from other developers on this.

Note: Adding the module name as a prefix to the kfunc name is
technically feasible, but it has significant historical compatibility
issues, which are hard to solve.

>  static int find_ksym_btf_id(struct bpf_object *obj, const char *ksym_name,
> -			    __u16 kind, struct btf **res_btf,
> -			    struct module_btf **res_mod_btf)
> +			__u16 kind, struct btf **res_btf,
> +			struct module_btf **res_mod_btf)
>  {
>  	struct module_btf *mod_btf;
>  	struct btf *btf;
> -	int i, id, err;
> +	int i, id = 0, err;
> +	const char *module_name;
> +	const char *kfunc_name;
> +	size_t module_name_len;
> +
> +	split_module_from_ksym(ksym_name, &module_name, &module_name_len, &kfunc_name);
> +	if (module_name_len == 0)
> +		goto search_vmlinux;
>  
> -	btf = obj->btf_vmlinux;
>  	mod_btf = NULL;
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
> +	for (i = 0; i < obj->btf_module_cnt; i++) {
> +		/* we assume module_btf's BTF FD is always >0 */
> +		mod_btf = &obj->btf_modules[i];
> +		if (strlen(mod_btf->name) == module_name_len &&
> +			!strncmp(mod_btf->name, module_name, module_name_len)) {
>  			btf = mod_btf->btf;
> -			id = btf__find_by_name_kind_own(btf, ksym_name, kind);
> +			id = btf__find_by_name_kind_own(btf, kfunc_name, kind);
>  			if (id != -ENOENT)
> -				break;
> +				goto found;
>  		}
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

-- 
Thanks
Kaitao Cheng

