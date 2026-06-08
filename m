Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0B30E847
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884012; cv=none; b=ZfQhJKOM/a78101m20OVxlPPfsoC7XDn24us9wpfB+2E9KSG//nTyG2e8HzgFrl9eJTGwdoz+ku4f1BapQZcu0CcIPwC9jhV08La10CnZM6F09QzUXIbwmbjj6mheCkl6tsiRKGfHL7Bt3bzuo98ztBEshxp2tUPVF4FeDAaEfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884012; c=relaxed/simple;
	bh=zK+m+w8hc1BfJS7FDGrY9u707vLJ+ac4hsnfgFmVOAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N5Tx5QxoRAzDTtNKDfCXKsCX33My5fao5onjeEb9fuJnYOMbkjyVLd7eihhJG53bb/qxdajko18GqhMBYgSrtNOZYsk9Z0YO17XanVFso/8AO/5QN6TBKmNwFW8wChqNdxS50vWRdYLmzhenbZYkLCkX67+ypkrDWZ38mxTZe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0l1YJOb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0l1YJOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8911F00898;
	Mon,  8 Jun 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780884011;
	bh=HZSfvMEG3a/NZRGferRHcIdOjln/JvktlSdOCdrjq6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=U0l1YJObnOaxJ56bW7VTwDPKRwmeNeTO/rvWDf3fVgf/O36dkIgZFHZY1uLEbWNlJ
	 XfKoESSYU5HpM5Ex0G7EdDqe+95oZ9VSGjFlVzvtL44E96WGNh8Soff9lExmtj7sJs
	 y7JDpsbHHiw4BCxjjd4klG10hdYCALvv7T60clOE/kwWsW3r5my7Eeel87hNKVeFqD
	 Bns+aJEKvSWQ+n05EYNxPnBEntWWZnp1QTLjQqkJrbOjq4ZY0XtRe9FX8F3S89hxMf
	 HAB3qA2/PlGL0lUOdVXd2kiCCBMbTNUDc14I3bK5Qvl3Fx8+jBV7psgzuZIp0iUU/z
	 V9e9hPogtiEPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5692E3930CA0;
	Mon,  8 Jun 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: Fix LRU NMI/tracepoint re-entry
 deadlock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178088400989.793559.1741705659865463574.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 02:00:09 +0000
References: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
In-Reply-To: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com,
 memxor@gmail.com, yatsenko@meta.com,
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com,
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 07 Jun 2026 13:30:40 -0700 you wrote:
> This series fixes AA-deadlocks where NMI and tracepoint BPF programs
> re-enter the per-CPU or global LRU lock already held on the same CPU
> (syzbot c69a0a2c816716f1e0d5, 18b26edb69b2e19f3b33).
> 
> Patch 1 converts every LRU lock site to rqspinlock_t
> and adds explicit recovery for some failures so no node leaks.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
    https://git.kernel.org/bpf/bpf-next/c/89edbdfc5d03
  - [bpf-next,v3,2/3] Documentation/bpf: Refresh map_lru_hash_update.dot for rqspinlock
    https://git.kernel.org/bpf/bpf-next/c/8f6802d26d96
  - [bpf-next,v3,3/3] selftests/bpf: Stress LRU rqspinlock recovery paths
    https://git.kernel.org/bpf/bpf-next/c/6e1e4a9d60ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


