Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BE47ACE3
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407071; cv=none; b=FXUWnmGEplzkdCAxRSslwyYz8HwFWGYTHoGeU/XaVGtiIZLFM0mb3w2dPcftiagWpIO1s0wX/4v15rSorZyoa8QfvK1nBqB8DNQ0JpWB5roy5rMYcrXcmHx7+9T7JpENbw4fwWRFXaCQzZHwGrGGOM1iG6yM3MHrs/EFCIQylAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407071; c=relaxed/simple;
	bh=76aSScZKNhlDUN+swUBXSZ0BLKVEN+qZFNci0CthOHE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bjpcgumHCOdey2W6y0uz4j7kNqC0BWicPs9a3r6z6s1oIaXVnGGO+qastTzmC5ADshO3QWdel2LchGbvlaHuxCwm2zeasudmY5lWznYy/rsAQLS6k5d2n0RoLj05qNWoy6RPp/6pWw5g2GmfxOfyefhaziW40EBj2bgC5wuZ3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLSdyAwz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLSdyAwz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E61F000FF;
	Mon, 14 Sep 2026 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789407069;
	bh=fpMO8GA31aFBkdg7DzXaKs7SrTeCHcT1mUWOUEMmNpc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SLSdyAwzf1kTFd8uWQ/mueXWgesfAhZADxF6dxkiuEQ45bxi7GE0G/iNtBnMpNP0v
	 6KIhFD7S32AXjhlSwSoFPODEXma9NWXuwlvrXx6uupORxs+oac6bs30F3QuNkxV8Sn
	 Clig2CsYVB0wCTdGrD9SToqO4ph4HWFFq6m3JvBK0mxGaMhhA+9Ga34VFofN7kmUZr
	 Dg6TKNWC3giLZHq/YJ9SJ7h0S9/IFXjaHv7Qp9XM9RNFGRqdu9ay2JEP1HGfKQFDea
	 Og1DkZcNco+n07fhC96EphMQhyAYDrsVt/mJFVJZ0SUWPwg+47R/7URUvJLPvvn8Iu
	 FmkZA4KAEEbig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197513924FCD;
	Mon, 14 Sep 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 1/4] libbpf: Add bpf_program__add_flags() and
 bpf_program__clear_flags()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178940700489.1142314.12603596043055418062.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 17:30:04 +0000
References: <20260912084109.432834-1-toke@redhat.com>
In-Reply-To: <20260912084109.432834-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, andrii.nakryiko@gmail.com, jiayuan.chen@linux.dev,
 bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 12 Sep 2026 10:41:00 +0200 you wrote:
> When changing BPF program flags, applications often need to just add or
> remove a single flag, without touching the existing ones. When using the
> bpf_program__set_flags() function, this requires reading the existing
> flags and doing bitwise manipulations before resetting the result, which
> is slightly awkward to do, and easy to forget.
> 
> Add two new convenience helpers, bpf_program__add_flags() and
> bpf_program__clear_flags(), which wraps bpf_program__set_flags() in the
> bitwise operations required to modify flags without clobbering the
> existing ones.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/4] libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()
    https://git.kernel.org/bpf/bpf-next/c/3041e498f961
  - [bpf-next,v3,2/4] selftests/bpf: Add assertions for bpf_program__{add,clear}_flags()
    https://git.kernel.org/bpf/bpf-next/c/13eee5736563
  - [bpf-next,v3,3/4] selftests/bpf: Adopt bpf_program__add_flags() helper
    https://git.kernel.org/bpf/bpf-next/c/5f65b7160634
  - [bpf-next,v3,4/4] bpftool: Adopt bpf_program__add_flags() helper
    https://git.kernel.org/bpf/bpf-next/c/5ef40d69b38a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


