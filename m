Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DD37A841
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849922; cv=none; b=kp7X2qTF9HqsEVRc9JiWJ8Q2MUN6CcPgYWY0yRL4Iipi1q1mWBPXgYG4dZyvK+EYZvPFG5tlHnyD/F1m4itiBwij2eFRXTs1YPwpLbWZj6qoDTQXWFG+WIo6ll+fAc+uzf1HGM5mFiEQxuldia/u4sIgnEVThlzgPyV2EWUE81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849922; c=relaxed/simple;
	bh=Mp3del96KvT7420sQkxabhcS2uwsOS/FHnorOTpOHik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIKlegdso+CdiCA5FW2v3wQ6lSahsxCs3Pcw8gqWyg0hlTtEXUxV1XMQXEByNnLOVBLA2dnQdeOiq2/RVKUKwMlMpt98A4D/94vAbzuLLsGSQ5l5eghGckyjcDNnl2mZuXkQfy4wePOyRY9Ulkl49yUhrOUiv08QGZTlRTLxxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RLKukzmD; arc=none smtp.client-ip=95.215.58.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RLKukzmD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Mp3del96KvT7420sQkxabhcS2uwsOS/FHnorOTpOHik=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789849916; v=1; x=1790454716;
 b=RLKukzmDKz7/oLV9YR1DLeRmuJAcbd9u2grlLhyD+dmratyy447gi9OOn0tG94lG2EOOWpqj
 6WDlbL5iq6DK16ds8jmmsVXqH21UKZpENCCnyO2r7OXgjMwOJ9rTP7v82nJWnKp1AoF5GlzDEM5
 XjA0lu25VkV+ZFbgNf7Xa8nY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0210bcd3dbcc526;
	Sat, 19 Sep 2026 20:31:56 +0000
X-Mizu-Trace-ID: a0210bcd3dbcc526
X-Migadu-Flow: FLOW_OUT
Message-ID: <7ef6f566-f5b7-4a38-a824-5666fabe5c21@linux.dev>
Date: Sat, 19 Sep 2026 13:31:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
 <20260918044327.3292986-1-yonghong.song@linux.dev>
 <20260918050136.2A6DA1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260918050136.2A6DA1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 10:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] bpf/linker: NULL pointer deref in linker_append_elf_relos()
> - [Medium] bpf/linker: unaligned memory access in data relocations
> - [Low] bpf/linker: multi-line comment style violation
> --
>
> commit 2eadf13e135621b2e34d8946fe67664cd72e0e3d
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Let the static linker carry .bpf_cleanup relocations
>
> This commit updates the BPF static linker to support .bpf_cleanup relocations.
> It specifically adds handling for R_BPF_64_NODYLD32 and R_BPF_64_ABS32 to
> process compiler-emitted exception cleanup tables.
>
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index 78f92c39290af..e5c06023cb5b1 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
> [ ... ]
>
>> @@ -2274,6 +2275,22 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>>   						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
>>   					else
>>   						insn->imm += sec->dst_off;
>> +				} else if (sym_type == R_BPF_64_NODYLD32 ||
>> +					   sym_type == R_BPF_64_ABS32) {
>> +					__u32 *val;
>> +
>> +					/* Two spellings of the one thing: LLVM
> [Severity: Low]
> This isn't a bug, but does this violate the BPF subsystem multi-line comment
> style? The preferred kernel style is to have the opening /* on its own line
> rather than putting text on the same line as the marker.
>
>> +					 * emits NODYLD32 for a .long against a
>> +					 * section symbol, GNU as emits ABS32
>> +					 * (bpf_reloc_type_lookup() maps
>> +					 * BFD_RELOC_32 to it), and the value
>> +					 * they describe is the same.
>> +					 */
>> +					val = dst_linked_sec->raw_data + dst_rel->r_offset;
> [Severity: High]
> Could this lead to a NULL pointer dereference? Looking at
> linker_sanity_check_elf_relos(), SHT_NOBITS sections are explicitly allowed
> as relocatable sections.
>
> For SHT_NOBITS sections (like .bss), extend_sec() typically skips allocating
> raw_data, leaving it as NULL. If we process a relocation against such a
> section here, we might compute val = NULL + dst_rel->r_offset and then
> dereference it on the next line when handling sec->dst_off.
>
> [Severity: Medium]
> Is it also possible to hit an unaligned memory access here?
>
> While executable sections enforce alignment checks in
> linker_sanity_check_elf_relos(), there doesn't seem to be an equivalent
> alignment check for data section offsets. If an ELF provides an unaligned
> r_offset, the direct dereference of the unaligned val pointer might
> cause a crash on architectures with strict memory alignment requirements.

Okay, I will add a guard to check NULL pointer and unaligned memory access.
If this is true, will return an error.

>
>> +					if (linker->swapped_endian)
>> +						*val = bswap_32(bswap_32(*val) + sec->dst_off);
>> +					else
>> +						*val += sec->dst_off;
>>   				} else {
>>   					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>>   					return -EINVAL;

