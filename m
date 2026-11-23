Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472775;
	b=mYm9oSy9DBKc9wzKw+dXj6+WPT+eQhlQpK03QCZkHgxQq+0XkitUucWF9M/vUmCDPdcL
	 Rrg2AnSjJMyvJVqOiqXUGJHji0zPVyjPhAUZVoqz5LTjNETCTSU1KBSkhnCAOBUS8pp0v
	 htRpNbpo3EsuGt8Y/OEVzYLLpAJhF6+bbCG0tz8h4v8kbpwYUocv7I54o1bV/4fSU2sfH
	 jeTr/iJtZUGjf+JZSxc8/MLs7A5d9TrZhzdX9oNeDjhV9HU668r+PrpupKj9bt4gdV4xt
	 gzD3jeqEgu0UDjgtVk+3dwf31S395QsQRQksT7nX/PC4QmeyT5ZJP7cqwRdGmlTRVHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472775;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=RSkMGfran+j3wslLs7o9UWNh2g3/zDkYgASDBOdDLmE=;
	b=PMBUEcAjH4Hou2qQxDAxh22G86zlAKxdFG92IbwwNgepSlYh033r1TVstC9pxiqAZZVC
	 c7ilFZOSBNabZUtW4kIBgIfSv2pFX+Q2369zat+jjoYlj/y3wq4U0rvk2TkXSPAvB83IJ
	 jKosX4ixxJNqpQujrbsPkNrZjU6E8nGlhoDmGI3aEWvhXXttko6C+QNhWYNILrAMgfIwb
	 FoQ62Nl0KJm9i10EH4lBa9GXQ2h6WGG4yp7MZ4Ir+ib/Myph/o3w/JMoF3QBuNA50R20V
	 rmAcQZ1hwGCaX0dtezxsXLlwcHYO9Pg4T51qB3nYj+KtRVCExIHRZZcKdpNMOCGDDKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmO4tu9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AFE606A322
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmO4tu9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEE1F000C4;
	Mon, 23 Nov 2026 22:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472774;
	bh=RSkMGfran+j3wslLs7o9UWNh2g3/zDkYgASDBOdDLmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lmO4tu9RkkKRfhcRVLaYlXtMF4PBf+2VLKmGK6JOnpRwU+86PTX7v4gAKonK2iaxZ
	 KLC0WrypZBSu+HKPGx4Gp918VUGirq10hSdWt56PnKBGuLY8PPRICPSQeln/YbH9pU
	 TwQ/OhOxPMZYo26sLtarupOfmfKEXXtzhDw/wPWWph5f0EzfK1uPvKQ+x2XziLT/F9
	 QGlEStmFKdbsjeZu2rSYl5KTR18funGIkPgmMLtdBUL04x+ciZcQMENJ2Co9UpU/nd
	 i7NNTSjvkxYAc0kbP7MQ3O/xZ2E8J28WOwXBb/TZAzOKrxuBnOVmnkIUbyb0E3GSo6
	 ulJFMN97i6HIA==
Message-ID: <dbf929f8-5ff9-43ec-9eb3-380936ea6568@kernel.org>
Date: Mon, 23 Nov 2026 22:26:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for
 LLVM 24 in text_mc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, a.s.protopopov@gmail.com,
 bpf@vger.kernel.org
References: <20261118194030.4103149-1-almagui@kernel.org>
 <DMYT224YKW0Z.2NAT6FTR68NQE@gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <DMYT224YKW0Z.2NAT6FTR68NQE@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 1:44 AM, Alexei Starovoitov wrote:
