Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD653B19BF
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647533; cv=none; b=R6r9yJQyKAEqGZNE7/C0ifp11lHbBFL4MeGk7g8PvLGYUECdwS/OTOwcX/OonYPoEnNupHA9Banus5nooOuvK0zoB37Pq+nTDzHiWzwZ7louec28V84JniBo5uwUSVjmti0GnQLmHnFlub9MCksSgE1xC+v5call+EZ7IBI0kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647533; c=relaxed/simple;
	bh=ieT3j4ATm+VvwOP6ZEo+gWzrvv6Thjmvaatd82ACSEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVIB0l8M/BgB/HUnLI01u9qf+TdAOjCNp6LkrOfxjDG3VK4wNVJxhesyQbJPlyPVU/13enBnwYLHcF9k7o3g8h+0H/ybNPMM0jBS6ZVNpjUU5DfmweH5cY9pIAQtZdHsDflGBpjeMcFM3GIkBqAz4/FU3bT1bCub9E8wq2ZwNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHabd6FV; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHabd6FV"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so198340a91.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786647529; x=1787252329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNrC+JRTptWjKfS940kfYbykFXy92wCoTM6c2X2KQos=;
        b=pHabd6FVq2kM0yDo4CRUVorADTmvSqg5lj/4DjK+t4U/plVyYl7ek1uXqLmdEupZwV
         01RsgIsv9gfd9sLvpr8c1iKzJIjrL1yuVkP6DmsVv4YxGCtINv4hDYTgZB3aycZSbcnY
         NgEXCzcCMa91DeVOAAnGusdhRLPSV9joXjVRg8vHRMtdBHuedHHcoViT6uzU2K4i/lKR
         dDRjWOn0mzTP7ph8bCKyJt/V29ihKqURYZrf5wXxXODGB0huyUowwxeeMNBaIhQywcIe
         aN25LOiANQRCUEO/NEuyEe4Mm91KM/y34L4NJbw0gRzqkl7ZlGm1l6zP5Yib4Gqo9wbF
         J4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647529; x=1787252329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNrC+JRTptWjKfS940kfYbykFXy92wCoTM6c2X2KQos=;
        b=fPRX3BsYvsdpj8BDrYnUehtCH/J9eBrfGu20q1rAVK/I6Yl6w435ZDojXpTa1VSfUU
         mZyOA+PHS+FxXWwID1m7x0VT7r9jsE1+zpv35l0JB9MQpuW79nQKwrJ6ujOSeqHuhN0z
         yTLHRDKGKNfVZ8/rYgid/LNOHcXfJdZsQwvWLChBbfypYszHmmDUxSlIhfBaYRO7OgVk
         2bQV8nB1vVyRVdQrFFOlRL1IrOzNzkA85LqDbnUyEpd02G+FyMywr0DYp0HdoVdqQRpQ
         FUacA4L91Q2c/qYjROi6fpYulTCkIRdZ4kRBZnD8RUiSQiIcfBO0g88t6rn6gsTC8Ii7
         k8mA==
X-Forwarded-Encrypted: i=1; AHgh+RqqV6AM38yDvpyW400ZTc6D84lFy8TvMHI8pVitEmhXGSBPPIhHF1m3q619To15szNQDQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIcopP2xipesNkhXECK6bEbHX2qzQzpQCobVGisWuOk63ketm
	ZKGxMHsVvZ+mfgYYY6tkCAxObSrSoBk5EU48I00jn66RnVNplmNV/aJK
X-Gm-Gg: AR+sD11w6i8kLczqpluM6wEbO5TLFJHXHo13Rbuh4E820rqzd2gIilB5lHLjoipmTWu
	Bc+N8ORFTYE7ImjcN6iGbpk/+aY7G4J+S4gEo9HHCyvJYRgnBuHVGN6ZMaHCptSJIJGyZSXXuNC
	o5DdICgff8igENcV0A1+UxuGQuVC2ieO18VY2QPwQiwvKAUXdz682nwVfQlyDVJmYsm0Q8Nml5n
	3OcExOqHuGarLm4RLGAPZucAYyhzTdG72IJNzKfUSvU4B9jKzolCMUbWByowuyPaOa01QPl5BZX
	NEUern79dhqsjYqFtteeVgSiqYdmyOZtUDtras5XAawR7sunkDhceOZkaUG9HV/8sEwFmWnxDmm
	dNUIwIDT+raNSD67jfZru3YoF+lad6o8MMkqW/SqBirVEJyFw4PRkQ7NvPV9H+0gfGnqHt6feqw
	4UkLSaWB6SIawFXhmU3I4zDDg6oRaHbf9al0l6mOp3KKVtiF0l+l/5/UUFxBhG7e/0s9M=
X-Received: by 2002:a17:90b:5447:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-3933e5c8557mr24629a91.12.1786647529381;
        Thu, 13 Aug 2026 11:58:49 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6f::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ac9b1sm943437c88.2.2026.08.13.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:58:48 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Ben Segall <bsegall@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>,
	Ziyang Men <ziyang.meme@gmail.com>,
	kernel-team@meta.com,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] cgroup, sched: add bpf for cgroup cpu controller
Date: Thu, 13 Aug 2026 11:58:44 -0700
Message-ID: <20260813185846.1216892-1-ziyang.meme@gmail.com>
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
- Leave reading the CFS bandwidth counters to the BPF program. They are
  plain fields of tg->cfs_bandwidth, so they need no kernel code.
- Add one kfunc to compute the throttled time. This is necessary because
  it is a sum over every possible cpu, which a user cannot do itself.

The only part it touches the scheduler part is to discard the static for
throttled_time_self() in order to use externally.

Patch 1 adds the kfuncs (kernel/cgroup/bpf_cpu.c); patch 2 adds a
test_progs selftest.

Tested on VM with v7.2-rc5. 

Ziyang Men (2):
  cgroup, sched: add BPF kfuncs to read a cpu cgroup's stats
  selftests/bpf: add cgroup_iter_cpu test for cpu cgroup kfuncs

 include/linux/cgroup.h                        |  15 +
 kernel/cgroup/Makefile                        |   2 +
 kernel/cgroup/bpf_cpu.c                       |  80 ++++++
 kernel/cgroup/cgroup-internal.h               |   3 +
 kernel/cgroup/rstat.c                         |  42 +++
 kernel/sched/core.c                           |   2 +-
 tools/testing/selftests/bpf/cgroup_iter_cpu.h |  22 ++
 tools/testing/selftests/bpf/config            |   3 +
 .../bpf/prog_tests/cgroup_iter_cpu.c          | 259 ++++++++++++++++++
 .../selftests/bpf/progs/cgroup_iter_cpu.c     |  53 ++++
 10 files changed, 480 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cgroup/bpf_cpu.c
 create mode 100644 tools/testing/selftests/bpf/cgroup_iter_cpu.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_cpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_cpu.c

-- 
2.53.0-Meta

