Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501563;
	b=cDSf0/2MxtLiMfDdy03sSzH2WDTabImMkDmkR3KzauSr5cCf1h3W/CMnRyg3QXzG6A1m
	 qr9WW92ZMFV8xBIE+6qWIl5YZQSGkTRoRPsdT2DVtIL3iojUEBPaHCrAYT8SRYrOoctC8
	 vIsFRjIKDnhgRaszEDz73Z9sgF7F0y7j1YcJejlrQMhMK4yyqlTpmsYsbeR4IQ44bVuq0
	 jTGPD96KU2PYZ533Q0xEGzFj/9jfM0qQLp8iKrF8bvDr68zivuHTm2fY8CFxUnhWEzo3a
	 FHRt2O5ZgU89haPvndt2/y7q8E6T/PCv8ddwS2NmmfomStSz3/QZklr4kRYHlVEibPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501563;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=87Yvq5Tfw20D1NHuIdIjGitV2Wx0A+jA2klH0/7UQCM=;
	b=uJ7mD23F1kqgIxKxd1qX9nkztQV0O/9jlatJqmhBUcbb1HY0r6gtNFmyGncG6fPsjYwX
	 BuJjxHKoh5skLtYUpugNwMw5ypQA5CW6xxVHDVVFT8WgJVd6pxJuCgAJK185XZrXDupN/
	 G10mWFXjJ0Iz3wH57dNR3SHOsDcrum6OUOi/wwu8U1WWb5hgrLGjLxOQzIh4AdWFq4rGD
	 kRFhmdFdqmFJ/sb8b4IERBuEQ7mSJkF6AMPY1j9eOq2C7CPkABppg1MObXGbW5qwhxDte
	 xN3TAVOmrOIK35slHid33KtbAoatcpC/ZzRTVyzFPNBTvnxn3GOYLV5BaC2RpBNx7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGVvgKCe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE7606A885
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGVvgKCe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F091F000C4;
	Thu, 12 Nov 2026 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794501563;
	bh=87Yvq5Tfw20D1NHuIdIjGitV2Wx0A+jA2klH0/7UQCM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VGVvgKCeaChKautC+S+eaajI6YbLxDI9/zmUkyT0pH33ontKqEmumipLmPoc/inAm
	 i7JaZeu2iLMPZ+L4JdfcOeV3vTmabEmGc599EZ3SA9J5p99tDsJByBK2J90vbBvrqv
	 Onh3Gb6ElSvONWOZRIFkc10MkWbMC8r19cfDtKe1JRSJopt+vL6x13smaOMXlR5D6C
	 f1HnbWe93HU1OfkHEyr1HQOn+9pbosShyUfXxiPKUoVm2Uv8HMhv/9o8eWyGPE9Wm9
	 cNggTsNzosij4BgmnujK/kqEZQnkk+nxTkaIihYhDIBLYgdOfLKEsQFK/L67nmv8TD
	 uiqU4B4/5Q82A==
Content-Type: multipart/mixed; boundary="===============3232780938788462101=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <90528bedbd81c1687f01a4ba9ca5bea8fabe22b97628640ce3af85f488f638ca@mail.kernel.org>
In-Reply-To: <20261112155337.1040699-13-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/12] selftests/bpf: Test the evaluation of linked expressions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 16:39:22 +0000 (UTC)

--===============3232780938788462101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test the evaluation of linked expressions

TL;DR: Nit only, in the selftests: the comment above remainder_of_low_32_bits
also describes the 8-bit case, which belongs to zero_extension_of_low_8_bits
further down; move that test up or give it its own comment.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/testing/selftests/bpf/progs/verifier_scev.c
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c

[ ... ]

> +/* r8 is dead at the jump. Its leader r3 holds 32 or 8 bits of it: r8 is 1 << 32, 1 << 8 */
> +LINKED(remainder_of_low_32_bits, MAP_OOB,
> +	"w3 = w8; r2 = r8; r2 %%= 100; r8 = 0; if r3 > 63 goto out_%=; r1 = r6; r1 += r2;")

This isn't a bug, but the comment above remainder_of_low_32_bits seems to
cover two tests.

In remainder_of_low_32_bits, r3 = w8 holds 32 bits of r8, and r8 = 1 << 32
is its counterexample.  The '8 bits' and 'r8 is 1 << 8' parts belong to
zero_extension_of_low_8_bits (r3 = r8 & 0xff, r8 = 256 gives r3 = 0 and
r2 = 2048), which sits three tests further down, after
operand_has_a_leader_but_no_value and bound_of_loop_above_a_32bit_spill,
and has no comment of its own.

Could zero_extension_of_low_8_bits move up next to remainder_of_low_32_bits,
or get its own comment, so that the '8 bits' / '1 << 8' part sits above the
test it describes?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43255831689
--===============3232780938788462101==--
