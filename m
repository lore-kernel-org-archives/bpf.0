Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73039391E51;
	Sat, 17 Oct 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275015; cv=none; b=PiZlNjqJGNqfaHOMEydhfztMS9Gh3slXEgmo5H3po07mRiZdYWJKruSuMpKujyf+i+XG+Lr5sCa7ACJCy6Co0TGXSSwb4mqSrLbiG5gqVqsBALpiGlCNyOX73ESdpv5/oTheFM9KDk2ZaJM3bZP8lIWZV8P8qPOX2V1D9dXLLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275015; c=relaxed/simple;
	bh=xpB3kDYVCa7fXeY38ar/gHIQVVMsXi+K4a9iJZ2SCxw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GvzKMdwsJT7Qv5wOUaH5wh4IrtWgAAJe7efNkf7FbkWYn896POSp9rW/tssAKkmsEzz7lNHPe4I2y7pyTx0J2NxuFXANcxtI49zJ5tC/gcS43zcqTjccTkFPsXyP/gb+CANLSPvHtUsBggjFQNwmuUSDc7RZnpti3YTAmlKld9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpXrCkKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpXrCkKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC48C1F000C4;
	Sat, 17 Oct 2026 22:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792275013;
	bh=lw/O6RiIvCUumLCunwQyeN8o/cRod6JeOPBSceYadjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gpXrCkKFxXp5Jb4BGJXRtRgZKSy+FH/AWRPQU6qm98dSB2zddlmcp6Dsd+ZI+xlfS
	 S5Zg4Yvs+8mU+TcOINRDP2e00pUTE3rKzRPCDSgSd9O7Cl878sClRTKprXaKiGDB60
	 Mdcav0ubUCkThsAa7/oQIKfszgjkVzSRT6SSpRCRkOmou+MHAcF6rX9bK2PBuuSclm
	 rpPK0k0EvgtjK5G16pXlvL/x6qf9T6Wu7sMalGYXo28Peaw7ynek+a6EoJ9G9fEMsd
	 ue3ZW67y1M6AkPzje9f6yH6sIDF5R5qQQGQiBBRG/RsL0CDd6ZDapF2VnZHYq9BC3T
	 qJEWYJ8kDZeUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44E038111CE;
	Sat, 17 Oct 2026 22:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 00/43] bpf: Memory safety,
 lifetime and locking fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179227501253.1459884.6652613492860330047.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 22:10:12 +0000
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, netdev@vger.kernel.org,
 josef@toxicpanda.com, mason@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 17 Oct 2026 16:37:02 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> This series collects fixes for bugs in the BPF core, the verifier and the
