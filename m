Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EA3947AB
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596698; cv=none; b=mpQAYe2qj+6R/+tm4mtNj6GjlKfy/hpw0jYwo+uLT1Au5N4zs4laW74nEifq43WJY6Jl8pQCv9teCdUEmEGgTw/jiEB+ZPKinRY7dZAxBaIINPXvsw1w4z/afSyWbmflNNRk7gqOwsXWodhgEdfGOK728NCke/HFRVxtLrLhXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596698; c=relaxed/simple;
	bh=nbqpV4NSt+nCRoJdAwzLhcTK87dtIl8mHH5/IWbZUBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=It/Ednf4pB0klPJ7YwmC5jC53etHv62b30/g2MVfe3MFQbAybGCCKx+y7/BxKMxaY6e7JHfMi6vg/ek2Pil2g/D/Q8LwNoI6BafuC/FDut+eZeaJO67M8fYHwQ49js/uC+ST8FRYZkquISFe1RR7qsLrpfMEaQ2gyEUaeGmrWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E61z2BH3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E61z2BH3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD171F00893;
	Thu,  4 Jun 2026 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780596697;
	bh=1WlHBH6S38U9IbfHsTzj8krhm14S7dZpF+k2GkZVFaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E61z2BH3UzQNU2+1tigrFj0ovKajMT5rA+niS+Hqp0UZGobBnvYuXC88fzM+erjnk
	 3PQ1XT7jIbxU7AXqtGB/eRzkOXR8nveT/0pfthB1utwAULgxNoyBBQDAicLSXj2uqr
	 DTsQA1j4LBl7jJX7366rN/X1u+cXDoltCAMJX7G60b3lM17fusRhgQ77/t4wD/75DD
	 pdFLK70LBriwlPcv85IcWfWjkU5gVPAjhjfIC0d0PycHr/1WZXMnBK3Gy0Vld/eiBE
	 zN7fA78e2kBWokJ4/KsA3UStbnZsamJnuE/JibCDvxBHOLLRT/D5rO3zhe+NrN2EBP
	 25xg/giJIydoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add tests for
 PTR_TO_FLOW_KEYS constant offset bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604180730.2518088-3-gnq25@mails.tsinghua.edu.cn>
References: <20260604180730.2518088-3-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 18:11:36 +0000
Message-Id: <20260604181137.0BD171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment uses incorrect style with text on the same line =
as the opening '/*'.
--

commit 403c63e3a50bb2db745757c2fd28a65e4268deb6
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds

This commit adds verifier tests to check bounds enforcement for constant
pointer arithmetic on a PTR_TO_FLOW_KEYS register. It ensures that in-bounds
arithmetic is accepted and out-of-bounds offsets are rejected for both
reads and writes.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/too=
ls/testing/selftests/bpf/progs/verifier_flow_keys.c
> new file mode 100644
> index 0000000000000..512e5d1d26651
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c

[ ... ]

> +	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
> +	: __clobber_all);
> +}
> +
> +/* Equivalent OOB expressed directly in insn->off; this form was always
> + * rejected and is kept to show both forms now share one diagnostic.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style? The BPF guidelines prefer the opening /* to be on
its own line, with the comment text starting on the following line.

> +SEC("flow_dissector")
> +__description("flow_keys: OOB via insn->off rejected")
> +__failure __msg("invalid access to flow keys off=3D4096 size=3D8")
> +__naked void flow_keys_insn_off_oob(void)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604180730.2518=
088-1-gnq25@mails.tsinghua.edu.cn?part=3D2
