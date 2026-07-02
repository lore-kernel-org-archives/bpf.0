Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE8D344D9F;
	Thu,  2 Jul 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009825; cv=none; b=oUxEHeKWnvFpXwEz8uvhQuxncZgFclYhOMpizZxss1LFn6rpC5HH1u1bYOhjxy6EKyYLMdeF8Fd+dfzYSDeSJAM/3/vga1YjAHoWsgx71y+qXnV+gXvNXKczMeIz4N3Jjpc5o7xgO40htzqp9OWg4iSojNXvC+rTihblpYeDUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009825; c=relaxed/simple;
	bh=VGIrMFfUO68ru9Gm3ijUIOF4czSsIOuPHv1JMHISwBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SRFI7KapPGgGAUAU/2BcKOc2OEvkBgURDp9e9K6PrDCrK16BdRKO1YJ/5p3YJvDeGT5H5F9iJ+B65rFvy/qYQZEnAGgJiV2HFe1qDMDWzxC0vpo9NhixvYicVLBdcA7/3HXxcSKDagBg+hhw8NK5hDaOVgz1SMVgeoZ78gJMwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg5mJA+c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg5mJA+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3811F00A3A;
	Thu,  2 Jul 2026 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783009822;
	bh=VISgW3J+ri7MacFLLUVnHH3VEp7193wwlfi9aC8e9FM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Vg5mJA+cuR0kiaMUXxs5zp5E4arrECuL9PB6HUEL7N1YzaVe3OgQSYVTWI4oiPCc1
	 m4qiD6b+hk3AnYyjA6A9jRTJHXrgE4wQEODhaX8g+JI1VEP+b/IxApxO+rJ0nLlZwL
	 Ppx3vsiL9Pzleh7fcL9mpSagXUtEE/tKAFfBF9d3H4tBAR4ui+xP37lQnJg8gKShk/
	 ZqoxZwAtnCym94Hzvmq0dD2xgdI4CmPYfs3VI0lPEnwGTvtIFyRPNGDENnkQTg5EOp
	 9mBrmi5jNwMKF+/S8sVFSgBCnYn8Axn+t9KeTCG07k50sP0TW0FVzsxSXPHybX0F8R
	 Q1Mhyj6aq3X9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09A439309B8;
	Thu,  2 Jul 2026 16:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers
 consistently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178300980565.1768277.11391992832497919628.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 16:30:05 +0000
References: <20260702012311.2265001-1-luoliang@kylinos.cn>
In-Reply-To: <20260702012311.2265001-1-luoliang@kylinos.cn>
To: None <luoliang@kylinos.cn>
Cc: qmo@kernel.org, ast@kernel.org, andrii@kernel.org, kafai.wan@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu,  2 Jul 2026 09:23:11 +0800 you wrote:
> From: luoliang <luoliang@kylinos.cn>
> 
> The btf_vlen(), btf_kind() and btf_kflag() inline helpers defined in
> tools/lib/bpf/btf.h are thin wrappers around the BTF_INFO_VLEN(),
> BTF_INFO_KIND() and BTF_INFO_KFLAG() UAPI macros - each one simply
> returns the corresponding macro applied to t->info.
> 
> [...]

Here is the summary with links:
  - [v2] bpftool: use btf_vlen()/btf_kind()/btf_kflag() helpers consistently
    https://git.kernel.org/bpf/bpf-next/c/bb4e90e91ba1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