> BPF side of the networking stack. Most of them are from Josef.
> 
> Every bug was reproduced in a VM on top of bpf-next, on the kernel right
> before and right after the patch that fixes it. The splats are in the
> commit logs. That goes for what the reviews of v1 have found as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,01/43] bpf: use the frame mem type in devmap egress XDP
    https://git.kernel.org/bpf/bpf-next/c/b3ca872947ef
  - [bpf-next,v2,02/43] bpf: forbid sleeping in hash map for_each callbacks
    https://git.kernel.org/bpf/bpf-next/c/9bdd5e7f5d83
  - [bpf-next,v2,03/43] bpf: don't leak the inode when token creation fails
    https://git.kernel.org/bpf/bpf-next/c/f52b699c8863
  - [bpf-next,v2,04/43] bpf: don't hand out a linked element as extra element
    https://git.kernel.org/bpf/bpf-next/c/ccb88db8dac8
  - [bpf-next,v2,05/43] bpf: reject sleepable programs for task_vma iterator
    https://git.kernel.org/bpf/bpf-next/c/dfcd17659112
  - [bpf-next,v2,06/43] bpf: forbid sleeping in bpf_find_vma() callbacks
    https://git.kernel.org/bpf/bpf-next/c/c6dc0a288d4e
  - [bpf-next,v2,07/43] bpf: look at all 64 bits of a BPF_JSET mask on 32-bit
    https://git.kernel.org/bpf/bpf-next/c/ee4f44e0e3c8
  - [bpf-next,v2,08/43] bpf: don't let bpf_skb_adjust_room() use up the MSS
    https://git.kernel.org/bpf/bpf-next/c/12d07c38e1b0
  - [bpf-next,v2,09/43] bpf: Read the probe of a perf event under event_mutex
    https://git.kernel.org/bpf/bpf-next/c/3ccd700543f1
  - [bpf-next,v2,10/43] bpf: Don't saturate owner_refcnt on the last unpin
    https://git.kernel.org/bpf/bpf-next/c/30a140c9d479
  - [bpf-next,v2,11/43] bpf: Validate the SRH which End.DT6 uncovers in End.BPF
    https://git.kernel.org/bpf/bpf-next/c/e8b084646b94
  - [bpf-next,v2,12/43] bpf: Pull the inner header for End.DT6 in End.BPF
    https://git.kernel.org/bpf/bpf-next/c/434324c611a9
  - [bpf-next,v2,13/43] bpf: Update the SRH state if End.B6 fails late
    https://git.kernel.org/bpf/bpf-next/c/427e751a231a
  - [bpf-next,v2,14/43] bpf: Clear sk_refcnt of a clone before its storage is linked
    https://git.kernel.org/bpf/bpf-next/c/22f100bd0134
  - [bpf-next,v2,15/43] bpf: Fix NULL deref in the sk_storage map iterator
    https://git.kernel.org/bpf/bpf-next/c/6186c9711ac6
  - [bpf-next,v2,16/43] bpf: Link the first element after its storage is published
    https://git.kernel.org/bpf/bpf-next/c/bd897919e4dc
  - [bpf-next,v2,17/43] bpf: Hold the socket in the sk_storage map iterator
    https://git.kernel.org/bpf/bpf-next/c/070a96b2a98f
  - [bpf-next,v2,18/43] bpf: Bound the nesting that the BTF show code follows
    https://git.kernel.org/bpf/bpf-next/c/13ac7c05bc45
  - [bpf-next,v2,19/43] bpf: Check the new program of an iterator link update
    https://git.kernel.org/bpf/bpf-next/c/45e912fb1db0
  - [bpf-next,v2,20/43] bpf: Fix stale offload->prog pointer after realloc
    https://git.kernel.org/bpf/bpf-next/c/8e83d5359644
  - [bpf-next,v2,21/43] bpf: Don't bind a program to a netdev that goes away
    https://git.kernel.org/bpf/bpf-next/c/af929bc938e0
  - [bpf-next,v2,22/43] bpf: Keep a program until its bpf_wq callback has ended
    https://git.kernel.org/bpf/bpf-next/c/1e28a5e52d32
  - [bpf-next,v2,23/43] bpf: Count sleepable callbacks as sleepable map users
    https://git.kernel.org/bpf/bpf-next/c/927c9c985f3e
  - [bpf-next,v2,24/43] bpf: Check the maps that sleepable callbacks use
    https://git.kernel.org/bpf/bpf-next/c/3e6d7522af2c
  - [bpf-next,v2,25/43] bpf: Assume no bounds for buffers behind a tail call
    https://git.kernel.org/bpf/bpf-next/c/7fa323d77688
  - [bpf-next,v2,26/43] bpf: Don't take an extension for an iterator program
    https://git.kernel.org/bpf/bpf-next/c/7cc639dc45c5
  - [bpf-next,v2,27/43] bpf: Assume no bounds for a writable tp with tail calls
    https://git.kernel.org/bpf/bpf-next/c/cd0490e671d7
  - [bpf-next,v2,28/43] bpf: Don't take an extension for a writable raw tracepoint program
    https://git.kernel.org/bpf/bpf-next/c/7fe348f18b37
  - [bpf-next,v2,29/43] bpf: Keep iterator programs off special map fields
    https://git.kernel.org/bpf/bpf-next/c/8d0358f6e8b3
  - [bpf-next,v2,30/43] bpf: Free what map_free() unlinks for sleepable readers
    https://git.kernel.org/bpf/bpf-next/c/5bdd61e98da5
  - [bpf-next,v2,31/43] bpf: Keep values of a dead owner for sleepable programs
    (no matching commit)
  - [bpf-next,v2,32/43] bpf: Don't take an extension for a function that runs sleepable
    (no matching commit)
  - [bpf-next,v2,33/43] bpf: Keep the symbols of a program until it has ended
    (no matching commit)
  - [bpf-next,v2,34/43] bpf: Use the socket of a sk_lookup test run under RCU
    (no matching commit)
  - [bpf-next,v2,35/43] bpf, cpumap: Hold the device of frames in the queue
    (no matching commit)
  - [bpf-next,v2,36/43] bpf: Drop packet pointers behind kfuncs writing an skb
    (no matching commit)
  - [bpf-next,v2,37/43] bpf: Let bpf_dynptr_write() mark a global function
    (no matching commit)
  - [bpf-next,v2,38/43] bpf: Don't take a dynptr argument for a local dynptr
    (no matching commit)
  - [bpf-next,v2,39/43] bpf: Refuse the prologue for an extension that cannot take it
    (no matching commit)
  - [bpf-next,v2,40/43] bpf: Unclone the skb for kfuncs that write through a dynptr
    (no matching commit)
  - [bpf-next,v2,41/43] bpf: Follow the head if an skb is written from a slice
    (no matching commit)
  - [bpf-next,v2,42/43] bpf: Use memmove() to store bytes in an skb
    (no matching commit)
  - [bpf-next,v2,43/43] bpf: Refuse packet slices for packet-changing helpers
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


