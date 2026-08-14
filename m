Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464B1B3925
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 03:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677868; cv=none; b=cLf1tYMXgwbe1QuT+RrK4iD69fQNGKwpXw4FFA3YMlIhXYvH38OmjHgnW6YbR/Ffi5JswbjVay8szaPpSkLqkgw/cxCNj9ce6NSjnP8HcAEhc0O3jSy73qVez8EYlLYPOgcmAiP9bclC+pi0tix3cui/49yNGKt+CcVuFlwEVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677868; c=relaxed/simple;
	bh=rcxMgiWxjMkQFPa32//U9z+s6WPJ5Yzd5yeADKb8kgg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L6V9keZhv1v/2p+id08vSe86fwwZMehbfvK4ng/XEaGpAc1E0QTN+4lOAn8/UAz1v8le3SawA0++x+08F9mhV5dJcdPFbVLl2C6o/KR1Cnq9R2cBQAcN2N9lu+IpBAaMYUrFLrTAv5cUvL53zTgooSxz94tQc+EYo4B/nbFqGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPWqJRfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPWqJRfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659271F000E9;
	Fri, 14 Aug 2026 03:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677867;
	bh=1ViVew006vNn44JHotmLnH8B57svVQyhtxGPTbRCDBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gPWqJRfBiUSPZW9NmGPMJrNGREIRgiz7hMfuXZe12s/sTZIHht290f7GUvVRP0Cfx
	 3M7lvfIHfKBVjxT15UOXsZBMRDGlmh6DKjV8BPsA28TNSrmItIPegctyniuFWiXT3m
	 kP9oh5OVuedsEpOBb2N6njwxlXpJro8lfrARPIeGpJZTrfQThRKg3ZjcAf+u0z+gqQ
	 nDNU1oqH3j20kYOToTu0RsOfjlwCZ0CxODU+2kTtwSA7C/FqMfiw/p+BLTPkNwAPRn
	 2RxDtcJAeOdkmmLbBbsqd1HxUcqCJdyOoyea2YuwfqPzT5T8uLKSbvTMpdtP5gJ5BZ
	 IJRPpyu0NGKkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B93810900;
	Fri, 14 Aug 2026 03:23:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/3] selftests/bpf: fix for veristat file/prog
 filters processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667782164.3150297.3197994287873547816.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:23:41 +0000
References: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
In-Reply-To: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 11 Aug 2026 23:05:41 -0700 you wrote:
> At the moment veristat filtering behaves unexpectedly for the
> following filter expression:
> 
>   -f !file/prog
> 
> The expression rejects all programs with name 'prog', and all programs
> in a file with name 'file'. Fix the expression to exclude only a
> program 'prog' from a file 'file', also add a set of tests to exercise
> filtering logic.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/3] selftests/bpf: fix for veristat file/prog filters processing
    https://git.kernel.org/bpf/bpf-next/c/98d309ec8189
  - [bpf-next,v2,2/3] selftests/bpf: exercise veristat filtering logic in a selftest
    https://git.kernel.org/bpf/bpf-next/c/6c034d962bdf
  - [bpf-next,v2,3/3] selftests/bpf: guarantee zero termination for veristat test buffers
    https://git.kernel.org/bpf/bpf-next/c/033506fc0667

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


