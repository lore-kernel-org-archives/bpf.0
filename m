Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74852286A4;
	Sun,  7 Jun 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780820408; cv=none; b=FHI7ROiv4UI6BLqT6VkaRD8NmTgB5KUwPSHV51IA3qgAZqpZE5spk47q3irKfRSJ1f7oSFVgxXk3h3DrmS6BjqAqVIMaKUPlv7ZtoJwvmCv7iE/ylQVqsC5P3jpJaZzAlF75K572kCdV97+ePQWnu06ikcBDqS+N//QJyQa9CZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780820408; c=relaxed/simple;
	bh=mYFHI47SJU5Nx75ldlyNhmdN+4XOJgFCO8/baxbf0E8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ki8IpM8E4CEWvTa8iLIdkAbPOlSJhzINzXLyVVXIiThzBCb4dg2Z07Jy5Nj+ayQwgab+JP1SBiPRY6WglRsa5rz6RsS731BCjsVxUoiIBPp4fK50Xe1AdkdnVqQRnQDDTZ9lR+fn72DOnw/viq/LnhCix0oMMSW5l0fMcqK3DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6d6WEpA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6d6WEpA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E21F00893;
	Sun,  7 Jun 2026 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780820407;
	bh=9UR/Y/oKT+U0we0ieb5btMg/a50q1gK4okb/OYxRwV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F6d6WEpAu/06FAJ/rKeoJJiRpSaCkp2nFvXI/0mlReoUu4vszZKwjsspXPs6/b2W+
	 ZYGBq/ROwOSVBPkfkw67GlEckRZTjF266EqpOUlIaraM9+i6MDQ3jzj/PFh2lpMd5Q
	 wZmEazr1hRAfJ8AwI2D1K2IUJ4FHIS5M+pNsMderOrhd/hPQ2NqXEASObSeasZGG3i
	 sIaqg0JHSyxDs/fdCjygjnNnBiOFYsSIsOw4Chid8wNRh8QO9Dpt0fRL9Z7bl4ITvH
	 agGOvLqE42qkVoQlleVjDhWXtcVun6nOexxjL7jlf4xSvXm4N1OC6IkYrdBaQmhRzn
	 BM72Jc25lK11A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09443930C88;
	Sun,  7 Jun 2026 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at
 load time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178082040641.151789.15634326061215589390.git-patchwork-notify@kernel.org>
Date: Sun, 07 Jun 2026 08:20:06 +0000
References: <20260605145707.608579-1-dwindsor@gmail.com>
In-Reply-To: <20260605145707.608579-1-dwindsor@gmail.com>
To: David Windsor <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri,  5 Jun 2026 10:57:07 -0400 you wrote:
> The cgroup shim runs under rcu_read_lock_dont_migrate(), so we should
> not attach any sleepable BPF programs there. Add support to the verifier
> to explicitly reject attempts to load sleepable BPF programs destined
> for LSM cgroup attachment.
> 
> Without this, we get the following splat from a BPF_LSM_CGROUP
> program marked BPF_F_SLEEPABLE attached to file_open when it calls
> bpf_get_dentry_xattr():
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: reject sleepable BPF_LSM_CGROUP programs at load time
    https://git.kernel.org/bpf/bpf-next/c/5b038319be44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


