Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B727495ADB
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379322; cv=none; b=Xx9bzbVo6v3Ygywydr3AvuM4gHUMN/uxOAEbXgoy3TMn3SmDtm9VK6XAGjH7RD923Uix1DI3azDGwOvagskq1o83HCchhMgIMnd2izzU1KySJrTQHQV0UbMgHVrqDNt9ojtV6Xw/U4n7JjEv7ny7wN06fdbOyZYxCcqfb4eSF9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379322; c=relaxed/simple;
	bh=4lHKdYQpYF6tgc3+L/lBe6RO8N3TSBNZvLfm7araJFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=M3c4vsT0843l1zAfGdluE0jcD+UvmshnoSUFsdJx/NOmXj9/bxvZK9d6huFvBZyGaNBdhh/gCVWmXLRimr0Gc1IMDBRLO9Uf/macJujaV3SrpGiFg7ySB5U0ZMIWvwrkdAvhxe2RULB4/W4GtyGZpXFAyvM85P49JHx96KEwmb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QChxcqhg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QChxcqhg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C48E1F000FF;
	Fri, 25 Sep 2026 23:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379320;
	bh=2WElu+ie6GSCXQsUKZbudxjKgzmW0nTcqluCK0Zr1nE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QChxcqhgAOqd/z21W7FY6JYEJRAFHfn/9DmapT3aEMzLDp8yQnQi3f2mPpEgeOxpe
	 RRJLIyN7zvEE4ddiow5iAvcxAqtP0Zf/yQL7vT6SlcaIv+BdTAdmsufnlKi51GB7a8
	 coKSr7d030QuRSVyar5ari6L426Lx+ljyVUtbxCD9waIKGcYMuOLMcxxHlHEBCLSN4
	 4hpZ1nt6rc9BFuxWmjmXT4zMLl2YxvPQKYVIc7pqxxN0hXV8oWuCLtPykhQfdFEjyY
	 hsiNibyayXFK4ALqesd/sGxn8q5SbdbHBN4oc6lnarG6fSSzwOlppBcGdDzLltTJNs
	 pCh6Tr1Kn3PWw==
Content-Type: multipart/mixed; boundary="===============0729104089562396186=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1133351c9a9af13d20566a2336f08bb37a799b28f616363a9171223551b4513b@mail.kernel.org>
In-Reply-To: <20260925224631.1490488-1-andrii@kernel.org>
References: <20260925224631.1490488-1-andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix static linking of externs placed in allocated sections
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 25 Sep 2026 23:35:20 +0000 (UTC)

--===============0729104089562396186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 53f64a1a1f25..0eaf98b093f0 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2159,7 +2159,10 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
>  	dst_sym->st_name = name_off;
>  	dst_sym->st_info = sym->st_info;
>  	dst_sym->st_other = sym->st_other;
> -	dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
> +	if (sym_is_extern)
> +		dst_sym->st_shndx = SHN_UNDEF;
> +	else
> +		dst_sym->st_shndx = dst_sec ? dst_sec->sec_idx : sym->st_shndx;
>  	dst_sym->st_value = (src_sec ? src_sec->dst_off : 0) + sym->st_value;
>  	dst_sym->st_size = sym->st_size;

Does this code leave st_value non-zero for unresolved externs in
allocated sections?

For an extern placed in an allocated section (.maps, .addr_space.N),
src_sec is the object's real section. The extend_sec() call sets
src_sec->dst_off = dst_align_sz, which is non-zero whenever an earlier
object in the same link already contributed to that section.

So for unresolved externs, the output symbol would be:

  {st_shndx = SHN_UNDEF, st_value = dst_off (> 0), NOTYPE, GLOBAL}

Won't linker_sanity_check_elf_symtab() reject this when the output is
linked again?

linker.c:linker_sanity_check_elf_symtab() {
  ...
  if (sym->st_shndx == 0) {
    if (sym_type != STT_NOTYPE || sym_bind == STB_LOCAL
        || sym->st_value != 0 || sym->st_size != 0) {
      pr_warn("ELF sym #%d is invalid extern symbol in %s\n", ...);
      return -EINVAL;

This check requires st_value == 0 for SHN_UNDEF symbols.

For example, if stage 1 links c.bpf.o (defines "long __arena c_val = 3;")
followed by linked_arena1.bpf.o (defines a_val and has "extern long __arena
b_val;"), linked_arena1's .addr_space.1 lands at dst_off 8. The output
would have b_val as UNDEF with st_value 8. Stage 2 links that output with
linked_arena2.bpf.o, and bpf_linker__add_file() fails in
linker_sanity_check_elf() with "ELF sym is invalid extern symbol".

The same issue affects extern maps when another object with map
definitions comes first. The outcome depends on input order. With a
single object in stage 1, dst_off is always 0, so the issue only shows up
with multiple objects.

Would setting st_value to 0 for externs address this? For example:

  dst_sym->st_value = sym_is_extern ? 0 : (src_sec ? src_sec->dst_off : 0) + sym->st_value;

This would match what Clang emits and pass the sanity check.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36199505247
--===============0729104089562396186==--
