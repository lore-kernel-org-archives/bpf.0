Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578822;
	b=hxNPl57Tp9GlldurRRuLUzqybleGgT/+V/z62Kz+msa/UMYOsVB/bA/I7xl/tW0pNZYS
	 offU7TMHWkCM8K6pyEmDwOWiiTiizLMANeEQnd2CHIG2f4RnV07UXDx1ZxcvA5uoH6GMv
	 OFZGn/JGQedbKq2Z/OEoioFjn66rZugsv6+ehTkBloX+DPbjZnLRBXRgcul/MYpIel3nE
	 JqScb20P3KafKA/Fw/HdYbwLWhWxh/wLc75TIY5CWtnzEM+dc6M4BJkiy/YzGc2g7QGPK
	 TLJ84ojDs6GftaUfj/xEBu38fgfPtvp8iUPDSzUyRhD2EMaSChi8Ol6ZT1kYE7060Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578822;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jwUeZDWBCFAKgh9iPvXir7dyVOHi1Jj6ovu4halCxaE=;
	b=Qf1jT5I3EH+fEv57+cUkLM/x+Ai1nfiJ/a2lFl2gbThme7DZ4prsXx4+RAUdyycDmzZk
	 qCtSQ0bsXhtwKbdq6bDpPO6dO6qhNPYeKjvIjny1wkLQ/wE/dXWk/H+9/tjy+EozgZTyE
	 /3JgabvdRgZaEZ9KaLbhSeTNWuZDnYA11WS0v/g0V/etsH+9vK3JTgYFtAm5yvwEVA00J
	 0P6v9+j570M6+LK+QOD9AhknAJ+iNZsf3rUM6kcenF9+k3tgAQlwFYO6HjNYhCX/qC1Uk
	 v6O/esYlXc7Fp9SH9ZoDHODvs9cX+gyo5EPP4vQijGJluhjXioUp2tcewX5G2IMm05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppn2LAFs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9CA606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ppn2LAFs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA65A1F000C1;
	Mon,  2 Nov 2026 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578821;
	bh=jwUeZDWBCFAKgh9iPvXir7dyVOHi1Jj6ovu4halCxaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ppn2LAFs3JEbFzendhlMDahFjPEwYDcU9RvVcerwo7rqf/q1FwHTNZ0tBHPDswHcF
	 2LBrnESUOxxTdH4eDucHGRNxkSmu5rdCirJfZC67eOHAsuRiIfbqRjSIyYydb+EPVW
	 39BELgkECmDNm/s7oJecjL5lyhcsBGO5SsJsk+7igm/JlcboREeGhbXYquhAVcI87n
	 H0k5QOpfnLLl3iNcsQpdt1sDY/UX9fpvb1gCirtTrAS+44HjXB50BTZ8NBrzf5OsZl
	 vonBFOSePFMvKS7WX/KH0ufV7ZPE/GfCDz1VKzKsC1x9DIjDpcSGXdMJXvvWQPDgKy
	 O9NdBDS+Djckg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA3E6391AFE5;
	Mon,  2 Nov 2026 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 00/27] bpf: Fixes for the verifier, arena,
 skb and lwt helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179357882029.3683510.4838737790692968847.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 00:20:20 +0000
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, josef@toxicpanda.com, mason@kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  1 Nov 2026 19:05:08 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These patches fix bugs in BPF:
> 
>   patches  area
>   -------  ----------------------------------------------------------------
>   01-02    stack traces: the limit of the trace length
>   03-07    arena: the range of mmap() and of bpf_arena_free_pages()
>   08-12    arguments of kfuncs and of extension progs
>   13       cgroup detach: the permission check
>   14       cgroup skb progs: the network offset
>   15       bpf_skb_adjust_room(): the limit of gso_size
>   16-24    lwt and seg6local End.BPF progs: pushed headers, skb->cb, dst
>   25-27    skb offsets when a helper adds or removes room
> 
> [...]

