Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFA3F7E8F
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 20:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952659; cv=none; b=Ro+fGU6aaAcys/azXSWrFsESPnTZCmmKHDXZthUDWgL+jI1OFB/ALrmdLGFyS3gmVgi5tnEuEbbj+QjotT2c0kAdC1ESGqmp8oAXrl7NCuWRj7i12cbK4xSGp4WofMH1XaY/7gWx8SmWUlhxnlRLqPmArlPWR46WPKB4/nxZuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952659; c=relaxed/simple;
	bh=l+jynknLewvG7rfXVfSRyIeHLZG3GIWfREzY6j5zNlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTud7OMYnRr7oozs2pqc2CxZ3Nu5dn1iWMlj7B4Vz9a1kvjyi8+26dlloP1H+bhnSiZ3144CV4osGrSBzD6J2ubI2gEGt5rEhxNzJhJmydtWmSKIKeH+5jx8CUndI7tbpxJIu5HL84vcWI+ZjFMbyCOUNVub3tPaJfqH6dk5e08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GGPIxmNi; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GGPIxmNi"
Message-ID: <470ba10a-096c-4f54-81e0-b896a4d72e25@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773952654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SA0RDgzLdJaicfTK378M0gYPDgWc+g4VGSZAOEZf4aM=;
	b=GGPIxmNiHgfXlvONXqdBbWc5L/7/nt8MT42r4WANNHVWYbLwtqS5IqRe2fP0rQJzys19ef
	A/nsLtRdb3XZ+6A8Va2WLBpAjTseib2QAnjYfB0gGGxmiiBlccCrD8647JPa+0G6NdJX+q
	kZ5D63a72ULA3CRuwdh/ZX7+X1Vppm8=
Date: Thu, 19 Mar 2026 13:37:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <abvrQATstf5nuOpK@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <abvrQATstf5nuOpK@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/19/26 5:25 AM, Jiri Olsa wrote:
> On Wed, Mar 18, 2026 at 04:42:09PM -0700, Ihor Solodrai wrote:
> 
> SNIP
> 
>>  
>> +/*
>> + * A kfunc with KF_IMPLICIT_ARGS has two prototypes in BTF:
>> + *   - the _impl prototype with full arg list (this is meta->func_proto)
>> + *   - the BPF API prototype w/o implicit args (func->type in BTF)
>> + * To determine whether an argument is implicit, we compare its position
>> + * against the number of arguments of both prototypes.
>> + */
>> +static bool is_kfunc_arg_implicit(const struct bpf_kfunc_call_arg_meta *meta, u32 arg_idx)
>> +{
>> +	const struct btf_type *func, *func_proto;
>> +	u32 argn, full_argn;
>> +
>> +	if (!(meta->kfunc_flags & KF_IMPLICIT_ARGS))
>> +		return false;
>> +
>> +	full_argn = btf_type_vlen(meta->func_proto);
>> +
>> +	func = btf_type_by_id(meta->btf, meta->func_id);
>> +	func_proto = btf_type_by_id(meta->btf, func->type);
>> +	argn = btf_type_vlen(func_proto);
>> +
>> +	return argn <= arg_idx && arg_idx < full_argn;
> 
> hi,

Hi Jiri, thank you for taking a look.

> I understand above is faster, but should we rather check for exact
> types with something like:
> 
> __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_PROG_AUX_ID ||
> __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_BTF_STRUCT_META

This is an open question, see my discussion with Andrii [1].

IMO we don't have to enforce the argument type in
is_kfunc_arg_implicit(). The only way I can see this check causing
problems is by an invalid kfunc declaration, or a relevant bug in
resolve_btfids causing bad/wrong BTF. My understanding is that
verifier can trust kernel's BTF as long as it's valid BTF.

But let me know if I'm missing something here.

[1] https://lore.kernel.org/bpf/3d069965-2992-421f-bb94-827bcb177f17@linux.dev/

> 
> jirka

