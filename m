Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD083B7B68
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281661; cv=none; b=Xx7qe5wooNXFR6C2vDeCWEDStxLuMfC3JHT4Ys6py8qVYYZ/u0Su1l2jyzAnoCr3HVSRr427cykgsAJg1Bzh+z+eh1mYCNVD6uTVLnCAdoI7Ssn+3izj0jsbdcsXaIzgZ/hJZ2tYEZ7JHFYQSrDv3SVxtMMU5SRD0GJS68SvUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281661; c=relaxed/simple;
	bh=Bz3Ots6yk9ZczWzMqmrxecnG8LNR/r4o3HZXwJKixbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dsc32zJI4+zux6FhAyHJgOg5dD1kS4QgG7LoDz6QEE4hkWPNLARD3SgHo2Z+ho69TdZ58JvWM4tuG92m2zM9IeLa9Nzfv25+6XLY/uguBa5GdaBeoN/MB8c49pNnQjyK9rIJsm1Efk7wAN+blF7htrBwbpN9sOI2B5IoJPvMtWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=icTJgAMR; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="icTJgAMR"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-66ee7b9af94so1393058eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281658; x=1774886458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SscKSPRtp5r0bOyZYtc8orw97P+lM4BuDDRyRnpM2Q=;
        b=icTJgAMR0oeLmZ/KWfLwRrhOP+EsA5wl9eKYkctdG+jFUxkdpinSnf2VcJjIGT1ldW
         8faZggbpkd8NYEieO4mYUuOAYj1+A72IArYttf9BWOIrU4rwJLJd/miC42tsAVwEFVJy
         66Ti2OFUfy/HXBknYPGxqAyu+UL+6AmHQvZtAuPzlGc2n9aEOOhgemTQdsIzkot+rZHD
         zOeSlK/xnyBwjh+Jf5Ptj0RpSg2E2UhK3v9S/T/JaoGb3ta+awmnU4NQq9NLF3jIbmcd
         y7nTnDhmLABhFmA4CKzRMvPexu2BOZf5R0MoCXYf+kvlR/rpgKaIXkVRCw2S1/CKv+FF
         J2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281658; x=1774886458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SscKSPRtp5r0bOyZYtc8orw97P+lM4BuDDRyRnpM2Q=;
        b=YGtF2hAWRyXgXLU8wFmxu0gt+BN0vlqcTfK6ph0ah1sLbTYnIPncwzVgbSshO/4Sgg
         eTRnJxM45fB2wdi5YedGBk+75PQzoycDdzjmOsMMEtyO+4As839Cw6gJL0EP+JBKlnfK
         xCMU4vzHeUhSWUg6X5sMqEIRFqQgZoH3YVf4ZkZWbnlVvlMSma4cQtOuCG2cL6X8vMC3
         c5kgRUiO1zsbFwHlXkMeR7MiIw+zLCG7n6mLVnlfYZ0cP23/HvY/6rVRViGxcsKqoDDO
         0tM8pIQP72S3WU2D3tJkXRGEGz4Sbbb6ifSgrLa4HbAjnhkILQYb2oV4BSm2fuNYEcs0
         f1sg==
X-Forwarded-Encrypted: i=1; AJvYcCUIssQvjZ9u3c9WKH1R/DbPmLF6JTetV5HwJbIsqXAsm5V2373ztiqG7qxKi0oGKCRQrPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYy8Dfqy+szKJr80kklxk1G9wjqYkQk+nxmw4b7UO8N412FYIf
	l5YK4Ur1Wa8LFHumWWlV1Q+4+P29TEptW7PHYNOl2aHFgqoRc12A50/kMOrn9Tm0/R4=
