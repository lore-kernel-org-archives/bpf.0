Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD9E2C17A3
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 05:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795876; cv=none; b=e7SIE7auv38UGPygYKeitS0Re1prkESZXgvCJyRB2gjOgfwtHHX2mMo1/jLIFcnvj5iqI1dQkCaRg0Cz5Uj20Yp6dZWdfTI3cvP7JjI5/NYwvdPBR4u7Nt3RhgfV7sYr7NS4vrfRGlB0LJhQsSVQUur+DmRL3wnCaHQuUfm+bl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795876; c=relaxed/simple;
	bh=Vaxay+9tE1i5tHp5Q0yQhyuGSnP1qtyM3XmVzRtCRok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=elviUD5+P/V3Zn2BEuTGg9b5rT02E6bhFyGpRhPzFu9dgUQmgOB6uQloZm4huYobyNmv490h2R6GMLcAoE5cti/1jJO0Qi6YEXpBp5dq5520iUKZZVA3aX4gdvF1Jj88h7ch8vHQ+BVNHHdHhwMSHb+o1QSjTM/5IuvHov6QirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3TYtxNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3TYtxNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A961F000FF;
	Sat, 19 Sep 2026 05:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789795874;
	bh=HEiLd6t5yI8CV3YAH90Hm8SgVbc5oz1W/ldHpo9CXD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q3TYtxNUx6La4mo0VIFpx7k4ZxzErbgRqyQ4MNZylZ1fojacIE+F/GFAl1p9lcSZa
	 NX671gTgsRM6K9XBHG0vi/Bb2sivj7LVtj4oPYsP6u+DBWSmPnvr0e99sK54quCw34
	 Kv3EtVqvc7/fXN+LMQ9aF57VjwaU5V/rJ2C4mFM14RjHYhWEIster8YM3h6X1fObCV
	 WHRMCA9okSn4WaV6UjvLgIStseMw5zg8dIFpCkFdLVqyu4i+HqANI54X0K557gqb78
	 OhJU6AE1bhtDCOeeV/64zQZoadHNzAjPtlNd/TmYE7LhHLsl7oU4ihgzsN4hSqkyGj
	 Yn5/380Ri3O1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BDD381197E;
	Sat, 19 Sep 2026 05:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] Compare stack frames in exact register states
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178979580765.1275551.2384650495430969417.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 05:30:07 +0000
References: <20260919014213.1840880-1-memxor@gmail.com>
In-Reply-To: <20260919014213.1840880-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 npc@anthropic.com, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 19 Sep 2026 03:42:09 +0200 you wrote:
> regs_exact() compares register values and their ID relationships, but it
> does not compare frameno. regsafe() checks frameno for ordinary
> PTR_TO_STACK comparisons, while its EXACT path returns through regs_exact()
> before reaching that check. Infinite-loop detection can therefore mistake
> pointers to the same offset in different stack frames for the same pointer
> and reject a finite loop.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: Compare stack frames in regs_exact()
    https://git.kernel.org/bpf/bpf/c/8901cee9316d
  - [bpf,v4,2/2] selftests/bpf: Cover frame changes in bounded loops
    https://git.kernel.org/bpf/bpf/c/070587848985

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