Here is the summary with links:
  - [bpf,01/27] bpf: Clamp the trace length in __bpf_get_stack() again
    https://git.kernel.org/bpf/bpf/c/007fd460798b
  - [bpf,02/27] bpf: Clamp the trace length before the skip test in stackid_init()
    https://git.kernel.org/bpf/bpf/c/a08ba2ab79df
  - [bpf,03/27] bpf: Refuse to map an arena at address 0
    https://git.kernel.org/bpf/bpf/c/ca580b034380
  - [bpf,04/27] bpf: Don't let bpf_arena_free_pages() see a half-set user range
    https://git.kernel.org/bpf/bpf/c/52498f14c2d2
  - [bpf,05/27] bpf: Refuse an arena mmap() longer than max_entries pages
    https://git.kernel.org/bpf/bpf/c/1e01345b87f1
  - [bpf,06/27] bpf: Remove the WARN from arena_get_unmapped_area()
    https://git.kernel.org/bpf/bpf/c/15dedd4b2592
  - [bpf,07/27] selftests/bpf: Test the length and the address of an arena mmap()
    https://git.kernel.org/bpf/bpf/c/14d3e5bf9ffe
  - [bpf,08/27] bpf: Reject memory for kfunc projection type args
    https://git.kernel.org/bpf/bpf/c/f89ebf07496b
  - [bpf,09/27] bpf: Don't turn struct arguments of KF_ACQUIRE kfuncs into memory
    https://git.kernel.org/bpf/bpf/c/07684726d39e
  - [bpf,10/27] bpf: Don't turn kfunc arguments of an empty struct type into memory
    https://git.kernel.org/bpf/bpf/c/ed02b9cc1d37
  - [bpf,11/27] bpf: Compare the arguments of an extension with those of its target
    https://git.kernel.org/bpf/bpf/c/faea3cda41d3
  - [bpf,12/27] selftests/bpf: Test the arguments of an extension prog
    https://git.kernel.org/bpf/bpf/c/9abda4d8fc0e
  - [bpf,13/27] bpf: Require prog fd or capability for cgroup detach
    https://git.kernel.org/bpf/bpf/c/2962329f7c86
  - [bpf,14/27] bpf, cgroup: Keep the skb network offset signed
    https://git.kernel.org/bpf/bpf/c/3f9780d62dd1
  - [bpf,15/27] bpf: Don't let bpf_skb_adjust_room() raise gso_size to GSO_BY_FRAGS
    https://git.kernel.org/bpf/bpf/c/6d8118937ba4
  - [bpf,16/27] bpf: Reject non-IPv6 packets in BPF_LWT_ENCAP_SEG6
    https://git.kernel.org/bpf/bpf/c/58e39f8d58b1
  - [bpf,17/27] bpf: Set a dst for test runs of lwt_in progs
    https://git.kernel.org/bpf/bpf/c/c1ca06e48e88
  - [bpf,18/27] bpf: Limit the SRH length in bpf_lwt_seg6_adjust_srh()
    https://git.kernel.org/bpf/bpf/c/ac159f39b252
  - [bpf,19/27] bpf: Don't look for the SRH again in the End.BPF helpers
    https://git.kernel.org/bpf/bpf/c/45bcc58d5767
  - [bpf,20/27] bpf: Move the MAC header in bpf_lwt_seg6_adjust_srh()
    https://git.kernel.org/bpf/bpf/c/0fcb3f11a93d
  - [bpf,21/27] bpf: Don't leave a stale MAC header in bpf_lwt_push_ip_encap()
    https://git.kernel.org/bpf/bpf/c/701ffd202b9e
  - [bpf,22/27] bpf: Reset skb->cb after an lwt prog pushes an IP header
    https://git.kernel.org/bpf/bpf/c/b3ad42f61832
  - [bpf,23/27] bpf: Require BPF_LWT_REROUTE when an lwt_in prog changes the protocol
    https://git.kernel.org/bpf/bpf/c/d9618a619695
  - [bpf,24/27] bpf: Don't let lwt_in progs call into IPv6 when it is disabled
    https://git.kernel.org/bpf/bpf/c/95f1d5e4abb7
  - [bpf,25/27] bpf: Move the transport header with the moved headers
    https://git.kernel.org/bpf/bpf/c/a9d08fe60fa7
  - [bpf,26/27] bpf: Use the inner transport header after a decap
    https://git.kernel.org/bpf/bpf/c/33be492c2e23
  - [bpf,27/27] bpf: Check the offset in bpf_skb_generic_{push,pop}()
    https://git.kernel.org/bpf/bpf/c/ee36c9aa44ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


