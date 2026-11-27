Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763507;
	b=kGtuN66RxQp86Nz36tpJQQhdREMUQV3IJTk12kCYdfdTNyryKfiBFJ6zR9ZqGakHt0Ul
	 HKr0wYyrHfSr+lVOJlOFHoyx3JAXSc/Y553ZjNmiuru3uau7ygQRp9QjPr+mpqyd6cXCy
	 GZAWmkaR1VU2LqgEKGT9JGkYHYtXCBcMZOX8nZA7Tz6UXbf9z4xZ7jZ+dSg0Wz0N96f7k
	 3k7jjkOzXUdi8s7Ud42dkRHhbXAJ7e8zj3B7g/bL9uzOzZg2he9j5K9dPNcojdC1AImeO
	 S594CZCm0K12IQbXmOLxYblQCjLugPLPAvqmYm1BbTdAMcY4oKOCY7432lY2KC+9bBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763507;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ez9s0vmDLfD0TjdlcRV+T0MXEoY3emq6kIWpbAaGW60=;
	b=nG07y9fA/nugI+Aam05DyYYyng7S5a3KAXMIe3szDtj4n7l7JCvlCqPJ869Mq1+HH06b
	 ikfiZYNwNbXMUEiTIh/YCJCqjGqnRgSmWM8TYle+mrObCd7wfcAhm7O/TkixesFJuEmAL
	 vnvTDpkn6gOaH90rtXSCQiucbkvOp6mmAhITad3AR3hLoG7gPxr2uOS/wYYLoFO3VoviP
	 cv4L/ZB4HiWcIfmrL6Ff6tXd6+zyX7NDKAPfWmTZeT6f3xGWYYMGznL3jMQDCmL+nQUQr
	 co34XRh+uH1BkGnBreGxPq6qoU0zfcCrrxQqk7RxKof6P15X44UFxmV0IftybQ/P+2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k1nZvzcl;
	arc=none smtp.remote-ip=91.218.175.179
Received: from mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D6606A31C
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 07:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 170D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k1nZvzcl
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FE7rEG4y+GPIIMU8xwfZHvDP6YOGluopin5bzc2zGhc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795763504; v=1; x=1796368304;
 b=k1nZvzcloZz6tPMmCQWaryQUlmFK30RgQi9qkZ872CCwKC9dLcqLYvRkq0mHyf/DKGuIdBLl
 8HXLZfw6761FXXJGauH15hDvB85DYM7y34PmHH+h7xSjqWL7JI8pme4v1w1G4IAKmlekjiBcGUK
 w2T6bW3cWFyqjUvwi3jHSUFg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f8cc86cfa9e7ed37;
	Fri, 27 Nov 2026 07:11:44 +0000
X-Mizu-Trace-ID: f8cc86cfa9e7ed37
X-Migadu-Flow: FLOW_OUT
Message-ID: <bd3834d3-568e-4ab6-884d-c1ff39e3cb5c@linux.dev>
Date: Thu, 26 Nov 2026 23:11:40 -0800
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261126175602.1882988-1-yonghong.song@linux.dev>
 <20261126175607.1883240-1-yonghong.song@linux.dev>
 <DN5F6AJVK33K.25IJTI12XHRKN@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DN5F6AJVK33K.25IJTI12XHRKN@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/26/26 12:20 PM, Alexei Starovoitov wrote:
> On Thu, Nov 26, 2026 at 09:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> So a program is only rejected if the poisoned instruction is reachable.
>>
>> This also applies to bpf_core_enum_value(), since libbpf cannot tell the
>> two forms apart. A program like g() above, which could use a target
>> value out of the range of the local enumerator type before, is now
>> rejected if the instruction is reachable. Document this in
>> bpf_core_read.h.
> The usual guard doesn't make it unreachable.
> bpf_core_enum_value_exists() returns 1 here.
> I think this takes back what your commit 776281652ddc allowed.
> The local value is often a placeholder, like in profiler.inc.h:
>
>    pids_cgrp_id___local = 123, /* value doesn't matter */
>
> What bpf_core_enum_value() gets today and with the patch:
>
>    local enumerator                   target       today       patch
>    ---------------------------------  -----------  ----------  --------
>    SCX_ENQ_PREEMPT___local = 0        1ULL << 32   1ULL << 32  poisoned
>    PERF_EVENT_STATE_OFF = -1          -1, kflag 0  0xffffffff  poisoned
>    PERF_EVENT_STATE_OFF = 4294967295  -1, kflag 1  -1          poisoned
>
> Row 2 runs on v5.15. Before commit 4fad237494f1 it got -1.
> Row 3 has vmlinux.h of v5.15 and runs on bpf-next.
> The kernel builds relo_core.c too.
> A light skeleton with row 1 stops loading after a kernel upgrade.

