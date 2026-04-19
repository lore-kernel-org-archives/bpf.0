Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC818DB26;
	Sun, 19 Apr 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600648; cv=none; b=eviH2viiUlFeGeF8nCeP82g69PxeFCXZ7ENW5ChTzBN3cHW9Qa8K5sf7EH0+M887e12rFyt9dKHvPomnNWFUPGUfwx4BNp1q3fZx71KZQXugNttBlaQBtH6I783U/H9VQq3yw49A2o5AvFO/qdVzqOhY1rZ74WyyoD4hBdwkV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600648; c=relaxed/simple;
	bh=VmOE/mp0Fjm4ADWLK0x2NyniMoIXS3RRSlhK3ChJgwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=edWhbhJvS/+gOQj4AGnEmAVmA7Y4W7asfP7IaYCpynLWLT/ENqa37UEYOXtSOFT6MppM6eOiRIURSTQ14xRYH3UltH01wCzj7lnAlejHMAP3SM2JbBMxk7BqqHo7nhX2/hI8Vbi/C5p/00UHE1Co6od+kG2fw2bVDsvYjtMCfEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SntwmDfb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SntwmDfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A850C2BCAF;
	Sun, 19 Apr 2026 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600647;
	bh=VmOE/mp0Fjm4ADWLK0x2NyniMoIXS3RRSlhK3ChJgwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SntwmDfbKkue4sdYHGWu0ghjCnsWJ2EeOoWOyMNeHD8YXg8SUbrYwj3jCa4F8MA9k
	 KXUme27ihN8fhj7dUVZ2aDppnbbEebcN8TkwpWqC3SJmcrmAH8AoZ2laoHAUuXVY8l
	 jkrCV1pGcjoDpyGLPCUcTUO0Wf4VlXOEXJ+vk60IFK3ZivaAIXlMfrpRluM1NtdMg1
	 5qFEWlsGka9PJS11JZBk10xfeCcDGgFTGpKxaD+TPylwD6VwhntQw33+qEkbKHV6zK
	 0kw2Px6oerRhnxi5qcx4Y5rk4M545XdIAiSkh5liuyo3oDZDOEAYnDLXapNT6srrVy
	 f/dQqsDvF3zKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D047380CEF9;
	Sun, 19 Apr 2026 12:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] libbpf: Report error when a negative kprobe
 offset is specified
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177660061303.747443.1190299083198193649.git-patchwork-notify@kernel.org>
Date: Sun, 19 Apr 2026 12:10:13 +0000
References: <20260419030944.1423642-1-atomlin@atomlin.com>
In-Reply-To: <20260419030944.1423642-1-atomlin@atomlin.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sat, 18 Apr 2026 23:09:44 -0400 you wrote:
> In attach_kprobe(), the parsing logic uses sscanf() to extract the
> target function name and offset from the section definition. Currently,
> if a user specifies a negative offset (e.g., SEC("kprobe/func+-100")),
> the input is not explicitly caught and reported as an error.
> 
> This commit updates the logic to explicitly notify the user when a
> negative integer is provided. To facilitate this check, the offset
> variable is changed from unsigned long to long so that sscanf()
> can accurately capture a negative input for evaluation.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] libbpf: Report error when a negative kprobe offset is specified
    https://git.kernel.org/bpf/bpf-next/c/ad35d8018669

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


