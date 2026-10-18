Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579D54CEE78
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336208; cv=none; b=mEyQmUyVBQ+3bynOVLAHl2kZ5ZX/Oj5Kv5bir/em+ac33q6L+aHjPkdlQsRHjjVS/Eka/B0eK5ZIfSLRTwrBZ6D+Q7GzL5XuYUUF6421YwX6eNCrPq8C+mlQe/iocuPVOu5ZM6NXXSBZ0pe+lPjPCS2uaRsu4d7qowRpm5cCUmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336208; c=relaxed/simple;
	bh=mYTTCaWK/9ZqajGBsojFgfS95l5+LKN9YQ6cPzrivYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XBICBHOkjXZSUshtkM9llq5S1YK3s7w124gYAt251o2WCzTKOjxY21QIoV2+IsklGdU5WiKOaQtvi6S4mHpNi1+19/3M9zyG2AqFUiht276zGoH+6XKbhF2L8rR0htONdGsNtVdtg1UKq9Fo8Kch7KX5IdY4GDz5jOj3+jXFleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaGRc5Sd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaGRc5Sd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF471F000C4;
	Sun, 18 Oct 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792336205;
	bh=/K1uDIKhAuo8s4okgbTQPGLSZc1YbXuU3fqgFkYAvyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KaGRc5Sd11esIP0gtPRgSE/OGVGlFxZWT3ewC0tQoxy1mxQaGL+rsVfa74fGosU3U
	 xXIFh0Me2bnpJPnNaJVc+Ob+qDOvkcUmZqwgicADQzxPxufWoeIWk2yuPfDjUdWbX3
	 Y8VXjzvaIF89ogfr3tyCXeYFoP6WB560+EcDE3NC1kRv/99E/kQUDhnevwUS74KuI/
	 cptl9jselVvfaaRItCmv2SvXTMUetsxBzrk1u+tCeH4b44DbDeTmtd2nxCYWu0VBzk
	 GwZXe7ua/o5uoySPWDedZwu0xkxCzWzLIWtHN/bp0OFWV09+zmVlVert/oruQ6kts4
	 kCx3tR7fEt8SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42EF381195F;
	Sun, 18 Oct 2026 15:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,
 x86: Mask the shift counts of the magic number division
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179233620462.1709764.3268728489775198543.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 15:10:04 +0000
References: <20261018113352.730799-1-daniel@iogearbox.net>
In-Reply-To: <20261018113352.730799-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 18 Oct 2026 13:33:52 +0200 you wrote:
> The kernel test robot reports for a clang 22 randconfig with UBSAN
> and ThinLTO:
> 
>   vmlinux.o: error: objtool: do_jit(): unexpected end of section .text.do_jit
> 
> Fix by masking the counts to their range like rol64() does, which keeps the
> shifts defined for the sanitizer and removes the __ubsan_handle_shift_out_of_bounds()
> checks. The counts are below 32 and 64 anyway, so the emitted code does not
> change. Reproduced with clang 20 and the robot's config without LTO.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, x86: Mask the shift counts of the magic number division
    https://git.kernel.org/bpf/bpf-next/c/73a5accbfd21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


