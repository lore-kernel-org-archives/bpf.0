Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98033A6E2
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787795462; cv=none; b=EHUJD2IsvGTrT6TL6ifDU2gjBdu322LJqe8ATZdZoJm5+8zmKZJBYdRUZeXT+4R8ufXogRF/Z0WOFfzS6OAhkGTQdFuK/Kls60VoVyL1c4dtnjXQW4hM+w1j+SGqdmJXA9P8EMoSpuPrlVGqX4PyfECwlPbXn1sdAsVZWm5q63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787795462; c=relaxed/simple;
	bh=qYLHUxVWSW5negazTvrcnPWJRINH+2aYfo6G0wXalqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mitYPgMx8UU72CFdH9mqNxqL1P+q50cUoHh5niUmig5lBoUaWNamMrb2xvI5uMbicZRPiCihDwd6q33NDlln6B8xU3cSu2vlhFOLYcPlYJ+ric1toZMXXYpEgc9RQZWOG9+wjQ6lm7VkAdLbsj6ppXL6vFEdetAXDd76jbg9j0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwS+qgf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwS+qgf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40FE1F000E9;
	Thu, 27 Aug 2026 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787795460;
	bh=ZSNhBn9PH8r5/5CN/9VrUt8T2gIMnXGnv9fxJRgqMek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SwS+qgf1Tg9Jsq++TDCctaWt9d1NUJj3fyEjzgbl9q0TS1xzBK+Vkm1x3FOAms42/
	 WHy/boN04XIVB1Tr0neYRgU2l1lbDzLrtTRZj8ZVTT9odcseFt7Dda4HncvKbdfeC7
	 Ip6OSyRERQ4UR/8E8P82utwUGbcJelWwBlJr7nyvjgfWBdEpK2wracGx51Bc+Hb2op
	 3UgUHkfkbRpXr4EDCg9ZABdRnn9NLrzDcSRFVNYpzE7xXFcd+CC6p/xSx7ckPk70Kf
	 JioQaYbCXbJgpS22K55P3F/4LzO1zwPgKPAvMjwzIXs6x1btyec9VtNpL0lEaVVPt0
	 HQxoE/f8X7zbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199773809A09;
	Thu, 27 Aug 2026 01:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: check_cond_jmp_op(): properly infer
 if
 register is null
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178779540690.975117.350693037315748937.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 01:50:06 +0000
References: 
 <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
In-Reply-To: 
 <20260826-bug-029-bad-non-null-inference-v2-1-136789ace9e9@localhost>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, npc@anthropic.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 26 Aug 2026 11:18:44 -0700 you wrote:
> Nicholas Carlini reported a bug when verifier can incorrectly infer
> that a pointer is non-null. The bug occurs when two pointers are
> compared and one of them has a type w/o PTR_MAYBE_NULL flag,
> but which allows a value to be NULL at runtime.
> Here is an example:
> 
>   // `a` is PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED
>   // `a` is 0 at runtime.
>   // `b` is PTR_TO_MAP_VALUE | PTR_MAYBE_NULL
>   void *a = bpf_rdonly_cast(0, 0);
>   int  *b = bpf_map_lookup_elem(...);
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: check_cond_jmp_op(): properly infer if register is null
    https://git.kernel.org/bpf/bpf/c/d3ef6c097ba0
  - [bpf-next,v2,2/2] selftests/bpf: a demo for check_cond_jmp_op() non-null inference bug
    https://git.kernel.org/bpf/bpf/c/ce6dcd0aed18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


