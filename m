Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C5489865
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983077; cv=none; b=K+YT/NtTOm9SwKBXhkTafq61yEtXWxiuCarEMpQhx5KuCaXnj6e/Bid9x/87gthpgfEe3PWzPpK4Ncx94wtmHv17IIuKLrRZAzhaigwek/4VvoWF4aQkubXRh/zug7kGQWqo6pi9/FUCf85Yk2zlqvNPQIIvvgGRYztUkFMfqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983077; c=relaxed/simple;
	bh=UtphRCZQmt/roI9m1X0wtaQPIFnzHfarzUZ9TmzG16o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bgh5dyodXbO/D6hFVgFXLqpeKclgt1JEKPaH9X0O4gVKu1yOzZH042tQxdUH1q1PFkf9kiBYJYD/gPVWIsMe62olI35Zdp8Un+zzQP8wcjrUcG3E+RRDOefZfM9B6ERyylxwUbcW1eT0ZQ5IpKn8Tgql2FRsA+wvdUWbkoEpRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoFVZ5h/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoFVZ5h/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194471F000FF;
	Mon, 21 Sep 2026 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789983076;
	bh=zO1EGf3A6JUTpGQhS8F9lVE/YYf427gPo18aQFkQ+48=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DoFVZ5h/cfY4C8rr9g7q1OMuJ8218LfBXu12rXxZRiwbgejZA/P5rHzMDWaAOHC84
	 s1rAAZiPVbT0d4IdfdplN2MunMdjDLZY3vmGqm9LhA+UTpc3sOPBG96z3v45pgSIpy
	 WnRa8G5vmaj/TGVBlctk7+kszQbjASM62zB8E6qDz8bct77F+sjUkQqsJAW13Vqza8
	 JnBILsRMofDdnERaxJCtPGuUNkufI9QERMtP4c2kW2pDIOvrBk7nbipCc9mTCzvfLM
	 VD6aVNHvp7Bpmp+mJ6+NAhwJ/Y2KWw3SkAyw7736mxw4O1O2QS9Itgkw6yQAc/QEv5
	 Q03v4Ue11BYCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11F48392627F;
	Mon, 21 Sep 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v8 0/9] selftests/bpf: restructure the Makefile
 as a
 layered build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178998300788.2460388.17148762750813541573.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 09:30:07 +0000
References: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
In-Reply-To: <20260921075855.2065871-1-nickolay.lysenko@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 21 Sep 2026 00:58:46 -0700 you wrote:
> The BPF selftests Makefile has grown to ~1,100 lines, with much of the
> complexity concentrated in the DEFINE_TEST_RUNNER double-expansion
> machinery: the per-runner rules are written in $$-escaped make and
> eval'd once per flavor, so the rules that actually run never appear in
> the source and are easy to break for one flavor while testing another.
> 
> The series opens with six small stand-alone changes, each usable (or
> droppable) on its own: patch 1 filters headers off the generic link
> rule's command line (gcc tolerates a stray .h there, clang refuses);
> patch 2 drops four stale target-specific lines that name objects nothing
> builds - restoring the two dependencies of value among them in working
> form (flow_dissector_load.h against the binary;
> cgroup_getset_retval_hooks.h by moving it under progs/, where the
> blanket header prerequisite of the BPF object rules covers it) - plus
> three never-referenced linked-skeleton dependency-map entries, a no-op
> CURDIR override and the OBJCOPY definition nothing reads; patch 3
> factors the eleven identical permissive-mode "remove the target, print
> SKIP, report success" recipe tails into a skip_on_fail helper; patch 4
> makes the signing key generation race-free under -j; patch 5 turns the
> verifier/tests.h $(shell)-in-recipe into a regular recipe; patch 6
> derives the bench object list from the sources with a wildcard.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v8,1/9] selftests/bpf: keep headers off the generic link command line
    https://git.kernel.org/bpf/bpf-next/c/75ab33a0a50f
  - [bpf-next,v8,2/9] selftests/bpf: drop stale lines, restore two header dependencies
    https://git.kernel.org/bpf/bpf-next/c/35ac30e71745
  - [bpf-next,v8,3/9] selftests/bpf: factor the permissive-mode skip suffix into a helper
    https://git.kernel.org/bpf/bpf-next/c/00c2b472d5dd
  - [bpf-next,v8,4/9] selftests/bpf: generate the signing key and certificate once
    https://git.kernel.org/bpf/bpf-next/c/73fb8cea7269
  - [bpf-next,v8,5/9] selftests/bpf: generate verifier/tests.h in a regular recipe
    https://git.kernel.org/bpf/bpf-next/c/7292e0ad85d5
  - [bpf-next,v8,6/9] selftests/bpf: derive the bench object list from the sources
    https://git.kernel.org/bpf/bpf-next/c/063fa645c723
  - [bpf-next,v8,7/9] selftests/bpf: extract BPF skeleton generation into a helper script
    https://git.kernel.org/bpf/bpf-next/c/da6cb3aff2cb
  - [bpf-next,v8,8/9] selftests/bpf: move shared build definitions into Makefile.buildvars
    https://git.kernel.org/bpf/bpf-next/c/ab1d791d0cc4
  - [bpf-next,v8,9/9] selftests/bpf: build each test runner instance in its own sub-make
    https://git.kernel.org/bpf/bpf-next/c/ef3744f49d98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


