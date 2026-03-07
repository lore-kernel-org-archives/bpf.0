Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753972745E
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772902810; cv=none; b=tZ+GmLgj/1NDZ883jelkQHnnnACNxoxiMz9290R8YmkPrEOnNOCWyDdBMM9hIIqEvg8seNImUxkfr0V0nTD9IfbXLewMhCicE/AJBV08QBfJe1uv3ihwhDt4iCE8jX2+aCbPOAPwXvkNQC/o2+5/BVuAUbFkU1C+YqQ5sO3bzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772902810; c=relaxed/simple;
	bh=hVH/nLEIJXbZxhMkm1ctdN2axYtTBbCDVlioh0fa9GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y0vCKARZHjvwHoetvcLEXUrgA57pw674cqnYc58liXnRon72FePPwDHA0CaIHQLqSMJ6YrcpTCYhkobqLAxGyn5jqMTWDIrsSE/ddBSvjPThTGYSYlIDFSOsspLjAugOXOdRNARJb/nE0AYHwK1mT+9niaKFgeuwuzy92/Obgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfRNxZd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfRNxZd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7BDC19422;
	Sat,  7 Mar 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772902810;
	bh=hVH/nLEIJXbZxhMkm1ctdN2axYtTBbCDVlioh0fa9GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OfRNxZd3Y3h6dxtbJadf9LObtR32p1DR43v1ebh/uFTWUgqQWoCRWFZG58ZqbT0TK
	 KECD2VPek/cLBZyRcLjmxZBNZ8h278eFLKCY4czg1YUS/vHCL9SHWAAubYADDXjklB
	 eur++YNfVl/731bXxuvL4Skz5COcLUivl5gN2Z8BKJ8QUq1IcsdgnNSn4O3WjJ5qQq
	 iFtAMPyW6g8h8LDqACHt+Izf9cG30ulrMrq8I2BBKWM1C3I++F+fl7OWaKmBfjPWTc
	 +H+uORUk09XAwtt4qXkHV18tdcL8FFZkjK3n5xBlqhZ/92SZJOe9PNP7xqxDlmOUa4
	 8pVGcoZPOOu7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02FC63808200;
	Sat,  7 Mar 2026 17:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] resolve_btfids: Fix linker flags detection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177290280858.277115.15845114856619296622.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 17:00:08 +0000
References: <20260305014730.3123382-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260305014730.3123382-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 paul.chaignon@gmail.com, vt@altlinux.org, bpf@vger.kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  4 Mar 2026 17:47:30 -0800 you wrote:
> The "|| echo -lzstd" default makes zstd an unconditional link
> dependency of resolve_btfids. On systems where libzstd-dev is not
> installed and pkg-config fails, the linker fails:
> 
>   ld: cannot find -lzstd: No such file or directory
> 
> libzstd is a transitive dependency of libelf, so the -lzstd flag is
> strictly necessary only for static builds [1].
> 
> [...]

Here is the summary with links:
  - [bpf,v3] resolve_btfids: Fix linker flags detection
    https://git.kernel.org/bpf/bpf/c/b0dcdcb9ae75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


