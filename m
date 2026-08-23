Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7A5331ED2;
	Sun, 23 Aug 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512865; cv=none; b=ECiLc7ETRcpsbxJHiNXYTnq+IxwB4P7XSkqTvjKhcLmu4wd2OWQxQxMlvrn06qQxeQ6NcXlNEu2eSNwTVv4dHFTwHBOaEeWv77IpOAZQVycCQKxg9QHIDG/wUWPIhMuayFofd3TEsD8Qsupn0Pj70vW8obZ4fI13/4qt2CsjAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512865; c=relaxed/simple;
	bh=lZE0Z+zzBP2ifa/6XOsmSkBEa6MJq6lIiof4lhbdiN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZaJECCGWs66f34I4caLZ5wutnwhbshZQ0bYXEi/IX2DcIp4L64P8oE8sK8KYxAUCPr5DG4/msnVlykcKY6tuZiDL4Liiy0+X/L6uzCjJ+KDXJaOrg0jFUtOiESDVUcPr8jEZozVJuEhHrYlWFaO608ejx4Xe1JBvNPl+9G/l2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/hfA9Mq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/hfA9Mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B014C1F000E9;
	Sun, 23 Aug 2026 19:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512864;
	bh=VYFO6tJVNPqhJuTQGXh5I60FMbo4mcK4t0QQU1bUH+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n/hfA9Mq3N2zkPa57WnWHyqGYnZzy/jyRLrX89QJpB4M47hBiPNqHrOpJfaHTQx7L
	 TyClEnnWVVNjaKpVvBNTVvjbQvoAN8cs5sem1Bg06+LGUSUzf5gBpAKleeRpKNTyYT
	 ld1mp1GL7anEraTwmQ6x9392KEiV/nZ5WMTPCcueaYTZg04DjBjWpGRi0gR+pAG7xk
	 SVtQy0TocX1wUA6JA6WlCoAEbcOwj/EiO+40GJ8sIfqqMhtNX/Mva869t30jsUWNtf
	 ozJPqGCX86vpyGpG4V7fWJI4YdtlEV1xXns5FQUfQ8JwZEIJaxOk9gX/9bpFDbvi/X
	 RW2bgMNRoxQDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197D4380AA78;
	Sun, 23 Aug 2026 19:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 1/5] bpf: roll back stream capacity when
 allocation fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178751281263.2121026.4461900903934090479.git-patchwork-notify@kernel.org>
Date: Sun, 23 Aug 2026 19:20:12 +0000
References: 
 <c0ad7b18c59be6695fcc9e4e1200b2f4d5cbbea2.1787492521.git.shijianlin11@foxmail.com>
In-Reply-To: 
 <c0ad7b18c59be6695fcc9e4e1200b2f4d5cbbea2.1787492521.git.shijianlin11@foxmail.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org, memxor@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@chromium.org, sdf@falco.dk,
 haoluo@google.com, jolsa@kernel.org, emil@tsalapatis.com, pulehui@huawei.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 23 Aug 2026 22:17:24 +0800 you wrote:
> bpf_stream_push_str() accounts the string length before allocating a
> stream element. If the allocation fails, the length remains charged even
> though no element is queued and therefore cannot be released by a reader.
> Repeated failures can exhaust the stream capacity permanently until the
> BPF program is freed.
> 
> Refactor bpf_stream_release_capacity() to take a length so the consume
> and release sides are symmetric, and use it to roll back the charge when
> creating the stream element fails.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/5] bpf: roll back stream capacity when allocation fails
    https://git.kernel.org/bpf/bpf-next/c/bd2466ed8fc2
  - [bpf-next,v4,2/5] bpf: fix stream capacity leak in staging path
    https://git.kernel.org/bpf/bpf-next/c/effa6370ba89
  - [bpf-next,v4,3/5] bpf: return partial progress from bpf_stream_read on fault
    https://git.kernel.org/bpf/bpf-next/c/16790357a50b
  - [bpf-next,v4,4/5] bpf: reject oversized bpf_stream_vprintk output with -E2BIG
    https://git.kernel.org/bpf/bpf-next/c/41c0348f6e65
  - [bpf-next,v4,5/5] selftests/bpf: cover stream capacity and partial read edge cases
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


