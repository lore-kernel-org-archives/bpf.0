Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D178F44
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591428; cv=none; b=m/kix185g51pvzdUZHc1EwmTE5F7yzuVg20+E1DtncVS/j/BDfMZw02ZwQlinWBEMEsGo9iEwKAlWh6V579up/JCO28UlrJdkHxXhI6ArKdnIpF8ENWuL17D/QQ4J4vctWupmh0ftGylfNm2gXRQjgVNvLVe9l3wDz4BpfNBp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591428; c=relaxed/simple;
	bh=sAJm5RivjLw1OusTuLRGKgsErDrYWdHBJ1oj2+9KluA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GkMMmOey5HKkOhtUh1vqiFSH9FMs4GZfQJwSjTRXDC62veTnQUAGbWW+49j+QmJAH58olf+fUkJa+eEZAkqaNQU1WIMd5iLjkxRE+Ly4ZPTRkfSRCZVTqGTdWVfJik5HAPT8C+MDsuqAofor6wncxyU9SsRrpd/USlx0uX6U4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMUPZx6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMUPZx6a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB225C43390;
	Mon,  4 Mar 2024 22:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709591427;
	bh=sAJm5RivjLw1OusTuLRGKgsErDrYWdHBJ1oj2+9KluA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eMUPZx6ariSqy9Q/GOExuiBabHxMq8q8tGSZaV/1O4C0hv+CRViEPKGdjUP2uRY+l
	 cUL3gfnhfb6G49f+dr+id1ZQefJM2OPb2vDAdINEfdQPAoG3+HwesOXb+Bg5IKjZ+9
	 W3D0UntMUyrjvhN1FQGE7sIWxlJBWbbfsypMH0/A20+X0a67+5AbVq8HANT9B5rQMh
	 PcoFedggoyRE+VI2FDIswEgm+P8jyFH9GbZFSkzjZxj8Gw1gL9VXhAAmSJvPoRJf5/
	 P/Uoj/YVrJOhM6QZEgOYiGuJLJ1adWFMgKfVCpgSSMKbAkym8vMTjOkj+dvOOS1Zu5
	 AyPXz8/KA9lNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92068C3274B;
	Mon,  4 Mar 2024 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Allow struct_ops maps with a large number of
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170959142758.32228.8319096514120156761.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 22:30:27 +0000
References: <20240224223418.526631-1-thinker.li@gmail.com>
In-Reply-To: <20240224223418.526631-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Sat, 24 Feb 2024 14:34:15 -0800 you wrote:
> The BPF struct_ops previously only allowed for one page to be used for
> the trampolines of all links in a map. However, we have recently run
> out of space due to the large number of BPF program links. By
> allocating additional pages when we exhaust an existing page, we can
> accommodate more links in a single map.
> 
> The variable st_map->image has been changed to st_map->image_pages,
> and its type has been changed to an array of pointers to buffers of
> PAGE_SIZE. Additional pages are allocated when all existing pages are
> exhausted.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] bpf, net: validate struct_ops when updating value.
    https://git.kernel.org/bpf/bpf-next/c/73e4f9e615d7
  - [bpf-next,v4,2/3] bpf: struct_ops supports more than one page for trampolines.
    https://git.kernel.org/bpf/bpf-next/c/187e2af05abe
  - [bpf-next,v4,3/3] selftests/bpf: Test struct_ops maps with a large number of program links.
    https://git.kernel.org/bpf/bpf-next/c/93bc28d859e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


