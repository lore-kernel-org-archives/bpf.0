Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494398;
	b=O0LUf/ZiNP6MygPxcP51oGNP07RlZEHxuBMIv+sBafLpcGYe25h0p7zITSIMGeIidxi0
	 yAggQVziDC5FjCok1bB+CA+eusf0vmwdVZFtwja+Vsd1jXJQKiSXhKnnyJUj69vtxyJe3
	 nPDdUURmxaTXJu8JVrNNRf3bDhkU38SczxhMOLec+WCwe3ukJ8mGs1tNcqecQVIpvzbDz
	 TLUCO9ChhSz2CDQTjBP5mx3U69RvVOcc0A3DCRzWfJUyt2rZD44IeNsDCiB+CvTCA4VmK
	 WPO5pvJqEUZRAVNTk0DzpiNpSskYno9jtYqJbyreiu1BStWpBpuYTy2LAH6sT7g1HvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:
	 Content-Transfer-Encoding;
	bh=RKz3qpU8ttLqqpRgn4f/qLb2IMUIl0tI5d3P0NML3VM=;
	b=CBi003rfxhhepomIp/6cirZBZHSjtAI9rBYXu8UvSKxdf0ry3GLffyOUsnOj4eaal01b
	 40ndVUXKNQhIcTd8yw3jGBvCewwSu9tnJPh5mAcW7//Ku834fqQeg8Kvp0Ypc7C/0EuMt
	 r3bU5876MJoFH7ZgixcyrPDGfunnqPGx2sXEJvq9rVGmL/iTCimzbne4Iiras4Wb5AeXB
	 EkoOipU+LwfllREdvh8bIv/dUrtAYZywXTTDmkMHOQotU6ig4phBFs8rRrR/mSg3F2LWo
	 tMQCpZpZD6rayaXhIt0TqljkBkx/k5DEN7D0lqNKQUsHVVm8cKNN0xx9pLniDmBCBlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qY9mSBcc;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424F606A32A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 11:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B424F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qY9mSBcc
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso2280766a91.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792494397; x=1793099197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RKz3qpU8ttLqqpRgn4f/qLb2IMUIl0tI5d3P0NML3VM=;
        b=qY9mSBccC1OQwSExfXup8kB53g2BC3d8GcRBtmnp67jaXJ+rHvjCSyXtzc3wmAF2ca
         4hT11EwkBQqPt3Tgv37eWXGuJHCradv62+Pk2TrPU+wbKmUXuDgTpr2AQvFYOCQ9eKaa
         5C2Qau8thHdSfbzdVtkHLK/g7PELqC4gSi/P8pl697g628ZBmtjy/zbt9T0nhBeR9M+W
         Jhvr1nJrFPouOoITu/bxVZwug0oZnF5U7E+PT7+V1PSPQhTdMAszn5xqjrasUQnQJ/gv
         veuJGsW7mr9FZyed1K+q+qt2cT5rICbzSQU1+N/TjdP+SyuhOG2umUSfNkm3DXKh48Ct
         RVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494397; x=1793099197;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RKz3qpU8ttLqqpRgn4f/qLb2IMUIl0tI5d3P0NML3VM=;
        b=k8a9+GWLqPzJewQ2Z2ld90IEzXAGpxNywCzZ7Kbwrh3L+JlCsjskgLRHNkeSNuhuRB
         LDamyRiTg/J9d8tw0mde4hIvO+5IVB8dSbhqSOSwfHytasidOEejjIJiKcj6aeLjkxmm
         RLMU0/Xj8lgvcpzKer/lmsdUQelluQ731NXkXBMR71DBIWist2C9iwPd/smVbn6SwwTk
         dQxwC6YQhg+yJ+SwevI0YYsN97+Z3SwBfja9u6fLl6GbIug5OXAapr7Jndh06gUxlSif
         xDGVmDLROdHYLLL61/j2upuqKyIKTxpWXCOwt7bIRJ2MJ7a4RDES8CCH0emkrz0Ldxbq
         3dLQ==
X-Gm-Message-State: AFq9FYKiqW/HlyVUkKF2FEOFf72BhmUDY6tV91vYq5a6MhKyyR8+3iTS
	1SFC0bZn0/8HrbF12KoK4zrON15PQLaGjBPkosbDEW+GRUfCynJKSSI9DfiGmg==
