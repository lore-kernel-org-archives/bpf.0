Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE07347FE1
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103056; cv=none; b=cIvLB8DOH6YaaC6Ylx4RYAxp6h6OFgrnC26kFxaKIz+hLCVYFCUxF6fpj224UoqxIy66MwIoeTqbVCMqgrPd8NSGzqE5mPbLxyMe9uSxZHHxDMf3txPnNB7ob4FaLOT0xqv0p0tpH9Rve/hModPdMMJyghUuKxI/BzkYy8vxYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103056; c=relaxed/simple;
	bh=if6j9HO/mJIvMrD+k/BsrBs1NDdbBBHS2jYZoQ60xTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A3nqp4vejbMOFxPASN0xdxSrLPfuTsnXub+49nvHxLK8xoq6CvvAOZFVOCZ3f2vn2luhgVeuSDXHJ6tOfJMk4NzohAMTakK9HK8beweY6HfTHGyuhfkCUApQYw2GhTvwCbRxAeC+2AxSuqI6Ybbg3Wm/2cHpGXZc4mnsPr6AAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSMAiepr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSMAiepr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E696AC2BCB7;
	Mon, 18 May 2026 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103054;
	bh=if6j9HO/mJIvMrD+k/BsrBs1NDdbBBHS2jYZoQ60xTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FSMAieprqrzdyyvAf5TIT1zsSfEJMgGofsfDv9ddQ6ts3arthVD2Bc97TThb3x1BV
	 CTMuT3qReYaeOxmPsXIAREG+RIhJ6VWKton07vdWTfzYseFCGJYwrZEsclCc5Fbtoy
	 OscLFWUfQ7pfTGizjmnzwGOjV5EUEnta5WZCK6pvjMG4OFXNWmlpejGyf+IvUs/H2F
	 PKmFhiw4PVijC4eY4lbdvAB+zFLy4++ZB8KdDmn7NBtQWtbOHR92aTi8njSpogD+tK
	 lUu8de9pWR9s2J5HcUCRnhVVLNjP665MagQkWO8V7PiFWZkXTkWIMw01eD+7yLk7en
	 1+rxC/P7/an2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2 06/11] selftests/bpf: Emit nop,nop10 instructions
 combo for x86_64 arch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260518105957.123445-7-jolsa@kernel.org>
References: <20260518105957.123445-7-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 11:17:33 +0000
Message-Id: <20260518111733.E696AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch modifies `USDT_NOP` to emit an 11-byte `nop, nop10` se=
quence, breaking existing BPF selftests that explicitly expect `nop, nop5`.
- [Medium] Libbpf is not updated to recognize the new `nop, nop10` sequence=
, causing the intended uprobe optimization to silently fail.
--

commit 1ccfa6afa421e13f88c377be82ec249ff187bf51
Author: Jiri Olsa <jolsa@kernel.org>

selftests/bpf: Emit nop,nop10 instructions combo for x86_64 arch

This commit updates the USDT_NOP macro in the BPF selftests to use a nop,no=
p10
instruction sequence instead of nop,nop5 for x86_64. This is intended to
support nop10 optimization testing.

> diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests=
/bpf/usdt.h
> index c71e21df38b32..d359663b9c329 100644
> --- a/tools/testing/selftests/bpf/usdt.h
> +++ b/tools/testing/selftests/bpf/usdt.h
> @@ -313,7 +313,7 @@ struct usdt_sema { volatile unsigned short active; };
>  #if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
>  #define USDT_NOP			nop 0
>  #elif defined(__x86_64__)
> -#define USDT_NOP                       .byte 0x90, 0x0f, 0x1f, 0x44, 0x0=
0, 0x0 /* nop, nop5 */
> +#define USDT_NOP                       .byte 0x90, 0x66, 0x66, 0x0f, 0x1=
f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 /* nop, nop10 */

Will this change break the existing BPF selftests that explicitly expect the
nop,nop5 sequence?

Looking at tools/testing/selftests/bpf/prog_tests/usdt.c,
subtest_optimized_attach() uses find_instr() to search for a hardcoded 6-by=
te
sequence:

    const char nop1_nop5_combo[] =3D { 0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 };
    ...
    addr_2 =3D find_instr(usdt_2, nop1_nop5_combo, sizeof(nop1_nop5_combo));

Because usdt_2.c is compiled with the new 11-byte nop,nop10 sequence,
find_instr() will return NULL and cause the ASSERT_OK_PTR() check to fail.

Additionally, does libbpf need to be updated to recognize this new sequence?

In tools/lib/bpf/usdt.c, has_nop_combo() appears to be hardcoded to check o=
nly
for the 6-byte nop,nop5 sequence.

If libbpf doesn't recognize the new 11-byte sequence, it won't increment the
instruction pointer to skip the initial 1-byte nop. This would cause the
uprobe to attach to the unoptimized 1-byte nop instead of utilizing the
intended optimization.

>  #else
>  #define USDT_NOP			nop
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518105957.1234=
45-7-jolsa@kernel.org?part=3D1
