Received: from mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64F34CFC6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564910; cv=none; b=Ucuw7Bhj5pd2nPWSAKNFfj0WbzyOKU7K0z2rc1AITA1qajvwbdgB2/RjzTWSYCkwXpL6OGhcQGUdsBrT9yEqhDS5S4HIOwfqI5qP5w1QQCQtf0r3UzM2bpJCsLcNucP3Z4sfVkrvtLzj3+VUEBzp7u8ShMw1kbaNWnwX33uZ4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564910; c=relaxed/simple;
	bh=HzLQm8yceXsU5YEI2nQ/qHhRGvX9rm0DubbnNySS5yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufcBcFEs4gZNkui/MJugV/Ldf7HSvZ9yHjaRjvASIBBgGiE4ak3soICw9Z/qZwcJ6Ktv4o00fPbEkMa3madTiPvnls0ZQuG8zQNu3gv14tfTMiWCB8bqdtjNbJMyhUApqSckeuCmCoUgeUd71Ilh1rtpCLwp7DY9yeyfoBSHPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g9D90MrY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g9D90MrY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HzLQm8yceXsU5YEI2nQ/qHhRGvX9rm0DubbnNySS5yI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791564907; v=1; x=1792169707;
 b=g9D90MrYOTnWJhSxszRCRf0Kz2Sj1SnNT5dfigiqgIhpZtW0s3hh9XlpqqQFAGn68QXlfied
 w+n8ThrSXlw3pfiGM2Ew8f1lLYyNlvHbDPKyhTGYnbw3RIw1/HaUUSQ4/MyRORulRwb35QXB1bV
 ko9bCBNDjPwdhPyCLSNUFoF4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9c78e18c0828b795;
	Fri, 09 Oct 2026 16:55:06 +0000
X-Mizu-Trace-ID: 9c78e18c0828b795
X-Migadu-Flow: FLOW_OUT
Message-ID: <6b77fcc9-93d0-47e6-be94-6087fa96e2ee@linux.dev>
Date: Fri, 9 Oct 2026 18:55:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v10 15/24] bpf, arm64: Dispatch exception cleanup
 pads at run time
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041605.33513-1-yonghong.song@linux.dev>
 <sashiko-outbox-164834@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-164834@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/26 6:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] arm64/bpf: PAC modifier mismatch for bpf_throw's C frame causes FPAC panic
> --
>
> commit 2f751c03b321c9d53d97196968f653cf6c3fa289
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf, arm64: Dispatch exception cleanup pads at run time
>
> This commit adds arm64 support for unwinding BPF frames and redirecting
> their return addresses to cleanup pads. It signs the modified return
> addresses using PAC when address authentication is enabled.
>
>> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
>> index 3ebcf8c53fb04..56d1310eca323 100644
>> --- a/arch/arm64/kernel/stacktrace.c
>> +++ b/arch/arm64/kernel/stacktrace.c
> [ ... ]
>
>> +/* PACIASP's modifier is the entry sp, record + 16 for a BPF prologue. */
>> +static void bpf_unwind_store_ra(unsigned long record, u64 ra)
>> +{
>> +	struct frame_record *rec = (struct frame_record *)record;
>> +
>> +	/*
>> +	 * Whether the slot holds a signed address is a property of the build,
>> +	 * not one to be read off the value: a PAC can come out equal to the
>> +	 * bits stripping puts back, and a signed address would then be taken
>> +	 * for an unsigned one. What signs is CONFIG_ARM64_PTR_AUTH_KERNEL --
>> +	 * the prologue here, and -mbranch-protection for everything the
>> +	 * compiler emits.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) &&
>> +	    system_supports_address_auth())
>> +		ra = bpf_unwind_sign_ra(ra, record + sizeof(struct frame_record));
> [Severity: High]
> Will this hardcoded PAC modifier cause an FPAC panic when returning from
> bpf_throw()?

bpf_throw() cannot go together with bpf_unwind().

>
> The unwinder uses bpf_unwind_store_ra() to redirect the return address for
> the first BPF frame. The caller of this first BPF frame is the C function
> bpf_throw().
>
> While record + sizeof(struct frame_record) correctly assumes a strict BPF
> JIT prologue where the entry SP is FP + 16, bpf_throw() is a compiled C
> function. Its actual frame size is compiler-dependent and may be larger
> than 16 bytes due to local variables.
>
> When bpf_throw() returns, its epilogue will authenticate the return address
> using its actual entry SP. If we sign it here using FP + 16 instead of the
> actual entry SP, could authentication fail and trigger a kernel panic on
> PAC-enabled kernels?
>
>> +	WRITE_ONCE(rec->lr, ra);
>> +}
> [ ... ]
>

