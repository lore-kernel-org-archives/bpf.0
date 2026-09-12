Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C45747B436;
	Sat, 12 Sep 2026 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237269; cv=none; b=QOt6aMbbqfklp9ZL+InAjZRHU+5Cra7jksdDZxCVnBPWAASdFeOyRfl40jruH7DPSGlBbWiZDyF4G+FLB7vCS7nV13YtCwFrbQ4X0iXU3dg7KDue/UX/hgnkG/RWmLqPMLPd1WLtsRyYWYkeYroQ++zXD2IJ6bMAz036/F0Ibv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237269; c=relaxed/simple;
	bh=ILExIOCiWsN8fLHG7fDSRX2u/Jko7LRYT+1oDXilbSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZiDcLDGuSXaNM8GDAYESvl++WZyDtNtZL9GR1ETwIOHyUQGCHKovp2FijCpUaW8Ax3r0xrOUcrSUXyV+EzjfD4S1DaQNfPbh4PBZD26t+nZs6qGqgUHwjwOCG16X7NsU46yv6RoX1QvAeEk8fXsjpUUjfvhi4FO1E7lFukcho7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co8N3uuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co8N3uuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220F31F000FF;
	Sat, 12 Sep 2026 18:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789237268;
	bh=HidQSN1nugSryy3nWqNWpavdczYAViodzcHywUY/KUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=co8N3uuwU8iXJhQtiCBsi7HVOLcy9CfvsWe3uh1V2WXgiHjZSczSuqdPyNO1Rt6J8
	 ITy/HpWXCBtfvogWo1oEIv2+wedeN4jtHtNv3G1OVEU0MCid3uemIq0OkrSMY7TAEr
	 8ywowl8d32rfiO9m+18tlEGxVB+igQCh+Tc8XDX6NhA3eyA6Y0H6w4vMxXui8FwkcV
	 hkZPci/EbiT8GTSwNBlkYrtbD+8rlHfvf41KIBvGzt5xqE8xlpi61RweybgF0O+PIc
	 iamFpDAyS3h0YR9fGWAUDAReSF9jJ0HuLYoAcrcAEKjHQtd9nC7vjavULIYGGqIyoj
	 LBqFWMYy7eD4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A01380820D;
	Sat, 12 Sep 2026 18:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix out-of-bounds read of rtt_min in sock_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178923720441.3582279.950800021362165235.git-patchwork-notify@kernel.org>
Date: Sat, 12 Sep 2026 18:20:04 +0000
References: <20260903100921.113374-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260903100921.113374-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, vega@nebusec.ai, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 brakmo@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 18:09:20 +0800 you wrote:
> A sockops prog reading skops->rtt_min never checks the sk type: on the
> tcp_conn_request() path sock_ops->sk is a request_sock (non-full), and the
> ctx rewrite casts it to a tcp_sock (full) and reads rtt_min past the end of
> the request_sock, returning dirty adjacent memory.
> 
> 	SEC("sockops")
> 	int prog(struct bpf_sock_ops *skops)
> 	{
> 		switch (skops->op) {
> 		case BPF_SOCK_OPS_RWND_INIT:
> 			leak = skops->rtt_min;   /* reads the request_sock OOB */
> 		...
> 		}
> 	}
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix out-of-bounds read of rtt_min in sock_ops
    https://git.kernel.org/bpf/bpf/c/75f8cf22463d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


