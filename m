Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30746314B63
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362071; cv=none; b=Q5UXrPIokF8+vb9dxk4Ao64M+HDMzqQ7UVkqjIsTKlskAEcI1JHCOD1Nd8DdZXgNgKRp/j0Z72zsjjJq9ROJbdoOFg7PoTmshytc4D4XFCJW0QXrY6Ol0A6A3DuBQVCiEj+5Vm79URRKspSfyvbsC5PfGNUYARs2uWMUALhF6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362071; c=relaxed/simple;
	bh=bSPrkUS0WqQy9dk3LoMfwMPolOmrSi1+nDJVNxHiUNQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANpjRYqszYzB6eYwpx7FXXnwqr6v0o1C4w4FenA/WZqyQNoTftGB7pBw/PLEM3O46HkUXkhkWcsDImcX2T9/bRXIhmMRn4ecikYk4KgZ+dkkAmsLL8TJkQMFBm6Z6M64Rk+jmVKjmXZtOryWPMZCw6ZQx4MBOuMevukgt9OG8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MG734oo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MG734oo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF14C1F000FF;
	Mon, 14 Sep 2026 05:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789362069;
	bh=DlCRHc50kiX8443AbLIHTm3S2ivbum1OA7kvXF4qd0Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MG734oo1ZTV96pVzdagfb0HKytQYJnaP1TrWhfKb223sHtx0IZF7Pd+UC+4KNWgkk
	 Ak0Sm3q7gFd/eOKd6xlX4qEmXE6pfqSEJRUz+v0YiLFgEecCbqe5DaTW97ASAxGW6r
	 RPYuQ4ammHpKetpvOcLqj+5lLPxnevhfrWeWIQZSNxJIMBiLYFsi9HD11HNAPlXZQB
	 mkoOD3jXah5RQSTyv7ZlKSVWypxwF/4DQ5yyzh1t37AXs9vxfCuWAhqiY5XT9ahxOR
	 w20WxROF6n8am5fmLbJmPwvk+qixR1Jnmjfwg4dEBfFfbtZBPXqhwjATgSNxzZHlN0
	 0Kw/DIJE4Mx9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5683F380AA63;
	Mon, 14 Sep 2026 05:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf: Fix u32 overflow issue in map batch operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936200490.325205.4267221494429776095.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 05:00:04 +0000
References: <20260903082734.623904-1-maghasi@disroot.org>
In-Reply-To: <20260903082734.623904-1-maghasi@disroot.org>
To: Masoud Aghasi <maghasi@disroot.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, john.fastabend@gmail.com,
 brianvv@google.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  3 Sep 2026 09:27:34 +0100 you wrote:
> Several map batch operation implementations such as
> generic_map_lookup_batch() use calculations in the form of
> "values + cp * map->value_size" to compute the desired userspace memory
> address for reading or writing. This can overflow the u32 type
> (the result of "cp * map->value_size") when the map size exceeds 4GB.
> 
> generic_map_lookup_batch() may corrupt values for some keys in
> userspace memory, and in some cases it mismatches values for some keys
> while still reporting success.
> 
> [...]

Here is the summary with links:
  - [v3] bpf: Fix u32 overflow issue in map batch operations
    https://git.kernel.org/bpf/bpf/c/953824e508b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


