Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5863ACF15;
	Thu, 16 Apr 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350438; cv=none; b=hTVX/kDMgqP69BWD0nbBCh/1RKvoZC0JdoVlWsFB10f9PwAVqZh8Jx9P4fifN/G8uwZV1qBI8lT4v8uoUdK2zqb5EdBRBls7Ua/wftmixL47zR9iC7/yeqEcmAoqFZ+7ku1ivg7Jg6vBzmWoiJ6H9hWVDWojpfnk+SFuGNj+KwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350438; c=relaxed/simple;
	bh=tT1416H5Bea/qRzPxcGIGfsbKTxzK3vYci/z3A9nqzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q/IT8GWkECd4DwrAlb2YqigaC2EOxujEJzfHu/AthaCeYB6Mlm1BpY60+NGxKjI6K1FqshOouitjYirspZRxz7CQhTuSQ9grj0kUrSn+g5ms75XXyEBeRyBdQRLPVskVDNVkX1/uiKP3QCih+aY04HrIb5+TGW95yLT1iMH39d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXZD6tpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXZD6tpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321A6C2BCAF;
	Thu, 16 Apr 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776350438;
	bh=tT1416H5Bea/qRzPxcGIGfsbKTxzK3vYci/z3A9nqzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QXZD6tpEX/td6SQMbqQJaGTBvq3Oi/r1LK5e/N8jauFyHxzlyrz/e8iWwSCAPVfaC
	 Gaf6cQ0GwT9PZsjwiE9fRxC+sq/qk4qS1hKj7iBp244AvMT5jvXoI2TuKyZdw78x6W
	 SBoa6iQnBu7HvKTJ859hpVpiZXq6vKjPxHLVAnM9DSTkfWm0Ml4FUzat8sutgbOJNH
	 w2jWcZvUSAho76W9XSmCdUHgumM0NfuClzx39YxvXhrJOXnUYjnQehiDOK37joZlSy
	 ujiaLU5C/M/ZSk+ZcwFTzvAcalpWAEthyXjNUbLydmvJYniJ+N+mpDubtl4FBNtamg
	 Heq8hbqTskztA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B63380AA61;
	Thu, 16 Apr 2026 14:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Fix precedence bug in convert_bpf_ld_abs
 alignment
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177635040680.3258205.15154840823715414256.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 14:40:06 +0000
References: <20260416122719.661033-1-daniel@iogearbox.net>
In-Reply-To: <20260416122719.661033-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 16 Apr 2026 14:27:19 +0200 you wrote:
> Fix an operator precedence issue in convert_bpf_ld_abs() where the
> expression offset + ip_align % size evaluates as offset + (ip_align % size)
> due to % having higher precedence than +. That latter evaluation does
> not make any sense. The intended check is (offset + ip_align) % size == 0
> to verify that the packet load offset is properly aligned for direct
> access.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Fix precedence bug in convert_bpf_ld_abs alignment check
    https://git.kernel.org/bpf/bpf/c/e5f635edd393

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


