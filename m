Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F94A4F1F;
	Tue, 22 Sep 2026 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106089; cv=none; b=T0y3Mk6uwPYyocEd+ELhp20kLQKLBxRdJXCbmxfZa40zyD6b4NhsUk2GS400i7vZ931Na+Tu+qfdTsVs1HlCbD9AcSue3c1p+5g2+o/A5cLiiGt7kVgjhtGIHBFd7vnqNxDD+iW7fehhYNd40cadMx0gcVI8O7P9H5Qf68Mko08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106089; c=relaxed/simple;
	bh=y03ImLd8/oljktXTCWu9VWLWus5hn0BdVkjodGZSMO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQdgUTdY+VNq3Lwyv/k+s0teYZlSJhwc9FHNEvK/btlY2jZYOSJuQLrN74ESIpz+Xjs+vJVpKe0QWgM/PCGzOf+Gn4w36W/RPFE3Xpn/fMgBIuwib7+VQ7V64j1Ec8JqVqg9kPJdw9hdZ1sdLpKY9cVwLiypa7eb1/Qux6bv7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1cRMfV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1cRMfV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9D81F000FF;
	Tue, 22 Sep 2026 19:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106088;
	bh=Qax63mSOp1gySUBjRXF4hfdq/dtG6DsHkoSgPgOQRCw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O1cRMfV+TUwxeTV9tp3Xz8GCPeiIp5VRizyr4+HQMi6lLLb3gleUY4xr1ugvS9szo
	 0hI2NPNl/BwvfGSrFVGVFUQHXb3OJ9L+vSzE3gvB9h8H9DtUVBC4IvFnLxRXtPDbdX
	 G+r0zKfKeqfHZWjKTI/pyPmDGcTxU1X4/sYWk1XxPJNTOMZ62G+c03tVl1X1LwjcoI
	 gxPV1FcK63tDdievTAMowhq8mwYgEmMk5Pm8ytSWvvdW5/ZQhbAAt7MYggu3EfpIQW
	 mseqDfAiAA/i6CDjCQfyv3HLIY2/52oXLsXZM531O6egX4txFXjt5f65Wt7gd6/izq
	 O62ePxLKOzXmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BF53811A60;
	Tue, 22 Sep 2026 19:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 00/11] skb/arena bugfixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179010601914.57201.17168926914102740622.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 19:40:19 +0000
References: <20260922172028.6269-1-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 17:20:17 +0000 you wrote:
> Set of verifier-focused bugfixes related to dynptrs, SKB
> management in BPF, and dynptrs.
> 
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
> v1 -> v2 (https://lore.kernel.org/bpf/20260916050830.8774-1-emil@etsalapatis.com/)
> 
> [...]

Here is the summary with links:
  - [bpf,v2,01/11] bpf: Fix bounds check for skb-backed dynptrs
    https://git.kernel.org/bpf/bpf/c/ed6eec97b534
  - [bpf,v2,02/11] selftests/bpf: Test dynptr slices past end of skb
    https://git.kernel.org/bpf/bpf/c/4fd72eb9f1c9
  - [bpf,v2,03/11] bpf: Fix bpf_sock context code generation
    https://git.kernel.org/bpf/bpf/c/4a4852376e3a
  - [bpf,v2,04/11] selftests/bpf: Add selftests for rx_queue_mapping context access
    https://git.kernel.org/bpf/bpf/c/dec0c209a680
  - [bpf,v2,05/11] bpf: Reject pkt arguments in mutating subprogs
    https://git.kernel.org/bpf/bpf/c/a6c1edfbe240
  - [bpf,v2,06/11] selftests/bpf: Test rejection of pkt args to mutating subprogs
    https://git.kernel.org/bpf/bpf/c/1ed69a54d318
  - [bpf,v2,07/11] bpf: Prevent variable arena/non-arena register contents
    https://git.kernel.org/bpf/bpf/c/f85f5917aa2f
  - [bpf,v2,08/11] selftests/bpf: Test for mixed arena/nonarena code paths
    https://git.kernel.org/bpf/bpf/c/a9e86dd9de4f
  - [bpf,v2,09/11] bpf: Track whether dynptr type is known
    (no matching commit)
  - [bpf,v2,10/11] bpf: Track skb memory invalidation by packet-backed dynptrs
    (no matching commit)
  - [bpf,v2,11/11] selftests/bpf: Test dynptr slice invalidation on skb clobber
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


