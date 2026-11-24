Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491609;
	b=p/awllZP2kIJjJKvc0Z5tP6cTmuEVyX1wpeiWskb/r+/RKUwe3ZNudMfN/EAfxSREi56
	 E0b1JKf0sl7GZmR9laWchAOFbtTGb4Xeu3kVemqH0cGrPgizrWdnIrEK6M5jd2XEJKYl8
	 Ef39rJERmjasBH8VseveD8v1QVaTbhJW/TpK/hT14pxcAPVBdbtsSVvCPUPFYQm20jI1E
	 Q6bCKubOeYoSPbgpI1/DWV7hGqd+siDhh5EqUVn9kwP77QFTAhxac4qw5aXvCoe6h84Oz
	 G0evCKz/ev052+fUL8/DvG7L+1LGnCa08r37VWLI2pnz12lvFWCEqezOD2hRr2zH1jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=RY/pscAY0kqIVuCD/VQ32rz7Pi/um+3HxodO4+2UNto=;
	b=LSim6T0K/yRNsObXCum7K1+craNeS47TONCx/M7v3Bg6ftjY+nhpDgqSVyN0EaYhpeB0
	 BFkL/U8M/hK55N152OTwjZ07lMuV+gEeeYumBiJDGIjl6O09JNxfHFYSfjV0H0ThETQhX
	 olNSX6rvnGagj4RayRBRwmVo0tSUjKSBTecOk+8GaMcL1dKgxeK6Qw+qvR6NeXXc9W4pH
	 qlgPHVhCOGb85fHuWrytaltED5GLYptI3WXYANsfJWNi6iFnwG/EIVxdeYLwItnxr0Q4x
	 KYNs1p/Is2rLnH1CLDO6Qu0PBR6zDEIvtESUr5cp0SNFWM3DsyYhi+CBc3WNcNfuKXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ux1GbTh3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC7606A33E;
	Tue, 24 Nov 2026 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ux1GbTh3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8E31F000D0;
	Tue, 24 Nov 2026 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491608;
	bh=RY/pscAY0kqIVuCD/VQ32rz7Pi/um+3HxodO4+2UNto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ux1GbTh3CA/X/Qf0RuADeg3n1CUz3oQVOAoxxrkWnv3sfv7CXBR/uSuXyTr5UGYjv
	 Modlqm5XxzUWgrvw5Q/kz8hicAmZ+wrFKOAkvMoJIKYCWtWgkvMVP4Xl3Nts2PuM5r
	 OnEwtaydO2QtLM3PbXHbaeARqwi+N2RZ5es7WQ9LOqkIp8/flDCdiluZKQijp0hQKB
	 DI069/jcUJJ8NLWMnkBxGl93/QTSZG/vNCvnN5F+PVvsYwYkBFVn6/lvbvIrTZwl0t
	 FjbDg5XfOM6PjkbOtYyzNBPcjenBNKZKFY5jLSs8hyCaOsr3d7Zj/E5OED9h8YNqHf
	 jYgzA5xf9y13w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B442D39302D7;
	Tue, 24 Nov 2026 03:40:08 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix
 file_reader/on_open_non_sleepable_first on overlayfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549160725.3263417.1033641608398909493.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:40:07 +0000
References: <20261120-file-reader-overlayfs-v1-1-81aa7f3041d1@gmail.com>
In-Reply-To: <20261120-file-reader-overlayfs-v1-1-81aa7f3041d1@gmail.com>
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 20 Nov 2026 14:59:02 +0800 you wrote:
> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
> 
> on_open_non_sleepable_first fails every time when the test_progs binary
> is on overlayfs, as under /home and /tmp in a virtme-ng guest:
> 
>   run_test:FAIL:err unexpected err: actual 4 != expected 0
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix file_reader/on_open_non_sleepable_first on overlayfs
    https://git.kernel.org/bpf/bpf-next/c/f5931061c005

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


