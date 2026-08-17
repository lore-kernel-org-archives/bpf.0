Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA246AECF;
	Mon, 17 Aug 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987887; cv=none; b=nD5R+gPc0jyJnF4cmB4XlBu1HfAwsWeg+3n/+j/aNL49VOD+EnfOzEv1u0P+IfPtcwhsT8UAlTQJhe+T4EZRKxFzb6+LnqIxOZ+jIjOEA81qOh5fNohOcO0Zm2pmgfKmEDBwJKscgssgPCX3oUfCrREte4S+H4b71ejkMrA9xSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987887; c=relaxed/simple;
	bh=EzvVYoHdofLxVfFhVesAID7yg4jQjmGgkTVqVe9teNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KztFd/OzEGHnmVbYf0XfzLO5fLVN3D8CeZ2x+dj2LtSv6hWbWC/mjxzucUHM83JhpjvT/f/DiNGBioPdo/8rRdvpkHxT63eXOOvlHjporPCBIn8vsdEgZryRiiiEVqfnFhwZXRqVDZ3sq9G9RSk4yZM5o2AIWqAUgX1R2XiFP70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQl//6kJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQl//6kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5451F000E9;
	Mon, 17 Aug 2026 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786987885;
	bh=jYkVBiRdmR7dtQoUmA2EXI8m8j3sAeYYAmtKiVnPBrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eQl//6kJFNiTnhidOPi9G7MDwve6qw8KQ98NdzTq2MNtxMzwNvr4SJhgolyBPYv3i
	 jQTwdOQsmQFGv/OcD1FxwO8qj+ZJrYJncmK5L603rVJeMyHsQVFntLAUHA71nT+gxM
	 mzpKrAekcplfuOSNHENjAzdcXMkrHnoUOXamdtyiBwmvBQfYLRwX7PVPghZVbigY4D
	 OkicOwD/D7jLZCFaaKq49XU9GRfDtY8IYI3Ibh9/5tIfL7Od5jecWHxqwOyTn5D6dR
	 oEKzOUrzjlD7JJHlg7U4btjiOx4sj3l3SGxpZBQyh6kH5NfBs5QmmWtjA82JAR4Faz
	 SYKbp2bLmydkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569DF3926259;
	Mon, 17 Aug 2026 17:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bpf,
 xdp: move offload check into dev_xdp_install()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178698783797.1666117.698643856348207432.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 17:30:37 +0000
References: <20260812063616.364817-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260812063616.364817-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, kuniyu@google.com, liuhangbin@gmail.com, krikku@gmail.com,
 mkarsten@uwaterloo.ca, andriin@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 14:36:11 +0800 you wrote:
> bpf_xdp_link_update() calls dev_xdp_install() directly and skips
> dev_xdp_attach(), so the checks in dev_xdp_attach() do not run. A user can
> make an XDP link with a normal program and then swap in an offloaded or
> device-bound program with BPF_LINK_UPDATE, which puts it on the software
> path.
> 
> dev_xdp_install() is the one place all three paths go through:
> "ip link set xdp" and BPF_LINK_CREATE reach it via dev_xdp_attach(), and
> BPF_LINK_UPDATE calls it directly. So move the program checks (offloaded,
> bound to another device, device-bound in generic mode, native vs generic,
> DEVMAP and CPUMAP) there, and keep only the netlink-flag check
> (XDP_FLAGS_UPDATE_IF_NOEXIST) in dev_xdp_attach().
> 
> [...]

Here is the summary with links:
  - [net-next] bpf, xdp: move offload check into dev_xdp_install()
    https://git.kernel.org/netdev/net/c/ad27ed7d2309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


