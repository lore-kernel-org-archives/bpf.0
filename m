Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852057;
	b=S+kTMNpkRzKiDvP+EmKmHItc+tcmMDJWKvwzgVKAuSbnFF7jB/DWTymlsML7SRIhWOdu
	 +SFzefBr1SkkzATC//5Sp7vLHHvNpySeMxg9AbwQSCIAYoyhuz8M+FzOHK8U73vdfW6w1
	 p6Yr/FzMi8QGDdg45z1fYKXuSquMCsJxMMXE0bO5LCEbaVa7jHKOLrK3tYkrJ1K/5alIn
	 H+386sGmb+ZAnDgjqaNxfRMgC1rS4d5zT6amNqQ8I60xp6Z1T4cMwQkbYWii79cOZxHMm
	 370tgDEZMLNlh4APg9/0z+AztFw/4/BQyV8WiE6zQSqZg4eeiZiN/1HTcvnA3kvPFxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852057;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2AkJx9hi83xuoAOhb1ukIpX4UAtOpPgSa20X9GXqtPI=;
	b=c8PrcROgNoAb/KfPXbGy0IIu07XV+QEOADq9aSPmo4MG4psMNfwKdgQ/+2W9UJfD/8fo
	 iuzw82M8C9zfXbBNFEGlc4v4TNKIZlwFdgwEoOYTb0kevwMaDRwbhuqMFEDlMTbNNh1TL
	 u/ZYULdSRIoHbwXiSyyi+WF59bvATZyx4MHRTvX6qNHd5QeQN5iSjAjPt+Fi/dVOhjmXv
	 /RMn8f9Tw7FBWXhMAcwzq1ZA96mBswfHdTyR5vf5WD+818wQ3OFuzmA+AnWg+QcT6BKK8
	 VzP/tlsrt7qQ1uP4at+BHC0Sj5qXMHj4qhRnjnUeKLCGi2+ltzBD5mUhRXTXLnM5ddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJLyGzrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE3606A883;
	Mon, 16 Nov 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RJLyGzrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B101F000CE;
	Mon, 16 Nov 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794852056;
	bh=2AkJx9hi83xuoAOhb1ukIpX4UAtOpPgSa20X9GXqtPI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RJLyGzrj5U3uVN4Dj9SxYZsU2tBDJl2Mcnj+jwG6Sn5LNN4EtR/CI9l2inoevGEcs
	 Z6JSOJYfClj2ecw4tmFaDxC1ALSbblK4mDGaJPBgGMWDZRtLbznaxuMTON4sI7/HDI
	 IVyDBmaiwynWQtBQyPiMptdsotJLCDxPMA8MnvAYSMdm4NXlwB2D1N+DolqHzSVQQk
	 K5EyqLjo8Epr/7w+V7yQ8j0PhKOJtBFA5hwCw9/NM6BR91IX/pAr2xSaGFEhdzwHIH
	 83xTgHXT/r3FjnGyX8BgiAhK85w1jaWgvFLM6zxQKzXkg6jql1Y/7bj/LaL66+TUEl
	 ME3SLrXK31LEg==
Content-Type: multipart/mixed; boundary="===============3050173542120737568=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cbc334928b8adc1b58476abc1b29d6283b050a8e9d3078338cda0a0a505e19e4@mail.kernel.org>
In-Reply-To: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
References: <20261116-bpf-raw-tp-regs-preempt-v1-1-d01b6dd8573c@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Disable preemption while a raw tracepoint regs slot is in use
From: bot+bpf-ci@kernel.org
To: mike.bazov@gmail.com,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,yonghong.song@linux.dev,emil@etsalapatis.com,kpsingh@kernel.org,matt@bobrowski.net,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,mike.bazov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 18:00:55 +0000 (UTC)

--===============3050173542120737568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Disable preemption while a raw tracepoint regs slot is in use

TL;DR: Commit message only: the "few instructions" cost claim may be wrong,
since build ID resolution in bpf_get_stack()/bpf_get_stackid() would now run
with preemption disabled. Changelog should mention it or justify it.

>     The cost is small: the helpers already disable preemption around most
>     of their work, the unwind in bpf_get_stack() and bpf_get_stackid() and
>     all of bpf_perf_event_output(); this adds the few instructions around
>     it.

This isn't a bug, but is the cost really only a few instructions when build
IDs are requested?

In kernel/bpf/stackmap.c the build ID resolution happens outside the
existing preempt-disabled sections:

__bpf_get_stack():
	preempt_enable();

	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);

bpf_get_stackid():
	scoped_guard(preempt) { ... }

	return stackid_install(&stackid, map, new_bucket, flags);

Both callchain_finalize() and stackid_install() call
stack_map_get_build_id_offset(), which takes mmap_read_trylock() and, for
every frame (up to sysctl_perf_event_max_stack, 127 by default), calls
find_vma() and fetch_build_id().

With this patch, a raw_tp or tracing program calling bpf_get_stack() with
BPF_F_USER_STACK | BPF_F_USER_BUILD_ID, or bpf_get_stackid() on a
BPF_F_STACK_BUILD_ID stack map, now runs that whole build ID resolution
with preemption disabled, where it previously ran preemptibly.

Could the changelog mention the build ID case, or explain why holding the
slot across build ID resolution (which no longer uses regs) is acceptable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43920336669
--===============3050173542120737568==--
