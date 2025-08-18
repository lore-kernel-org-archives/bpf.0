Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E3261B99
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531596; cv=none; b=sOQIfMQCE5efzNmdOydlGTdtHdCqvchj8OUNtm/B6I3/IGBiVyX0ivGmhOUAXdsz9dufzoJ+Dj14yOY1nmEeCshYJ/2n26qcQDF/1k3aH6/RyblwDktbQiQO8a9DympQMdnffhkvvMnAyBfKDDC9b1zdKnVR5rcVWk3ZoqiR5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531596; c=relaxed/simple;
	bh=GiVDYmZB5nsGE3AXmw2MtHJ6fI45d7hmV6bswi2ueuY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lSsrbexvdY4Oaku3pF0raamjP5dI/8r351eKWPhakhhelFRuEEK3/MrAlCnWhUP8CoD9BmC27oSU4Q2P4yqeYpCbz10ZobwyovcITEor9APB4Ylki+Dwbk8xclcVU8Y5cMDb0exe0hOwslhKaDvEP4q5i0ZdLEHCjNal8E8P+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+9/OT83; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+9/OT83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2835C4CEEB;
	Mon, 18 Aug 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531595;
	bh=GiVDYmZB5nsGE3AXmw2MtHJ6fI45d7hmV6bswi2ueuY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y+9/OT83NPkYad/3XARQpsYq1BLukNsHXjOR7addDmYhmn7tAkq6JnY/AeatFD5bu
	 D2YrPvwoQOxdbZqeQOdZROGSxkj2/v6/bu0JPORmYN1mzAOXwQKDgRJJzt6u38bU31
	 9j3vm/LOTB51mABKRrEB4Bhv9bT138krxNDJHADYnsANy+oXpp0UsfO7Vbb9KlMGhA
	 yyAT58/ano2e1QvolqW0elIVF41zfYekNzhHBvrnGenUg9noyR7W/sMewUUeYeEByN
	 w/UaPOWlac2zHOCbJGK1Bu4bKVEK0w/hFQ2YKoP/od1+fCtG18E29KP8q+aJa3KpOK
	 8rEJEIe9JvGWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DEE383BF4E;
	Mon, 18 Aug 2025 15:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: add a verbose message when the BTF limit is
 reached
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175553160601.2802574.247803000131436535.git-patchwork-notify@kernel.org>
Date: Mon, 18 Aug 2025 15:40:06 +0000
References: <20250816151554.902995-1-a.s.protopopov@gmail.com>
In-Reply-To: <20250816151554.902995-1-a.s.protopopov@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 16 Aug 2025 15:15:54 +0000 you wrote:
> When a BPF program which is being loaded reaches the map limit
> (MAX_USED_MAPS) or the BTF limit (MAX_USED_BTFS) the -E2BIG is
> returned. However, in the former case there is an accompanying
> verifier verbose message, and in the latter case there is not.
> Add a verbose message to make the behaviour symmetrical.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: add a verbose message when the BTF limit is reached
    https://git.kernel.org/bpf/bpf-next/c/dbe99ea541f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


