Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E34DA552
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555378; cv=none; b=T//GbgH8CetIVVxit6v3+t2Y/4g9s5/5U+v8q3X1yHsJLLlTQHRf0+zidxsQlz2KuLe8l2WAbhEk25IoVV4dzxe2PcGxnVFMAKzuvRghi87SFhMfeAMhyJpbsO7HC7f06LQE0EOB1aEBmClqDeqlwUICnvOms4gnPlBK1ldZPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555378; c=relaxed/simple;
	bh=BY5G1NRxuyMsQZJBOz/VqqG5cvCVR93ARsdhy73TK3o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=h1teFD7+PrrSBK4do5RY2bXaXK73VemB3u2sdVLH+ojFTY8DQwlFRbqnHh6sijT1Gun/4OGzf2WGb282dV3luLZubPt8o86n5or7Lx2+z46spMwW/bGLJ5hZJIlxVjmjfeYId8fbTWhe4Qbi9qNVwD3S3J9RiiUpMhaHjXZvYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V9g/OBGJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V9g/OBGJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C5CBFC40FA0;
	Tue,  3 Mar 2026 16:29:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E066A5FF29;
	Tue,  3 Mar 2026 16:29:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28AAD1036875A;
	Tue,  3 Mar 2026 17:29:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772555372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vxEKFs0jFuv6u4VJhIGhmJsnyai2CUMCJeV8dWAXHLQ=;
	b=V9g/OBGJCkYKEquzv3iFqY58vCKodgkgdEE4Ye5HIsVuNVKWXt1iFth0miD4iIVc0YHGtO
	brqiAKR1unqtUd2Q91a1TY6oPHhcABPV8oYKEecCUCMuscYngy6FuCADq8cERfoICZ85SM
	dKH+MXepzfk3oHg8lT1Oa2Kbi8+x5kzTb1YPrazrOW4pDLmLupuCHPthNb2Y8VL0KrbyoG
	utiwSpqnjv9m+EQZN7AB1RdauZtz/aWqsrOROc8aI8pdu+reKnTdYGZvab1vWW3O5dfA+o
	g2V6dgiwyplXYdrynyXAKSWQEPWAd3XmPl1PZ5WKdkQtg/LhmMJxFudAR3jHgA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 17:29:27 +0100
Message-Id: <DGTAFQ1WX43H.2R6R1RS5F09Q7@bootlin.com>
Subject: Re: [PATCH bpf-next v5 0/5] emit ENDBR/BTI instructions for
 indirect jump targets
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Anton Protopopov" <a.s.protopopov@gmail.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
In-Reply-To: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Xu,

On Mon Mar 2, 2026 at 11:27 AM CET, Xu Kuohai wrote:
> On x86 CPUs with CET/IBT and arm64 CPUs with BTI, missing landing pad ins=
tructions
> at indirect jump targets triggers kernel panic. So emit ENDBR instruction=
s for
> indirect jump targets on x86 and BTI on arm64. Indirect jump targets are =
identified
> based on the insn_aux_data created by the verifier.
>
> v5:
> - Switch to pass env to JIT directly to get rid of coping private insn_au=
x_data for
>   each prog

Nice, thanks for this. As discussed in [1], I'm planning to reuse this
in my KASAN work to pass info to JIT comp about ldx/stx instructions
(especially, whether those insn are accessing prog stack or elsewhere).
So far I've been using a small POC aiming to do the same kind of thing,
but your series made me aware of a few points I missed, like the offset
induced by constant blinding. I'll keep my work rebased on top of your
series, and track it until it is merged.

Thanks

Alexis

[1] https://lore.kernel.org/bpf/CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2=
xGkE-ZNw@mail.gmail.com/

> v4: https://lore.kernel.org/all/20260114093914.2403982-1-xukuohai@huaweic=
loud.com/
> - Switch to the approach proposed by Eduard, using insn_aux_data to inden=
tify indirect
>   jump targets, and emit ENDBR on x86
>
> v3: https://lore.kernel.org/bpf/20251227081033.240336-1-xukuohai@huaweicl=
oud.com/
> - Get rid of unnecessary enum definition (Yonghong Song, Anton Protopopov=
)
>
> v2: https://lore.kernel.org/bpf/20251223085447.139301-1-xukuohai@huaweicl=
oud.com/
> - Exclude instruction arrays not used for indirect jumps (Anton Protopopo=
v)
>
> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweic=
loud.com/
>
> Xu Kuohai (5):
>   bpf: Move JIT for single-subprog programs to verifier
>   bpf: Pass bpf_verifier_env to jit
>   bpf: Add helper to detect indirect jump targets
>   bpf, x86: Emit ENDBR for indirect jump targets
>   bpf, arm64: Emit BTI for indirect jump target
>
>  arch/arc/net/bpf_jit_core.c      | 19 +++----
>  arch/arm/net/bpf_jit_32.c        |  4 +-
>  arch/arm64/net/bpf_jit_comp.c    | 21 ++++----
>  arch/loongarch/net/bpf_jit.c     |  4 +-
>  arch/mips/net/bpf_jit_comp.c     |  4 +-
>  arch/parisc/net/bpf_jit_core.c   |  4 +-
>  arch/powerpc/net/bpf_jit_comp.c  |  4 +-
>  arch/riscv/net/bpf_jit_core.c    |  4 +-
>  arch/s390/net/bpf_jit_comp.c     |  4 +-
>  arch/sparc/net/bpf_jit_comp_64.c |  4 +-
>  arch/x86/net/bpf_jit_comp.c      | 25 +++++----
>  arch/x86/net/bpf_jit_comp32.c    |  4 +-
>  include/linux/bpf.h              |  2 +
>  include/linux/bpf_verifier.h     | 10 ++--
>  include/linux/filter.h           |  6 ++-
>  kernel/bpf/core.c                | 93 ++++++++++++++++++++++++--------
>  kernel/bpf/syscall.c             |  2 +-
>  kernel/bpf/verifier.c            | 22 ++++++--
>  18 files changed, 157 insertions(+), 79 deletions(-)




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