X-Gm-Gg: ATEYQzwVJB5JK4DQpMnq+TLYwIFD7gndLPn8TqJrh2NJTFT5TKcWV+vZW6cT7fJY+SR
	jCBSoOA5cVyZsK4aW1//RPRa0kh/BouD3RBUlmxK49x1VeCFVFQ8rHBDP4A7dJU70Np/ZEubQ+P
	p5XwsCA3FVn1DvwFvmkK4zpNhMW78yI7RXVYX6+gR6noGJNe65k6/JntCV/hnQ+LtK4QQRiZnPq
	emPdh5GSieCMg8ZDaLe9h4XfQol79nkX7IiKTKuqUeOluSNL2gGlNY7ZCiXvBTfpdKWhaB26rd3
	sXd8C/m+uLDiRV7UWaZ4R5MtJR+T7a7qcVzaCN+XVoBKiVAlJmfzBJjYhK5McZdEk5G5CCIe2DD
	4Qf985MogwT8qU6fx5J41uHDUHznU4MsHJSDVBN8e+qsEJwQdV5E3S1Sp8WLNTMxY0ZZ7MDlUL8
	pqC1Mukc5vegc4GtbZWPc+iZlJ3lMhsj3JGNCxV69zmNt9UG5f6vcsA8ufxeNtBe98dg==
X-Received: by 2002:a05:6820:3091:b0:67d:9cc0:968 with SMTP id 006d021491bc7-67d9cc00e0dmr6486936eaf.63.1774281657494;
        Mon, 23 Mar 2026 09:00:57 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:00:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	dev@openvswitch.org,
	Jiri Pirko <jiri@resnulli.us>,
	Oded Gabbay <ogabbay@kernel.org>,
	Koby Elbaz <koby.elbaz@intel.com>,
	dri-devel@lists.freedesktop.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linaro-mm-sig@lists.linaro.org,
	Eddie James <eajames@linux.ibm.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/19] tracepoint: Avoid double static_branch evaluation at guarded call sites
Date: Mon, 23 Mar 2026 12:00:19 -0400
Message-ID: <20260323160052.17528-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a caller already guards a tracepoint with an explicit enabled check:

  if (trace_foo_enabled() && cond)
      trace_foo(args);

trace_foo() internally re-evaluates the static_branch_unlikely() key.
Since static branches are patched binary instructions the compiler cannot
fold the two evaluations, so every such site pays the cost twice.

This series introduces trace_call__##name() as a companion to
trace_##name().  It calls __do_trace_##name() directly, bypassing the
redundant static-branch re-check, while preserving all other correctness
properties of the normal path (RCU-watching assertion, might_fault() for
syscall tracepoints).  The internal __do_trace_##name() symbol is not
leaked to call sites; trace_call__##name() is the only new public API.

  if (trace_foo_enabled() && cond)
      trace_call__foo(args);   /* calls __do_trace_foo() directly */

The first patch adds the three-location change to
include/linux/tracepoint.h (__DECLARE_TRACE, __DECLARE_TRACE_SYSCALL,
and the !TRACEPOINTS_ENABLED stub).  The remaining 18 patches
mechanically convert all guarded call sites found in the tree:
kernel/, io_uring/, net/, accel/habanalabs, cpufreq/, devfreq/,
dma-buf/, fsi/, drm/, HID, i2c/, spi/, scsi/ufs/, btrfs/,
net/devlink/, kernel/time/, kernel/trace/, mm/damon/, and arch/x86/.

This series is motivated by Peter Zijlstra's observation in the discussion
around Dmitry Ilvokhin's locking tracepoint instrumentation series, where
he noted that compilers cannot optimize static branches and that guarded
call sites end up evaluating the static branch twice for no reason, and
by Steven Rostedt's suggestion to add a proper API instead of exposing
internal implementation details like __do_trace_##name() directly to
call sites:

  https://lore.kernel.org/linux-trace-kernel/8298e098d3418cb446ef396f119edac58a3414e9.1772642407.git.d@ilvokhin.com

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>

Changes in v2:
- Renamed trace_invoke_##name() to trace_call__##name() (double
  underscore) per review comments.
