Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645242B756
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579046; cv=none; b=REjJxF1qQMS6CYEeNMEYyFKA+SOxwaviIctlHdpNQuBbPsLpcT+O6WqTkLsFgVFQ8lBCtftmTAikJ85DwW+hxgkaRF1PcQy+/tm+jcXNYfPhXUVPW0g15GrEtYb2t4iU0QfQCeulN1WhBgq+3cMzh0TjE5yE0NZ/UxavEZEuRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579046; c=relaxed/simple;
	bh=6qGkc1qIo3cva8JUravmV4rZZSb/rMPFDcg6AQdg+LQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cdJ6nX87Eamw+0l1oTQ1i1H3eFfVeg41onqQXjYpPRZ3qfMPhGxfaNQS9xc57Pb2VoXEJYG1TUyT0HSggFDShZArgXzuWuKTHAQalgvaP4P93osryb3ekDZlATftCyTplt1DXSi2Go/guM36gCl0tkmaxfCJEZS8u3OhSDnLZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYeesFCl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYeesFCl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508231F000E9;
	Mon, 24 Aug 2026 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787579044;
	bh=GtrLlvShZyM22+pKVnI9I5XhXGFchINtBu00gIe+N8U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nYeesFCl0kW2tbWkv/tY95RZDs0ot2L0VQe2RXUrME9WcAhT2d5llx51VQq+r7oh0
	 WzVZGObalMoKtZLrlj0sKvM/CaMYzmvbHT6Fi3a6i5XbNOCJzXUUlFABCIrBY1HTKf
	 5DvHFRb2VQZWifyQY4o0yLObSaG6c4Qeni7ODsRu+lB4UGZQkJS9MuwJFAlKzFOytT
	 3CEYlcZeG05sl6XPBHkMe1B2V5I7hJ0fz6q/7ZOZvqMPKncSuk9XPcmmVUSOY2S3P8
	 mmrsaXLcwCxsxJfl/TMsA/zE0233a64mq/r4KALD3oJiq5yMoqB10zZ7fA70jXIthh
	 CiOI3YjuNeMLw==
Content-Type: multipart/mixed; boundary="===============5539401712765086994=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ce55595370c8629d3a962c78a2f1b4c385fa0253d85e74552f45beccb7e45667@mail.kernel.org>
In-Reply-To: <20260824130245.580545-1-tw19881113@gmail.com>
References: <20260824130245.580545-1-tw19881113@gmail.com>
Subject: Re: [PATCH v2] libbpf: Ignore exception frame section
From: bot+bpf-ci@kernel.org
To: tw19881113@gmail.com,bpf@vger.kernel.org
Cc: tw19881113@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 13:44:04 +0000 (UTC)

--===============5539401712765086994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Ignore exception frame section
>
>     Exception handling in BPF program is not supported right now, let's skip it.
>     BTW, I found this when building BPF with Zig compiler[1].
>
>     [1]: https://github.com/tw4452852/bb
>
>     Signed-off-by: Tw <tw19881113@gmail.com>

Kumar Kartikeya Dwivedi pointed out in both v1 and v2 reviews that the
Signed-off-by tag must contain the author's full real name, not just
'Tw'. The v2 review explicitly stated: 'You need to have your full real
name in the SoB tag. Patches cannot be accepted otherwise.'

Could you update the Signed-off-by to include your full name?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee..05727c418c40 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3867,7 +3867,8 @@ static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t idx)
>  static bool is_sec_name_dwarf(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return str_has_pfx(name, ".debug_");
> +	return str_has_pfx(name, ".debug_") ||
> +		   strcmp(name, ".eh_frame") == 0;

This isn't a bug, but could the continuation line be aligned under the
first operand (tab + 7 spaces) so the two operands line up? Every other
wrapped return statement in libbpf.c uses tab plus seven spaces to align
the continuation, like in bpf_map__is_ringbuf():

    return map->def.type == BPF_MAP_TYPE_RINGBUF ||
           map->def.type == BPF_MAP_TYPE_USER_RINGBUF;

>  }
>
>  static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 78f92c39290a..1fb0efdbfae7 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -599,7 +599,8 @@ int bpf_linker__add_buf(struct bpf_linker *linker, void *buf, size_t buf_sz,
>  static bool is_dwarf_sec_name(const char *name)
>  {
>  	/* approximation, but the actual list is too long */
> -	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0;
> +	return strncmp(name, ".debug_", sizeof(".debug_") - 1) == 0 ||
> +		   strcmp(name, ".eh_frame") == 0;

This isn't a bug, but since the same .eh_frame check now has to be
extended in both is_sec_name_dwarf() and is_dwarf_sec_name(), and their
callers ignore_elf_section() and is_ignored_sec() are also near-verbatim
copies including the same .rel prefix-stripping and the same BTF section
exclusions, would it be worth moving the shared predicate into
libbpf_internal.h so future additions only need one edit?

>  }
>
>  static bool is_ignored_sec(struct src_sec *sec)


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32731757949
--===============5539401712765086994==--
