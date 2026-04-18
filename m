Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6827118A6A8
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776473560; cv=none; b=qVMQHOW+fWGZGgnPGpAvxL63+WeEpMlcY3Nqi91dL8FySEx0twQ8rDPyLICFv/MTC9UvlGrnYM77vF0al0KVRUY+vY3pgkpSA11N1A3QP5LeRhzJ2VVkkTbCBbwPBRqFzjKXDEu8CBTG4ITOJejPXOktmgaVbPO8bmfdpFibwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776473560; c=relaxed/simple;
	bh=BrcTcPM8k8m8Godpf1wQcQPVc8Vyf8pWoKHOVmrMWCY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XmeM0V8QqtBoZIy+jHU1FjCJcAP1GXwvxDQ5/J2yKXtAG8AmB1HCLetKGd2TjJ5BlKHb/aXiIP/3Xnzz82WMPEMLRDgsyEzZrYVTnkEWjabqrBaN4/zkx0RksJhepctwV6K39vmsDW8A/3JAh+Vl9ysCkN1BVp2m4r69/4S/AlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmN+Wxlu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmN+Wxlu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE22C19425;
	Sat, 18 Apr 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776473560;
	bh=BrcTcPM8k8m8Godpf1wQcQPVc8Vyf8pWoKHOVmrMWCY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gmN+WxluwLob8FY6TWXKKu8P3ImGKNAxZy7pr2nEQUD4mhCjFm7ui4cU693WMfZsM
	 6VVeJIlaFAwuE9DppgdzpqOK4pxmtbBlBjhcVeGfUi8oX/T942yJOs0yHndpMlAsZs
	 F5DhSNWYmPOFu5tuYJWyaWLL2dqHDP/gWEB54vnc10zbDNBSDxOeDrrKlkJSE3d/kT
	 lWrij3uo3Y0KZ20Z3WmyRuFU6wwqalN1wz3rffEmcUb9GqFUbxSvw1rhsvlWn0AnDb
	 t1vFp7Jpu0PWEV0iIbFXRM/NL1QZMg8HKn/Ts2nGUnoKOdZ9Ak/XFSHrTKRN0f+4Ix
	 jMr61p5DhXuaA==
Content-Type: multipart/mixed; boundary="===============7287181267751871159=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <690707ccb6647cb641ed5069473393dc7b862b7e34d8f67a4949556aec627a15@mail.kernel.org>
In-Reply-To: <20260417034744.2630316-1-yonghong.song@linux.dev>
References: <20260417034744.2630316-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 09/16] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 00:52:40 +0000 (UTC)

--===============7287181267751871159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Reject stack arguments in non-JITed programs
>
> The interpreter does not understand the bpf register r11
> (BPF_REG_PARAMS) used for stack argument addressing. So
> reject interpreter usage if stack arguments are used either
> in the main program or any subprogram.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Should this include a Fixes tag? The commit addresses a bug introduced
in commit 13ee5d67a7c9 ("bpf: Support stack arguments for bpf functions").
Additionally, bot+bpf-ci@kernel.org noted in v5 review on lore that this
commit fixes a bug but lacks the tag:

https://lore.kernel.org/bpf/9b0ca90ef418abe68516e5570b953bbbee79f418c1550255784baf8422e9e3c0@mail.kernel.org/

Suggested: Fixes: 13ee5d67a7c9 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============7287181267751871159==--
