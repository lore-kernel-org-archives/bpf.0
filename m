Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE48E3CF032;
	Thu,  2 Apr 2026 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148625; cv=none; b=AgTeEM6AQ7ptE7S8PrKfen5ok8Fm+d+vjl+eK4MXiM84rIe+TaeQJMb3jwO2Oj6IVSSa4XzXY1kIvsNm3Q6AmP4yA+8XlvnQBlHzon8VcjLVoCjE7+niZ8l+fFX53RIR0+ya4ylyoGsn+uaePgnZhdpjbU7t3LqrsSMPWgGq1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148625; c=relaxed/simple;
	bh=HYSwEQAM3aluh/WR570HW3cZYoiqNzQfAvOELSl+2lQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsuxwqVAAuD0KdSfcHSt0YCN10DEkg9sw6Rh0eFVvEinxoU1whY5gg2CCg+31FbKOijv3enZRZ/lz9MIuYAerpaO+VCyDfwH00P4mQ5tS4ESG0sxdMADACdpQta/xH/+XVOUIQN3UD7KxkBBzcs8ctla3t+i9477acbz9I3EmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXbu/Wb2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXbu/Wb2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0269DC116C6;
	Thu,  2 Apr 2026 16:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775148625;
	bh=HYSwEQAM3aluh/WR570HW3cZYoiqNzQfAvOELSl+2lQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OXbu/Wb2QIt3UFk/ojO+V9JV+3v2Hw3ZX+Nnrljznu2d77UIvhYB9qHRN40b7WSns
	 AnLR67Da3w9ErTg6A0ir/RIAAjPu0D40CVa4XwGtr4Z7rfbITo0l9Bn2XIsB/ViX3O
	 8WT3Ic7ZkPn/c826YgkXUNbxV9DQH/yXt3rqUUiDiBIrlZggMgzrXTU70wamaTM7Z2
	 jAe2pawMK11B2wyy+kuT56/KKwC3KuvwFZcMisqKujn34M9NJ8DSyY3XeDKiX/hgIk
	 3quD7EsuLc20vEEDdsN3RifMtQbOVb9lfPtcPwdKuzF2NYV4cGLHwT2rxWSSvcGwM7
	 KrMveuOexIPpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD5F3809A08;
	Thu,  2 Apr 2026 16:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs at
 attach time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177514860732.529348.7826737904742910634.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 16:50:07 +0000
References: <20260401191126.440683-1-varunrmallya@gmail.com>
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, yonghong.song@linux.dev, jolsa@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Apr 2026 00:41:25 +0530 you wrote:
> kprobe.multi programs run in atomic/RCU context and cannot sleep.
> However, bpf_kprobe_multi_link_attach() did not validate whether the
> program being attached had the sleepable flag set, allowing sleepable
> helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
> context.
> 
> This causes a "sleeping function called from invalid context" splat:
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Reject sleepable kprobe_multi programs at attach time
    https://git.kernel.org/bpf/bpf/c/eb7024bfcc5f
  - [bpf,v3,2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


