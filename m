Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D1390601
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461293; cv=none; b=AM8akp/ukXk3i8FAPfJjf/B+88sEb8YpVdCZ8NMYxaGPqzHvaz8s7Dd2t8Og0F5XH6wX6zQKDhCkuN77VdN22cEfqgnKvkblEMXsaxh7OT8QKd+B7HHANH07edTaBvm0Fo3Nx8EMkJwHESE1/B+LyckUMcWoTb/GtNSJU9eIEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461293; c=relaxed/simple;
	bh=VITpEH6gzFIOy/9XF1GYOOTHwaAhB+5bcPCwrHw1c50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNFvt/HmlpMmkIdgTVrDG6nE3hPyfnn4gjQZN8Eidkyl98JuRTIeTIebm/cs1ciTtA65xsoNN/M1F5t0vl6nMoXsq+ZPWFXWYLyhzalYY5PkJJv0VMbABt/+obDb8wQFBoqyfKxRjJ8UvpxcSr08aA9/kDpH9auc2CFF0xqh0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Y9oDgQ32; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Y9oDgQ32"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NmNv2gG8wyZjbPbfvoUEW0FkSaSsva2qKSAd8NzJoJQ=; b=Y9oDgQ323NDfvf9/kCYfFP67yA
	MxIITbYBmViHbRjTbjDtSTK7I6jwJyu86CizQcy85J/IZbhqS3wpXGNbettYcI8iHgM7ZZZBJVEo0
	6Z7K7Gv/+dztMe85DGe4rl6aBtlpATS/blxPiez7yO9fnS6J+t8tAW2OngUlzbi2skPhbfhz6aM4+
	UHBeg+FAwr+8LflyHOTmXNm4IPrMVeXpMf/HXx4TqbkC+BtC5j6aqqVtlw3QDsPaI6OHOekzOck14
	rIt+mWjpPj8FRRAIVC8GQf9sJoUsQtkGmY/sP5gFv83/CqIMGviFRN21QwwlQILJ1Jt8ewQzBXbbe
	jUZZlR4Q==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtoBe-0007cx-2c;
	Tue, 11 Aug 2026 17:14:42 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtoAg-000AZy-0f;
	Tue, 11 Aug 2026 17:13:42 +0200
Message-ID: <0045615c-fbff-44fb-a366-9f1a5dd29308@iogearbox.net>
Date: Tue, 11 Aug 2026 17:14:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add arena fault tests for
 atomics with fetch
To: bot+bpf-ci@kernel.org, memxor@gmail.com
Cc: eddyz87@gmail.com, puranjay@kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260811131600.506721-6-daniel@iogearbox.net>
 <94cf180b432f9d5d15a198285273f2ad57426e16855ff584da1c40519a93c4cd@mail.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <94cf180b432f9d5d15a198285273f2ad57426e16855ff584da1c40519a93c4cd@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

On 8/11/26 4:27 PM, bot+bpf-ci@kernel.org wrote:
[...]
>> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
>> --- a/tools/testing/selftests/bpf/progs/stream.c
>> +++ b/tools/testing/selftests/bpf/progs/stream.c
>> @@ -229,6 +229,107 @@ int stream_arena_load_acquire_fault(void *ctx)
>>   	return val;
>>   }
>>
>> +SEC("syscall")
>> +__arch_x86_64
>> +__arch_arm64
>> +__success __retval(0)
>> +__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
> 
> The series includes fixes for four JITs (x86, arm64, riscv, s390), but
> these new programs only cover two of them. Could __arch_riscv64 and
> __arch_s390x variants be added for the other half?

Hm, so the __arch gate is forced by __stderr() and bpf_prog_report_arena_violation()
currently only has callers in the x86-64 and arm64 ex handlers. I'd leave
as-is for now.

[...]
> But the __retval(0) half does not depend on arena violation reporting.
> A variant tagged __arch_riscv64 __arch_s390x with __success __retval(0)
> and no __stderr() would exercise exactly the register-clear fix those two
> commits make, using the same poison-and-return mechanism. As written, two
> of the four fixed JITs ship with no test coverage.
> 
>> +__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
>> +__stderr("Call trace:\n"
>> +"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> +"|[ \t]+[^\n]+\n)*}}")
>> +int stream_arena_xchg_fault(void *ctx)
>> +{
>> +	static const struct bpf_insn xchg_insn = {
>> +		.code	 = 0xc3,	/* BPF_STX | BPF_ATOMIC | BPF_W */
>> +		.dst_reg = 1,		/* BPF_REG_1 */
>> +		.src_reg = 2,		/* BPF_REG_2 */
>> +		.off	 = 0x7fff,
>> +		.imm	 = 0xe1,	/* BPF_XCHG */
>> +	};
> 
> Does the misaligned .off = 0x7fff cause the test to validate a different
> fault path on arm64 than the commit message describes?
> 
> user_vm_start is page aligned, so the effective address is
> user_vm_start + 0x7fff, which is 3 mod 4. The 4-byte BPF_W access also
> straddles the page boundary at 0x8000.
> 
> For plain LDR/STR (stream_arena_read_fault, stream_arena_write_fault),
> this offset works as intended: arm64 permits unaligned access with
> SCTLR_EL1.A=0, so those really do take a translation fault on the unmapped
> page.
> 
> But atomics require natural alignment. arm64 LSE CAS/SWP raise an EL1
> Alignment fault (ESR FSC 0b100001) when the access is misaligned or crosses
> a 16-byte granule, and that takes priority over the translation fault.
> 
> The test still passes - fixup_exception() in arch/arm64/mm/fault.c runs
> before any die_kernel_fault path, so ex_handler_bpf() still clears the
> fetch register and still prints "Arena WRITE access at unmapped address".
> The fix under test is fault-type independent.
> 
> But the arm64 arm of both new subtests validates the alignment-fault path
> rather than the unmapped-arena-page path, while x86-64 (where page fault
> is delivered ahead of split-lock alignment check) validates the intended
> one, so the two architectures end up testing different code paths.
> 
> A 4-byte-aligned offset inside the unmapped page (e.g. 0x7ffc) would keep
> the fault a translation fault on both architectures. The pre-existing
> stream_arena_load_acquire_fault has the same property with its 0x7fff.

For the sake of what we test here, I'd leave as-is since the fault type
doesn't really matter here but rather the fact that we match on arena WRITE
plus the register clear.

> [ ... ]
> 
>> +	return val;
>> +}
>> +
>> +SEC("syscall")
>> +__arch_x86_64
>> +__arch_arm64
> 
> A subsystem pattern flags this as potentially concerning: On arm64 these
> two programs only load on CPUs that implement LSE atomics, and nothing in
> the test gates on that.
Hm, not relevant for upstream BPF CI given green as can be seen, but I can
look into that if desired.
