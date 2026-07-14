Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01283342524
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000207; cv=none; b=Kyfsf7+nXjq3r6Bswfgn3flszuAoYq7P3Pvj9NZ9UTvL0Xy10mS591PLCTR9dTchORaCBPrTheL5KF/u+DHjsJxNhAnmnK9Xl18hTF3l8l/DvuDAug7Q2mHlfFhqHVcRRIvQ2T9AAy7jD282dxuPU/qPsCXiXVZTIVR1Us9kc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000207; c=relaxed/simple;
	bh=1vCqvhUHcRsIXqFXJSYyaKb4VyH6I0iGBE9hLL5tbKs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oyf6QAmL0FN0s+MCicGTFsOeJG54cWL/vNXvDk76tvQFYIDdP0pPO5ii141BavOfQ4Ku0MnlNkSS5k/mr7T1brChO5nkdHjHv//H3m44H8gD8WHCKeBIPfMzE+fpg+bK9r9XOz4UGudFsQe2f18fZ3UdASHJMuOOE97V/M16B04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qJNOg3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qJNOg3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656CC1F000E9;
	Tue, 14 Jul 2026 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784000205;
	bh=2SFG8gXx37lMK6UYABLcKml6+U5aDOkVwtDSrVm37F4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=l+qJNOg3ENbQWcR6s/2h2neOPUFpW2prgjMKiIYOIrwun/ZudCbQjzE7736wfxfQZ
	 8mqzXJHtSJdkkvyhGYgg1TjDbNvyPF1Fi4xe5R/VZkW+bzFdFSEqT6CeMU4TlDo68N
	 VSzlQofd7bmRs3va+/5xN75hSkaQQc6GjifoODzcYA/Og1HzM/q4IFSsb6uUUrh/Go
	 tPz8nhKVuRzL7vYUV0IZ1epwGputQz45f4ZswcdphuQLAIVbh9+G5sG/ga1+M0B7HT
	 blcp2i2EI80KOQyOknp0Ljy2ljno2ZLd5AdM/i8F3wACjJvgvsg8y3A4cwLwZ2VvER
	 Zn8kyJRBUIwCQ==
Content-Type: multipart/mixed; boundary="===============1889907060490196146=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b72813f0ba5f1b0477d538a852642fc8b07240ea61714931893d59d659e2f4be@mail.kernel.org>
In-Reply-To: <20260714023939.616686-1-main.kalliope@gmail.com>
References: <20260714023939.616686-1-main.kalliope@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf, x86: Add support for BPF_SDIV and BPF_SMOD in the i386 JIT
From: bot+bpf-ci@kernel.org
To: main.kalliope@gmail.com,bpf@vger.kernel.org,udknight@gmail.com
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,visitorckw@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Jul 2026 03:36:45 +0000 (UTC)

--===============1889907060490196146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> emit_ia32_div_mod_r() emits an unsigned divide (xor edx,edx + div ecx)
> for BPF_DIV and BPF_MOD regardless of the instruction's signedness, so
> the i386 JIT does not implement signed BPF_SDIV and BPF_SMOD (off == 1),
> which get an unsigned quotient and remainder rather than the verifier's
> and the interpreter's signed result for negative operands.
>
> Add signed support. Pass the instruction to emit_ia32_div_mod_r() and,
> on the signed path (off == 1), emit cdq + idiv ecx instead of
> xor edx,edx + div ecx, mirroring the cdq/idiv-vs-xor/div split the
> x86_64 JIT uses. bpf_do_misc_fixups() rewrites the zero-divisor and
> INT_MIN/-1 cases out of the instruction stream before the JIT runs.
>
> The RV32 JIT has the same gap.
>
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8

This looks like a bug fix for the i386 JIT compiler. The function
emit_ia32_div_mod_r() has only supported unsigned division since it was
introduced. Should this include:

  Fixes: 03f5781be2c7 ("bpf, x86_32: add eBPF JIT compiler for ia32")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29302361966
--===============1889907060490196146==--
