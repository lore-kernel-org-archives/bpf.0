Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269D2045AD
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426329; cv=none; b=WWjao4/5fecvPV++EM9xZliZPz95LeV5f8O6mL26JSTZzxA/Dp8vgoC0SCY1bTvc4ldIe2isoCL8NJehQD5XQLwjfvd4EySYOvlv2KJwM1QteWhYpI1bdv7jR7/ixrUVVMR1dF8wtXqJiQGCT7WdFyq2hSN/zh/GcUhnOhmOU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426329; c=relaxed/simple;
	bh=HKpu4FhKfBggEGcLdnDmIUIrUTJVCqvZM4dvwCE4JKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+faLlf79nNLX2huvs6fmXmoG8EuRCVsHsy9OGXuCKDe/9svYtOHfg8K3d3MjAvt5hv7WU82efov+Z6dj+npwjtws/xmeowd3M3zZXaT5VFipq9SQmgx7fxGC0KZoxjnPmDxukf/Opiks/aKZK6ylLhx7O4W1NSHUJ/dxnIziDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQH0tARZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQH0tARZ"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8845cb580bso742817966b.3
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 03:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769426326; x=1770031126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fU31cQf7s/Ulyyagx5+MqmS70uFSFhlB1pyUANU3x2Y=;
        b=PQH0tARZEvP0BmcV18bsI8dHq74wJUnmG22Qz1qp5WKcqqTLrgl8lJ6gKYdqm1wWXh
         Ub9IsS/ZMvdusobZZmTZw13ng8gmUaQIp7T0nN5uvgiFYKx/GXjRB0n4C7rHhqvKW/G7
         VYEAeND8UYH3VazmfIDBosbGQRzF+iDKrxiZTY8HTtr27bWACuMVwMdydsYSRmw8zAxy
         BKSmk+sMAPcT4tc+noNeti57iRglIwA9pMgVn1xLZzjQBQYNrcGnOwXgQLt9OKAMoV1U
         tyC3EN6I1SYERKJCAi4sc79pB0Q3J6s2tvxPLrHs7M/3zG+Cx55f2+OOslr/1KQtrQxe
         4anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426326; x=1770031126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU31cQf7s/Ulyyagx5+MqmS70uFSFhlB1pyUANU3x2Y=;
        b=bAa5AY7NcuGwK3nCSbk+lczvX5/CT9nxPjPyTXjq3DMfoGGwwdQp3sMKO9POFo8es5
         qDFSHcGnEvmOCTHe0x8SwJb90UVgPyDf2WYOjg5WqztQsC1oHcKhqK9h4vzMWrH63P5t
         lScld2q7/1zP+vW7otTxm4yaCpAc4veolzdEjkKd47DKd53VlQ0taDBs5Crwd5GECTv3
         dWYIl/y/KXDeI3tLp7OvGSa0FCpP5+QU2jAmH8MWKi+cAS1NVI2ta2iOBKBoaZTYW4oI
         dtAHjPxmOSv9hu6jbIVbK8MHk3upVNaNZ/ZxuOsVVtk5B+lskOvsfht6Yw6TawVsL265
         5xLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7flbo7Vodq4g7RqOvwNlndPn9ugnilwNSf41fSA3CThBr2P+vLbTViOpZEf2iFNgFjkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8yf1y+Pz6JsqOEEN6z2ry2vr8+BNGgVOICG9CFA0rvPNsK+j
	CIDA8JCKpwfthCNMgm3VNeX27dSfXexaBSo5A/2Sq1oXFQa8ITLVqpEYCYFaEjB0Gg==
X-Gm-Gg: AZuq6aLr1VmQryZGnQaQl8FPP7NnN4F72TcOiYkcyz2jgvuvSXmGstzEeUzdu7VLYe3
	zqk5x4HQ1xZtKAuu8gHibb5kowLUAjEx9oUnJ56dLAQ9M6MeCEtwuwqV/BKeWtW24JCsdhqUXvZ
	p3HZ76qadC+62TpLjENiMOKcJC+/N9U+SKTK+J2WfP9hmhNqdsBXK0SdCVOM++RyxbCqgcRJp/s
	OKS48bEmmyz5vT1IKhEZe34lCWRgQtkuOMlyONCwQk4Nzjk8N4l8vEIWcao5ceLSm8fRZbAMb8Y
	5AxOdNeghPqt6ENfFFDaegyWJZeWJIEzIxzI/TAM8/rkMpYmML4vXUXTWQODgw7KmpVSDvVeSVD
	31hUyT1URzrxU13+G20hywinfqr9NlhGfSsXUxfGRArfaWNeCFCXevxh8kGVKJpjZpA/Zj6IMYW
	hgFqShuvGq6mU83CkyRNB9nuAXi8ihUv8wlXDMwOogAnpIOoXdhLS54iWPZMLGag==
X-Received: by 2002:a17:907:1b18:b0:b88:471b:2f50 with SMTP id a640c23a62f3a-b8d20e3fbedmr285597066b.34.1769426325922;
        Mon, 26 Jan 2026 03:18:45 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b416ca5sm629292066b.25.2026.01.26.03.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:18:45 -0800 (PST)
