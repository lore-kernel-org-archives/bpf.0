Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE561E515
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782091225; cv=none; b=l6cQ90crvr4aE1wbPX3BQMZxWfR+5HxGQ1J0c1r147JHNTbXfosBHAx8DpodJBnN9PcHb37vO9OlFUery6lpsZo6QB1B1WtrneyqebVs20xMtH58+1sMaGl+e6RmmgpoojUkooEIpCxqSFQPk1uAK2qQ7x94Ddvylc3wpBU5Vd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782091225; c=relaxed/simple;
	bh=hkvK8fF/FhVYsLO+91RyGeSLBKZFRhHbbPmKcKO1/PA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XE/3IjPoukEjS3LbYjuNnpdtSzEH9cngbWfM2oC//CvilsQ8VLfeHyz6mdsT98sof2/FaqcRMHZtwxSqCsaHVLgyDOdhdmAZUBnldUSHWhmQMAIh+42jSkOq0PuCghuirl7nN3ZPFEfqUHZmmBML/hP1gccA6huGsJXTNaH9dyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqzmyW0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqzmyW0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CC11F000E9;
	Mon, 22 Jun 2026 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782091224;
	bh=FsZjqlX8m+KNh0tOtUaSb8Gsvi4aSeyTjD4fTxR2gwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TqzmyW0dkDvXdaN+Up7BnSAUTUN1sAe534l6WtpHYqIXis53D9dqW6iZhIt8+J4QR
	 O2V6M1iCuz96yOngutv2Y8Lg6nAFUai+0XwKuXk7Qf44ekJSOcM/wA0OM993jmeuws
	 IqdBN6MLsEj+f5e55cpqa1AnCsvhAL3bk7JKzKy7vGLAsv435l6CXRqDPrFqv/EY+o
	 SFqKUUIqQjgkM1baDMSdfyBA3jk78TVWQbWewgQOzdPZDwbnNgbhmrUutTLCPit44/
	 2CXON80TNITPh87Z5WYynjxVx9AT7SMqw0qMLDRWJZtpiAywJAwgWYf/F8YbLau7KD
	 hls8ODnanQRqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ADA3AAA6EF;
	Mon, 22 Jun 2026 01:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/2] Fix effective prog array indexing with
 BPF_F_PREORDER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178209121548.561199.15322460203791260492.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 01:20:15 +0000
References: <20260619063520.2690547-1-ameryhung@gmail.com>
In-Reply-To: <20260619063520.2690547-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 18 Jun 2026 23:35:18 -0700 you wrote:
> Hi,
> 
> This patchset fixes a cgroup effective-array indexing bug where
> replace_effective_prog() and purge_effective_progs() used a linear hlist
> position that doesn't match the array layout when BPF_F_PREORDER
> programs are present, corrupting the array on link update and risking a
> use-after-free in the detach fallback. It computes the slot via a shared
> effective_prog_pos() helper and adds a cgroup_preorder selftest.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Fix effective prog array index with BPF_F_PREORDER
    https://git.kernel.org/bpf/bpf/c/f08aaee3152d
  - [bpf,v2,2/2] selftests/bpf: Test cgroup link replace with BPF_F_PREORDER
    https://git.kernel.org/bpf/bpf/c/a6ff26f360c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


