Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529ED3264D9;
	Tue,  3 Mar 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556025; cv=none; b=Sw1BR/bBqiguEDdIJC6qFMylD3uHEVcENOZHL+PpvRjp1uyoGF3mH8C5skdDGzRD2Xo4uazOoTaugT3IAQKWzkIscfADAjIqOuYs6k1cXdPrCSsYyib7ElByR3HKuFuIFVw/mi95YMXUXnTg2qbFU/u3A70igAVoMahSxCc7RU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556025; c=relaxed/simple;
	bh=hkQzVbVFAY0Lw+KXpTeChxTqQv9wnktZibMANBna5X0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i40SEFP7o4gFtFqcTZUiLReMoq1sBM/8VjP1l0MHnOcETcZAsDL5i5NyajJ/Dlp98HZOFvfsJYrCnROybNcOlBHdBLSlZuxVGi4yTBUz3IoUSoYlqF0iBawClPBQNz8UMDmB7ihYxfeQmHyE1Bx4shaXlQd82UsnnhgwMqZPTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsmX74jt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsmX74jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA46C116C6;
	Tue,  3 Mar 2026 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772556025;
	bh=hkQzVbVFAY0Lw+KXpTeChxTqQv9wnktZibMANBna5X0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LsmX74jtlFjI1TECLe2oIukB884C9yoFtki+N9gYhIctupO4b4ns9NxgEbGT34Ozq
	 qIjcvbskuKh/r37YiL8/jvN24wxbZooaryAvv9rxU17JPf1MPwHR9oS4TENPhLkZ/g
	 GXXvTTQDMfq2w5/aRXBJL0kkSX2nimO3QDj9N9GvcvrUtuF4QHCOdSRmlfbRN1Ttuw
	 pPpPRnH8RkjBfreHIozBPbo5+tU+BmpMSzwDuWsuXEjH+zIfjx41vqxGGe3CM9SW/h
	 I0kagDq1uaiLfksDxlz+WQHdZPkuOfmcHlHTlIutlFfdgJW3P9Pk0u5wVJSbhabROZ
	 9e1OnEAL4UsPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0743808200;
	Tue,  3 Mar 2026 16:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog
 runner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177255602606.1378092.6497646158888477308.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 16:40:26 +0000
References: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Feb 2026 09:59:24 +0530 you wrote:
> cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
> XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
> falls into the default case which logs a misleading "invalid XDP
> action" warning instead of tracing the abort via trace_xdp_exception().
> 
> Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
> the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
> devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).
> 
> [...]

Here is the summary with links:
  - [v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
    https://git.kernel.org/bpf/bpf-next/c/39948c2d42b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


