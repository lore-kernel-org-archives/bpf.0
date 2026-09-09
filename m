Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513733F59C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989667; cv=none; b=bqHVPgo9HBYP1pwxQHYt8te0PAH80fiF4YtEd+O7jaEtO6bvUXuhm4l7nfuP40t9spCac8LnA3DrVITtyYsx+FVvcN5g/lcdI+kBM+SwT+wDNyO5IcvGSLwcOuAsjbG1v3iXAJ12SvePFQoRWtqUEdiwjAZNDULBGzPguvrvbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989667; c=relaxed/simple;
	bh=Inc6jLu07CF/CMcSKsqccgdRGD8hM4wxdnQ3Fd/d5No=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lHltMEa1FaIsVN4StK43tx5m1Ozek9O9DtIeq+YsT0w4rjHWvDs+t0MU2JmcEoz2PEqw1+ZCiMHv0UR6P51PJL3KpUbs3kehOPlfYC5qeCdAZKPFWFMObbFpJjDK1ztA+uclkTY+aIsowVGVSjz2cCCNEu6kdQ4I+4UuWLa5BNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMsjcNVy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMsjcNVy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EAF1F00893;
	Wed,  9 Sep 2026 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788989652;
	bh=LrXFAOIwukxlv6KZWWZ85SiSTa8JgALL21opgmOPby4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DMsjcNVyd8eOAQ3r1FwKQuev2q9IbBWxjBs2mAR7bdMNXqEdcibfxAjWm3rumhmKT
	 +kPbwvhmVN9X/k1mD8EYIVOAtIR2yh0J8wrPzche96mSrLRRW9Yat8bmHYupr7Iwbm
	 UuoJWC2Ccd+10mPn+/VsJl6lWx0GKL/po7/imBSJZd2Wv2XlkBD1Gpn9mlyI0PwIbc
	 Y6T1GtIGLXvUkyymu6GwtoetQZavS7iaSD5SgNuonrZEcpGf1T52wY31hQVOO4MfDJ
	 D8ZDYKG4T99uk7i+jtKdC8EnI58LTusQhWwd3sHPu7YH+BU+e2oUTchGEn4COtaEZJ
	 ROMgezXxNOYYQ==
Content-Type: multipart/mixed; boundary="===============3636514649328014340=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3a4002b3e522866af4590ef3657f7bbad6acd9d3fef889a866a2c0ec25dd389@mail.kernel.org>
In-Reply-To: <20260909204035.24289-5-daniel@iogearbox.net>
References: <20260909204035.24289-5-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 5/6] selftests/bpf: Add tests for the indirect jump edge limit
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,a.s.protopopov@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  9 Sep 2026 21:34:11 +0000 (UTC)

--===============3636514649328014340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tests for the indirect jump edge limit
>
> Build programs whose gotox instructions are their own jump table targets,
> which makes the edge count quadratic.

The one-sentence body describes the construction used by only two of the
three subtests this patch registers, and it is wrong for the third.

'gotox instructions are their own jump table targets' is accurate for
check_too_many_gotox_edges() and check_gotox_edges_across_subprogs(),
which both build their tables with gotox_jt_create(first_gotox, gotox_cnt)
over 'first_gotox + i' while gotox_run_fill() places the gotox run at
exactly those offsets:

    insns[0] = BPF_MOV64_IMM(BPF_REG_1, 0);
    for (i = 1; i <= gotox_cnt; i++)
            insns[i] = BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0, 0);

It is not accurate for check_gotox_edges_at_limit(), which uses the
unrelated chained-block construction in gotox_chain_fill() and
gotox_chain_jt_create(). There, block k occupies insns[k * GOTOX_BLOCK_SZ
.. k * GOTOX_BLOCK_SZ + 3] with the gotox at k * 4 + 3, while the
jump-table entries are

    val.orig_off = (i + 1) * GOTOX_BLOCK_SZ;

i.e. 4, 8, ... 4000 - the BPF_LD_IMM64 at the head of each block. The
target set {4, 8, ...} and the gotox set {3, 7, ...} are disjoint, so no
gotox is its own jump-table target in that test.

The at-limit test also carries the load-bearing detail that the changelog
omits entirely: it sits at exactly BPF_MAX_GOTOX_EDGES (1000 gotox x 1000
entries == 1000000) and must still load, which is what pins the 'greater
than' rather than 'greater or equal' comparison in visit_gotox_insn().
Likewise the third subtest's point - that env->cfg.gotox_edges accumulates
across subprograms rather than per-subprogram - is not mentioned.

Could the changelog be generalized (e.g. 'build programs with quadratic
gotox edge counts') or expanded with a clause for the chained at-limit
case and the cross-subprog accumulation, so it matches what the three
subtests actually construct?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34404843294
--===============3636514649328014340==--
