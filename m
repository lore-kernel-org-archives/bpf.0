Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA841D109
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836461; cv=none; b=RodGZy7lYDvaCLRDS32JYQ0jVTlNzHiA4hHFOtYvDWsJp4kktYlM9Ts04UZH3ab2kZaatwbBnvrEO7CP1TfhsHqxLXFyj2DxhNfVCRfPMoaYJlhP2m9O4H8NsrbFTaAzZM7SYhwe4VEBP1iGbfaFDG24XylEQSjb7U3+v2UPkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836461; c=relaxed/simple;
	bh=SY31v2UEEtmahofQq5WzmJ/FodF8VeSkczSmXx0jOAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzjNyFd+YJP9nHzgM9REvxzztf+nsVYbRuLiAhBSurUjl/gzb26ZyeslOMEbbnhgaROvJzzxNe9ti0aWEhoHrYjF8ISSDTKTK3MQOiouW0PU3aTsPUMkozgNz6TwmNEaDTooncVaHIh7eeus5Qh81msZmcLZ+tULOL2fwpZFJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzR7BJ85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzR7BJ85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B821F000E9;
	Tue,  4 Aug 2026 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785836460;
	bh=PZyI05tlAVo4QpTAtEzdEIMRwiweBL8hDXe6kLU+0ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GzR7BJ85xiiSpmdFajghnj5+NfeqC32lIOJjp+jebTr3RKrFAIxdMsgVkR8w/tZP/
	 rnE0JISZutv3q84F2/aMYga9Bv7uIoj4Wh5w39ybNzO4P32ZWJuv8dG9DAsnQdDi29
	 WftwXd39r2xxN1illv/ZW4aM0/fhxTjpeWy6axrrPyr5qoAwPW7X/P61rhXSuawH4z
	 UxDgwhjv90MrFTW8jTiJc9GFvWD5/PPbv1HUYeh5jp0UoRNmidNLUa6QGVrug6Epow
	 A4wgnz5fu25D1Sou8mbtM77lNmsYVINzD9XICxn3he0ZIeadd4u/auajz1l68nfoPw
	 DzZPGuLMU08yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A53924FC3;
	Tue,  4 Aug 2026 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Invalidate RCU pointers after final
 spin
 unlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178583642064.3066243.929090840390958892.git-patchwork-notify@kernel.org>
Date: Tue, 04 Aug 2026 09:40:20 +0000
References: <20260803112615.3362122-1-dingning04@gmail.com>
In-Reply-To: <20260803112615.3362122-1-dingning04@gmail.com>
To: Ning Ding <dingning04@gmail.com>
Cc: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon,  3 Aug 2026 04:26:07 -0700 you wrote:
> In a sleepable BPF program, a spin lock can provide the only RCU protection
> for a kptr. The final spin unlock ends that protection, but the verifier
> leaves the pointer valid. Another CPU can then free the object before the
> pointer is used. A capability-limited runtime PoC triggered a
> KASAN-confirmed task_struct use-after-free.
> 
> Patch 1 invalidates RCU-protected pointers only when an unlock leaves the
> final RCU-protected context. Patch 2 adds a negative sleepable test and
> positive controls for non-sleepable and explicit-RCU contexts.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Invalidate RCU pointers after final spin unlock
    https://git.kernel.org/bpf/bpf-next/c/180c7000712d
  - [bpf-next,v2,2/2] selftests/bpf: Test RCU pointer invalidation after spin unlock
    https://git.kernel.org/bpf/bpf-next/c/bb2df6fd891d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


