Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668567081F
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774803625; cv=none; b=TG+EZN7Td3vhsvgZdPox33ohqDNb+gHRYaaI7ttFS1bBTqFQSPqt0PPQnL9e0hmq0ZD1x+RPFPT6OREmfqP8KRoh218GqxcvBhGJjhjqlqkO5dBTTy0k8Ha/XvM8rQwkUMeLpw6iQYQCZiVqkJ0HtMpCFE1h0NSc2AKc9f0kWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774803625; c=relaxed/simple;
	bh=IpoIA0M+F4oOAk0JmWTlJ8MuzAtmo3VOOg7lWmbT/0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ku5PACL/cuGzpsS1IZYOS1jLyMQjPXps4/a/O2ESVoHsNOua1ruKpRbv0cYsSHFylvn2TfIw+gR16HVXslqG7mGY+4XGTKwFd6w3s51NG67gsMkYhgJ7kXl0SpkerWdsGt6xeAceecoK2iW3sUQa5Y50JN1MbzE8tSZ9xds8FP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI+Eew81; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI+Eew81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103BBC116C6;
	Sun, 29 Mar 2026 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774803625;
	bh=IpoIA0M+F4oOAk0JmWTlJ8MuzAtmo3VOOg7lWmbT/0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dI+Eew81jfPHwcvkh97AUz3N5ZHqVjnvNTpZFNtB0y0bcjgaiLKDbrPJQhgSvv1/o
	 AAKNIyDhW69EahrX45Kg6V/ysSeW49UEGoGlF56hJJYHrhNH3ObPA3sSIJzNgqFRzp
	 JCPc6ePu8vBKpgcHc3iv/NX30qJcqHHVid/Wn/cJWG9wltq3TShnqdaMidb5gvkKzh
	 9kPBpwSlwqRK6gfxBUsCKUtUp3DLuZXaBhm0xw/p4yrbgYI76Pk8TQXg8YMQY7Om9M
	 euxPX0ZrjrrY6Ax5VskPqsMPb316ihqq9GfDM1S6CRVPTd4bnMumz9pszTt4qkpTSY
	 awTcsEDNGHbwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BD1393000F;
	Sun, 29 Mar 2026 17:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATH bpf-next] selftests/bpf: Add few tests for alu32 shift
 value
 tracking and zext
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177480360978.412443.2005990242801317328.git-patchwork-notify@kernel.org>
Date: Sun, 29 Mar 2026 17:00:09 +0000
References: <20260327220629.343327-1-daniel@iogearbox.net>
In-Reply-To: <20260327220629.343327-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, rivastava0@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 27 Mar 2026 23:06:29 +0100 you wrote:
> Add few more alu32 shift tests using div-by-zero on provably dead paths
> to check both verifier and JIT xlation resp. runtime correctness.
> 
> If the verifier mistracks the result, it rejects due to the div by 0;
> if the JIT computes a wrong value, then runtime hits the dead path and
> retval changes.
> 
> [...]

Here is the summary with links:
  - [PATH,bpf-next] selftests/bpf: Add few tests for alu32 shift value tracking and zext
    https://git.kernel.org/bpf/bpf-next/c/398ad123e830

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


