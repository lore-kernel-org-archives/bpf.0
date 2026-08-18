Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A038220F2D
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012695; cv=none; b=RPBC91uM4IwqWBMql5m5BGVqtZpLIUgstuZ0s/9tULq8Y8bN7cjfWHWmyDgyG8TTtW9zB5T0I/omGHHGmrSQK3sHpYHr5YZCjoTpAhYSJO7uaN4vLPgwT8iFKWDybhSFlEKHvlgEhy63rPKQWC6EqaWGQIFGa3UQEIrDFYjgQF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012695; c=relaxed/simple;
	bh=qWRqvfmnNty80NoawIZpg8GiTpU1j9V039JR3Hleqg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHOnFXAbB/UgtkJ4Y2HTv6qWoilV1aI61h5ChmdqRbA6xn2tuu7tyP1S45Z2FRREt4CF9TXk+QsD37AIB/+X9S/eeaF1xEL+HAMv9qZ8Glh6nlQ2aJhAOKt3FEZIxeIbMiOJz6mVWh9Po/3+63QgNq500cY8ad5zzMFl2yB0DAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXSrOccU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXSrOccU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3868956a91.1
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787012694; x=1787617494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XQzhuTEmSzFVRktqX1xn6ptqrzbe2xgge0zZzqfRxOc=;
        b=HXSrOccUFFHs/y8UgtdBxzzK6rYbzWVrbVupWEqVQP7QD+L1+5JMUb4bDRJIznS0OJ
         WW/yPAkPwh864IwLN3KS2ygMcnptY5b90KTyJjRf4mZeFKaIJU2pUWwDlmP515UKpxBC
         j9qOFX/JP/cLIdAI2xLTCajl1IpfF/gU0q6cfGgWrYmr1Xhc+gB4al54DImdU2g19xy+
         yh0yLJAR+LYlyoaq4RQrnJqheZFBt1527McScmewJpxrhdVXaqR5bKvLLsLggcX4pFNd
         xErBq9eUsdnKsTQBe7AZSOkGey/+pCIHxhniibUG6u5lNRW+8WusdUn6dxCgLI1wSkmq
         8siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787012694; x=1787617494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQzhuTEmSzFVRktqX1xn6ptqrzbe2xgge0zZzqfRxOc=;
        b=qzBi2ncE0vgK0P/7iOBCgEEbmEssBe7nQmKN6O731Fr1R8zU/HJOQpcZgm7ae5UMQI
         dDC7H7WFUF37JbfQ5JqVgE6fGlVj/a7Ufvlk+awqoQ4anonQ8eNNz2pwfxETbDmwXsXZ
         SQgiVYa9WJLQvcGXr/Bm/6krsslkHKDXOD2sWYAiaFE9TTyYa8RSbcyz0cJNw3ORrwez
         yEnQrTEUoZSlYW+NZl8yzsmiWulEd7T6/Ft595aD9D2/ndE9exHq31dzMZtQhkOIXIsp
         jKYIuScW5IQINDs6r1+X1xkixDJ0JHEIcuWvVbtXpe4VVhS+u/XRLKGa7OOZlWYmKofb
         XBxw==
X-Forwarded-Encrypted: i=1; AHgh+RrBDT+f2t0fBhJ6TjGghMlAHykZ80OSyHXHo0TIfBx1g0+uw1TO4F2U7V9vq8MzAbKH80E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy27SvPFNlN+vEDEq5kQayQ2zD/smx2ZI6Q/e32XMlipMjsjPoO
	oItfeabODkvi9KAXYyAK6uOL8PGfzhGDfUnoVVstE003Zw+eflayRyvL
