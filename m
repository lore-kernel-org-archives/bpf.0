Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7133EAC84
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922130; cv=none; b=KlHTMnKH/6aChjjJiDYJvYGt+w5vrdjKAXrDERikfbB8tuMAulFCR8bHro/BQohfQlu0+d847/mGmaFtgZ11k6toAK0hVt8/6n+ginWAhT+98z/nfq008+CUYaMhDRBQPg/Mx9mrG6dYiY9x4kfFSiDttqN5UyTFmsQVHVARBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922130; c=relaxed/simple;
	bh=+ErvEuMfJmCrd0x42XkFeYa74x93FRlFY6Fhsep2IhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tw8DdwWgJJ6A1PV+1x5pwViDoTXFDAAzNE1Prrcm7IpuN4t94NCujCsP9PmB0sT3NNCg/hL68tKrvwW2f94U/UEzdJ0j0AQ1WamRRzoU3m4HV2S6uyYfsrnpArLNBHmB0AM0vx1to33VSvuVXLYcqGsTzR1CiL+JjHnOvA+d5is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH5j5H1Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH5j5H1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537471F000E9;
	Wed,  5 Aug 2026 09:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922129;
	bh=rY7erE+yF93g+TEKgKJnIM3gH3NZua4NwtKsytQt97g=;
	h=From:To:Cc:Subject:Date;
	b=AH5j5H1Qt0SUQaCeb237dobFE8GGsYYm6xeaiek1GcDtnGfhgCrkLykZEgurHHJaA
	 +C9hhCDM9fgM7h9J/ol3ydIZEVmJfVVZIJZQWKek4GevfSTUru7FlKmtkUR8PHnsku
	 R8lORA5UWTyUm0ziSlNDiTaz6LPS3CIJ0wgF07yMrRieaaWk6B/Sdj/eKA9qmezDdP
	 qeMGtmm/vaKvaYgC/6chGtFKs9URj7oIUqDLCtoBWitcMjgkZdoMVTr8MwJ5v/4GhU
	 N0L81di7Q1IhLFEcFVJNS8BttN5gO7i0WroFXCJmNvpm1bK3czzdrkz/Q5s8p1RUVz
	 Xrt6uZ+5WERMw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv4 bpf-next 00/12] bpf: Disable preemption in stack map code
Date: Wed,  5 Aug 2026 11:28:31 +0200
Message-ID: <20260805092843.516315-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we need to disable preemption for get_perf_callchain and keep it disabled
as long as we are accessing its returned trace entries buffer.

This patchset refactors both bpf_get_stack and bpf_get_stackid helpers as
suggested by Andrii [1] before applying the actual preemption fix.

Note the initial fix was sent by Tao Chen [2], but there was no follow up
on this since February, hence this post.

thanks,
jirka


v1: https://lore.kernel.org/bpf/20260720085351.655075-1-jolsa@kernel.org/
v2: https://lore.kernel.org/bpf/20260729083807.1588544-1-jolsa@kernel.org/
v3: https://lore.kernel.org/bpf/20260803210149.296496-1-jolsa@kernel.org/

v4 changes:
- fixed changelogs [sashiko]
- nr_trace variable rename [sashiko]
- fixed Daniel's email

v3 changes:
- pass flags rgument to callchain_finalize [sashiko]
- renamed err label to out in bpf_get_stackid_pe [sashiko]
- used scoped_guard in bpf_get_stackid [Leon]
- replaced trace->nr modification from *_pe helpers with length
  argument (new patches 11,12) [Andrii]

v2 changes:
- removed several unused functions arguments [sashiko]
- restore trace-nr value fix in bpf_get_stack_pe [sashiko]
- kept rcu locking together with preemption disable in __bpf_get_stack [sashiko]
- clear buf on error paths in __bpf_get_task_stack [sashiko]


[1] https://lore.kernel.org/bpf/CAEf4BzZwvAUgLwz-M0Y_NJLTmedyY9U6s7LrSmn751hQdTP4Uw@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20260206090653.1336687-1-chen.dylane@linux.dev/
---
Daniel Borkmann (1):
      bpf: Disable preemption in __bpf_get_stack

Jiri Olsa (11):
      bpf: Factor stackid_init function from __bpf_get_stackid
      bpf: Factor stackid_fastpath function from __bpf_get_stackid
      bpf: Factor stackid_new_bucket from __bpf_get_stackid
      bpf: Use stack id functions instead of __bpf_get_stackid
      bpf: Disable preemption in bpf_get_stackid
      bpf: Factor callchain_store function from __bpf_get_stack
      bpf: Factor callchain_finalize function from __bpf_get_stack
      bpf: Remove trace_in argument from __bpf_get_stack
      bpf: Clear buf on error in __bpf_get_task_stack
      bpf: Avoid changing callchain in bpf_get_stack_pe
      bpf: Avoid changing callchain in bpf_get_stackid_pe

 kernel/bpf/stackmap.c | 314 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 205 insertions(+), 109 deletions(-)
