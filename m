Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E442046D2A4
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652641; cv=none; b=sayamK9nGA0ra/3VyfF2AypnOCdO0T4iHyIseh0njwtmRzSXr6qURD554on+SwDAT9nURuhnnbil/8mkWLemdHh/M53tsJj+kOupLAGG2WKuirO7o8yeZ/SG+XjAMVfc7OCR05FZ8S+yMsjPuA+G70QmRKhDNAR0iL71jDXd9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652641; c=relaxed/simple;
	bh=kszPNptZHOMvQvXwz2Q8DwX3eJTkxrE4cUdNgZWgq04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hrbMofjiOuEkyEz0qp5Dfhg0UZO7Sn4JZNJgwjaLlkqW5hMQFHpyYObzEUdMyrT9nB+5ny9/+1QNOunQtgI9JqHS9hWmwgWBxykUAgVzSkLCI6SRFKt1F2G1eKTZcKAy3oENsn0iuklevEare3Mm4TfMfgfLu0n3CJuW+5mNpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOosbKTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOosbKTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865831F000E9;
	Tue, 21 Jul 2026 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784652640;
	bh=8Q9h1/i9XjvwZd2ALJwxGf//V5OF1OdkYjxWlGVmYmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NOosbKTWyyGTEaNJSMKJtIND5cYsOMrzWmqOrv+xohC5Vsv6TAlRSxbzMm1X2pVnO
	 n9fg3txIFI4qXNw5Z01I0fr3A2pC+C8sjb74XFLjuyPUAMBD5Cjo2Mcpd6QW0Dv+bd
	 K5/S+1HJQd9AycpW8DzzJPIpsQC3lQPibTuJEwjaBZuoIkAQc08tonLgRxJvofBTfw
	 Jn+RUzapl+VDyz1Gmkj59asrXJKr+uEwS6Z4WL1zePpmwnESuHDju6HkIDmNdA8AEL
	 41TGdP9pw4LUGXLOfpoUCkicAPMvDaPjQ9LoyU+yO3KR2rISMepVJYpldrldOLMzvD
	 /K/vDz5zSi1uA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696039253C4;
	Tue, 21 Jul 2026 16:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf,
 arm64: Optimize cast_user code generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465260989.839953.15657975732566546495.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 16:50:09 +0000
References: <20260721105921.1070501-1-puranjay@kernel.org>
In-Reply-To: <20260721105921.1070501-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, xukuohai@huaweicloud.com,
 xukuohai@huawei.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 21 Jul 2026 03:59:20 -0700 you wrote:
> cast_user converts an arena offset into a user address by combining the
> low 32 bits of the pointer with the upper 32 bits of user_vm_start, while
> keeping a NULL pointer NULL. The current sequence always emits six
> instructions: it materializes user_vm_start >> 32 into a register, shifts
> it into place, and ORs in the offset.
> 
> The upper half of user_vm_start is a constant, so it can be written
> directly onto the offset with MOVK. Move the 32-bit offset into dst
> (which also zeroes the upper 32 bits), then MOVK the non-zero halfwords
> of the upper address, branching over the MOVKs when the offset is zero so
> NULL is preserved.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf, arm64: Optimize cast_user code generation
    https://git.kernel.org/bpf/bpf-next/c/5f30ac94727e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


