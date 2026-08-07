Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179F3C73D9;
	Fri,  7 Aug 2026 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786143061; cv=none; b=SJrz3nfzFa7ynIhaVABhe6lclthtGQxGs4b1nV/BV4nxW0s1t2RF3HEXbqCch3IRGsGPoad8TNQyPbj2+DU3MhBsokHhXZ/tgXwqWqsuhuqEbFxI98yEp0DOl37FV4vNfGF8L0W6g2q/8Yb6iQVij6kp/+cQKo2d17ccBcg1IQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786143061; c=relaxed/simple;
	bh=NO+x1kmRstq3z3PaDmgRojj7LkQlpDrVqfAZKoJRZRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KNGZksxhkgD+xT9RNaGFghfUYRATUrJAWRBIObRZWUmYDXq6x+KAyIlRfCdOJsVRk+BjdEiq8t4GaB1ykwzmUc3dKfhy5eHXcrCgGw1csyCqw1OFCNKE122zCEiH4CCyet23yHEPMG0CR7jYBwC8gapTQZ+dg/O1leLBAsX0K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxD8PtCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxD8PtCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9E31F00A3A;
	Fri,  7 Aug 2026 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786143059;
	bh=W5GucXL/+JdfjzIvb/Kt8dmC3OH5SHapv8dXOeK7DPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FxD8PtCUkBLTzqvnli9bH1JttoLQE+3Q7bsA72HIISAbRxgz5/21W6fwsemlzf0U6
	 o3qw3E7MKL4AE9GgtkVeaiE6CtxsklCj+h7EMto8LTJ9twHZZfFAy50R32jrIOU9Pk
	 CgNpQmXqQqQfgKTHkuwCsZaf/5VqkTt8jwgh6jnct118jH/vVU1Hdt3nIlDZ3TCdOC
	 VU1joa7y6uqGfdcfR1D/KAhvBwvOkEBqpLnLaTsTHoLAFmkxzCLtEuf6pVPt54OY4q
	 xXs6N/421164Ici00XUU14y8rdh1P53+szMNMk/JqHgUhimfty1N8Kuoi88itqAqUj
	 Dh+b+tftzHjew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AA3380CEF9;
	Fri,  7 Aug 2026 22:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] bpf: Fix mmap_lock leak in irq_work path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178614301790.2448714.12103864417505840837.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 22:50:17 +0000
References: <20260805031425.2157475-2-sanghyun.park.cnu@gmail.com>
In-Reply-To: <20260805031425.2157475-2-sanghyun.park.cnu@gmail.com>
To: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, sun.jian.kdev@gmail.com, puranjay@kernel.org,
 ihor.solodrai@linux.dev, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev,
 syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com, sashiko-bot@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed,  5 Aug 2026 12:14:25 +0900 you wrote:
> stack_map_get_build_id_offset() introduced a per-CPU irq_work to defer
> mmap_read_unlock() from NMI context, and bpf_find_vma() later reused the
> same mmap_unlock_work. Both callers only check whether the work is busy
> before taking mmap_lock, so a nested caller can reuse the slot before the
> first caller queues it. Two read locks may then be acquired while only one
> deferred unlock runs, leaking a read lock and blocking exit_mmap().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] bpf: Fix mmap_lock leak in irq_work path
    https://git.kernel.org/bpf/bpf-next/c/51476f6a06ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


