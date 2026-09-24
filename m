Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B853CFF7F;
	Thu, 24 Sep 2026 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245285; cv=none; b=s465gIVEDQ0vWRR0z14ypHk8rMMUSUDul2FSZjTOTbI9Lgri3WAYr8/oES2Wn+zDDb8xTCr7x+jjiwSl8ws3DYqS6cpyzQnJp3s0Dt3c05Vq4FnWEQeXB9yHiXIBCXJeV3ZzIB/ff8lRBo7woIpljW1hD0OWMzRUREsNLyOzc1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245285; c=relaxed/simple;
	bh=Sj+jvzZSeiTZQfJU9RcSUUXzTWWI/6imOEo0BH+KaPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q63/ibBi3pJGoXTlKFb+tzymh5sJyS9R+XrbcNrEOQqg00Myu50at0eBi7PfjNsViX+sO+UkzGao3iqpcP0C0YFL3+eodAJ/RYTKj7B9ZQFz0nARtDpLfUmvGLJr1jFplNZcE0Is4007G3QiiotVwmq/o3NPB52Y3aol0T8hJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEICYvHu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEICYvHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219901F00899;
	Thu, 24 Sep 2026 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790245278;
	bh=8iql6nRxkwR9JSyqc+O9l1brTYYy/ABH6G+wxie3HK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HEICYvHuodt9TRXsv9jm2LkcmRFTMCkbryWXddlX2x3buGL+km0/vkhh9ZEWfcNJ6
	 S5tkZcVp28HEBkTmmLEEuHExg4Zvm2T30ieT9pgSUkw8H2wtweYnY1Rd582Zwb0K50
	 rbm8N6+t8qcviz8VYSda6zEyG0RIej0Dat5oj0jg7hzOoBgzJm65uYvzgSQ4nwCG3s
	 Ao/ljLIBNm+zzWjf/sybgHqSPhcW/z8bAGrillxgFlDjWtcs1sKA7uK2ilxMLgwJmT
	 2DpqBpAZnvjHuD/uI2HcRAPJ1DjMs2x2XTdBbUWrV4Ou1nUz6O1/TLxmbA2ge7sGAC
	 rrShIvdgVENYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C639EB06A;
	Thu, 24 Sep 2026 10:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/2] bpftool: Fix sparse CPU IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024520721.1453978.11185666533780747753.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 10:20:07 +0000
References: <20260923004243.969919-1-sh_def@163.com>
In-Reply-To: <20260923004243.969919-1-sh_def@163.com>
To: Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 23 Sep 2026 09:42:41 +0900 you wrote:
> bpftool currently assumes that possible CPU IDs are dense. This is not
> true when the possible CPU mask itself is sparse, such as 0,2-3. In that
> case, per-CPU map output labels and prog profile event-array keys can
> refer to the wrong logical CPUs.
> 
> The first patch keeps dense per-CPU buffer slots separate from logical CPU
> IDs when printing per-CPU map values. The parsed CPU count is passed
> together with the logical CPU IDs so that output labels and loop bounds use
> the same possible-CPU mask.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/2] bpftool: Fix CPU IDs in per-CPU map output
    https://git.kernel.org/bpf/bpf-next/c/dbf8cef936c7
  - [bpf-next,v3,2/2] bpftool: Fix sparse CPU IDs in prog profile
    https://git.kernel.org/bpf/bpf-next/c/edc071d7b3aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


