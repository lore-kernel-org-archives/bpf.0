Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396C31F9B5
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106206; cv=none; b=FKqHk+zLaODNM+HXzZ0+ksRjNp0TjLwFls9ObmK1kn6f6rPI+Bbfr7uuvjI4DAw7dRCb3pL9lCUiciErgzdcUe1Da3p4ZmpbTrRYuVBS6ajZoNPcYIRToNocBtcExGNJgxvl7pBOi7tX+DmM+FNs0/38bHY4lAXOuhSKpcL9gRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106206; c=relaxed/simple;
	bh=3AoFu4kcrF9uPFHHrmG9R1qJLfuRXbFOwj243vtJL2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNP5EHPA6QpOPBN+WuxzNRlMQjzRGnosAtloJCka0sS0I/Z52iSfExsRIAlM5blN825JqxtIfZZ3B6rzwsb9KQ597rkymMba0ZQuqFwpBOChet1KOpVokfTrfGnujMzGTwBaQgf94hR8wpqHVE6uOslV+wWJWz3PcYp4G9I0jfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7d5kiwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7d5kiwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920DAC2BCB0;
	Wed,  6 May 2026 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106205;
	bh=3AoFu4kcrF9uPFHHrmG9R1qJLfuRXbFOwj243vtJL2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D7d5kiwDcW+CC+peJDNt1qxbd3jlG9NLV4oux16IQTADjZPHvqL+rBxZBHTYFi1+6
	 88poKpmvKRCOowf5WNDbJf+HZFV4/T4QadNBswJwJvBpw8J8CwovoTp8vdXo/nPkLw
	 qUtftbWaHMR+egwG92BYinuElOGHEAL6gRG6HYStEbZrZKCb4QA46iC0JFGYQJ5x2F
	 jkUJhTI/RQbw1a3JgObexuCQ6otl0QjrT/lcb3YQr9jkHV9jLJSTBXWBIhUNGgDvcv
	 kR2z7pamG9b3yvjEgDKvc7ciI8UjisYn0Myu0Vu6bAbfIszSS+ad9DjNvhEDOjUfd6
	 OKxigLbNcLjmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] arch/riscv: Add bitrev.h file to support rev8
 and brev8
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260506175207.110893-5-ynorov@nvidia.com>
References: <20260506175207.110893-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:23:25 +0000
Message-Id: <20260506222325.920DAC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Selecting GENERIC_BITREVERSE conditionally on HAVE_ARCH_BITREVERSE=
 causes a Kconfig unmet direct dependency warning when BITREVERSE is built =
as a module.
--

commit 500623b90fe7e30bdea603dfb1e1f54158143ee4
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arch/riscv: Add bitrev.h file to support rev8 and brev8

This commit utilizes the RISC-V Zbkb brev8 and rev8 instructions to
efficiently implement bit reversal. It conditionally selects
HAVE_ARCH_BITREVERSE and GENERIC_BITREVERSE when the extension is available.

Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d235396c45141..a708583f785db 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,6 +104,7 @@ config RISCV
>  	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
> +	select GENERIC_BITREVERSE if HAVE_ARCH_BITREVERSE

Will this cause an unmet direct dependency warning if BITREVERSE is built
as a module?

In lib/Kconfig, GENERIC_BITREVERSE is a tristate symbol that has a dependen=
cy
on BITREVERSE. Because HAVE_ARCH_BITREVERSE is a boolean symbol, if BITREVE=
RSE
is configured as a module (=3Dm), the condition for HAVE_ARCH_BITREVERSE be=
low
evaluates to m but Kconfig automatically promotes it to y.

This forces GENERIC_BITREVERSE to y while its required dependency BITREVERSE
is only m.

Should this select also inherit the dependency (e.g., select
GENERIC_BITREVERSE if HAVE_ARCH_BITREVERSE && BITREVERSE) to cap the
selection strength and avoid the warning?

[ ... ]
> @@ -128,6 +129,7 @@ config RISCV
>  	select HAS_IOPORT if MMU
>  	select HAVE_ALIGNED_STRUCT_PAGE
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_BITREVERSE if RISCV_ISA_ZBKB && BITREVERSE

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506175207.1108=
93-1-ynorov@nvidia.com?part=3D4
