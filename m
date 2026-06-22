Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E25233956;
	Mon, 22 Jun 2026 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090626; cv=none; b=M3OuWV6IJT2ExHZCDDMrd24b8RzU13gJnsgC8EIGeik8eJyj+eCMSTWVQWsOG+NhBAm8PWuxXoGg7qLsTbYSA7caCjwC7v2M/bhHulDa9ITRDwKNEA3CwAy/KNQbF5cl+F5yruwD72P6JzbaQ+ylT+aSlKXNDLHwB4DvEZoQQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090626; c=relaxed/simple;
	bh=ldwlr7j7awykPM5jHEO3J6l0X4aRtpKKOGFcCdrn/uo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XJnKcAKQuqtlRWmB23J5ewQ/NZJ8/OnXklqgsA5z3wqmr5nKffG8BjVWYsPWoDZ/QUcUg7CeD43BddZ01R7vBCF39GSvS74dV5Y/3opRrI+ss4567rZrT3F477ABV7eJy49mSXSJSUdwp5M1k5PPuYpv7ueieaP4ZMNI954NXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHuGrUFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHuGrUFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736511F00A3A;
	Mon, 22 Jun 2026 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090625;
	bh=N5ftLIZ4H3VywEcUWAkrBpNNtsOsJd6nhX7Tsb1yFxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nHuGrUFYwSVZDciri8Jdml4FIHIXPVRSeVCgS3jIFwrfl5Unzl3B6UoWSgrHsnoGX
	 dcVBL9FOpLWeZz1GJXksuMZB7fOWetAdHgqvXkABPQVC+W5caWxmfYn9GzkRR0wp30
	 jQiMHdZZeWOBy9unqbZijKaZpGAsAF+qt3q1bb4KiB1KcmypNL+SQyXkbnefnFxhwo
	 jqzvUYAYzhgZvw2zZPeDeNfrafVnbT8w7rDzJ07DbfwGm8Fb6QwcYNW92FBwCKtGTD
	 TTA9jSj2QTb6XivWDrum1zJDnNMhdhvGArgcWC40MAjKEeQxSJGLzrR4HFaaf2DXPI
	 8YODnQjcJ2K/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09EA3AAA6EF;
	Mon, 22 Jun 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: zero-initialize the fib lookup flow struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209061631.558026.5043530435386557482.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:10:16 +0000
References: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260617224719.1428599-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 eddyz87@gmail.com, edumazet@google.com, emil@etsalapatis.com,
 horms@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 memxor@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 song@kernel.org, toke@redhat.com, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 04:17:19 +0530 you wrote:
> bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() build the flow key on
> the stack with a bare "struct flowi4 fl4;" / "struct flowi6 fl6;" and
> fill it field by field, but never set flowi4_l3mdev / flowi6_l3mdev.
> 
> On the non-DIRECT path the lookup goes through the fib rules whenever the
> netns has custom rules, which a VRF installs:
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: zero-initialize the fib lookup flow struct
    https://git.kernel.org/bpf/bpf/c/0dfcb68a6a5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


