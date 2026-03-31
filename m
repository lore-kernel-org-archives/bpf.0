Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E744611F9;
	Tue, 31 Mar 2026 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997425; cv=none; b=RWLdZEIy7L2zNZshUkHOE05bATt9PbRqlqIyG0IJjAJ9ta35X8lvay4vz5j0RR+59asziL6tQJIXc28v+u00eAJAYM0sT1T4nHQRaa9j4kJkNXIMX/J2TdrGF3BQ0ixeP88FjEbxCU6nGn0AcXxQLDBzvqB4ykrDsOXXznw/H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997425; c=relaxed/simple;
	bh=a7aPYtNaos2eTufwJG2e09miC+hvbUHRlM3cNuTneVM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Htvpc+NWJaiUb0T9CqLi7TNS2iPN8HMRp2DPVkuJPB0GqBtYyPfcJgmKIaxo4yS5UwxM/FTJ4JYMrxUo2mtDY3ro4dduOdGsxNmVJu9Kxyvc2aLylHVGmx+n69Qu8S/rZwchSO615OQk47twyD5IXNYzlNVV0ggtM9NoA1ltPzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U42vcWid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U42vcWid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E4C2BC9E;
	Tue, 31 Mar 2026 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774997425;
	bh=a7aPYtNaos2eTufwJG2e09miC+hvbUHRlM3cNuTneVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U42vcWidNuLHaS8CdDOupj3An3kTGSgiFN4mJptfhPHANDyXGnQQYcIM2GAkcKA6j
	 nMHnjWUdYBcQ6O1Dn8D7Df9XqUuX32Pn2GUC8vn4ebaR9H9kiZ3XOFiqZ7aP3i6VoJ
	 N4brwNtMMYqRRNaS4rgVVTj8XZwZd0WlDKwUnBq7PGLKQx1uVPJuApzrxg5FoiblJj
	 6Gw7doaHnp9v6n8gAwaW9CHHwK+enCx28/SM8o82/kNYjP0qpjPAvkLSh1NV7Xz40z
	 7gl79zDGeU9l6fA9UAH0G6RrFzaZxvYpkwNSC7JNIMm8XQDr3tp24uK+QBjJIolVxp
	 wHlIY+c9NKCgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E323808203;
	Tue, 31 Mar 2026 22:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: test access to ringbuf
 position
 with map pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177499740829.2977813.15482666940725237845.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 22:50:08 +0000
References: <20260331070434.10037-1-dongml2@chinatelecom.cn>
In-Reply-To: <20260331070434.10037-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, olsajiri@gmail.com, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 31 Mar 2026 15:04:34 +0800 you wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + BPF_RINGBUF_HDR_SZ".
> 
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: test access to ringbuf position with map pointer
    https://git.kernel.org/bpf/bpf-next/c/3e6475dc6085

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


