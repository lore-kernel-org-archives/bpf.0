Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2E3C6A4C;
	Tue, 24 Mar 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393218; cv=none; b=RUomi/cnJSftv53hgWyQ7pyxdOchzn97SahCZXH9mRxBJMrqgaS9kaX7CcLV6Wc0Isbvm7IWD4B64g7um+h5HGh6IXRSQu4NaRSSOUKn1aU1qexk90Ql+UqlDhkVEq1VI4IPXM6VGyUdhRp5rDN8opPXC3lPR+x5WKlXWsF/tuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393218; c=relaxed/simple;
	bh=KQxlvgDljIWttCUioUmVOheW5pdAG5lCdfGTEpT0UFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EZK00r6zlSdWoUCKc6NdsSzzcc793uE8AEBZ2n/K7nTjN8njQ+iB28BGOj2PKcgC9HjdTR2CfVDzaQQRgKaQcqsf/ahMztUjsKbb3SY8hq6lANX8MTNTSDPcKbVhpYq7lG3gUwFT3oMtNJ1kzrXdDegAv28Sf3lA4ODjFIEnA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNoCZ/aR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNoCZ/aR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC08C19424;
	Tue, 24 Mar 2026 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774393218;
	bh=KQxlvgDljIWttCUioUmVOheW5pdAG5lCdfGTEpT0UFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNoCZ/aRgbLJhNVHlPvjJDb6+ftsfpraZTKJz/mEo900ul0Ec3BGRiq7BVYxajEw7
	 3ehWfUbg13zme1x/UvspMjFNXBWryup6zzrF5TkyusCjvavLGd4orAiu3WHwuXXijP
	 nR64hNNVpLJuPK94P4RZ6kQ14O9/nEZWT10c+2xsMTLMZ4pa8x/NiBYRLqKxZOkJ3W
	 jJoZRdLBUIPgGuguUVAOfNSt5vzSAXd1uAPx1z3ElgPcefTLHNSqBOgrGGbuAomX2+
	 hoF5VMWJLfTV6uRIGSSkuZ9Gx3AHjBT1x7LbENha5nsY1kU9t3Liv//NpFlsYUZPpf
	 sskCKQyXVD3dA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DBC3808203;
	Tue, 24 Mar 2026 23:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: use RCU-safe iteration in
 dev_map_redirect_multi() SKB path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177439320580.1338341.8176625069776928433.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 23:00:05 +0000
References: <20260320072645.16731-1-devnexen@gmail.com>
In-Reply-To: <20260320072645.16731-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 20 Mar 2026 07:26:45 +0000 you wrote:
> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
> hlist_for_each_entry_safe() to iterate hash buckets, but this function
> runs under RCU protection (called from xdp_do_generic_redirect_map()
> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
> dev_map_hash_delete_elem) modify the list using RCU primitives
> (hlist_add_head_rcu, hlist_del_rcu).
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use RCU-safe iteration in dev_map_redirect_multi() SKB path
    https://git.kernel.org/bpf/bpf-next/c/8ed82f807bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


