Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A53CF02D;
	Sun, 17 May 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041930; cv=none; b=d/nS/aLgeEjkwC4Qc4P2E9JdrtcjnfZkBZya3nKXgm7KDE6j53Oej2DdMUrbsHqmoIzzrVH8wAXFXGTjmtrDKxofIPgHF1qIsmNfzCrPZVuScxiqkd9oIQNiHPUEYp5n9Al8PjmK3ZYB3Ce4quSbEcFGuzLStKRFhCo/nSuBgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041930; c=relaxed/simple;
	bh=FdTz52kBiuxxnKRGyJY8LYIp811khf+rWDjvDMYs5Rc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZKZTP3kzVnZuP5dlE7sIMsG9st/236mt+k86PMCBqrfKrlMmjfXRZODWK4oCP4wyS2xWNQpUgaKMTHGeqIPLbHzfl+i4JOcsASif71G6jqU6w2oUZ4ZqhzHbSckfcqKEQSeJWCtMHzLU8vTgCMUhMQnff/xDpRdZZfmBdSThsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Xcgn3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/Xcgn3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C784AC2BCC6;
	Sun, 17 May 2026 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779041929;
	bh=FdTz52kBiuxxnKRGyJY8LYIp811khf+rWDjvDMYs5Rc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R/Xcgn3EfpQZ7yJolrPGRQ5v3X7TKIyJpoV3r3zTXJyr7pVl517l7MMEMWPhbaMTj
	 fPtBG8CMOv1r19o6WVKylBp8Vo/jYSyozFZssnmAh196WxWScJjMvsdwGUeBc67ARs
	 PEXRSkOe6f0RHXxkaxuGLfbNBvkyQ7MUf6kOdX/RXjUEfYYWpuCFilY2EMbg9qAUby
	 +PomWpXt7M16B7riEtp3ndNl1Tr5mjKNj0IymsVlMQnTqM4a157isY1mVBPwJLdbyK
	 CAC2PrHn3LwL3nIknQS/9oTceAg1JIN6uQJ7KlFSXYIm0YkiSpnAcvuMyvD5FzipCV
	 eYcYIannNMcrA==
Content-Type: multipart/mixed; boundary="===============1283525173956514337=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <afd81a2105bb0deae207a35569bde1f3e1cf07d4a119a6fa745a3a15acd8be91@mail.kernel.org>
In-Reply-To: <20260517214043.12975-4-adubey@linux.ibm.com>
References: <20260517214043.12975-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v4 3/5] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 17 May 2026 18:18:48 +0000 (UTC)

--===============1283525173956514337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..4c6bcbe08491 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -170,9 +170,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	struct bpf_prog_info info = {};
>  	__u32 info_len = sizeof(info);
>  	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0;
>  	__u32 *func_lens = NULL;
>  	FILE *text_out = NULL;
>  	uint8_t *image = NULL;
> +	char *triple = NULL;
>  	int i, err = 0;
>
>  	if (!llvm_initialized) {

[ ... ]

> @@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output for 64-bit and 32-bit powerpc, which can't
> +	 * disassemble a to valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (strstr(triple, "powerpc"))
> +		trunc_len = 8;
> +

Does this code leak the triple string? Looking at the LLVM C API,
LLVMGetDefaultTargetTriple() returns a string that must be freed with
LLVMDisposeMessage(). The sibling function disasm_one_func() in this
same file shows the correct pattern:

    if (triple)
        LLVMDisposeMessage(triple);

The cleanup section at the 'out:' label properly frees text_out, image,
and func_lens, but triple isn't included. While this is test code and
the leak is small, it violates the established cleanup pattern in the
file and can accumulate across test runs.

>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25998434343
--===============1283525173956514337==--
