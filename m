Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F55383C69
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776453041; cv=none; b=t7Y6qp9rtp8is9Z8srEhvBaASwIX5E+gDUT3e1RcumqEPFt0EGMOaNmPStH96jwLqQeYoRhHEJF1zCzbxOGPh2pdIxQl4EsTGljJA8as3hxGIJ8pSi6Xz55MHqCkonSD/pGJlj4IyvwNWv3TY2hkAF46VaK3dgKAq00JCyJ/Wds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776453041; c=relaxed/simple;
	bh=dFkj+ca6uGrNHNsTKhOSNonc+Gd/9N5KNrgZziLvCH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgekNCctAbhZ76iCpoPYIQg1A7C8St9OX9q00BZ/bNZs41OSxHdzpDc7XZL7X6EC8BVPBlfkU99aXAm/bROoALVDqfRbtfSzdfj3o13cLCFB8IkFdzfYKUVSfNSoXv719G7yjAVyxC6+eeHo7xK2l8+WBMJpkEQrE9zUvTLiFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkCXQBpR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkCXQBpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C140C19425;
	Fri, 17 Apr 2026 19:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776453041;
	bh=dFkj+ca6uGrNHNsTKhOSNonc+Gd/9N5KNrgZziLvCH8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IkCXQBpRO/6MgDiy71ZDjXpbWOb5MfCYbc9BttafzA6cjp2EdwoFO9uEJbS1jMbQu
	 3BPA3BzQbL9IPvWwJAUwlNsmrjCTdFtnu4ugBm3VIhQWnDvgFk0bA/DXkVVOrufHyQ
	 e/GORTslT+9X+9+qneP0xjS8Sah42fA6HurYmCdxnwUygEnt1R6Mrs2T/HzcAA1yLx
	 /7R5H8Bg4GFTO6DsDTY8NjPIUrCLLtGjmNqLEvvYuc+WdxYjJ1bLurpfCK2obIUmcu
	 n7Xv7DJ9F20YOJimaPZzfUpa789g55ugZy3bEOj6Wgwp+MN+nRrg3MdGJ3fl9nr17a
	 nX2/0Vs4DOU9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF9380CEE7;
	Fri, 17 Apr 2026 19:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1 1/1] bpf: Dissociate struct_ops program with map if
 map_update fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177645300829.123271.1060726016212544246.git-patchwork-notify@kernel.org>
Date: Fri, 17 Apr 2026 19:10:08 +0000
References: <20260417174900.2895486-1-ameryhung@gmail.com>
In-Reply-To: <20260417174900.2895486-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 17 Apr 2026 10:49:00 -0700 you wrote:
> Currently, when bpf_struct_ops_map_update_elem() fails, the programs'
> st_ops_assoc will remain set. They may become dangling pointers if the
> map is freed later, but they will never be dereferenced since the
> struct_ops attachment did not succeed. However, if one of the programs
> is subsequently attached as part of another struct_ops map, its
> st_ops_assoc will be poisoned even though its old st_ops_assoc was stale
> from a failed attachment.
> 
> [...]

Here is the summary with links:
  - [bpf,v1,1/1] bpf: Dissociate struct_ops program with map if map_update fails
    https://git.kernel.org/bpf/bpf/c/f75aeb2de891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


