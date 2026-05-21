Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90217243951;
	Thu, 21 May 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779323407; cv=none; b=V+mRb92v9lMyUaER68E2xbiyzaqPr7q29p/re4x/dnWB/rvSLH8KHu9CUpVzuSpw+joJyyRyagktWztxhNJ559vA64Mggci2gJZpVzY1ckb7bJ7KlPBOVbnRejICnpzm4BGwMxMcrxDKIJIAwqw4WNM8tpv/3yvvCZCzM2/2ZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779323407; c=relaxed/simple;
	bh=0zAJeWD9CvrtnKAQTBgaX+Aj0i/QAWbmHAAspyWiTx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PXtRTYOm1E+MOD2ZRO/86LELe7PBCyp4o3ZTAV1exw10/qsrOmac0+D+pHCyEycaPt+cno+Gj9dOKY6ev5qUSx6Cl7K1T8pytu0jdHMzAwfi00hC6QaTTmWZUMwkaME4DFitEscPHw9st5b5+c2IASXsndKTjnMVM1t3OsUh9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOdZOzqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOdZOzqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84741F000E9;
	Thu, 21 May 2026 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779323404;
	bh=vqaMv9VDNe7sLhRchfomHjPW+wjMlNMtNb8k6M6WB4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cOdZOzqUEJ1b6EIRa0pOaieZ+D2iiL89+37R+PLqoafMhWZTeWWPh3pUe+EA+v2x1
	 MNId8qrG/r15kVUUaM6E4j+0MmzEUG5uovx0uRYvbrHNxY/VawFpAGk2jbGzun0B1p
	 BVSPDeQv956m1xJOIQKvSTz6i1X33IyQ7T9LPE3P2dmvoP8OtRQYa31ZEJZJ7PPcSD
	 QScq8RfH7EJwQ4iHJXgTT+Jc6snZ5f/PXWN3haYsOsrXuehAxqIKDyPwvAnPLVxASJ
	 mFZHnJiCcdErrSH02OktxHd9ZW5GjOaDkeMZu9VtcDMjROCR0qtxY9qyBpu/yv9yBs
	 THzonYp0S1JTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568CD3930C25;
	Thu, 21 May 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] bpf,
 skmsg: fix verdict sk_data_ready racing with ktls rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177932341489.3808433.10969832563832040180.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 00:30:14 +0000
References: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
In-Reply-To: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
To: Xingwang Xiang <v3rdant.xiang@gmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, mrpre@163.com,
 jakub@cloudflare.com, sd@queasysnail.net, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 17 May 2026 23:56:25 +0900 you wrote:
> sk_psock_verdict_data_ready() lacks the tls_sw_has_ctx_rx() guard that
> sk_psock_strp_data_ready() gained in e91de6afa81c.  When a socket is
> inserted into a sockmap (BPF_SK_SKB_VERDICT) before TLS RX is configured,
> the missing guard causes tcp_read_skb() to drain sk_receive_queue without
> advancing copied_seq, leaving a dangling frag_list pointer that
> tls_decrypt_sg() walks — a use-after-free.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
    https://git.kernel.org/netdev/net/c/ddf8029623a1
  - [net,v5,2/2] selftests/bpf: add regression test for ktls+sockmap verdict UAF
    https://git.kernel.org/netdev/net/c/33644bd38aec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


