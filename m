Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F470238D27;
	Tue, 27 Jan 2026 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769482815; cv=none; b=XEDzYNLrxXjx4ChlHPTFkZALE78+xWV9arVfc3m10M5GhxW0e3hJKVax3oTN3SZweeSPz4JK7zkLWgwrhYh4BZD65ki0J/9oJ2b+zHZSc4es4iS02odHUv3c0+M6LoPHPfWi2GiSUzqatFG2JkvUmSvWCO05KM2ZjfkDxESuLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769482815; c=relaxed/simple;
	bh=c6kL4sggAnCSzCthVsGyutQO93o0GVpDQKfymnoRdjg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XzYGMpfE7XHJBWV1djRqXslNVf6sg9xhgF+Cav+Et3Ou4M1Dra8UG04MU7GQd/bckmyyxrDdoZ0RNQphuIfke+LtVgXdMkhf1zvhg5tZhONBXOkib9gUQxEQNTc509DOPiCtn9+dnd/i0f9vZm9QtfVNAog4c2nEcSJKD/QZuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2vAp3f2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2vAp3f2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D105CC116C6;
	Tue, 27 Jan 2026 03:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769482814;
	bh=c6kL4sggAnCSzCthVsGyutQO93o0GVpDQKfymnoRdjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T2vAp3f2oK41Mas+JsI3fXYzGfYbmBuHqR0uLn+yN1PFqO6XPSSEcgVRU5ePrJZV6
	 sEmJZwFo7Fm4pCmYvDHFDx+cOpzJfu6xYTpSIc40wgao1/6aMXX6CMtV1YGKCHeNjD
	 7QNZa+tYoIksXuLlIDXLm3GcY8xjZbDm4lUYpL3LhwoaUPIrxqYTEbGQjzratk9EP+
	 JHfuIP+iE//pxQYd6Eyc99kGnR6Yo3QGwvwkrqVOse8VMNve3lnMo95xQV5HG9pbIz
	 iUqpFsv8vZhIRhim/epdMx+u6NI71+F71F59Im3BYrQ3M+CMazda4ZSjGlYDbjgrM8
	 noTdsL6cWVayA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB80380A961;
	Tue, 27 Jan 2026 03:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] selftests/bpf: migrate a few bpftool
 testing scripts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948280903.660450.14105248730273486887.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:00:09 +0000
References: <20260123-bpftool-tests-v4-0-a6653a7f28e7@bootlin.com>
In-Reply-To: <20260123-bpftool-tests-v4-0-a6653a7f28e7@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 qmo@kernel.org, ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Jan 2026 09:30:07 +0100 you wrote:
> Hello,
> this is the v4 for some bpftool tests conversion. The new tests are
> being integrated in test_progs so that they can be executed on each CI
> run.
> 
> - First commit introduces a few dedicated helpers to execute bpftool
>   commands, with or without retrieving the generated stdout output
> - Second commit integrates test_bpftool_metadata.sh into test_progs
> - Third commit integrates test_bpftool_map.sh into test_progs
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf/selftests: add a few helpers for bpftool testing
    https://git.kernel.org/bpf/bpf-next/c/f21fae577446
  - [bpf-next,v4,2/3] selftests/bpf: convert test_bpftool_metadata.sh into test_progs framework
    https://git.kernel.org/bpf/bpf-next/c/1c0b505908a2
  - [bpf-next,v4,3/3] selftests/bpf: convert test_bpftool_map_access.sh into test_progs framework
    https://git.kernel.org/bpf/bpf-next/c/2d96bbdfd3b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


