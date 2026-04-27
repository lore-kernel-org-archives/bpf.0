Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC81FBEB0
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 00:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249691; cv=none; b=IqUhVUu5YhSr6ZVyaYdMIdK381llGUFrPr4qmVERnUB2nOIpP1OgWPhUub79HqXMdHJhwF954rgbideY3vwQDwyDik0jFgpPFd5MFZXHizK3T27GAiNk2yzra5xyA61AGfogy3bS3Pn6li9tf5E5PkJWQIPLwne2i0psHP/hEWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249691; c=relaxed/simple;
	bh=RCwiSRJKKZ+IgzuBHBTcfyv4UGdD51UxL7WcpyoN+sE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BCQXrdspmpEKF/DZrk0/Vivnic3KdVxpTFImLTGizTNx9gG88uujt7SZerUufJgU6cV9e3EYlydXVdYw5aanWMyOI9Wgh3kig7eCvFUaHQgvow6Zysmj9tN80b3pEnZn8f9QkEu1KIy53HV96JIz3070xu6IlN4MR/K54aUkVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taV5lM67; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taV5lM67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411BEC2BCAF;
	Mon, 27 Apr 2026 00:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777249691;
	bh=RCwiSRJKKZ+IgzuBHBTcfyv4UGdD51UxL7WcpyoN+sE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=taV5lM67lOQGvjiglqQ0PcmAlIM5PpM/tSaqqly5OaA3/dz/Z03C3hsScFZ7wImHE
	 w2Ulc28XX5bypOJW1j9ut3s7NoAO8DjNAzD4UdVNjWWrFskVrgf1A9AKqCIARvQ2DY
	 0u0TiE6SnIIRUw3wl0tD4BwhiM5RHEIhq98UD7izwsBhLJWPmNifAbpvUbeBDFnYOz
	 9OxzhyWUVLNbhW5S47FOLw0uWLZpmuI5I4onaY/RIxxgcUUaPN3f/aneBE4WKGtiIJ
	 BvZ4MH8isjV4jOT80g1uigU55pThheB6mgVxA/yYMbNOd0Xq2vNKvSRXr6tEb0njql
	 XMXD9RY+AiZHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA28538119E5;
	Mon, 27 Apr 2026 00:27:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] selftests/bpf: Use local types for kfunc
 declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177724964954.2839245.14025879647185201181.git-patchwork-notify@kernel.org>
Date: Mon, 27 Apr 2026 00:27:29 +0000
References: <20260417154122.2558890-1-grbell@redhat.com>
In-Reply-To: <20260417154122.2558890-1-grbell@redhat.com>
To: Gregory Bell <grbell@redhat.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Apr 2026 11:41:20 -0400 you wrote:
> The xdp_flowtable and test_tunnel_kern selftests were previously
> rewritten to compile with CONFIG_NF_FLOW_TABLE=m and CONFIG_NET_FOU=m.
> While the compilation issues were resolved, the tests fail at
> runtime. In test_tunnel_kern.c, struct bpf_fou_encap___local is
> defined with the correct fields but the kfunc declarations still
> reference the forward-declared struct bpf_fou_encap. Similarly,
> xdp_flowtable.c uses a forward-declared struct flow_offload_tuple_rhash
> as the return type for bpf_xdp_flow_lookup(). Clang emits these forward
> declarations as BTF FWD types, which fail to resolve against the
> module-defined STRUCT types at run time:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] selftests/bpf: Use local type for flow_offload_tuple_rhash in xdp_flowtable
    https://git.kernel.org/bpf/bpf-next/c/ac985e7bf840
  - [v2,2/2] selftests/bpf: Use local type for bpf_fou_encap in test_tunnel_kern
    https://git.kernel.org/bpf/bpf-next/c/afb0450be061

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


