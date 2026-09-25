Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DA3D88E0
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370684; cv=none; b=gL4h2T2Fng2LF3MGVRaOB6koBRu1a/yAKr6CggX7arj6taWGSLAYe3xMv7xBlbJ5RtLU3akqErRNkUi90OvuV6hIJPZQ7SVIWhcfqsyUNHo2UWzS/3sLecXw0Y7Z9GFI4F12nPYu8EawdNs0kH3ArkSS5tZ8LLng9JfdcSJQXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370684; c=relaxed/simple;
	bh=EwEQ32CUxgGGci/f6sTHjuS+Xltoy751UH9gjJdm6FE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pn07uAk1CZGHhfB9k2txmKJ47xdiqYIVifTLGSE2PvmbgPMIzY0ncCAGUFIQGMV+3ns4VEghInxRYqzLcGoyMDwDSuBqRlqKxWQgSmCaf0UhX/tTEBYewHsub3XTkU0DrxPN3h1QHOQrIIU58TVoPDEYijP/A6qqc8JkLgnMsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR951/7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR951/7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E936F1F000FF;
	Fri, 25 Sep 2026 21:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370682;
	bh=z/UcEdZu/qtUU5YwAdIAIffK1kCoDwA4I+L/1K8OTGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oR951/7/CZKnv9FhDQJIHOxPdoz41f9WSSlqGJEsUaOfxWE0AdjEJEPaaPxSTzVzw
	 HMLYeKyngDVX57JdAO9gGO1fbaRB0Ld6VMalUxmwLNo/dHXVQjMQI3qEpZk3HgLYOu
	 +bnWCzMoJ8rloOtLaDqkJiEN4Digp9S2BYBXiM+eM3IbWkAIbt7oy06LVAV0ikRp8O
	 XCPmoAIAjq/j6hvgMEdEVZX439lVvzXMrC9+klvHMV8HSSWYHRFKef68PlDiSPGgV2
	 gag98XEY7SuN2unw3nJHQOj5FoBnWry+MDcd9+mTg9cG8I8ve3qmc73cwBnofnnwQo
	 8AfWvW3XbVx3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D4380820D;
	Fri, 25 Sep 2026 21:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/16] Misc BPF gotox fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179037061065.3153796.7631821411496872769.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 21:10:10 +0000
References: <20260925175244.1136329-1-daniel@iogearbox.net>
In-Reply-To: <20260925175244.1136329-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: alexei.starovoitov@gmail.com, eddyz87@gmail.com, john.fastabend@gmail.com,
 memxor@gmail.com, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Sep 2026 19:52:27 +0200 you wrote:
> Address various open issues around gotox instruction, see individual
> commits for details. Also BPF selftests are added to assert that these
> are addressed.
> 
> v2 -> v3:
>   - Rebased onto bpf-next given indirect call series landed
>   - Split out the exit_idx sentinel as its own fix (Eduard)
>   - Return early from visit_gotox_insn() on a revisited gotox (Eduard)
>   - Check both ends of the target slice in check_indirect_jump() (Eduard)
>   - Rewrite edge limit and nop target tests in inline asm (Eduard)
>   - Name the patch modes BPF_PATCH_{KEEP,MOVE}_TARGET (Eduard)
>   - Drop the insn array stale reuse test (Eduard)
>   - Clear the insn array used flag with release semantics (sashiko)
>   - Add fix for the exception callback index after dead subprog removal
>   - Free the jump tables of removed subprogs and on a failed table build
>   - Shift the poke descriptors along with the insn array slots
> v1 -> v2:
>   - Remove jt_spans_subprogs and reject right away (Eduard)
>   - Rework jump table to no longer keep it in insn_aux_data (Eduard)
>   - Fix up comments in bpf_compute_scc (Eduard)
>   - Fix up commit message nit wrt signed_loader (Anton)
>   - Added 3 more fixes related to gotox along with BPF selftests
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/16] bpf: Avoid quadratic successor rescan in bpf_compute_scc
    https://git.kernel.org/bpf/bpf-next/c/3852e19cb954
  - [bpf-next,v3,02/16] bpf: Bound the number of indirect jump edges in a program
    https://git.kernel.org/bpf/bpf-next/c/57f6eca2f63b
  - [bpf-next,v3,03/16] bpf: Rebase the exception callback subprog when dead subprogs are removed
    https://git.kernel.org/bpf/bpf-next/c/8608ec8e9819
  - [bpf-next,v3,04/16] bpf: Leave out the hidden exit edge of a subprogram without an exit
    https://git.kernel.org/bpf/bpf-next/c/939bb6270ee3
  - [bpf-next,v3,05/16] bpf: Cache the jump table of a subprogram during CFG discovery
    https://git.kernel.org/bpf/bpf-next/c/fa5ebade2a54
  - [bpf-next,v3,06/16] bpf: Reject indirect jumps that leave their subprogram
    https://git.kernel.org/bpf/bpf-next/c/19581372dd81
  - [bpf-next,v3,07/16] bpf: Don't remove indirect jump targets in the nop removal pass
    https://git.kernel.org/bpf/bpf-next/c/c48a91c049fd
  - [bpf-next,v3,08/16] bpf: Clear insn array jitted pointers on map reuse
    https://git.kernel.org/bpf/bpf-next/c/9aa11c4656b7
  - [bpf-next,v3,09/16] bpf: Clear the insn array used flag with release semantics
    https://git.kernel.org/bpf/bpf-next/c/a83512036e08
  - [bpf-next,v3,10/16] bpf: Retarget indirect jump targets across prologue prepends
    https://git.kernel.org/bpf/bpf-next/c/fba62d33c125
  - [bpf-next,v3,11/16] selftests/bpf: Add tests for the indirect jump edge limit
    https://git.kernel.org/bpf/bpf-next/c/db8c58c83f5a
  - [bpf-next,v3,12/16] selftests/bpf: Add a test for a tail call in a subprogram without an exit
    https://git.kernel.org/bpf/bpf-next/c/5add2c64f474
  - [bpf-next,v3,13/16] selftests/bpf: Add tests for indirect jumps across subprograms
    https://git.kernel.org/bpf/bpf-next/c/17c7d885efe8
  - [bpf-next,v3,14/16] selftests/bpf: Add a test for gotox nop targets
    https://git.kernel.org/bpf/bpf-next/c/2cc0a520a8e7
  - [bpf-next,v3,15/16] selftests/bpf: Add tests for gotox targets across prologue prepends
    https://git.kernel.org/bpf/bpf-next/c/28e458bbb44b
  - [bpf-next,v3,16/16] selftests/bpf: Add a test for an exception callback behind a dead subprog
    https://git.kernel.org/bpf/bpf-next/c/91ed1942edef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


