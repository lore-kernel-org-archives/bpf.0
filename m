Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1A3BCD2E
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540819; cv=none; b=f8WzR4o/ZmZG8H5uwpCJWA6NJo6ALqxijcEY6gUmPVE8q6tj1HHHkkb39hhDaj3/W47qGMpIvycf/tsyqAAlgHekOYWDbwHj3Ag5hyb/z95k/Zi414XAIOami/kZUxIznG0PD17l7YiC9Rt3KgDPChFTYHV73U8CdWBLmyqm1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540819; c=relaxed/simple;
	bh=0G9AnP2ekxSCd/AdhtErFxWQiodvpidd/NE05XddTVQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=emZYy0YONZhZWZxBweqjJ+tRA+qj9635sxP0xXmP/bFwajD2qAPPKmUh8pA/IaxwEvy0z2DQLHpE+TFHYs5a9bDMv47gILa8tE9118Jei4kM33abPsUuj3q3nrH74U9nBLMOEFvJkHtvhychgiVqlmjKpyAlesTx/bjalcjJZwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEz8Ku0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEz8Ku0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F791F000FF;
	Sun, 27 Sep 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790540818;
	bh=eClDgwZSnjspUWp/Zkm/dZWdlVOSID2MZ38IwB7vRTQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UEz8Ku0knBfBm0HMKBXzPfLtMDoA+xIfbSKBxXWJuqSBjkg+7uYE2sVgqFstMhukz
	 AcncQt42kxqA0cuXcY1FWZ6cdrBIu9YY5llnHDUfg3Z2zCrsw6AFL/tosIXdGlhf0P
	 cEQT9ZNh3UK0Degc39VDbHY8gjypAa2zForWbrJ1Y36G6QiSLd7i1+ed9Du/10rGMB
	 1uSPROuSY0wrW/2v8mxRUBdVwvfKkkFAkfNzbRxcRp3dvrlXrT2nBIS+Gffc45IDz8
	 R1CWxa4L8VFvxIa8Wv/o9gwJZequywa/Au1Etar+cWEfaXDMOHJjqAAVFCvFPr1ZfI
	 RgZvcEEqXB4vA==
Content-Type: multipart/mixed; boundary="===============0547221111940864934=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3c54a424658a3f2041ab63fe1c13f782e9f184f47c4c8e3a4dafab6f4b54265@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-17-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-17-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 17/36] bpf: move the live-register and SCC printout to a standalone function
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:26:57 +0000 (UTC)

--===============0547221111940864934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Tests for multiple analyses performed by the verifier need the
> verifier log to contain analysis results alongside the program
> disassembly. This patch moves the log-level-2 program dump from
> bpf_compute_live_registers() to a standalone function called from
> bpf_check(), in order to provide a common logging function for such
> analyses (and thus avoid printing program disassembly multiple times).

The commit message describes this as moving the dump, but log_program()
also changes the user-visible log output in two ways.

First, the header changes from "Live regs before insn:" to "Program dump
(scc? insn#: live_regs_before):". This is why the selftest in
verifier_live_stack.c needs the __msg update from "Live regs before insn:"
to "Program dump".

Second, log_program() adds a verbose_linfo(env, i, "    ; ") call that
interleaves BTF source-line annotations into the dump:

kernel/bpf/verifier.c:log_program() {
    ...
    for (i = 0; i < insn_cnt; ++i) {
        verbose_linfo(env, i, "    ; ");
        ...
    }
}

The removed code in bpf_compute_live_registers() did not print these
source-line annotations.

Could the commit message mention the header rename and the added source-line
annotations?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============0547221111940864934==--
