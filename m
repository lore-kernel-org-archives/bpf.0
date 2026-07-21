Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA4404BC7;
	Tue, 21 Jul 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657875; cv=none; b=JGje7/28tuND8brzT1/aYVvORjg+lHqDMm9c9OGIUH881ew+FOS7kTbRfWjGfnWNIPS7UQalNr1RTNegZk12IFAvhPbZsuu1TnbHBc7CZIt3CAgdyvY3XpZAxGbKktLo924ESosVVqoq/Q4ugS0hgztikclVPxpCqOAuHD/DWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657875; c=relaxed/simple;
	bh=DAgpQs99S8QypFrkxBDN2isaBOsPn8rkpC+lorqlJt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I5yeDHf3lF2OdbZ8H3Lpr8WgAhVjJndDmLPi/4A3Vhb3qz0kDJvlyihWpGJX12qBaxz0QPdEPYYZo4lbF97PhqOYWJTnHE0HV3qf0h9dUPGb7SH0nml21OxJ4wv3lVnl59bnnFjUPX2MUFEXUlCb9VVvxy7zlvXMRr488ts8mB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNdbEr3n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNdbEr3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568141F00A3F;
	Tue, 21 Jul 2026 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784657870;
	bh=DAgpQs99S8QypFrkxBDN2isaBOsPn8rkpC+lorqlJt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oNdbEr3nyDVIx1R/+Zb4Y2JnC/fLb3S2/FwdF0uGAz3dlSPLNcmI3gY+o13M54FCQ
	 7IGXIf+MrEKPeiQ4iccsPeu639yNBbxM9aBnn5ikmovOVd1I5sjApHG3BdZehzIqDu
	 K3SbTDKKP9tIt6ARfCdWy2IIIwGGe6qs8Oh0GYxcxZjuOmi4Mr/ylZKb4pIZbYcqx9
	 u4UIB6+jUaQ3TqUH1WKnvEYWF/+ak8qHq8xTKBiIw9JLNS4oeLc3eYFRmpVBmnvosL
	 7jr8o5D1jEVQ89NBV+k+3rcnUunF/WOLdWL31SN/dOlJDibpddIRB7eJxPhL1D+5Ou
	 ylrQTcIWEr+cQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Pu Lehui
 <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Feng Jiang
 <jiangfeng@kylinos.cn>
Subject: Re: [PATCH v3] bpf, riscv: fix extable handling for arena load_acquire
In-Reply-To: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
References: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
Date: Tue, 21 Jul 2026 20:17:48 +0200
Message-ID: <87h5lsurzn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Feng Jiang <jiangfeng@kylinos.cn> writes:

> emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
> a sub-word load_acquire. The caller does "ret =3D ret ?:
> add_exception_handler(...)", which skips add_exception_handler() on any
> non-zero ret, so the extable entry is missing and a faulting
> PROBE_ATOMIC load_acquire oopses.
>
> REG_DONT_CLEAR_MARKER leaves rd stale on fault, and the verifier still
> thinks the load overwrote it, so a program can leak it through a map.
>
> Check ret >=3D 0 before calling add_exception_handler(), and pass rd for
> LOAD_ACQ so the fault zeroes rd like a PROBE_MEM load. Return ret
> unchanged for the zext skip.
>
> Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Thank you for spinning a new version!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
