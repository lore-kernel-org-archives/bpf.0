Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601610;
	b=tSC7Pxp2AWbv2jeSCT7D5fVljuKiyPgnS8ArMUCG9J2eeA22/fR78Vlir9DPMakCsJSv
	 e/zjROh291XKHHLmxVanb55exsIbbKLef/0EqQGS0hTyFZx9yPJRNWG4s8Yjmn+/4ELwt
	 jqRlDnTAYwlNfalndeCM0tFYC3uSZTIYhKX/1PQ4bYCfrNuGg6thJQNDrVLXTIKVBVznG
	 n925zKsEWyaFQN1rUjcsTCdAZ5cQIGHLInlKCWaISymjoi9/Li2egeHhkAQOi0rK99XYu
	 KAZ1e+sZauGuZd9UadWRE5uqK5FER8/yGHHKu4xAlP1/lp57toj/K7GempFHMN9HkHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Van8p6u8tpMwJKiMVtgfvfZ/G0CaEaYCyf/IF1dl4HQ=;
	b=g5KzSjyuj7fGI7DY89faVs7YegKltHDurGr6l8k/65icL5EBEU0P53MUJk0n+uA7l4yJ
	 uvENFtUrB1JQ64lss/cb4vHxeGUoDhSVrqmErTKnqX/7CP/GBBJgr/X4UZsjS8i20gOxx
	 lWpbTASW3AZCsPnR9TZaZrXuyNmdkElZk6NseuKUjtt2zv53/Wdn2ltRbmq96YmhV5nwF
	 wOevDys0gIeFOgvbTtzI3DN97i0vzbexWMdj7UeTsTTDy9k4RXjyFKZPlu2mKIPtmnnVX
	 71bf5VbfiMIP62PvKdAdo831hxhMoHYINeEcT22v9j0o47THiULY/QzZxcvO8keuNNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOiU8BOU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05F2606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOiU8BOU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A161F00A02;
	Mon,  2 Nov 2026 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793601609;
	bh=Van8p6u8tpMwJKiMVtgfvfZ/G0CaEaYCyf/IF1dl4HQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lOiU8BOUePhQqGMFVsDax8byI1Lx8GqiWbwqFAV3RIbaje/55jCsfMt4tEfpokfu4
	 0PEODq8GHh5MLawu2NafSKGutf9chsQW8PoPTTRfdmvMO++qSDYlNbb7MiYIMXVodG
	 bs2XBBKp72zJae5krcUQyCu6W5DhbBQtqz1msiKEzkczzvF4u1DhAx5cAigBU50UGm
	 RDyYf5JJ5MRWbMWTP6ersVXxzfJG5N57XjJJnM9EWTDpjukJNBCgYpkslCTrNJl8sc
	 Q7N9MjQRtd/XDGlqD1JrJKw0yrU5D1ey87Op+0/aIJiUKNUVNz9Q0kWLOyDmhG3Nyl
	 /IzS6j7zO7xEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D278391AFF3;
	Mon,  2 Nov 2026 06:40:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 00/13] bpf: Replace bpf_patch_insn_data() with
 a
 list of deferred patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179360160830.3805650.16153961326949358926.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 06:40:08 +0000
References: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, odys.yuan@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 01:29:27 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> After verification the verifier rewrites the prog in several passes. A pass
> calls bpf_patch_insn_data() for each insn that it replaces, and
> verifier_remove_insns() for each range that it removes. Each call moves all
> insns behind that place and walks all insns to adjust the jumps. It also
> walks each table that names insns: aux data, subprogs, line info and more.
> Thus a pass that changes M of the N insns of a prog does O(N * M) work.
> With bpf_jit_harden=2 pyperf600 from the selftests loads in 3.509 s, and in
> 0.223 s with this series.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/13] bpf: Add a list of deferred instruction patches
    https://git.kernel.org/bpf/bpf-next/c/be6f3ee5164b
  - [bpf-next,v3,02/13] bpf: Remap the verifier state through the patch list
    https://git.kernel.org/bpf/bpf-next/c/715942f477ac
  - [bpf-next,v3,03/13] bpf: Queue the rewrites of bpf_do_misc_fixups()
    https://git.kernel.org/bpf/bpf-next/c/a7a767c66a2e
  - [bpf-next,v3,04/13] bpf: Let the patch list remove instructions
    https://git.kernel.org/bpf/bpf-next/c/7308888ec195
  - [bpf-next,v3,05/13] bpf: Move the bpf_opt_*() passes to the patch list
    https://git.kernel.org/bpf/bpf-next/c/a6e3b3378fe3
  - [bpf-next,v3,06/13] bpf: Allow patching an instruction twice through the patch list
    https://git.kernel.org/bpf/bpf-next/c/004711c7bbb4
  - [bpf-next,v3,07/13] bpf: Teach the patch list to insert in front of an instruction
    https://git.kernel.org/bpf/bpf-next/c/dd235939c6f4
  - [bpf-next,v3,08/13] bpf: Move bpf_convert_ctx_accesses() to the patch list
    https://git.kernel.org/bpf/bpf-next/c/99d24b3938fa
  - [bpf-next,v3,09/13] bpf: Move the remaining verifier rewrites to the patch list
    https://git.kernel.org/bpf/bpf-next/c/0a630ce57cad
  - [bpf-next,v3,10/13] bpf: Blind constants through the patch list
    https://git.kernel.org/bpf/bpf-next/c/d50ffab62001
  - [bpf-next,v3,11/13] bpf: Remove the old instruction patching code
    https://git.kernel.org/bpf/bpf-next/c/056587f974f1
  - [bpf-next,v3,12/13] selftests/bpf: Test jumps around patched instructions
    https://git.kernel.org/bpf/bpf-next/c/67d4d0b73c29
  - [bpf-next,v3,13/13] selftests/bpf: Test the tables that follow patched and removed instructions
    https://git.kernel.org/bpf/bpf-next/c/d86e6695cb2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


