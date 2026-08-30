Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E21D432D
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052868; cv=none; b=HtSoYi0TPCCMZbH3+GGuZPDk3BhXW2KoCJL7I/Ln02fVs2DIFwt7Xt1Rn+L/uWeGBUFSdtj50SCyJRaq28w6oVLB6KnVVXs6lfMfiMs/5f5BLnGJUsY/Zvny+TUH7lOJ1GiDDOgV7COpHyCBCEukYAr7FSjy/nK52QxBmnfeGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052868; c=relaxed/simple;
	bh=BG70QuIsHQCLrCpCsBtVKPWHjQU+GNrte4EWc8OMryM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V3qR3tciXmEU+sxeKD7/6ux4c3ZwdWi3jU9rw/e8vaqbWRDkAUGIRoECjeulhK1E8mdmQmrxqn5SUDZnH49nx3Hbp3j+PaqQDy4cQdGKpat6oUOiUww5SAPUeGrR7fQ+aEmyDz5lbY8YVUNNAKhvSQvyikLzmtcmoPfmB+f43es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mnzjde7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mnzjde7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906BA1F000E9;
	Sun, 30 Aug 2026 01:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788052866;
	bh=QVmyO67Hck3A6BVcBY1TKCTa9Z7Pi8nGZouifDkuUr8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mnzjde7yt1KV3vjg0VWorG3o9KTJrMgUSsDKr/FfF6SSyPwqlOvL39x+qQvvXMkp/
	 BInS+mmD0RWxvuCEcYTcG4lEkdtjo8U1AhSbdCoK3uFxK/3859Gk/9FimwsoV2F+OR
	 YiuyZWSWvSrtCZ5aXfTRSZM2Ud5EJUpt+T5Zgq2T3/ax9S/PPAAtEt1NGD05YoufQO
	 +NoIiL6FuHHEPRu8hAA6tVhh1EaoGPNc7wIQVUHfYHh8uDo5FOE8lWKRxujR2F3B9c
	 /nuvGIsz9MgLW11I3MtZXXIeSaoQ2V434VsIB/TCabV3KxE2ayP8ZeMc+3fqYxbZiV
	 C61o3Q6SWIX8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB3380CEE0;
	Sun, 30 Aug 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Bound the offset accumulator in
 __tld_fetch_key()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178805281040.3192144.13293196970240452654.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 01:20:10 +0000
References: <20260828170534.1011183-1-yonghong.song@linux.dev>
In-Reply-To: <20260828170534.1011183-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Aug 2026 10:05:34 -0700 you wrote:
> The LLVM commit c7f4a76da024 [1]
>   "[InstCombine] fold ((x - 1) | (2^k - 1)) + 1 to (x + (2^k - 1)) & -(2^k)"
> caused test_task_local_data.bpf.o to fail verification:
> 
>   The sequence of 8193 jumps is too complex.
>   processed 188770 insns (limit 1000000) max_states_per_insn 34
>   total_states 8238 peak_states 12330 mark_read 0
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Bound the offset accumulator in __tld_fetch_key()
    https://git.kernel.org/bpf/bpf/c/28d75dd3eb60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


