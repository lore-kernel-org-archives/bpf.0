Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF5D25543
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510628; cv=none; b=tmC3Z12wRTb6FCTFEhRrqCSpZE23MCbE/J1FUAHTO79DFenne81eLrnEImiHaFXDGWxVe+0+KPL+34qegqBIeNfK0h/fJ/QTL7bgdbsxUHoEQQlBvEDg2j8RpxUpo0leTZ6HlNTV4MG3+/EiBdRACI/kAVBIf7y/pgUS7aaY3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510628; c=relaxed/simple;
	bh=AfcTpi6nw3hCTZ5fZoFOHcU3xNfxhiPu7YSFG1cLTZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=le3UUXI86L8j09y4/b46WhtJzQMpTnnYme8QbX7vtU2wtUWuIy5vphEZnE13/sIJIsvq1Cl06Jz99O055IT5LJv7u2ybj+J08mj8nNUoezyDfIhd5UyqsKpg5Ub5OUCAaykZQfxw25V6j7Wylry74urRg2C0zrp2QXYmrGMn4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB6VAWRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB6VAWRE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CCFCC433F1;
	Fri, 15 Mar 2024 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710510627;
	bh=AfcTpi6nw3hCTZ5fZoFOHcU3xNfxhiPu7YSFG1cLTZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GB6VAWREQ0dS2WGAnIJEqeM57WhKz3pzMe4tPBnKBMcbxx+0bQFz1jfhYGZfm0GgC
	 CtwnVcgQSjq33E6FaqPgm1ydzq8i6RBUQeJvxpWbH543MyA/QaDnfRd2EDsEIL7pyG
	 NNRgiykf6nrnmF0gHRUymIp7pbW71kA42yTEPgON+ZTqqVoNDb4agnhlz+guA1K6i2
	 VMU53mhpai7kLYPwlj0cuJJ2LJDvMxEe4TEeYCydURtsILcNxjRk57xnX5bsVX1zIy
	 PBQc36QvvRQ+2jwVLdVDFJ3IL7q/mnZ1aOdZByjwJnvNSAx2GaeVtqHTL2FGSYOK5U
	 VZrqTtY+7sjaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69465D84BA8;
	Fri, 15 Mar 2024 13:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf_doc: use silent mode when exec make cmd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171051062742.25120.11238831827593087092.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 13:50:27 +0000
References: <20240315023443.2364442-1-liuhangbin@gmail.com>
In-Reply-To: <20240315023443.2364442-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com,
 alx.manpages@gmail.com, mhofmann@redhat.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 15 Mar 2024 10:34:43 +0800 you wrote:
> When getting kernel version via make, the result may be polluted by other
> output, like directory change info. e.g.
> $ export MAKEFLAGS="-w"
> $ make kernelversion
> make: Entering directory '/home/net'
> 6.8.0
> make: Leaving directory '/home/net'
> 
> [...]

Here is the summary with links:
  - [bpf] bpf_doc: use silent mode when exec make cmd
    https://git.kernel.org/bpf/bpf/c/5384cc0d1a88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


