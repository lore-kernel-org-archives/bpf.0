Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297C296BD2;
	Fri, 27 Mar 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627829; cv=none; b=Q3zgmRBTgXUmwC/hZ+kON2HXp/Ag6OkhQtrwBiuMkSDyoYGy9qh4EYszwiQiiYSWk3Cw5H9mrdPdhEju7idNsukM34ndl/ZxcPY19l8t/kmz/FPk9XosdiQCu7rNAzig/28PSpJX0aZ15uN4lbH6Aw7VXG7iDFRAyKeUrjEGizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627829; c=relaxed/simple;
	bh=TQ/CHNnNLIzPwPDDfCfnZgkekOwWEEe8go4F0lZc8Fc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ncn167QDMNr/3jp9YaCsGmZO7Z/mKThd1eP/+Lc9vL4hNe0qjyIYanYrQ4VvuLM7OzMeKgR1yVFdol3Cgg0D0zSNkGRVCu/KxOQiEcZ7bE6uTXY6xBapRypue2MyGyiV1DfErnnfloDe8INhC8wMRYDzqMPoBkL8srxSyvrpX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBXgDd7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBXgDd7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D364EC19423;
	Fri, 27 Mar 2026 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774627828;
	bh=TQ/CHNnNLIzPwPDDfCfnZgkekOwWEEe8go4F0lZc8Fc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBXgDd7oOO6bQ4dmvzcEhIKDaZyP9vxYh7PF9CNtxPJGshBgVGdQiV5ZihLJswotz
	 V5kS04c6+C5yNBwjGQanEsCrmOjCv/eT3imO6VY4q15HrCeEbYsikR31nmyzVqEUSn
	 7eIdbMxgYs0rReI6o7DM3myzE12rHYPA2QbHu7dU3uMhwNAuHHxYSaDwi8ha1F6IyX
	 MlCWOebO7zwD/HSchjHGqSjvt5je3DSBxB2PiJe3HD20fFsGnSwHJI3iZOTtkCBI1B
	 MtEPzvAXnM+x3SnYj6OpMGTOUqebW4Fln7d+dnvhTjzvw9d4R5Ppz+d8rgLEYQZ9Up
	 W/PLWSe+MMnbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E3639301C1;
	Fri, 27 Mar 2026 16:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND v2 0/2] bpf: classify block device hooks and add
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177462781479.3551071.3975124198098746090.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 16:10:14 +0000
References: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
In-Reply-To: <20260326-work-bpf-bdev-v2-0-5e3c58963987@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 kpsingh@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Mar 2026 17:09:13 +0100 you wrote:
> A bunch of new hooks for managing block devices were added a while ago
> but they weren't appropriately classified. Classify them and add a test
> program so we catch regressions.
> 
> Note that for whatever reason building the bpf selftests locally seems
> to fail for all kinds of arcane reasons for me. That might just be my
> fault. I added a pr against the ci to have the selftests run but to test
> this meaningfully it needs veritysetup and dmverity support. I'm not
> sure if that's available already.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,1/2] bpf: classify block device hooks appropriately
    https://git.kernel.org/bpf/bpf-next/c/46df585fcff7
  - [RESEND,v2,2/2] selftests/bpf: add block device management selftests
    https://git.kernel.org/bpf/bpf-next/c/96f4c251a087

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


