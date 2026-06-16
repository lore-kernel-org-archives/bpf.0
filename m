Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A613845C4
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640623; cv=none; b=NrZHsUDEK4TqZtzrkocWt8qSSxO9Xqqofy+l6ViMmVPq9sTUkR9M1uP0wVBSFJchfOmlSjPSqrIi41G0V6Z6R6rMlOILp7NJwg8hILxs1Z2fD9Z5ZgUomGDat3+m21EsDNz5PyTARC6OYhuNvo2GooFahx0NR4Kc6dg0THbe33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640623; c=relaxed/simple;
	bh=uXi1GrLjUavubxJ3YDfn5OC1eELmb/Bf1eiQ0IgU4TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTEkvhea+ZI9tjPbgdd4VTWWGvUCCF69oWrUKSZ/mhOjmSeNWow7sNPJboITJ9x+MAHaDhSa+jrkZjfNR2nDIAszi4tNC1NCSLhwS4Eq0N9WqFYnnIB60ndLD4oagcT5WkWi4IuY/ux9kLlbBZAb6xrc8sVdVt8BRiFkjd6lvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RcTSBzRO; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RcTSBzRO"
Message-ID: <d4c1c0a8-0c7f-4b0d-b7e7-37933c9f9efe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781640610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHbp9nlXw7phrFaurZznoIn29ClzJQQUdZgiSuc8s2Y=;
	b=RcTSBzROzZD+GmlukfJh9sjOIrZZvxd93HOdThXbagw8ymbhs/sTOhcV8mEHrgj/TSX0wS
	bo04btO26QpJnlbotf892RZrcspGVbrtKBU7hlYG+rPogPbxY5UxRCIiybc6Y6P8GQqoPR
	py5korJ2tv+be1SICgy54JFzwlju1Iw=
Date: Tue, 16 Jun 2026 13:10:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 00/14] resolve_btfids: Implement BTF tags
 emission for kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <CAEf4Bzb-MuvFqsBdNCYyU=X7O+OXGK33TKA3GRe=P0gVFR=S2g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bzb-MuvFqsBdNCYyU=X7O+OXGK33TKA3GRe=P0gVFR=S2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 4:45 PM, Andrii Nakryiko wrote:
> On Mon, Jun 1, 2026 at 3:18 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> BTF data for the kernel is generated through the following pipeline:
>>   * DWARF is emitted by the compiler
>>   * pahole reads in DWARF and produces BTF
>>   * resolve_btfids makes kernel-specific btf2btf transformation and
>>     patches .BTF_ids section
>>
>> This is orchestrated by link-vmlinux.sh, gen-btf.sh and Makefile.btf
>> in ./scripts directory.
>>
>> Historically kernel-specific BTF features were implemented in pahole,
>> and controlled by the feature flags. This requires kernel build
>> process to be aware of pahole version used for the build to set
>> correct runtime arguments for BTF encoding [1].
>>
>> This is a burden which can be alleviated by splitting kernel/module
>> BTF generation in two stages:
>>   1. Generic BTF generation from the kernel source code.
>>   2. Kernel-specific BTF modifications to support various BPF features.
>>
>> So far both stages were fused in pahole's BTF encoding. By moving
>> stage (2) in-tree, the dependency of kernel build on pahole can become
>> much more loose.
>>
>> Recent work [2] made it possible to do btf2btf transformations in
>> resolve_btfids, and it is already responsible for a few important BTF
>> modifications for the kernel:
>>   * .BTF.base generation for modules [3]
>>   * BTF sorting [4]
>>   * KF_IMPLICIT_ARGS support [5]
>>
>> This series continues the migration of kernel-specific BTF
>> transformations from pahole to resolve_btfids, implementing emission
>> of decl/type tags for the kfuncs and handling of the KF_ARENA_* flags.
>>
>> The implementation is idempotent with respect to BTF modifications: if
> 
> This sounds like an unnecessary complication. Can't we just control
> pahole through flags to guarantee there will be no kernel-specific
> information emitted?

Hi everyone.

I talked to Andrii off-list about this series last week and I'm in the
middle of preparing a v2, which is why I've been quiet in the thread.

The main v1->v2 design change from the discussion is to drop the
"ensure" pattern: just assume valid BTF on input. This requires
restructuring the series to preserve bisectability with respect to the
pahole flags.

I'll go through the messages now and reply where necessary. I'm going
to silently accept most of the nits I think.

Thanks!

> 
> 
>> input BTF already contains target tags, corresponding resolve_btfids
>> transformation is a noop. This allows for more flexibility in terms of
>> dependency on pahole. In particular, older pahole (without
>> decl_tag_kfuncs support, for example) can now be used in kbuild and
>> the resulting vmlinux BTF will contain properly tagged kfuncs
>> anyways. Conversely, if for whatever reason pahole emitted the same
>> tags, they will be properly skipped.
>>
>> [...]
