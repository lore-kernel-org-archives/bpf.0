Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0562F7F04
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383831; cv=none; b=ZaxeROPAjpC/dB8k0ExtOQ8OhwWpke11tZWdhgjNfJTjPQfB1vJ6Hh/IW+2hOjiIxbwvlhdY4EKRnz8EsMZOZrPKP2wZJcrCARhxj8iT4YNXAEAPYKd62cD0Yiea8qvMc84NITU+pRVZSWzxf+ukSyXLdgXkcJxLA5b0EPUUM5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383831; c=relaxed/simple;
	bh=pMRwX8nehLKD9LRWHdDLiv3xUdLE0/enV7Q4d4XlG8M=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Gny6OZWcKk0Ebn0IplmScZ3K+9WR/Up8L6LB6DyO189QJx7rRUcPyOXFWbyddGeZNuNZTECzylWgTTj/LF/UdTBxnLcLhwdiqX0kOBDjlD5K5LDkCvFrEWXsOK3igYMA38uKXeKvXAFvRQe4ieZ4jHtMXSPvAx2aTtYjN5QAXQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLRHVD0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLRHVD0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004F31F00898;
	Sat, 26 Sep 2026 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790383830;
	bh=waGNAO3mmaWY5iamP83zOct/GEytFGOhkGA4T2yQa/w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VLRHVD0LqZxEG2hPGi+P9PwHtElg91ejuJLSL8O2Z3ZQ49g396uhi53Z8RYsjVzlv
	 izLZYHQvYmUQRJGUZvIuLNL0UPK8hlo3fcBMJhQzzTvNvhXKxI7hq+6+GdSs8JknbW
	 ik4QsLZqAvZrvmAvD3s1JiZNycewKkpK/GQt+chqNZBYsMEGvoVOuWYZIPgDJ/GBjp
	 UsBoODqgyg01hA0VcPbeUo0P/wTvbPslciYNJx/8FQRkF0bL/vtF8bdd39f0sjdT/T
	 0NdcO3wyu26UYqUKVt9x7SfHfFA7nAJwxQ7rPTDfve9koVGprCeKV6b0rYYXgJYJOb
	 AYDLMlNLEu7/g==
Content-Type: multipart/mixed; boundary="===============5376281402700195805=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94542a0825cb075559127c015439418c3392f166ac8523dd84643c684fcae27d@mail.kernel.org>
In-Reply-To: <20260926000243.2830819-1-andrii@kernel.org>
References: <20260926000243.2830819-1-andrii@kernel.org>
Subject: Re: [PATCH v2 bpf-next 1/2] libbpf: Fix static linking of externs placed in allocated sections
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 26 Sep 2026 00:50:29 +0000 (UTC)

--===============5376281402700195805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 53f64a1a1f25..f3f71c452f00 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c

[ ... ]

> @@ -2592,6 +2597,10 @@ static int linker_append_btf(struct bpf_linker *linker, struct src_obj *obj)
>  					continue;
>
>  				dst_var = &dst_sec->sec_vars[glob_sym->var_idx];
> +				if (!glob_sym->is_extern) {
> +					Elf64_Sym *sym = get_sym_by_idx(linker, glob_sym->sym_idx);
> +					dst_var->offset = sym->st_value;
> +				}

The new offset update assumes glob_sym->var_idx is an index into the
current dst_sec->sec_vars. Does that hold when the resolving definition
is in a different section than the one where the DATASEC entry was first
created?

glob_sym->var_idx is recorded when the glob_sym first gets a DATASEC
entry. If a later strong definition wins, linker_append_elf_sym() moves
the symbol to the new section:

  dst_sym->st_shndx = dst_sec->sec_idx;
  dst_sym->st_value = src_sec->dst_off + sym->st_value;
  ...
  glob_sym->sec_id = dst_sec->id;
  glob_sym->is_extern = false;

The section mismatch check at the top of the DATASEC loop in
linker_append_btf() compares against this updated sec_id, so it passes.
The stale var_idx is then used to index the other section's sec_vars.

For example, if A.c has `int y = 1;` in .data and `int x __weak;` in
.bss, and B.c has `int x = 5;` in .data, linking A then B:

  After A: y is .data sec_vars[0]; x is .bss sec_vars[0] with var_idx 0
  B's .data DATASEC: strong x resolves weak one, sec_id becomes .data,
                     dst_var = &.data->sec_vars[0], which is y's entry

Before this patch only dst_var->size was rewritten there, and y's size
is 4 either way. With this patch y's offset is also set to x's st_value.
The output BTF then has y and x at the same offset in .data.

The same happens for an extern whose DATASEC entry sits in one allocated
section when the definition that resolves it is in a different section.
If the new section's sec_vars is shorter than var_idx, or still NULL,
the write lands out of bounds or through a NULL-based pointer.

Could the var_idx path be skipped, or the resolution rejected, when the
resolving section differs from the one var_idx refers to?

>  				/* Because underlying BTF type might have
>  				 * changed, so might its size have changed, so
>  				 * re-calculate and update it in sec_var.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36204104252
--===============5376281402700195805==--
