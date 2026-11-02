Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642408;
	b=TYUJDVfyiTH9OaOYAL3s1b4mYYEtV53xn3lqp5QTE0RdiDUSa7/NcQeJWUT4cYpjdWr6
	 Rizm7Tqr1Z0fmxr9RGvLJ2oXuoknaer72bACnUWqVHZcPzeVvZpCmWCjjl26t7Dl4Cvjq
	 LXJywRo2hsiF8GNIJrxpkC5czVfC0wRTh3fPMpWmiFsssP5WQYhXQMDgxjQJ071t2dD7U
	 15bMKlu3q/8uwQ2JRHMownOAIbKr8N5pLH0R3j+/Bm8a9BBoykCc2TdmRjixAIbXowfzQ
	 qTEKMR5c3RxCrvwnEkFklAc+w4tWDHdfY5N3/GtK9SgH1KgFMgUVtIwfisAdToMzyFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=SgQ9oZdWrnqtqnL0xkOU3hZcxzkqJ+Z0Q5LT24rPQyE=;
	b=fA/+0kUcxqlFLyEK/voR3NLI7dlLup9ZFncURdwm0xpp2MBOFUTyvZlgifKRXQiVPb3G
	 S9iasMpDK6GD87qq6U1VvamZSfm1RGp5FlapUl9n6cf2pgIEYc9byUVRxwHQGqiuUiDrL
	 ieEhDst2oiwbfkjeTHsk7NnA+xRonjbn08PuJoMrbMia9dIBnwJZwza4FXADSdUMvPwLi
	 DIfpTcUH85N1jLuwCDpIR1ujn22khlQW0DpnyXL1hI3ShTVwEU9IOD5Wlr7y7FuqaYLjh
	 TIC2m+frk3UWmCku+sP1vtD3p28ip870Q1u2QMEPEFWBzViXWHymZqy2KcRwUE09qqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8kFxf9f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788C606A5AC
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F8kFxf9f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3FD1F00A16;
	Mon,  2 Nov 2026 18:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793642407;
	bh=SgQ9oZdWrnqtqnL0xkOU3hZcxzkqJ+Z0Q5LT24rPQyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F8kFxf9fG3vd7B2ruY/On9tG7WzCuEp/ZSWGlzOS9Qxkhpja6tGWbH2ecMlBWVIz4
	 KETg7oeQYrL9FNDXWE0ypqHYSWdC7K2ndAUNIT/K53v98iEt0TGLf7TXJ88Evn0n29
	 E1W1hG7lKJB4wot7IgtXuPvnQdnPyV+UI1QTT22Ifa3Cb2+oz2UiJW4ThjKlqACAWi
	 qxBBm51+xuSXMqE6DTXnuIvQZMigYnu+42sKe94NJdUM0Y2lLvyPCQn+v8qrb85Hhx
	 JpNdaJhx2HAg/DgdfYNgKlFsuC1lL7Yiimlbc6XJDIC6gWVZxurqIB1Qm/96Y8D/6k
	 zTL2xml04noyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4029B380821F;
	Mon,  2 Nov 2026 18:00:07 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/4] bpf: Fix two holes in the analysis of stack
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179364240580.563634.9640036389272600045.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 18:00:05 +0000
References: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102055913.3598414-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 05:59:09 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Before the main pass, arg_track follows pointers to the stack through
> registers and spills. For each insn it tells which slots the insn can read,
> which slots it can write, and which slot it writes for certain. Scalar
> evolution and the removal of dead slots rely on the answer.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] bpf: Fix the join of fp+0 with a value that is not a pointer to stack
    https://git.kernel.org/bpf/bpf/c/6185d4fc6e64
  - [bpf,v2,2/4] selftests/bpf: Test the join of fp+0 with a value that is not a pointer to stack
    https://git.kernel.org/bpf/bpf/c/27f0738d348c
  - [bpf,v2,3/4] bpf: Don't trust pointers spilled in slots that a callee can write
    https://git.kernel.org/bpf/bpf/c/cdefba74b53f
  - [bpf,v2,4/4] selftests/bpf: Test a callee that overwrites a spilled pointer of its caller
    https://git.kernel.org/bpf/bpf/c/c9a45b2ede01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