- Added 4 new patches covering sites missed in v1, found using
  coccinelle to scan the tree (Keith Busch):
    * net/devlink: guarded tracepoint_enabled() block in trap.c
    * kernel/time: early-return guard in tick-sched.c (tick_stop)
    * kernel/trace: early-return guard in trace_benchmark.c
    * mm/damon: early-return guard in core.c
    * arch/x86: do_trace_*() wrapper functions in lib/msr.c, which
      are called exclusively from tracepoint_enabled()-guarded sites
      in asm/msr.h

v1: https://lore.kernel.org/linux-trace-kernel/abSqrJ1J59RQC47U@kbusch-mbp/

Vineeth Pillai (Google) (19):
  tracepoint: Add trace_call__##name() API
  kernel: Use trace_call__##name() at guarded tracepoint call sites
  io_uring: Use trace_call__##name() at guarded tracepoint call sites
  net: Use trace_call__##name() at guarded tracepoint call sites
  accel/habanalabs: Use trace_call__##name() at guarded tracepoint call
    sites
  cpufreq: Use trace_call__##name() at guarded tracepoint call sites
  devfreq: Use trace_call__##name() at guarded tracepoint call sites
  dma-buf: Use trace_call__##name() at guarded tracepoint call sites
  fsi: Use trace_call__##name() at guarded tracepoint call sites
  drm: Use trace_call__##name() at guarded tracepoint call sites
  HID: Use trace_call__##name() at guarded tracepoint call sites
  i2c: Use trace_call__##name() at guarded tracepoint call sites
  spi: Use trace_call__##name() at guarded tracepoint call sites
  scsi: ufs: Use trace_call__##name() at guarded tracepoint call sites
  btrfs: Use trace_call__##name() at guarded tracepoint call sites
  net: devlink: Use trace_call__##name() at guarded tracepoint call
    sites
  kernel: time, trace: Use trace_call__##name() at guarded tracepoint
    call sites
  mm: damon: Use trace_call__##name() at guarded tracepoint call sites
  x86: msr: Use trace_call__##name() at guarded tracepoint call sites

 arch/x86/lib/msr.c                                |  6 +++---
 drivers/accel/habanalabs/common/device.c          | 12 ++++++------
 drivers/accel/habanalabs/common/mmu/mmu.c         |  3 ++-
 drivers/accel/habanalabs/common/pci/pci.c         |  4 ++--
 drivers/cpufreq/amd-pstate.c                      | 10 +++++-----
 drivers/cpufreq/cpufreq.c                         |  2 +-
 drivers/cpufreq/intel_pstate.c                    |  2 +-
 drivers/devfreq/devfreq.c                         |  2 +-
 drivers/dma-buf/dma-fence.c                       |  4 ++--
 drivers/fsi/fsi-master-aspeed.c                   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          |  4 ++--
 drivers/hid/intel-ish-hid/ipc/pci-ish.c           |  2 +-
 drivers/i2c/i2c-core-slave.c                      |  2 +-
 drivers/spi/spi-axi-spi-engine.c                  |  4 ++--
 drivers/ufs/core/ufshcd.c                         | 12 ++++++------
 fs/btrfs/extent_map.c                             |  4 ++--
 fs/btrfs/raid56.c                                 |  4 ++--
 include/linux/tracepoint.h                        | 11 +++++++++++
 io_uring/io_uring.h                               |  2 +-
 kernel/irq_work.c                                 |  2 +-
 kernel/sched/ext.c                                |  2 +-
 kernel/smp.c                                      |  2 +-
 kernel/time/tick-sched.c                          | 12 ++++++------
 kernel/trace/trace_benchmark.c                    |  2 +-
 mm/damon/core.c                                   |  2 +-
 net/core/dev.c                                    |  2 +-
 net/core/xdp.c                                    |  2 +-
 net/devlink/trap.c                                |  2 +-
 net/openvswitch/actions.c                         |  2 +-
 net/openvswitch/datapath.c                        |  2 +-
 net/sctp/outqueue.c                               |  2 +-
 net/tipc/node.c                                   |  2 +-
 35 files changed, 74 insertions(+), 62 deletions(-)

-- 
2.53.0

