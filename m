Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1A3B27E9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427734; cv=none; b=GBWcwqmVjtL1BddZsEuwSCeBsHChzo1NCka9R2TK/1MmSs5PWdKfKUzITKmW98U8rD/80n0X1+iNo2mJPCl2FIyPI1UNhqIV8ii40AaDBK3E1oAGJWm8xcUkqyjqtmd6qWGJgohG8w+aJCSVTNUPVXlJ2tgw+oIr73LDNhy3H6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427734; c=relaxed/simple;
	bh=xywjc4Op0zpLMLTymvnnTRFzgk1Lj+Y/R+PoO7x7UKY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AjSDjEBep0qPGJlzoMNpsO7pZ/pA5Ip1uSQH6Gf1ByZnjggWIxpPv8wmBNIh0/mJHLPwpQZ9VUMOrOs+NQPzUwkxsi2VJcRsLZyX758VN9IfRVMUaHLTgyoRj+rdMSefkABIb5zCs6oCcwJQ5wGyeibZceEcEhZV/BdPgzbQaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Ns/i4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Ns/i4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2181F00893;
	Mon, 14 Sep 2026 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789427730;
	bh=K7erhlcBoSPOQhcfk36ZEzLgW3NZV2PNSd9/8C/r8kM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h/Ns/i4fghydK1FP6guepuJiAyjRNdk+Ybc/x4YgW/uFvgz2v7qOI7uKFZnDO/+3l
	 RER8sE9X14yHSTaM/yiyUUUJKYDf7w7UnQXPZq5RBEAJz0DElF/GTCeWbUTcXBpbdq
	 W/5RhulY/EkeaDY8sAW74nOmi209EpDufW860wnsh5x5+CsZ5PLI0PG52I5UZE9FlU
	 HDAM9aT4ZVeWVTUHlC5Cx8eAt/F0z6DEb/+W7lyQhJYHUW0CdnKkN5PZZujEIiotjh
	 01NYODPG+EUI864+j80fjnOaCMWUFHSlyHp6j6hP+t5ctWr2mjQMp9yBfuH3F+SOOd
	 0NToQU/dP82Ww==
Content-Type: multipart/mixed; boundary="===============3931033995527708730=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <44ece0212fb14b9996b672e297bf92005fc97c5d2701ec4d0d42293c5caf9ee8@mail.kernel.org>
In-Reply-To: <20260914222514.1635018-12-memxor@gmail.com>
References: <20260914222514.1635018-12-memxor@gmail.com>
Subject: Re: [PATCH bpf v4 11/11] selftests/bpf: Add truncated CO-RE ldimm64 test
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 23:15:29 +0000 (UTC)

--===============3931033995527708730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c
> new file mode 100644
> index 0000000000000..b70c8874241de
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c

[ ... ]

> @@ -0,0 +1,82 @@
> +static bool truncate_ldimm64_prog(void *elf_data, size_t elf_sz, const char *prog_name)
> +{
> +	Elf64_Ehdr *ehdr = elf_data;
> +	Elf64_Shdr *shdrs;
> +	Elf64_Sym *syms;
> +	const char *strs;
> +	size_t i, j;
> +
> +	if (elf_sz < sizeof(*ehdr) || ehdr->e_shoff > elf_sz ||
> +	    ehdr->e_shnum > (elf_sz - ehdr->e_shoff) / sizeof(*shdrs))
> +		return false;
> +
> +	shdrs = elf_data + ehdr->e_shoff;
> +	for (i = 0; i < ehdr->e_shnum; i++) {
> +		if (shdrs[i].sh_type != SHT_SYMTAB)
> +			continue;
> +		syms = elf_data + shdrs[i].sh_offset;
> +		strs = elf_data + shdrs[shdrs[i].sh_link].sh_offset;

This isn't a bug, but since elf_bytes here is always the skeleton's own
build artifact, would it read more simply to drop the header size
guard - or, if it is meant to make the walk safe, to also bound
sh_link, sh_offset and sh_size?

> +		for (j = 0; j < shdrs[i].sh_size / sizeof(*syms); j++) {
> +			if (ELF64_ST_TYPE(syms[j].st_info) == STT_FUNC &&
> +			    !strcmp(strs + syms[j].st_name, prog_name)) {
> +				syms[j].st_size = sizeof(struct bpf_insn);
> +				return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c b/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c
> new file mode 100644
> index 0000000000000..d8d9a3650fe0d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +
> +enum core_reloc_truncated_ldimm64 {
> +	CORE_RELOC_TRUNCATED_LDIMM64_VALUE,
> +};
> +
> +SEC("raw_tracepoint/sys_enter")
> +int core_reloc_truncated_ldimm64_resolved(void *ctx)
> +{
> +	return bpf_core_enum_value_exists(enum core_reloc_truncated_ldimm64,
> +					  CORE_RELOC_TRUNCATED_LDIMM64_VALUE);
> +}
> +
> +SEC("raw_tracepoint/sys_exit")
> +int core_reloc_truncated_ldimm64_poison(void *ctx)
> +{
> +	return bpf_core_enum_value(enum core_reloc_truncated_ldimm64,
> +				   CORE_RELOC_TRUNCATED_LDIMM64_VALUE);
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";


The commit message says:

>     Without bounds validation, libbpf reads or writes beyond the exact-sized
>     instruction allocation, depending on whether the relocation resolves.

This isn't a bug, but would it be worth saying that the second-slot read
happens on both paths and only the poison write is unresolved-specific,
and noting whether the kernel-side bpf_core_apply() path is covered
elsewhere?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34904671165
--===============3931033995527708730==--
