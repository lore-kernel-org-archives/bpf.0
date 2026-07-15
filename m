Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFD3D9DAD;
	Wed, 15 Jul 2026 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106041; cv=none; b=Y8jCVgE3yH7beGJoSDilWFINDZLmMan06bYaElkcs+H/M6vZwAvJMQ7niuRCsxhTWYK2N6yTlEKQzIncf5XgzKcQ00Vu6sCxQp9zFsed4hl2D1g2mqeFK00MQjRizBhslq9Utsw2FXzznCLt/iSox6oh0CMBX4e1+3t/xIkbRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106041; c=relaxed/simple;
	bh=sW0uEZWe6tUXPmm+L0Sefg6jfHV3ohevQmOKxg/g3pQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rf4jHIhBgbzt0OBV1QC2+b+afGLeCSGiSLsZIQceccBPePjPrgQVg8U5mj0LA+2C7Iv0Kav0pvIGtoVkRaif4JQHIFj1QmNfIMTtjvN3DSYRrG/z5F+tyUDGhUhKtEdK3BYpoCLcahqh74tlDqplzNFzaQeWl2RbGlHIYnYSDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NARP+YA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NARP+YA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA811F000E9;
	Wed, 15 Jul 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106037;
	bh=45M0Fa9/SGxHpp4jJkt4N9B4NIY8KR/dSaCinU2gelM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NARP+YA3cII42w9ZUhrq0nI09MhX9y1RyKKrzBOJB3U6wE6lMgSZgsPHmYlr2LgCy
	 8WY83VVBji2Mc8sxcPwUkN0Gdjs00qyb2QNgPxRMy9cClvSa4HXX7R6m17YvHzrnKD
	 rlUI61OwWBXCdqV8MbNVOaObq/B4jOPSTSxGD4gxk/idSbYWR3XHZ7c7mkqVi+lGl3
	 vzPUAPHtJCsXJVUWVuA8859Jw5kSZ7d6/ffNj9HwF/iBlIbUK7TDmx7Bz6bEM9y7uM
	 0Gifr4z2aMRnVJfLWfQTB2cPDUmO5v1O+mkN/WyQbYn0pFKrrGa1gVIBUWL6Rbn++G
	 nYY/RHtJguJiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D2A143938E87;
	Wed, 15 Jul 2026 09:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/3] bpf: bidirectional VLAN support for
 bpf_fib_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410601163.3969811.1253596819047175894.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:00:11 +0000
References: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shuah@kernel.org, hawk@kernel.org, yatsenko@meta.com, leon.hwang@linux.dev,
 kpsingh@kernel.org, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 rongtao@cestc.cn, eyal.birger@gmail.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, toke@redhat.com, dsahern@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 13 Jul 2026 21:53:02 +0530 you wrote:
> This series adds VLAN awareness to bpf_fib_lookup() in both directions.
> BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
> plus the VLAN tag (XDP programs need this because VLAN devices have no
> XDP xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged
> frame had arrived on the matching VLAN subinterface, for iif policy
> routing and VRF table selection.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
    https://git.kernel.org/bpf/bpf-next/c/35dac1daeb3c
  - [bpf-next,v7,2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
    https://git.kernel.org/bpf/bpf-next/c/217828aad80d
  - [bpf-next,v7,3/3] selftests/bpf: Add bpf_fib_lookup() VLAN flag tests
    https://git.kernel.org/bpf/bpf-next/c/e54a87872e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


