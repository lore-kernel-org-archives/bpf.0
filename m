Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578209;
	b=ToHcU7uqIL1xHVDXuC/XxOiUQXMl8vuSEyBSGsTLovvXDBvouZpE6FQ2W58RiLEI2nsT
	 77FQg2voB0cx7+tMVuVhGICkMlX+3o4LTIBjCDQ6djWz7cEp5AF5cm76ZPLbTeH1phQme
	 bKAT2Xu4JN50OKz9c7kMLKmmbnjKRANXZQQmQkAd2EXbUw6zW7kLn/Anx6CKU2Or/4PBU
	 HKLzShvuvrX5dJI4mWYyJr9frzhdDWMDe+jVwN8Ru4/oC1KFX6GK3StIkZqnlMlnVfRZk
	 iifxrQx/TDkqdX2o9mYJUKxmOt/Z7yE1ekFM/YSNAag9m7943harWW0Ky8IqOOHsxOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578209;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rUehSYnTxwzIBOpO9MBt1mkRKF29Pb2CaAVA/4wSDVE=;
	b=5qSpVfpt3v+S6jWyeO04+5DVxd0pgQ8b0dM/40LEjtz3iuscsOry8GknjGcWGUxhm+Gj
	 6Q+P9djz3/KgbxukEeW5CQucq8q9dY/Sn2WsUzYWoM/aFQUwZ650h80O6JbXPXfvjIKzJ
	 jk54TzvreSofqyL1sRIWIDvE522pkpexQWIyucYLIY+1VZiCAKWRnes0tzUvUg/8ZeuQj
	 A6JmBgsIc/SxSgfgoLQvwMlrUKiWyaQKtFr/hMJQZPS2NGqROLBwM/wh3SniH1ahFeAPn
	 4tCpFT+3ZD8VOiFNJZ8Qa0pdUcYQOW9RiW4hJWLxHpW0vNDQK8jRfvOn0DQsEoI68Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3lI+H7y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BA606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3lI+H7y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF7B1F000C1;
	Mon,  2 Nov 2026 00:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578209;
	bh=rUehSYnTxwzIBOpO9MBt1mkRKF29Pb2CaAVA/4wSDVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L3lI+H7y7z6lS3kpY410iEjqrRqO7QYLJE4NuziELnfw6oJsdip9Do7b7/2/3bQuB
	 j98X+AGlMfGLyILr8twE24DIdTrHSLYcWdeVjcl5rUkY/6tWr485mNJXNhNyW0j4TV
	 i35hw8k143SGHRSG9XEgUHvyxhR7dVXm4qgAjBDtraJprA2h79afaMfaqhRjjGbRqD
	 E1zjECXk5Zc8AjTzNZYnnCUK9WReBGcOMn5r8/FbsylPSh2b10xLnH9q5nyyQPnGRw
	 D9AhATVxA8fP9OSrvJQuJSX5Zx1JN5D/T1CU0Y4veQVXwegWA7Ee+k5oCQ9K49w1aO
	 oZtvuXP9CPVFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030EE391AFE5;
	Mon,  2 Nov 2026 00:10:09 +0000 (UTC)
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
Subject: Re: [PATCH v2 bpf 0/2] bpf: Keep the valid bytes of a packet pointer
 in
 scalar evolution
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179357820754.3679073.4932420394944871013.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 00:10:07 +0000
References: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261030210950.1904640-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Oct 2026 21:09:48 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Sashiko found a bug in the review of [1]. It is in the tree since scalar
> evolution widens packet pointers.
> 
> 'range - umax' bytes from a packet pointer are in the packet. At the head
> of a counted loop scalar evolution sets new bounds, and reg_bounds_sync()
> makes umax smaller: 58 becomes 56 when the step is 8. The range does not
> change. Then the verifier accepts 2 bytes that are not in the packet.
> 
> [...]

Here is the summary with links:
  - [v2,bpf,1/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
    https://git.kernel.org/bpf/bpf/c/88e2c896d859
  - [v2,bpf,2/2] selftests/bpf: Test the valid bytes of a packet pointer in a counted loop
    https://git.kernel.org/bpf/bpf/c/61f833f968fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


