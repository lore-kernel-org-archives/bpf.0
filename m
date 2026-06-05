Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0014B3FE650;
	Fri,  5 Jun 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700421; cv=none; b=YVdaX6/OhszcaHXgQgYP3bWwSe4kFYmpXQcRKz2Km755eq9JGm4ibHKsdwWpwmoNjmiVjdqyPCbqB/7hZgILevp9hxa+UOzmprym7oVy7UxS/Xg7y/LMPuGxId3WAtq7DtneZurLxURwTq7P1BhVjq69HHfssT0aGt7ZNpRfWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700421; c=relaxed/simple;
	bh=Eg3kN+aIvkapwnl00d8/53tgez9mC7O3biJ9uPQq3JY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aBI5X77Q93TWPtTn7iZZvl5Kej7BShFbP73fE9b5ZYNX1XZ8GnCnSUlTIe4pg8QJUMBcrjS4ie5BkGzrsD50hbFkfXV9bb6GnMWNBRiiDR0VZSfFdgTEjocSLBOeW83RUxub5BeVrJZMIBBComnwbnud36jYesFEy3fu7IOXBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1tjlH/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1tjlH/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A351D1F00893;
	Fri,  5 Jun 2026 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780700419;
	bh=gMa8QKyaBDOfeKZcnqtydjQcFvRd18FeDZJSwXSuzS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n1tjlH/iesSvMkLdOUmy5GthIrN8QADntFDxtahAjSpnoJBDcHzbc7nyr0NVnGoRn
	 1DX+n1ZBMCe/aBSfd2ihiuOyHZ6uvw6TJXRgY6cS0HM5ZbDeiuapIvA0tokPFX+MKQ
	 paTCT9FN8vczQVrxdZcpyA+r+sQ0ZW17xEa3ftwPD69RSSZ6VcFSow3mkk/XOU+6Xg
	 3S00XbQCFTbJWh1dJi1onl/PD+lSId8f5d6IsawmIErLwv0JWED4TbCwyI2Q8C3n6c
	 vbuB4NDTnaeI70mfQ9e1YUR1DRoOHv3GtnwKKsFiHlD4GVNFCBmMFcF66K0V1l4usx
	 bd9g7K7TH5wrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198953930C04;
	Fri,  5 Jun 2026 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Fix test_lirc test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070041964.3950549.11879034955530736243.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 23:00:19 +0000
References: <20260605151417.777614-1-sean@mess.org>
In-Reply-To: <20260605151417.777614-1-sean@mess.org>
To: Sean Young <sean@mess.org>
Cc: bastien.curutchet@bootlin.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Jun 2026 16:14:16 +0100 you wrote:
> Since commit 68a99f6a0ebf ("media: lirc: report ir receiver overflow"),
> the rc-loopback driver does not accept edges over 50ms, as these are
> never seen in real life ir protocols. Fix this.
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c | 4 ++--
>  tools/testing/selftests/bpf/test_lirc_mode2_user.c       | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - selftests/bpf: Fix test_lirc test
    https://git.kernel.org/bpf/bpf-next/c/d5e5745f8a1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


