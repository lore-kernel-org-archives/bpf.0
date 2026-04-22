Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D755B1EB;
	Wed, 22 Apr 2026 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892847; cv=none; b=hAEFHUJjI8nPsBfM3jj1+GpG+SEx1rZ0lNlEPnK+EANbSHRwaAQzwfeEyPJVkfGxghSxlzSBpJ6vf4tQfHFkQ0g2eMfLUr93b1yJN/9/Kw2KShDeGADntiiPULLdMj4PRgCYMz0bUUzP8ly0Rgiqgx6FgP1K5Vv0rHMIE+fpVvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892847; c=relaxed/simple;
	bh=xNHI594aiMqpecdXehVR3ZQD0ZoiTrl2cLuFkfBG6nw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWeicMX0tXUIhTV5OlkjKO+CTpyvJrFQNPbNN9xFDulU70i5UDhiuntL0yc7iCcTROR9rnKn+2/sTw+ji9F72a2sHSUGm81PyI0Oeb6rr7NjVHhvZjeFBQQvik+i3b4CIXVz2bMHH4YWwiNkG2WUDAI13mte5t5waTSzEz3B/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDW2sj7J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDW2sj7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA9BC19425;
	Wed, 22 Apr 2026 21:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776892847;
	bh=xNHI594aiMqpecdXehVR3ZQD0ZoiTrl2cLuFkfBG6nw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BDW2sj7JmTDTKBagEsQOfLc/cgtwpvZwupW1DsgGvaFPoqsEt7EZUd+tyHzq81fL/
	 wbTOt9U9V8kX83B3OYTRScr3Ay2sWGxnJWjhedMVYo5CkPookmjPm5oSPwcjJyNIxQ
	 fBlLoVP7/pr9ZdjzzAqF7p2slFIFvqpu2XYwFnfbLd9tExRU15WatV/YmOq+1uK51a
	 UYoUZrqD/CR1W4rRMX///u4hVtyC9btuBtwNb3cQFY9j7vRJF2TN6VrtWeyC5yZgWA
	 7vgS65CLyI4yZsf5+6lgimaTuZnX21IbczOx428NB2vxUVbUDMgChb36NuR/CJZfbP
	 0Efrd6zx5opuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F9B3809A85;
	Wed, 22 Apr 2026 21:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177689280955.4040916.1149416555658938866.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 21:20:09 +0000
References: <20260420134637.2513867-1-jmarchan@redhat.com>
In-Reply-To: <20260420134637.2513867-1-jmarchan@redhat.com>
To: Jerome Marchand <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 yatsenko@meta.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Apr 2026 15:46:37 +0200 you wrote:
> The file_reader/on_open_expect_fault fails consistently on my system.
> It expects a page fault on first dynptr read of some range the exe
> file of the current process because it has paged out that page range
> earlier. However a lot can happen to that range (which depending on
> the actual memory layout could contain text section, data section,
> sections )related to dynamic linking...) between the moment it was
> paged out and the moment the bpf program expected to hit a pagefault
> actually run.
> 
> [...]

Here is the summary with links:
  - selftests/bpf: Page out as late a possible in file_reader
    https://git.kernel.org/bpf/bpf-next/c/a20f97791a78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


