Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741E1C8604;
	Mon,  1 Jun 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275603; cv=none; b=gFCKUa9kKmxnHrf6rqbb1hmvCxYLV3+fID9UlIpyr+x+HV8lZeMLysWGIn9hvcZyuCtRJx74pDB0B+5f0nP2pYBaUpTM2xb/8k7NzsC5QCKuVQyzBlgVJGOAEHrj7gjvVtVaGWgl5fIii729MRML6PRLzWZ8epaMzpHOsRE+l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275603; c=relaxed/simple;
	bh=i5YAzci5+MFVaIUytsTdAoGYSAMG5T/E4rWsss7EN8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gpPyqqjlzmEqKK+8T1DRNuOg0yvPjOhXoh2nosyieAsN3sMWtwdbLK5dAlXrQUTZMaHJfKYyu5R/DpA31AMVN5gZd3YVY4/8LN7stFgtVelSeP2MWjpukQ8xFx30+St80ZmJ7aw8BIqRhQX76g0OdJjTqNQwtCuZB9UrTRJGwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxnQpSDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxnQpSDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34331F00893;
	Mon,  1 Jun 2026 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780275602;
	bh=uTaOW3D4noqv0h3HC1G3bXBBcpHsycUtAyv/8pF7/9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gxnQpSDD/GYtIYa1Zp+JHVsbqbcU1vQeFWvfrSap2HUdL/6tV79AFC0r6vK4FGdy+
	 kdc05G2dX1TqPTz53UiHXBEv+gMoVtjDbw7lBOdR7r2LTC3BbhDVJuiEFomR5JJ0Bd
	 s4LCuOx8+TjDaP5QmV3+7kvhtShIZwce0c1JShLQBl1SgHhx+EzLiIkGual3cTD8V9
	 Voj27ZUfY6hXtH2O8RlG7DhJ7n78IinSA44zhA2wOp25DevVbURUeYiUJ/efqz9uno
	 H3PlltklDME6PeHIPRcgk4ly1FvfObZha/JW7JiiP38pUS3INn2iDVGUj+yVLBu7Rx
	 CcmlcCgx5aCmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FB39302FC;
	Mon,  1 Jun 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: reject overlarge global subprog argument
 sizes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178027560516.3443781.11705215616764330591.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jun 2026 01:00:05 +0000
References: <20260528062155.3988156-1-hataegu0826@gmail.com>
In-Reply-To: <20260528062155.3988156-1-hataegu0826@gmail.com>
To: Taegu Ha <hataegu0826@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 yonghong.song@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 shuah@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
 yatsenko@meta.com, song@kernel.org, puranjay@kernel.org,
 emil@etsalapatis.com, martin.lau@linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 May 2026 15:21:55 +0900 you wrote:
> Global subprogram argument checking derives generic pointer sizes from BTF
> and passes the resolved size to check_mem_reg() as a u32. The access-size
> validation path then uses a signed int, and stack pointers negate the value
> before calling check_helper_mem_access().
> 
> This creates a wrap when BTF describes a pointee size larger than S32_MAX.
> For example, a global subprogram argument of type:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: reject overlarge global subprog argument sizes
    https://git.kernel.org/bpf/bpf-next/c/de36adca6346

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


