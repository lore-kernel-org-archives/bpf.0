Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAF1D5ABA
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785597046; cv=none; b=NOd2X3TYE+QrgYH8zq7xdy2QqutFYPL7px2riNoXufj2ifX/x/DqRH0QbF3J+AkBh6A11sk02nG7ZAsDU9LQu0Lwc2/k7aEUk0COmVoQCbmEZ2K2l2rn6kLn69isLZOVVuHU865+smmYkYGR9l53oC0M+BW5KLA4d3ZM4M99i8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785597046; c=relaxed/simple;
	bh=AHvefMmgek0DsbD8yWSFZ8f/P/+KWhcSiVcyffq09oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1Egcv7tzg+pcNHuzozlE2eWaQWXnldn5ggz+Pe+yiDA/YPk6o1SfF1TL+4hkt1NnsAwbUNM7GVyP3mVB4jJZSaCmP6EHr+mrSIo1RoH/6L8kSSidXfL4kTyzveC0Z6Ttzf1AdHEGbIc2Ny/JD4BplMQWeS6hm+dvldoxmRJP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVOBFVHZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVOBFVHZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C9D1F00AC4;
	Sat,  1 Aug 2026 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785597045;
	bh=ORcNh4UKq0BwwS7+fn0kXo11VMRr8p7RtA8DgbTSLJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eVOBFVHZ3zW437+G9YoLK5OqT+DslwznlPuYgkqKADEVhioCRbgpEOu82/V1yVIR2
	 jQsgVPvL0TpuAAL7UpTCcmW/vbZC8hK5xbPZh0WGxd4BZnL4593Acx2pgPcWHS84+b
	 dSBNoMy7aecXWpikpMUptEx1UatwFfIElogSRXCpV++kD8q3wR3LXh8it1v9E4xG+L
	 Jd8Sdio9EVW0Y01v3AwPUae1Ibf71ttieYp2W63EoRe7DnHpyvc3Bvyrpe5ZC3dJQX
	 ft5JyLn9D/vGBbiIB0SCuq1OOieTilsJRWunevS/j8voTQ5uB9KqTtsA2zJMz3GYR0
	 b+nc0M9X4PkgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A07380820D;
	Sat,  1 Aug 2026 15:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: update BPF LSM maintainer list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178559700739.1140968.14912188468376505803.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 15:10:07 +0000
References: <am3uorMW7_UWA5An@lima-development>
In-Reply-To: <am3uorMW7_UWA5An@lima-development>
To: Matt Bobrowski <matt@bobrowski.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, kpsingh@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 1 Aug 2026 23:03:30 +1000 you wrote:
> I've recently left Google, so my mattbobrowski@google.com mail address
> is now inactive. Update the BPF LSM maintainer entry with a mail
> address that I do still have access to and use.
> 
> Note that I lost access to my mattbobrowski@google.com mail address
> before being able to make this MAINTAINER entry change from it.
> 
> [...]

Here is the summary with links:
  - bpf: update BPF LSM maintainer list
    https://git.kernel.org/bpf/bpf-next/c/28e911d61d66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


