Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C983515D5;
	Wed, 19 Aug 2026 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787121774; cv=none; b=V9N+30m8vf57cji8OlsaiAct86lZxQBDw5u/hZhEkWVim2QG9vvYwb5fUPFJ8JFjktoI52IaRDPrQseleUZFFw3Y+xevg8l0covj6eAKU8wU5uxDRt7LvsPJ26hJjvs42ICWJvKVmPI8B10Q6JPWrjnKC8/0qGrrxwhNmbeVlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787121774; c=relaxed/simple;
	bh=EcHlaHX3gHJyEH/Zga+QN1oo/GzQGDIJpk5BiafgZcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxLx7KRqHIHLF8R30Uoo8NtmD0lJb7jehL46NCF6rvGbUPERnqCWCxxMq2js8bXsFfn8LHSN5P9O/6jClYSyHcJ5Evp+3NJVnMXne0jYRkNoxsrG5pdGxw3QquUXjhBg1T0WbaKHG/BpYyGhYBALO2Nf+z5Tb4q8HyHsdYMznpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaEwTV3k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaEwTV3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC4C1F000E9;
	Wed, 19 Aug 2026 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787121773;
	bh=CrEG9fFw1MFmWKmMTb/tSxBnpXHVdHRYHFBMBtOPBHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IaEwTV3ksNQJzjITQnGu05Ka6a4HdZJTbwpRx7eozxzTfG5sIjysaLWrIoHU3//65
	 s8a3CwgrXic9Aa8jbJQTZA7WrKhIDLHYPk5jFrlkVBRfCjU3odJ8mEl7geAsFfl6Ww
	 /PV2/nMs0E0fs0ZcQyp82MWJ7jU9zaDzmAtpR1yJQthpuMu4LSvDzPphSQbbuN9hi7
	 zONGWCLJ1RAFJAVw4wC5/ucjFXtILsHMpjl7DJ92Qik494ju8EtgiiZ6/71cVtb7aY
	 Wm2HM86Q7GFYCgYlInHiI2B8mQmTpO0FoxBIv9eEn+3DFlUevE9W6dT4G5eAQ/VsgR
	 hvFN0/nZpYIZA==
Date: Wed, 19 Aug 2026 09:42:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, bp@alien8.de, daniel@iogearbox.net,
	dave.hansen@linux.intel.com, eddyz87@gmail.com, mingo@redhat.com,
	memxor@gmail.com, song@kernel.org, tglx@kernel.org,
	emil@etsalapatis.com, hpa@zytor.com, jolsa@kernel.org,
	john.fastabend@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, olsajiri@gmail.com,
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH] x86/bpf: make arch_bpf_trampoline_size allocate from
 EXECMEM_MODULE_DATA
Message-ID: <aoVQYYzUt_eCG4Ek@kernel.org>
References: <20260818130510.3110054-1-rppt@kernel.org>
 <9b5c48df2b9e1f49191a459c822608751240e2243ae0cebb96bae0939037aadc@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b5c48df2b9e1f49191a459c822608751240e2243ae0cebb96bae0939037aadc@mail.kernel.org>

On Tue, Aug 18, 2026 at 02:07:23PM +0000, bot+bpf-ci@kernel.org wrote:
> >     x86/bpf: make arch_bpf_trampoline_size allocate from EXECMEM_MODULE_DATA
> >
> >     Jiri Olsa reports slowdown of tracing_multi benchmark that allocates huge
> >     number of trampolines [1].
> >
> >     The slowdown caused by extra protection changes in execmem_alloc_rw() and
> >     execmem_free().
> >
> >     With ROX caches enabled, all execmem allocations except EXECMEM_MODULE_DATA
> >     are ROX after the allocation. execmem_alloc_rw() temporarily sets them to
> >     W+NX and execmem_free() resets them back to ROX.
> >
> >     The only user of bpf_jit_alloc_exec_rw() is x86::arch_bpf_trampoline_size()
> >     that only needs a temporary writable buffer in the modules address space.
> >
> >     On x86 executable memory and module data are constrained to the same
> >     address range, so x86::arch_bpf_trampoline_size() can directly use
> >     execmem_alloc(EXECMEM_MODULE_DATA)
> >
> >     Replace the call to bpf_jit_alloc_exec_rw() with a call to
> >     execmem_alloc(EXECMEM_MODULE_DATA) in x86::arch_bpf_trampoline_size() and
> >     drop bpf_jit_alloc_exec_rw() helper.
> >
> >     Reported-by: Jiri Olsa <olsajiri@gmail.com>
> >     Link: https://lore.kernel.org/all/an8r7EODLIL-bZM3@krava
> >     Fixes: f0334294a428 ("bpf, x86: make sure allocation in arch_bpf_trampoline_size() is writable")
>              ^^^^^^^^^^^^
> 
> The Fixes tag references commit f0334294a428, which does not exist in
> this repository. Should this be:
> 
>   Fixes: 5bf02dbf39fa ("bpf, x86: Make sure allocation in arch_bpf_trampoline_size() is writable")

Argh, checked the log on a wrong branch.

Can you folks fix it up when applying or you'd need v3?
 
> That commit introduced bpf_jit_alloc_exec_rw() and the performance issue
> being addressed here.

-- 
Sincerely yours,
Mike.
