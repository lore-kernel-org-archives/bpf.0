Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C814D455
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075431; cv=none; b=FUkCkz/cwyIE+SYGxW1rDjFABV3514xm1ED3J51/cmJrjyydMS+4j2j8gyCti7lnQXieOsPDSWb4IUxT849LlJgdx83eIw6Wx09QK9qqwJ8IYWRcz85KEQ8M39z+11wa98/lsK5wNMrk3QUi1lT16U8YZYAyI4VgqtkB+RgTiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075431; c=relaxed/simple;
	bh=lx22IBArK0ua+CGQHSTKguZKe42c2F1I5InR+AgF5Jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ao5U5h5M1VVkDUr4UscP9RWOjpcqRL0S5MsgvvfknL977F4tjpo2msooUEOexB7x03fybBJTdyrtahyP05F9KW6ciw6Qi0lu4POJ4CEbNlSppUhP4cBPOPDb2gjNubPO0m99xEQtwf160yP2E1+Rbiy94HvZcjyemfW8NTCDNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mER9uFR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mER9uFR8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A29EEC433F1;
	Tue,  2 Apr 2024 16:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075430;
	bh=lx22IBArK0ua+CGQHSTKguZKe42c2F1I5InR+AgF5Jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mER9uFR8cyURhb1SiS/mH0u6ZUv/vNf/exbZpbOO6cz0EEIW45t95xGu/Cr11tytY
	 seLOWcgWlUUdxWWScZJTzUw5tvYqIJQxajG/t53ZGMy+9JeCcFPzLfA4ss+jhRvmSr
	 Xia83FvpAtu06TOfjmx7iGwGAUItqFY14C0Pg0cIQEGOoxxtqyp6PQeZfm92R8aPZA
	 k6S8ylctsBJL5AccIoGnBe9JxvKm24T4euqjPVBQMGR6Zp9IJVsl5CUIJ7ltnehQzI
	 V1xkPTbRlaNkX4TzEBWGhsnGw/ElblfWt3WNjbqJ1gD7jMwcX+C/GL+WheSBgCwkHt
	 nwfk0bKuG2ZKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DAE2D9A14F;
	Tue,  2 Apr 2024 16:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: use local bpf_helpers.h include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171207543057.32275.4983538412245689698.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 16:30:30 +0000
References: <q5d5bgc6vty2fmaazd5e73efd6f5bhiru2le6fxn43vkw45bls@fhlw2s5ootdb>
In-Reply-To: <q5d5bgc6vty2fmaazd5e73efd6f5bhiru2le6fxn43vkw45bls@fhlw2s5ootdb>
To: =?utf-8?b?VG9iaWFzIELDtmhtIDx0b2JpYXNAYWlib3IuZGU+?=@ci.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 2 Apr 2024 17:10:52 +0200 you wrote:
> Commit 20d59ee55172fdf6 ("libbpf: add bpf_core_cast() macro") added a
> bpf_helpers include in bpf_core_read.h as a system include. Usually, the
> includes are local, though, like in bpf_tracing.h. This commit adjusts
> the include to be local as well.
> 
> Signed-off-by: Tobias Böhm <tobias@aibor.de>
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: use local bpf_helpers.h include
    https://git.kernel.org/bpf/bpf-next/c/15ea39ad7e83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


