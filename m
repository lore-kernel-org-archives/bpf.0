Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511933ADB2;
	Wed,  1 Jul 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931227; cv=none; b=Sp+qVOD/lqje+Gq1/etLYnRiPGv31CcIuUX72cX8Q77GQ2yUKjK5zaK2uTSiGe7uenbEt3Yt5WcNyBXyCeuX5jOIv2rpFnyr1K2lzF1E/CtM9qAcwy4pQYHcgRWjLseFSpPo1jlLz61kv57vonWPPb06Ho0fneViAWvqJRNhyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931227; c=relaxed/simple;
	bh=5Kz02SwH2RtllZCaHA9PYJWvc0jjhEHguiaBMs0JOog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQ0sEyenZEplZq3wFbLbD/6x7upc9T0ixixgoG89IaNx8nH/Iy8DI3mB4tmJFzPpsf7ds6ynLUZ40pzNPpuB8LXSqgf4quLBBXQ1igl6Fr6kK7i/2obbFrRobi1jDToVZFvTN2dqy6UtdgDnkrKDZg5CaSXoWTikQR6fr6ZVJJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUGsvfeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUGsvfeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97571F000E9;
	Wed,  1 Jul 2026 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782931225;
	bh=llmiBEu9YlK2uBcO+AXRPwTr3lgF5m2AVhzPHnlHtAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AUGsvfehcUbLRrbbhrSunn7ofBf9USZaO9CgM0zxZ43y+h19jwzw83gBTlGb/6+6T
	 n9vjZmTBW5XLlbC5GbhfvkX+3QTreVemXB5p1+0+fWDIFmxeAUXrdiLztA97kImYOC
	 i6Gv2swBrBw4M1zHlyKfQQrOhnebzY8pxm6wN57JF/cpE2A1s1CrELMGLqO/wGgBBf
	 eMkQupIpYWdEjgJ2co0A6qIJS99bjbgaR3o3moY3npRCehabFIHYaXK1RyKC9uwfmm
	 YPb0NIgS/LTZXdICZuhW2pEh4wBbPkdmCNqWjuoPGMO8WZvkSZoANBes2EbQxs4FBr
	 IXZJV2sk1rcOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EB383B274;
	Wed,  1 Jul 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/2] bpf: Copy per-CPU map value padding in
 copy_map_value_long()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293120889.1244774.2607166625752769512.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 18:40:08 +0000
References: <20260624155115.85196-1-leon.hwang@linux.dev>
In-Reply-To: <20260624155115.85196-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 24 Jun 2026 23:51:13 +0800 you wrote:
> Sashiko reported [1]:
> 
> This is a pre-existing issue, but does iterating over per-CPU maps expose
> uninitialized kernel heap memory?
> 
> When working with per-CPU maps, temporary buffers are allocated using kmalloc
> without the __GFP_ZERO flag in functions like bpf_iter_init_array_map in
> kernel/bpf/arraymap.c:
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf: Copy per-CPU map value padding in copy_map_value_long()
    https://git.kernel.org/bpf/bpf-next/c/7cf9cd98cf6f
  - [bpf,2/2] selftests/bpf: Verify no non-zeroed kernel heap memory exposure
    https://git.kernel.org/bpf/bpf-next/c/163944262f86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


