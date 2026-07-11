Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB11EEE6
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783792654; cv=none; b=C33TfAGWECbbsmvJV5cK5d/dK99CLd2CVOqp8zc4hzT6tQWrVTZxUzlbWIXGChtTXX1ps4v02Vp9pBEB3Cy7DF8httNDg2T0TOUpzBpxsr6EKCkKT4yj3OZXR8uKNbn6PjQJtVUq4Ksv9lrcTu1LGOsEd7yh5Vj05x3MyBTWkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783792654; c=relaxed/simple;
	bh=2QqZBw4W5WGEniB9iVJrGwbrUWUFOmj428ZVA2UIPF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXrkhaf3AVHL0wvjh/ufFSW79ijI5/QSQZ9hm4B2CKGvQtLM0yutWVdJV+eDoT/0BrQsqQw1Pi/UT2cGr8CP8vcWWmTIHpwUa8A219DjeewInFe3qUruJ2rFWdz8/AN4FiSePlskUVUVehbDD37XmiWRgtBhcU3WS+jr7thBprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vfNWazvI; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vfNWazvI"
Message-ID: <3b272469-9563-4843-8126-5c6698a84d98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783792640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFsh+E4NuF4ACkGGFEIl2ZU9ws6bLZPlR8boy12f8TY=;
	b=vfNWazvI0N+vwIPuw2LbamJTPa9mh3skm55tltDcNSR/Uep8Pg0Ec+R/mNV4wuu4MEgHo4
	NBk/N+1BgWDfpTzrtpHRjWLAs8zFeT5zG0Lu436JCu6bxdfd+ER/248r50YapByIlzU3qP
	OcpODXMrXChM8uLrSXBvNX1f6XigXkw=
Date: Sat, 11 Jul 2026 10:57:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix tracing of kfuncs with implicit args
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260710192940.3020280-1-ihor.solodrai@linux.dev>
 <20260710192940.3020280-2-ihor.solodrai@linux.dev>
 <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <a183b4d6f3e814f9ffb79c8e0efca8b5f162e127.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2026-07-11 3:43 a.m., Eduard Zingerman wrote:
> On Fri, 2026-07-10 at 12:29 -0700, Ihor Solodrai wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64572f85edc8..20aeca6b4f95 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
>>   	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>   }
>>   
>> +/*
>> + * Return the union of a kfunc's flags across all hooks.
>> + * Unlike btf_kfunc_flags(), not restricted to a calling
>> + * program's hook. Used when attaching to a kfunc for tracing.
>> + */
>> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
>> +{
>> +	enum btf_kfunc_hook hook;
>> +	u32 *hook_flags;
>> +	u32 flags = 0;
>> +
>> +	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
>> +		hook_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>> +		if (hook_flags)
>> +			flags |= *hook_flags;
>> +	}
>> +
>> +	return flags;
>> +}
> 
> This. Is. So. Ugly. You guys should reflect a bit more on the llm output.

Hi Eduard, thank you for the review.

I think it's healthy to have a clanker hater bias on the list,
given the circumstances.  However not every slop is a decision made
by a LLM, it's often humans.

> 
> The fact that we currently have a technical possibility to have the same
> kfunc in different sets with different flags seem to be accidental.
> Is there ever a valid scenario for this?

I don't know about "valid", but in fact there are kfuncs that
currently have inconsistent flags.

For example KF_SLEEPABLE can be on or off depending on the kfunc set:
https://lore.kernel.org/bpf/ah8-6CNIHPCJxAOM@krava/


> Grepping kernel code all I can find are these kfuncs from
> drivers/hid/bpf/hid_bpf_dispatch.c:
> 
>    BTF_KFUNCS_START(hid_bpf_kfunc_ids)
>    ...
>    BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
>    BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE | KF_SLEEPABLE)
>    BTF_ID_FLAGS(func, hid_bpf_hw_request, KF_SLEEPABLE)
>    BTF_ID_FLAGS(func, hid_bpf_hw_output_report, KF_SLEEPABLE)
>    BTF_ID_FLAGS(func, hid_bpf_input_report, KF_SLEEPABLE)
>    BTF_ID_FLAGS(func, hid_bpf_try_input_report)
>    BTF_KFUNCS_END(hid_bpf_kfunc_ids)
>    ...
>    /* for syscall HID-BPF */
>    BTF_KFUNCS_START(hid_bpf_syscall_kfunc_ids)
>    BTF_ID_FLAGS(func, hid_bpf_allocate_context, KF_ACQUIRE | KF_RET_NULL)
>    BTF_ID_FLAGS(func, hid_bpf_release_context, KF_RELEASE)
>    BTF_ID_FLAGS(func, hid_bpf_hw_request)
>    BTF_ID_FLAGS(func, hid_bpf_hw_output_report)
>    BTF_ID_FLAGS(func, hid_bpf_input_report)
>    BTF_KFUNCS_END(hid_bpf_syscall_kfunc_ids)
>    ...
>    register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> 
> But this appears to be a misuse:
> (a) syscall programs are always sleepable
> (b) e.g. hid_bpf_allocate_context() calls kzalloc_obj() which can sleep,
>      as far as I understand. Meaning that hid_bpf_allocate_context()
>      should always be marked with KF_SLEEPABLE.
> 
> Am I confused?
> 
> If I am not confused, I think that resolve_btfids() has to verify that
> kfunc flags are always the same across multiple sets.

