Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A313EA83
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560227; cv=none; b=I266bjRGZJ2e3IQgMjfz60nbHWW00GV9Alzd5GGKPdAlr/2cd8R1dGQWfrvYb1bntTlJoElouzF7TFPFAN0vDCm0EbuUMwZHcfTPaJGafe3e/GNyLBYo+3R2NU8Pr5IxzyrO8M48tQgYB+dMd6jtwHqzm1rJ5chcJX7Xrpc3CRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560227; c=relaxed/simple;
	bh=catrGbzLj0QcmFDeAp3EehgP0o1FUKcO+v1tKBbSDlY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XGr9o5F0ZOCSP2Em9sY7K6y08j2EL5FgaUpfB52rxlhwYw/MQOlPPP2gwfvt6VeL85xnjxeWdnSdiEDo+tZxI1ldykypQSHaNw3kyiDlTTfTIEYxIcw4ArpV+GaYBIg5jxNdMEdgKCPPZ8gLzRxgv1mdGqqGJksMPxNrrJmoI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9bzzfZ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9bzzfZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C9F8C433F1;
	Mon,  4 Mar 2024 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709560226;
	bh=catrGbzLj0QcmFDeAp3EehgP0o1FUKcO+v1tKBbSDlY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S9bzzfZ7uOV773ZBHiT4LPJ/LazPl+UBM0GEixbt+osL3yrHS5TbRrM1hd1EkO5Aj
	 B774q5QACtt7YMB9y5tfeqGgN359uD9OuEdLsFe0dAD71UOOQuLbfQ/yZkmhlR74lV
	 YiVVRaDkeF5QGdKXJuWzIe5zYZk5vWGTPYOIDZjxcsNK8qxhxJPidgNFK8pvy4Q7Wr
	 Sq9UHl/eVEiOZy7CcTi2If9RMBD8PCZbDhCEcHiAHxtf4b7TGS34QKfybxOUvCDBeW
	 76ZHclCnSz+mxJRYeqUWo1sghwtgQ/5yUJoquAjc7RPquiTBbDw6Fuo57snYqcIc/n
	 m1YQdFOLU3Taw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82518D9A4BB;
	Mon,  4 Mar 2024 13:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: extend uprobe/uretprobe triggering
 benchmarks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170956022652.2345.17175566564276393716.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 13:50:26 +0000
References: <20240301214551.1686095-1-andrii@kernel.org>
In-Reply-To: <20240301214551.1686095-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  1 Mar 2024 13:45:51 -0800 you wrote:
> Settle on three "flavors" of uprobe/uretprobe, installed on different
> kinds of instruction: nop, push, and ret. All three are testing
> different internal code paths emulating or single-stepping instructions,
> so are interesting to compare and benchmark separately.
> 
> To ensure `push rbp` instruction we ensure that uprobe_target_push() is
> not a leaf function by calling (global __weak) noop function and
> returning something afterwards (if we don't do that, compiler will just
> do a tail call optimization).
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: extend uprobe/uretprobe triggering benchmarks
    https://git.kernel.org/bpf/bpf-next/c/8f79870ec8a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


