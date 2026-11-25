Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795576206;
	b=v2CfGKoXQcqhT0NeBYNoDfBO/4BNgORFkrsv79YOqYYVbWVJjEkvoFEp7xBx9GQRpqiZ
	 rO4SxlkeFsqlbIP7I0/t8RLjIkWsuKaMdxF/gsgCrZ+kLtxp/HjgGxww+O8m8YXwww4ec
	 zd/BahLP1BnRaVCQbyGbHL7p4xK78mORr1n6vAUwAdh56tREvm9EWrgWmknh6/iyWFGq5
	 z1DqrNR0MfwrXjCmlI0HgKk768dTMKuIrlOvxYyu4RGduQ8UbtxldkRt+M6xwBjdCFDkq
	 lSQiJsJ5LLqn2sXecSkmdzs1ku4MjAUQx0HzeApLqv3d0cxgVUs4lFkyZoswUs/MA7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795576206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1JZl22K+abMUGyRUPz6Qz2gQqJrRoMZDi43zBInXTZg=;
	b=jiDa3Acuo54ilRge9opFzroFM6WjMbWnVVycho0lEJB6HIgHdo8xUUoy9OJwBAYjmgq6
	 jEjWVV+ApzNyolbUR6FL3I+rNTfR1IZNynbNIJWzno/OKKEN2IN+ZkaCslmHTxzpHsSvJ
	 gf1h323Q8FOWQK7plsp9yeUkIaUSw5TCdH7N7KJHCQpIRXEzVKPLR7N58+MQObZkaxTAy
	 SG6d+m6rOnp5RHEP9bdnpMPhER40N/sRN13M4xxOguewjFhc9Yp2fSYQpgoThNxevBr+b
	 /nwfwPhp8cmE69PbzYQcyenUNbjR5cahe1t2TuUAM+Hkf65jaDFXvAmEVkseWCqM5FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMKLtm4W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDE606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMKLtm4W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425D71F000C0;
	Wed, 25 Nov 2026 03:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795576206;
	bh=1JZl22K+abMUGyRUPz6Qz2gQqJrRoMZDi43zBInXTZg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GMKLtm4WsLg55ZWl8TOeXBNT9of84f/8oMDumN706MMcAwdUKM+xELiLeBU2+TLe/
	 xjstFuHIGiE2/QmVXI/rs9ouFtk8raod/fgk84t+T8SNhloGt0Hdy/w9bpepMXfJph
	 4dz4bqICRKX9gkEgchK7Oa8VbgcpFuT6m+Ol478WVYHlXgoWXk104IWnOVP+bW35ip
	 9+HiokZOvRUtypIKlBw/FpTXHJDZOBREJMqLB+16QdnhRehY3GO3/aXsA4yZKfi856
	 ZSiyysqjm53aIAqRFXeMFx4I9EtvN4Ds4kAFhpWlV2K6K25iflgoC88kQ6g1moZX4n
	 tRTlZb9ia9M5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3073808209;
	Wed, 25 Nov 2026 03:10:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf v3] bpf: net_sched: Defer bpf_kfree_skb() to irq_work
 with
 irqs off
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179557620478.191109.10719858530609351531.git-patchwork-notify@kernel.org>
Date: Wed, 25 Nov 2026 03:10:04 +0000
References: 
 <7a28c63f6b3d61442dbee1950f9a76d278a0f5be.1795550039.git.memxor@gmail.com>
In-Reply-To: 
 <7a28c63f6b3d61442dbee1950f9a76d278a0f5be.1795550039.git.memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Nov 2026 20:54:12 +0100 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_kfree_skb() is also the destructor of an skb kptr. A destructor runs
> wherever an object or a map value with such a field is freed. That can be
> with irqs off, for example:
> 
>  - bpf_list_add() drops the new node when @prev is not in the list, while
>    the program holds the bpf_spin_lock of the list, which keeps irqs off.
>    The drop frees a node that has no other reference, with its fields.
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf: net_sched: Defer bpf_kfree_skb() to irq_work with irqs off
    https://git.kernel.org/bpf/bpf/c/73f17a98ea70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