Indeed, looks like based on local enumerator to imply the expected value range
is incorrect.

>
>> The target value is taken as signed or unsigned according to the kflag
>> of the target enum, which pahole sets for a signed enum since v1.24, the
>> minimum version now required for kernel BTF.
> That covers new kernels only.
> Before v6.0 btf_enum_check_meta() refuses an enum with kflag.
> Row 2 ends up in:
>
>    val <= INT_MAX        val = 0xffffffff, val_signed = 0
>
> Code like f2() gets -1 there today, since s>>= restores the sign.
> So the attribute form fails to load too, and its value is correct.

My current implementation assumes >= v6.0 kernel and it may indeed
reject some cases for < v6.0 kernel.

>
>> +/*
>> + * As in C, the enumerators of an enum have type int if all values of the enum
>> + * fit in int, even for a 1-byte enum made with the packed or mode(byte)
>> + * attribute, and otherwise the type of the enum, which is then 4 or 8 bytes.
>> + */
>> +static bool bpf_core_enum_fits_int(const struct btf_type *t)
> Not with a fixed underlying type. sizeof(N) is 8 with clang 21:
>
>    enum E : unsigned long { N = 10 };
>
> This function says int, and 0x100000000 gets poisoned.
> BTF doesn't have the type of the enumerator. The compiler has it.
>
> can clang emit mov for 32-bit enumerators, like for field relos ?
>
>    enumerator    insn
>    ------------  ---------------
>    int           r0 = 0xa
>    unsigned int  w0 = 0x80000000
>    long          r0 = 0xa ll

I remembered that we discussed this before during implementing
llvm commit c080a0b9b673e ([BPF] Support preserve_access_index attribute for enum (#232498)).
We briefly discussed whether we should do 'w0 = ...' or 'r0 = ...'
although eventually we used 'r0 = 0xa ll' style.

Looks like we do need to use 'r0/w0 = ...' style too. This will
gate the value in tight range to simplify libbpf.

>
> bpf_core_enum_value() keeps ld_imm64 and works as before.
> bpf_core_patch_insn() patches ALU imm already, without a range check.
> With mov the diff poisons all three examples from the log.
> Rows 2 and 3 load in both forms.
> The diff skips the sign of a long and fixed types of 1 and 2 bytes.
> No need for bpf_core_check_enumval_range(), bpf_core_enum_fits_int(),
> and for the shifts in f2() and f3().
>
> relo_core.c in place of patch 1, compiles for libbpf and kernel, not run:
>
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 58c782c..b2c8632 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -1031,6 +1031,20 @@ static int insn_bytes_to_bpf_size(__u32 sz)
>   	}
>   }
>   
> +/*
> + * ALU zero-extends imm, ALU64 sign-extends it. BTF before v6.0 has no sign of
> + * an enum, so accept both forms when bit 31 of the local value is set.
> + */
> +static bool insn_imm_fits(const struct bpf_insn *insn, __u64 val)
> +{
> +	bool zext = val == (__u32)val;
> +	bool sext = (__s64)val == (__s32)val;
> +
> +	if (insn->imm < 0)
> +		return zext || sext;
> +	return BPF_CLASS(insn->code) == BPF_ALU ? zext : sext;
> +}
> +
>   /*
>    * Patch relocatable BPF instruction.
>    *
> @@ -1067,13 +1081,18 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>   			goto bad_insn;
>   		if (res->poison)
>   			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
> -		if (res->validate && insn->imm != orig_val) {
> +		if (res->validate && insn->imm != (__s32)orig_val) {
>   			pr_warn("prog '%s': relo #%d: unexpected insn #%d (ALU/ALU64) value: got %d, exp %llu -> %llu\n",
>   				prog_name, relo_idx,
>   				insn_idx, insn->imm, (unsigned long long)orig_val,
>   				(unsigned long long)new_val);
>   			return -EINVAL;
>   		}
> +		if (!insn_imm_fits(insn, new_val)) {
> +			pr_warn("prog '%s': relo #%d: insn #%d (ALU/ALU64) value out of range: 0x%llx\n",
> +				prog_name, relo_idx, insn_idx, (unsigned long long)new_val);
> +			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
> +		}
>   		orig_val = insn->imm;
>   		insn->imm = new_val;
>   		pr_debug("prog '%s': relo #%d: patched insn #%d (ALU/ALU64) imm %llu -> %llu\n",

I will work on llvm as soon as possible. The above diff looks correct
if llvm side with 'w0/r0 = ...' for relocation.

>
> pw-bot: cr

