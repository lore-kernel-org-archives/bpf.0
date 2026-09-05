Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01696413230
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592337; cv=none; b=TL6mn+slOfibByutMaoYCRnAspfDk6mO9HUyNVkyI/eNcrvmnbO/wzQr4cn9pMSoOucTTeK9RSbY0d6LgL4U5Wdi6v1NBCFclMOrXAdhtHAPwPkD059C+Ibu7L6twPx75EF3EvXCoDbUCR94bN33ALV5EFXvp7vaTx8cP6mNcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592337; c=relaxed/simple;
	bh=1BnqsscMj+0wNQx6hVHucc+0l5FWh+rpGMJJ6VGQ/e4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cZ5pT5ZCBhz8Ks3b3WHK4T0o0uowABYHDMpMQ4eS1dU6Vbcyl7lqJ3L/rrDR7IadSO/lSvAEzozBJfSEK1gI4zgYY5oR9Y3CkfU53Qr7+DMwWrvd2xiXPMovfYkMnCtI4VvTLHkigq8ukT5+DaVq8gzIgGT6z4bMmoOb0psPlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMG+ix01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMG+ix01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878301F00A3D;
	Sat,  5 Sep 2026 07:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788592333;
	bh=SY/CTMpSpeKcxrnE4PKQJ2moBFcX/CvyMOdx0VJOawE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JMG+ix01OETgBnHDw+xM8+RP7JqKyDbao07rd9Q52aGF37y3f8VEb7/616wB2MVqs
	 ShKMU1PH7fA/qQR51JCr/JwD6BlIoNp+edQe8gmdZ32WApuTxg43RiIf5bDIOtMm2l
	 2izUd1qBDi9yyYmyMpBOXcKOuIimZNvORTVWnGzkINRxSWH+cqRtdEK8d1P4DChMbu
	 G5Agnp9MisnRhncAEbfUqSRdXvqBbVjkcfaQV0dtRz4AF/WisA8gX4HyaGTdBCjV7B
	 wudHWalzHyVSu4UWOMU2CdXsa7Tl+kxGJG9NUCYFYklMdTXNfSm3PWfV1Qly8qCjaQ
	 47x6IFzvH4tYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] riscv, bpf: Remap BPF_REG_0 and
 RV_REG_TCC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905070409.4141522-2-pulehui@huaweicloud.com>
References: <20260905070409.4141522-1-pulehui@huaweicloud.com>
 <20260905070409.4141522-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 07:12:13 +0000
Message-Id: <20260905071213.878301F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The block and inline assembly comments in `bpf_timed_may_goto.S` co=
ntinue to reference `a5` as the mapped register for `BPF_REG_0`, which cont=
radicts the updated code utilizing `t6`. This patch changes `a5` to `t6` in=
 the instructions, but missed updating the corresponding comments.
--

commit 3f2026164fcac1b3db2387eec49e58f20293243f
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC

This commit remaps BPF_REG_0 to t6 and RV_REG_TCC to t5 to support BPF
stack arguments and unify calling conventions. Freeing up a5 and a6
allows bpf2bpf calls to pass extra arguments consistently with kfuncs.

> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_tim=
ed_may_goto.S
> index 02c637d874205..ac41bf6dcb3d0 100644
> --- a/arch/riscv/net/bpf_timed_may_goto.S
> +++ b/arch/riscv/net/bpf_timed_may_goto.S
> @@ -21,7 +21,7 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
>  	addi	s0, sp, 8*SZREG
> =20
>  	/* Save BPF registers R0-R5 (a5, a0-a4) */
> -	REG_S	a5, 5*SZREG(sp)
> +	REG_S	t6, 5*SZREG(sp)

[Severity: Low]
This isn't a bug, but should the inline comment above this instruction also
be updated to reflect that R0 is now mapped to t6 rather than a5?

Additionally, in the block comment at the beginning of
arch_bpf_timed_may_goto in arch/riscv/net/bpf_timed_may_goto.S, the text
still documents a5 as R0. Could these documentation references be updated to
match the code changes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905070409.4141=
522-1-pulehui@huaweicloud.com?part=3D1
