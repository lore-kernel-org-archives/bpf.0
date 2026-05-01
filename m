Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B547036607D
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670134; cv=none; b=OrwQuJaW85VLk0hsO8vSex+935l77skcPxsunkk358UPNkaTJbiwpiVhBYUopHabrCBlnZC8COhtv4GAyDjaY1xXrpQSuAxEDRhnHXiv/9hY8zW2ZAHF9seqfZb7dJ86iAWWov4hU3/t7DP1a4NErvDdp32HaRMCu0WAUZ41B/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670134; c=relaxed/simple;
	bh=BRcb+5D5EPYSXyRuaQ/rAopHCxWuthlPS9tqhujyswk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IwoKLKV+scmjpXiwiNGX9nxF+A1f9krL1at2ZS+QNMfOILoUhLvU8kf5Q3zWJUruYTuigJVrGMJf8wVvIHyqFEoKrjoNS/vSmQciQmCSmDERLg2bhXiBfKFo/xwe9wU9W+Zej2TgdZZTGh5JZ+ao7xhRk3JM5ENumlhMyw2gXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1fIfXns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1fIfXns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F913C2BCB8;
	Fri,  1 May 2026 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670134;
	bh=BRcb+5D5EPYSXyRuaQ/rAopHCxWuthlPS9tqhujyswk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=V1fIfXns+PMbf9L+ee4LX4nyZ+ZhFjy/y+9i1WDiQbNRBrc31rTFXU/16ZPiluvEN
	 yRc0iJ5lq6Mdz0uF4sLXlYu/kyLAAknX2vXPSWhexp5YYZQPq7outddtdLP9V6MvOT
	 7RY0abtrRoAQdbxIo+TqO7xOcrN9qkjeIrpAYH3SUrGRsxJw9dTYUrFyj5rxyJgSe2
	 UHp9/uJKdMZl+8zfVUVpJ0q7+3ghhrS1c37DiHxPzWczzEG4DADJrur3UZmXukefA0
	 othKI28aOD1QOxajoKTLKSNMum9w5J9qVWmv8mh9JE8bGFOvsggJTYmq0iECQYiS8M
	 fWR2vkTD4Agcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] arch/riscv: Add bitrev.h file to support rev8 and
 brev8
Reply-To: sashiko@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260430211351.658193-5-ynorov@nvidia.com>
References: <20260430211351.658193-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 21:15:33 +0000
Message-Id: <20260501211534.6F913C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Selecting GENERIC_BITREVERSE without satisfying its dependency caus=
es a Kconfig unmet dependency warning.
--

commit b26322371528c694cf7ce4bf22b509fc4ef43133
Author: Jinjie Ruan <ruanjinjie@huawei.com>

arch/riscv: Add bitrev.h file to support rev8 and brev8

This commit adds <asm/bitrev.h> to efficiently implement bit reversal
using the 'rev8' and 'brev8' instructions from the RISC-V Zbkb extension.
It updates Kconfig to select GENERIC_BITREVERSE and HAVE_ARCH_BITREVERSE
to utilize these hardware instructions.

Link: https://docs.riscv.org/reference/isa/unpriv/b-st-ext.html

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d235396c45141..d32309846fa31 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -104,6 +104,7 @@ config RISCV
>  	select FUNCTION_ALIGNMENT_8B if DYNAMIC_FTRACE_WITH_CALL_OPS
>  	select GENERIC_ARCH_TOPOLOGY
>  	select GENERIC_ATOMIC64 if !64BIT
> +	select GENERIC_BITREVERSE

Will this select introduce a Kconfig unmet dependency regression?

In lib/Kconfig, GENERIC_BITREVERSE explicitly depends on BITREVERSE.

Selecting a symbol directly without also satisfying its dependencies forces
the target symbol on, which causes Kconfig warnings at build time when
BITREVERSE is disabled (for example, during allnoconfig builds).

Could this select also include BITREVERSE to satisfy the dependency chain?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260430211351.6581=
93-1-ynorov@nvidia.com?part=3D4
