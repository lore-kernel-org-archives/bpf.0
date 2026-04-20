Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1993A380B
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720140; cv=none; b=tAkXqjepGZRLoYb4FcptdZ45qgQ+Wl5tcQ8PGb+tjLNEPGVt6mQEohZ7av/GdsfdA1ramAYCjxi2DAA1bDxmnUPg/K531qhnwq8bn8fdiaaHzgYlpV9C/oqJ1hH6CcpTOzpfSCNcFpBrIWX8GGwtsdf7KfZ7/GZc3/+47vmtv+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720140; c=relaxed/simple;
	bh=8Ip6MOhvWXUj6WLmycSlGI8h7MjEEImQac68rcbTYPU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WfUg/g4tSmwgYzeOHwm5tLhZXrGV7MsfIdcT8VcJyMt5tZV3MNFJKizREYSJVVl21Jk+MXDDWpDk9NWCM/lkPOKzK8rpYGa/z12LtoyDec8z+tK5Efb7HbuMeIN3ER0ru5MR5H0wgws8PYLQFWEHFr9eXvuQ62mogaAFDOqvwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBniTkz/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBniTkz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F26C2BCB0;
	Mon, 20 Apr 2026 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776720140;
	bh=8Ip6MOhvWXUj6WLmycSlGI8h7MjEEImQac68rcbTYPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hBniTkz/rGxZDYt6d1bq6rQ3O88cL3Ixc+mVd712BIaCybbNQDx3kpR+ehpQjo/xj
	 x5n9E7tOXLLuF1454mrl1SD31uw+6RtxVqXO5WIwQjiPx4C26SKHzceWCXX2rnMTPn
	 Z1TlR33TL1XEAzu/S+vQJe9CfIdOYPCyogejxtFfh3ovhLlzs0KRP7/XKiNF+XaP4D
	 MeBIQRME588FiGjMQ/HbNhuzcKkMpnscebVBpR6g3Qc//1cwH2huEmKhMPFSY5wiS1
	 ngz2agtnI1t6ZKQyyEVT4iA7dxm3vSM/bDeUaBYp2h+3gxDJNW7+8yXhW3pLReQx0S
	 NNRwdLA2pAcYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.10] bpf: Do not increment tailcall count
 when prog is NULL
Reply-To: sashiko@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420132314.1023554-191-sashal@kernel.org>
References: <20260420132314.1023554-191-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 21:22:19 +0000
Message-Id: <20260420212220.13F26C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Incomplete fix creating BPF architectural divergence: the tail cal=
l counter is still incremented before the NULL check in multiple BPF JIT im=
plementations.
--

commit df5323d5a23d7d76d6c427c88e1a292e4d37a90e
Author: Hari Bathini <hbathini@linux.ibm.com>

bpf: Do not increment tailcall count when prog is NULL

This commit updates the BPF interpreter to increment the tail call
counter only after verifying the target program exists. This prevents
failing tail calls from exhausting the limit.

Link: https://lore.kernel.org/r/20260220062959.195101-1-hbathini@linux.ibm.=
com

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 7b675a451ec8e..67eb12b637a5d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2087,12 +2087,12 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
>  		if (unlikely(tail_call_cnt >=3D MAX_TAIL_CALL_CNT))
>  			goto out;
> =20
> -		tail_call_cnt++;
> -
>  		prog =3D READ_ONCE(array->ptrs[index]);
>  		if (!prog)
>  			goto out;
> =20
> +		tail_call_cnt++;
> +

Does this change introduce a semantic divergence between the BPF
interpreter and various BPF JIT implementations?

While this updates the interpreter, multiple JIT implementations (such as
x86-32, ARM32, s390x, and RISC-V 64) appear to still modify the tail call
counter before performing the prog =3D=3D NULL check.

For example, if the JIT generated code updates the counter before the NULL
check, and does not revert it on the fall-through path, the counter will
remain modified.

Will a BPF program making many failed tail calls now exhaust its 33-call
limit when JIT-compiled on these architectures, but not when running under
the interpreter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420132314.1023=
554-191-sashal@kernel.org?part=3D1
