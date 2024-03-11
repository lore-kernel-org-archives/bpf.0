Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE6554F9D
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185958; cv=none; b=DVe95PR+F0W6epmkB4zo9VNndHp54JKMQ87sw5QSlg1AVBZkwpmAibscVMw9LBuPaJgGWq9w5WmJAf40POMTwwEVxhS4TwVmWa2ad9vxlg07+xgkKR1unh6oDaNgRNFwD1XP6ZF0/aun24IIB4JxXHt9G275mmu8ZjE2wdpG9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185958; c=relaxed/simple;
	bh=838nlSPSd8VtxeF/9bY/8eWtOq4VGPOsPKx3e506zS8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VBPwiTAuC4Bq9w7IJcaWPd3qU+mRDH4ggR8lAcsHVFdb7+U5edfCxTNYVBFUQQ2DWxOajFwWxbKih6k2JwpaBOWfHMoWUuySLvwHItxW4EnwT3q/6V7ej9Sd98uYbjjmS5BR+gmgRUKZq7P5tq9ygKdNfPNo8aGOuxiBsh9EG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKaIDQdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKaIDQdY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA224C43390;
	Mon, 11 Mar 2024 19:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185957;
	bh=838nlSPSd8VtxeF/9bY/8eWtOq4VGPOsPKx3e506zS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IKaIDQdYOgdsVH7DAN5wjlrR+lg1mGQy52PRApSrrr3PCRiA0zWCEFjs5W7oAVAre
	 /oEHeP8QrCVbtffnHV8Kpt1zsK7z8iaVmUjMdcmDRH4obc2aQNmtsCzM9frfGl2W/w
	 DOFb3NgcWDgpByIybatGmdR7KN2AK/UHA4ulxR2b3WjyBgLy/gK3sITCiO0Ogu30kc
	 bVwnKqLT4TfdETSyYmHdxHgPdMd71mwIMvcE4vH7D9Cci0DJ+aE36nsppspeAee+Kw
	 sbLy6S6gRK2SfZPC/lbdRBbbICdT7LvNoQYsUXG/Aiw1HXUm7rKBUc5Tss4TdA39OT
	 wbQLFKrY1+SDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B925D95055;
	Mon, 11 Mar 2024 19:39:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: add fexit and kretprobe triggering
 benchmarks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018595756.1144.13320459973031684069.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:17 +0000
References: <20240309005124.3004446-1-andrii@kernel.org>
In-Reply-To: <20240309005124.3004446-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri,  8 Mar 2024 16:51:24 -0800 you wrote:
> We already have kprobe and fentry benchmarks. Let's add kretprobe and
> fexit ones for completeness.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           |  4 +++
>  .../selftests/bpf/benchs/bench_trigger.c      | 32 +++++++++++++++++++
>  .../selftests/bpf/progs/trigger_bench.c       | 14 ++++++++
>  3 files changed, 50 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: add fexit and kretprobe triggering benchmarks
    https://git.kernel.org/bpf/bpf-next/c/365c2b32792e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


