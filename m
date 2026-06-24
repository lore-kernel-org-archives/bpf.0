Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843773BB4A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782264647; cv=none; b=DCtY/Kvp2IKTxZz3aIdLH1z7DH73LsJ7flRnoZkL/yyG4ZMbTN3r+QeKezEsr/TgglAXPa11BJsKe13eSoUjV5Wk4PoSf9l8YRDRe8wADPAh3ke7FYHHiIrSmi1ybigSEhlAX3siwryQAPfYq3TTRC7U5l+GIyPmTSUtOaXGIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782264647; c=relaxed/simple;
	bh=m3F5jJvz3N2o9ug4jmktsKSaAZEIXs0u6bohCyBxKjc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ClANDzVM7TZnld4EOMoLmJ3Mox/1XUwKi2VVcYwzpwyHeyV2VfN+Fg38umptYfCCiIK1CBhyvuwIDX/sBhHxR51qHMcBwPQu1vNqImP5Cy7tP3x7hMwCvLZlVSdymn00H1B2qzBacgeSX497kDrqyCWP1bqzLDR3uI0AYssr2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeWiY1ZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeWiY1ZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0162F1F000E9;
	Wed, 24 Jun 2026 01:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782264646;
	bh=Jz9vH98au60T7dk0yuWSxllyQVRlOIRwIsgPRWyZiKI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DeWiY1ZAAvJWzc9hA0b8RpzCkRLvT4brOy3A1avCn/MyQOcAgI7unVrZ/an2KbHja
	 zAERP+hTOcKM5vqdb8RF2iJf9wxXpd2XlEVOdv6Jt3VRvEh35Vq5WmfAqN0RTyIdQ2
	 gp36C7O/hQftYEhRWvSxHcmEGj5niKO+epVichFWoMF8BxG1kNf93ikBjjcSdA+jkt
	 Hwfv+HRxlDO+feJ2H0vqa8Kkt2fNBoMCIitUfF5diJNHBLPsKpxwDdWOv+cYgIuZ9G
	 F78jJo9bAzwNquIfxfUUgA3RigUxkO/y7Y8g6qWfaidO8vu2ErfZDV6BYHrOfoEifS
	 UA9pqmsgYEmow==
Content-Type: multipart/mixed; boundary="===============3601710770784757655=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed03f2e59e5758800d95063c6be4df9edb75abdcaede6eee364ce2ede357e674@mail.kernel.org>
In-Reply-To: <20260624005546.1818483-4-ihor.solodrai@linux.dev>
References: <20260624005546.1818483-4-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE builds
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 24 Jun 2026 01:30:45 +0000 (UTC)

--===============3601710770784757655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE builds
>
>     TL;DR
>
>     On aarch64 with gcc toolchain, when test_progs is linked as a PIE,
>     reads of BTF ID array by C name return garbage because the GNU
>     assembler on aarch64 unconditionally folds .local symbol references
>     into section+addend form, and GOT slots cannot carry an addend per the
>     AArch64 ELF spec.
>
>     Fix by marking the test's BTF ID objects with hidden visibility, which
>     makes gcc emit a direct access that bypasses the GOT entirely.
>
>     Details below.
>
>     The subsequent patches adding kfunc checks to resolve_btfids test may
>     cause test failures on aarch64 / gcc-15:
>
>       test_resolve_btfids:FAIL:kfunc_set_flags  actual 13 != expected 1
>       test_resolve_btfids:FAIL:kfunc_set_cnt    actual 0  != expected 4
>
>     The test defines its BTF ID sets with the same macros as the kernel
>     and reads them back directly by C name (in the same way as the kernel
>     code does).
>
>     [ ... ]
>
>     To mitigate this issue, mark the test's .local BTF ID objects
>     (test_list_local and test_set) hidden with a visibility pragma so that
>     gcc treats them as non-interposable and emits a direct access instead
>     of a GOT load. test_list_global is .globl, which the assembler does not
>     fold into section+addend, so it is left at default visibility. This
>     keeps the natural by-name access, works in both PIE and non-PIE builds,
>     and needs no change to the BTF_ID macros or resolve_btfids.
>
>     Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

This reads like a fix for a bug that has been present since the test
first started reading these .local BTF ID symbols by C name. Should it
carry a Fixes: tag pointing at the commit that introduced that read-by-name
pattern, something like:

  Fixes: cc15a20d5f3a ("selftests/bpf: Add test for resolve_btfids")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28067752662
--===============3601710770784757655==--
