Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69AF1D89EF
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407112; cv=none; b=EcU/jaM60YTfKzqNl4bvkLAov30+NcpAFf9IOJAr0i6rG/rMPsJcJVtf2ci0awzvBhkYccCRzGBpq6QDVRjkvDQmFx69PCfZEqWoSQuTQ6sXWPUXkoA3F07NTKuoHj3lEdxw4KOfxDfDKTP6hnjoMJIPk2q47zogWS7iaRs8kAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407112; c=relaxed/simple;
	bh=CAn+Y8gVLcoShjg16us9Qh/jqS6q4vyzhJ9Le9JFxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Di0Qxi/WW2pxsqv2cR3NDfHq+tGaxwSnGFkZk21C5/1aekw2n9wIPSPbUoSDX/7i/7LZlMqW7lhzJPaWc44xi150npImpu0cND2sRj2vOZYw9SDpaIbHMUV6uehrqONpW5/Gr5q3TbyQq9NCr31X7pacgKmuVCceFadyxcsxTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ojAlxQjz; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ojAlxQjz"
Message-ID: <b6c33651-05d1-485b-9a4b-f0135723c05f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786407107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kmeOehw+jdQGziucf3glUsWRl8Bgqs04QqU1H/jjcg=;
	b=ojAlxQjzd6dPRjCJrYjpvfew4Y5v19YcVm9qA3fSZlZNqg2ce/Zqt1zxYMN1nnrao9rcHm
	yPNBVUZVMsGVxTVzz2AJjCd0Qs6zTdNz2Qa+Lj78C1buQi/mbMyGg9Nm7JbSkti8Kovawa
	j63PLwjvdKdALNNF3BmaOz3X6oY/784=
Date: Mon, 10 Aug 2026 17:11:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] resolve_btfids: Emit arena attributes
 from kfunc parameter suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
References: <20260809085155.3305519-1-memxor@gmail.com>
 <20260809085155.3305519-2-memxor@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260809085155.3305519-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026-08-09 1:51 a.m., Kumar Kartikeya Dwivedi wrote:
> Kfunc declarations can identify arena arguments through parameter name
> suffixes without repeating KF_ARENA_ARG flags in their BTF ID sets.
> resolve_btfids currently misses those arguments when synthesizing the
> address_space(1) attributes used by generated vmlinux.h files.

Continuing the previous thread [1] (progs/arena_kfunc.c:42):

     ret = bpf_kfunc_arena_arg_test((u64 *)val);

I'm thinking it would be useful to have selftests that generate a
vmlinux.h-equivalent header for a test kernel module with bpftool, and
then use it in BPF progs that depend on that module. This would give
us nice additional coverage for module BTF generation.

With this patch resolve_btfids adds attrs to BTF, but nothing consumes
them, as we don't have such kfuncs in the kernel yet. So the only test
is the super-custom resolve_btfids.test.o

This is not a blocker. Just putting it out there, maybe one of the new
eager contributors will pick this up.

[1] 
https://lore.kernel.org/bpf/4d3b9137362fd9151ecdaf29d863a6cc0b0799d1.camel@gmail.com/

> 
> Teach the arena prototype rewrite to recognize __arena and
> __arena__nullable directly on each parameter. Keep KF_ARENA_ARG1 and
> KF_ARENA_ARG2 handling for explicitly flagged kfuncs, while allowing
> suffixes on any argument without synthesizing kfunc flags.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   tools/bpf/resolve_btfids/main.c | 62 ++++++++++++++++++++++++++++-----
>   1 file changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index d2e4176339da..3c88ea192f7b 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -65,7 +65,8 @@
>    *
>    *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
>    *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
> - *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
> + *     KF_ARENA_ARG1 or KF_ARENA_ARG2, or identified by an arena parameter
> + *     suffix, with the "address_space(1)" type attribute;

nit: Documentation/bpf/kfuncs.rst:512-517 says the same thing and
still lists only the flags. I don't know if it's useful to enumerate
all the ways address_space(1) can be emitted. Maybe just say
"resolve_btfids also handles arena BTF tags" or smth.

