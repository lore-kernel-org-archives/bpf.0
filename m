Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3C344025
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645224; cv=none; b=Xe9i0ytwA3QoF1RKPZYokdQxnCMhtMbV/rYv3zzKTgueOc7MIxr9bXCt6Z/G+oBkiBokq5aPkS/xDycBRLtmrWVAoZjsp0Llt+iUDhtfeT7C4tE6UWuFNU6INSr1ubmzjSXN/G2Xlcj4IPDjVeQUFsx0konyAJ2vdA5fmkmkk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645224; c=relaxed/simple;
	bh=7UGVx9KM3SV+YJdA5PoexzfJIt0yM3ClYHoknSecZl4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vbd6wjxtyN7kCQocqex9NMWyClGahLOkFARl88Fr/3jb26CtEBttAlavThbPwsfFnNzlpgrbzdLFKCUH4i4y1dKoUGfYrkHcaInKFUq5AdSCmYhAj0iSwFNqTOnlyY4An+SjBRPIU5+y4JTtAyt3eeT48XmaTt6tJPXd4pF9m1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5HTAsQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5HTAsQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E121F00893;
	Fri,  5 Jun 2026 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780645223;
	bh=lii5a5w0X2arKonxwDmV/iY4Az4H/roAlImc1QOCDnY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O5HTAsQC+S6BJIKFgnv7HVpLDGQFnXGIpervf8jUODMve5AIIzZMk64l7AhAQ+hF+
	 6gA0JYFIkH7h7hJHuFLie8QfHD2B4qD9UbwIKZqOapCPvAy8Q0caNw4eoqcmuF/rYQ
	 zfpj4ZL0+9YNxI0F+tmf4IrtK2YYPMstbaIH9Il2+crJ5jlE/uB8G8y/3wy89E0FC8
	 m6OBlvkhbWFoPF+Dn7ME4oJGZ68o83IaAjO3RU4jIKJNVLPLHTfzIe2inti0dH4jwr
	 mZ+Q2uTMdataMDthrJ3OzML17FU94jBW6qKWInJWK3w96rWEnYrMv9wrKGc3tUpfOm
	 0SE/+w0eDJ9jw==
Content-Type: multipart/mixed; boundary="===============4525208464560260098=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0d71642586dadd6ef7906ec364444985268ab264d66e1b194257ac0a17a65601@mail.kernel.org>
In-Reply-To: <20260605063412.974640-18-memxor@gmail.com>
References: <20260605063412.974640-18-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 17/17] bpf: Gate verifier diagnostics on log level
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 07:40:22 +0000 (UTC)

--===============4525208464560260098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Verifier diagnostics collect per-path history and render richer reports for
> selected verifier failures. That work is useful only when the caller requests
> normal verifier log output.
>
> Do not enable diagnostic collection or report rendering for BPF_LOG_STATS-only
> loads. Stats-only loads still need the verifier's summary counters, but not
> the extra path history used by diagnostic reports.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix.  The diagnostics renderer was gated on
bpf_verifier_log_needed(), which returns true whenever log->level is non-zero,
including BPF_LOG_STATS-only loads (BPF_LOG_STATS = 4).  As a result, report
rendering (and later, path-history collection) was active for stats-only
loads.

Since this commit introduces bpf_diag_enabled() to gate on
(log.level & BPF_LOG_LEVEL) and exclude BPF_LOG_STATS, should it carry a
Fixes: tag pointing at the commit that first added the incorrect gate?

  Fixes: a5ebc8a45c36 ("bpf: Add verifier diagnostics report helpers")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27000182395
--===============4525208464560260098==--
