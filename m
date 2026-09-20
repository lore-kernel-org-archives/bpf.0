Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FF3C9EF4
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885920; cv=none; b=m4VnstDnEMK5aUfKDRSUgIRtfvwf0JooaAtQpaMs0saQBUWF3sWjgsRHUd3DmGeLrY3XL4eGQ/y6VRbzV46VsW/gHhc8q6fDnP+mJJcUzQQzazoWQum6NZqu8uZrDlwr1zr7cj98yYhKjBJR6/oeJgAZuhnD8zoXXNW3dLy+6Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885920; c=relaxed/simple;
	bh=Sqx2isRTVDgHoP1n70RCH1iXU1gQdBBII/EgFGeyMtc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WsRhkal8VqxP63/lM4VbMiknGjuLh4R4CIK8E19W6kikLh4B7V+W9deXqsH/K0w0QACQpmrfgkXTUuyClG3A0HckRFe0pWGfMBPFA75dKU+SVTHXgZmW1r1/KtG34HOGp31odmv9K43L2+NgXUX1BPQe1L8vpTMhW/Axw/OytAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTE9ehC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTE9ehC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AB81F000FF;
	Sun, 20 Sep 2026 06:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789885919;
	bh=O29iEbQamsnRRaCIRCgymzZckA0a6E3X+OiVrUUrTak=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mTE9ehC19K8VL49ZtSoD8w3WMlWACUKdbU187iwkXlRi8zALGQfZtM/lEvFCFel4I
	 qLx+nyLCZuZOJgbDHZ3oZcSlIy0jAL/QRjiqq0zG1OvxFvE7ZUvKpljgJB/umMnx4M
	 jBPuUCKKLyfXUZdFuRbEEPLGgG+JxyXD1sYL2pF5lAFh8FEZ0xJZGtfqRUduKwHubK
	 K4EK9p49tlwY7Spa8RiS2Yciu3vRi8d3HNNIhuMeBaZlFF9Des2uevSgXaSPdK1vwx
	 +qC5x1yXyfmiC3MVOJY90XLXstfZQAXfa+l9GzR/EsS6zOZei6KrfMnkdSK5Limmru
	 96zshVt9iZcjg==
Content-Type: multipart/mixed; boundary="===============5326325940599972801=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <814e7b07a8b20d99b412c03b1a597a3637387190add957a109e567bcb3413593@mail.kernel.org>
In-Reply-To: <20260920054353.872669-1-yonghong.song@linux.dev>
References: <20260920054353.872669-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 17/20] libbpf: Let the static linker carry .bpf_cleanup relocations
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 20 Sep 2026 06:31:57 +0000 (UTC)

--===============5326325940599972801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290a..fac7390bd109 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -1036,7 +1036,8 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
>  		size_t sym_type = ELF64_R_TYPE(relo->r_info);
>
>  		if (sym_type != R_BPF_64_64 && sym_type != R_BPF_64_32 &&
> -		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32) {
> +		    sym_type != R_BPF_64_ABS64 && sym_type != R_BPF_64_ABS32 &&
> +		    sym_type != R_BPF_64_NODYLD32) {
>  			pr_warn("ELF relo #%d in section #%zu has unexpected type %zu in %s\n",
>  				i, sec->sec_idx, sym_type, obj->filename);
>  			return -EINVAL;
> @@ -2274,6 +2275,39 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
>  						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
>  					else
>  						insn->imm += sec->dst_off;
> +				} else if (sym_type == R_BPF_64_NODYLD32 ||
> +					   sym_type == R_BPF_64_ABS32) {
> +					__u32 *val;
> +
> +					/* Two spellings of the one thing: LLVM
> +					 * emits NODYLD32 for a .long against a
> +					 * section symbol, GNU as emits ABS32
> +					 * (bpf_reloc_type_lookup() maps
> +					 * BFD_RELOC_32 to it), and the value
> +					 * they describe is the same.
> +					 */
> +
> +					/* An SHT_NOBITS section has no
> +					 * raw_data, and r_offset is sanity
> +					 * checked only for sections holding
> +					 * instructions. Check both here
> +					 * before writing.
> +					 */
> +					if (!dst_linked_sec->raw_data ||
> +					    dst_rel->r_offset % sizeof(*val) ||
> +					    dst_rel->r_offset + sizeof(*val) >
> +					    (size_t)dst_linked_sec->sec_sz) {
                                                    ^^^^

Can the addition here wrap around? Since dst_rel->r_offset is Elf64_Addr
(uint64_t) and sizeof(*val) is size_t, the expression

    dst_rel->r_offset + sizeof(*val) > (size_t)dst_linked_sec->sec_sz

is evaluated in unsigned 64-bit arithmetic. For r_offset == 0xFFFFFFFFFFFFFFFC
(that is, 2^64 - 4):

    r_offset % sizeof(*val)  is 0 (since 2^64 - 4 is a multiple of 4)
    r_offset + 4             wraps to 0
    0 > (size_t)sec_sz       is false

so all three sub-tests pass, and the code falls through to

    val = dst_linked_sec->raw_data + dst_rel->r_offset;   /* raw_data - 4 */
    *val += sec->dst_off;

which performs a 4-byte read-modify-write immediately before the buffer
obtained from realloc(), corrupting the heap chunk header.

r_offset is fully controlled by the input object and is never
bounds-checked. The existing r_offset validation in
linker_sanity_check_elf_relos() (near the top of this diff) is an
alignment-only test and applies only to SHF_EXECINSTR sections.
The .bpf_cleanup section is not executable, so nothing constrains
r_offset before this point.

Reached via: bpf_linker__add_file() -> bpf_linker_add_file() ->
linker_append_elf_relos() -> this arm. Triggered by any object with a
.rel.bpf_cleanup entry of type R_BPF_64_ABS32 or R_BPF_64_NODYLD32 against
an STT_SECTION symbol and r_offset == 2^64 - 4.

The commit message notes "r_offset is checked for alignment only where the
section holds instructions. Refuse those rather than write through them",
which suggests the guard is meant to close this hole. Ordering the
comparison so it cannot wrap fixes it:

    dst_rel->r_offset > (size_t)dst_linked_sec->sec_sz - sizeof(*val)

with sec_sz >= 4 established first, or an explicit test that r_offset does
not exceed sec_sz ahead of the addition.

> +						pr_warn("ELF relo #%d in section #%zu points outside the data of section '%s' in %s\n",
> +							j, src_sec->sec_idx,
> +							dst_linked_sec->sec_name,
> +							obj->filename);
> +						return -EINVAL;
> +					}
> +					val = dst_linked_sec->raw_data + dst_rel->r_offset;
> +					if (linker->swapped_endian)
> +						*val = bswap_32(bswap_32(*val) + sec->dst_off);
> +					else
> +						*val += sec->dst_off;
>  				} else {
>  					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>  					return -EINVAL;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538
--===============5326325940599972801==--
