Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130006;
	b=CeRFhq1cMKKyENdSHW/tvSSj5yt0Z+hrdqNZbZhXwJm416OfORjP/uQ8tl77bqmtRNWe
	 Uxd07jK1RiO1Ji3avUiKK6/O815yCG6JCtnU2uJh9PhfohbcvsFWBhRRev8jCtlrecrpQ
	 UXGZiFAi5h8J4J9AgG0SMlwKo4ZN1Ve8QD3a2IpOzZlkcYuTle5QGaWq2f/doi0wyf0S9
	 fz3VWstWYG5DHkcnZloZsdGdEmn7oG0oOww89+ZW75XsbMBG/QkS2auFJaZPicZD9p3RO
	 REqIBXm/Zn3CNTy5hVPFEXFN1Nsm9zzHk46A11oTcHJFmjLCAj/NJqce42Dvkks3YjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=aSYH63mhLrcrfeXiEkHrNZnfBQKFbSlly5WQSxYApVk=;
	b=RZyvSpJmAxm1XrC5umJSR+CACrfmYqeD/iqoVQP686DN/sdVAqKKVRzmD8ohPV6+tx+F
	 nQpeHTVDmkNUG2XOh5hAo2YqJy1Nl+cbzxoEjmJizSK0ZCrmHm4dXcltFgarLXkfVtrDt
	 qH2f+aJYeuU7oaQfVJEhjhXOB5h4alAiFSak0f4VToX3vO+wtWH/HW8tZJFA82unBBwpy
	 aqnfLrLXJVwih+CdMP0Pa+LhJILJiaZ9bLz4RfOAhsnt+FdAPOHBUEoEHh/5JzINFwhkY
	 fVcQW9AufMwPRbZ3PxWKOFBus24qr1HBtoovNiw29nREdsIiN1c2/owV3IhePrScoFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMCY+AGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8D606A31A;
	Tue, 27 Oct 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMCY+AGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C01F01825;
	Tue, 27 Oct 2026 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130005;
	bh=aSYH63mhLrcrfeXiEkHrNZnfBQKFbSlly5WQSxYApVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMCY+AGTHZ1sbl/zbMCOEoQINQPDHSZbZzz0Gls5IxeqHdtLD/9j7K/7t3x3LYAul
	 pDdRLXqGhUTdLZ8uhtOl61iOUVnJftqYk0FDSuRCQ1EHeVIB05qkkOUIvi3nte/WZV
	 +tOVVVnqwgu0dLUrlyFVwYF2TkDigam8TqQls0+T78gSWEjlmpG9hNnrYIz2XLZ89y
	 19ELlToFPReEoM+pahXlPDMVhMtbe/JFkBIXSTD1jsYkg6iGpPWbPE1Cf8g7phHDAL
	 uWYVcAGCgM12mi/0mCXQ5rqh2Y8G1wU1wqKh8r3n37D3i+/xZegH6WBozYhnUPBjmf
	 +Adp9BaWaIZTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE7183AA9F47;
	Tue, 27 Oct 2026 19:40:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix bpf_timer callback running on a freed map
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179313000458.289932.11629601440991927072.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 19:40:04 +0000
References: <20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu>
In-Reply-To: <20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, yatsenko@meta.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, tz2294@columbia.edu

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 27 Oct 2026 13:03:42 -0400 you wrote:
> From: Mani Tofigh <mt4022@columbia.edu>
> 
> A bpf_timer in an inner map can fire after the map has been freed, and
> bpf_timer_cb() then reads the freed map:
> 
>   [   50.709520] BUG: KASAN: slab-use-after-free in bpf_timer_cb+0x249/0x290
>   [   50.709540] Read of size 4 at addr ff11000003bc1030 by task bpftimer/72
>   ...
>   [   50.710783] Freed by task 12:
>   ...
>   [   50.710826]  bpf_map_free+0x1a2/0x380
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix bpf_timer callback running on a freed map
    https://git.kernel.org/bpf/bpf/c/815a0a2a40d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


