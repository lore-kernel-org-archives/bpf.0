Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40453515DC
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638821; cv=none; b=EJeZz2v1KtGKU2bRmqK/Bp4mM8qEzvJqHKp60ip3DJpjx4h1cJBgHhRxU9n9yhDYV9bcH2pJzV1VL62l5nxLoa4o8KvQqKa6zR4Sm+eWl6MTeWqaDL4WDChJBJI59+ojYPvwNtM6iLXOyEznEh/lWmi34q4461Xryk9PJlJ1sLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638821; c=relaxed/simple;
	bh=wJlVEMCkoSLF9chqQGicVSkaAowjfTThoXJrSmL34pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EE1+xzyXBlNCpgto83bRX1WqjhiJCo27nxsfzv7EkcKRL/8kpIdIrKJYf6xCPxzie8dNIwasgeKrOTtr+ox197jEMV39L10/ivHXKYeL05VSvgkY8BfDJfI6oiD/nSTyka9PfOTlC9EZoe4TtgaCcSuK1/ZKu2q6l+WADZqSTuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI5a/+OL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI5a/+OL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D911F000E9;
	Thu, 13 Aug 2026 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638819;
	bh=U311fKzo+abdNChlGBmM1C/dlzvcuZzgGEZst7+DnLU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GI5a/+OL9FOHNjkCmC2sxpX4aY0HLXd45rWmr47EgNiKhUThDDxL0xEbRjUUvv4IX
	 SZDz/5vMgWgbL4G6NiSs+sqFFROWaHyH+FSk0ggDzvJuZGnIrcEkKWestEpe/QXGqq
	 smNQx9qtY42GfV5+Su9rZnQkAPuie0c/TZAdORaKh0hw/FqYqpW4s5rxKURdxjXOc8
	 bBVmbSnGX2HmyQK9mY9Ih/X2yQmlfDYBcxJ/VSOcz9v9E8fu/3N1j3HvN/B1fKBIAn
	 amhVIuhQYbJruXCcp0+e8VRHaW06oAEHClisZSDC5WtMG1mZ126CYG16BauhRNPuJn
	 zKHHz4sBd4e9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A60380CEE2;
	Thu, 13 Aug 2026 16:32:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix chained_global_func_calls_success()
 for
 cpu v4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178663877455.2948096.7160178725216923389.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 16:32:54 +0000
References: <20260813150641.3347662-1-yonghong.song@linux.dev>
In-Reply-To: <20260813150641.3347662-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 08:06:41 -0700 you wrote:
> The chained_global_func_calls_success() test hardcodes the instruction
> counts reported by the verifier's per-subprog stats:
> 
>   subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total 5 stack
>   processed 14 insns
> 
> global_good() does 'return arr[0]', where arr[] is an int array and the
> return type is long. Without cpu v4 this is a zero-extending load
> followed by a <<32/s>>32 sign-extension pair. With -mcpu=v4 llvm emits a
> single sign-extending load instead:
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Fix chained_global_func_calls_success() for cpu v4
    https://git.kernel.org/bpf/bpf-next/c/9786d424a36b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


