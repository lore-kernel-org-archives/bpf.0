Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63F8462
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024034; cv=none; b=QDzp5IrTK2VdBJqJdliKlAN+3+unLlvLF9KxnSHMRomdg/6QbiB/j7SInR11dt/apamhSBvrr48VC8gcbk52RiW6iNCG9Wm0WWllP3XRLocPQ3igodtVPNICztap213ykAqaOEWwhmtgfimnnRdz4H21lrzMyAB96B1rQB2RCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024034; c=relaxed/simple;
	bh=LgkW1dnraHvMJe+YEu8SASSWFZlfJofAVnqDjjl+x7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FrWyXCVPdTH9nDzXHpSFUByIDw/AUKlOpC14aWRFmkjPUneLL8romUNCIxBp1OXN+AijFtY2Wnh6Nhj3k8EZbryuWL904YSO0ogKJH3BJpW0WznzbgLMKq+xUWZtVTSRsqMvyMDqKpXLpmu6GVHY8cUXHwRE+Wtj9fyQ/dOwHK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q913QXtC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q913QXtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20635C19424;
	Sun, 12 Apr 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776024034;
	bh=LgkW1dnraHvMJe+YEu8SASSWFZlfJofAVnqDjjl+x7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q913QXtCG/4Vnld0ywUjXhuo2tIR07X+bauD5RunlCHdZ26egxs+RWe34RbtwsM1S
	 escmiRW9wYQQmXINBKl3H0zCW+tZsAme89sIP+QdmJcXfvaqRoAWhsSTFSESigEB0t
	 E1djfVNtvjLbRQOYu3DE0G2d5BmdX799KIZ9wKyyRK2HPVNoSpu4ZswjZ+TI7641uM
	 rUhvH3n9wO9tDgpLwYuYD40x5IBywZ/7IANC7BdaTfAf6u7znbnA5/eKf8k035iqlK
	 Hr2f3cu8JBeGi7VrFgtdlyevwUs1OzfHMCFgIyOnDL6/18YWxaMJg0bspw8OeswN3O
	 ULJe6OojfijxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DCC3809A8C;
	Sun, 12 Apr 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/9]  Introduce arena library and runtime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602400654.3393210.13154421019495533982.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:00:06 +0000
References: <20260412174546.18684-1-emil@etsalapatis.com>
In-Reply-To: <20260412174546.18684-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun, 12 Apr 2026 13:45:37 -0400 you wrote:
> Add a new subdirectory to tools/testing/selftests/bpf called libarena,
> along with programs useful for writing arena-based BPF code. This
> patchset adds the following:
> 
> 1) libarena, a subdirectory where arena BPF code that is generally useful
> to BPF arena programs can be easily added and tested.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/9] bpf: Allow instructions with arena source and non-arena dest registers
    (no matching commit)
  - [bpf-next,v7,2/9] selftests/bpf: Add tests for non-arena/arena operations
    https://git.kernel.org/bpf/bpf-next/c/4c5f21d4dfa4
  - [bpf-next,v7,3/9] selftests/bpf: Move bpf_arena_spin_lock.h to the top level
    (no matching commit)
  - [bpf-next,v7,4/9] selftests/bpf: Move READ_ONCE/WRITE_ONCE macros to bpf_experimental.h
    (no matching commit)
  - [bpf-next,v7,5/9] selftests/bpf: Add basic libarena scaffolding
    (no matching commit)
  - [bpf-next,v7,6/9] selftests/bpf: Add arena ASAN runtime to libarena
    (no matching commit)
  - [bpf-next,v7,7/9] selftests/bpf: Add ASAN support for libarena selftests
    (no matching commit)
  - [bpf-next,v7,8/9] selftests/bpf: Add buddy allocator for libarena
    (no matching commit)
  - [bpf-next,v7,9/9] selftests/bpf: Add selftests for libarena buddy allocator
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


