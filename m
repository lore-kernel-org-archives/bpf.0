Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937F1D432D
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052913; cv=none; b=QumXxPc8ZhrgGw4ZcVO4NeTA7A81CvaTxIKxhFDUD3Bs6tnpJ+FnP33NiQvpT10i7ubgsDeLA867fUIsDTWKm1t059MxH9IWGjlpX0gPmXD/trOtCF41TDbhQ1szGzwM3x+WGqWZkTg/0R70bLCjio15YwmQpjEKX8qZ7fPssy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052913; c=relaxed/simple;
	bh=EJfXpfUNAgvt5D+1A9GKaiAWd7ZE1uoz2nnjBjBHids=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MyTsj3haoS0KzEAWIexJirjTqoTZbIj2vK1xNwaxDOMbkoZGpQurBXfAOlXziNnh5KxGwAbXU3BgVyd0GVidZjf2/855jK6pPms869wrev6jgYmDhSk2LnODl5XX2o5+xG1A/7hQLfkrJXjynINRYK4rrkJ3eymW3fZJ/Q0agZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzPjj7sn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzPjj7sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9155F1F000E9;
	Sun, 30 Aug 2026 01:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788052911;
	bh=NojvvGjIj4VF/k9VE3knlb2fuQqCaT3mVBK8OBaLl+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HzPjj7snyca8gd2t7DarLpreA7Sm4Oc5WzkCq6JPWbZzBjJrTqbiQlFgfH+sbuFGH
	 VftU5y7PBeRTpVm+kV/C5TP5mBAJdGv0D0+IFZEGLOQw5bsHy/Kv/Aibrg4ro4/xjG
	 0jQhGUObyPI5i3VoAsX1mLjMadatSTIVPwX27qMRSkC9tTDMeeeRPs31VWRzbFd6H9
	 L/ywaAoF0alCtxjxlJlxWZNrOfSHMMrF046dNP4qEkZLMzqvxjwnyw+KPvL7sieKIK
	 uOJPLF/AL/jzWH/Qfyeg29B0hsAuTMWAI7HKfgs9Tblq33GZN3jC1JFJ/KuUJJJM40
	 0RFm2koRbwVug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0938380CEE0;
	Sun, 30 Aug 2026 01:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/12] bpf: Allow arena pointers in by-value
 returns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178805285538.3192144.6922784787709890591.git-patchwork-notify@kernel.org>
Date: Sun, 30 Aug 2026 01:20:55 +0000
References: <20260829061514.1690730-1-yonghong.song@linux.dev>
In-Reply-To: <20260829061514.1690730-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 28 Aug 2026 23:15:14 -0700 you wrote:
> A function returning a struct by value may only return one whose members
> are all scalars. That is stricter than it needs to be: an arena pointer
> is safe to hand over as raw register bits, and both a global function
> and a kfunc can already return one on its own.
> 
> This patch set allows returning arena pointer(s) (as member(s) of a
> struct) for global functions and kfuncs. Any other pointer member stays
> rejected, as it would be laundered into a scalar and escape provenance
> and reference tracking.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/12] bpf: Record each half of a paired return value in verifier diagnostics
    https://git.kernel.org/bpf/bpf-next/c/f62a9b82700c
  - [bpf-next,v4,02/12] bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
    https://git.kernel.org/bpf/bpf-next/c/77983371742e
  - [bpf-next,v4,03/12] bpf: Add btf_type_is_arena_ptr()
    https://git.kernel.org/bpf/bpf-next/c/3fc3e7331af6
  - [bpf-next,v4,04/12] bpf: Let the by-value struct walk take the kinds of member it accepts
    https://git.kernel.org/bpf/bpf-next/c/8d7ea1b752e5
  - [bpf-next,v4,05/12] bpf: Let a by-value struct nest arrays and structs freely
    https://git.kernel.org/bpf/bpf-next/c/9e0195cd1d31
  - [bpf-next,v4,06/12] bpf: Report which member makes a kfunc return type unsupported
    https://git.kernel.org/bpf/bpf-next/c/282d07dc6c74
  - [bpf-next,v4,07/12] bpf: Allow a global function to return arena pointers by value
    https://git.kernel.org/bpf/bpf-next/c/ff08e6b79ee1
  - [bpf-next,v4,08/12] bpf: Allow arena pointers in a by-value kfunc return
    https://git.kernel.org/bpf/bpf-next/c/9046109974dd
  - [bpf-next,v4,09/12] selftests/bpf: Check the member named for an unsupported kfunc return type
    https://git.kernel.org/bpf/bpf-next/c/cc03706d92c9
  - [bpf-next,v4,10/12] selftests/bpf: Test global functions returning arena pointers by value
    https://git.kernel.org/bpf/bpf-next/c/18bc61838842
  - [bpf-next,v4,11/12] selftests/bpf: Test kfuncs returning arena pointers by value
    https://git.kernel.org/bpf/bpf-next/c/f7213961e8e2
  - [bpf-next,v4,12/12] docs/bpf: Document arena pointers in a by-value return
    https://git.kernel.org/bpf/bpf-next/c/25b0d73a7742

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


