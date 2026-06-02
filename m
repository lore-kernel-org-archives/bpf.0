Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8903F4DDA
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420398; cv=none; b=li+1LCp76Y5C+WxMcWT6aT0zn1pvpW4WES16UtrRNrX5x1o4uk85aIM047EqmSsyuHc68CQM8awTyhalR/Ck6i0r+HEOULGQq04G/G3VFgxFwhMrJDwflOTMAqRZ5IfyvkPkE69HOIf6RjXlC5Axl1/60Vl50Ra39wHvfUfa3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420398; c=relaxed/simple;
	bh=RPvkBtHirW7YoC7cdCr+rxXe0J+D52+kZlarUlyehaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DrMkC46IaWpVXA5kxGbcn2vtjiGhj9CBKUV+9HeWihVvyXngSkwdH4+kJX7AWJiT4/MSzj80SQQwuS1e40i8ZbzSpddU0tijV6DY8t40+tjEUuZHjds+02D0oPJrSqPWTmCSricZbM93bZJb8blSuhZAl+a7FilNg8YQA5Lmxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UnxVstqe; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UnxVstqe"
Message-ID: <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780420394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3RZLBXo0qamZRboc3G6gCp4D+rmYBliqxy5raxOSnRU=;
	b=UnxVstqexxEp/DyVPxd40OJYbpHFdm+RcTXuo4CwKBUuI52cenfVozpiWeJZLwUXE7bbHh
	TywMDhpzb9TVe0nz5doG/j/m2G/stf+NxsqrAPQfDKlJSba+j3xNQFKG+VHR40SQSu42JP
	0IR1RPGBvbk7Gc5kxKMrD7hNXl7hWls=
Date: Tue, 2 Jun 2026 10:13:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] btf: reject to register duplicated kfunc
Content-Language: en-GB
To: Song Chen <chensong_2000@126.com>, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602110710.19642-1-chensong_2000@126.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260602110710.19642-1-chensong_2000@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/2/26 4:07 AM, Song Chen wrote:
> I had an ebpf program which calls a kfunc defined and
> implemented in one of my kernel modules, it was working
> fine in 6.16, but was rejected to run by libbpf in 6.19,
> the error message was:
>
> libbpf: extern (func ksym) 'bpf_strstr': func_proto [5]
> incompatible with vmlinux [94389]
>
> The reason is there is a new added kfunc in kernel 6.19
> which happens to be the same name with my kfunc. However the
> error message is not obvious enough to address problem
> immediately.
>
> Therefore, this patches searches duplicated kfunc in
> both btf_vmlinux and btf_modules list before a kernel module
> attempts to register kfuncs through register_btf_kfunc_id_set,
> it prints clear error message and returns error code if same name
> kfunc has already implemented and registered, then developer
> knows at the first place.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Suggested-by: Kaitao Cheng <kaitao.cheng@linux.dev>
> Reviewed-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Song Chen <chensong_2000@126.com>

The subject can be [PATCH bpf v4] bpf: Reject to register duplicated kfunc

>
> ---
> changelog:
> v1 --- v2:
> libbpf has already specified which module this kfunc belongs to as
> ebpf code onwer's expectation, then verifier uses
> find_kallsyms_symbol_value to search kfunc's addr.
>
> v2 --- v3:
> After v2, I tried a new idea of introducing a namespace in libbpf
> to specify kfunc owner in an ebpf program suggested by Kaitao Cheng,
> please see [1]. Alex suggested to go back to report an error during
> kmod load on conflicting kfunc name for now. What's more, v2 only
> searched bpf_vmlinux, v3 also traverses btf_modules list.
>
> v3 --- v4
> Fixed some coding style problems suggested from Kaitao Cheng.
> ---
>   kernel/bpf/btf.c | 38 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..fe1612677a4a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -8618,6 +8618,41 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
>   	return 0;
>   }
>   
> +static int btf_check_kfunc_name(struct btf *btf, const char *func_name, u32 kind)
> +{
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	struct btf_module *btf_mod, *tmp;
> +#endif
> +	s32 id;

	s32 err = 0, id;

> +
> +	if (!btf_is_module(btf))
> +		return 0;
> +
> +	id = btf_find_by_name_kind(bpf_get_btf_vmlinux(), func_name, kind);
> +	if (id >= 0) {
> +		pr_err("kfunc %s (id: %d) is already present in vmlinux.\n",
> +				func_name, id);
> +		return -EINVAL;
> +	}
> +
> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +	mutex_lock(&btf_module_mutex);
> +	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
> +		if (btf_mod->btf == btf)
> +			continue;
> +		id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
> +		if (id >= 0) {
> +			pr_err("kfunc %s (id: %d) is already present in module %s.\n",
> +					func_name, id, btf_mod->module->name);
> +			mutex_unlock(&btf_module_mutex);
> +			return -EINVAL;

Let us avoid the above mutex_unlock and 'return -EINVAL', just do
	err = -EINVAL;
	break;

> +		}
> +	}
> +	mutex_unlock(&btf_module_mutex);
> +#endif
> +	return 0;

	return err;

> +}
> +
>   static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>   {
>   	const struct btf_type *func;
> @@ -8631,7 +8666,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
>   
>   	/* sanity check kfunc name */
>   	func_name = btf_name_by_offset(btf, func->name_off);
> -	if (!func_name || !func_name[0])
> +	if (!func_name || !func_name[0] ||
> +		btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))

format issue:
	if (!func_name || !func_name[0] ||
	    btf_check_kfunc_name(btf, func_name, BTF_INFO_KIND(func->info)))
	...	

>   		return -EINVAL;
>   
>   	func = btf_type_by_id(btf, func->type);

