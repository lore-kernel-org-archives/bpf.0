Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D72D1F44
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364735; cv=none; b=G+xxQA65vLSzBxXG+yJNwErrhv3RzeHadii1NeL9J1V7vzELPYsyVzV9jxEKWNIuq79Id4vihPwFYOrsp5fwHY5aBbCUhrwNjijiNV7qwMDW+FCDkZISTtmPENlvO3m8ORQDaQdi8ox8PT9ZeB1NTIC1A8lPg37pGDT+1RLxlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364735; c=relaxed/simple;
	bh=SshgiqvOdNjRXwrP2/JMXjlbyCAgX+IEQDBiaqtomW8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iXH2jWC00xgFn2KpHBbJe75jzqBbnK9VT2HgmHnVPs88lsz8a638E4dyE6ozwbw4dVArIDEGPRoNme+7JwGfsvfrFCuY84jd24UGCX6Y63G4UtcEktloooPWlAJqGx+7n6z+E6mpYUFsi7pjXGYChOnCLmbyK4jfxn27YHEi8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpI3xsiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpI3xsiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647AA1F00893;
	Tue,  2 Jun 2026 01:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364734;
	bh=ZPhk7NsEPz+rk7UlVTfbxjc8K9Oxa13BzC2EO3R1Ov0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpI3xsiR8rOBhQUxLTjrLjieU+pMaTptBhCJUWsAQC+aSSfoTeKDbKE1syYUQMGO2
	 r0cx8R5SfJQiRrM/+bvRo263N9zJeU4uYLuBu7wnCuGz4hUfNFst5szUvgVEX+llPh
	 Wpxz8KiuNPQSLerxGd9PflaXAKkMFCwK7DioKUqRQcVt83XgKzgI5lzqI+abAldkQ9
	 f8a3ywzxZLg7sw+PjakKAeibKKb8eML9oiGkYNQi9Imm2h4NPqScLvCZOW16GbRd9g
	 CWTjiIoiYH17l0D94899+uSs8AYBDMeHdVaRvWH/HeQFEPNaKys/FO8Lz0485kcd0o
	 AmD1/LcmF0JLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: libarena: Directly
 return arena pointers from functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602004120.17087-6-emil@etsalapatis.com>
References: <20260602004120.17087-6-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 01:45:33 +0000
Message-Id: <20260602014534.647AA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning `void __arena *` natively from global subprograms causes=
 verifier rejection due to the omission of the `addr_space_cast` instructio=
n.
--

commit cebc1ff5de4bdc037926c8cf353b253eb29e111c
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Directly return arena pointers from functions

This commit updates the libarena functions to directly return arena pointers
instead of returning u64 and relying on preprocessor macros for type casting
to hide the conversion from the caller.

> diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.=
h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> index 4d57fc1b5c26f..528c69a1f38e0 100644
> --- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> +++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
> @@ -76,7 +76,6 @@ struct buddy {
>  int buddy_init(struct buddy __arena *buddy);
>  int buddy_destroy(struct buddy __arena *buddy);
>  int buddy_free(struct buddy __arena *buddy, void __arena *free);
> -u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size);
> -#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((=
alloc), (size)))
> +void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);

[Severity: High]
Does changing the return type to void __arena * break the BPF verifier for
programs calling these functions?

Since this change removes the explicit C-style cast from a u64, Clang will
no longer emit the BPF_ADDR_SPACE_CAST instruction because both sides of
the assignment share the same address space.

However, in kernel/bpf/verifier.c:check_func_call(), the verifier still
forces the return register (R0) of all global subprograms to SCALAR_VALUE:

    if (!subprog_returns_void(env, subprog)) {
        mark_reg_unknown(env, caller->regs, BPF_REG_0);
        caller->regs[BPF_REG_0].subreg_def =3D DEF_NOT_SUBREG;
    }

Without the addr_space_cast instruction to upgrade the SCALAR_VALUE back
to a PTR_TO_ARENA, will subsequent memory accesses using this returned
pointer be rejected by the verifier with an "invalid mem access 'scalar'"
error?

It appears check_func_call() might need to be updated to populate the calle=
r's
R0 state with PTR_TO_ARENA based on the BTF return type before this test can
safely rely on native arena pointer returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602004120.1708=
7-1-emil@etsalapatis.com?part=3D5
