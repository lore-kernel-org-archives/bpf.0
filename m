Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84819AD90
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784249622; cv=none; b=kRrBmOhyiR5ph4M5wTmeqGSk60yCnMlMpuPGA9EtZTkebUWOk5xnpb3Mkk3ueDXXkGE5bW5+jvKgA7JqrC+3W5qUyNU2h3B7DvBpTCGPiEOvl1vq5qLa3fQngSSkkMKclOjZZSGBnEKglJCr5F87cjHyuBwUQ67Fpju0JzWuRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784249622; c=relaxed/simple;
	bh=pwiqLN4ZwjB0n+USAqfnipD3eeF/B99m2pcOf54vuFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wsh1WJBthuJX/oQqzA73TLUxuiehEsPKMnU0Z+zQ16ugh7DYwLP9z+W1mAl8oIRyeocz+2fRiLrJjvstMHVa1xG0kH9cxrYg5YJ0L7TM0+C/SbeU0BZBI3qW/5lCWysqiR5Io8Iw/0C2YRl5kEhYrpasSCR4wGC2tvCNfscJyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pICCMcof; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pICCMcof"
Message-ID: <a97bbf70-ac5f-4a32-bd85-5cb2bdbff00f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784249617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed9BBEpCVS7PI7F0t5qd17HgFQS/8tFbAxYgVX+qv1c=;
	b=pICCMcofzaco0wG8n9zdzW1B+byABjsF3yri2DIkTBWuGQ9AhDifeU8onq4uQA6GBzBK5u
	yEM5aj7yW8qEl+k2I9fetUscpKlVs38phEsqAuoBf+5UxPV525vGTw3sJ4zNg1nkekAm5o
	DqKDEB4msN8dapH3s/Vj3f2rDLwYI8c=
Date: Thu, 16 Jul 2026 17:53:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] libbpf: reject linker STT_SECTION symbols with
 out-of-range st_shndx
To: Naveed Khan <naveed@digiscrypt.com>, bpf@vger.kernel.org
References: <178394859382.2.942623981274846749@digiscrypt.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <178394859382.2.942623981274846749@digiscrypt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/13/26 6:16 AM, Naveed Khan wrote:
> linker_sanity_check_elf_symtab() only validates a symbol's st_shndx
> against the section count when it is below SHN_LORESERVE:
> 
> 	if (sym->st_shndx < SHN_LORESERVE && sym->st_shndx >= obj->sec_cnt)
> 		return -EINVAL;
> 
> For a STT_SECTION symbol the following check only rejects a non-zero
> st_value, so a section symbol carrying a reserved index such as
> SHN_ABS (0xfff1) with st_value == 0 passes validation.
> 
> When a relocation references such a symbol, linker_append_elf_relos()
> indexes the per-object section array with no bound check:
> 
> 	if (ELF64_ST_TYPE(src_sym->st_info) == STT_SECTION) {
> 		struct src_sec *sec = &obj->secs[src_sym->st_shndx];
> 		...
> 			insn->imm += sec->dst_off;
> 
> obj->secs holds only obj->sec_cnt entries, so obj->secs[0xfff1]
> dereferences memory tens of thousands of entries past the allocation
> (reading sec->dst_off) when linking a crafted relocatable object,
> an out-of-bounds read that faults or folds unrelated heap contents
> into the patched instruction.
> 
> A STT_SECTION symbol must reference a real section, so reject one whose
> st_shndx is not a valid section index. Reserved indices are always
>> = SHN_LORESERVE, which exceeds sec_cnt, and the in-range case is
> already handled above, so a single sec_cnt bound closes the gap without
> affecting valid inputs.
> 
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c3929..8a93faa41d 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -973,7 +973,7 @@ static int linker_sanity_check_elf_symtab(struct src_obj *obj, struct src_sec *s
>  			return -EINVAL;
>  		}
>  		if (sym_type == STT_SECTION) {
> -			if (sym->st_value != 0)
> +			if (sym->st_value != 0 || sym->st_shndx >= obj->sec_cnt)


As far as I can tell, this is only a problem when the ELF object is
corrupted. If you don't have a user report, or at least an example of
a normally compiled ELF object that can cause a crash, it's a NACK.

libbpf does not aim to be a safe parser for arbitrary malformed ELF.

pw-bot: cr


..An unsolicited piece of advice unrelated to the patch:

I checked your email on lore, and it appears you are a new contributor
trying to land similar patches across multiple subsystems. And I'm
pretty sure AI finds these bugs for you by inspecting code, and then
generates patches.

I can understand the motivation to get your name out, but this is not
a good way to do it.

Pick an area that interests you, or (if you don't have a preference)
pick something useful and/or neglected, like selftests. Read the
mailing list to understand what areas need work. Then figure out how
to actually improve the system, not just fix random unimportant
bugs. Come up with a strategy and start small. Use AI, but also try to
actually learn what's going on, don't just relay the output.

Good luck!


>  				return -EINVAL;
>  			continue;
>  		}