Date: Mon, 26 Jan 2026 11:18:41 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: yonghong.song@linux.dev, ihor.solodrai@linux.dev, eddyz87@gmail.com,
	jolsa@kernel.org, andrii@kernel.org, ast@kernel.org,
	david.faust@oracle.com, dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
Message-ID: <aXdNkRerXTKAX3Ds@google.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-3-alan.maguire@oracle.com>
 <aXc5XXZvgJAHMf6v@google.com>
 <e25e9c26-933e-4aa3-822c-9e1181b0118a@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25e9c26-933e-4aa3-822c-9e1181b0118a@oracle.com>

On Mon, Jan 26, 2026 at 10:49:00AM +0000, Alan Maguire wrote:
> On 26/01/2026 09:52, Matt Bobrowski wrote:
> > On Fri, Jan 23, 2026 at 05:26:47PM +0000, Alan Maguire wrote:
> >> Currently we collate function information by name and add functions
> >> provided there are no inconsistencies across various representations.
> >>
> >> For true_signature support - where we wish to add the real signature
> >> of a function even if it differs from source level - we need to do
> >> a few things:
> >>
> >> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
> >>    we can do this via the address associated with the function.
> >>    In doing this, we can then be confident that the debug info
> >>    for foo.isra.0 is the right info for the function at that
> >>    address.
> >>
> >> 2. When adding saved functions we need to look for such cases
> >>    and provided they do not violate other constraints around BTF
> >>    representation - unexpected reg usage for function, uncertain
> >>    parameter location or ambiguous address - we add them with
> >>    their "."-suffixed name.  The latter can be used as a signal
> >>    that the function is transformed from the original.
> >>
> >> Doing this adds 500 functions to BTF.  These are traceable with
> >> their "."-suffix names and because we have excluded ambiguous
> >> address cases we know exactly which function address they refer
> >> to.
> >>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > 
> > Some minor nits, but apart from that it looks OK to me.
> > 
> > Acked-by: Matt Bobrowski <mattbobrowski@google.com>
> > 
> >> ---
> >>  btf_encoder.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-----
> >>  dwarves.h     |  1 +
> >>  pahole.c      |  1 +
> >>  3 files changed, 71 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/btf_encoder.c b/btf_encoder.c
> >> index 9a567e4..c1002c3 100644
> >> --- a/btf_encoder.c
> >> +++ b/btf_encoder.c
> >> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
> >>  	int16_t component_idx;
> >>  };
> >>  
> >> +struct elf_function_sym {
> >> +	const char *name;
> >> +	uint64_t addr;
> >> +};
> >> +
> >>  /* state used to do later encoding of saved functions */
> >>  struct btf_encoder_func_state {
> >>  	struct elf_function *elf;
> >> +	struct elf_function_sym *sym;
> >> +	uint64_t addr;
> >   		 ^
> > 		 This appears to have leaked into wrong commit?
> > 		 This member should've been introduced within patch
> > 		 5/5.
> >
> 
> It's used here too though; specifically in btf_encoder__save_func()
> below. We need to use addresses to map between a DWARF representation
> and the associated ELF function to ensure we're using debug info
> for the correct "."-suffixed function. We need to do this because
> the late DWARF generated after optimizations are applied uses
> the original name ("foo" rather than "foo.isra.0").

Sorry, I thought I only saw usage of member "addr" within
btf_encoder__save_func() against fn->lenblock.ip.addr which maps to
member "addr" within struct ip_tag and func->syms[i].addr which maps
to member "addr" within struct elf_function_sym. Member "addr" within
struct btf_encoder_func_state remains unused until patch 5/5 where we
assign it the value returned from function__addr().

With that said, within btf_encoder__save_func() why don't you do the
following instead:

state->addr = function__addr(fn);

...

if (encoder->true_signature && state->addr) {
	if (state->addr != func->syms[i].addr) {
		...
	}
}

There's no need to open code fn->lexblock.ip.addr everywhere as it
deminishes readability.

> >>  	uint32_t type_id_off;
> >>  	uint16_t nr_parms;
> >>  	uint16_t nr_annots;
> >> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
> >>  	struct btf_encoder_func_annot *annots;
> >>  };
> >>  
> >> -struct elf_function_sym {
> >> -	const char *name;
> >> -	uint64_t addr;
> >> -};
> >> -
> >>  struct elf_function {
> >>  	char		*name;
> >>  	struct elf_function_sym *syms;
> >> @@ -145,7 +147,8 @@ struct btf_encoder {
> >>  			  skip_encoding_decl_tag,
> >>  			  tag_kfuncs,
> >>  			  gen_distilled_base,
> >> -			  encode_attributes;
> >> +			  encode_attributes,
> >> +			  true_signature;
> >>  	uint32_t	  array_index_id;
> >>  	struct elf_secinfo *secinfo;
> >>  	size_t             seccnt;
> >> @@ -1270,14 +1273,36 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> >>  			goto out;
> >>  		}
> >>  	}
> >> +	if (encoder->true_signature && fn->lexblock.ip.addr) {
> >> +		int i;
> >> +
> >> +		for (i = 0; i < func->sym_cnt; i++) {
> >> +			if (fn->lexblock.ip.addr != func->syms[i].addr)
> >> +				continue;
> >> +			/* Only need to record address for '.'-suffixed
> >> +			 * functions, since we only currently need true
> >> +			 * signatures for them.
> >> +			 */
> >> +			if (!strchr(func->syms[i].name, '.'))
> >> +				continue;
> >> +			state->sym = &func->syms[i];
> >> +			break;
> >> +		}
> >> +	}
> >>  	state->inconsistent_proto = ftype->inconsistent_proto;
> >>  	state->unexpected_reg = ftype->unexpected_reg;
> >>  	state->optimized_parms = ftype->optimized_parms;
> >>  	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
> >>  	state->reordered_parm = ftype->reordered_parm;
> >>  	ftype__for_each_parameter(ftype, param) {
> >> -		const char *name = parameter__name(param) ?: "";
> >> +		const char *name;
> >>  
> >> +		/* No location info/optimized + reordered means optimized out. */
> >> +		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
> >> +			state->nr_parms--;
> >> +			continue;
> >> +		}
> >> +		name = parameter__name(param) ?: "";
> >>  		str_off = btf__add_str(btf, name);
> >>  		if (str_off < 0) {
> >>  			err = str_off;
> >> @@ -1366,6 +1391,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
> >>  
> >>  	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
> >>  	name = func->name;
> >> +	if (encoder->true_signature && state->sym)
> >> +		name = state->sym->name;
> >> +
> >>  	if (btf_fnproto_id >= 0)
> >>  		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
> >>  						      name, false);
> >> @@ -1508,6 +1536,39 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
> >>  		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
> >>  			j++;
> >>  
> >> +		/* Add true signatures for case where we have an exact
> >> +		 * symbol match by address from DWARF->ELF and have a
> >> +		 * "." suffixed name.
> >> +		 */
> >> +		if (encoder->true_signature) {
> >> +			bool true_added = false;
> >> +			int k;
> >> +
> >> +			for (k = i; k < nr_saved_fns; k++) {
> >> +				struct btf_encoder_func_state *true_state = &saved_fns[k];
> >> +
> >> +				if (state->elf != true_state->elf)
> >> +					break;
> >> +				if (!true_state->sym)
> >> +					continue;
> >> +				/* Unexpected reg, uncertain parm loc and
> >> +				 * ambiguous address mean we cannot trust fentry.
> >> +				 */
> >> +				if (true_state->unexpected_reg ||
> >> +				    true_state->uncertain_parm_loc ||
> >> +				    true_state->ambiguous_addr)
> >> +					continue;
> >> +				err = btf_encoder__add_func(encoder, true_state);
> >> +				if (err < 0)
> >> +					goto out;
> >> +				true_added = true;
> >> +				break;
> >> +			}
> >> +			/* If true symbol was added, skip the below. */
> >> +			if (true_added)
> >> +				continue;
> >> +		}
> >> +
> > 
> > I think this hunk should be factored out into a
> > helper. btf_encoder__add_saved_funcs() is starting to get hairy IMO.
> > 
> 
> Yeah, I think that's reasonable. The combination of loops within loops,
> breaks and continues is getting hard to follow. I'll respin with a
> btf_encoder__add_true_signature() function replicating this logic.
> 
> 
> >>  		/* do not exclude functions with optimized-out parameters; they
> >>  		 * may still be _called_ with the right parameter values, they
> >>  		 * just do not _use_ them.  Only exclude functions with
> >> @@ -2584,6 +2645,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
> >>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
> >>  		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
> >>  		encoder->encode_attributes = conf_load->btf_attributes;
> >> +		encoder->true_signature = conf_load->true_signature;
> >>  		encoder->verbose	 = verbose;
> >>  		encoder->has_index_type  = false;
> >>  		encoder->need_index_type = false;
> >> diff --git a/dwarves.h b/dwarves.h
> >> index 78bedf5..d7c6474 100644
> >> --- a/dwarves.h
> >> +++ b/dwarves.h
> >> @@ -101,6 +101,7 @@ struct conf_load {
> >>  	bool			btf_decl_tag_kfuncs;
> >>  	bool			btf_gen_distilled_base;
> >>  	bool			btf_attributes;
> >> +	bool			true_signature;
> >>  	uint8_t			hashtable_bits;
> >>  	uint8_t			max_hashtable_bits;
> >>  	uint16_t		kabi_prefix_len;
> >> diff --git a/pahole.c b/pahole.c
> >> index ef01e58..02a0d19 100644
> >> --- a/pahole.c
> >> +++ b/pahole.c
> >> @@ -1234,6 +1234,7 @@ struct btf_feature {
> >>  	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
> >>  	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
> >>  				      attributes_check),
> >> +	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
> >>  };
> >>  
> >>  #define BTF_MAX_FEATURE_STR	1024
> >> -- 
> >> 2.43.5
> >>
> 
