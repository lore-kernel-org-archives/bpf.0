Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7519369204
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 23:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780011660; cv=none; b=DiDGlthavfDdcqUubPMQX39AJL3eRkULyNTjVqmL4cVHEx3whB65oNNga5+1a87AC0WJ9zQlBug3A8TdHO4Zc5BWJEg95VzxVkwq8mYQMOHDp9wMhY2Bxrmdw8IcmcaflrRh5lTGuAbZbwFQQjUbLJWvo5eL0/rfGldDn/dnBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780011660; c=relaxed/simple;
	bh=VaZsjhqwnSOOUQl7jpV10TGAIO+cDi02Fym450YJxvc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XoPs6y0qrz8w9elMZAZ5D2w0uCbHKGQ5ueWAfRrJI4UKPVsO14qde5XTyX6tzDkV0AAkbYAyauEYl8RSBq8FRyu+UyXTlixTc0udTcwf8fRS6yGaHiJqwuFe+DPYjvFmC7CJ6XwsjEaT5P1JAkom6qRmJakIFoAb62mbnge9U78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2dFcqr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2dFcqr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BC91F000E9;
	Thu, 28 May 2026 23:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780011659;
	bh=MDGzaKBNdRrJQfY+/ER6XVylMg+nxqgvxlm7zGkNUOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2dFcqr12EbrfnfPlaJ8IIiF6ejywbMlfFRr3IWclPs33apOgatYH41RwMklyoxEd
	 6wG+ma51PbNEyxK3XK4hDexvuPCu9x3CB/bxbKBQBGohE5pYIRfymgr9OLoCdPW59y
	 5We2RfjaqxzsysMuSYPdIbBSM9RO7zRG20Df7CInMUMhJqbDUIqmP6tnbe1gX53XIM
	 Sd011dIljbGi3NzmNHIADKNaWqilLjWBkG3la5Uep5KRpzeKr/lV28cawt4u2Fr5kR
	 fIP7Fg+1Lo2WZUNjF5IiwVjRLLsv4/QpAZraNaAmgaVsYMIuckn+d4QDGV1h5tNYVU
	 MIeLUfK48oqEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] selftest/bpf: Fixing powerpc JIT disassembly
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529015855.364704-4-adubey@linux.ibm.com>
References: <20260529015855.364704-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 23:40:58 +0000
Message-Id: <20260528234059.06BC91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The use of kernel macros `IS_ENABLED` and `CONFIG_PPC64` in a users=
pace BPF selftest causes either a fatal compilation error or incorrect logi=
c.
--

commit 86263e6d76dea14a94abb1054bf8be122467a648
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Fixing powerpc JIT disassembly failure

This commit truncates the last 4 or 8 bytes from JITed buffers on powerpc
to prevent the disassembler from processing the dummy trampoline address.
This avoids disassembly errors caused by reading these dummy addresses as
instructions.

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/tes=
ting/selftests/bpf/jit_disasm_helpers.c
> index 364c557c51158..21e3e3e68c147 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
[ ... ]
> @@ -216,9 +218,28 @@ int get_jited_program_text(int fd, char *text, size_=
t text_sz)
[ ... ]
> +	triple =3D LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc")) {
> +			if (IS_ENABLED(CONFIG_PPC64))

[Severity: Low]
Will this cause a compilation error? This file is a userspace program built
for the host system to run BPF selftests, so it does not have access to the
kernel's IS_ENABLED macro or Kconfig options like CONFIG_PPC64.

Because include/linux/kconfig.h is not available in this context, the
compiler may treat IS_ENABLED as an implicit function declaration and
CONFIG_PPC64 as an undeclared identifier.

> +				trunc_len =3D 8;
> +			else
> +				trunc_len =3D 4;
> +		}
> +		LLVMDisposeMessage(triple);
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529015855.3647=
04-1-adubey@linux.ibm.com?part=3D3
