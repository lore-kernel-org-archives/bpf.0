Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96C4404
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917427; cv=none; b=TrED7mH8jlvKESTBWcJ4tlovADlz0//eGO14AX5iYnPWGbB1seVwp94A/MnGa+Hod9vly68vzLIvHqnWu2c8sjcrcrRCPYHpi8I5y1Ko5lxZsrNdLJq2MlFhGdMFHN5xyeYMGWvAV9nVSt+hXTyJd4snB+HHZoXrpU/fdALNZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917427; c=relaxed/simple;
	bh=rWkx5HrdjV6TgxSzt1AQWh3DXWRZUpvD1XKGrP9dBaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AL4JDHHNkMiAOTajSPfGHfT4dVUUvAsuHSXBjsokVUHChjYIikp0m70MO4I5VLwrczmnJ8VcBs/jMiRIZr1r4iN6q06p/Q773LeRvLIngHuKmLDT5uoLwUx6AaO64n/BPg+VEUyTqsKhDoPkGbqEzqE0+37P84LmxXlbG0Gbcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC5yeWr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC5yeWr1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8696C433F1;
	Wed, 20 Mar 2024 06:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710917426;
	bh=rWkx5HrdjV6TgxSzt1AQWh3DXWRZUpvD1XKGrP9dBaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UC5yeWr1utnEX8zVE3FQsSVVLRuEJCY7uB/x7g28I16BfI7iGHjwWzkyyEsajSJeU
	 UtV6SaemsDOj/sBj0Ybe8kmrM/JbutLKHDDNDoZsXnOVbFmwrjrw3qM7tfpDw3LB4j
	 yyEEYWH4NlNgDkQmqesla7iW/Khwz2jn7VUw3dsSGMcGQn3Q0dAptBufiI5Fe1h5bl
	 LioFnLJiCO71ltO0hRWXvrC2sI6Mk7m8wF5AOrM0sGNqAvsQ6UPthLNv9mnhGaFPn9
	 w8kIaj5rTmuaKypIgC8Zp5veSrhkf1QXziWmQvslpBiAdTVGjVnGbiRd1rvN+JMX/O
	 R/J/1x07hiHiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2F15D95060;
	Wed, 20 Mar 2024 06:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: scale benchmark counting by using
 per-CPU counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091742672.5028.5566504085932271972.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:50:26 +0000
References: <20240315213329.1161589-1-andrii@kernel.org>
In-Reply-To: <20240315213329.1161589-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 15 Mar 2024 14:33:29 -0700 you wrote:
> When benchmarking with multiple threads (-pN, where N>1), we start
> contending on single atomic counter that both BPF trigger benchmarks are
> using, as well as "baseline" tests in user space (trig-base and
> trig-uprobe-base benchmarks). As such, we start bottlenecking on
> something completely irrelevant to benchmark at hand.
> 
> Scale counting up by using per-CPU counters on BPF side. On use space
> side we do the next best thing: hash thread ID to approximate per-CPU
> behavior. It seems to work quite well in practice.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] selftests/bpf: scale benchmark counting by using per-CPU counters
    https://git.kernel.org/bpf/bpf-next/c/520fad2e3206

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


