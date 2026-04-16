Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6E369234
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381037; cv=none; b=HkRbcA9GwiteAKq4gObnH/IzLlHcFtY3gnDICRebFPZUKueAizZvYK/rW7nGImqIdrn5N/et/px0n9IRYCojsp9ZFvQz8ht68QHKtdV3pHB+GcMPE5sY4dyinu1g2+NR0SJTXbNzLaCtxhvCmJCPBklD/Y47XVRr60v5bvb3p0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381037; c=relaxed/simple;
	bh=5xTalLuvItNgMQEwuMIyAZqf+OpX2GJQC3nqIn/K6Xk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fj+WLwWcuD35f1VOMHs9/fy1ZvbaDaVG6awqPPN34y7nz5DA6fHPAwFXgLmE7N4ZsGzBfw93hfOq438jEAdduFaASaDtg3SGj8fXQvx6H3e9WZoW406XX59yJ2mlCQRCWRUui/jacs7Q+tMGFYBHUuuxY/ces/Y3I3VeCBAicKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+68X7/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+68X7/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C0C2BCAF;
	Thu, 16 Apr 2026 23:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776381037;
	bh=5xTalLuvItNgMQEwuMIyAZqf+OpX2GJQC3nqIn/K6Xk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B+68X7/0uNWAxiDOpRpPgJ/c8BlX9dwS2r2oYs6camOiiLW//0dt9ZZh7wbRZPFfN
	 pyJQTjXYbvktRTKe1cuwrtRAJqu1EkW/7UCRYxNmoYdfv26sf54+4xy7EC7QR2JdJ6
	 QpsVGcVuiWBXJOBBXbQEpGs0BwCF6/Hvf5dA1OB+rxah7NETJ7KnnnMOWWa8J89H3v
	 ++PCEC6Ma1GI9/bE6kOzdW4gQWT7zwpnXqADgMCc1hjwjDOXMYqYN9GamIMFdXIcM0
	 WO9wl5fHMJh8ovvEgGBfCVf+9kjlsFqTKSeYw7Kw7e+hJ9suiS/jkjeIDf9mt4sOaj
	 UI5W3ApgcM8/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE29380AA76;
	Thu, 16 Apr 2026 23:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf] libbpf: Prevent double close and leak of btf
 objects
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177638100531.3434480.7755313721234677141.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 23:10:05 +0000
References: <20260416100034.1610852-1-jolsa@kernel.org>
In-Reply-To: <20260416100034.1610852-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com,
 yhs@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 12:00:34 +0200 you wrote:
> Sashiko found possible double close of btf object fd [1],
> which happens when strdup in load_module_btfs fails at which
> point the obj->btf_module_cnt is already incremented.
> 
> The error path close btf fd and so does later cleanup code in
> bpf_object_post_load_cleanup function.
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf] libbpf: Prevent double close and leak of btf objects
    https://git.kernel.org/bpf/bpf/c/380044c40b16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


