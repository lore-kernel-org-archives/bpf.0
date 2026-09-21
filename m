Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EA471CE8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000429; cv=none; b=DS2DBctkqMcWDPC0+3dD6RJhGbNyLACV4Qz/YPblLVWk6FGK6CjGdzfKHi4vUX2sBG4NTjnZTgOdj4jgb2E7C/1Op5gN29/X2mqxiUI39SbeYntq5ipO5DYAGTyeos0k8NZGVPRM2eJPzbtCfvy+4vyhx02S15syGCz+fI4aWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000429; c=relaxed/simple;
	bh=Z6+lbQSfsts1seFo97lTcVu3MuMtDNhLODH15/zqHCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rh7WLlghYj+ZufKKBPrpBJrCoPF8b/ibFv7TM1L1V8ZnWkM5cDJu6Z6HBthCxdg6ExHqxMo9KcsVvJyZQGHdQCUA70wVYaRzxOIHsgWgaIJKSQN63MJ2Ff0LabhR7uRV69GrQQ8WWj2dMOCaDOhkCHqHuQnFvOSApfo9U2rcaT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q816Y/GU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q816Y/GU"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Z6+lbQSfsts1seFo97lTcVu3MuMtDNhLODH15/zqHCA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790000425; v=1; x=1790605225;
 b=Q816Y/GU2fDzHaWrQ9t9Z8ehIvjqtCijTxx02mXDhgeKYzPg5BdT2+M9JUNqxeGlIVHKeBzb
 GWwkzmqtdo1D2hLTMaP3zn3n8eDmGYWXDvKWYKB7EU2fhQKUVzaEaePC0Vgo9BAplFn0+5JQD3U
 Q5ZCkxSIzqz7MVf7uijiitzg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d936da47445c78c3;
	Mon, 21 Sep 2026 14:20:24 +0000
X-Mizu-Trace-ID: d936da47445c78c3
X-Migadu-Flow: FLOW_OUT
Message-ID: <a5ac138b-f857-4b6b-aaa9-1695b4b877e6@linux.dev>
Date: Mon, 21 Sep 2026 07:20:20 -0700
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054353.872669-1-yonghong.song@linux.dev>
 <20260920060026.6349C1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260920060026.6349C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/19/26 11:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] libbpf: integer overflow in relocation bounds check allows out-of-bounds heap access
> - [Low] libbpf: incompatible pointer cast to __u32 * violates strict aliasing
> - [Low] bpf: newly added multi-line comments violate the BPF kernel comment style
> --
>
> commit c31e91765bc81fed1c51952c88d0792cd3b4c2bd
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Let the static linker carry .bpf_cleanup relocations
>
> This commit updates the static linker to accept and properly handle
> R_BPF_64_NODYLD32 and R_BPF_64_ABS32 relocations against STT_SECTION
> symbols in non-executable sections. This enables linking of objects
> that contain compiler-emitted exception cleanup tables.
>
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index 78f92c39290af..fac7390bd109d 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
> [ ... ]
>
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
> [Severity: Low]
> Does this multi-line comment format violate the BPF subsystem guidelines? The
> BPF guidelines specify that multi-line comments must have the opening /* on
> its own line, with the text starting on the next line.
>
>> +					 * section symbol, GNU as emits ABS32
>> +					 * (bpf_reloc_type_lookup() maps
>> +					 * BFD_RELOC_32 to it), and the value
>> +					 * they describe is the same.
>> +					 */
>> +
>> +					/* An SHT_NOBITS section has no
>> +					 * raw_data, and r_offset is sanity
> [Severity: Low]
> This isn't a functional issue, but this comment also places text on the same
> line as the opening /*.
>
>> +					 * checked only for sections holding
>> +					 * instructions. Check both here
>> +					 * before writing.
>> +					 */
>> +					if (!dst_linked_sec->raw_data ||
>> +					    dst_rel->r_offset % sizeof(*val) ||
>> +					    dst_rel->r_offset + sizeof(*val) >
>> +					    (size_t)dst_linked_sec->sec_sz) {
> [Severity: High]
> Can this bounds check bypass validation due to an integer overflow?
>
> If a malicious BPF ELF object provides an oversized r_offset (for example,
> 0xFFFFFFFFFFFFFFFC), adding sizeof(*val) could wrap around to 0. This bypasses
> the check against dst_linked_sec->sec_sz and allows out-of-bounds heap memory
> access.

Yes, overflow is possible. Will fix.

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
> [Severity: Low]
> Does casting the raw byte buffer to a __u32 pointer violate strict aliasing
> rules?
>
> The tools/ build assumes strict aliasing, and accessing generic byte buffers
> this way can lead to compiler misoptimization. Would it be safer to use memcpy
> or unaligned access macros here?

I think it should be okay. In the above we have
   struct bpf_insn *insn;
   ...
   insn = dst_linked_sec->raw_data + dst_rel->r_offset;

>
>>   				} else {
>>   					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>>   					return -EINVAL;