>    *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
>    *
>    * These kfunc annotations were historically produced by pahole.
> @@ -182,6 +183,8 @@ struct object {
>   #define KF_IMPLICIT_ARGS (1 << 16)
>   #define KF_IMPL_SUFFIX "_impl"
>   #define TYPE_ATTR_ARENA "address_space(1)"
> +#define PARAM_SUFFIX_ARENA "__arena"
> +#define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
>   
>   struct kfunc {
>   	struct rb_node rb_node;
> @@ -1067,6 +1070,22 @@ static int collect_decl_tags(struct btf2btf_context *ctx)
>   	return 0;
>   }
>   
> +static bool param_name_has_suffix(const char *name, const char *suffix)
> +{
> +	size_t name_len = strlen(name);
> +	size_t suffix_len = strlen(suffix);
> +
> +	return name_len >= suffix_len && !strcmp(name + name_len - suffix_len, suffix);
> +}
> +
> +static bool is_arena_param(const struct btf *btf, const struct btf_param *param)
> +{
> +	const char *name = btf__name_by_offset(btf, param->name_off);
> +
> +	return param_name_has_suffix(name, PARAM_SUFFIX_ARENA) ||
> +	       param_name_has_suffix(name, PARAM_SUFFIX_ARENA_NULLABLE);
> +}
> +
>   static int collect_kfuncs(struct object *obj, struct btf2btf_context *ctx)
>   {
>   	Elf_Data *idlist = obj->efile.idlist;
> @@ -1299,8 +1318,12 @@ static int process_kfunc_with_implicit_args(struct btf2btf_context *ctx, struct
>   	return 0;
>   }
>   
> -static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
> +static bool is_arena_arg(const struct btf *btf, const struct kfunc *kfunc,
> +			 const struct btf_param *param, u32 idx)
>   {
> +	if (is_arena_param(btf, param))
> +		return true;
> +
>   	switch (idx) {
>   	case 0:
>   		return kfunc->flags & KF_ARENA_ARG1;
> @@ -1311,6 +1334,30 @@ static bool is_arena_arg(struct kfunc *kfunc, u32 idx)
>   	}
>   }
>   
> +static bool kfunc_has_arena_arg(const struct btf *btf, const struct kfunc *kfunc)
> +{
> +	const struct btf_type *func, *proto;
> +	const struct btf_param *params;
> +	u32 nr_params;
> +
> +	func = btf__type_by_id(btf, kfunc->btf_id);
> +	if (!func || !btf_is_func(func))
> +		return false;
> +
> +	proto = btf__type_by_id(btf, func->type);
> +	if (!proto || !btf_is_func_proto(proto))
> +		return false;

I don't like this helper: we walk the params only to decide whether to
walk them again.

What if we change add_arena_tagged_proto() to return original proto if
nothing was tagged? I think one of my early revisions worked like
that. Then the helper could be dropped.

And returning false on bad BTF seems to silently skip the tagging,
and so far we've been failing hard on errors like that.

> +
> +	params = btf_params(proto);
> +	nr_params = btf_vlen(proto);
> +	for (u32 i = 0; i < nr_params; i++) {
> +		if (is_arena_arg(btf, kfunc, &params[i], i))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static s32 arena_tag_ptr(struct btf *btf, u32 ptr_id, struct kfunc *kfunc)
>   {
>   	const struct btf_type *ptr = btf__type_by_id(btf, ptr_id);
> @@ -1383,11 +1430,10 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
>   	}
>   
>   	for (i = 0; i < nr_params; i++) {
> -		if (!is_arena_arg(kfunc, i))
> -			continue;
> -
>   		t = btf__type_by_id(btf, new_proto_id);
>   		params = btf_params(t);
> +		if (!is_arena_arg(btf, kfunc, &params[i], i))
> +			continue;
>   
>   		id = arena_tag_ptr(btf, params[i].type, kfunc);
>   		if (id < 0)
> @@ -1403,7 +1449,7 @@ static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
>   	return new_proto_id;
>   }
>   
> -static int process_kfunc_with_arena_flags(struct btf2btf_context *ctx,
> +static int process_kfunc_with_arena_attrs(struct btf2btf_context *ctx,
>   					  struct kfunc *kfunc)
>   {
>   	struct btf_type *t;
> @@ -1463,8 +1509,8 @@ static int btf2btf(struct object *obj)
>   				goto out;
>   		}
>   
> -		if (kfunc->flags & (KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)) {
> -			err = process_kfunc_with_arena_flags(&ctx, kfunc);
> +		if ((kfunc->flags & KF_ARENA_RET) || kfunc_has_arena_arg(ctx.btf, kfunc)) {

nit: KF_ARENA_RET case short-circuits the arena_arg check here.
Seems benign, but made me pause.

> +			err = process_kfunc_with_arena_attrs(&ctx, kfunc);
>   			if (err)
>   				goto out;
>   		}

