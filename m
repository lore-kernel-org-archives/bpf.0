Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1E22652D;
	Mon, 15 Jun 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781484033; cv=none; b=pyD+d8dFQvQS3Z3tX8m3FKPDrYRQHi7YIb/GlG5d4mEF4QqcES48QDqYp3u42FZ2S7A6ClXBr55hz9ZH49s+isUFn1GMLbKo0NwKrHp4UvauYvuVYqVNn0E3jh2rJ30mY0IjsI/cYhb00DLHtfci6pRYUnQJ3cbZetBHLXS1+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781484033; c=relaxed/simple;
	bh=UJy0AA6csPRiCnstvTz1ueAhR/3DCFkAlvjNGPjxHHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jHZqNtitPYaUCn/p9k/cT7rp4htQrbLaUoBCT2T45vB98yeYk+onSnwo34sAC9si1GZUHdUOcsf/YstIFDHXtYNiPhn3qoKdni1jRmuRqEvIliCiVeRFw4d4XV8iabrbkGpMW/SxKSPkqYMpwMN75F8337MRaZx0yNd0PKDEsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYWzrzkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYWzrzkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FBD1F000E9;
	Mon, 15 Jun 2026 00:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781484031;
	bh=S5YfzIDxUgC4Xg71v9qmQZJR6JCeH4FhZ6dTlzLXreA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KYWzrzkcuAJyQdPcBJPSQESdbGCene9Ss6Wkl5d1dbBzJbsJQHrG9+4wGxMBDU824
	 P3lyE+dNnWf0jI7DJjlo/5Sxka3JYMH9v2saSNqJwrMrBhqJjuqkOc/WiYVk/CwXkZ
	 pYbWBNVAEfxGen1Xit+vL55NzWOyZZTmLRxIP9T99q0oA+xdOf8xvbsHbwpAWQ2ZYE
	 ORXVskR3zaLIbztM5obl1Cv6F0wZFIrCtTi5Ha+5KwaJ7ldoO/mPZKnFojxzbBdC8q
	 k+Dk3eVpomBNOiqgMSkc/m+uzfYf35q2IeKPX1jx+MZs9FFqOas+GiNdktf4v2ZppK
	 FwDT45s/D6VTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BE13A566D2;
	Mon, 15 Jun 2026 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] selftests/bpf: correct CONFIG_PPC64 macro name in
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178148402716.2363016.7900379113752570071.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 00:40:27 +0000
References: <20260610044023.225820-1-enelsonmoore@gmail.com>
In-Reply-To: <20260610044023.225820-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  9 Jun 2026 21:40:20 -0700 you wrote:
> A comment in tools/testing/selftests/bpf/progs/test_fill_link_info.c
> incorrectly refers to CONFIG_PPC6 instead of CONFIG_PPC64. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] selftests/bpf: correct CONFIG_PPC64 macro name in comment
    https://git.kernel.org/bpf/bpf-next/c/1f24de6b2c81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


