Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9530B50A;
	Wed, 15 Jul 2026 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106044; cv=none; b=iDn74KVyWadSEjw799OMUXjs+GllV8Dof4KiYiBNELhBStxohft9T3nHcGXApVJHbpgVIhP12TQq9nRH+XHAHBNGLTSeQhAzNLhAasDa8zYICZBmjjFUae5hxXGDXjVi88ccIdgG8a5KqZGKtFCJukg4lo+gj/MreLc8X6+2PVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106044; c=relaxed/simple;
	bh=RXpcHh+L+BVC/QlLZtCn3STz9tbih4fsaYBkRCVXtKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Use9qg4Wilu07WsC28RO10KKQrSX9gcxfaqblVEmHR81pXXnhz7UdbeV5+6nfipaDaPs96KSOX6WRlMPG3G189UPem66OgiqYUDTLP9xD0+cfvh6RVopNwIzrzUuEulmW2YbMCFGf9n3g6f8lNpbKakPH0D4NudlDuPBPp2XUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIuuAaYO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIuuAaYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C741F1F00A3A;
	Wed, 15 Jul 2026 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784106038;
	bh=r3/DE/HUhFAwTh0cMuugnDigN+Qjr5BF0lGgYlFT9w4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mIuuAaYOtDZpE/sZYWdYgJ1XmjhEMzfZphzZ2Nsxq6rK5XIazjBJNsfHWBRTsCQlH
	 iKueoeeyOaur2XhQSNdCCmoOtebw7I/Oj+R5yRptpzIFCx3wgkk6tZiFVEy2UteXK5
	 6NB1yvidk+wrImmSbCIo6tWBSK2XCD7ybf3CDnIInDNND7X9+p/l5KzQKZZykM5CE+
	 UWPrdORX5XVnKCusnwMu6kN4lMTIkSIaESLdDlo5WmUNBmyrMLic/H8wARfzGI8HFM
	 j9KIlG+Ln+xCmfwCvO/QpIlk4Fvm7Id9gcAGmaqZANRPsXtTz74Th2zgd68Fai8x71
	 /PA2eDHMWSzSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DE3938E87;
	Wed, 15 Jul 2026 09:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] docs: bpf: document BPF_RB_OVERWRITE_POS in
 bpf_ringbuf_query
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178410601291.3969811.3899137225020056765.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jul 2026 09:00:12 +0000
References: <tencent_22134645443B75ED907D2A85A47AD554A709@qq.com>
In-Reply-To: <tencent_22134645443B75ED907D2A85A47AD554A709@qq.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 13 Jul 2026 10:49:01 +0800 you wrote:
> BPF_RB_OVERWRITE_POS is supported by bpf_ringbuf_query() but was missing
> from the helper documentation. Add it to the flags list in both the
> kernel UAPI header and its tools/ mirror.
> 
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> ---
>  include/uapi/linux/bpf.h       | 1 +
>  tools/include/uapi/linux/bpf.h | 1 +
>  2 files changed, 2 insertions(+)

Here is the summary with links:
  - [v2] docs: bpf: document BPF_RB_OVERWRITE_POS in bpf_ringbuf_query
    https://git.kernel.org/bpf/bpf-next/c/f68df52fbad0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


