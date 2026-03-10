Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF2285CA2
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 23:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183957; cv=none; b=l9TXPcLRy7JtQ6QamHsZTERKYAM2WpZrvsyNVGzyDVgn5olnOIgmXrADxa7orBjiFE4RhRG+BfXW6gg5ZwpfsZf0QFZ5xWr1BukMqE+xlKnG/8EqM3xm5bO0KuLYqPNo/+G2YFVSkAuZzijI2Y/7xtCobCJABvrilUv/ij1FpWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183957; c=relaxed/simple;
	bh=Qolf50CDyxdYcMCsip7TygIVIf5OohnXzDX2vsxtC5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WcYiaWPCt5exYmt3AKlqdPeJTXh8dRdVozUuq9IfjoM8A6RNQQQXYfwYCtPmN82ISfPgS5MKzIBp8+tOwmA2dknklwcyuQMXnzQSrJ1fyZWXrr3+qnH0A3SgTbb0lrqP/6rFDxupT8JoCEHiMZQBUbJxmyHnpEs1W0oDA19r5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP1dzWEw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1dzWEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7E9C19423;
	Tue, 10 Mar 2026 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773183957;
	bh=Qolf50CDyxdYcMCsip7TygIVIf5OohnXzDX2vsxtC5c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MP1dzWEwYlq/zB8y3finH3K0+RnxCg5vrqIvnU6aiZbBJmujquKsaSmbCgFzegw4d
	 waW7wt0ZSfm7MKNFaoNzyVy9EAPmrXwdnf3XgUZ8ytqbG7DUuFrzYW0PNo6C8ynkeT
	 576gYWFyC1XN3RDjf9a5YkkY8Ay+5R4Nq6gaYUoJl7Y7QlOQ+pv8opUI3U+TlN6YxK
	 LL6e9AGgheh5roTyqyr5dt1760XWikO5NlHJwYZS7qXbYm+LJu/GI9IjMfH0PvJsOu
	 ikyysyfaSYaUEafuv8c1RU9j5GyitXfvNv6BCoHfw4b8jehozXCd20imYeJMNA/xqB
	 FdvPFQfMU/9BQ==
Content-Type: multipart/mixed; boundary="===============9140904856075228337=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d287b2ab8fe7ee19b3e6c98a58aba501ac191339b7f34960b5bc804ae6a23ab@mail.kernel.org>
In-Reply-To: <20260310223456.1706712-1-puranjay@kernel.org>
References: <20260310223456.1706712-1-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpftool: Enable aarch64 ISA extensions for JIT disassembly
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,puranjay12@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,memxor@gmail.com,mykyta.yatsenko5@gmail.com,qmo@kernel.org,kernel-team@meta.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Mar 2026 23:05:57 +0000 (UTC)

--===============9140904856075228337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -93,7 +93,16 @@ init_context(disasm_ctx_t *ctx, const char *arch,
>  		p_err("Failed to retrieve triple");
>  		return -1;
>  	}
> -	*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);
> +
> +	/*
> +	 * Enable all aarch64 ISA extensions so the disassembler can handle any
> +	 * instruction the kernel JIT might emit (e.g. ARM64 LSE atomics).
> +	 */
> +	if (strncmp(triple, "aarch64", 7))
> +		*ctx = LLVMCreateDisasmCPUFeatures(triple, "", "+all", NULL, 0, NULL,
> +						   symbol_lookup_callback);
> +	else
> +		*ctx = LLVMCreateDisasm(triple, NULL, 0, NULL, symbol_lookup_callback);

Isn't this condition inverted? strncmp() returns 0 when the
strings match, so when triple starts with "aarch64" the condition
is false and the else branch runs, which calls the old
LLVMCreateDisasm() without any features enabled.

Conversely, for non-aarch64 targets (e.g. x86_64), strncmp()
returns non-zero, making the condition true, and
LLVMCreateDisasmCPUFeatures() with "+all" gets called on the
wrong architecture.

It looks like this should be:

	if (!strncmp(triple, "aarch64", 7))

The v1 of this patch used strstr(triple, "aarch64") which has the
correct polarity (returns non-NULL on match). The switch to
strncmp() for v2 appears to have lost the negation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22927610334
--===============9140904856075228337==--