X-Gm-Gg: AYBFou1g6r1grLowwDw484tIhVBUDImELWhoXMS+ZfdX6BMj7bM5OFnvry6r6RfNBp2
	BGSdsDIor9+UH1twQPjYMXkSxXGlS13WHGOsjCqg05kcKnmkbbKm3SajYMJBxd/WDtZ3A43m9Yj
	G0hEAXmI5VQy+4oYM9yVE+JvDCzYD/S5ZtZ05WfbRSdhHUCO++VbSVjdNrF0qqtJuifSvDQHMGJ
	AANdCIhQeWBjONEe4i8jD7S2vpizPpNUh/3vL4n+iWpPuU8gjj1cwQa7Y2cqs24Mti8q/43BmAn
	d/1vnrndseuKutsCv2ztTimbIBzjaetiit3792IxO+q0FzJZXOmqkKHhEZvbqPrhGgY0TqyClT/
	KqroLoeQcPGbZJOceb8QUN7GVLgiA77qRjKnOqeRDw8okcy9ZN92Tz3eZq+6H5f7112fPfAt50P
	OVdPNK02ADfeYIRqmhfdLWKb+zmobzyErF5FIGFo7n5GyXwmSj3MI4a8YdptpQo4Qc99BsbP/Jk
	ZwD4SAt6Dqo+qA=
X-Received: by 2002:a17:90b:3c92:b0:3ab:2d46:1dd6 with SMTP id 98e67ed59e1d1-3acee729656mr9287239a91.4.1792494396945;
        Tue, 20 Oct 2026 04:06:36 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad60f3425bsm3064392a91.8.2026.10.20.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:06:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: support 32-bit linear scalar evolution
Date: Tue, 20 Oct 2026 04:06:25 -0700
Message-ID: <20261020-scev-32bit-v1-0-838f34f9f0cd@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261020-scev-32bit-0bcdd0fd6c34
Content-Transfer-Encoding: 8bit

Support scalar evolution widening for loops like:

     w0 = 0;
  l: w0 += 1;
     if w0 != 3 goto l;
     exit;

Implementation details are covered in the first patch.
Veristat results follow. Program sets: cilium, meta, scx, selftests.
Tables: success in both runs; baseline Insns >= 5,000.
Ranked by percentage change, then instruction-count change, file,
program. Meta names are anonymized.
Top 50 wins are shown, there are no loses.

Histogram
---------

Total progs: 7994
Old success: 5665
New success: 5665
-100 .. -95  %: 21
 -95 .. -85  %: 1
 -85 .. -75  %: 4
 -75 .. -70  %: 17
 -70 .. -65  %: 10
 -65 .. -55  %: 3
 -50 .. -40  %: 2
 -40 .. -30  %: 2
 -25 .. -15  %: 2
 -15 .. -10  %: 7
 -10 .. -5   %: 32
  -5 .. 0    %: 6
   0 .. 5    %: 7887

Top wins (50)
-------------

