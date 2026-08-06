Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A547F765
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050404; cv=none; b=BdO67cDGJ40QXPpu1JUNTDtK2RkkojOpby1np6NSJAzkh64+9bekIykmfaNCgtVmnKdwYnZEMpO09H0OhdTUNKvsVfzkcTbkxgo7PCLP++Qiw3Dr1rPlcyhiqZ1cJGMQoa2TafVxJL5E6lLWlcnpjmIMmbZOaD3lWNy0rAvN0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050404; c=relaxed/simple;
	bh=Kp41RHfNDkstCjrQQeuShbUQmUEHHc6AKhcyizONNDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipyuhZAuXr/xZ8uNq6NnD8sCf4zxp0uZSRAkaOWDj2bWT/O3JuxqhLrUtMzEaj+5aze7B0y278JPCa42e73ciNOXPeIZmG9SDyciCT5jGvxY+AxGgb66eiAURIrXMk5m9I2YQP+NaX6VRlK1lnNyItODSoPLWlSg22/VX7vXVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HvisrRb4; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HvisrRb4"
Message-ID: <f9b8c8b1-906e-458b-b779-faacb2dee66c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdNNYmL0/yfvQZrBDQe4pGwcwmTLv9LsarZ3QOI/cwU=;
	b=HvisrRb4XY+FJq11vAOEoj5VPDdEYh5qiTimelFjQj4nf/fXrfWtWgyE4+VJrfyCl6NIPb
	U6reipjaTGKqDRInfP47QZNPD9d5VdoHe1J6By9UmgbVIrzKhr+Q4fzJHaF0rKOmT6qsdY
	LYwszvber5kcaWvqwvaXB4frysYK97Q=
Date: Thu, 6 Aug 2026 14:06:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF
 annotation emission
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
 <20260805230648.2354989-7-ihor.solodrai@linux.dev>
 <b695bed46f03b4cc1a819bcd0d63272923ba5ca3.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b695bed46f03b4cc1a819bcd0d63272923ba5ca3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 12:47 PM, Eduard Zingerman wrote:
> On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> 
> ...
> 
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index cbde86d082cc..c60fc574e8b0 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -472,6 +472,14 @@ type. An example is shown below::
>>          }
>>          late_initcall(init_subsystem);
>>  
>> +At kernel build time the ``resolve_btfids`` tool discovers all kfuncs from the
>> +registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into the
> 
> Note that this is a single occurrence of the word BTF_SET8_KFUNCS in
> this .rst file. Also The wording "registered" is confusing as the
> above code snippet shows the usage of register_btf_kfunc_id_set()
> function, which is completely unrelated.
> 
>> +kernel's BTF; these annotations were historically produced by pahole. For each
> 
> I'd skip a note about pahole, it does not convey usable information.

ack

> 
>> +discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, a
>> +``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and the
>> +``address_space(1)`` type attribute on the return value and/or arguments flagged
>> +``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
>> +
>>  2.7  Specifying no-cast aliases with ___init
>>  --------------------------------------------
>>  
>> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
>> index 1ca8c5f73ad0..6d1dbe4abf0f 100644
>> --- a/Documentation/process/changes.rst
>> +++ b/Documentation/process/changes.rst
>> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
>>  modules as well.  This requires pahole v1.22 or later.
>>  
>> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
>> -or later.  Without it, such kfuncs will have incorrect BTF prototypes in
>> -vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
>> -with vmlinux" error.  Many sched_ext kfuncs are affected.
>> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the arena
>> +address_space(1) type attribute) are emitted in-tree by resolve_btfids from the
>> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
> 
> Just drop the whole paragraph?

hmm... yeah you're right

> 
>>  
>>  It is found in the 'dwarves' or 'pahole' distro packages or from
>>  https://fedorapeople.org/~acme/dwarves/.
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index a1812985a61a..717e76ce96a7 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
>>  else
>>  
>>  # Switch to using --btf_features for v1.26 and later.
>> +#
>> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
>> +# address_space(1) type attribute) are emitted by resolve_btfids, not pahole.
> 
> What's the point of this comment?

The point is to inform the reader "where did decl_tag_kfuncs go?".
Question is whether the git log will be enough, or is a comment
also appropriate?

> 
>>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>>  
>>  pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
> 
> ...

