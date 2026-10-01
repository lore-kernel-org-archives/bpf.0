Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B076381E89;
	Thu,  1 Oct 2026 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816411; cv=none; b=K44QuPXk0Ut+PR/fJWXOB2FODxQeoMkPKOLnBMdbKudn6uvkDy4gLx/hT4x5vbMtpVvRDdEnoAU8OffeeaEfUVZ+1GX0XLs5Ks62GMOY84VWipwCHI/Z5rLJAhc8H8W9FG+Hc4d/4vmLx6/Dk+tA1v2pVwgGCxz5eJhOHiLrlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816411; c=relaxed/simple;
	bh=OnZnXeWf+ado418TuC58SQwvJbixZa5lXno0AvT51H0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QOHQeusQ2AvNl4EYoZmnLs3aFTA2HMKb+QJbSDztmuoa0hdunY1El6hy7tsBPCB6FPNPJZUOJOee7tULHfBZe5ViVLjPO5lRNQMpftUP3N6DEkMz8Sa+mIHtXxaydK6xYJ7X5ASErqFCcIBX4R0KHOH1HaPdBxJ5zzl7Lk87nVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GURB7chT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GURB7chT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449A91F000FF;
	Thu,  1 Oct 2026 01:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816410;
	bh=MvEgfPg1zsyM8W3O4GDR6R2A7Qbc06fKHIO3ddDYRpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GURB7chTOJh8Qo02DUuEwY8HjEXsPlWJDTwCNEa2oGo0hry/HByAN0yt94sWEDBIm
	 I14xZetMq7utoS0VcdNIZBW+v7yWzzqZcOaaobtnkBaWr20Xoj1NsIQtSVzaiBCjsM
	 BURIJZ3HfGBK7xveVbCjF2D1Td3lyksUs7gQfGsgJ/g97RoVJjre80nlsXAjpC5TDS
	 QmYuUQWmYBT8RCkzpMo9GG32QrtMwK2kd5wNeoYK6KIhwv/zYaOgjmtoGXhcd9NOuv
	 UTiYfuAg1EVgkQFShrugQ6eknEm79WzGCs+wE3ji48sdp3bS38NUq6C+e72GmNhtxH
	 FeLAXMwrCuv0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2023AA6A61;
	Thu,  1 Oct 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5e: Fix AF_XDP TX timestamp teardown NULL
 dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081640877.2197065.2848520357667196654.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 01:00:08 +0000
References: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
In-Reply-To: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: tariqt@nvidia.com, saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 sdf@fomichev.me, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Sep 2026 17:53:57 +0100 you wrote:
> From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> 
> During XSK TX queue teardown, outstanding descriptors are completed
> without a CQE. If one requested a TX timestamp, the completion path
> passes that NULL CQE to mlx5e_xsk_fill_timestamp(), which dereferences
> it.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5e: Fix AF_XDP TX timestamp teardown NULL dereference
    https://git.kernel.org/netdev/net/c/7b97273cbebe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


