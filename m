Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CD23E330
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090440; cv=none; b=ne2Wz722TUa01bb/TI+xe1K9tX7RUgyMPcCyVLSX+3fpLYg0Y8978hMFWUcP/NXr3Xh4uM58wmYUKXk8QwM59BVehEfA5EzEM2UL7UAw97vuhAW/URWL+6/vZwOcB5OlzouH6LRdKkPmBAWkFNKvq5JK0RlWIDwDHj1ZjgPWmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090440; c=relaxed/simple;
	bh=1Z0Hhzojj3Z17NyO0LQLSQukYkk/M7OzUNxjTsGs2ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WIZ3UZTTty23ufoRf8zzN7DoqtIbQ+MymVOtcHkB9u8WAW9njTZNyTWqBnFUcsL3FUKtbEy2Kbdzw/zeR7g3Zw7v3PIKBWj3XHJ/l87hNQ3GzB25fs5aQBx/ee6uBGBhMqTFxKoBUydTritTQ/3mQZc3aUS7faC2SDoUTyWvVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg8UoFan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg8UoFan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361101F000E9;
	Mon, 22 Jun 2026 01:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782090439;
	bh=CeQ5wZcYnkR7EhiNqAkoKyFA750SuMcBWYF8rJwrq1M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Mg8UoFanmlkj8SzkQ8px4ooUwp2Wx1Fx/A2DrqeQ9/EUI7kvc8iATXn8xxaqP0qZF
	 iHvWn5ThaISVCQQ28A4+Qj565U4hIXttIUVHgIDqhIOlzLNSgtaLAmS4A/glEWFW6T
	 sN7hPUV277Iqgp5XNNfpuBLyfQvGg0t0r8hdjn2tUh2nDsrQPufIe3LW6dqZP9Aszp
	 5BNZKr0EV0oA1BqOhPCZbUt5SYsyjdZqKfrRnaM2+PDe3KfRNVnMtSNYySgssIkjhg
	 iGR0n+Sox0h1wrs89pGYj4dlXMwHO6YtoQsmdyXgOcRzbtIRJ1a+Ltm0wqpsDMqHng
	 hN3Sdio7IQkow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939423AAA6EF;
	Mon, 22 Jun 2026 01:07:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Emit verbose message when prog-specific
 btf_struct_access rejects a write
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209043027.554493.551476022387640129.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:07:10 +0000
References: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260615232146.5491-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 15 Jun 2026 16:21:46 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> When BPF_WRITE goes through a PTR_TO_BTF_ID register, check_ptr_to_btf_access()
> delegates to env->ops->btf_struct_access(). Most implementations
> (bpf_scx_btf_struct_access, tc_cls_act_btf_struct_access, etc.) return
> -EACCES for disallowed fields without logging anything, so the verifier
> rejects the program with an empty message. For example a scx program doing
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Emit verbose message when prog-specific btf_struct_access rejects a write
    https://git.kernel.org/bpf/bpf/c/a933bade82b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


