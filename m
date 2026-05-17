Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A13D0903
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043127; cv=none; b=Rjq35AdU37oGUQucERHAsk/vVMCjgG1UlTMQqJRCLxj7JH2IwFBt1vMf1RDjebHXduPda4J4L8RE0mEu9fpDXDb4FgNZLAHviLJPalu/Mu1WSSAQeDhB39nR50CW1R2gYZA+wNe8gjb6ciL+M/JHMxzmj9egXM0dXPE31gPRClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043127; c=relaxed/simple;
	bh=k8zP1B5fqZF1uC3nV1g0Bz7jocH2kDxWj3o91XIOfBY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rOWGUPQS4R7tlTeg++B18cxfV3lDRFKHG66B4apGJuAf8Ka7wfiF6TiFw3zBwGtAzFoF7Q62uJSBEd/ijFOX2WBIcL/lklwhsHt+95YPn9W64UKeRLGWhvHXWX+afSAIAxBhpE8U9ZZQTW/94hV3U9/4gM1SkCqu7sLumCZ7CmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQpbmc3k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQpbmc3k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7C2C2BCB0;
	Sun, 17 May 2026 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779043126;
	bh=k8zP1B5fqZF1uC3nV1g0Bz7jocH2kDxWj3o91XIOfBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aQpbmc3kGk8m9BjZP9UuGyuWS3p9eZdu61oPRSdLpuuVe7DE+bIzJ38msyz5jYRfi
	 vX28GRsToSSQLP1Do0vzNJnuj/uT4ooiyxxrPWLlyQZ7wNr6E6qszy5wnRF/OZAw42
	 pamsDvis7xncuCmNNFEprVd/Jo6tVE7wGxTcFFxDqHcAdbwvcsYNxkMVTC2BKbcFLi
	 1BLDSpHM5I/IegFLKWOCTTwAOXt977bxDFe7kDmg5uYn20Qa2C0aegGaxvstFkQ97m
	 irk08VMkk+j28gsokxckX8UeM68j8/uWMKtYm/+YFNRvtsnJM5Bd6e3c+1YgRqX3N2
	 ePHNIdmi+Vlkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] selftest/bpf: Fixing powerpc JIT disassembly
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517214043.12975-4-adubey@linux.ibm.com>
References: <20260517214043.12975-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 18:38:46 +0000
Message-Id: <20260517183846.CD7C2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Truncating 8 bytes on 32-bit PowerPC incorrectly removes a valid=
 instruction from the JIT disassembly output.
--

commit 1ee8cba34b15e2d991f046b6802fda4443b02cd0
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Fixing powerpc JIT disassembly failure

This commit truncates the last 8 bytes from JITed buffers on PowerPC
architectures prior to disassembly in the BPF selftests. This is intended
to prevent the disassembler from misinterpreting a trailing dummy
trampoline address as a valid instruction.

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/tes=
ting/selftests/bpf/jit_disasm_helpers.c
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -216,9 +218,18 @@ int get_jited_program_text(int fd, char *text, size_=
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
> +	if (strstr(triple, "powerpc"))
> +		trunc_len =3D 8;

Will this remove a valid instruction on 32-bit PowerPC targets?

The dummy trampoline address is stored as an unsigned long, which occupies 8
bytes on 64-bit PowerPC, but only 4 bytes on 32-bit PowerPC.=20

Because the long branch stub ends with a 4-byte bctr instruction followed by
the dummy address, unconditionally truncating 8 bytes on 32-bit PowerPC wou=
ld
remove both the 4-byte dummy address and the valid 4-byte bctr instruction
from the disassembly.

Does the truncation length need to be determined dynamically based on wheth=
er
the target is 32-bit or 64-bit?

>  	for (pc =3D 0, i =3D 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		disasm_one_func(text_out, image + pc, func_lens[i] - trunc_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517214043.1297=
5-1-adubey@linux.ibm.com?part=3D3
