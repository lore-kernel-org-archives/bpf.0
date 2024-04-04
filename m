Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCE12CD9C
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255326; cv=none; b=kjwJErv39jMWegf4pQ+ZBh6xhZL87Su4i9T48ZCuoo4PUVSX5ODcDfxyV/kwyi1xkLtEj5vQt+dqlScX6JJZtUfypcsKmdwJRnEzy5/t+R3isbL0O+tAa2+a9JC2tUvTzGuOmaj3gIhoj9fGqMdUMBpT6DMrxBCKDsH6i1TizfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255326; c=relaxed/simple;
	bh=u+kQooBlZ4MiYDuSFf99+F5LvhAGenBM2gcRtO/aHD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4MM8Ep6bAeg7QPnZd6l9TKPTleh8OrA+vBbRZgH2cLWQJjkKqoHzJbWQ/s9aiZ/EjfTWyd7JlVlh+PwXhZl0rfOLU9IlBzrl+Xn5NG3UMn1lWIIOFLBBIsGrlrwDyjDFFARZU+LD/OrOnKnmAxv9KCfz4lL5GSdYx81G2rofu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pMqtNQZI; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pMqtNQZI"
Message-ID: <936229b3-ba4a-4c46-8042-977e5f069800@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712255321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeN6ktp3klWYakAXqC9ZclmVOuipiffJCEuydbZZdko=;
	b=pMqtNQZIfCVlqyopa3QOVOBsFk/6I0WiOfrhrmR4pgEU0C4Y0HDcIHXHj88PvMS0LF4m30
	3udVbY9U8Atg1X302tRwzfcWSRoBjTu4NcrmW0dXfG5K6+pqPvYlnwA2t597ASn8h4aAul
	HFEHKPpIlPO3DFw0MrFzhUl0zSYnidw=
Date: Thu, 4 Apr 2024 11:28:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 2/2] bpf: inline bpf_get_branch_snapshot()
 helper
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team
 <kernel-team@meta.com>, John Fastabend <john.fastabend@gmail.com>
References: <20240404002640.1774210-1-andrii@kernel.org>
 <20240404002640.1774210-3-andrii@kernel.org>
 <CAADnVQKc9QgOxvru-tqii0GO7H5+QD_=_v3O7_ant4BU1cNmKw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQKc9QgOxvru-tqii0GO7H5+QD_=_v3O7_ant4BU1cNmKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/4/24 11:14 AM, Alexei Starovoitov wrote:
> On Wed, Apr 3, 2024 at 5:27 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>> Inline bpf_get_branch_snapshot() helper using architecture-agnostic
>> inline BPF code which calls directly into underlying callback of
>> perf_snapshot_branch_stack static call. This callback is set early
>> during kernel initialization and is never updated or reset, so it's ok
>> to fetch actual implementation using static_call_query() and call
>> directly into it.
>>
>> This change eliminates a full function call and saves one LBR entry
>> in PERF_SAMPLE_BRANCH_ANY LBR mode.
>>
>> Acked-by: John Fastabend <john.fastabend@gmail.com>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   kernel/bpf/verifier.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 17c06f1505e4..2cb5db317a5e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -20181,6 +20181,61 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>>                          goto next_insn;
>>                  }
>>
>> +               /* Implement bpf_get_branch_snapshot inline. */
>> +               if (prog->jit_requested && BITS_PER_LONG == 64 &&
>> +                   insn->imm == BPF_FUNC_get_branch_snapshot) {
>> +                       /* We are dealing with the following func protos:
>> +                        * u64 bpf_get_branch_snapshot(void *buf, u32 size, u64 flags);
>> +                        * int perf_snapshot_branch_stack(struct perf_branch_entry *entries, u32 cnt);
>> +                        */
>> +                       const u32 br_entry_size = sizeof(struct perf_branch_entry);
>> +
>> +                       /* struct perf_branch_entry is part of UAPI and is
>> +                        * used as an array element, so extremely unlikely to
>> +                        * ever grow or shrink
>> +                        */
>> +                       BUILD_BUG_ON(br_entry_size != 24);
>> +
>> +                       /* if (unlikely(flags)) return -EINVAL */
>> +                       insn_buf[0] = BPF_JMP_IMM(BPF_JNE, BPF_REG_3, 0, 7);
>> +
>> +                       /* Transform size (bytes) into number of entries (cnt = size / 24).
>> +                        * But to avoid expensive division instruction, we implement
>> +                        * divide-by-3 through multiplication, followed by further
>> +                        * division by 8 through 3-bit right shift.
>> +                        * Refer to book "Hacker's Delight, 2nd ed." by Henry S. Warren, Jr.,
>> +                        * p. 227, chapter "Unsigned Divison by 3" for details and proofs.
>> +                        *
>> +                        * N / 3 <=> M * N / 2^33, where M = (2^33 + 1) / 3 = 0xaaaaaaab.
>> +                        */
>> +                       insn_buf[1] = BPF_MOV32_IMM(BPF_REG_0, 0xaaaaaaab);
>> +                       insn_buf[2] = BPF_ALU64_REG(BPF_MUL, BPF_REG_2, BPF_REG_0);
>> +                       insn_buf[3] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_2, 36);
>> +
>> +                       /* call perf_snapshot_branch_stack implementation */
>> +                       insn_buf[4] = BPF_EMIT_CALL(static_call_query(perf_snapshot_branch_stack));
> How will this work on non-x86 ?
> I tried to grep the code and looks like only x86 does:
> static_call_update(perf_snapshot_branch_stack,...)
>
> so on other arch-s static_call_query() will return zero/einval?
> And above will crash?

Patch 1 will give the answer.In events/core.c, we have the following: 
DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, 
perf_snapshot_branch_stack_t); #define DEFINE_STATIC_CALL_RET0(name, 
_func) \ DECLARE_STATIC_CALL(name, _func); \ struct static_call_key 
STATIC_CALL_KEY(name) = { \ .func = __static_call_return0, \ .type = 1, 
\ }; \ ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name) So the default value for 
perf_snapshot_branch_stack  is
__static_call_return0.

In static_call.c, long __static_call_return0(void) { return 0; } 
EXPORT_SYMBOL_GPL(__static_call_return0); So we should be fine.

