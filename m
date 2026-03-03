Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F693947B2;
	Tue,  3 Mar 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556622; cv=none; b=tI3DTwGFABBYl91tKdCB/KRqGRpdeS9WTBn2BYixKinQjdCWTB4+iLoaeb+yPZesfSlY8AF///IeS+WXvjiJx3qcfiVX7pl3O8wTeJMb4CrbDOheqY4GlSXt7tochicMCQWps0N/UcJVPhDIl87W3ER/6u6iXqvlptfx1otgiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556622; c=relaxed/simple;
	bh=oznYu8qpAtkyOwyCCIZkJUtlzc9w25YwKKjcm4BmlUY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D70WAbm9y7oj+vUeDVT39sUf2griWVYJiAbDR6VgM21mpKjEe4/BN/KjV2uFfQaQ0rBq/S5DKrsTjTtd+8uHjn1jk0BI2VV22lQu2ac3AJnQyynN4PPDV7UU37X4A0Ax7oRh8/7S2fCsN8WUXrY01ha00e9EwhWpWd7gf7vURpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvgtUq1y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvgtUq1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC64FC19422;
	Tue,  3 Mar 2026 16:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556622;
	bh=oznYu8qpAtkyOwyCCIZkJUtlzc9w25YwKKjcm4BmlUY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HvgtUq1yyhLRygJKgYIf/89IKLXV54FJzJBxbNmVUyoYxjoZVxGYJ9lrssh+JgDn3
	 Drfqgtc95bjQw+HB6OynSkC13LrdykCXNXZloGSJuZSITfjcpUU4xUkrZsEEO/7V3q
	 mcjqjT6cN8eaoP4X2x+DgPrap9TyOIybm5boubJtR8wzNyTLWrqCOSuO3wTMDRhUNg
	 vhkSC0QLSnniIligbicFv0hVgWhsqyndk9JBa0PWv3PDQMmDp7sDeDcX5w1r5kMUPu
	 ynp/s0e6kiqeKfo6HhtD79J0YjMfl5djPnilfNZce8kVKMXrHhmJsDIrS89YnSu4p8
	 qqpqZzJTU0fGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEB63808200;
	Tue,  3 Mar 2026 16:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: drop test_bpftool.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255662304.1383432.15450137166284632680.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:50:23 +0000
References: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
In-Reply-To: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=3Calexis=2Elothore=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Feb 2026 09:08:47 +0100 you wrote:
> The test_bpftool.sh script runs a python unittest script checking
> bpftool json output on different commands. As part of the ongoing effort
> to get rid of any standalone test, this script should either be
> converted to test_progs or removed.
> 
> As validating bpftool json output does not bring much value to the test
> base (and because it would need test_progs to bring in a json parser),
> remove the standalone test script.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: drop test_bpftool.sh
    https://git.kernel.org/bpf/bpf-next/c/7242b0951d2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


