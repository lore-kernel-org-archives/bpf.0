Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C63EB81C
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948822; cv=none; b=Tsiu0bWij8O6d77zZgm6noB1nYrKZw6fchOQgERPVUTJ8MLA87ELObHmGZB+dyvsWvRj0ZEQZVe7RIExb8ivxBol8H8SHgeQF5veJZpfOey+guUG8S7l/IzcOqFf7mzaweLN0zO02yPTlguGpqh86kDES5gwWMh940mfNRpbUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948822; c=relaxed/simple;
	bh=SXlpUZyuzY1tK58eJQtsBBQyfjjwDNITIklH7WK8byM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XVgvcBQaRP62PXVVWh3845WQ4pi91Bvjk9np07hVa78tub+VjMXKFCvtBnWeGPmI/eOB4wTPUZIItmUSTb0NnCFmD/kNAH2xzEtm0QE/9+mnmu/dug4GOzCUi4zbgksx5LifOxVBX0HI/0PF7ehhduXMNBwenmb7Eij49FVuoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDvzROT2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDvzROT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC84C19423;
	Tue, 31 Mar 2026 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774948822;
	bh=SXlpUZyuzY1tK58eJQtsBBQyfjjwDNITIklH7WK8byM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VDvzROT2j/DCmG+98JZyjSsxN8m+dG+ePG34TLx2YKg+X8FcMVXX2v5BCghDMPXk8
	 r7/S6SfEB54rpneHMG6SYQwfyN3oO3GnNJbLD/R7I5QAeRTB4iTpJtttpKraBdkxWB
	 R4FgyULeM/gqiEQms+oTJnKKVkQ0qAW1y4xUubYEX+cRRJzbA7iCDdSovCZpBY1m2H
	 FjKTyOk2jwPUKAuwyWV6TklJUMCySeL6LHcAW4YAN2qVGeXku5g+aZl7/LWZv90XK4
	 Xn9qSowcnWV2Nkijqb5n3trrkVV/KDoKlbdDvEbLxDzj2uDCtKOiA3NizvwmtaYyga
	 zSoQJQurmWr3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D92392FF48;
	Tue, 31 Mar 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix block device hooks names
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177494880580.2195388.4807847912204264584.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 09:20:05 +0000
References: <20260330210344.3073712-1-jolsa@kernel.org>
In-Reply-To: <20260330210344.3073712-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 brauner@kernel.org, venkat88@linux.ibm.com, bpf@vger.kernel.org,
 kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon, 30 Mar 2026 23:03:44 +0200 you wrote:
> Use proper names for block device hooks names.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Fixes: 46df585fcff7 ("bpf: classify block device hooks appropriately")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/bpf/acrVKUy_EPiFFmV9@krava/T/#m7c7906a1ff4029e29185aec3266dbf5c8996dbf7
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix block device hooks names
    https://git.kernel.org/bpf/bpf-next/c/9eccdd38fb50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


