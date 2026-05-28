Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1B1325485;
	Thu, 28 May 2026 21:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005002; cv=none; b=AwL6cPL8qMyeOg+I8cv+TfBC4YM3J7mXp200AGYtlQbZKsfLib4gnPwS3xqCahVXGD3jy6AyR0+bieDnSvDoi4e+zp9BdNlOhOWYumXdJ6Px/UbXtlp/+lv7/8I1c7f7TLLHnA+ukOT9ct/pcAq3l1/Fyu03vwhpY49xb6uL9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005002; c=relaxed/simple;
	bh=Y+ueoG9iB0qiKbcAKPwb4xPQL9PE2szOAiQSaS9FHJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RE49WeRTs2EK5Yxnfs63ffiOTLvy4p8YPszQhXJqLkXHQm1vsR41+QhlTUkTsnqANrO+PW7F1Q2LhlAFb/u7pV2bl5IvJq4WDGDnBUdBfAC+FqpddQK6pI4vkkgRfaqlcLs9rpjP6R5v/vytKxUQ9WFohwv8BlcEetMUJYv1nnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiHmLjzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiHmLjzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD451F000E9;
	Thu, 28 May 2026 21:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005001;
	bh=rA4HfdfZKojkFYplCCzpwCWwDyyQ7Ml2jDbuYpPVnNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DiHmLjzjNHGzh5/TE80+anc/g+w4ytDlgTtnqh4Fnv1fapK97tWydsysWymchXTvU
	 AIBQac0ERKhW+slfb/VV3aPpf947+ueLM7zsUMJzs4kGxVOJAez2a87jdgjXw6mi0p
	 6/0jxPMqdBuyfmCk7+5NoQo0K/6kZNyM0fe79Q01RHig+brQQU3iCracw+CdA1cRf0
	 /UbtweV1XFR4qRPJuk3rYlTn32CLJNRfw7zbGN7F4OBVgoWloKAlVmwcrY+ndLZ0oO
	 xSbH3/hrcWYkvdGbNJyaOdrcuqLhwubQAdz61XXuARJa/KLz1DbxKf8mkHP64JM0DA
	 ejPj1jfLaiI2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19969381196D;
	Thu, 28 May 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Add __NR_bpf definition for LoongArch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000500565.1525803.6064501122964198942.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 21:50:05 +0000
References: <20260526063936.16769-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260526063936.16769-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 26 May 2026 14:39:36 +0800 you wrote:
> LoongArch uses the generic syscall table, where __NR_bpf is defined
> as 280 in include/uapi/asm-generic/unistd.h.
> 
> To align with other architectures, add the __NR_bpf definition for
> LoongArch to avoid a potential compilation failure: "error __NR_bpf
> not defined. libbpf does not support your arch."
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Add __NR_bpf definition for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/a4a5d4ee0612

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


