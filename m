Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1741D637
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050852; cv=none; b=GC+g641wV36SnCpo+g5Rb2BzgHWZzCed7ZWmtiyDucP06kTrmRO7qrA1jJ7KgDdeya+qfi1PYGOQMgXa/pBkmwhDH1v06szrmp4kUhyBjmUzK/CeBKwovYvJ0AGT73Kl8Keyt1uf+WpPAqje/q+y4kYBO+Es+BidQfykS2F33Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050852; c=relaxed/simple;
	bh=Y7j+vHz5ifg+awfBMpMmqyogGa/aB+LwlKJSG3YrdLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpbA6wHvC25Cqva1mLvViwgQ3pQjvk/8JCR3aYAn9YbjeI8fYq1bHJW5YUQpfFgyTS/NzgVuASmra531/tiuoYKD4LZMkKTm7MZA+Qjax1YQMB9j2SDozzrT/L+XP1iq+EI/o99kHyCVdlUssBmLL1dA0bMd03k7/Q+mLGVibRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTzMxtY/; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTzMxtY/"
Message-ID: <33b6923a-51ed-4e6f-b41a-8780992fa262@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786050844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/6Jrn204tkhstHg8N9Afe3wZPFehkOUPkVqH18ofNo=;
	b=RTzMxtY/6D5I1qeAi55XFme58Bznp71UU7T1Rje/4Ts/SA0Ra/Cf+ckYFDFTVD2ixl/158
	fK405RVaJgNVcDfvLDV+uFMQp9MJ3IUnRuLx7E7f9RAWYo0Ztg8MIWO1MVYzlZAaqh09wz
	mMzAcSg6DF0fk7iqsVEMAG6NaGpX2rs=
Date: Thu, 6 Aug 2026 14:13:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 6/6] docs, resolve_btfids: Document kfunc BTF
 annotation emission
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com
Cc: alan.maguire@oracle.com, jolsa@kernel.org, emil@etsalapatis.com,
 bpf@vger.kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com
References: <20260805230648.2354989-7-ihor.solodrai@linux.dev>
 <a55ccb52e205bc8a32d3ae6c179de333746ef912a9a259f18425b33935509653@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <a55ccb52e205bc8a32d3ae6c179de333746ef912a9a259f18425b33935509653@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/26 5:01 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
>> index cbde86d082cce..c60fc574e8b06 100644
>> --- a/Documentation/bpf/kfuncs.rst
>> +++ b/Documentation/bpf/kfuncs.rst
>> @@ -472,6 +472,14 @@ type. An example is shown below::
>>          }
>>          late_initcall(init_subsystem);
>>
>> +At kernel build time the ``resolve_btfids`` tool discovers all kfuncs from the
>> +registered ``BTF_SET8_KFUNCS`` sets and emits their BTF annotations into the
>> +kernel's BTF; these annotations were historically produced by pahole. For each
>> +discovered kfunc ``resolve_btfids`` emits a ``bpf_kfunc`` BTF decl tag, a
>> +``bpf_fastcall`` decl tag when the kfunc is flagged ``KF_FASTCALL``, and the
>> +``address_space(1)`` type attribute on the return value and/or arguments flagged
>> +``KF_ARENA_RET``, ``KF_ARENA_ARG1`` or ``KF_ARENA_ARG2`` (see section 2.8).
> 
> Emil Tsalapatis suggested in v1 replacing "address_space(1)" with "arena"
> throughout the documentation for better readability. This nit was not
> addressed in v2.
> 
> The term "address_space(1)" appears in four locations across this commit
> (kfuncs.rst, changes.rst, Makefile.btf, and main.c). Would using "arena"
> be clearer, especially since the code already defines TYPE_ATTR_ARENA?

Nonsense feedback from the bot. Ignoring.

> 
>> +
>>  2.7  Specifying no-cast aliases with ___init
>>  --------------------------------------------
>>
>> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
>> index 1ca8c5f73ad00..6d1dbe4abf0f0 100644
>> --- a/Documentation/process/changes.rst
>> +++ b/Documentation/process/changes.rst
>> @@ -147,10 +147,9 @@ Since Linux 5.2, if CONFIG_DEBUG_INFO_BTF is selected, the build system
>>  generates BTF (BPF Type Format) from DWARF in vmlinux, a bit later from kernel
>>  modules as well.  This requires pahole v1.22 or later.
>>
>> -Since Linux 7.0, kfuncs annotated with KF_IMPLICIT_ARGS require pahole v1.26
>> -or later.  Without it, such kfuncs will have incorrect BTF prototypes in
>> -vmlinux, causing BPF programs to fail to load with a "func_proto incompatible
>> -with vmlinux" error.  Many sched_ext kfuncs are affected.
>> +Kfunc BTF annotations (the bpf_kfunc and bpf_fastcall decl tags and the arena
>> +address_space(1) type attribute) are emitted in-tree by resolve_btfids from the
>> +BTF_KFUNCS sets, so they no longer depend on a specific pahole version.
>>
>>  It is found in the 'dwarves' or 'pahole' distro packages or from
>>  https://fedorapeople.org/~acme/dwarves/.
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index a1812985a61aa..717e76ce96a71 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -14,6 +14,9 @@ pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsis
>>  else
>>
>>  # Switch to using --btf_features for v1.26 and later.
>> +#
>> +# kfunc BTF annotations (bpf_kfunc/bpf_fastcall decl tags and the arena
>> +# address_space(1) type attribute) are emitted by resolve_btfids, not pahole.
>>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>>
>>  pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index ea25ca34aa006..66f4014e6aa17 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -58,6 +58,17 @@
>>   *             __BTF_ID__func__vfs_fallocate__5:
>>   *             .zero 4
>>   *	       .word (1 << 3) | (1 << 1) | (1 << 2)
>> + *
>> + * In addition to resolving BTF IDs, resolve_btfids performs kernel-specific
>> + * BTF-to-BTF transformations for kfuncs found in BTF_SET8_KFUNCS sets. For
>> + * each such kfunc it:
>> + *
>> + *   - emits a "bpf_kfunc" decl tag, and "bpf_fastcall" when KF_FASTCALL is set;
>> + *   - wraps the return value and/or arguments flagged KF_ARENA_RET,
>> + *     KF_ARENA_ARG1 or KF_ARENA_ARG2 with the "address_space(1)" type attribute;
>> + *   - rewrites the prototype of KF_IMPLICIT_ARGS kfuncs.
>> + *
>> + * These kfunc annotations were historically produced by pahole.
>>   */
>>
>>  #define  _GNU_SOURCE
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31056256483

