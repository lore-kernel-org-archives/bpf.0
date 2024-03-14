Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9372A1C7
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449431; cv=none; b=NSDtjIvDaqs66+bwSsfQYrHpCKISw/GsaRCjhGl9wvDloz0YkjFLuVaOQO6tRGeboA16BCyywvzpYpBhlKbYjo9bOC0QOPNb2kKMM6yM0fCVJBy3u95Q8pUT+1+cL71bTwfKZsCNnELaR7pMK05Sirj20x0LKXUEKqggrp57ez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449431; c=relaxed/simple;
	bh=HdJS2xZEWQC8puRW7w4LzzA18+kfSSX+Y1DBmWDhZm0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pjBd54zdGDCp9RI0EekmOFKVTwSkPgZNqutW1eBO3+lWtqQYU0Sk9UNFdKATjW/FHX1AEN4iGPapUMEEsOEckq9YrHF5c4TyXwp8dZl16+bHT4Gvv77I1F9zvg5FeXRf65Md2C2DTDtqOfgqL6uV2kA8UfdqGlWdjRoXmg3tSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7ANcnV9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7ANcnV9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85A10C43390;
	Thu, 14 Mar 2024 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710449430;
	bh=HdJS2xZEWQC8puRW7w4LzzA18+kfSSX+Y1DBmWDhZm0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K7ANcnV9S2R/q9rU5TB4eTav+FxXdXxsBYaQtdPwm0sC4NqZh0jrzXNAohHpItLH0
	 ceg4TsJDH/b4JVVcvIMdXbWV7XnEywhj4W39M+J6EonEYoI3Ay0CJpTt1ukMebrtwn
	 PQ9/IdoxemWi0mEla4MaOmy/faGqsLlzczNc8bCthuB/mPolRvePF7vt+xoWjk79JI
	 vKzDuBzgXfAu1oUptgfPCISUCDPvOienNhdyYTvVoiK6VKuatBOuhub/IFxcArnWAR
	 lEITXwx0O14wOVfi3Yk2VkbpYY98roCaIFaebANHUbMXgIWHrovkj1xJ/BekPGNUHf
	 ktL7F04sv40rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72505D84BB4;
	Thu, 14 Mar 2024 20:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: Prevent null-pointer dereference when
 prog to load has no BTF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171044943046.22144.10648250930242367803.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 20:50:30 +0000
References: <20240314150438.232462-1-qmo@kernel.org>
In-Reply-To: <20240314150438.232462-1-qmo@kernel.org>
To: None <qmo@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Mar 2024 15:04:38 +0000 you wrote:
> From: Quentin Monnet <qmo@kernel.org>
> 
> In bpf_objec_load_prog(), there's no guarantee that obj->btf is non-NULL
> when passing it to btf__fd(), and this function does not perform any
> check before dereferencing its argument (as bpf_object__btf_fd() used to
> do). As a consequence, we get segmentation fault errors in bpftool (for
> example) when trying to load programs that come without BTF information.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: Prevent null-pointer dereference when prog to load has no BTF
    https://git.kernel.org/bpf/bpf-next/c/9bf48fa19a4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


