Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E3C8E6;
	Thu, 12 Feb 2026 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770859719; cv=none; b=oMbEcByGc13kf6q6bteDzYEEmqGFo7WBs46yzamJr4FjLNeinrKIsvAyvZFo74qGIpAftTtM3CwrNFilwCUVxpgaKp9DPLBYM9ciO/hPHj7AEYfmQyPcQJekpGtJJCeAip7ds8N1EBC6e7FmF/oG7lRZ24M8cRjtehJ8UVBDLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770859719; c=relaxed/simple;
	bh=8Yg1RFg80tpAhdhD9psz+mJXkrc5ycYTezdfBBb3eXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MJe/tUEzYBwZBouOkKlagAgw39JGFNYMqZ2OQWJKPvsQXHcgfrNYA4PQSQ0yALaz5hi9NDE8FsK4N17e+4BdadX+MWIYgu7GGK6X7I3TtEldVGcNygllkpop/T+maHoYrj5YDoG6bA8bJPv9IMre+zXt6rGGziPra72+/uIZg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHTg2mMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHTg2mMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21D3C4CEF7;
	Thu, 12 Feb 2026 01:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770859718;
	bh=8Yg1RFg80tpAhdhD9psz+mJXkrc5ycYTezdfBBb3eXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iHTg2mMVE5USaHe6Tll8RP+FlkBa2ie6mh1hfjnJ1cjFZcTpZJRexHvJAoRSCvP0O
	 b0ImzXdCjluiKgPqlwduz/sFSHTwGNKt6t7NGJMAK009JFoUf0NYflOyQ27m1FXp+k
	 fjpTiyd4FZOMJPWEkh0hR4fS/qqT1+yvXlNe1LRxiV2JtmozHVgzhZTM0L7SgLi4u0
	 +eoan5D+AfY1SwBZAajveZHsOIilgy2Abzxrur86mJfP2i076oyi8qpQvpDKF9OfDK
	 epFqAdHvyyHJ0QTqi7JA7GJnN1r7bcTNKaNpJ6d8/kUhpDEkMZEuVioX5Pse16CQ/J
	 EARGkMcAzziSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C203A39EF966;
	Thu, 12 Feb 2026 01:28:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177085971357.817736.11815620280391831698.git-patchwork-notify@kernel.org>
Date: Thu, 12 Feb 2026 01:28:33 +0000
References: <20260204132643.1302967-1-arnd@kernel.org>
In-Reply-To: <20260204132643.1302967-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: kees@kernel.org, pmladek@suse.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, lkp@intel.com, alexei.starovoitov@gmail.com, andy@kernel.org,
 ast@kernel.org, brgl@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Petr Mladek <pmladek@suse.com>:

On Wed,  4 Feb 2026 14:26:23 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The printf() format attributes are applied inconsistently for the binary
> printf helpers, which causes warnings for the bpf_trace code using
> them from functions that pass down format strings:
> 
>     kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>     kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>       377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>           |         ^~~
> 
> [...]

Here is the summary with links:
  - vsnprintf: drop __printf() attributes on binary printing functions
    https://git.kernel.org/bpf/bpf-next/c/b07829d546c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


