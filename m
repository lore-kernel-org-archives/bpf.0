Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292163C945A;
	Wed, 15 Jul 2026 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108452; cv=none; b=eTl6mI9978gEH6lvDpYOwntIWSUIq6sOZbxp1B9JWdEmn73G2KlRaDhvfdqORL7Ry+BKaYUmpmVbYZbdPrc6QsYy301sTOg/nhsizXL4+rQvgPH7Woc5UO2wiWkkkHCmJsiGCKCyjWisNa7Sv+poKxhW/61HSMVbSb8Pj1UXFMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108452; c=relaxed/simple;
	bh=mCZod6BhvS/MXwqNaTxht//Z+ReSR8i3zWPM3hDQEuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XEvFv7mxdnMBj5flSkyJeJVIlywq2aFahczobvRMGIT3nbdb375lkZlBCrlHLbPtTShdSOqhIfUg4JhHeeuAihrPAZG7KHA7IhwLKC02+l8CGPwkQfhd3MdWBH91pUCu2I3+Rzk8xa4EB5M86u3BbWxSflXrvLf3yanBd+MF4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFdlkC5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFdlkC5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EA1F000E9;
	Wed, 15 Jul 2026 09:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784108443;
	bh=f/ZMJ/+bZkYQ86nNktKz7vRxlblGpAKNcg8N6oXLVl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KFdlkC5yTY9c+5RrqpK7Q04azV3Ku46W/Wl4lJNQPweEpGf0oS8+Xl+jVMqMydXB+
	 rQubK03JudZ6SF7dvzuFAIr32uiAeVvhBKsdGu+2EE77Olw2dxUDtX/HaiphRey2xo
	 eS1beXeM6f7dFZyj+ENQ6lTtDS0MwR3hN4cU7NdvI/3jliqO6w/Tk1WAW52mB0FaBE
	 5tltBFubGjDMJhIFLRzza0L7ITMH4Jr58lIHWw/wpVw5z0Byzf0RwpLWOfar4lQ6oO
	 xV/cXLL2i1Qp6XwqajxKAtp0VAcOdUL1Av7e/CZ0c9okDeF+YlTxa5b9ctn21ZdKNp
	 NBWIEWC+WMAgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B163939340;
	Wed, 15 Jul 2026 09:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5 0/2] bpf: Reject negative const offsets for buffer
 pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410841689.3988381.5999018507297554942.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:40:16 +0000
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com,
 jolsa@kernel.org, john.fastabend@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, shuah@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, shung-hsi.yu@suse.com, mmullins@mmlx.us,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Tue, 14 Jul 2026 02:38:44 -0700 you wrote:
> Reject negative effective offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
> accesses. Calculate the effective access start using signed arithmetic
> to prevent unsigned access-end accounting from wrapping, and cover both
> load-time rejection and the raw tracepoint writable attach-time path.
> 
> ---
> 
> [...]

Here is the summary with links:
  - [bpf,v5,1/2] bpf: Reject negative const offsets for buffer pointers
    https://git.kernel.org/bpf/bpf/c/fd4cfa8c8f9a
  - [bpf,v5,2/2] selftests/bpf: Cover negative buffer pointer offsets
    https://git.kernel.org/bpf/bpf/c/6f59deb32efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


