Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730006;
	b=lfcM36hXoIDZcNKdIAczq7o6z4wz+Z3XTD9VuBP9LgVZ9LOAsfEr4RpO/z6tnLuv+J7b
	 06kLg6l5sUKFO9Gr+lpcJTykE3XdynjFELvkIml15rL1QvXmrEb0B6wIkJWNxzPUS6027
	 56oQeYHSpuXvcOpY9XvyY6u/ehJj1Fm0vM1M1w8k/YwEQIhfE5dVlu4guxUnpUQicS7Bk
	 vJe1dhr7+3B3LVumIiODCQ3rHfm5ck1tSjYc270d4YzHtDdvvbnWKnQqQvCwhcb71tTo8
	 rVCRqzfHOAY5IWPAN0K2cqI+YUDp5cWlz31kbgArLahAPYXFNcQbxP8QmmCg1Iqj3aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=eAXyQr3vEdqukSsGH0jkkOnnAJcU9mFR9v4sFv8zuQc=;
	b=a3v/iWqcL0IqdCs1B68McRqhGXNpaNN+k4+P7xHNA6YbjRPQvZltTWfPc3G3oQq2Y8Hy
	 MWSoa4l0NFHcPE4H1JHZLYp82ubEbjK9PKJJhbjdSE35LLqN0YBT1Au/3jSI3l1tti8Rl
	 BEUDpW3ynQ4vBuY6sqpWKZDOXh+obVwSRbF+T6c3NIoTiq9Hmv5lVYNScNOBPd2ACisst
	 V53ZJYpPk04VivhhitqwTHdkipWb/nfpVwdUT9/24RSctquwKMQ0XnBQOuodbSVstCrTv
	 YpUg/0s9bIa42k2Kwibrz6qjEqsV0NkOinbHhelR6xfPPZFsl8UDDDJxnO3g5hMqdCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHBmmKzz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840A606A32D;
	Tue,  3 Nov 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHBmmKzz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870931F000C1;
	Tue,  3 Nov 2026 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730005;
	bh=eAXyQr3vEdqukSsGH0jkkOnnAJcU9mFR9v4sFv8zuQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iHBmmKzzLxaMbfNh2VIr8qtFixQURdpeWXSH4TPG7f83JjYnc5R/CAMURMDSZpgge
	 B0icZHc6d/hYMiFMqp2e27OPtaJ2Pja1bDxUAE6XN4+jgQwLh3Oa9kCahAuIlHueCE
	 7TBfXJoT8O6E+nTTyNz19lcBUfvM/VnJSFU8mWOVC4Q8O+txlJwOE1DW/ACvE4BqgY
	 FARUVTR15Eqol5hrXrz1KquyUkHOE/Lt5zGz+BpE8y3Slj1vQ2f3iwA/gpLeOPyWjY
	 VBUvcdm94ZwrtNz0bQHz0sx/XD5fkgNVIe5ZLCxGMkS0SziUw37zgNV8tj5ri3uJWY
	 ijmor+v5p1CRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D269391B05E;
	Tue,  3 Nov 2026 18:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf: use FS_USERNS_DELEGATABLE for bpffs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179373000431.1799506.14381637067962664484.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 18:20:04 +0000
References: <20261103101405.70180-1-alex@amutable.com>
In-Reply-To: <20261103101405.70180-1-alex@amutable.com>
To: Alexander Mikhalitsyn <alex@amutable.com>
Cc: ast@kernel.org, brauner@kernel.org, jlayton@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Nov 2026 11:14:05 +0100 you wrote:
> Instead of FS_USERNS_MOUNT we should use recently introduced [1]
> FS_USERNS_DELEGATABLE cause it better expresses what we
> really want to get there. Filesystem should not be allowed
> to be mounted by an unprivileged user, but at the same time
> we want to have sb->s_user_ns to point to the container's
> user namespace, at the same time superblock should be allowed
> be created only if capable(CAP_SYS_ADMIN) check is successful.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: use FS_USERNS_DELEGATABLE for bpffs
    https://git.kernel.org/bpf/bpf-next/c/cd8a2d402273

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


