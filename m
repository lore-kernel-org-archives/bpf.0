Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795721754;
	b=T3Le093vwMGIzr4C2kLvgT5BRtd/9w6+/8OcwTIpn7MnlxVmLwG8NevLY2rkkWMYQabv
	 pmNAwd5d/45Rjqfomlkm6qD15E37o0qGWXp0vH8SOPUCQhyupBNwEzHWTQnhYElyRZ+gC
	 ujGz9lxFRX05PbQNoijedTWjiQRlOXQUajBSoZUoH4dApRKKgenFHDpevuPkV6rte7TsR
	 l4w7xXfJc2qzSN6Sy8RJEilBjp5Wj3USiu3pYakMdNG9EQUz1TdBg/iqJoYV4WKjvsNRv
	 En7npG56JeTTDawkIRniIgno9VtLxg3lh6QbvX7KXZR5nsIoA8AhBdpGz9oGs2Kr/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795721754;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Cr1ILRgs8ZUdAXciHMSDpnnf5jBEtObzeMiER0D/S0o=;
	b=MCrTGEZqB9MZChiIEGfZhhjTN9np5B+JTfLhaGNS1R8LXtjFH+bLEFaiUzggaqlK/dMO
	 akGe14aNw2ZWtMCvca7GAAIJi9aAN/ZtDydyNK8KNarNNJxobYRNz1kbPNGN1IfZX5Pv0
	 wMmGyt9613vWDtBZja+Po+vtyblFS3NjLyA/fOpsnSUn6rzY8r9ad5fe4S859jc1PTk5S
	 gIHALoDPtiSZzXzw0CqEnpYO4ErKYFN23G3Uo6Pm3VTMBg9uclqbqD1HdV+Z2SVXMHthU
	 RGfNkjTRZMbwuu2gsMC4PiQh9eP4cLqD+gDT7x47KKx+KxbMmOtxJs+MthbpT+rCYwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mOAgsGK2;
	arc=none smtp.remote-ip=95.215.58.227
Received: from mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54A606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 19:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B54A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mOAgsGK2
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=tOn7o6D230EwWW3ZzRNubWzSgq9j0czih7VpwrFm48w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795721751; v=1; x=1796326551;
 b=mOAgsGK26qgcO31Ucd9NG2Eoh2Thm9T3sdOLh2p350aXrFpkG/fznAxIHqnJvq86HgvtbNgc
 pmhcVxmH4XTiZdyaeLdQjyjTDv8AxAwbYu8pl3qAfeZtOVMCLHew+0IiPTQ8V6GgKVMHHJ0TTsz
 +lL1sWJwmstICxaUvKt+FLOg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a35781529f35255c;
	Thu, 26 Nov 2026 19:35:39 +0000
X-Mizu-Trace-ID: a35781529f35255c
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d2c8268-0ad4-4f39-80e9-ba9393d88f15@linux.dev>
Date: Thu, 26 Nov 2026 11:35:34 -0800
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
Subject: Re: [PATCH bpf-next 1/3] libbpf: Poison an enum value relocation out
 of the local enumerator range
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20261126175607.1883240-1-yonghong.song@linux.dev>
 <2c14a84ab2ca76b12c34e5be65c4e51a969151f0c831386519a47a9c6245671b@mail.kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2c14a84ab2ca76b12c34e5be65c4e51a969151f0c831386519a47a9c6245671b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/26 10:36 AM, bot+bpf-ci@kernel.org wrote:
>> libbpf: Poison an enum value relocation out of the local enumerator range
> TL;DR: Possible wrong behaviour in relo_core.c: enum value relocations may be
> wrongly poisoned when target BTF lacks the kflag (pre-6.0 kernels) and
> negative enumerators, so valid programs could fail to load.

Please take a look at commit 6036922777d3 or
    https://lore.kernel.org/all/20261124000514.2955878-1-yonghong.song@linux.dev/
We do assume that kflag 0 is taken as unsigned.

>
>> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
>> --- a/tools/lib/bpf/relo_core.c
>> +++ b/tools/lib/bpf/relo_core.c
> [ ... ]
>
>> +static bool bpf_core_enum_val_fits_int(__u64 val, bool val_signed)
>> +{
>> +	return val_signed ? (__s64)val == (__s32)val : val <= INT_MAX;
>> +}
> [ ... ]
>
>> +	local_t = btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id);
>> +	targ_t = btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
>> +	local_signed = BTF_INFO_KFLAG(local_t->info);
>> +	targ_signed = BTF_INFO_KFLAG(targ_t->info);
>> +
>> +	if (bpf_core_enum_fits_int(local_t)) {
>> +		type = "int";
>> +		fits = bpf_core_enum_val_fits_int(targ_val, targ_signed);
>> +	} else if (local_t->size == 4) {
>> +		type = "unsigned int";
>> +		/* a negative value is sign-extended, so it is also too big */
>> +		fits = targ_val <= UINT_MAX;
> Can this reject valid programs when the target BTF has no kflag on a signed
> enum?
>
> Before commit 6089fb325cf7 ("bpf: Add btf enum64 support"),
> btf_enum_check_meta() rejected any BTF_KIND_ENUM with kind_flag set, so
> vmlinux and module BTF from pre-6.0 kernels (and from kernels built with
> pahole older than 1.24) have kflag == 0 and store negative enumerators as
> their u32 bit pattern.
>
> For kflag == 0, bpf_core_enum_val() returns (__u32)e->val, so a target
> enumerator of -1 becomes targ_val = 0xffffffff with targ_signed = false.
>
> Consider a local enum such as enum perf_event_state from a modern
> vmlinux.h, where PERF_EVENT_STATE_OFF = -1, running on a 5.x kernel:
>
>      bpf_core_enum_fits_int(local_t)                 -> true
>      bpf_core_enum_val_fits_int(0xffffffff, false)   -> 0xffffffff <= INT_MAX
>                                                         -> false
>
> The relocation is poisoned and the program fails to load if the
> instruction is reachable.  Before this patch the ld_imm64 got 0xffffffff,
> which truncates to the correct -1 in an int context such as:
>
>      int x = bpf_core_enum_value(enum perf_event_state,
>                                  PERF_EVENT_STATE_OFF);
>
> The mirror case also looks affected.  If the local enum comes from a
> vmlinux.h generated on an old kernel, btf_dump prints the kflag == 0
> values with %u (e.g. PERF_EVENT_STATE_OFF = 4294967295), so the local
> enum is a 4-byte unsigned enum.  On a 6.0+ kernel with kflag set, targ_val
> is 0xffffffffffffffff, which fails "targ_val <= UINT_MAX" and is
> poisoned, where bpf_core_enum_value() previously returned the kernel's -1.
>
> The commit message says pahole sets the kflag for a signed enum since
> v1.24, "the minimum version now required for kernel BTF".  Doesn't that
> only cover kernels built from this tree, rather than the older running
> kernels that CO-RE targets?
>
> The selftests added later in the series appear to use only target BTF
> compiled by a modern clang that sets kflag, so they would not exercise
> this.
>
> Would it make sense to judge a 4-byte BTF_KIND_ENUM target without kflag
> by its low 32 bits, accepting the value if it fits as either int or
> unsigned int against a 32-bit local enumerator?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45873143557

