Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC563372049
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030934; cv=none; b=qJ6MukYTvBSUlLsz6NyQEjWac4bMqbZq1SW0Y1xq3LK5AlRt1eKN8bbQAyIOCWpJykQemO2a8SLTSSuR402ZyBpBr/D/jFin2Qubekbm81kW729wrGzRLWpu3vHwI38qYT6NwG4KEQi9VSnxx1Vkg0mlx2Ue0mEkIs7Kpqs+YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030934; c=relaxed/simple;
	bh=wKWoGLlq+4mfh4pvYBkRnt/SbcaIvU/Ynv3IEz5edZs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YgtaPR36cbPhMZ/V48mmDDlfeKbyEm3ZybpyOwBTnM7TdoFf091uyQNcrwj2xKNeIGKr9o5ZzMVThaKBWmwFwQOPXP7vmUbc8Qv5emdNvkkC5FnewvmsusfGnymMr8ZRvMZphWwebAnXG+w5coi6JBq2oaduA+FgpNLIw+WaXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUiub0ku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUiub0ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0801F000C4;
	Thu, 15 Oct 2026 02:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792030932;
	bh=wKWoGLlq+4mfh4pvYBkRnt/SbcaIvU/Ynv3IEz5edZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUiub0kulLjwUmptjOLdAT1uS/dvM9rL9r4uezVRq5m+1tg9mX5lKbt2c5FjlNQzK
	 Rdj2T7rpYFgQ0dhf9gS8zbjZ3C1UNiRewX0P3pzPgWXyZGmQ2Ujc1YPMGB1ukxJ7ty
	 nYuWA8qC5ehDufkEfFCVRYqsjKNt6DRGvbPJ05uDjJUdOyvlDEdwrAX15494PjsXUH
	 rdG6PRDAxFySXW0q63x01w5+qKtAqOYmCAxwV1Zp9ybp7mcW9/T+urk9FGR4GDK/0M
	 ddtXufUfT7hWM7F7by3RrWhoBRGrkIrQuRvfK29vLrXuJX81J2jxaBdmfuih49j0SS
	 LGIeO+JeQgIug==
Message-ID: <sashiko-outbox-172140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Enable private stack tests
 for riscv64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261015021238.5657-3-cp0613@linux.alibaba.com>
References: <20261015021238.5657-1-cp0613@linux.alibaba.com>
 <20261015021238.5657-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:22:11 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: Missing enablement for private stack test in verifier_large=
_stack.c for riscv64
--

commit 6110b152bad2869b21761f9abd7de948a19afdbf
Author: Chen Pei <cp0613@linux.alibaba.com>

selftests/bpf: Enable private stack tests for riscv64

This commit enables the verifier and struct_ops private-stack tests to
run on riscv64 by adding the expected RV64 JITed instruction patterns.

> selftests/bpf: Enable private stack tests for riscv64
>
> The RV64 JIT now supports the private stack. Allow the existing
> verifier and struct_ops private-stack tests to run on riscv64 and add
> the expected RV64 JITed instruction patterns.

[Severity: Medium]
Was the private_stack_two_frames test in verifier_large_stack.c missed
in this patch?

The commit enables private-stack tests in verifier_private_stack.c and
struct_ops_private_stack.c, but verifier_large_stack.c contains a test
that explicitly validates the verifier log messages for a 2048-byte large
stack (private stack) setup, which is currently restricted to x86_64 and
arm64:

tools/testing/selftests/bpf/progs/verifier_large_stack.c:
__arch_x86_64
__arch_arm64
__success __log_level(4)
__msg("stack depth max 2048")
__msg("subprog 0 (private_stack_two_frames) main {{.*}} stack 2048")
__msg("subprog 1 (priv_stack_frame_2048) static {{.*}} stack 2048")
__naked void private_stack_two_frames(void)

Since the RV64 JIT now supports the private stack, should __arch_riscv64
be added to this test as well so that the riscv64 architecture receives
this large stack test coverage?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015021238.5657=
-1-cp0613@linux.alibaba.com?part=3D2
