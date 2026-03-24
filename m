Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E7356A0A;
	Tue, 24 Mar 2026 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384827; cv=none; b=baz49K1y0J44/VR471APUHxEgM0bv7swmYmwu/tNDXAaz5YBAQjibgtcgBITeQ52BzOq+jwU+mQDnDZwXDhfVPknZyLPI2Nr+q9B0pEYbcFsap80IiumhGeurWq0fNPcHnxU9xtXeEkrrYY2rKEgNNQ4tHt6v2ohdxOoJj1aCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384827; c=relaxed/simple;
	bh=SamzU1tY6n8OJzkBCScXQDAzmd9q5IVtyn/lgDdcYpM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VrIlXwEtKWhbsbrGbLijV8jkPCnbGMCSIGaeijT32lm7VsPSK3oU+wCff9Xp9bVLUUr+01vc9PoeyWN3yvxLRoJYaQ4dP2ZIOT6omYHrwr0ue+Rh0oMn0V8IAM3EgcQ9gZ2C3AJIqgDJLuBx6CUBSMWSghjUtRtVfzKsnCpfmYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwPEQ/EV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwPEQ/EV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50776C19424;
	Tue, 24 Mar 2026 20:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384827;
	bh=SamzU1tY6n8OJzkBCScXQDAzmd9q5IVtyn/lgDdcYpM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OwPEQ/EV7xvq194p8XZFoZdssCUehEFVpkpVjN7bdWwQatYXkODJikgI6zT6nbzFH
	 DG/HNOc/iahvDvXCmMDlSi3XzQRsr1ihcKj/7vOFNNJO1Yx/N0HOjX4efh3MVlCEfP
	 JbOXKUBeTvUZx2QJmxhodpUYM1b5iQKcavjphLNPLYKdSWK/8v3hSKZRm9Aw3VSL4K
	 7eGJO6eehD3HFmiIl9iC8uK2r915mm6kfSYmlCpcQA0dt9DUTnAdS1P73y87hC8h3M
	 3SnYuaY9+GzoFNVqjqzA/NP6r3dZSC7XZ3kABGmaa3KLG8nn/Sc+tYa/2dudWjXDK+
	 Bba/YZMSbTBng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD353808203;
	Tue, 24 Mar 2026 20:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Fix sockmap_multi_channels
 reliability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177438481505.1297770.2936665516613350095.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 20:40:15 +0000
References: <20260312072549.6766-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260312072549.6766-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ihor.solodrai@linux.dev, jakub@cloudflare.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Mar 2026 15:25:44 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Previously I added a FIONREAD test for sockmap, but it can occasionally
> fail in CI [1].
> 
> The test sends 10 bytes in two segments (2 + 8). For UDP, FIONREAD only
> reports the length of the first datagram, not the total queued data.
> The original code used recv_timeout() expecting all 10 bytes, but under
> high system load, the second datagram may not yet be processed by the
> protocol stack, so recv would only return the first 2-byte datagram,
> causing a size mismatch failure.
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Fix sockmap_multi_channels reliability
    https://git.kernel.org/bpf/bpf-next/c/d9d7125e445d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


