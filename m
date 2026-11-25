Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579697;
	b=rUztHM/XvvWkMlypHi9/GgZ8kpkBNSVyUIuXIKljOYs4EIegAHS3oXGpbrf1K7g/quh8
	 IGk7wrrggE25oYru9wSoW2okMakDcemiLwbTYdlOhCX/dKlJ4vMrQ5gzf9py8Rvjj5X6G
	 5Y7mjkcZxqd+nzu9UZVlZS26iiCIq35p4uYOACcZEEPk1Hy/tnpSAcnFrMOpya09kVNGH
	 yKgmfibHF5FaBv52hBCniyLPVpba/TtdWeLEbn+QkTxYsJHGgkZpbCg2nvlRzDj42cTpG
	 GjeCunn9onfLCGVuYQ5R1CK+ArHvEFCgU4bKaANcYOrX8CR/af87C5/CP55dpnBmr3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579697;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=43aCqDgOx3MtWoX1pBWImMLkmf3xKFnvveLbX4CTpnY=;
	b=z5Sqyqz647/yAPrgjXERuO89shpJfdfqi5R2eEcnEkfMd47q0IFm9lRCDQMJcHR9FFvK
	 cZMWu/DeEO+du6MjzuMRKdu6pnaQeReQ4Vv6xfFfR7DYPH0djMJ5AZAGIdDe6YKnt8dyY
	 tLtin4T5GjQtBLTsY6SGpsyyn9Jyq8tt/3cnf3peLZ2Ev0FYGF1OZneWXtv2UBXI1SlGe
	 Y68R7//j2MAbgjndkgppSS6iof4BueBrWDnQeuFHAogTmDCaQsCFY1Q8PHhSJ7YNwFmXJ
	 oHaInBK7ba/hYTsqpYeffRUjlNsqf+xJaSIrb/FmzmTqJyAnlvm7uYmLCiLrAgl+Gng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flX0FwUZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A72606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 04:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flX0FwUZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46581F000C4;
	Wed, 25 Nov 2026 04:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579697;
	bh=43aCqDgOx3MtWoX1pBWImMLkmf3xKFnvveLbX4CTpnY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=flX0FwUZ+G2xXiGRgAhteuC09XyWiuZsRKO5arxoLfyn0ppFD9glqy9Tiuru1DZMk
	 dgI2ErRAdj5symFIxzjWDU0GfGyv7QMGaT1SS9aFFb6E596uiJlY8VCnEacyv/mI3b
	 3NjKu5fZEBCPbMFqi4Wk8HkDOhh8L0ur0sOvrhhdOIw6S4lYNOfVvlRvu3uED0pyS3
	 kZUv6DTkhOyCuwhw1WMlRWEeLbzCLwRBiGrv6ASrpTfXotRipDE2fLdrZw5nFc+JWO
	 KYXzE6NzEllD+nHhOhjKYcmOSVYev5A2uQ1Z/KAsrZmD4mljc1/BeelPUiMbqd4uFE
	 PybfxwgbIOwLA==
Content-Type: multipart/mixed; boundary="===============7683592179212360325=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <73457dcc88e3cae2c4ebed4ede59597f8275a46f3bb4e91fac816df7b5bc3516@mail.kernel.org>
In-Reply-To: <20261125032938.670542-29-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-29-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 28/47] bpf: Limit reads of variables of the kernel
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 04:08:15 +0000 (UTC)

--===============7683592179212360325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Limit reads of variables of the kernel

TL;DR: Commit message only: the Fixes: tags may point at the wrong commits.
4976b718c355 and 6aca583f90b0 look like better fits for the ksym PTR_TO_MEM
and helper parts. No code issues raised.

> bpf: Limit reads of variables of the kernel
>
> ld_imm64 of a variable that is not a struct gives readable memory, so do
> bpf_per_cpu_ptr() and bpf_this_cpu_ptr(). Many variables hold addresses,
> and CAP_BPF is enough to read them. The size comes from BTF, and that
> can be BTF of the program. Loads from such memory are not probed.
>
> Ask for CAP_PERFMON, as for the access to a struct. Addresses of
> functions and of per-cpu variables can be loaded as before. Take BTF of
> the kernel and of modules only, libbpf passes no other.
>
> Fixes: eaa6bcb71ef6 ("bpf: Introduce bpf_per_cpu_ptr()")
> Fixes: 541c3bad8dc5 ("bpf: Support BPF ksym variables in kernel modules")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Are these Fixes: tags pointing at the right commits?

The PTR_TO_MEM path for a non-struct ksym variable, with a size taken
from BTF and no CAP_PERFMON check, looks like it was added by:

  Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")

The helpers became reachable without CAP_PERFMON through
bpf_base_func_proto() in 6aca583f90b0 ("bpf: Streamline allowed helpers
between tracing and base sets"), since eaa6bcb71ef6 added them only to
the tracing set.  Should that commit be listed for the helper part?

541c3bad8dc5 looks plausible for the non-kernel BTF fd check.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45542192835
--===============7683592179212360325==--
