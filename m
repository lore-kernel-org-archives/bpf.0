Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519704AC17E;
	Fri, 11 Sep 2026 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148491; cv=none; b=uNr+6aMg/3gz7ThXscen9zHnInHGTK6mbILG8mbjQw5HEvJAve6AKpR+zR9i2JN2BF83Ni97oy2sDoV2qcyj6OoVIFlNxz1WZtGJVaDt0WtJrBvR5TnBeZkjx7Hf/bCeRXDy0bB+JSuaoY1VLrk8gy2oem1UYiqIg4TjE1/kfxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148491; c=relaxed/simple;
	bh=nkjYnm9it1PLpUqDYT4MBNKGK0bpLaGdXMfrEGiCfLY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MwHktSpAFojKt8OofCcUkRtNYJfSgArfZOeXeyc76YPX6gazHPZcLqTp95cAj6qeHu+2Kj33ECvAwn7P2Y6rF1y6Djd+Kz86aAjBoNc3LwJrhQ6zFSU3Pyo39MJ73pjrZV6eAIJKTMDcixHpEiUgDbWzWmZu/laA7nEJfXee9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHsFyfXN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHsFyfXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB42B1F00899;
	Fri, 11 Sep 2026 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789148472;
	bh=XStbx5xOqnvisaJEdBjjJufAiJ8sozdyioF/dPvzEnc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mHsFyfXNfXTG5sWqpzFyfaHc1jxBjUV9XKBBx2FbhxaSiGT/+fVcTNDtK92XURMmt
	 ei+TNAvyodBV0jmhT9jmQBknAKg6fACDR6aIGJdWrHqD+ofn9Q8mP3UEppymiFGfUW
	 gr8YvVxKXf5UjyvRSyG+jqRSnbyz9T7afI7ons4aMRBrfZXGGsulDP8HKrV5e6nkjt
	 mXdCZkzlIs3GdtyNY7VSejSxX2c/6lQ1EpaRpRIhULuXbOA6Bzb/oc9IPC2y+YESGw
	 BhWgDwI5NqaOVkSapZwXQCBd8G9MvKiufFdd8vNnIcFo0ZQUsU7MjsQqJ3R2g8Jlhl
	 hqwPdAFSBA5cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BCD3924450;
	Fri, 11 Sep 2026 17:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] selftests/bpf: test_xsk: Fix spelling mistake
 "conigure" -> "configure"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178914840939.3026440.2048331122548889925.git-patchwork-notify@kernel.org>
Date: Fri, 11 Sep 2026 17:40:09 +0000
References: <20260903150351.12725-1-colin.i.king@gmail.com>
In-Reply-To: <20260903150351.12725-1-colin.i.king@gmail.com>
To: Colin King (gmail) <colin.i.king@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, maciej.fijalkowski@intel.com,
 bastien.curutchet@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  3 Sep 2026 16:03:51 +0100 you wrote:
> There is a spelling mistake in an assert message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] selftests/bpf: test_xsk: Fix spelling mistake "conigure" -> "configure"
    https://git.kernel.org/bpf/bpf-next/c/34b9bde8eea7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