X-Gm-Gg: AR+sD126uVOBdc7rTXuE0y6fr9BEF8Bn4dcq8ShYDGWmBrHr26A8dUHTWbI2KWCNgfp
	v21vdGGAaq/ympJ92qn+rafr0oyUKksiEAT56ZclSKlQ63zW7cnMTF236B5Kh8fxMunlY1y0GJ9
	B+1cm8xB2X/SFjV17WYU6sWGP2wN3CCjUX41Ju04FD40/pFVjLKT8iOX2vK7nP1AVJGcaeAPfI3
	ESNvt5N4/ZPyWcJuhZdIz3WqMairS249bR1FRJF4xKYsmhmhu+LcAXrFf8BJJR8zFMMNg9D4Jaa
	9SyEfgH0X/G2vmIV3ct59k9N5eZanR7tjKhE+U9nGzjTWhri+e7aCBk20THJluxDqxZGM8hm1Rf
	BqE1D/BJUtyikXUIz/sAgke1byqbW6bT0QqjtjiEBxPgspft/pS/U5oxJb+xUxvyZeMCnxnuUij
	B4LHfY/jU/Fd421a5k/CEbackBOB+LGeR27KsLmwZlIhst6s8I+gCXqWk=
X-Received: by 2002:a17:90b:2c8d:b0:38f:caa2:5721 with SMTP id 98e67ed59e1d1-3933e62f4f8mr29637987a91.17.1787012693684;
        Mon, 17 Aug 2026 17:24:53 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:67::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32678dcedf4sm10261905eec.5.2026.08.17.17.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 17:24:53 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	kernel-team@meta.com
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Ziyang Men <ziyang.meme@gmail.com>,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cgroup: expose cpu.stat to BPF
Date: Mon, 17 Aug 2026 17:24:48 -0700
Message-ID: <20260818002450.3071325-1-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the title suggests, this series adds bpf kfuncs for the cgroup CPU
controller.

Motivation:
Collecting cgroup statistics is expensive: the existing
method is to open and parse a cgroup file. memcg already has an
efficient alternative through BPF; this series extends that idea to cpu.

Design:
- Add bpf_css_flush_rstat() and bpf_cgroup_base_stat() to cgroup rstat.
  The second kfunc returns the raw cgroup_base_stat after the
  same cputime adjustment used by cpu.stat.
- Leave reading the CFS bandwidth counters to the BPF program. They are
  plain fields of tg->cfs_bandwidth, so they need no kernel code.
- Add bpf_css_to_task_group(), which returns a checked RCU pointer of
  the task_group*. This is usefule to compute the throttled time in bpf
  side since the bpf_per_cpu_ptr() requires a verifier-known struct
  task_group * and a pointer carrying the MEM_PERCPU property. 
  This use the convention that task_group embeds its css at offset zero,
  so no scheduler helper or scheduler source change is needed.

===
Changes since v1:
- Make the rstat flush generic, move it to rstat.c, and take a css.
- Return cgroup_base_stat directly instead of repacking its CPU times.
- Replace the throttled-time aggregation kfunc with a checked RCU cast in
  the CPU cgroup BPF code. The cast preserves the verifier type needed for
  the BPF program to perform the per-CPU sum itself.
- Remove the changes in the scheduler part.

Tested on VM with v7.2-rc5. 

Ziyang Men (2):
  cgroup: add BPF kfuncs to read a cpu cgroup's stats
  selftests/bpf: add cgroup_iter_cpu test for cpu cgroup kfuncs

 kernel/cgroup/Makefile                        |   2 +
 kernel/cgroup/bpf_cpu.c                       |  61 +++++
 kernel/cgroup/rstat.c                         |  59 +++-
 tools/testing/selftests/bpf/cgroup_iter_cpu.h |  22 ++
 tools/testing/selftests/bpf/config            |   3 +
 .../bpf/prog_tests/cgroup_iter_cpu.c          | 259 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_cpu.c     | 113 ++++++++
 7 files changed, 517 insertions(+), 2 deletions(-)
 create mode 100644 kernel/cgroup/bpf_cpu.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_cpu.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_cpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_cpu.c

-- 
2.53.0-Meta

