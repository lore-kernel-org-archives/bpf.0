Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C6489FD8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000500; cv=none; b=oCAvBSMqvaQySGr0uSSa1L9HdiU8x5eAlOXvD7Sw6lk8jUAtDQWQc2+NOpZ3Gb3kfV4LofRZpdQQZAvC3MM/FAKEf0qM+Q3AOSwyRfQ+KsCAY1ED1W1JeHwFybPEWQpdI81B2Y1Ts8aGpoyEf6JtSsaEG7QJX9frYv9n+kfwTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000500; c=relaxed/simple;
	bh=+7Z+Mv91TAk6XqwHlJRyJI0omnUpeR/OUOsZQscbRgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa4vyxEj9fa3Yl2Q/MK+M2JDp457T57ouM4fEd64ZucgcPihd5pM2IOg21IuGTDxS7icCGaK6B80N31wiVUXIFT4CM/LOGPD1mxUkJbYUxnHiXUFa+oDO6VDwS8oRWJYet59nzmDPSUlcz+suZq7wFxfDJ7Dcnz5eyU7CILc4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+UsYej1; arc=none smtp.client-ip=91.218.175.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+UsYej1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+7Z+Mv91TAk6XqwHlJRyJI0omnUpeR/OUOsZQscbRgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790000496; v=1; x=1790605296;
 b=A+UsYej1L9mtF+ZZVCmEx5YlxVKK/FXIWPbaIatz0mu+lGZ0WS9ExRGz2pjLtwEmIB9HxdBP
 MYUzhG7NNww3GJiHf0hTPBla56b5Q1PGUM/qAo2lFISKDRffJGF2It+Gx1FxKI+Oo7eiUEwq64h
 452T+kGXFsahAN2yhUly5LOU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e83492bc1c2ebf62;
	Mon, 21 Sep 2026 14:21:36 +0000
X-Mizu-Trace-ID: e83492bc1c2ebf62
X-Migadu-Flow: FLOW_OUT
Message-ID: <e78bf544-9287-47ff-8b02-e29bd03e1e15@linux.dev>
Date: Mon, 21 Sep 2026 07:21:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054353.872669-1-yonghong.song@linux.dev>
 <814e7b07a8b20d99b412c03b1a597a3637387190add957a109e567bcb3413593@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <814e7b07a8b20d99b412c03b1a597a3637387190add957a109e567bcb3413593@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/19/26 11:31 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index 78f92c39290a..fac7390bd109 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
>> @@ -1036,7 +1036,8 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
>>   		size_t sym_type = ELF64_R_TYPE(relo->r_info);
>>
>>   		if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
>> -		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
>> +		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32 &&
>> +		    sym_type != R_BPF_64_NODYLD32) {
>>   			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
>>   				i, sec->sec_idx, sym_type, obj->filename);
>>   			return -EINVAL;
>> @@ -2274,6 +2275,39 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>>   						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
>>   					else
>>   						insn->imm += sec->dst_off;
>> +				} else if (sym_type == R_BPF_64_NODYLD32 ||
>> +					   sym_type == R_BPF_64_ABS32) {
>> +					__u32 *val;
>> +
>> +					/* Two spellings of the one thing: LLVM
>> +					 * emits NODYLD32 for a .long against a
>> +					 * section symbol, GNU as emits ABS32
>> +					 * (bpf_reloc_type_lookup() maps
>> +					 * BFD_RELOC_32 to it), and the value
>> +					 * they describe is the same.
>> +					 */
>> +
>> +					/* An SHT_NOBITS section has no
>> +					 * raw_data, and r_offset is sanity
>> +					 * checked only for sections holding
>> +					 * instructions. Check both here
>> +					 * before writing.
>> +					 */
>> +					if (!dst_linked_sec->raw_data ||
>> +					    dst_rel->r_offset % sizeof(*val) ||
>> +					    dst_rel->r_offset + sizeof(*val) >
>> +					    (size_t)dst_linked_sec->sec_sz) {
>                                                      ^^^^
>
> Can the addition here wrap around? Since dst_rel->r_offset is Elf64_Addr
> (uint64_t) and sizeof(*val) is size_t, the expression
>
>      dst_rel->r_offset + sizeof(*val) > (size_t)dst_linked_sec->sec_sz
>
> is evaluated in unsigned 64-bit arithmetic. For r_offset == 0xFFFFFFFFFFFFFFFC
> (that is, 2^64 - 4):
>
>      r_offset % sizeof(*val)  is 0 (since 2^64 - 4 is a multiple of 4)
>      r_offset + 4             wraps to 0
>      0 > (size_t)sec_sz       is false
>
> so all three sub-tests pass, and the code falls through to
>
>      val = dst_linked_sec->raw_data + dst_rel->r_offset;   /* raw_data - 4 */
>      *val += sec->dst_off;
>
> which performs a 4-byte read-modify-write immediately before the buffer
> obtained from realloc(), corrupting the heap chunk header.
>
> r_offset is fully controlled by the input object and is never
> bounds-checked. The existing r_offset validation in
> linker_sanity_check_elf_relos() (near the top of this diff) is an
> alignment-only test and applies only to SHF_EXECINSTR sections.
> The .bpf_cleanup section is not executable, so nothing constrains
> r_offset before this point.
>
> Reached via: bpf_linker__add_file() -> bpf_linker_add_file() ->
> linker_append_elf_relos() -> this arm. Triggered by any object with a
> .rel.bpf_cleanup entry of type R_BPF_64_ABS32 or R_BPF_64_NODYLD32 against
> an STT_SECTION symbol and r_offset == 2^64 - 4.
>
> The commit message notes "r_offset is checked for alignment only where the
> section holds instructions. Refuse those rather than write through them",
> which suggests the guard is meant to close this hole. Ordering the
> comparison so it cannot wrap fixes it:
>
>      dst_rel->r_offset > (size_t)dst_linked_sec->sec_sz - sizeof(*val)
>
> with sec_sz >= 4 established first, or an explicit test that r_offset does
> not exceed sec_sz ahead of the addition.

Yes, wrap arround is possible. Will fix.

>
>> +						pr_warn("ELF relo #%d in section #%zu points outside the data of section '%s' in %s\n",
>> +							j, src_sec->sec_idx,
>> +							dst_linked_sec->sec_name,
>> +							obj->filename);
>> +						return -EINVAL;
>> +					}
>> +					val = dst_linked_sec->raw_data + dst_rel->r_offset;
>> +					if (linker->swapped_endian)
>> +						*val = bswap_32(bswap_32(*val) + sec->dst_off);
>> +					else
>> +						*val += sec->dst_off;
>>   				} else {
>>   					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>>   					return -EINVAL;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

