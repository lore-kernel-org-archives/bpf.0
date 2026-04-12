Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCEE1FE451
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 05:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775972595; cv=none; b=uhtJ2DPTK6X/LcRtkaOUt/djLu/2wybT9qo4KMNEi3qO5A63ErGr0wcZ1kYqvIK4avEU6zQ16PtN5Gkik/+2XrP9P6weBjyWM2Tn5FHXLHSFxe/TZiKu5Qp8Gg65WeMgyCvEovpBQF8LeO1MGH5qmdwAX1nW8oFaq3Yr35ziv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775972595; c=relaxed/simple;
	bh=+ITyfEBJb6/uSPGDI3B7be2logDaIiPfKDma6qUtkw8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wwe/SsX4oxgV406tVm0gauUJiI/D2gi8K8MUkgiW7+nxFHUN0qKM7C0f7uzDCMd5wB1pUxHsEuQVVFKoM7z4HiCTnRr2aHxJ9IFRLGZYE8HMyxKh+UTXO1L1OCDFhyVE2f5zaYhmnopMmmY6jBfm2zYqlIdULBDSZemxmSlQENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUG5IYPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUG5IYPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DB9C19424;
	Sun, 12 Apr 2026 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775972594;
	bh=+ITyfEBJb6/uSPGDI3B7be2logDaIiPfKDma6qUtkw8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=FUG5IYPGhT2LxKNl2ZAY+8mmogfBzyBn55PtSVlcUc6D2mRA66YMbV6TzqhSO6P0D
	 re7h/qM5yaOZuLzfck6ApsJ0WppPKnc4vWV1ozllseRLtw1BsFFRIlLIr4/q60LiCz
	 +eiptXJxpkIonKuRV7hM+LeCAzCTQM68GEqRihvQ5Vczy3WwYLiha3qSw7lLQMF56t
	 05UmOwIDklYY8XoYApy9LAkJUFVGMAvRtlX8H1Ft6Co52EmXivZB1EBL7X6Ku4lwib
	 Q+UQGdjD2NgkZvmbvMB+B/QWlzB65fLb0IUFrfZG+H2MJSb0Bn+oKeV9oIJWTmAocC
	 EgQ1wLNOGTBhg==
Content-Type: multipart/mixed; boundary="===============8406630557783566353=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <928fac5880ee0f617245a8cb45a88a00eb03fa2137e18fc8943a4505a3df50be@mail.kernel.org>
In-Reply-To: <20260412050000.262030-1-yonghong.song@linux.dev>
References: <20260412050000.262030-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 10/18] bpf: Fix interaction between stack argument PTR_TO_STACK and dead slot poisoning
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 12 Apr 2026 05:43:14 +0000 (UTC)

--===============8406630557783566353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 7570556100592966981ed4784bb775307405e5f0
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Fix interaction between stack argument PTR_TO_STACK and dead slot poisoning

This commit fixes a false rejection where the verifier rejects valid
cross-frame stack reads because the static liveness pass cannot track
indirect references through stack-argument-passed pointers, causing
parent frame slots to be incorrectly poisoned.

This patch fixes a bug introduced by an earlier commit in the same
series but does not include a Fixes: tag. The issue is introduced
when stack argument support is added, because BPF_REG_STACK_ARG_BASE
(r12) is not tracked by the liveness pass. Without attribution, it
is harder to identify the scope of the fix during bisection or
stable backporting.

Would it make sense to add:

    Fixes: 442d7da1edaf ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635
--===============8406630557783566353==--
