Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09C9486BBD
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787156111; cv=none; b=gPMLZXpqMSWbR8txj4CxxncAEKYIuna/f9rMAB5zYRU/2CBB413wbANODerJgxxuuBjO2RDvywEedK8YDDEgKE89WhZ8TQXMvI2h9rIhHbB14kUIG52/wEP1C1PsHQrBqmkjCaS7J0/3RUNlcXdNmVPZOX6cQRH8iftLh8k5xXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787156111; c=relaxed/simple;
	bh=f9u+yL71Tek+uEya1sp3xd1dGDQFvPraHg1L8a6CrWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpVkFj+HZM9h1FV/+VkkMxtk/aB+EgCBkKp7DORlWzoIIm7xFa35Koi1sQ2TqSp7IRuQYlz0ILP8y+er7MEdXGqid/qJVlpeOXYw10tIcgRTEErOUNPwtXtUtOjdVAk0L4HygfVhpJEEcuGAG16WVSl+R+1E+p7TdSabRgyOO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xdY2UDUz; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xdY2UDUz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f9u+yL71Tek+uEya1sp3xd1dGDQFvPraHg1L8a6CrWo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787156106; v=1; x=1787760906;
 b=xdY2UDUzmS6sLQf+zcPWkmlhDY0VhFjWpgUk3xTXXD3krCBAsEEs5KnrtRywWu1nEUT6So0i
 lZwo2B6OK/DxSeouxqQi9Omc7R+2jPh8HjFHBlrIoNNznI0/URy5Ig9Ckh9iTr7hK8T8PDIH8d3
 zXD9XvtiPnGQQQxt7E3zSEHQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id db50bc5d2279d7e2;
	Wed, 19 Aug 2026 16:15:05 +0000
X-Mizu-Trace-ID: db50bc5d2279d7e2
X-Migadu-Flow: FLOW_OUT
Message-ID: <edd7ac42-0b2f-4a72-8cb0-ba169a6f22c9@linux.dev>
Date: Wed, 19 Aug 2026 09:15:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 08/10] selftests/bpf: Add C tests for 16-byte
 returns in R0:R2
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260819055320.3300114-1-yonghong.song@linux.dev>
 <057ae35eeaccbbb9dc187bb5edbf0b29c974dab9bf2142c2ff924c12e9e21db4@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <057ae35eeaccbbb9dc187bb5edbf0b29c974dab9bf2142c2ff924c12e9e21db4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:49 PM, bot+bpf-ci@kernel.org wrote:
>> Add selftests that exercise a 16-byte return value passed in the R0:R2
>> register pair, written in C so that they depend on the compiler lowering
>> the register-pair return.
>>
>> The R0:R2 convention is only emitted by LLVM 23 and newer, and a by-value
>> aggregate return does not compile at all before that, so the programs sit
>> behind a __clang_major__ guard. An older compiler builds the dummy test in
>> the #else branch instead, which keeps the object non-empty and says in its
>> description why nothing was exercised.
>>
>> The kfunc tests are tagged __arch_x86_64/__arch_arm64 and skip elsewhere.
>> Those are the architectures whose JIT advertises
>> bpf_jit_supports_kfunc_ret_reg_pair(), which bpf_add_kfunc_call() requires
>> before it accepts a kfunc returning more than 8 bytes, and they are also
>> the only ones building the kfuncs.
> The changelog states that x86_64 and arm64 are "the architectures whose
> JIT advertises bpf_jit_supports_kfunc_ret_reg_pair()". Is this accurate?
>
> Looking at commit 4b4530101f35 ("bpf: Wire up JIT support for 16-byte
> kfunc returns"), the first patch of this same series, it adds
> bpf_jit_supports_kfunc_ret_reg_pair() returning true to three JITs, not
> two:
>
>    arch/x86/net/bpf_jit_comp.c       bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }
>    arch/arm64/net/bpf_jit_comp.c     bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }
>    arch/riscv/net/bpf_jit_comp64.c   bool bpf_jit_supports_kfunc_ret_reg_pair(void) { return true; }
>
> and its own changelog says so explicitly: "Only the x86-64, arm64 and
> riscv64 JITs opt in so far." kernel/bpf/core.c keeps the __weak default
> at false for everything else.
>
> Stating the JIT capability as the reason for the architecture tagging
> misleads a reader into believing riscv64 has no R0:R2 JIT support,
> which is the opposite of what the series does.

We are fine. I didn't add riscv64 selftest. As mentioned in
    bpf: Wire up JIT support for 16-byte kfunc returns
riscv64 is not tested.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339

