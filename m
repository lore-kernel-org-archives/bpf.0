Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A53B6371;
	Fri, 24 Jul 2026 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925646; cv=none; b=A8NA0uE8chWREa2sKuLk4W2KaaHTA/4BoPH+K0ELAXHGTO0hlFcE2HkOfipADV1Qv5SzF8AEzqmLva43HCNfh/NNIxBYFj6+9SvFzMv551gbEiRlan5trejl1rzdXqDOgOLgXsY4yJZrezaFg02p01ehGFX6Dmm8E3MT3AaiErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925646; c=relaxed/simple;
	bh=QOQ8B5EyaKZm3y+F5j0OmS4Jj3FPVpB9MMUVTGQfSPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvLIdcpsRhTVsZcIKxeZfdTXab3q17/Ezx+45iWzRh1FeOYyEcsqo40KUa0sm+iS3eQEFhT8Bgvc+e+bDhqO1QdoUtuMDzvsHjfbNEzDE59eF0XtST13CWciHxSznr+oCZHKAPqOJMr2+oBAX3UUmeLqAIGHfP08+bsQSkBqdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddTnNpBN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddTnNpBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A651F000E9;
	Fri, 24 Jul 2026 20:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784925644;
	bh=K5XuFJGe6yyRk85swIzjKQIWXjsjzub5sB4WIAUEeUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ddTnNpBN1iG/RD0Bhp0/zG3r6LdZLSG7G13TeSIiC2xEkajwfZIKPgjTwLeIIjZlT
	 Y+soNPS+f8Vf7FgXrUd+cL64hB9U0YTH2UaqHfwpxqhg6YS0Bv4KJV0JwiD+U+yo5P
	 GHf91Rjun9uvQWq/OLZciZToSqJi/oPe8va+69vfamyUIhD0gNcs8X4urF5RyYnNUm
	 QWGxyPRxmI75bXXBKiOIC3JEIpiKKtEqNLeGTsu+2CVGBlVikilX1kT2jHNKx4zACc
	 xE8zx2ysCjYRoggGzq/T8Eeiu0TTXGMDihBZsWy8Us6s6riidwDc/Ab7aALhLT+3D1
	 sgjhp/grpBgAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5682338111D2;
	Fri, 24 Jul 2026 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix CFI mismatch in task work callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492561215.3300548.13290729767393088788.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 20:40:12 +0000
References: <20260724-task_work_cfi-v1-1-2616691781ed@meta.com>
In-Reply-To: <20260724-task_work_cfi-v1-1-2616691781ed@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kernel-team@meta.com, hca@linux.ibm.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 24 Jul 2026 08:52:06 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> BPF subprograms use the bpf_callback_t ABI, but task work invokes the
> callback through a three-argument function pointer. This trips kCFI.
> 
> Store and invoke the callback as bpf_callback_t.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix CFI mismatch in task work callback
    https://git.kernel.org/bpf/bpf-next/c/2805abd08957

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