> On Wed, Nov 18, 2026 at 11:40 AM Alan Maguire <almagui@kernel.org> wrote:
>>  		if (it == by_name.end()) {
>> +			if (pattern->optional)
>> +				continue;
>>  			error() << "no opcode " << pattern->opcode << "\n";
>>  			ok = false;
> 
> Thanks for the quick fix. Applied.
> 
> But should we go further and skip unknown names? Like:

It works for me, fixing the original issue, so if you want to apply 
it feel free to add

Tested-by: Alan Maguire <almagui@kernel.org>

The optional approach that's in-tree currently maybe gives a bit more 
up-front diagnostic info for failures, but either approach works for me.
Thanks!
 > 
> diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
> index 57f45a4..bfe9824 100644
> --- a/tools/bpf/resolve_btfids/text_mc.cpp
> +++ b/tools/bpf/resolve_btfids/text_mc.cpp
> @@ -165,10 +165,9 @@ bool read_regs()
>  	return ok;
>  }
>  
> -bool read_opcodes()
> +void read_opcodes()
>  {
>  	std::unordered_map<std::string_view, Opcode *> by_name;
> -	bool ok = true;
>  
>  	d.opcodes.resize(d.MII->getNumOpcodes());
>  	by_name.reserve(d.opcodes.size());
> @@ -194,10 +193,9 @@ bool read_opcodes()
>  	for (const mc_pattern *pattern = mc_arch.patterns; pattern->opcode; pattern++) {
>  		auto it = by_name.find(pattern->opcode);
>  
> -		if (it == by_name.end()) {
> -			error() << "no opcode " << pattern->opcode << "\n";
> -			ok = false;
> -		} else if (pattern->kind == TEXT_RETURN) {
> +		if (it == by_name.end())
> +			continue;
> +		if (pattern->kind == TEXT_RETURN) {
>  			it->second->is_return = true;
>  		} else if (pattern->kind != TEXT_OTHER) {
>  			it->second->patterns.push_back(pattern);
> @@ -208,7 +206,6 @@ bool read_opcodes()
>  				it->second->nop = pattern;
>  		}
>  	}
> -	return ok;
>  }
>  
>  const Reg &reg_of(const MCInst &inst, const Opcode &o, u8 nr, bool def)
> @@ -422,12 +419,16 @@ bool run_tests()
>  extern "C" const struct text_arch *text_arch_init(unsigned int machine)
>  {
>  	static text_arch arch = mc_arch.arch;
> +	bool ok;
>  
>  	if (machine != mc_arch.machine) {
>  		errs() << "text_mc: built for " << mc_arch.triple << ", not for ELF machine " << machine << "\n";
>  		return nullptr;
>  	}
> -	if (!create() || !read_regs() || !read_opcodes() || !run_tests()) {
> +	ok = create() && read_regs();
> +	if (ok)
> +		read_opcodes();
> +	if (!ok || !run_tests()) {
>  		error() << "the table of the arch does not fit it. Set LLVM_CONFIG to the "
>  			   "llvm-config of another LLVM, or switch CONFIG_BPF_FMODRET_SCAN off\n";
>  		return nullptr;
> diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
> index f2add1f..914a00a 100644
> --- a/tools/bpf/resolve_btfids/text_mc.h
> +++ b/tools/bpf/resolve_btfids/text_mc.h
> @@ -13,8 +13,9 @@
>   * It does not say what an instruction computes: the selection patterns are not
>   * a part of it. And the headers with the enums of a target are not installed.
>   * So opcodes and registers are given by name, as MCInstrInfo::getName() and
> - * MCRegisterInfo::getName() return them, and looked up once. A name which this
> - * LLVM does not have is an error.
> + * MCRegisterInfo::getName() return them, and looked up once. A register which
> + * this LLVM does not have is an error. A pattern for an opcode which it does
> + * not have is left out: each pattern has a test, which fails if it is missed.
>   */
>  
>  /* A condition on the operands of an MCInst, like an MCInstPredicate of TableGen */
> diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
> index 5d2fa8a..31ca6e0 100644
> --- a/tools/bpf/resolve_btfids/text_mc_arm64.c
> +++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
> @@ -25,6 +25,7 @@ static const struct mc_pattern arm64_patterns[] = {
>  	/* HINT: nop, bti, yield, wfe ... */
>  	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
>  	{ "HINT", TEXT_OTHER, .nop = true, .predicates = { IMM(0, 0) } },	/* nop */
> +	{ "NOP", TEXT_OTHER, .nop = true },	/* nop since llvm-project PR 170968 */
>  	{ "DMB", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },
>  	{ "STLRB", TEXT_OTHER }, { "STLRW", TEXT_OTHER },
>  	WX("LDXR", "", TEXT_OTHER), WX("STXR", "", TEXT_OTHER), WX("STLXR", "", TEXT_OTHER),

