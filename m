Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814408;
	b=3ftPJ7Dg2F1w4Pk1OJlAtMDAdSuCqZ48VzIsZBjmrVOR9JrhtMCXuycGIxUB/YQXcvMq
	 Q7dD0y5sDsdOyn+6TFk335F8b7bj3xeJi8yfFnDFOYKrXYESlRvWtBcz8HznyFBi7sWMa
	 G2J2jwD7PE+VVryOxrlYZyUNMR/grItmCj5wJ3gFevM9O+uKFmlku2GfP1jvvb3xgkWWd
	 KrlQojgNHe8UqfoBQRFFWPb6cDXHH1NomVENSLVUuXCZ1bENF/vLJjq8nQvY2A/7SVBnS
	 k1JJ0kOpLiHwP2ZqHHdjs5zhcYjDcmtIBIxkSYWZOTotTgQNOadOA8dyPNoYFpRjAWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=pg5FMnhdl9zYAiRwdT7lqiDkHQEk6LcYINtbWg0xOfM=;
	b=SCYctSlyj9YX9ir08K2H+D5rIjvqrn3cdB/6jyiLmXT1NPjjBFdmUxT8Aj9FsS0xQIFX
	 l1Su3+G6liFOXTjAFOc/gxifZ6mVeLD7h55Zbetzg0WRctQY+HoV9NJTq9kcj+9XCvnkm
	 S8DiJN60dQogIUMAcwWWrFOGveUQaQovqwyA4jYuoXYZAWwOH38jxG3QIwNfn+6u/7JIk
	 8/QQ8xbRw4CCdlvYe/cQtio6zRud3QMMApuAF4ch2j4hGJQwlizaJcLeU9PV7mm7ZB89t
	 n4R6dMM7iCJH3iiD4rfAcP7DTbKk19ceX7/Cc7nc4tkdzLP3jYKYzhzE5VOkgycV/oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9lY59Z1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAE606A31F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a9lY59Z1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3941F01825;
	Sat, 24 Oct 2026 04:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814407;
	bh=pg5FMnhdl9zYAiRwdT7lqiDkHQEk6LcYINtbWg0xOfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a9lY59Z1yDD6C1MRYXTrETC7oeWPwBTUR/VQOKuKGpnfIhXeLqSQ4Wz5uj+kkp3Qi
	 IycXNrsnqOOWrvbmxJ4itDJIrwNd3FQm6lNruXXnORSCgYP4CAQY5I0jLt7sz2P+4M
	 NbQhUGH3qheIgSadpwIVdmwebjJZCYk1ZNjdvfo6I3T49jCD1Rm2T+eg8W00PBYuTQ
	 U0XJWwCGP5nwkLcQeop5o4MYggT6EcTSwqC9VZPK8WOxBh6vXt4VRCKan+ZlfX1/kk
	 Wm2TbmZrfGeMmqxg6Z1ThlhEhQPpxnFwXeiZ+zq6u2fdlt6VxBbXsvFJqr4sdrug8Q
	 1GnekI0J1txTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8157E391B17A;
	Sat, 24 Oct 2026 04:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Propagate btf_add_type() errors in
 btf_check_all_metas()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281440608.1452471.10421800888846159992.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 04:00:06 +0000
References: <20261022064727.747304-1-yangfeng59949@163.com>
In-Reply-To: <20261022064727.747304-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 22 Oct 2026 14:47:27 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_check_all_metas() ignores the return value of btf_add_type(), so a
> type that could not be registered is silently dropped while the loop
> keeps walking over the type section.
> 
> Both failure modes are reachable:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Propagate btf_add_type() errors in btf_check_all_metas()
    https://git.kernel.org/bpf/bpf/c/fb2b27d214c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


