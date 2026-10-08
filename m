Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33D93A16BC
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476824; cv=none; b=bFw+rMkf1v9aSyxNgXVtaeuCVhznVAP+dxqzww3GhOP8PemZ4kbV55pxi+PQr9KomkhUEFnzIJTY+HCewVejM1rujm/b5QEJdfrfWpCoRl4abb/2w0aNfNxAibAJA2zOjbOpZAZnA1HkKtHGCmIG+4bMiEn1VyW7P5iQTDRTDAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476824; c=relaxed/simple;
	bh=elMo7XeB3YRhT6RNTPvrgMU788aLB2u7QePIglPuYa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvB2XQ0m/XuzSYxu/P7pDJBqgX/kNIxQXUHSmzZA9hDiNhPt/7cMcxCqgTGz5tpDIdhBpTJGeSErSE00FuwFkbjqbAzeHHHgARs6dXGVqvdYUjd/IlPsNI/FjIJPap9ks+F9EZKq782KqUVE0C9FS2xL/p1OZ4T04XVBSpykzms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1Pd8apR; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1Pd8apR"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=elMo7XeB3YRhT6RNTPvrgMU788aLB2u7QePIglPuYa8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791476821; v=1; x=1792081621;
 b=n1Pd8apR7hF/o3SfQL4vkKh5g9w8KS3NQsgwKTm9nQ5YZtlK/dAZytLgQCNoSrPtdvMm96fP
 AefAM22AC/Wuk62gi5UTtkrO4J3RyPttqRhwk4LryQKIq1NTq5oDr6lbZkSqtHIvtvuN2kHQttB
 buL99xPoXAqGKnJFme5RllSE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c101bbccb9fdfe4;
	Thu, 08 Oct 2026 16:27:00 +0000
X-Mizu-Trace-ID: 5c101bbccb9fdfe4
X-Migadu-Flow: FLOW_OUT
Message-ID: <ad01cc17-7226-4d13-aaeb-741a772308d2@linux.dev>
Date: Thu, 8 Oct 2026 18:26:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 19/23] libbpf: Let the static linker carry
 .bpf_cleanup relocations
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261008074959.2993751-1-yonghong.song@linux.dev>
 <20261008075136.3008537-1-yonghong.song@linux.dev>
 <sashiko-outbox-163810@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <sashiko-outbox-163810@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/8/26 10:14 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] libbpf: OOB array access in linker_append_elf_relos via malformed ELF symbol
> --
>
> commit c7a7a96d1dd021ce6e4bcaa13fd9ec618fb1f8cf
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Let the static linker carry .bpf_cleanup relocations
>
> Each field of a .bpf_cleanup record is a byte offset into a code section: a
> 32-bit relocation against that section's symbol, with the offset as the
> implicit addend. The patch updates the linker to handle R_BPF_64_NODYLD32
> and R_BPF_64_ABS32 relocations against non-executable sections.
>
>> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
>> index f3f71c452f007..c607f51e3cb46 100644
>> --- a/tools/lib/bpf/linker.c
>> +++ b/tools/lib/bpf/linker.c
> [ ... ]
>
>> @@ -2297,6 +2299,39 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>>   					if (linker->swapped_endian)
>>   						off = bswap_64(off);
>>   					memcpy(ptr, &off, sizeof(off));
>> +				} else if ((sym_type == R_BPF_64_NODYLD32 ||
>> +					    sym_type == R_BPF_64_ABS32) &&
>> +					   (sec->shdr->sh_flags & SHF_EXECINSTR)) {
> [Severity: Medium]
> Could this result in an out-of-bounds memory access?
>
> If an ELF file contains a malformed STT_SECTION symbol with an st_shndx

We should not care this since the elf file is *malformed*.

> value >= SHN_LORESERVE (such as SHN_ABS), it bypasses the bounds check against
> obj->sec_cnt in linker_sanity_check_elf_symtab():
>
>      if (sym->st_shndx < SHN_LORESERVE && sym->st_shndx >= obj->sec_cnt) { ... }
>
> When processing relocations against this symbol, linker_append_elf_relos()
> indexes the obj->secs array using this out-of-bounds st_shndx:
>
>      struct src_sec *sec = &obj->secs[src_sym->st_shndx];
>
> The newly added relocation handling branch for R_BPF_64_NODYLD32 and
> R_BPF_64_ABS32 then directly dereferences the out-of-bounds sec->shdr and
> sec->dst_off pointers. Can this lead to an out-of-bounds read and a
> segmentation fault when linking an untrusted ELF file?
>
>> +					/*
>> +					 * A byte offset into a code section,
>> +					 * stored in place. LLVM spells this
>> +					 * relocation NODYLD32 and GNU as
>> +					 * spells it ABS32; being bytes, the
>> +					 * section's new start goes in as it
>> +					 * is, not scaled the way a call's
>> +					 * instruction index is above.
>> +					 *
>> +					 * r_offset is checked only for an
>> +					 * executable section, and SHT_NOBITS
>> +					 * has no raw_data, so bound it here --
>> +					 * subtracting, so it cannot wrap.
>> +					 */
>> +					if (!dst_linked_sec->raw_data ||
>> +					    dst_linked_sec->sec_sz < (int)sizeof(*val) ||
>> +					    dst_rel->r_offset % sizeof(*val) ||
>> +					    dst_rel->r_offset >
>> +					    (size_t)dst_linked_sec->sec_sz - sizeof(*val)) {
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

