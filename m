Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA48371053
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427834; cv=none; b=QD/hcTGTWWWcO5rSJ9Pdnc+t5U59ePtKtdcFFQLkQxHC7HvNBcJrGhqjvzGQ/TrzRlzw1BP0GjkEbFBnlkS6gJl/J8k6cgVoAIoxUBrD3WRjALKJeh+eMpyYk/PobFTe/EDUv3fvPEREGgfjtre2GxmQa37TPud4RUfzYr0Wj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427834; c=relaxed/simple;
	bh=iCCKypoZV2Bz1Jm85FSJekT8yaT+FzgQw7ogADqsy9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3DE3jIDSMxlxoH5pHntHgunbLvUGxd7cGBoosVYuUCNimuUq9Yet+o9t6nIU5p5rH2n+Lt8HJZ8hSDf4paiJF7kGWkU2On6PKE7cZEMTyPpU4UZ3Klefvia0b2owxwUL7PTy9TTX2/wBpNVAO42KBrvCc9rs+M0xuMn4+OL3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvCKT5Lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvCKT5Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EA51F00A3A;
	Thu,  3 Sep 2026 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427833;
	bh=ZghTjcuhKX66MHyU8KuaLCkcIAYhjDzIE/lay7M+wJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jvCKT5Lj/PFP0+ixf05bITftWwGXpgsSDAffoPV+etkKwsouRgd5nf+5gYG7l5n7C
	 rWZlP6WE7Tz2Z/7YGyuUBHAiR4GV60TR/G+wx8RrUV3NkLOOsRE0O+b1hIqATsyd1J
	 G2KH3yxIRc97ztbqu1/lI3it8drI3q2kBlMucxq8t9eihwBMCCfgJI4OrHIR5xdvHF
	 ChBKVNrKfowx0z3bzYXDU9/7Jy7IM0D/TYzJa+emp7gJvUvYQWq8Tcpo0hcBHE2O+I
	 Y8x0TuUxEAlf5uiJz4wENhyr/UYD3W6K+X0UgLlYupwO0vYOIwL+GArkXXmx34AmZE
	 ipmiv8DsDZMxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903092416.223294-1-toke@redhat.com>
References: <20260903092416.223294-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:30:32 +0000
Message-Id: <20260903093033.31EA51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment in `libbpf.h` violates the requi=
red BPF subsystem comment style.
--

commit 0677df91f2b2dedb24874db25663854a4619dfdd
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()

This commit introduces two convenience helpers, bpf_program__add_flags() and
bpf_program__clear_flags(), to non-destructively add or remove BPF program
flags. These wrap the existing bpf_program__set_flags() using bitwise
operations to avoid clobbering existing flags.

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad5715403..3932bf9cb4903 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
[ ... ]
> @@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_p=
rogram *prog,
>  LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 fl=
ags);
> =20
> +/* Convenience helpers to non-destructively add or clear the specified f=
lags
> + * instead of clobbering them as bpf_program__set_flags() does.
> + */

[Severity: Low]
This isn't a bug, but does this newly added multi-line comment violate the =
BPF
subsystem comment style? In the BPF subsystem, multi-line comments should h=
ave
the opening /* on its own line, with the comment text starting on the next
line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092416.2232=
94-1-toke@redhat.com?part=3D1
