Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AAC288AD
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850035; cv=none; b=N0UhZgEeOcbXiu48x3c1Clula4FXss9c202VGiEN9sD6AclcYpjW5RVuXdP9We4iwnLONoc+XK1EgsWaA+MefkUK0a+gy5boGRIESpcLGXBEKcC59OSlNEpfPly0hq16twtL9NanYegyuTINKk5dtnTapSbdVGAs7072Z2tjIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850035; c=relaxed/simple;
	bh=+5WYFcdzQT+SP2O9sHUf6TMHH1nW996eA/JtEszeAK0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mc9gmccs6HUcPnulkZXmID8WyKlfNJh+HsAtJlYgLwQhwSHBb2qS1c2BxW9oFhfk01TWLrvhZZ7Y0/lfeWSqVSFvfDXsgZRwQWNamOSbez7ieWx6ahKlSdX8RAyPVeINAdMjEThLuGA3nWw+gkd3r+4KdJxDO4uGC5SNaKVDgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5vbc0NO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5vbc0NO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A5C19421;
	Fri, 10 Apr 2026 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775850035;
	bh=+5WYFcdzQT+SP2O9sHUf6TMHH1nW996eA/JtEszeAK0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5vbc0NOj1h5TYE+ZrSLS6SLnUDdBR4o2aRMZfrlJrqMafdixAvvqrOjCT52up0qs
	 g0UBvO/HJUA525ZFhC1CGBu3UgAIEuciU9wN3qcvlyIKf8DSUsoxK+HzAw9mgWmkwf
	 0lWIlbz7rgwSze30RCSZJO7hqUNgWFTguhhhCnwbNpNHlU8e/gZZp1v1UYJmY9IXEM
	 yvU7jU1rcFpbYs0Wh665nuBzaWF1Cvri+pqb2FE0+h4iJ+BQ248yOr+Z3/nXs6SyPA
	 rRVW1BJ32YeWJPAkZAQw8HMhBRwlVdiVexVKnHCfKsRUunK5kGbZ6vyd5g8W91PwZs
	 7cExeuOw0Dhqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CE03809A88;
	Fri, 10 Apr 2026 19:40:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/2] selftests/bpf: Test BTF sanitization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177585000979.2617676.1875277438608066572.git-patchwork-notify@kernel.org>
Date: Fri, 10 Apr 2026 19:40:09 +0000
References: <20260408165735.843763-1-alan.maguire@oracle.com>
In-Reply-To: <20260408165735.843763-1-alan.maguire@oracle.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Apr 2026 17:57:33 +0100 you wrote:
> Allow simulation of missing BPF features through provision of
> a synthetic feature cache set, and use this to simulate case
> where FEAT_BTF_LAYOUT is missing.  Ensure sanitization leaves us
> with expected BTF (layout info removed, layout header fields
> zeroed, strings data adjusted).
> 
> Specifying a feature cache with selected missing features will
> allow testing of other missing feature codepaths, but for now
> add BTF layout sanitization test only.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/2] libbpf: Allow use of feature cache for non-token cases
    https://git.kernel.org/bpf/bpf-next/c/7419fcadd1dc
  - [v3,bpf-next,2/2] selftests/bpf: Add BTF sanitize test covering BTF layout
    https://git.kernel.org/bpf/bpf-next/c/0e4dc6fbddb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


