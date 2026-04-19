Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E33BB4A;
	Sun, 19 Apr 2026 04:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776573176; cv=none; b=gx4Ka0mWTedd0X2EpYTmsP52MWEi+Nvan2VU/Xe88Jzc8BODnxhPgsdpaUfj8T+ake8zrF8Vu3Q386kFITShLPESeBjTB4iiz9d/yWG1nMsz2UzgsSiiIAGyJGETV14qnwJ5cHwfa0O8Gm80bCuCM11UYsnBfaTnGhYYwXN/xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776573176; c=relaxed/simple;
	bh=L8BeoMR/S1J5cJhw4dhL2I8MvOSmN9iYYujOLMiNCiQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l7e7pKMEZCsjhB7pTG6wbFRy6qLqxtFefVSl8ozt+SoOkVN2OJKzm9847qBgxW0PMPMLBGqveGaf3qoJe9X0l/wdmQ7KD0rt3fyq9tC4gFiVqXjaBtbueoHVtqQnEJItXpgOUrRTsnf2NHH7yHlQ3utGlPEMxEpxnEEXlZFK9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoAUslfA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoAUslfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D983C2BCAF;
	Sun, 19 Apr 2026 04:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776573175;
	bh=L8BeoMR/S1J5cJhw4dhL2I8MvOSmN9iYYujOLMiNCiQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=qoAUslfA26yZanvgnKMgcjEebz5WRTxortbnChaH4CFl3VgjM6QsIsYg62VCh58ZL
	 Gi5BJJexe/xFvBb5ThEutagyWVVf2LDiDECYiFUq/nWimPhHHABuOiNGVp5/KKvCik
	 WyAUAeEyRfcCwHxa1GfIRCrQkHF9Y36ur+YvLoPZZDyTEzadaBLgVyupMt2VbsOSup
	 8alno2egypdkbaN4TQG33Cg6pA+i8EkdgknGeGK3rdTXRYwsqlnLvmRBa3wkOGyKve
	 pdq+NjwWfw/BJ12GEUDppIH8wsCST8+/mIkhzmGfG92KTgrl25T/AmpAYax5btGIW3
	 bJ20tmlnGK7ng==
Content-Type: multipart/mixed; boundary="===============5059097281938462969=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <557b90e63fb85b646de7ae4792eb2c06d6be251dcd95dabe9ed99435c82b85e0@mail.kernel.org>
In-Reply-To: <20260419040426.9672-1-avinashpal441@gmail.com>
References: <20260419040426.9672-1-avinashpal441@gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs
From: bot+bpf-ci@kernel.org
To: avinashpal441@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 19 Apr 2026 04:32:55 +0000 (UTC)

--===============5059097281938462969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 6c1cde9635b1379ee40c94c5ecc8a7d09507c0c9
Author: Avinash Pal <avinashpal441@gmail.com>

bpf: verifier: fix NULL deref in map_kptr_match_type() for scalar regs

A NULL pointer dereference occurs in map_kptr_match_type() when a BPF
program attempts to store a scalar value (non-pointer register) into a
map slot annotated as a kptr (kernel pointer).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221372

This commit appears to fix a bug introduced in an earlier commit.
Should this include a Fixes: tag?

The fix guards against NULL reg->btf before calling btf_is_kernel(),
which suggests the vulnerability was introduced when map_kptr_match_type()
started using btf_is_kernel() without checking if reg->btf is NULL first.

Looking at the git history, commit 61df10c7799e ("bpf: Allow storing
unreferenced kptr in map") introduced map_kptr_match_type() and the call
to btf_is_kernel(reg->btf) without a NULL check.

Consider adding:

Fixes: 61df10c7799e ("bpf: Allow storing unreferenced kptr in map")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24620726038
--===============5059097281938462969==--
