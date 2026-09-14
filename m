Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0DC3115AC;
	Mon, 14 Sep 2026 04:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789361471; cv=none; b=BfrrM8GwRHgixGyJbN4Dv9ay8xbZhTpj4bCEOkAyGpxlJ23co/RBGomXn2wp8P1lxI0Q6AOue5MySbxRKMVpQseA6VO/hc73H/4GjKHGNL8dV1YRj6vmFHxK+8JZy9bTP8CX26bD62Gw5F03lgel8orAa0eq2Qyj8d9wCJZ/ANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789361471; c=relaxed/simple;
	bh=ty0lL2XdGaJ16xd8LAp4MjWH5vFih56YMjJeBIWwGPg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p8EXonIOtjapp60HtDv5rRsmtfWhUpJfwEkhiVEX2+4YRHSzeYNQ5JUDqIQCsDMYgglKy9mmcZrUtUtrioS8rg9to+33r86Uc9sBOdRyw2Utm8t9v533sqv1z6X/RWBm1pm9QSR+NBYsBBcsEQfyB/mUR2BBIhSvHX0lEIw4T+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeQtjrGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeQtjrGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709611F000FF;
	Mon, 14 Sep 2026 04:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789361469;
	bh=a3gFrigOiuyKqxOGSC7uDkyzjzEhyZx4u6ZWL7zbPLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MeQtjrGwy2BYnAiJdS4o/ast5Nb77gHoBYTRLvGcy9DwjCXSEAbzKW9Ph9G6cICFi
	 xVv0pm6ibBNKq3wkT5I2bX0FL9e3tL+lf7gqG3pQ6WQbcZ/bo92Web0dKPtlOcoIGp
	 HafwrCFCNl8YYmaaZ/65Eym98u30Bu30Pw5EHPVgF9qEcmy3kkbGCoR5AxF3xVcni3
	 0EocryL22nGsvPVgk+BpbjSkEOwKETF8Nv9CCY1I6qhoY9QeffJqzKzq6wV2t8hz1j
	 oKUQ/ah6Bi+QXp6eXrY2HMzqUeIfH59TFrx/LfTS6tbHmGk10jAhlR57V4233/L8Ft
	 VEVcKG0Bi6bug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199FA380AA63;
	Mon, 14 Sep 2026 04:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add test for indirect
 struct_ops
 trampoline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936140489.322883.12116940153387060587.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 04:50:04 +0000
References: <20260908073506.29734-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260908073506.29734-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Sep 2026 15:35:06 +0800 you wrote:
> Add a test case to verify that arguments passed on the stack are
> correctly read by an indirect struct_ops trampoline.
> 
> This test ensures the correctness of stack offsets across various
> architectures. It is particularly critical for architectures like
> LoongArch, RISC-V, ARM64, and PowerPC where arguments beyond the
> first 8 registers are passed on the stack, as well as x86_64 and
> s390x which have lower register argument limits.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Add test for indirect struct_ops trampoline
    https://git.kernel.org/bpf/bpf-next/c/698181b2d5fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


