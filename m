Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC81246778
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090628; cv=none; b=pdKGKjyd3KZqN4vp6BW/AMMgdq6CW8QwuH1FE/CXesqM5UoguMPsA6X5VIY8EPo/S1paA82humvTzz+6/8Lrn2Aa1uAnkUUIZOL86IFuQEBG7J/kro5PntJe0DQCb/Z8f5ZWU7zTqbAgHS1YZ5YDnOvJtWHOZBOZnft7X6/+Hw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090628; c=relaxed/simple;
	bh=S+MGZ2J3ujCDTDCRqaDF3zzLTTY1DigBjxJgltMVChc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJpxChfwMJHMWIEXvPQdETJGMxdIkD5E3SBn4hNrx7hTiKdibyyZN95j/dpZkIPKX/8jO97jUIImjVKCdZgLr5mmhiR7l83aRiVxzJw0WDbR3LzecJL8LaN9xQrQJloycSRxK1I/rtuPljzRzd4pXayQYamPzWSWVIZAZtzrcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he/OikuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he/OikuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA701F000E9;
	Mon, 22 Jun 2026 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090627;
	bh=Z8zK3YIcAMOsjJSG8qskJRxbZhhRhOVKrlYzeqku4gQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=he/OikuCVft+2TPfPqo757dDFlPBXHstzl7bDr++e+yGo7VvayMAZyOx4p3hEsZ0F
	 2INCRCOV+BZFRcW96VGtTmAGLFpB3tk12Itmmxl2ygkFB3N/Hsv0JC7ExEBWgVwOXc
	 6WpLlTuoXgEUr+ErNG8lT7OrMHNXrRV5mQA8Je7llkXRi4KR4lDaainnlNF0TVX6MV
	 z37tCaCUnY4SI/TsXSj6JfzcxA6tEXKxfvrkJk4lx0gdLBh0f4kAfrthxzwD+Wk2GT
	 JblVjoovOXtN5zNZA84Plg+aRfe8wvxX78e3PLewTk0a3AGgCItUkKiib93Y0Mackm
	 NsjgRzwrGs7mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5679B3AAA6EF;
	Mon, 22 Jun 2026 01:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Allow type tag BTF records to succeed
 other
 modifier records
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209061800.558026.3329413765436619975.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:10:18 +0000
References: <20260616061454.7869-1-emil@etsalapatis.com>
In-Reply-To: <20260616061454.7869-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 yonghong.song@linux.dev, vineet.gupta@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 16 Jun 2026 02:14:54 -0400 you wrote:
> As of recently, Clang is able to attach type tag records to modifier BTF
> records. This is useful for using typedefs that encompass a base type
> and a type tag, e.g.:
> 
> typedef struct rbtree __arena rbtree_t;
> 
> Modify btf_check_type_tags() so that it allows this sequence of records.
> The function now only checks for record loops in BTF modifier record
> chains. Rename to btf_check_modifier_chain_length to reflect this.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Allow type tag BTF records to succeed other modifier records
    https://git.kernel.org/bpf/bpf/c/39799c63578e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


