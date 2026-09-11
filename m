Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9C4AB1BD;
	Fri, 11 Sep 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148481; cv=none; b=kK9zKcYp2xawXjbPuLjNY2QHclScp9/iHt1myjORJxUz1kYmVDqn8f0MCLCaQgYStgtfmh6VlFy2wra0DANWWOK1teqYdXhcmOkd7xOH0qyYfXsdyUopAKwfm6XCuEpUl6MvbK9FG+iaGHIHHrdOUQlDpzuK0Af989Reu7bojp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148481; c=relaxed/simple;
	bh=lNusqhCP5umZ1KT7cePnFjms6rCOLvj+8FAQURdxrvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PEa/n2u1LOdnwLGUDps+BmeOdpWPEmp8foTpALZ6ifviHNC4Au/Cs2Xd42uk6JBs9CV4gro675HzKI2QvqdMfKDzf+3mKoJoq9Rwrvz31LlSbXa/dNAL/hudOXTllbG2Cdb4tfacRalIDc1Tj2LstwMdK31nupCfp4CGwbkOgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiYho0B2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiYho0B2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CF1F00893;
	Fri, 11 Sep 2026 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148469;
	bh=Fr7AFwUWklwy6JTbjppKr8ICfhJ3W/mc/eyzICqThAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HiYho0B2k+Ve+qwj2z+H2i9UiwtT6lsb6ivxte02kpWHAGh1Xauyyk/ok8WSYzHYy
	 LqfUIx8C54J1f4/t7FiROaWZ14tu6Ie6CYbwCjDfSpj3c+Zsp11dzNLvbXtORfhx1a
	 pBF84psjXGfiovxKahHG1SKCjn4X//eWH/4PnEWvM5SaSPPOC4OCTCQg4w674Tf428
	 0/IQgRcwhZY35WlDuhG5A+4w13I8mQo5Pe+T/lDFyqLsCneY8mfZz0lWs5SVHJyAti
	 wkQTIhFfqApt02cutGS1wi9A/0W4Aph4rt3j11ewVWtk2XOxTVHtuJREwkK+P+U0lS
	 dz5tZywM3urFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08C63924450;
	Fri, 11 Sep 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: btf: make alloc_obj_fields array const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178914840639.3026440.3468513711293477818.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 17:40:06 +0000
References: <20260906223358.25717-1-brads@mainlining.org>
In-Reply-To: <20260906223358.25717-1-brads@mainlining.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  6 Sep 2026 22:33:58 +0000 you wrote:
> The alloc_obj_fields array is never modified. Make the array itself
> const, not just the strings it points to.
> 
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  kernel/bpf/btf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf: btf: make alloc_obj_fields array const
    https://git.kernel.org/bpf/bpf-next/c/c1ff425d625e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


