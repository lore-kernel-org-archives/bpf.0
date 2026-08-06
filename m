Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6A4248DC
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050997; cv=none; b=dOO4+OKLkEDQtAqjQI9j69Tumy/LdjC+ykd0TvbzNyNG5S0GECvNg3BssTDh7v69XvLozU2lVz2LJz2ORzE08ER+WVA031I0WCe1bZVmbAWJhBoo4plHo0RVQg1SgCyrGh78hGJD7nwa+i8y6+xPaKsaWpZ23qRxqI/kPivbFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050997; c=relaxed/simple;
	bh=pSBIKlCMa13VCkbQW8AIUPptuaVFEQmIqlc+QQG/ES4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0ZxX5XvY6X/VwB+z2VXUIymiuPdYpvz70+AgP+Otp7BzMnZXa2glpSczKyLjJl03zeIO19252wKgrrUM14OYcaS+g1+9royRvN1S0eiFaGDt3ejcYu6KGrUNdFesrdRLgFD2lLEtszvgbroZrsjsETJz4avq1nk8ZKFBsTyx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C1nfjmeY; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C1nfjmeY"
Message-ID: <64e8767b-e3b3-4794-a8b1-b4c1d8248353@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHA/YRsIb/3fPVEiFS+Ogztk3CMSnLdHrQv8EXgoMZA=;
	b=C1nfjmeYqfp5KpBouN+nIyan/O7E9SdjQRsnNy5FgjYCQd9gLtzdamPHlQFDSmyXpENFrw
	DxU9jr9ob1wqEA/tDM459YBRs+/mj+GofE4Ttx/41ieYmLanPX5+KBbm18typ0pG/4DhaZ
	sj+R5CdaLKqu2VVx6Pk73LRtv06dPEw=
Date: Thu, 6 Aug 2026 14:16:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 <d3b34173-d3fa-489b-958d-f56bd541b838@linux.dev>
 <afb7cff918f93e754a873344d9794446e4ac4f9f.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <afb7cff918f93e754a873344d9794446e4ac4f9f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 2:12 PM, Eduard Zingerman wrote:
> On Thu, 2026-08-06 at 14:02 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>>>> +		if (nr_params < 1) {
>>>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but it has no argument 1\n",
>>>> +			       kfunc->name);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		id = arena_tag_ptr(btf, arg0_type_id);
>>>> +		if (id < 0) {
>>>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG1 but argument 1 is not a pointer\n",
>>>> +			       kfunc->name);
>>>
>>> Nit: not a pointer is not the only error condition, btf__add_*()
>>>      functions might fail as well, maybe just push pr_err() down
>>>      to the arena_tag_ptr()?
>>
>> I guess the question is how much details do we want from the error
>> messages here. Since this is a part of kernel build pipeline that can
>> block it, I'd err on the side of more details.
>>
>> I'll see if I can simplify this though.
> 
> Well, we don't want the errors to lie either :)

Why not? We can create many beautiful debugging evenings for the people,
and now for AIs too!

:bilbo_why_shouldnt_I_meme:

> 
>>>
>>>> +			return id;
>>>> +		}
>>>> +		arg0_type_id = id;
>>>> +	}
>>>> +
>>>> +	if (kfunc->flags & KF_ARENA_ARG2) {
>>>> +		if (nr_params < 2) {
>>>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but it has no argument 2\n",
>>>> +			       kfunc->name);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +		id = arena_tag_ptr(btf, arg1_type_id);
>>>> +		if (id < 0) {
>>>> +			pr_err("ERROR: resolve_btfids: kfunc %s: KF_ARENA_ARG2 but argument 2 is not a pointer\n",
>>>> +			       kfunc->name);
>>>> +			return id;
>>>> +		}
>>>> +		arg1_type_id = id;
>>>> +	}
>>>> +
>>>> +	new_proto_id = btf__add_func_proto(btf, ret_type_id);
>>>> +	if (new_proto_id < 0) {
>>>> +		pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a func proto to BTF\n",
>>>> +		       kfunc->name);
>>>> +		return new_proto_id;
>>>> +	}
>>>> +
>>>> +	for (u32 i = 0; i < nr_params; i++) {
>>>> +		proto = btf__type_by_id(btf, proto_id);
>>>> +		params = btf_params(proto);
>>>
>>> Nit: these two do not need to be in the loop body.
>>
>> They do, because btf__add_func_param() below may move the proto
>> pointer, no?
> 
> Huh, indeed.
> 
>>>> +		name = btf__name_by_offset(btf, params[i].name_off);
>>>> +
>>>> +		switch (i) {
>>>> +		case 0:
>>>> +			param_type_id = arg0_type_id;
>>>> +			break;
>>>> +		case 1:
>>>> +			param_type_id = arg1_type_id;
>>>> +			break;
>>>> +		default:
>>>> +			param_type_id = params[i].type;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		err = btf__add_func_param(btf, name ?: "", param_type_id);
>>>> +		if (err < 0) {
>>>> +			pr_err("ERROR: resolve_btfids: kfunc %s: failed to add a proto param to BTF\n",
>>>> +			       kfunc->name);
>>>> +			return err;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	pr_debug("added arena-tagged proto for kfunc %s: %d\n", kfunc->name, new_proto_id);
>>>> +
>>>> +	return new_proto_id;
>>>> +}
>>>
>>> ...

