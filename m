Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795550406;
	b=KEwz+0kBG324m1/K9WIVachMadzLtUPWujIAQ/k6z+V+GYvXh1tZxIXVPFjeF9hGXJoT
	 aVGOrukVL9qy25dhZIfivHzDDCQreTE2UVHZa5Mw57yixFS2HZk238/bEkGzurKqI6zq7
	 eibG7qmBeIyXne8CrBTAACnGT9K/Eb3CyEmXgbvZNC88vIga/P+yevWbktbbPRMRIdwgh
	 QZ+WnACTewMw2X0/DXQz6k85n7CJR3ufQJ+v0cpyzYrBf2sruJzeOMTaMbTq82CZpvDNs
	 jLG9jfsD85KxbGloqKaM9FMqfn7bJBtQsMPwklzmMmytXLFK1rvLUHuwSMDrJ/qYqrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795550406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xHPYlztE9WVh+k4JZwccMpeCLEXFqFfL19YKwetBqGE=;
	b=tlGdL3acO6TqYuAb9CFrgyANc347jyAvzSBpiqTijDfYyZeBTfAggfOGQxQoScs7nWs3
	 bNtHaP2Yyd52AVomxbMk2iT7zXnTrt6bsJyaWz/y5z+36WDAlnfrbmNAVEzlZEcDdLjGl
	 EMWQSIRaCMhNi4R6apz5hlBl46PuudD6fb8JoFlbWp2ioyexTcE/5Vvir59Ic9fdSkJbS
	 ZDkV1U0UJAUCePHQ/Iy/vlPZ0pQcMLtgoTsoT/NmqJ3GF+empjwLjwsTAFuZvT8pU/xIt
	 kGGEpv48WiJijYLHnfmGMVoIBYh6hb6IRcQ9yXyQzc7ZlaQ6c+6GtbPj/Ypqh/Qfs1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYUBYcSq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA64606A32C
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gYUBYcSq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F731F000CF;
	Tue, 24 Nov 2026 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795550405;
	bh=xHPYlztE9WVh+k4JZwccMpeCLEXFqFfL19YKwetBqGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gYUBYcSqR/5xUWyObkGQ60PVuXI7RCaKm+d/Gh04V7mh1R8hgSA6xQiJDq64GRtMP
	 2jm+p1FUqLSm686BWU1Szxnx1PnLHS8W4Kx75I0gZPK+8dFDg89blmvkU/FJsbbpxU
	 73hsHCwbm2vzM+CfhClJ8uZyNDjgM/tNpMpCU0emYESrTpJAGG1bxYpiF/HzN+6VA/
	 6z8ofu696Af2KEweWzQNwcr+clZM16T79P0Uo2FxzbyUde6HzyYRJzBHYWZ9I9JimA
	 ZPj7YFYFiXLPTWFyJjBXGmp/tW0jOSpmaxQZSY48kNN3sTKvC/gehHGnFK5B/fnGKR
	 ChV2OElCkyHDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774063808209;
	Tue, 24 Nov 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: reduce kernel stack usage in bpf_guess_first_trips()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179555040415.25498.7035361597940523177.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 20:00:04 +0000
References: <20261124140155.1555535-1-arnd@kernel.org>
In-Reply-To: <20261124140155.1555535-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, arnd@arndb.de, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Nov 2026 15:01:31 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The large 'bpf_verifier_state' structure causes the newly added
> bpf_guess_first_trips() function to have one of the largest stack frames
> in the kernel. With CONFIG_KASAN_STACK this exceeds the warning limit
> I have set on arm64:
> 
> [...]

Here is the summary with links:
  - bpf: reduce kernel stack usage in bpf_guess_first_trips()
    https://git.kernel.org/bpf/bpf-next/c/a58375b858fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


