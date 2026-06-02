Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928732E6B8;
	Tue,  2 Jun 2026 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364435; cv=none; b=uIci8ifszXSwW+21qiC69fy+pXy/4vO4SkoO7QUZ4RM+Ob5/76hrLvg0VWBz6+4NgxaGkMl1gNFsEHdT8OgX0Qr/U5PB3/vpwqMMaiivQKc7ORtUF9rkl6DUdSQ1B2oHi9HB3VUIh/4jYDK2fL+uQ02vqaLDgTEMqqv3KGlcIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364435; c=relaxed/simple;
	bh=eBXxR9fM1xEcxDJ//Rk2yLojWgRB7UoC8I57rqFmnzg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYxMznkju4rQCkeFvgbf1NquPc5XmXNRpeIwOeATbCsL5cX2ufc7alWWrqlFODTTiSf3OsWxGpNM/r0MBTmwUhdV5liwdyjHOTzdwD+XhHZfQGk4KFGhwsCVXmAXqx29WLolRhdz1ZtbaEehpE07oS9bNB9DV3NrVwyEqTkwpK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpH/MER8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpH/MER8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ED21F00893;
	Tue,  2 Jun 2026 01:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780364434;
	bh=Z8N+MQLGjizdgSde7KO/MqpA1myZQEWQPyqTQrCvX00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lpH/MER8uiDm1+RVD59CcDYNYl4R6FC/izMgN9LOl9eFuBO3b0js3Ji7r8tf72QhZ
	 gPl8/bD34R1/GS70SbJ12dN07eG9UjMKcbllYZBgIDv9pwmsMFJydTM7M1bSB9PVAu
	 IfraGXDVwG1KQEpykacT07cmxaxUmcOK/WF9KH/jwlrDPfCq5A0fjXg6DVbyII8znL
	 CzxE/1PRKnG7kMOxUh9vocNyvGGIb9e6pj6WAonQlVEjkwSO0loCfvlM1/b8u1vLbT
	 bCx+eobgOy0SFD9PHRyezRZNeri2LeZUDhkGgFqFdEPsMVcoESjYdAMtcG4LQopvSb
	 bPo2WtmS+KBxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93EF038119F9;
	Tue,  2 Jun 2026 01:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 00/13] Refactor verifier object relationship
 tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036443613.197970.8921687935908707515.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 01:40:36 +0000
References: <20260529014936.2811085-1-ameryhung@gmail.com>
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
 andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 May 2026 18:49:23 -0700 you wrote:
> Hi all,
> 
> This patchset cleans up dynptr handling, refactors object relationship
> tracking in the verifier by introducing parent_id and folding ref_obj_id
> into id, and fixes dynptr use-after-free bugs where file/skb dynptrs
> are not invalidated when the parent referenced object is freed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,01/13] bpf: Simplify mark_stack_slot_obj_read() and callers
    https://git.kernel.org/bpf/bpf-next/c/bab08d1f7043
  - [bpf-next,v6,02/13] bpf: Unify dynptr handling in the verifier
    https://git.kernel.org/bpf/bpf-next/c/b5c0a07eb2c2
  - [bpf-next,v6,03/13] bpf: Assign reg->id when getting referenced kptr from ctx
    https://git.kernel.org/bpf/bpf-next/c/94ac7553361f
  - [bpf-next,v6,04/13] bpf: Preserve reg->id of pointer objects after null-check
    https://git.kernel.org/bpf/bpf-next/c/06d518a5583f
  - [bpf-next,v6,05/13] bpf: Refactor object relationship tracking and fix dynptr UAF bug
    https://git.kernel.org/bpf/bpf-next/c/308c7a0ae885
  - [bpf-next,v6,06/13] bpf: Remove redundant dynptr arg check for helper
    https://git.kernel.org/bpf/bpf-next/c/92d681b42746
  - [bpf-next,v6,07/13] bpf: Unify referenced object tracking in verifier
    https://git.kernel.org/bpf/bpf-next/c/b7dd2b388657
  - [bpf-next,v6,08/13] bpf: Unify release handling for helpers and kfuncs
    https://git.kernel.org/bpf/bpf-next/c/bcfcb15fde94
  - [bpf-next,v6,09/13] bpf: Fix dynptr ref counting to scan all call frames
    https://git.kernel.org/bpf/bpf-next/c/2eee6fe8ac2c
  - [bpf-next,v6,10/13] selftests/bpf: Test creating dynptr from dynptr data and slice
    https://git.kernel.org/bpf/bpf-next/c/fbcc68af6047
  - [bpf-next,v6,11/13] selftests/bpf: Test using slice after invalidating dynptr clone
    https://git.kernel.org/bpf/bpf-next/c/925320666e06
  - [bpf-next,v6,12/13] selftests/bpf: Test using file dynptr after the reference on file is dropped
    https://git.kernel.org/bpf/bpf-next/c/3f75a757a3af
  - [bpf-next,v6,13/13] selftests/bpf: Test using dynptr after freeing the underlying object
    https://git.kernel.org/bpf/bpf-next/c/60c7c3b880c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


