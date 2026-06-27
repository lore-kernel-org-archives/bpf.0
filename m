Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BF25B0A5;
	Sat, 27 Jun 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525642; cv=none; b=sB5A3AKHUB1bDN89EqITf1Bk/Kk5/nBhHyenaoApMWENn2VKcYf/ou4mI3IdW0wDDkkNWR4w5KTlb5z4F6PxiigkVwh5ThsgEPcc2FI6u2YVdOS2x/0kiGS0bTap/jY9VQnG6rT4B3A8yVEEFLRQK5nJBSesPcmv/byYXOdpw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525642; c=relaxed/simple;
	bh=EFjoQt5Foug5DO1fQU0jSVTrUzZcJmb2zgIrDvDBDJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uqepE5PGjWhGgcP1KS+cG8qT7hlU4VFZwAti6W6VvwB8UdXyXZFRW1adufYrapx44J5rqB0nYlikDV89y7WortVPj6BMEYJBX6dzKffDbgwIj6AmcYbAQH4OlBqF0ZmTHUrUF9H/4AA6Nx/gL0ClF+BVMqaNqXvM/92bqqK2+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxppuCnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxppuCnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CC71F000E9;
	Sat, 27 Jun 2026 02:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525640;
	bh=88bgxuwezmvW1f5k01honCxuGEX4KlXiyI8bc/EBdw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FxppuCnDzKfLdAShoKxwVfgAarciUROYgZhZpMTule5FdxAQPSI7GcwYCJtFPd7Yy
	 JIHSeUN/EPsOJoulTbOjPLEBDIYgnvAq6FMKIZY/2CpHVLCjGS95Fzr4eeuZCuCoKk
	 I4ZX7Fi7U4eMlBG8CPDSKJG7FIJMIygv+PUgNhIgT9eIT/8IOKPGzR5xXCUPxsZhxs
	 mpEkh/fxP0uW3vLAvT1+JEMkoMF2+IkSUXs3JqgnSzlsg0YgV2664tgO5VTypWyWql
	 HUJ5Bq8L/jV2fguPlB4IB5ToLwTPCn8S9FioQLlogLBV5xXCI8thIaErSzS4F6Noxw
	 htpVL796wZkJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B3C3938C76;
	Sat, 27 Jun 2026 02:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] seg6: validate SRH length before reading fixed
 fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252562681.1167656.14195813566936530803.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 02:00:26 +0000
References: 
 <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260623-f01-17-seg6-srh-len-v2-1-2edc40e9e3e1@mails.tsinghua.edu.cn>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrea.mayer@uniroma2.it,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 m.xhonneux@gmail.com, daniel@iogearbox.net, dlebrun@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 18:32:31 +0800 you wrote:
> seg6_validate_srh() reads fixed SRH fields such as srh->type and
> srh->hdrlen before checking that the supplied length covers the fixed
> struct ipv6_sr_hdr fields.
> 
> The BPF SEG6 encap path reaches this with a BPF program-supplied pointer
> and length: bpf_lwt_push_encap() and the SEG6 local BPF END_B6 and
> END_B6_ENCAP actions call bpf_push_seg6_encap(), which forwards the
> length to seg6_validate_srh() with no minimum-size guard.  A 2-byte SEG6
> encap header can therefore make the validator read srh->type at offset 2
> beyond the caller-supplied buffer.
> 
> [...]

Here is the summary with links:
  - [net,v2] seg6: validate SRH length before reading fixed fields
    https://git.kernel.org/netdev/net/c/a75d99f46bf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


