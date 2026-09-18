Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D63644DE
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703914; cv=none; b=d/m3EzvvMGanEaJSBVzIIe7E78DhHOkkimoEFgLHa//c2yPXXbqg9HUA6Zr3iAIMwDLJH2vgVOGsjwdeG3rsfQm0jGVyhbVAN4oRWgN+V5HjtqvpliaiM1HDGPtllxtaU3LKvQ4ZicN5adkuYguChohgF1l1yZnSfjhsFkEopdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703914; c=relaxed/simple;
	bh=NLSLvi372C6GEwNb1cN63pHsVUs+n0tVlbKSSiay78s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cygNd3z5DN+OeylQZ50n2welLT8flMfwl9rjSUYu4C098UmlsXkn7jDHmwo9YaVvRpw0KCjTiC2yhokEmOEPgQeeuJOZEqDfg1+ZnnshB1/w+VZf5hblgYW5xKxpW4VZhq+G70cZQ8DYNWlXULQpkKiK9lwhi8Xzorjj8hINo/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGk8xeXF; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGk8xeXF"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NLSLvi372C6GEwNb1cN63pHsVUs+n0tVlbKSSiay78s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789703910; v=1; x=1790308710;
 b=IGk8xeXFvHREXP7oxjP+McPICDcfTH+wtjcpYSsOY3xBNTPK6CE+ailMXV6uW0T7tYOLjjEU
 KBkQbacAaJIQKce/E5mnSwr3wL1vCMiHHgt87LtcmAWq+zwnaMaHv32/96vC7YnSLy6iEG+V1rJ
 e/QJ3yjQB4SDS9MQUT0CE9/I=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab3fe10d581c422f;
	Fri, 18 Sep 2026 03:58:20 +0000
X-Mizu-Trace-ID: ab3fe10d581c422f
X-Migadu-Flow: FLOW_OUT
Message-ID: <07d4f53f-d572-4893-9dc0-c461f979f9b5@linux.dev>
Date: Thu, 17 Sep 2026 20:58:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 17/20] libbpf: Let the static linker carry
 .bpf_cleanup relocations
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055812.3934611-1-yonghong.song@linux.dev>
 <20260917061637.CF3A91F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260917061637.CF3A91F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/16/26 11:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] libbpf: unaligned memory access in linker for 32-bit relocations
> --
>
> commit 408d36d153c1766697801912b5eb3e8087995ef9
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Let the static linker carry .bpf_cleanup relocations
>
> This commit allows the BPF static linker to process 32-bit relocations
> against non-executable sections by handling R_BPF_64_NODYLD32 and
> R_BPF_64_ABS32 relocation types. It updates the 32-bit values directly in
> the raw data of the relocated section.
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
>> +					 * emits NODYLD32 for a .long against a
>> +					 * section symbol, GNU as emits ABS32
>> +					 * (bpf_reloc_type_lookup() maps
>> +					 * BFD_RELOC_32 to it), and the value
>> +					 * they describe is the same.
>> +					 */
>> +					val = dst_linked_sec->raw_data + dst_rel->r_offset;
>> +					if (linker->swapped_endian)
>> +						*val = bswap_32(bswap_32(*val) + sec->dst_off);
>> +					else
>> +						*val += sec->dst_off;
> [Severity: Medium]
> Can this lead to an unaligned memory access crash?
>
> The static linker processes these 32-bit relocations against non-executable
> sections by casting the relocated offset to a 32-bit integer pointer and
> directly dereferencing it.
>
> If a user supplies a malformed BPF object file with an unaligned relocation
> offset, this could result in undefined behavior and a crash (SIGBUS) on
> host architectures with strict alignment requirements.

This only happen for a malformed BPF object file and we don't care if
the BPF object file is indeed malformed.

>
> Should linker_sanity_check_elf_relos() be updated to ensure the relocation
> offset is a multiple of 4 for non-executable sections, similar to how it
> checks alignment for SHF_EXECINSTR sections?
>
> tools/lib/bpf/linker.c:linker_sanity_check_elf_relos() {
> 		if (link_sec->shdr->sh_flags & SHF_EXECINSTR) {
> 			if (relo->r_offset % sizeof(struct bpf_insn) != 0) {
> 				pr_warn("ELF relo #%d in section #%zu points to missing symbol #%zu in %s\n",
> 					i, sec->sec_idx, sym_idx, obj->filename);
> 				return -EINVAL;
> 			}
> 		}
> }
>

