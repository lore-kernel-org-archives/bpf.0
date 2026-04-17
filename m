Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8D359A9F
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776400209; cv=none; b=rwbVCRqx3o2M1w4w4BLm71ZyjsKwRCJ3RNOePqzGZGhiwgQo7bgRScYUbIt2pUzMaS/apURZ2KavORaMWfbRKtV0rfBODMy5JTscwEqsJ9p6LL7clJZ30ox3C4x8hYkwjALFR3bnWLR8wEc4S2K4lwREdz1rH3QQUq5B1mKtyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776400209; c=relaxed/simple;
	bh=xv2P4fZ64JaL7VGzvlLuQYeqdNCsV+56RBy6nbr9mrE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TgYTcxfxvBnqcJH5wzQfbi2H8u/XScVqbUqKSEEdlXB7aYJ02N/2EaMq2oxBnaXDCdIwsGVwXX0htCSSZzdCAie/VEZb4s9ez3D9cuhmMRrpnYFer87SX8KI2z0iNva9vF4dHbnLbGM7IcKDIcj39TLRTk6wWBU6Myqgz+PXFNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDyTfdcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDyTfdcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29358C19425;
	Fri, 17 Apr 2026 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776400209;
	bh=xv2P4fZ64JaL7VGzvlLuQYeqdNCsV+56RBy6nbr9mrE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MDyTfdcfW5aEyI1NYboWjo55z7Wu+ineS3M0rPfJq3Ok/LoldfvpOqnpYuN04u+X5
	 bZa+XyhA9zEcF8ZldYo3VKduVI4Ah60sEyAYtx9TaQEQNrc/I586WmJpLkKcV59p4t
	 VyJ7+WVthVAEtD7yujfyFjt5DiVrYn6Fewut4NptznuzkOFcr9Ftyg4LnD/ZVnR8mJ
	 uyF7wfyzcL/bTQkjZBGk1kIh6hmGpMcWXkdISA1/HEWIl4qKHmWo3WuHNtr2ekdpwA
	 IOaAPPANX2eJCbfnrG387NEpAj3QUh+KXZ81D0llMi6QlRvH2oYQBzP/GV6NsBD+Kh
	 bNddA59Yxs5+Q==
Content-Type: multipart/mixed; boundary="===============2498480886275247749=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9b0ca90ef418abe68516e5570b953bbbee79f418c1550255784baf8422e9e3c0@mail.kernel.org>
In-Reply-To: <20260417034744.2630316-1-yonghong.song@linux.dev>
References: <20260417034744.2630316-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 09/16] bpf: Reject stack arguments in non-JITed programs
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:30:09 +0000 (UTC)

--===============2498480886275247749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


commit 6f3447bea13f86a674e917f5f8ef4474cdd3b0bc
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Reject stack arguments in non-JITed programs

The interpreter does not understand the bpf register r11 (BPF_REG_PARAMS)
used for stack argument addressing. So reject interpreter usage if stack
arguments are used either in the main program or any subprogram.

This commit fixes a bug but lacks a Fixes: tag.

Suggested: Fixes: 21229535935384b01e3cef3c117233b23b2f3902 ("bpf: Support stack arguments for bpf functions")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============2498480886275247749==--
