Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74D342538
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178475; cv=none; b=r3P4M2Mj8lGAlxyY70CEQKJkDKykBc797zFAxzK9zg8G10/VxWq9muui6tvHe1KnAJuYzFsGWb6v5dalf1Cv6FSz0mabrYHPY/7J4JC3tO9m09E6lKk2WU/O8uMvtVtLZLAfQrLzALcEH2GADEdhip1L90MEs91dHTESIqmLmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178475; c=relaxed/simple;
	bh=1HvMwkdhqh4AXm47edttSrRJgGBut6w6bK8lbwYG6XY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9iM2SvnV0KY5yWQzI7LgpuS4Nxd+pWSeF8ZNGRVM3kM9SRmRSd8lTsSBKGTljOMj5PVYFYrJN1ouPngIpzTswoKpTBPubDazK9z2TuvFFMSOE76RMzBo4VWJLyxiyh1/gUhUzRjGnwnVEHf/TLsMj7mek3eZar3iqyMeHS5kWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKOfq9F8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKOfq9F8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8061F00893;
	Thu, 11 Jun 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781178473;
	bh=4Zx9S+miKde5EOmH8hj78OG+TpYelbf+i8jGU9iL6kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKOfq9F8t3/xQdf29NYkTvFghW/RTuN6Tk4lyvHc9bvCc++LsunU2cnIz4QVaWcFQ
	 oIJOZgZf7IWKV1vexKZW+8YcnzB2vY4jeV5+R832K9KTOzNh5cwIfzipTZvkuPM5h4
	 sWBMGDYoisi53WQALJQZerE5vjkzNZDFUWVoAuJdFo7YJhHVCLJ6jPfg94AIRs5OJl
	 WIyL67L5BuAm+laVkXZxbTMi2MklxF4AcbDz0Bj1B39UjFOTkaL0/mjA5Mn8AdiZgr
	 Z7vJ7wkT5LBaj1vJWJi+zpXqGfIL7SD/rmu1dg9vO7rAmEpo1CLg64ivlqyVBZFcVv
	 pCVl1XDGFS0wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] selftest/bpf: Fixing powerpc JIT disassembly
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611153826.31187-4-adubey@linux.ibm.com>
References: <20260611153826.31187-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 11:47:53 +0000
Message-Id: <20260611114753.9B8061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a C++ style single-line comment (`//`) which v=
iolates the BPF subsystem comment style guidelines.
--

commit 90e32beb297573769f660f2e6d0779da36d4155e
Author: Abhishek Dubey <adubey@linux.ibm.com>

selftest/bpf: Fixing powerpc JIT disassembly failure

This commit ensures that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address to the disassembly flow.
It prevents the disassembler from ingesting this memory address by
truncating the last bytes from JITed buffers before disassembly.

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/tes=
ting/selftests/bpf/jit_disasm_helpers.c
> index 364c557c51158..466d62b4ca285 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -216,9 +218,26 @@ int get_jited_program_text(int fd, char *text, size_=
t text_sz)

[ ... ]

>  	for (pc =3D 0, i =3D 0; i < jited_funcs; ++i) {
>  		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
> +		// Disabled JIT have zero func_lens, hence underflow
[Severity: Low]
This isn't a bug, but does this C++ style comment violate the BPF subsystem
conventions which require standard C-style block comments for single-line
comments?

> +		__u32 disasm_len =3D func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
>  		fprintf(text_out, "\n");
>  		pc +=3D func_lens[i];
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611153826.3118=
7-1-adubey@linux.ibm.com?part=3D3
