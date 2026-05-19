Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B963B95EB;
	Tue, 19 May 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221645; cv=none; b=dkl6oM0Ngxjin5o+gKcplsVFbnR823iDlIvLNDumpoda5PiIUdW9ogtoCqjumskEy472eJ52EZ6alFQk0Ma6Jtg9V6yPlDIfkBwc2IVzG+GjJZeOh6nhkWlXLWDUVG0dVvQNGs+IpniMQDbgQRBK8V9RYwypZFT/V8JMQij1ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221645; c=relaxed/simple;
	bh=qcDgeBIobu7QOiM1yTUW11o6pb4rkHOr3PHDvH9VGa8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R0RzkRDXJk83CJNjB7xQUFxWFrDP8GfcHs+CWcIws97mTKTcMtDapyZ+UGrbIJc9i44nh9jIvMuqTzi43tmA9HIk1JTNpzx/vADVn5YoVUwMfKwJXbsG1yTNlNlb/xH2RI5qM9xwVaatnbIjwTqfpr6/kiCBmqGvgP4inBf1GWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAijBb4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAijBb4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A09B1F000E9;
	Tue, 19 May 2026 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779221643;
	bh=QvOFtChNIc/Lv01NwRtdPtchE86wFjtvPtjthL72dA0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VAijBb4uB/fbrUDR3a/85Xf0E6X0ga64VaGegpCSNo04fkylWh3Xa0PMtwCPtmhOH
	 yxQ5U+lqKozloDWobwr4IalcJ9YYjb196CBTDvLnn0vhYXvvamNnYnEUstMxZrxQGH
	 OWxRXnyXq6r+Ip/hxzw+2EWKjGKwWKbHGxWQ0w420B4m6adjgTmlcg/zjYA1cNFLj3
	 Q3b4eNM1V+F7x4dNu6r0aIOnnbRVILxdIv10X+meWtjRvQE79doU9XFh9z/UuWSeQ/
	 mmckdJwBEflqRYK9hSEbR2j8VImqeE0XUZYS86phDXDcuN91OQpAIDujeGkzimgGir
	 qJv80dcaxzF8Q==
Content-Type: multipart/mixed; boundary="===============0100323596669499861=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c48e80e6302339e5bbbd1a0eff985f8cc114cc0bd78063552ed2729ae3ed1d47@mail.kernel.org>
In-Reply-To: <20260519233812.18787-4-adubey@linux.ibm.com>
References: <20260519233812.18787-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v5 3/6] selftest/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com,linuxppc-dev@lists.ozlabs.org,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 19 May 2026 20:14:03 +0000 (UTC)

--===============0100323596669499861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 364c557c5115..9e6613479145 100644
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
> @@ -216,9 +218,21 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output for 64-bit and 32-bit powerpc, which can't
> +	 * disassemble a to valid instruction.
> +	 */

This isn't a bug, but there's a grammar error here: "disassemble a to
valid instruction" should be "disassemble to a valid instruction".

> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc"))
> +			trunc_len = 8;

Will this remove a valid instruction on 32-bit PowerPC targets?

The dummy trampoline address is stored as an unsigned long, which
occupies 8 bytes on 64-bit PowerPC, but only 4 bytes on 32-bit
PowerPC.

Because the long branch stub ends with a 4-byte bctr instruction
followed by the dummy address, unconditionally truncating 8 bytes on
32-bit PowerPC would remove both the 4-byte dummy address and the
valid 4-byte bctr instruction from the disassembly.

Does the truncation length need to be determined dynamically based on
whether the target is 32-bit or 64-bit?

(Note: This concern was raised by sashiko-bot@kernel.org in v4:
https://lore.kernel.org/bpf/20260517183846.CD7C2C2BCB0@smtp.kernel.org)

> +		LLVMDisposeMessage(triple);
> +	}
> +
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

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26121409898
--===============0100323596669499861==--
