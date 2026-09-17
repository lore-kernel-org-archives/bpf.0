Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A457356771;
	Thu, 17 Sep 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683074; cv=none; b=uH5I1/aSLhrT9Qqn0nyy0STOJMT6iENruEBUQ07mHjI2bOnw2UKt8xA2t5lQD8j+AAq5lnUKGN9ALyTAK3AXJVeXt/TauH41LHMJ4UKXunibjEqYcy1EJFMHkHU08prlQjDy3IrtZUSqC91Fr90XKILqD1xEGthdctpwXi3vpik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683074; c=relaxed/simple;
	bh=0NStLTEhXHdAglvcmrPkVq0/EHnfM0NHy9slF2x4Zho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V6bjup31vOwq47NdjLMiH6F46nVA9rKts67Q03CbfWSLORBaD/50bUxAenCHOKN7HoCzJgHfdNgw+P0xUhJgb6yNkNVm0KOuOIR86GhL+IPpgtFpbuutllBKWyD6KCGpU6uOTV6vBPML1qC+/hqUahyFFMb1Rb19CSFtH96S06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG6BkPFd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG6BkPFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5001F000FF;
	Thu, 17 Sep 2026 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789683070;
	bh=+vfxTSJcT5BA7/Js19xIy6kC8S6qzGRZLs8DTBaZ+1E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jG6BkPFd4RL2HHGoxKpvZXHB/Xuvut50SmkdYJ00JKnoiGEyzhsQ6Ttw5SpndtvNJ
	 KygcicMAVg3WNbIcCoJkeGAOVaE9aGJDm5NqfGUQdg57es6l7x464bKIcuRGZUFgZQ
	 tyH84b+GN8AvBrvUOtWpV/JgjeiD2witEM1n11ThIR3sacVyyyxJd9X5Ufcyw4sLr9
	 ZIMfKKNQXLup0c78H9ms5HcwG6K9mEpDMrn+TdNpYGGFcjVcPwym75m+5OM8BGXcxA
	 vUlrebmpuPhOdX4NG6640DmKGOUaRBX7yAzz+LB6KqyJz7EEwsil1eS4p3X2QVuqOQ
	 1rpd/q0pzY1Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939113811974;
	Thu, 17 Sep 2026 22:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Skip unsettled links in link iterator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968300439.3896646.5761530373602686511.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 22:10:04 +0000
References: <20260914170206.170723-2-bestswngs@gmail.com>
In-Reply-To: <20260914170206.170723-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 9erthalion6@gmail.com, xmei5@asu.edu

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Sep 2026 01:02:07 +0800 you wrote:
> bpf_link_prime() inserts a link into link_idr before anon_inode_getfile()
> succeeds and before bpf_link_settle() publishes the ID in link->id.
> bpf_link_by_id() treats such an ID-zero link as unsettled, but the link
> iterator takes a reference without this check.
> 
> If anon_inode_getfile() then fails, the creator removes the ID and frees
> its still-private link directly.  The iterator is left with a dangling
> reference and its next bpf_link_put() accesses freed memory.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Skip unsettled links in link iterator
    https://git.kernel.org/bpf/bpf/c/50e80e2bb5e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


