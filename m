Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA1242D89;
	Tue,  8 Sep 2026 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788835267; cv=none; b=CL45P38gtusb7uJOhQqma7/haU4DIgD7VKYB/OHMYOLwPf5rR0IVc8SiB+wGtYajuxHWrDY3vFtxnfSt4RykmDEkligiy2IY+MOXsJ6Ch3zg5tfH0Ryhc6hTyW4t7P4hr89GjF4BHvqphff5BxoYchnHp0sEZ2Wp46ADW4QTEzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788835267; c=relaxed/simple;
	bh=ZXqt+wy1ky6ZkROxbET0sqVfnQl0tHsSIP4qR52I/FQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N39VBs2PD2aYNm3EmjxXL6qcu8vqE20NEBwvgnr50Hwki2yNByvwHSoIltF1B1zBtTATVulG1qiLV1THfphEI4laa5IOMtrCh1G30heFKAhdmmH5Pjvil0lKC+hU7mZDDs7kjxcoCWRtxQe4U6kO1YM8oM34gwf5z9LC/OQqI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyUcpSHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyUcpSHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9C11F00A3A;
	Tue,  8 Sep 2026 02:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788835266;
	bh=tvhK03jSmFF/rODjpwj0Aw9zx73Sq3WpGLz8+mDMcYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DyUcpSHcf00sQZ9081E0Rx2GtFR7Mdsd0Vp2WYvAbibs7CO6kde6AWnGfkCluiIL+
	 vIk7oAK4WDmp0jFeXoVaaOWeFhGvm34cnJtH4hkH2B5anjtItgoJS6d0z5VjGBEjMI
	 jIN4sOSDHnvMkBI7jQsGtb3YHAzFM5EoiX8FaczGODhxZbOvk3XawgBnDqrFP1N7La
	 J1bQDtEm1oRrEw74JFCZIkZu8d1vsyFIDsHaNShZrEuup8h2V4IPzj/OeU9PEX/VTe
	 4nnNCS2PFNVUV2LG7JubgHxhDyyhmryJ6dGzAnlOZbLbtsxXocKkoDHESkbL1V5mhC
	 CkdWw9dT9HPHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197AD39E8A5D;
	Tue,  8 Sep 2026 02:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf: Fix bpf_skb_change_tail wrt csum partial
 skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178883520489.3252445.12614070456129437426.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 02:40:04 +0000
References: <20260907121025.1923656-1-daniel@iogearbox.net>
In-Reply-To: <20260907121025.1923656-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, memxor@gmail.com, yusuke.suzuki@isovalent.com,
 tom.hadlaw@isovalent.com, bpf@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  7 Sep 2026 14:10:24 +0200 you wrote:
> Cilium generates ICMP "frag needed" replies from BPF when a LB DSR
> packet exceeds the egress MTU. The reply is built by first trimming the
> packet down to target size via bpf_skb_change_tail(), and then pushing
> the ICMP error headers in front of it.
> 
> The trim is rejected for skbs which carry a checksum offload, e.g. TCP
> packets aggregated by GRO on ingress where tcp_gro_complete() leaves
> the skb as CHECKSUM_PARTIAL. __bpf_skb_min_len() raises the minimum
> length to the end of the L4 checksum field, so a trim to 42 bytes bails
> out with -EINVAL given a min_len of 52 in this case, and due to that
> the ICMP generator fails. This is not the case if GRO is turned off.
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Fix bpf_skb_change_tail wrt csum partial skbs
    https://git.kernel.org/bpf/bpf/c/3b55f350c68a
  - [bpf,2/2] selftests/bpf: Add test for bpf_skb_change_tail on csum partial skbs
    https://git.kernel.org/bpf/bpf/c/15e2565f1c43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


