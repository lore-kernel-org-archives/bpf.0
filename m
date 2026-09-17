Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCD3DAAC8;
	Thu, 17 Sep 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684275; cv=none; b=oAczZy+DF24g9/L8j/GAitzp6f7NZv+FRWDKwP98c4UC5ofaQqHO3lVWircK50/hP6CxjTYT1bODHaauf9JS16lUnk/OKD6aowVTODWRlGULjS9qMcDaijHL+EHCv2kEfxFS5araxYReikrgozKaiFtVEY+ngHzHeM2JoSmfHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684275; c=relaxed/simple;
	bh=2XweQ+rDJ+fZAy7DSwx1gobAciV1lGVDkjAKKkZGB7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TK3/2Ci4y2fC+hlNnkOtpFXpwuvbYnwXeoThjrWWqn6THkZ+EnU+7eMQ2RlxxxW2UbJOZC6ApbBsmwWMOGRZEwblOh2VNssITYFpt2Aj4jJCen+P5AKXWEKlsZ2Hn6DSYD7IyyngTRs+RD+Zy74f7mEyGq0LQmsjC5qy4gFhYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky8711Sj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky8711Sj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C01F00893;
	Thu, 17 Sep 2026 22:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684273;
	bh=PlAtmKj/yRuyyKVdtIKk9Y8dlYAygrMY9Sp1HMi8Awc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ky8711SjEoEHDMlko0oXpy5onyqd+GbHgfF5LfBeqkaErZrdU1UDptbvutC50AXhv
	 1XY0ApD0e8q8VK4CVjBBppuLNLhDyhga29HgHhIwkgsTmRd1Q0RtYzuoWayYEL1+xb
	 3EIf8n6lk0CuH84KhI6Sc3Q+cZlMEjwuPRhlIFO+0mdJHsIHoL8qsnY9ZOqiWXYRvw
	 RMTGB2JQiyRo4KfYBRxtFixppORKfEZ/iaced8QF1qgVZ+RGSV2xVjO2EevauUsgwT
	 apvA0ITM9a1oU37bXLq5KiVUW+CmzsYm/okP7UTeA/3suYQOchVDWNn3YQkVKJfyB8
	 KAI3krRgIKTdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DA3811974;
	Thu, 17 Sep 2026 22:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Fix program log buffer size
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178968420663.152767.3344352465407469671.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 22:30:06 +0000
References: <20260915-libbpf-log-buf-fix-v2-1-2feca3fa4842@gmail.com>
In-Reply-To: <20260915-libbpf-log-buf-fix-v2-1-2feca3fa4842@gmail.com>
To: Luis Vieira <luisflavieira@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 15 Sep 2026 15:13:35 -0300 you wrote:
> bpf_program__set_log_buf() checks the existing prog->log_size instead
> of the incoming log_size argument when enforcing the UINT_MAX limit.
> As a result, an oversized value can be accepted.
> 
> The setter also accepts a non-NULL log_buf with a zero log_size, while
> bpf_prog_load() rejects mismatched log buffer and size values.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Fix program log buffer size validation
    https://git.kernel.org/bpf/bpf-next/c/8cca9a6bb681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


