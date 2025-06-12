Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C034C85
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750000; cv=none; b=gaSPu7LhnpBdfg0theHGMNALibR5lEq0TOjou1tvw4HcTXliHqfIHVcm4E4GgDRdIDCYWWpJWpwfL9uessNCtnGDt9HUPISc6DzvF/aIQNb2odyZ+aET1GmTF1PYNz8Tco29Ix/Lpp1AwzqMH+OofZqAk1ySGOkt+c9VybIqb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750000; c=relaxed/simple;
	bh=qqhu88udKSYYBwqC1o5B7KQJ+1HOIz3tIw7BXxL+pqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qNujoSvr2EE4CE74H1rIQkPZR2q8cJiBI3v8pSi3CZCOwyNsd/S0knVyNuheLpsZ6xsAE5eWokhKWpd+6SVCYK/0gTKAtoI5K7bV7CLoCN9NK4K0dibEbZGJmo18p2dKSoRMU/HSsbknGgfg1B9uQE7iljFfAVXHVzcEBkzhK8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjbytMmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjbytMmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1A7C4CEEA;
	Thu, 12 Jun 2025 17:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749749999;
	bh=qqhu88udKSYYBwqC1o5B7KQJ+1HOIz3tIw7BXxL+pqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WjbytMmJa3DmZC6zKN2gSuozB6iSDcwhfL3SGGIYpOT99ix5qHNuaVc0voLSNEvfZ
	 Xr8aKeTK6BuNZDD7z0P7nR8shXzq+idTbrsD8LjLkxgHLZLCRVCl2zARunIxWzT8cO
	 Vs91v8ToaGsC3sND8ezQhNrmSvoPbX6piCW0rluxDWSOKEnIdkE039Dikbbw5jKHmb
	 G0kXJVAtUQwlK55Cs7zlwmxJRraDYZcxGlMYsETUZArn/QLFvJpbGkrUIO6SDOZNXr
	 97Z185WPrS4bP/UPYokFYPUdJML7OAGvVdIZO5mir4qw6WFczWedEAFSMHQEN4wtuI
	 284PiNpfW8oPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFE39EFFCF;
	Thu, 12 Jun 2025 17:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] docs/bpf: Default cpu version changed from v1 to
 v3
 in llvm 20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174975002951.38864.12703304414505396024.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 17:40:29 +0000
References: <20250612043049.2411989-1-yonghong.song@linux.dev>
In-Reply-To: <20250612043049.2411989-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 Jun 2025 21:30:49 -0700 you wrote:
> The default cpu version is changed from v1 to v3 in llvm version 20.
> See [1] for more detailed reasoning. Update bpf_devel_QA.rst so
> developers can find such information easily.
> 
>   [1] https://github.com/llvm/llvm-project/pull/107008
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf-next] docs/bpf: Default cpu version changed from v1 to v3 in llvm 20
    https://git.kernel.org/bpf/bpf-next/c/2c6d105086af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


