Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9513563F6;
	Thu, 28 May 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003805; cv=none; b=nh125vLeLzfP2Qi3OmNsptpbrBVcHksVo2T6lJuO39+nouYD2SpaM8q+xcH6oHd+iGb7vusUMCZ4A5uKpa1QgXYEhivkiN4lEIbGcOx3NuJRD0sWqadymsf0LhPLu5mGI3IakxrQZshOuurTOImXuBoAF8XMqxTKjy884xRmHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003805; c=relaxed/simple;
	bh=u532RIUuzyS1vo8/hekWJ0x5WYz72CLTFNBG7o4J8Eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NF3XoXYmbrduhIinpfSDiPKINaZWnUZyY7EjPvz17KpN6wmOFks2V3Ji/loGkET4bd+y7+6llaIKZDPM4XL0hyzH2lw28GgzshGiR9lGgngTaXS3mH3CF9NOLV890Cjl2CvTq0wtpb/tJlBButyM2FOCGdSS2orhl4yqmhk7lEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY/DuOko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY/DuOko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E41F00ACF;
	Thu, 28 May 2026 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780003803;
	bh=l1Ez7i8bEIxq924REFxaItKmlOY2cx8OPKvV4Dwu+dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VY/DuOkoVoPxoznLaNGNw7YbNUR50/m9ri7uCDd7HY398PL19m/qEH/yZrVLLsZmp
	 wKyGzXSJpbcXt/8T+V5jfc7yjshIuSgX128/8F3nydE3UI2+AriH8bZPPMYqnhIhbC
	 dTaBq/F3L1lpitN26Bh8V5DkJt+TUINq9ay73i3Hs0naTVDgp5V1BafaMw+OniNVPI
	 O2EpTJ3fCmRIM5vAxJl11Hk4sU5R5iE7Yw3OaKiRC7Zn+D4I2V4lN9UuE6jXG+UMXI
	 mLqfO6ZV/eEgsUgrzXOqG2PoP9QmntuboYNMUfphvk7aWafBYtb1UdZNrRd1Chkvz6
	 j67ozDA1DdOFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D9C381196D;
	Thu, 28 May 2026 21:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: fix typo in struct_ops map FD generation for
 light
 skeleton
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000380741.1520554.18092173307849943650.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 21:30:07 +0000
References: <20260520-struct_ops_gen_typo_fix-v1-1-4dee3771da46@google.com>
In-Reply-To: <20260520-struct_ops_gen_typo_fix-v1-1-4dee3771da46@google.com>
To: Sid Nayyar <sidnayyar@google.com>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, yatsenko@meta.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, gprocida@google.com,
 maennich@google.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 20 May 2026 09:40:44 +0000 you wrote:
> When generating light skeletons for BPF programs containing struct_ops
> maps, bpftool incorrectly outputs a stray literal 't' instead of a tab
> character for the map file descriptor member in the links structure.
> This causes a compilation error when the generated light skeleton is
> used.
> 
> Correct the format string by replacing 't' with '\t'.
> 
> [...]

Here is the summary with links:
  - bpftool: fix typo in struct_ops map FD generation for light skeleton
    https://git.kernel.org/bpf/bpf-next/c/be4c6c7bc429

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


