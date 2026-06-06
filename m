Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E537997E
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743432; cv=none; b=uWfxN9n8+/Q6vhLwFC3nHEQwICIrHi2SdDXP+N43KihxmxHGPd+LWs6DIBt85BKEkInqeduQHHkftAXYR8pGjWkJzqrXtpH7sWiOa2UbsV9vNDuEfKcREUJ/nir/DKw2kap5D5qGQ/dCjxpD8TIsZIFsUKq//JwjUJy5JZv3R60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743432; c=relaxed/simple;
	bh=cAIW2Yj5Yu2kma6XE8UkXRQM3+iMzoKuX2FxhqmZWRQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPJMQSp7lJXSNgD0Rag5qMIDuERTcSJm3pdiG8xqQmLayHe8rFARpY339+NrRh4IIoy20oBTU4vucBo+Yfv9mvilIbx7eaYjRox6AXxYrlHrpIetNlGi0Dc1J8GcyTQ63hyv6Ys9a3mjOfoBYjSS3g5CuS5vGa10qvAde36tkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeSdTtg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeSdTtg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD291F00893;
	Sat,  6 Jun 2026 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780743431;
	bh=cYq7GontMg/Br3dRUrNKbybGk6X95p+N+7E99qQ2Z+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeSdTtg9qaTpr9M36tD0DpAionKFxwv0Y/aL5h7Z50Wqf+LaSXvA282x78p1W64H4
	 M6kek0iEAiDs3jfmNnqOHMmlZgfvDbntQoNIXmoS0jhXMxhY5joFr3jME18PEW1fnC
	 PxIZQsndHDObE2c6oj1Pxe/Je0TrSbJwav8uKXw203eW7ePHi3e0vmPyNbUXNZDTml
	 IQ47B1S1Af8j2/rpkjCsDTBQLuO8U3CEfplwEzc5ElGvyL1Xq2E6WWmbx1Kwjk1UQY
	 upuTvkn5oR+3auJUOKvDplUmNf1lKUB4T1opQn3r3cO7vIzC8nIeswoINpXREuJl+v
	 fE94NPZVw6Oww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 PTR_TO_FLOW_KEYS offset bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 10:57:10 +0000
Message-Id: <20260606105711.2FD291F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment violates BPF subsystem style guidelines.
--

commit e1141f4c391173362f83f08e56c2a4d2bb3f8dfe
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: add tests for PTR_TO_FLOW_KEYS offset bounds

This commit adds verifier tests for pointer arithmetic on a PTR_TO_FLOW_KEYS
register. It verifies that in-bounds offsets are accepted while out-of-boun=
ds
and variable offsets are appropriately rejected.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/too=
ls/testing/selftests/bpf/progs/verifier_flow_keys.c
> new file mode 100644
> index 0000000000000..d780a36a6e9a9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c

[ ... ]

> +	r0 =3D 0;						\
> +	exit;						\
> +"	:
> +	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
> +	: __clobber_all);
> +}
> +
> +/* Equivalent OOB expressed directly in insn->off; this form was always
> + * rejected and is kept to show both forms now share one diagnostic.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
style guidelines?

The guidelines prefer multi-line comments to have the opening /* on its own
line, with the text starting on the subsequent line.

> +SEC("flow_dissector")
> +__description("flow_keys: OOB via insn->off rejected")
> +__failure __msg("invalid access to flow keys off=3D4096 size=3D8")
> +__naked void flow_keys_insn_off_oob(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606-c3-01-v3-v=
3-0-97c51f592f15@mails.tsinghua.edu.cn?part=3D2
