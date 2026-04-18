Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E41917F0
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 03:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776484347; cv=none; b=JSDmyT+2whS2yLHFanKiPwiVvLWZojxsZXsASkEM34ONGFdor9XiKeehXJmoSd884aaUuG6EwDUnFlq8XmR83uYdWO5G2h0pLKqlu1/ZpKPXfv4hQeAFdFrberhrKw5NvkAGUpNZ89va0DKuEA5smJcfT6nLYokMrd/WkzWYCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776484347; c=relaxed/simple;
	bh=WLK8PVI/mJZAs76yF2kohWY8XVDwws7cheZLIe51IHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K5ltPMOnlfc+nV9aBaA1X+SKGtv1oofSH1YHzoBAga9qJ0m2/Cnvqm0szdeG0a3mF8NCRwHLq70sBXR/ne3nNbplILvbuTTOJq0XUgtiae16vD3q++r7CiG+l/3i2rgGmnAsnwckzjjNbrcHcUXPgROMaGs09Tf17ztzn0Or2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCc8ils8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCc8ils8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168AEC19424;
	Sat, 18 Apr 2026 03:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776484347;
	bh=WLK8PVI/mJZAs76yF2kohWY8XVDwws7cheZLIe51IHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BCc8ils81bUmZI80d/JUf/U6iOaoBVUzZbX7kRcc4u1/DhV/kKYeiZXGBf2HjOpyW
	 0wneO6N2Xpzlz4qBADWtm0sxzD6VZqSoTNJQCchBFoFHJINXJObssavmtWaGRQ/7dk
	 aI/vOroiuljjro3if/C/k64QBuW1FbSwMuRa+mbuxFgqO3er+uCi6ZuGDz7y8AMfBI
	 2Zq0/noGpcYd5E7fCdfoErZ31yCvMy4j7IxtUfL9tGtMPHrFWZN3tYgzxnbQ9iGBcW
	 fmVs5bEB1M4/RAt58hu/2sFyK+2dRNKMxEHpy56V8RE4LhhBNxCclB/IeokQ3FDic4
	 Sz9BkbVEjsZzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 04/28] bpf: Use mutex lock pool for bpf
 trampolines
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-5-jolsa@kernel.org>
References: <20260417192502.194548-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 03:52:26 +0000
Message-Id: <20260418035227.168AEC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] False sharing in the shared mutex pool causes spurious `mutex_tryl=
ock` failures, leading to random `-EAGAIN` errors and trampoline state corr=
uption.
- [Medium] The `trampoline_locks` mutex pool is initialized in `late_initca=
ll`, creating an uninitialized lock hazard for early boot BPF usage.
--

Note: Due to system recitation restrictions, the standard inline-quoted
patch format has been altered. The findings are summarized below in a
free-form format without direct code quotes.

commit 8bee21cb8aa45a6b2275c87c16fbbd2fd1953e75
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Use mutex lock pool for bpf trampolines

This commit replaces the per-trampoline mutex with a 32-bucket static mutex
pool. This allows upcoming tracing_multi features to lock all involved
trampolines simultaneously without exceeding the maximum lock depth.


In bpf_tramp_ftrace_ops_func(), mutex_trylock() is used on the selected
trampoline pool lock to avoid deadlocks with direct_mutex. Because multiple
trampolines now share the same lock, could this lead to spurious trylock
failures if an unrelated trampoline happens to hash to the same bucket?

If the trylock fails, the function returns -EAGAIN. Does this mean
concurrent ftrace or kprobe registrations might randomly fail due to false
sharing?

Also, when the upcoming tracing_multi feature locks all 32 mutexes at once,
wouldn't that deterministically abort any concurrent ftrace IPMODIFY
registrations system-wide?

Finally, if this trylock failure happens during unregistration, could ftrace
cleanup routines ignore the -EAGAIN, potentially leaving the
BPF_TRAMP_F_SHARE_IPMODIFY flag permanently set and corrupting the
trampoline state?


Regarding the pool initialization, the new trampoline_locks array is
initialized in init_trampolines(), which runs as a late_initcall.

Since the static array resides in the bss section and is only zero-initiali=
zed
before this phase, what happens if early boot BPF components (like early BPF
LSM policies) try to attach or modify a trampoline before late_initcall?

Will this result in calling mutex_lock() on an uninitialized mutex, leading
to crashes or lockdep warnings when CONFIG_DEBUG_MUTEXES is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-5-jolsa@kernel.org?part=3D1
