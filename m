Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534A446839;
	Tue, 21 Jul 2026 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655042; cv=none; b=o88gbsuZB5uvdNU/4rMclxBVpl8gW6xjgG7Pju+jTpyuXUGCTbaixE85GgLywg2RexukIVvZmGRwae++rkfY2szY7aN0M/iJqC1ofH5we9JT1OqJGr3yXnh8M6MUaFHt9JGOxHlUlO0MUeicg5dwXYqayhh5T5CEVhVa7M+HFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655042; c=relaxed/simple;
	bh=2KOGuuA9FDIkJ5Wreg6YTybx0xMLE00SXevl6PVql1A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NRcgPxxqyFLmTOIh0DO3gmDaHmOZsjRSGZ1qJv2QfTZwclh/7TRv/e85Ag5Qzte3fb9L4KXf8hVmHuYixITvo3a2uUe1zAYe2MxagKkhniYR3xQW6+Ta+vxv82NduakAu0KU7uaWAcfSrusByUg9JqRDTNlWVHjGueifMjBCEXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjUSe+Yy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjUSe+Yy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C894F1F00A3A;
	Tue, 21 Jul 2026 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655040;
	bh=PXub7QjxlKunPYoCAwyVyltbPLo7SXnDLSzJEGokQmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZjUSe+Yy0AlHYfI8ymzJBfvT76pM1sQukjtbZ3BD8WiZfQSA0TnHXoyzrjH/4R/Ar
	 NEmocDERNTLNgvfLbcsgPg2n4uOmTeYqcz2RrMcq0fFMblyBm+GMmM6ThsdBaLv1ZJ
	 XWx3yXuirVpADtJgTtlwOvt3o5EFyf/s7ABcEwS9Sbv8JtsDguujhYUvErtwVSoWhT
	 iKel7lIGeyHXl+SZdIH6+Dz0dZWFgk63S24aQw/NpTBt2Af5Co9NjFaWsBsdowG2wW
	 z1W2UTTeQljJonXc5s+VWIt3ctZrxF3/3xA3E1MPKwzOFbX5035chmX9AA1c7N9boZ
	 GhFdZ2morfdlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B3539253CB;
	Tue, 21 Jul 2026 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] selftests/bpf: A few edge case fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465501039.874899.18364184442966669455.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 17:30:10 +0000
References: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
In-Reply-To: <20260720-selftests-bpf_fixes-v2-0-b450eda93dfe@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, alexis.lothore@bootlin.com, ihor.solodrai@linux.dev,
 brauner@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 20 Jul 2026 08:13:06 -0300 you wrote:
> Hi,
> 
> Please consider merging the following fixes, found by means of targeting
> BPF selftests through openQA [1].
> 
> [1]: e.g. https://openqa.opensuse.org/tests/6087703
> 
> [...]

Here is the summary with links:
  - [v2,1/3] selftests/bpf: Fix make install target
    https://git.kernel.org/bpf/bpf-next/c/0b236ac75d04
  - [v2,2/3] selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
    https://git.kernel.org/bpf/bpf-next/c/71cf3f3275e5
  - [v2,3/3] libbpf: Search /lib64 and /lib in resolve_full_path()
    https://git.kernel.org/bpf/bpf-next/c/7b5ae0481efd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


