Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D514B950;
	Mon,  6 Apr 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440236; cv=none; b=PA/6pMxaDm+hhcWBdl82QJehztkv/uKuhARFi1ROlI3I56Qk/W2prQdMvaZV/AuRjySsVIxgp+gHmfHvlxH20HpcxZrtYVUrb4kr1lzoPPHJDKt4wnCSQuvtyC0NRCIDqZDk2DTffH5byY+sSZuyF4+AJgIypcU3KshQ9SxlADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440236; c=relaxed/simple;
	bh=g8BnwzzCeYyGFbhSoR1n1j31GMxfH/XtciAEFACW9UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ABWMNlKgVMEGtd8GCMSQRS6fXbKZbDEufdaS+Mb7oykGsKS2Tx7CjZ5SeRynDfwEvUpuiAn2bVnHZzIJxtiud1XsdAaghoEHZ2ZF1w5HhsDTMhUTXQUPx/2eFztJdPD+haHjvASzIVZz8TqKmzbnzx8deoSXpnw91ZjebEq67cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2qmDYtM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2qmDYtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D91C19425;
	Mon,  6 Apr 2026 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440235;
	bh=g8BnwzzCeYyGFbhSoR1n1j31GMxfH/XtciAEFACW9UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e2qmDYtMHDWlC7NcVwyzl3UzUudLDWmeTz0WzynM85lbgP6Z62Fn56J2kDEa6lsrI
	 HMOxbzVj9/wEqvbwPpTV0ndI3mr5aa/q9TyqVqG49Z/4P0lP21gGR7DMZ0V1V295XM
	 aAVIAOAxopzvMTpDjWSMgBIvaCqFwKnw7dKSbz8LR90k+b7m1Wx40fy+8/kRWB6A0P
	 PXvptR8IyQZnRVLbLQJXlIg4HBNSEeGVYT/Eub4/ewT8vElcPdIlwbarqS4Pp6uu6E
	 gr7pO/qcd3Vzsqe04/kdyThWMmHGdxmgpC+fZSFOm6XqFd8WtoCgCjWMw3J3iQt8Ud
	 hUjoAgpdBPboA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE2E3809A22;
	Mon,  6 Apr 2026 01:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: remove unused toggle in tc_tunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177544021528.2520976.13295325774547515219.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 01:50:15 +0000
References: <20260403-tc_tunnel_cleanup-v1-1-4f1bb113d3ab@bootlin.com>
In-Reply-To: <20260403-tc_tunnel_cleanup-v1-1-4f1bb113d3ab@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 03 Apr 2026 09:52:06 +0200 you wrote:
> tc_tunnel test is based on a send_and_test_data function which takes a
> subtest configuration, and a boolean indicating whether the connection
> is supposed to fail or not. This boolean is systematically passed to
> true, and is a remnant from the first (not integrated) attempts to
> convert tc_tunnel to test_progs: those versions validated for
> example that a connection properly fails when only one side of the
> connection has tunneling enabled. This specific testing has not been
> integrated because it involved large timeouts which increased quite a
> lot the test duration, for little added value.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: remove unused toggle in tc_tunnel
    https://git.kernel.org/bpf/bpf-next/c/f254fb58dde3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