File                           Program                            Insns (A)  Insns (B)       Insns (DIFF)
-----------------------------  ---------------------------------  ---------  ---------  -----------------
timer_start_delete_race.bpf.o  start_timer                            40007         28   -39979 (-99.93%)
timer_start_delete_race.bpf.o  delete_elem                            14003         11   -13992 (-99.92%)
verifier_bounds.bpf.o          crossing_32_bit_signed_boundary_2      12330         20   -12310 (-99.84%)
access_map_in_map.bpf.o        access_map_in_array                    18457         35   -18422 (-99.81%)
access_map_in_map.bpf.o        access_map_in_htab                     18457         35   -18422 (-99.81%)
access_map_in_map.bpf.o        sleepable_access_map_in_array          18457         35   -18422 (-99.81%)
access_map_in_map.bpf.o        sleepable_access_map_in_htab           18457         35   -18422 (-99.81%)
firewall-09.bpf.o              twfw_connect6                         153638        320  -153318 (-99.79%)
firewall-09.bpf.o              twfw_sendmsg6                         153638        320  -153318 (-99.79%)
firewall-10.bpf.o              twfw_connect4                         102193        241  -101952 (-99.76%)
firewall-10.bpf.o              twfw_sendmsg4                         102193        241  -101952 (-99.76%)
firewall-10.bpf.o              twfw_connect6                         166183        397  -165786 (-99.76%)
firewall-10.bpf.o              twfw_sendmsg6                         166183        397  -165786 (-99.76%)
firewall-09.bpf.o              twfw_connect4                          76030        197   -75833 (-99.74%)
firewall-09.bpf.o              twfw_sendmsg4                          76030        197   -75833 (-99.74%)
linked_list.bpf.o              clear_global_array_list                13071         57   -13014 (-99.56%)
rhash.bpf.o                    test_rhash_update_elements              7584         91    -7493 (-98.80%)
profiler-06.bpf.o              on_perf_event                         425953      94751  -331202 (-77.76%)
profiler-26.bpf.o              handle_cu_mem_address_reserve          45724      12702   -33022 (-72.22%)
profiler-26.bpf.o              handle_cu_mem_create                   45724      12702   -33022 (-72.22%)
profiler-26.bpf.o              handle_malloc                          45724      12702   -33022 (-72.22%)
profiler-19.bpf.o              sched_switch_offcpu                    78210      21906   -56304 (-71.99%)
profiler-26.bpf.o              handle_cu_mem_map                      45922      12900   -33022 (-71.91%)
profiler-09.bpf.o              on_custom_event_start                  45973      12951   -33022 (-71.83%)
profiler-09.bpf.o              trace_func_entry                       45973      12951   -33022 (-71.83%)
profiler-19.bpf.o              sched_waking                           23153       6642   -16511 (-71.31%)
profiler-27.bpf.o              handle_cuda_launch_exc                 23176       6665   -16511 (-71.24%)
profiler-27.bpf.o              handle_cuda_launch                     23189       6678   -16511 (-71.20%)
profiler-12.bpf.o              on_custom_event_begin                  23396       6885   -16511 (-70.57%)
profiler-12.bpf.o              on_custom_event_end                    23400       6889   -16511 (-70.56%)
profiler-26.bpf.o              handle_mtia_cached_alloc               46892      13870   -33022 (-70.42%)
profiler-26.bpf.o              handle_mtia_allocate_enter             46953      13931   -33022 (-70.33%)
profiler-12.bpf.o              sched_switch                           40257      12105   -28152 (-69.93%)
profiler-26.bpf.o              handle_pytorch_malloc                  47245      14223   -33022 (-69.90%)
profiler-19.bpf.o              oncpu                                  23689       7178   -16511 (-69.70%)
profiler-12.bpf.o              on_task_enqueued                       23734       7223   -16511 (-69.57%)
profiler-12.bpf.o              sched_waking                           23769       7258   -16511 (-69.46%)
profiler-12.bpf.o              on_task_dequeued                       23909       7398   -16511 (-69.06%)
profiler-12.bpf.o              on_request_context_event               24000       7489   -16511 (-68.80%)
profiler-12.bpf.o              on_pytorch_event                       24001       7490   -16511 (-68.79%)
profiler-12.bpf.o              on_task_stats                          24083       7572   -16511 (-68.56%)
profiler-12.bpf.o              oncpu                                  24187       7676   -16511 (-68.26%)
scx_rusty.bpf.o                rusty_init                              8784       3171    -5613 (-63.90%)
profiler-12.bpf.o              get_crochet_walltime_stacks            50215      22063   -28152 (-56.06%)
security-sandbox-13.bpf.o      kvm_die                                 5807       2967    -2840 (-48.91%)
profiler-24.bpf.o              get_task_stacks                       103742      64928   -38814 (-37.41%)
scheduler-01.bpf.o             arena_alloc_mask                       29208      25497    -3711 (-12.71%)
scheduler-03.bpf.o             arena_alloc_mask                       29208      25497    -3711 (-12.71%)
file-system-monitor-01.bpf.o   file_lineage_lsm_file_free             20986      18354    -2632 (-12.54%)
file-system-monitor-01.bpf.o   file_lineage_security_file_free        20986      18354    -2632 (-12.54%)

---
Eduard Zingerman (2):
      bpf: support 32-bit linear scalar evolution
      selftests/bpf: tests for 32-bit scalar evolution bounds computation

 include/linux/bpf_verifier.h                       |   2 +-
 kernel/bpf/scev.c                                  | 364 +++++++++++++++------
 kernel/bpf/verifier.c                              |   6 +-
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 273 +++++++++++++++-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |   2 +-
 5 files changed, 536 insertions(+), 111 deletions(-)
---
base-commit: 25bb03f0a47b622b9025a1558bf2095ec1f55d26
change-id: 20261020-scev-32bit-0bcdd0fd6c34