Some form of build-time enforcement will be implemented as part of
resolve_btfids() BTF handling, see the v1 here:
https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/

*If* you're right about no valid use-case for incosistent kfunc flags,
then long-term I agree: build-time enforcement of consistency, and
then the acummulation can be replaced by a search (find first) here.

But this has to be confirmed somehow (by thoroughly inspecting all
current inconsistencies and flags?..)

However if there is even one valid use-case, then we are in trouble,
because then depending on the flag semantics it may or may not make
sense for it to be consistent accross kfunc sets. And it's not even
clear what a good solution to that might look like: separate groups of
flags? consistency enforcement for some flags, but not others (this is
literally what Andrii suggested in resolve_btfids thread)?

Accumulating flags across the sets is an acceptable workaround for
this fix IMO. We can be more specific and *only* check for the
KF_IMPLICIT_ARGS for the purposes of this fix though, but we still
have to walk all hooks and OR.

I don't think it's reasonable to wait for the comprehensive kfunc flags
analysis and resolve_btfids series landing before fixing the garbage
dereference bug.

> 
>> +
>>   u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
>>   				const struct bpf_prog *prog)
>>   {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6515d4d3c003..2f56ab8d6b58 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2584,24 +2584,24 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
>>   
>>   #define KF_IMPL_SUFFIX "_impl"
>>   
>> -static const struct btf_type *find_kfunc_impl_proto(struct bpf_verifier_env *env,
>> -						    struct btf *btf,
>> -						    const char *func_name)
>> +static const struct btf_type *
>> +find_kfunc_impl_proto(struct bpf_verifier_log *log, struct btf *btf, const char *func_name)
> 
> Nit: no need to reformat the declaration.
> 
>>   {
>> -	char *buf = env->tmp_str_buf;
>>   	const struct btf_type *func;
>> +	char buf[KSYM_NAME_LEN];
> 
> We attempt to avoid large allocations on stack, that's why tmp_str_buf
> was used here in a first place. This is the second time I see llm doing this,
> maybe adjust your agents.md or something. If tmp_str_buf is not big enough,
> that can be adjusted. But I don't think it's necessary in this particular case.

This is not just a llm artifact, the new callers in the attach path
don't have env available, only the log. Do you suggest refactoring
bpf_check_attach_target() and path through the env now just to avoid
allocating this buffer?

I aimed to keep the fix patch minimal, but I see this is going to be a
challenge.

> 
>>   	s32 impl_id;
>>   	int len;
>>   
>> -	len = snprintf(buf, TMP_STR_BUF_LEN, "%s%s", func_name, KF_IMPL_SUFFIX);
>> -	if (len < 0 || len >= TMP_STR_BUF_LEN) {
>> -		verbose(env, "function name %s%s is too long\n", func_name, KF_IMPL_SUFFIX);
>> +	len = snprintf(buf, sizeof(buf), "%s%s", func_name, KF_IMPL_SUFFIX);
>> +	if (len < 0 || len >= sizeof(buf)) {
>> +		bpf_log(log, "function name %s%s is too long\n",
>> +			func_name, KF_IMPL_SUFFIX);
>>   		return NULL;
>>   	}
>>   
>>   	impl_id = btf_find_by_name_kind(btf, buf, BTF_KIND_FUNC);
>>   	if (impl_id <= 0) {
>> -		verbose(env, "cannot find function %s in BTF\n", buf);
>> +		bpf_log(log, "cannot find function %s in BTF\n", buf);
>>   		return NULL;
>>   	}
>>   
>> @@ -2653,7 +2653,7 @@ static int fetch_kfunc_meta(struct bpf_verifier_env *env,
>>   	 * can be found through the counterpart _impl kfunc.
>>   	 */
>>   	if (kfunc_flags && (*kfunc_flags & KF_IMPLICIT_ARGS))
>> -		func_proto = find_kfunc_impl_proto(env, btf, func_name);
>> +		func_proto = find_kfunc_impl_proto(&env->log, btf, func_name);
>>   	else
>>   		func_proto = btf_type_by_id(btf, func->type);
>>   
>> @@ -18873,6 +18873,44 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
>>   	return -EINVAL;
>>   }
>>   
>> +/*
>> + * Resolve the prototype describing a trace target's real ABI. A
>> + * KF_IMPLICIT_ARGS kfunc has its injected args stripped from the public
>> + * prototype, so use the _impl prototype; other targets use their own.
>> + */
>> +static const struct btf_type *
>> +btf_attach_func_proto(struct bpf_verifier_log *log, struct btf *btf, u32 func_id)
>> +{
>> +	const struct btf_type *func;
>> +	struct module *mod = NULL;
>> +	const char *name;
>> +	u32 kfunc_flags;
>> +
>> +	func = btf_type_by_id(btf, func_id);
>> +	if (!func || !btf_type_is_func(func))
>> +		return NULL;
>> +
>> +	/*
>> +	 * btf_kfunc_accumulated_flags() reads kfunc_set_tab, which for a
>> +	 * module is stable only once it is live; hold a module ref across
>> +	 * the read to exclude a concurrent module load.
>> +	 */
>> +	if (btf_is_module(btf)) {
> 
> So, this function is supplied with a module BTF,
> and the argument is that we can have an alive BTF reference
> but not to hold a live module reference?

We have a convention (I don't know the history behind it) to always
btf_try_get_module() before reading associated kfunc sets, see a
comment in btf.c:

   /* Caution:
    * Reference to the module (obtained using btf_try_get_module) 
corresponding to
    * the struct btf *MUST* be held when calling this function from verifier
    * context. This is usually true as we stash references in prog's 
kfunc_btf_tab;
    * keeping the reference for the duration of the call provides the 
necessary
    * protection for looking up a well-formed btf->kfunc_set_tab.
    */

I don't think it's worth the risk violating this convention within the
fix, even though you may be right about it being unnecessary in principle.

> 
> References to kfunc's modules are stored in the
> bpf_prog_aux->kfunc_btf_tab, and the following code from core.c
> suggests that module references would be present for as long
> as the program using BTF from the module is present:
> 
>    static void bpf_prog_free_deferred(struct work_struct *work)
>    {
> 	...
> 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
> 	...
>    }
> 
> ?
> 
>> +		mod = btf_try_get_module(btf);
>> +		if (!mod)
>> +			return NULL;
>> +	}
>> +	kfunc_flags = btf_kfunc_accumulated_flags(btf, func_id);
>> +	module_put(mod);
>> +
>> +	if (kfunc_flags & KF_IMPLICIT_ARGS) {
>> +		name = btf_name_by_offset(btf, func->name_off);
>> +		return find_kfunc_impl_proto(log, btf, name);
>> +	}
>> +
>> +	return btf_type_by_id(btf, func->type);
>> +}
>> +
>>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			    const struct bpf_prog *prog,
>>   			    const struct bpf_prog *tgt_prog,
>> @@ -19121,8 +19159,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   		if (prog_extension &&
>>   		    btf_check_type_match(log, prog, btf, t))
>>   			return -EINVAL;
>> -		t = btf_type_by_id(btf, t->type);
>> -		if (!btf_type_is_func_proto(t))
>> +		t = btf_attach_func_proto(log, btf, btf_id);
>> +		if (!t || !btf_type_is_func_proto(t))
> 
> This part seems fine.
> 
>>   			return -EINVAL;
>>   
>>   		if ((prog->aux->saved_dst_prog_type || prog->aux->saved_dst_attach_type) &&
>> @@ -19407,8 +19445,8 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>>   		return -EINVAL;
>>   	if (!btf_type_is_func(t))
>>   		return -EINVAL;
>> -	t = btf_type_by_id(btf, t->type);
>> -	if (!btf_type_is_func_proto(t))
>> +	t = btf_attach_func_proto(NULL, btf, btf_id);
>> +	if (!t || !btf_type_is_func_proto(t))
>>   		return -EINVAL;
>>   	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
>>   	if (err < 0)
>> -- 
>> 2.55.0

