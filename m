Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751A5FB81
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127430; cv=none; b=tQk25XVlr13PJISImFVDInd64+zGRqLshSJOowRpvTN/bpUWhmoE+DAnvuCHP2jymIQBvv86azegv5iofWT2Dw1jOLtkDxHJ4kUeikT/W/Fge5A/3Al/n7GeY9Cyuy/gIiwLEsidn3OS3p8NXbqADtjClxfRrEVZNWyFCazfePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127430; c=relaxed/simple;
	bh=oNnoEVPYYabXLKeoAklVVxAdYk5ezvuxM0GlMM/0KB0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XeLub+AFfeYnshwHK8ONBVz6fu0cQMYuaZhezCkC8gwYl6jB1CvL7mww3Hpn+6CodkRlppnSX1ehUp1iRS8ny4mRmPEGKlYljLwzK7QdS4UX6MkoXpyINFhWHNoUl8b9IJjL9AWu8/OhRDDRGEDF/PuNlpJdrFlfDYvAH4sQMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHsEqYjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHsEqYjV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE5DC43394;
	Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711127429;
	bh=oNnoEVPYYabXLKeoAklVVxAdYk5ezvuxM0GlMM/0KB0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHsEqYjVR5959fafgn2SlRyh/vKvFYU+bAfcQlbP/t4KD8b7GumysF96oa195XL0Q
	 88RazU2iorP1e8GRXxk9xMjv6sQk464XVqqxZLS+PgGu5swABDXU9/Y/PSHBmbotIN
	 7AD04GBTVD/oEhPWHt02W23+XkhjGs9vYpirEVoWygXrLdFtMfDVgjZeqDFj3uxNNE
	 EYD/zbvRPhOtmCzgg+YijbVlxz5G8U0dv/OOXtlHLN6k2TUQXYFFJGN73d1dZZKVJe
	 WgH2vBzAgL2qivikF25JkvcwiOlhs50P1mLvR9T2zIJKyKfgU4ugpkBHkYBbbkP8Nf
	 oIKrlhoRcMlJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4989D9505C;
	Fri, 22 Mar 2024 17:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Mark uprobe trigger functions with
 nocf_check attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171112742973.3285.4148849344808411338.git-patchwork-notify@kernel.org>
Date: Fri, 22 Mar 2024 17:10:29 +0000
References: <20240322134936.1075395-1-jolsa@kernel.org>
In-Reply-To: <20240322134936.1075395-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
 haoluo@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 22 Mar 2024 14:49:36 +0100 you wrote:
> Some distros seem to enable the -fcf-protection=branch by default,
> which breaks our setup on first instruction of uprobe trigger
> functions and place there endbr64 instruction.
> 
> Marking them with nocf_check attribute to skip that.
> 
> Ignoring unknown attribute warning in gcc for bench objects, because
> nocf_check can be used only when -fcf-protection=branch is enabled,
> otherwise we get a warning and break compilation.
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Mark uprobe trigger functions with nocf_check attribute
    https://git.kernel.org/bpf/bpf-next/c/af8d27bf15c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


