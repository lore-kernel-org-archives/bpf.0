Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4380937B00F
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587909; cv=none; b=EoBDAYwl/IwB2odHp8PYq8Fm/ayzp7z3vwdPuGlYNIkAvndm1CWHphYN2il8lfnzLnSpS+biGkOMM+1j63Z3SpctoVrRsV7/+brxdUgil76BL/U3ZGOUF+BTNi9Ep3FLr7wiRNanVm0TgcuZPDT62RffniiiPWrjVzvKO/y9fCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587909; c=relaxed/simple;
	bh=801kMK/unUHIxO9Nt+pGdNiZSI/KDIiPptBLiYHw1vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E42jZjbDFMzg7l9yU77426YCVn3pjmh0kmxOetyP7lbeYMSSIMvp/gN3G4oMa6TUeURbL9F1Lj0cvpAbqyKh+I6Dii9CDep1DP/vzJcVrLEctFu71giy7z8GHEfxmYVt9gAaf36gOaiu7NSaB/mWYtKWsG4QgmHiD1H7yyZQ/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsWafN2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsWafN2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CB51F00893;
	Thu,  4 Jun 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587907;
	bh=mfVjFOpeUoPNZDl8LS2eMrKQIlxZOYFylpwcR4C5sxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GsWafN2HFSyVPej3FKDeL861av7sQ3J8gfAnfoKZtjSiBJDNDERaRHi4ojjTgj8Vf
	 IDJTExECgPOFWXkYIWI4IQdHaA9V/qnz+xtrBREbhW0EW/qOIc6x/Bve7KvZjR7zld
	 pJl9rOROKNqf6kqUEkZ+YVjp0FVONVlRPkBb6tM+o2yWXZ/HjPFS7AhnveP7nCW+YA
	 cbR8ZoU1toVfdO3seVpZ0vPD77SedZ/RJ+r7RV2r3exdgBkHshTMbc1g8+mlvcE/kB
	 os4MvidzuT3g+URq50jH5sZHvJQWO0p8j6RJmZ7h1XJi/9K8qrMJYjxs4uaNo2yRGv
	 9/AJj5DsOr3pQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS
 constant offset bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuiqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604150755.2487555-3-gnq25@mails.tsinghua.edu.cn>
References: <20260604150755.2487555-3-gnq25@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:45:07 +0000
Message-Id: <20260604154507.B5CB51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] BPF subsystem multi-line comment style violation.
--

commit 86bbbe949c13579e90a39499cabd9dc701da0bef
Author: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds

This commit adds verifier tests for constant pointer arithmetic on a
PTR_TO_FLOW_KEYS register to ensure bounds checking works correctly.
It verifies that in-bounds arithmetic is accepted and out-of-bounds
is properly rejected.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/too=
ls/testing/selftests/bpf/progs/verifier_flow_keys.c
> new file mode 100644
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
This isn't a bug, but does this multi-line comment follow the preferred
BPF subsystem style? The guidelines specify that the opening /* should be
on its own line, with the comment text starting on the next line.

> +SEC("flow_dissector")
> +__description("flow_keys: OOB via insn->off rejected")

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150755.2487=
555-1-gnq25@mails.tsinghua.edu.cn?part=3D2
