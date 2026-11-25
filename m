Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644905;
	b=v7VRQ923tk1+QLNqC17HaNPXcblM6PXpW+5xHP4QwsnhLfyAljhmlaXHNjjX5ZS5OmvK
	 gCfxClcrrSMG1S++d1xWb83zsf3I6m1wO7Ur6QiHoDM8qQOMCoEbOR+qYOh5lsr9L75t/
	 I93/jWwIknCGgP6yRcIJ0sXNG1IN5eGMlRT8YKUa6TFj64QOjgNgAJqd+Fhty0QufYDGn
	 0Dg6VVG5ogvjq/y7gPwrj9RiPr+ZLRHvxtAf/adZZvDwpqyT5eCPxoaF9gS4dR0iTeUnj
	 mdfNSVOUf/ZAhT3jN5hbnu5lEK4TaRpma2ciKB+oBN9jh/9X7AnjZQcTqPFcvM8W8Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644905;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=JpZSg2TYG7PxfAKyJuNT7Sl3niXCfVBjAAIve0Hw8ao=;
	b=0UsI0pp8iHX+bFlzuPWAL94qXn8n3g2MmdmgYHTFI3ReUBK0JJK1zKnoALML12n9D7Yq
	 2Ouywf3woGJxNTZh2hTiVVBzb+1iN0QW9V36SYlenlJLrjZO9iqhsn08UW7yB0xEjnyjC
	 +6s2bFjigfrOLoMB19NPpUVScHX0yC96TbTmuY4+vkdSmaThhs4DxLc6H/Bwg3SXjZJTe
	 LXH1kPo9h8yhQfyZy/DWjJ4S5BnWXmiuUPJCszaWxWbj4uUtaDkoyPsbmgleAqevSszR9
	 aroLwNxpV50XARxbllE6QQByTEOI2Hdnvg9g/9ntJZfZeVdgp/9FAVsvB1/tZMnd3Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/y2/ddI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A907606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/y2/ddI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FDE1F000C0;
	Wed, 25 Nov 2026 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795644904;
	bh=JpZSg2TYG7PxfAKyJuNT7Sl3niXCfVBjAAIve0Hw8ao=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T/y2/ddI/dNyUrgMLg26cL6uoEHge28fwRY3wwFsOC5wfCjcXyyhejive0ms4kHAk
	 mJUDCUuKW+dRvYmhdPnAU1zMIBV7/p6jFhOvzm5j2sBfP7PPTUp3XHxOi/lF5K4HT2
	 hbSG83+Q4fYaS1394qCTfcn9OwYnsar6q7lLj50dIpuYkOdiRanenqd/M6lkXOQNgv
	 pKflTdZ/QysV6UvXUsWfNkaN+uwdY8/fuOKed1sFHgPqz4xj4s0/BMKOr0HNbMScRo
	 zCz08yHmoDKj/IDEWkmvOgqO/Uf+4PhiKyi8OWWSuQLe/g4U9EExchFBmBLqoOnMzG
	 NbC14ckAK9GLw==
Content-Type: multipart/mixed; boundary="===============4103781311731213700=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <14767b6e502afbaa1478bb8418a405a3aa58919b99b18a53212693ad50512ad8@mail.kernel.org>
In-Reply-To: <20261125212849.868523-5-a.s.protopopov@gmail.com>
References: <20261125212849.868523-5-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 4/5] resolve_btfids: Exclude the code of kernel/bpf and of the JIT
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,almagui@kernel.org,john.fastabend@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 22:15:03 +0000 (UTC)

--===============4103781311731213700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Exclude the code of kernel/bpf and of the JIT

TL;DR: With CONFIG_LTO_CLANG, a host llvm-nm older than the kernel's clang may
fail to parse kernel/bpf bitcode, possibly breaking vmlinux BTF generation in
a config that built before. Using the kernel's $(NM) is suggested.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +/* Read the symbols of bpf_archives[] into NAMES, sorted */
> +static int read_bpf_code(char ***names, size_t *nr)
> +{
> +	char cmd[sizeof(LLVM_NM) + 256] = LLVM_NM " --defined-only -j", *line = NULL;

[ ... ]

> +	if (pclose(f) && !err)
> +		err = -EINVAL;
> +	if (err) {
> +		fprintf(stderr, "FAILED: --fmodret_scan: %s\n", cmd);
> +		return err;
> +	}

With CONFIG_LTO_CLANG, every member of kernel/bpf/built-in.a is LLVM
bitcode.  Bitcode is only backward compatible, so an llvm-nm older than the
clang that built the kernel can fail to parse it and exit non-zero.

The build allows llvm-config to come from a different LLVM than the kernel
compiler (llvm-mc.sh says "The host's LLVM need not be the one which
compiles the kernel"), and LLVM_CONFIG defaults to plain llvm-config
when only LLVM=1 or CC=clang-N is used.

If that happens, the failure propagates like this:

link-vmlinux.sh -> gen-btf.sh .tmp_vmlinux1
  -> resolve_btfids --fmodret_scan
  -> fmodret_tag(): base == NULL -> read_bpf_code()
  -> pclose(f) != 0 -> err = -EINVAL
  -> fmodret_tag() goto out -> "Failed to generate BTF for vmlinux"

Before this patch the same configuration (LTO_CLANG=y, DEBUG_INFO_BTF=y,
BPF_FMODRET_SCAN=y, host llvm-config at least 17 but older than the kernel's
clang) built, since only the linked machine code of .tmp_vmlinux1 was read.
No Kconfig dependency excludes LTO_CLANG from BPF_FMODRET_SCAN, and the
BPF_FMODRET_SCAN help was not updated for the new llvm-nm dependency.

Can the host llvm-nm read kernel/bpf/built-in.a in that setup?  Would the
kernel's own $(NM), which kbuild requires to be llvm-nm under LTO_CLANG and
exports to gen-btf.sh, be a safer reader here?  If GNU nm were used, an
output format it supports (e.g. -P) would be needed in place of -j.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45706808075
--===============4103781311731213700==--
