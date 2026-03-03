Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215D35BDD7
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556623; cv=none; b=dWVH35+JUMblFG1sl+tLUS/Mb0Lh1ZgY8AOhYW8im4fxpAfjpwzPrJ0M9TBLThZihUSw3rwN3Bj/3QF1Xx3WShI2+7JsksknhdteKHTFdW7jWR0wtJSqYFz/wK/xDFVbWcJJxglAZn7NNiEDz3QWS39+z7joEZgJDvDKM7VCeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556623; c=relaxed/simple;
	bh=ZOBGdojfS+4SNAGQ6R48TJGzDD5B1djrwQCgfQy6H/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a6WQTunc2DXyqS59GELoltkUhp33yC/S1wiOOpHQ1VrBcGp/cb30w9yvr1EpuogAdzRsOZ4QUA7TyStHtfXIgPWvzSMvxOAsMON0QauAfUOfsUlUWayJGX2gbd4078AnlQAbsivWXV4ZcbSvue91WgqaaFwaW4O6EWJuXRx6XiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOSPt5q3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOSPt5q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39041C19425;
	Tue,  3 Mar 2026 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556623;
	bh=ZOBGdojfS+4SNAGQ6R48TJGzDD5B1djrwQCgfQy6H/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bOSPt5q3mc0YKKkzN+kab2+BHS1TNVdkIO1bYgtVkY72UZrZE8znUUj3kx7I6cFeC
	 anbTZu+zuNpQvEz+Kp0yAf74mo8son6WqG69d7H9hCE1yx9HY18Y4AnHJuF1YgOCbD
	 Vbsyf5WSxTy2xKjCTHF24ZFbRx9JMBtKkdFcYWSa0K8WpecdhWc1LOL74hso+oUClr
	 YkoICHvDnY7w7kg3MgAWWAXhMHQUSb94QGtxGDdJxbuXFqvx/Z435r+zY0dwdPbiOv
	 9pfQHnYuyjOI6+8zpM2FP/wVJUu4J0+5a4l7s6BvIrqwdWQXexYO5HxtV5Puf7x6TV
	 iy3fNCxQ9JINg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9CB53808200;
	Tue,  3 Mar 2026 16:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Allow fixed offsets for PTR_TO_CTX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255662454.1383432.17981614591692625587.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:50:24 +0000
References: <20260227005725.1247305-1-memxor@gmail.com>
In-Reply-To: <20260227005725.1247305-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Feb 2026 16:57:23 -0800 you wrote:
> Enable pointer modification with constant offsets accumulated in the
> register for PTR_TO_CTX for programs where it won't be rewritten. See
> patches for details.
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Relax fixed offset check for PTR_TO_CTX
>   selftests/bpf: Add tests for ctx fixed offset support
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Relax fixed offset check for PTR_TO_CTX
    https://git.kernel.org/bpf/bpf-next/c/de6c7d99f898
  - [bpf-next,v1,2/2] selftests/bpf: Add tests for ctx fixed offset support
    https://git.kernel.org/bpf/bpf-next/c/f6312e71759d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


