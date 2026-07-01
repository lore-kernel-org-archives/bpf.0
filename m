Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79C37DAAA;
	Wed,  1 Jul 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936624; cv=none; b=RmB5dIh9xO32BKzGW+WYquLhrdi5sBl/W/bQowpHFDkghLPquQlww1+waJ6zehULW72xmHWl28GNj6JxgFa6KueQkp50JYLA0BY1Qg/aELSGRA6cOEjSfXkOWxxiI86ONu5GUioi9dlcBCGMqSiJrL3aAF3OliOCdJZz6KfqMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936624; c=relaxed/simple;
	bh=eok8XwQQ6Qa0NP8akjsCbB6+MoK83H18G5g9ymcyG/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nde3PWpnNHotJBBt40CkGZxz6lTxvYKwA6UxFNqQHzNSWinK5+dng+QcUTr+CFpLc25W67rp2hlJyN9zXGi6Qw32uvzgtSp/kEdrP3T9SkkOulb54DME6dtCIyli6AbA7hpSvANy9UEtOJOtpdFikNj1PG0P3htc+yxXPV8amyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2DqErQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2DqErQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841DF1F000E9;
	Wed,  1 Jul 2026 20:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936623;
	bh=7FK9Y4pqjr1uan2yKqbpffTjM+I1t5KCwSKAi+g4bSM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X2DqErQEdQg7tYBEjF/EW7ewy9hYgc2Cj7oY9YBK3LsGbzhK5jLM8wZ0QNLuCv8SI
	 YSaJr0XFjXxaje5LO89gU+krIA7ep+AoLM3iIzN5pEX/sSx2ICmUxetl6EvZEpm9qM
	 0oDxKVQlxmAsgHfZuX3MFKkJG1WKk2tA5ajErsrDfHl8wbNfhgbH46lD9mobMojQBh
	 QOpPsCMqsrv7W363YeneNVOEuRYJy09i78QR16L3d9lr76gtG4ayEc/qYy7HhLfncR
	 en5lZEOeN45u09OndsmYzS1y+HaiFXVvLevei/E/618QfCwDBDzX/cIU0KyKxkHfRM
	 5irreB5gxYMog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197FD383BA30;
	Wed,  1 Jul 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] bpf: Use BPF_CALL_IMM macro consistently in
 bpf_do_misc_fixups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293660664.1278318.10938621476136606874.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 20:10:06 +0000
References: <20260701035107.8069-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260701035107.8069-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 kafai.wan@linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  1 Jul 2026 11:51:07 +0800 you wrote:
> In bpf_do_misc_fixups(), the conversion from a function address to a
> BPF immediate value is handled using the BPF_CALL_IMM macro inside the
> 'patch_map_ops_generic' label block. However, immediately following it
> in the 'patch_call_imm' label block, the immediate value is calculated
> manually by subtracting __bpf_call_base from fn->func.
> 
> Inspired by KaFai Wan's review comments on fixing helper call offsets,
> use the BPF_CALL_IMM macro in 'patch_call_imm' as well to clean this up.
> This removes the redundant manual pointer arithmetic and ensures coding
> style consistency across adjacent label blocks within the same function.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] bpf: Use BPF_CALL_IMM macro consistently in bpf_do_misc_fixups
    https://git.kernel.org/bpf/bpf-next/c/475b59db3bd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


