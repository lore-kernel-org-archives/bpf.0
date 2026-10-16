Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D1F63D9;
	Fri, 16 Oct 2026 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110609; cv=none; b=snE7PUsXB8vHbpxE0GemlO925tUNDC7ToZ1VFY8O8lai5F26LN2AkM1Krvb6dOgz6LnYWvdmj8LtEALtGB3lX1pXuC6Li9ERMRVaqC5YnWSr62BU5eSFf9akJcYW2ojErNRBZkanMIJj1234zfSR3Z/hsbEQYWT0XaDg4dUBLPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110609; c=relaxed/simple;
	bh=Dz6TmJYux1mux0ua/EVsgGLhVbDlddlquCM0PmBge9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckQ9gZ/AMrtRMHLIrziVo5It1tz4Npgc2SumVKnBZBM/8qVUGHI+sLD0VRPdRW6Bw01m83OrjJiqmuoKI4KQpVZ7dzIcDyjrfgWi4maGAjHNMhHW4k61PZ2g0rHVFAUhLhIxiEvhfRfh9wvS0mY3Aq7n1JzarRM4nScrnj25+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AII46m96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AII46m96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804B71F000C4;
	Fri, 16 Oct 2026 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110607;
	bh=k5OvMtbid22qcJDJv0Ls53VED6eV7K0r+g2fFWg94zE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AII46m96jiBSwHH7m4eJ3KWFAWFqGy/ZELg0QYaDonJ+tUj4hBDhYN0+Q1GjOYmPy
	 4XarjMZ3seaVos4xOThqpkTiRYea3ZmFfmfFJPjZh2mm1F97rpV0QNlzpf8dZYykef
	 3NMaPlWJ5s/f9YfMRumMFemJgbPEHqxd2YbA+tMpB6pPkqOU5fU6Z1IwUTNc+ALQXu
	 W2XygfhS9TIVPGBpLFz9n8+RQCcfV64MH/56t1Mw/sx/6lK/ceok4QkHHp18J8Urp3
	 X2RhC+XpwRwF2hhCYFtUxDf6xNlDkDUcuT543cdJF8Ir/2Oz1QcPIU0IsEgTLCzJrp
	 hE9ARP7B5ZX9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774F03808209;
	Fri, 16 Oct 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v9 0/2] bpf: htab: Reduce memory use of hash maps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211060627.4173731.9793836983476129802.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 00:30:06 +0000
References: <20261008104108.993791-1-tjmercier@google.com>
In-Reply-To: <20261008104108.993791-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  8 Oct 2026 03:41:04 -0700 you wrote:
> Memory is expensive and scarce these days. This series reduces the
> memory use of BPF hash maps by eliminating the per-element overheads
> below. This saves up to 50% of per-element memory use for standard and
> PCPU hash maps. The memory use of LRU hash maps is unaffected.
> 
> Map Type & Configuration           | Old size | New size | Savings
> 
> [...]

Here is the summary with links:
  - [bpf-next,v9,1/2] bpf: htab: Split htab_elem_lru and htab_elem_pcpu off of htab_elem
    https://git.kernel.org/bpf/bpf-next/c/26c9dc906692
  - [bpf-next,v9,2/2] bpf: htab: Reduce elem_size by 8 bytes for small key sizes
    https://git.kernel.org/bpf/bpf-next/c/0d0421c96f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


