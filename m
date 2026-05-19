Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B90377017
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224010; cv=none; b=hY6QxiGqKVZwtNwVzMeX7IDrArMMfmEG1BGnOZxa7baksA2ATDYsPtJk2V+OKfKn0dnpIJurjCMDLjNvVoK5EXdRYVEMA+5ttiEX4LwQNEx1EduHUJdviqlMzkOjROiok57tfN8NQDzgjzb2SU1OkTACwBXh96VKUNk03hPkWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224010; c=relaxed/simple;
	bh=FMQIWjp2Q8BkGmcrx6IgOpeHvUkJdQBMvM9D3UpxAFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mhGfEG9HlzB3+iP4fAl+4Cl8xZBKOaQI9wmcMDkZp8PkmL4TyYlIJ+lpVomCdBM+leWQ7ELDSXx8+EZGZBxBuYHFIafNsy0WN4IfbsQwaDlEgMujY3K2PJVp65cgDg9rWjdGVsxjkpEiGoRxxexUXAfNOfzPgewBIBip/W3O/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD3p/9dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD3p/9dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC2F1F000E9;
	Tue, 19 May 2026 20:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224009;
	bh=eF7zjXLySejT6koKkzxfYxI2LH+kcycL4/vExHy2nPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XD3p/9dPiu6IUoqDDz91r66ccO6OhdSYe6jK63RAzrclHgOH/oBXvSHEREXnAQIM+
	 8SiC6Jy3SNAefXChpU3Rk26uRJjRmbZVmq+chzUpYSwGn11sv0rHscOWwJGPZPld1M
	 q3e8Ayi599TrwvrjZKA36Wh3MA/OuJAMis9et/uJ9K/zZdKteK/MTg2o0OZ06lr6wz
	 mHVN+jnCBJOv/wDNNsP76r1vOYpLEsWsCNkm+rHEDvu5ZuuNN1LYv965OKrYqyLPpC
	 dTBFebjU3Al2l9KcE8cgps4fxSHOR/SQ1TC7MwO6RtZr0IJOP9fkx5f4AZgorC9CEI
	 wFovzbzyUbEEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] selftest/bpf: Fixing powerpc JIT disassembly
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260519233812.18787-4-adubey@linux.ibm.com>
References: <20260519233812.18787-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 20:53:28 +0000
Message-Id: <20260519205328.BAC2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch unconditionally truncates 8 bytes for all PowerPC arch=
itectures, which incorrectly removes valid instructions on 32-bit PowerPC.
- [Medium] Subtracting `trunc_len` from `func_lens[i]` without validation l=
eads to an integer underflow and a severe out-of-bounds memory read.
--

commit 73c1d26cdc13556368d62ac6bed226a8d4c1dde6
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Fixing powerpc JIT disassembly failure

This commit addresses a JIT disassembly failure on PowerPC by truncating
the dummy trampoline address stored at the end of the JITed buffer. It
checks the LLVM target triple and removes the last 8 bytes before
supplying the buffer for disassembly.

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/tes=
ting/selftests/bpf/jit_disasm_helpers.c
> index 364c557c51158..9e66134791458 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
[ ... ]
> @@ -216,9 +218,21 @@ int get_jited_program_text(int fd, char *text, size_=
t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
> =20
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output for 64-bit and 32-bit powerpc, which can't
> +	 * disassemble a to valid instruction.
> +	 */
> +	triple =3D LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc"))
> +			trunc_len =3D 8;
> +		LLVMDisposeMessage(triple);
> +	}

[Severity: Medium]
Since 32-bit PowerPC uses a 4-byte pointer size, does the dummy trampoline
address only occupy 4 bytes?

If trunc_len is unconditionally set to 8 bytes for all PowerPC architecture=
s,
could this accidentally strip an actual 4-byte instruction preceding the
trampoline address on 32-bit PowerPC?

> +
>  	for (pc =3D 0, i =3D 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);

[Severity: Medium]
If a BPF program fails to JIT or JIT is disabled, the kernel returns a
JITted length of 0.

Since func_lens[i] and trunc_len are unsigned 32-bit integers, could
evaluating func_lens[i] - trunc_len without checking if func_lens[i] >=3D
trunc_len lead to an integer underflow?

If an underflow occurs, could the massive length passed to
disasm_one_func() cause the disassembler loop to continuously read out of
bounds from the image buffer, resulting in a segmentation fault?

>  		fprintf(text_out, "\n");
>  		pc +=3D func_lens[i];
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519233812.1878=
7-1-adubey@linux.ibm.com?part=3D3
