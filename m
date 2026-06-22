Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECE8248B;
	Mon, 22 Jun 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090437; cv=none; b=MJM4QB9wWnaCWVHgdfFdoHx7ALPYyIJ9luKjLWLs8CM4TRLYbNHxnyWNCtb/Ao/ojINpEBljqqDjVQN6VgEh/9bm3DcRKp2F/85y1HAN9PYprx0LWcFONVZlU7CrJdQNuGniuUgbVn2q15RijhLtYeh8ryGkY/GiaxlR68uFf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090437; c=relaxed/simple;
	bh=2pd1rYFyW2zTPDf+pEi5Bq8irAnKLQagRH8it2h0bks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bCX0ddOIMKz15eStEossvXgl9w2cz/x3IXhwNeDq4TwO/GbpWKo2qgg6Qa+5jjtN9i2Sls4gkJ02JzvtIvR3yz3h3kpAOF3HpI90Pnz6H267NAum0ZDXxww8KVe8jO3oS47KIbvGugfA7Q9+HeThJz92JV3nAAgheXIVtevfsDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRtqLH7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRtqLH7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC98A1F000E9;
	Mon, 22 Jun 2026 01:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090436;
	bh=1JLZddvmI8W9DSIwo6SYX2iL6bvSV9iWTZ1WrAHQe4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YRtqLH7QsGne+vAFkSZ6JXC2UNa4gDUCUaxZlcyWq9Z4n643nJ8vf3bLvshJe1OGe
	 HFYGHSlGZ0vSFBGzO3TIicbCfbO7g5L45td901BXgwYbQCXZbS/02nz6kxKwBXWQnN
	 /fDez+vho8v06Uoq0JA+Z0na7HxMDkkAe4mpMO3Lev6VFeDV6q2QgnMruKjuCwISO7
	 PDvvq4StiPS5PjNdy41KRFOXusVhHnydQOUAjGNVa0rRmc1frKQ+dbYQAArFC0ngpN
	 cUjXzEBAySkRs7EgqA5pP57B4Hq443Tgg92T6i3qNV8ec6wRO2YeEjaj0IC2mEFNEo
	 XoEqv43sC3eFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B113AAA6EF;
	Mon, 22 Jun 2026 01:07:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3 0/2] bpf: Fix stack slot index for Spectre v4
 nospec
 checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209042679.554493.16748055730753195339.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:07:06 +0000
References: 
 <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, luis.gerhorst@fau.de, shuah@kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiayuan.chen@linux.dev, emil@etsalapatis.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 01:50:25 +0800 you wrote:
> check_stack_write_fixed_off() uses one byte-indexing scheme when checking
> whether a fixed-offset stack write needs Spectre v4 sanitization, and another
> scheme when recording the write into slot_type[].
> 
> For sub-8-byte writes this can make the sanitization check look at bytes that
> are not overwritten by the write. A zeroed lower half-slot followed by a write
> to the upper half-slot can therefore miss the nospec barrier for the second
> write.
> 
> [...]

Here is the summary with links:
  - [bpf,v3,1/2] bpf: Fix stack slot index in nospec checks
    https://git.kernel.org/bpf/bpf/c/d1d53aa30ab3
  - [bpf,v3,2/2] selftests/bpf: Cover stack nospec slot indexing
    https://git.kernel.org/bpf/bpf/c/a93ae7ed5972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


