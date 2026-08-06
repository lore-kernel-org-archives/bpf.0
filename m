Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53313EF0BD
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050201; cv=none; b=Hu7PoJnT3sFqXcRyNCHDmnH1rudeEVQDUz8p6j2mfv4xQGcI8GkHNGg0HUJtMbpaD8gOXPPsi8r+Wl3Nk3Mf+gGZ+GfafSv4uGLb2HdAfYR+seT2otVS969R6Erjeyg5rVdJIpKl9mAN2CZM6AlJ1bwHjy9uUGemOZ8o67qpmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050201; c=relaxed/simple;
	bh=V6RuxDQ4hPtuhaczCz/YHM6iQMjKZumx9O9CNZQnxaM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/FmpMpCj83Gi9mmQU119nqXXmNdKyCqqgM2EH7ZOsMpycS++iccF0TCZ8vcfnEuGkdWcD+UpDC0RDZ/Ixh7+NcHGr6IBIXbFJc0yQU/rDAwjymX72T0TPTY0OTU3/ZSjevgbhEkQMnT1sAB+gxy/vWNbqujdNIvGFQWWsFHJDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iunSdQ/s; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iunSdQ/s"
Message-ID: <d3b34173-d3fa-489b-958d-f56bd541b838@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWgdCFuIhbMEuIaKsZNQgD2iggWo+zJIGbEV9Dh/rxI=;
	b=iunSdQ/sjKcbr+0i86me56MPtjo0ob7K4hfVCqHkoX8rnpM2xePbhIjj6mmSzAZC1QPFjI
	NtNZcLOMadAPhnNftrkZOoD3QW/ZcxVi98dAa2RYUG0l0QKyNs+EzWVuuD3Z8qaOR/VGGe
	9/7pJi2AwupsWcqmv885qcw/Bid4sHU=
Date: Thu, 6 Aug 2026 14:02:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/6] resolve_btfids: Process KF_ARENA_* flags
 in resolve_btfids
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-3-ihor.solodrai@linux.dev>
 <b18f90989ea2632b36c41eef646541881c9bb767.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <b18f90989ea2632b36c41eef646541881c9bb767.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 12:12 PM, Eduard Zingerman wrote:
> On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>> +static s32 add_arena_tagged_proto(struct btf *btf, struct kfunc *kfunc)
>> +{
>> +	const struct btf_type *func = btf__type_by_id(btf, kfunc->btf_id);
>> +	u32 proto_id = func->type;
>> +	const struct btf_type *proto = btf__type_by_id(btf, proto_id);
>> +	const struct btf_param *params = btf_params(proto);
>> +	u32 nr_params = btf_vlen(proto);
>> +	s32 arg0_type_id = nr_params > 0 ? (s32)params[0].type : -1;
>> +	s32 arg1_type_id = nr_params > 1 ? (s32)params[1].type : -1;
>> +	s32 new_proto_id, id, param_type_id;
>> +	s32 ret_type_id = proto->type;
>> +	const char *name;
>> +	int err;
>> +
>> +	if (kfunc->flags & KF_ARENA_RET) {
>> +		id = arena_tag_ptr(btf, ret_type_id);
>> +		if (id < 0) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_RET but return type is not a pointer\n",
>> +			       kfunc->name);
>> +			return id;
>> +		}
>> +		ret_type_id = id;
>> +	}
>> +
>> +	if (kfunc->flags & KF_ARENA_ARG1) {
> 
> Nit: let's avoid the copy paste and make this code prepared for the
>      __arena suffixes by moving the logic inside the parameter
>      processing loop below:
> 
>      for (i in params) {
>        bool add_tag = false;
> 
>        param_type_id = params[i].type;
>        switch(i) { 0: add_tag = kfunc->flags & KF_ARENA_ARG1; break; ... }
>        if (add_tag)
>           param_type_id = arena_tag_ptr(btf, param_type_id);
>        if (param_type_id < 0)
>          ...
>      }

Makes sense. Will do.

> 
>> +		if (nr_params < 1) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but it has no argument 1\n",
>> +			       kfunc->name);
>> +			return -EINVAL;
>> +		}
>> +		id = arena_tag_ptr(btf, arg0_type_id);
>> +		if (id < 0) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but argument 1 is not a pointer\n",
>> +			       kfunc->name);
> 
> Nit: not a pointer is not the only error condition, btf__add_*()
>      functions might fail as well, maybe just push pr_err() down
>      to the arena_tag_ptr()?

I guess the question is how much details do we want from the error
messages here. Since this is a part of kernel build pipeline that can
block it, I'd err on the side of more details.

I'll see if I can simplify this though.

> 
>> +			return id;
>> +		}
>> +		arg0_type_id = id;
>> +	}
>> +
>> +	if (kfunc->flags & KF_ARENA_ARG2) {
>> +		if (nr_params < 2) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but it has no argument 2\n",
>> +			       kfunc->name);
>> +			return -EINVAL;
>> +		}
>> +		id = arena_tag_ptr(btf, arg1_type_id);
>> +		if (id < 0) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but argument 2 is not a pointer\n",
>> +			       kfunc->name);
>> +			return id;
>> +		}
>> +		arg1_type_id = id;
>> +	}
>> +
>> +	new_proto_id = btf__add_func_proto(btf, ret_type_id);
>> +	if (new_proto_id < 0) {
>> +		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func proto to BTF\n",
>> +		       kfunc->name);
>> +		return new_proto_id;
>> +	}
>> +
>> +	for (u32 i = 0; i < nr_params; i++) {
>> +		proto = btf__type_by_id(btf, proto_id);
>> +		params = btf_params(proto);
> 
> Nit: these two do not need to be in the loop body.

They do, because btf__add_func_param() below may move the proto
pointer, no?

> 
>> +		name = btf__name_by_offset(btf, params[i].name_off);
>> +
>> +		switch (i) {
>> +		case 0:
>> +			param_type_id = arg0_type_id;
>> +			break;
>> +		case 1:
>> +			param_type_id = arg1_type_id;
>> +			break;
>> +		default:
>> +			param_type_id = params[i].type;
>> +			break;
>> +		}
>> +
>> +		err = btf__add_func_param(btf, name ?: "", param_type_id);
>> +		if (err < 0) {
>> +			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto param to BTF\n",
>> +			       kfunc->name);
>> +			return err;
>> +		}
>> +	}
>> +
>> +	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name, new_proto_id);
>> +
>> +	return new_proto_id;
>> +}
> 
> ...

