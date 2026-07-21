Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B73B7741
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667037; cv=none; b=V0upaZZhhID2lLxyKje3V6TkK8uN9c79tWSRzpFrRbk84qApg2iPp8cGLPGTHsayMIO1F8PIHAPsuGuDIBHPjo7bSEbWRr/bI4nxnSsD/oCRoimGGDXZrw++jh333RnB2jflc8rOlodTneicSPPTz8jkP0p9lhP2iamoyJESV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667037; c=relaxed/simple;
	bh=jBBk8QafKCr4aKNqR985pKQdQ7bO/3tD9aO+EJTcQC0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jEcvGoqwWeOICKyJzGS5ilDCwFC1xJNfHWGaGEX4A+aM2pRAPIIFxQkzWdyM7giwQzrT8fXpyc1DC3RQ4keP4re5e9UKJAp3q4+ZJ2fiv00GX1VKGGSZk2rPMwNh09mGFq72Limq8QFX1w4A21yMx+DWrrnT411OXbnW+9Py8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FScVJPCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FScVJPCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A629D1F000E9;
	Tue, 21 Jul 2026 20:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784667036;
	bh=enXylscmsjyiXuzcYE3M2N0/N1Epqu708U93pQmnyWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FScVJPCHGNkqyRhaHaY6rHS4/5ooqk7WH8jwFIZ+a8/2dw761G6/ki7BHwtxF8cTJ
	 aXHP7mN7O4ucH+s6PeOrjxcCYIJCNqovqU0+0XZNSqDV3eyWolt3bCAFVy7NEh4C1a
	 X+0fxKYzVfiPwlfCOGnkH8HGGERq19r+uspNXUylViY4BsnAYBg6HtIfS9pMeRnBek
	 w/W+lPimLjq8eJyU4sxYdfkLoCvp3nXB4MGNu5J2PX674gjD3ugg1NfJZcsQpU30cY
	 6CxR5FsUcnC2/UkdSyT4bRotZLV6xYnExe3O/bDRY4+8ILKBYoGPPLY/o8KXXRqyzh
	 3eg6IrrQxmA1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569EF3926245;
	Tue, 21 Jul 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Add self as reviewer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466700591.1054554.8406172524883236704.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 20:50:05 +0000
References: <20260721172104.3689982-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260721172104.3689982-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue, 21 Jul 2026 10:21:04 -0700 you wrote:
> Add myself as a reviewer for the BPF areas where I've been active.
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [bpf-next] MAINTAINERS: BPF: Add self as reviewer
    https://git.kernel.org/bpf/bpf-next/c/fcac2b4a3bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


