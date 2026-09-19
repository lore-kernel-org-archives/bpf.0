Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615621CC59;
	Sat, 19 Sep 2026 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789797074; cv=none; b=h6AnzlJgymCQOnNYiQQWpB/Y+1f2sucyWA/dtleyUuotIPh0Fty/sS3Z/yO7TW50QrEmDQtY2JCIb+ARZ343+gZmo0ppQywHKGPaCFl2he71tg0llopxi74ibsqH+uj5HDQIlPqmSKCbP1PVQuLOjBSBrPZIF4lqSvKt1tXISDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789797074; c=relaxed/simple;
	bh=6TnbxwobvnfcCGQoiLtwCF4d93A2jLSOfkWUcNSju7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oQyOe62M/dSf/5cb5SZOK5TyKlHc+c8uXYo/Ny/MuCkXePQwjE7thx6NnRitk7Lqaq2fIKCa2hyBZqLFd3azjZIpYnTpaElrmNe0/2uIVCDKhMY/AemS6GfXSHmdW/zJyOMaiSB+WVOJBKibqCTd5LulHwp4xQFiaicyzaGO+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWY4dakD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWY4dakD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131E81F000FF;
	Sat, 19 Sep 2026 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789797073;
	bh=jrex8TXUpZ7q52aHdwMMLlcZJ89BHOHwDFw4QUASyqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PWY4dakDAwmVQcw4ka5aSyAlD8Na19vBS6Xnva/bEMSX6kKzlU1bU+eso76y89N5D
	 CA0q2HnKe5+S/M8jRp8TtWqkzBZxD/jU0Nos6MICGqMrn17QTABDQDHghTlI+id2TS
	 FNm76KaCOMf/NI3KOEtANSvg2tyAZNXRBSvGof0mcgy8DXk73wj7IQMAe7vsDEDuWh
	 XY/JjM2rAjm8ZotSZV9aXI8JTsdWPQNdmKr6BeNFK+Q6Lgj3sKUlLo15+c339Apiqu
	 GeF0JbVXL8BfeYwqv6jEBY1dfeWS+fOfz9Gy7tFwKIzDwzNpPrjGcaJYBwtOsH8DEo
	 nZM23aupJoDTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197843924440;
	Sat, 19 Sep 2026 05:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] samples/bpf: remove unused hash_func01.h header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178979700590.1279646.8949803445782759365.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 05:50:05 +0000
References: <20260918041148.602323-1-enelsonmoore@gmail.com>
In-Reply-To: <20260918041148.602323-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 sdf@fomichev.me, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 llvm@lists.linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, nathan@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Sep 2026 21:11:45 -0700 you wrote:
> samples/bpf/hash_func01.h has been unused since commit 91dda69b08de
> ("samples/bpf: Remove the xdp_redirect* utilities"). Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  samples/bpf/hash_func01.h | 55 ---------------------------------------
>  1 file changed, 55 deletions(-)
>  delete mode 100644 samples/bpf/hash_func01.h

Here is the summary with links:
  - samples/bpf: remove unused hash_func01.h header
    https://git.kernel.org/bpf/bpf-next/c/559b90b855ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


