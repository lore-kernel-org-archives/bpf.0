Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29465377023
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783998529; cv=none; b=WhJcAyZrJbf6xr8pQo1I2+/j+zmC3/F2Ut7XXbjbDH2yW2DcnEX0maVkTK3pHpg/cvWFo8UAXrudEb6ZcP54oyD/lHgdvagrjPDuXlOHI9Llet4GTw+1auNXLIzAm0WTuapoIBeiQ8gfExI6lIDZHGmzFWNsLUrJ9Kimym0mAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783998529; c=relaxed/simple;
	bh=RGPIQvo+6RezGITTY5TlxaZGH4plblmXtELXC3KGNlg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z1GC6nON22h0zB9a55O18rVDKvSyceAw/Ipojmc3w+uTkG/6wImqL796c6f7OvkzJ/+VknQUeKc04L72Q/fFDTplSFjz95k231XiGwaKH0Mcn5BKE9MN/VhuI1+HyQ7m5G2EmVojjGp5PbrM/WNg21ub5r85CJMPzQEmT8/JVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KV7sbPgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV7sbPgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE41F000E9;
	Tue, 14 Jul 2026 03:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783998528;
	bh=IpOxy6KJVKvEBb4tbTsQdRiZSdRue0D3ebGwXAmTQOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KV7sbPgRqdtk69fmxCuq4f4tGDv5tKX1jse4poGL9tXLuxitkhTiJAHh5Tu1uiaGf
	 YYoIea1mveqKNrM5JSQnqCFxoQlCNX8gAgJQpvu26dQr2qBhrNmhPWsqu1roAqByi5
	 FHJqanzjv8LacZNuXPF6QhTxcFXitSPqYcNyG1xx7otut4G0HDL23lLNEIa4qXgrUd
	 FTELnef6d/Ef6GpGSOdYLhRN98WTMZk5pJGptHrN4/quc9O0LfZF0IQJnDqcuzjH0V
	 H9DX3ntL2QRiaNJisY0+ujsvrKDWmNVslrXAJKVxfuyWfIgPJTJnuHnTJNRVuEm9yu
	 k53VD8t/coEwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: enable timed may_goto tests for
 riscv64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Jiang" <jiangfeng@kylinos.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260714-riscv-bpf-timed-may-goto-v1-2-3988601fe6ac@kylinos.cn>
References: <20260714-riscv-bpf-timed-may-goto-v1-0-3988601fe6ac@kylinos.cn>
 <20260714-riscv-bpf-timed-may-goto-v1-2-3988601fe6ac@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:08:47 +0000
Message-Id: <20260714030847.E3BE41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing test enablement for riscv64 timed may_goto expansion and=
 bpf_fastcall interaction.
--

--- Patch [2]: [PATCH 2/2] selftests/bpf: enable timed may_goto tests for r=
iscv64 ---
commit c54da59713ded8c765c2c6ab6331451df77083c9
Author: Feng Jiang <jiangfeng@kylinos.cn>

selftests/bpf: enable timed may_goto tests for riscv64

This commit enables the verifier_may_goto_1 and stream_cond_break tests
on riscv64 now that the JIT supports timed may_goto.

> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/s=
elftests/bpf/progs/stream.c
> index 92ba1d72e0ece..8d8e53d37266c 100644
> --- a/tools/testing/selftests/bpf/progs/stream.c
> +++ b/tools/testing/selftests/bpf/progs/stream.c
> @@ -64,6 +64,7 @@ SEC("syscall")
>  __arch_x86_64
>  __arch_arm64
>  __arch_s390x
> +__arch_riscv64
>  __success __retval(0)
>  __stderr("ERROR: Timeout detected for may_goto instruction")

[ ... ]

[Severity: Medium]
Should tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c also be
updated to include __arch_riscv64 for the may_goto_interaction_arm64 test?

This test verifies the expansion of timed may_goto when interacting with
bpf_fastcall, but currently lacks the riscv64 architecture tag.

riscv64 shares the exact same verifier translation and fastcall behavior for
this path:

tools/testing/selftests/bpf/progs/verifier_bpf_fastcall.c:
    ...
    SEC("raw_tp")
    __arch_arm64
    __log_level(4) __msg("stack depth 24")
    /* may_goto counter at -24 */
    ...
    __success
    __naked void may_goto_interaction_arm64(void)
    ...

Without this tag, the test for this specific timed may_goto interaction is
silently skipped when running BPF selftests on riscv64.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-riscv-bpf-=
timed-may-goto-v1-0-3988601fe6ac@kylinos.cn?part=3D2
