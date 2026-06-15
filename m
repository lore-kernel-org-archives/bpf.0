Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5721339B1;
	Mon, 15 Jun 2026 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781491812; cv=none; b=iqhN/1HT/KSUH8t30LnIiBL5He1rBEPV9xzb3PylnHajv2L9k78pi/YwB7ab1bf6+ydk4U0Os5pdd7HYsXaokZvVoNP78FgBW0z/BLWqXnTPz8tNUd2Qv9JzTAZ6PUHSY7GhfpQbBk88Ex+rv01+NB7CxQJHENPGAuCR1CjpiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781491812; c=relaxed/simple;
	bh=ArqE8hlYc0WgrlPQIyT0nba0TOXxB446xlhApazixyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OsqupvHGPUAwfhOMkao1M4IDQRboatZ0MeGDlhH0V1s+Fhtu70Vw5XBY2I/IHDJgtYVR1oblQcp0w/m/YSjgeyDJJU+x9vzl5ftSvJZJFdhYrKhEpuJPYHoRkislR0taAsMNeyh9REkxfPBmWNbVK0QNV4QoMPS8y8OEE7HgXUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6+KJILG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6+KJILG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A001F000E9;
	Mon, 15 Jun 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781491810;
	bh=eaJjKx1kWkRUvF6gX4B4+RSWSQoKzBtFhNek2L+25q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W6+KJILGa0i0gapvwj8DjaTJzeD41Q13o9M2/5Ms6xYRhW2noexzYEDotpan1ml8m
	 QU4f/8YoPNY9Hz42CC+w7KO6Qtx0Rnz57KF8qYLlFq66X9pwe5QKF9QUIwb9KwicZf
	 Thou+nUbt3UxZ9U6Nbu3nH8ds4msd0obmrPcOZmqCtAPyrDEKVLgzQle6sGp70HNFF
	 2vj5DiJMaao+6eEC6giO1LrQlKe40/WPDR1AP8BeIATtDX0/agcPfaUi0OyE/An4Wn
	 NzRaXJ/CiO4RVwp1INnAI0sRY2PP5pfZWPPK7PXBMC6lsDWOVyI69E5i70YTZXDt3S
	 kbYkjw8jdbGzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389B3A566D3;
	Mon, 15 Jun 2026 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Add test for sleepable lsm_cgroup
 rejection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178149180616.2395239.5373951589434426010.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 02:50:06 +0000
References: <20260611143549.703914-1-dwindsor@gmail.com>
In-Reply-To: <20260611143549.703914-1-dwindsor@gmail.com>
To: David Windsor <dwindsor@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Jun 2026 10:35:49 -0400 you wrote:
> Confirm the verifier rejects loading a sleepable BPF_LSM_CGROUP program,
> as introduced in commit 5b038319be44 ("bpf: Reject sleepable
> BPF_LSM_CGROUP programs at load time").
> 
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/verifier_lsm.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Add test for sleepable lsm_cgroup rejection
    https://git.kernel.org/bpf/bpf-next/c/05ae621d4e3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


