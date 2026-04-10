Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13942D5C8E
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783507; cv=none; b=BkJwpKkxywZ7WC5K62/e8LB9mgrKqF+gXmNn2MPANEFNxI4nDQsMSwws5zQCXkvydQlLrm61HouVP+MMVjB/n/2LOIPiyiarsN3GrZ46c9YRU6S/CqfX0nATOIsvRmLWAGICxqt7gZCzugWPKk3y3vStRSTvnFeZbgHHYrlitbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783507; c=relaxed/simple;
	bh=6bInoKc0+DriuvC9uuFJ+QBzggfre5nxDa2p2QCFK14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P5lIZqn/kgKiUhSwXLPrSk70sz+zPp/OMHNtKLGfhIIqZk9raDrk2M2QzNWZgKMqlISVDP/LPSvWaHRzIof/Jdma3EHNemvpNPMCpb0X7ejeJzXetEGt/LnyXCdsNIEWpM9BObzrN9HKUZZt7eC+Fl0mOv07s8epnRMxaEem35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8gjP36o; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8gjP36o"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so3125573eec.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783505; x=1776388305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuyWJJ2aKSh6GNzUW/8QOGWQP7XUv5L92UlL/CXqotc=;
        b=L8gjP36o4ffWbwAgDLneQrT5qLEJRXlSVjnHtFcOEVZJZUVNzswMDsw7DV5OpMsxP7
         pCdRd4D6D/w0/8sG0p9Cna9/vJP3gh3cFUGj6QfTxhN0Kd0UNalrSrYbp9FAlcAyqIuO
         Q9UfHKh0llDVu7gTtzTO+eabjP1XHrEzJuRqRj8MBSTEq/fVvjdh/H0jlDctJGtczY4l
         xUroRsFfzoUvgcFtTk6NRS7n9WcbNeZNEKN+psiJ7l8WvjvjcSTrdNgsnqhrHcX1rfxG
         ddUafXQtv/Fdd44DpUo8jqSlJZPdiZKJk6GYSY82B1kZgOrPh97b6Gb+TZWRaay6QBbx
         kXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783505; x=1776388305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuyWJJ2aKSh6GNzUW/8QOGWQP7XUv5L92UlL/CXqotc=;
        b=ExPIoRux1aCqM3XiMDIUWa3hMkyzk8skQ/7oMKVXgMsXF2bmi0sCq3taEffK/wpAOs
         G9kvxj09nirKyAUL29mOVV/OPqePC79hCVSC//xJ2GYOR60RsCSCxiER+ApBqwrpsrvV
         rR0LzJh6RDj3rVn3pf62eCl/R9SSoP0auXqAl3g9UF8QfOWelAFMLB+I1ZfyxQwbZlXq
         p332OhteKm6VOGMbLFAFTpYBgkm93yGfmI39HhsvmvJxLFkGGzPDrUc+3bf81i1Z2ufk
         xkkpbsfQoFFn3jWqnoqKoUKtbjzHbFYcRBmzTzizvX4yNFstzPERq39JYvgZWYtaH9FU
         um5w==
X-Gm-Message-State: AOJu0Yz5iFiDyP8YUv/kDFVUYxqtY5ROS0QOAznsu6maktiSbwzZxf5U
	Ny+YpN4KEFvKT2hBqDATtXcOKmcPdM8ZqxG971nXRb755Xwy8VyXGBx28DYl/KnQ
X-Gm-Gg: AeBDievelne/GC8m5erbElAdEemN3KKwtqbaGlmEVaUAfImZ7hLQevB+ZweD/Ei1i8c
	htzKyFxkAbc2+9WutkDv1equ4/JzoFkNBzdcyDoHwODg0k6LOMC0BwJdztxzoeiefGzLkqJc6lo
	3D8gnFEqT4Xs17qaFvBPAKDX4gXn7rTOR3BkVyYO9tSWPZTe+VTrqNLh29tlWfIFkEdP9HDX5wA
	2q59XA0QiQypUmVkzyFW2L4VM5Gq2vXOZoh2DCC4QMPz5MmBdLkL4xFjeP2yAp9tPckyl+KCuY3
	XRlZQzwIWZj1NzW7Z4PW7F+0CQBK4T/zMz5hibj3i2La8vA+ykQGnz1fcDJ9zcOPSFi/BNMULLN
	vML2v/dIoZ6tMFVzSb0zFUkV/zxaG3MKIAkCi0sJJNAVwLjfhCcZNieqCE3qeiU+xQiOF+4vNug
	juJYU0/lOBJbiy/y4X7J0iLOszeN+sKln0m4iMbQql+rcJ7niQ0Sz+D0ZrH9H1cuIcf3rUzM0mW
	NCXBneeyxhfzM40Zg==
X-Received: by 2002:a05:7300:7b86:b0:2c6:7f49:a85d with SMTP id 5a478bee46e88-2d5898aa2femr751532eec.22.1775783504476;
        Thu, 09 Apr 2026 18:11:44 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 00/13] bpf: static stack liveness data flow analysis
Date: Thu,  9 Apr 2026 18:11:19 -0700
Message-ID: <20260409-patch-set-v2-0-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260408-patch-set-29efd8c0f810
Content-Transfer-Encoding: 8bit

This patch set converts current dynamic stack slot liveness tracking
mechanism to a static data flow analysis. The result is used during
state pruning (clean_verifier_state): to zero out dead stack slots,
enabling more aggressive state equivalence and pruning. To improve
analysis precision live stack slot tracking is converted to 4-byte
granularity.

The key ideas and the bulk of the execution behind the series belong
to Alexei Starovoitov. I contributed to patch set integration
with existing liveness tracking mechanism.

Due to complexity of the changes the bisectability property of the
patch set is not preserved. Some selftests may fail between
intermediate patches of the series.

Analysis consists of two passes:
- A forward fixed-point analysis that tracks which frame's FP each
  register value is derived from, and at what byte offset. This is
  needed because a callee can receive a pointer to its caller's stack
  frame (e.g. r1 = fp-16 at the call site), then do *(u64 *)(r1 + 0)
  inside the callee - a cross-frame stack access that the callee's
  local liveness must attribute to the caller's stack.
- A backward dataflow pass within each callee subprog that computes
  live_in = (live_out \ def) ∪ use for both local and non-local
  (ancestor) stack slots. The result of the analysis for callee is
  propagated up to the callsite.

The key idea making such analysis possible is that limited and
conservative argument tracking pass is sufficient to recover most of
the offsets / stack pointer arguments.

Changelog:
v1 -> v2:
  liveness.c:
  - Removed func_instance->callsites and replaced it with explicit
    spine passed through analys_subprog() calls (sashiko).
  - Fixed BPF_LOAD_ACQ handling in arg_track_xfer: don't clear dst
    register tracking (sashiko).
  - Various error threading nits highlighted by bots
    (sashiko, bot+bpf-ci).
  - Massaged fmt_spis_mask() to be more concise (Alexei)

  verifier.c:
  - Move subprog_info[i].name assignment from add_subprog_and_kfunc to
    check_btf_func (sashiko, bot+bpf-ci).
  - Fixed inverse usage of msb/lsb halves by patch
    "bpf: make liveness.c track stack with 4-byte granularity"
    (sashiko, bot+bpf-ci).

v1: https://lore.kernel.org/bpf/20260408-patch-set-v1-0-1a666e860d42@gmail.com/

Verification performance impact:

========= selftests: master vs patch-set =========

File                     Program        Insns (A)  Insns (B)  Insns    (DIFF)
-----------------------  -------------  ---------  ---------  ---------------
xdp_synproxy_kern.bpf.o  syncookie_tc       20363      22910  +2547 (+12.51%)
xdp_synproxy_kern.bpf.o  syncookie_xdp      20450      23001  +2551 (+12.47%)

Total progs: 4490
Old success: 2856
New success: 2856
total_insns diff min:  -80.26%
total_insns diff max:   12.51%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 837,487
total_insns abs max new: 837,487
 -85 .. -75  %: 1
 -50 .. -40  %: 1
 -35 .. -25  %: 1
 -20 .. -10  %: 5
 -10 .. 0    %: 18
   0 .. 5    %: 4458
   5 .. 15   %: 6

========= scx: master vs patch-set =========

File            Program    Insns (A)  Insns (B)  Insns   (DIFF)
--------------  ---------  ---------  ---------  --------------
scx_qmap.bpf.o  qmap_init      20230      19022  -1208 (-5.97%)

Total progs: 376
Old success: 351
New success: 351
total_insns diff min:  -27.15%
total_insns diff max:    0.50%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 236,251
total_insns abs max new: 233,669
 -30 .. -20  %: 8
 -20 .. -10  %: 2
 -10 .. 0    %: 21
   0 .. 5    %: 345

========= meta: master vs patch-set =========

File                                                                                       Program                        Insns (A)  Insns (B)  Insns      (DIFF)
-----------------------------------------------------------------------------------------  -----------------------------  ---------  ---------  -----------------
...
third-party-scx-backports-6.9-1.0.13.1-scheds-rust-scx_layered-bpf_skel_genskel-bpf.bpf.o  layered_dispatch                   13944      13104      -840 (-6.02%)
third-party-scx-backports-6.9-1.0.13.2-scheds-rust-scx_layered-bpf_skel_genskel-bpf.bpf.o  layered_dispatch                   13944      13104      -840 (-6.02%)
third-party-scx-gefe21962f49a-__scx_layered_bpf_skel_genskel-bpf.bpf.o                     layered_dispatch                   13825      12985      -840 (-6.08%)
third-party-scx-v1.0.16-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_enqueue                       15501      13602    -1899 (-12.25%)
third-party-scx-v1.0.16-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_select_cpu                    19814      16231    -3583 (-18.08%)
third-party-scx-v1.0.17-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_enqueue                       15501      13602    -1899 (-12.25%)
third-party-scx-v1.0.17-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_select_cpu                    19814      16231    -3583 (-18.08%)
third-party-scx-v1.0.17-__scx_layered_bpf_skel_genskel-bpf.bpf.o                           layered_dispatch                   13976      13151      -825 (-5.90%)
third-party-scx-v1.0.18-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_dispatch                     260628     237930    -22698 (-8.71%)
third-party-scx-v1.0.18-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_enqueue                       13437      12225     -1212 (-9.02%)
third-party-scx-v1.0.18-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                              lavd_select_cpu                    17744      14730    -3014 (-16.99%)
third-party-scx-v1.0.19-10-6b1958477-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                 lavd_cpu_offline                   19676      18418     -1258 (-6.39%)
third-party-scx-v1.0.19-10-6b1958477-__scx_lavd_bpf_skel_genskel-bpf.bpf.o                 lavd_cpu_online                    19674      18416     -1258 (-6.39%)
...

Total progs: 1540
Old success: 1492
New success: 1493
total_insns diff min:  -75.83%
total_insns diff max:   73.60%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 434,763
total_insns abs max new: 666,036
 -80 .. -70  %: 2
 -55 .. -50  %: 7
 -50 .. -45  %: 10
 -45 .. -35  %: 4
 -35 .. -25  %: 4
 -25 .. -20  %: 8
 -20 .. -15  %: 15
 -15 .. -10  %: 11
 -10 .. -5   %: 45
  -5 .. 0    %: 112
   0 .. 5    %: 1316
   5 .. 15   %: 2
  15 .. 25   %: 1
  25 .. 35   %: 1
  55 .. 65   %: 1
  70 .. 75   %: 1

========= cilium: master vs patch-set =========

File             Program                            Insns (A)  Insns (B)  Insns     (DIFF)
---------------  ---------------------------------  ---------  ---------  ----------------
bpf_host.o       cil_host_policy                        45801      32027  -13774 (-30.07%)
bpf_host.o       cil_to_netdev                         100287      69042  -31245 (-31.16%)
bpf_host.o       tail_handle_ipv4_cont_from_host        60911      20962  -39949 (-65.59%)
bpf_host.o       tail_handle_ipv4_from_netdev           59735      33155  -26580 (-44.50%)
bpf_host.o       tail_handle_ipv6_cont_from_host        23529      17036   -6493 (-27.60%)
bpf_host.o       tail_handle_ipv6_from_host             11906      10303   -1603 (-13.46%)
bpf_host.o       tail_handle_ipv6_from_netdev           29778      23743   -6035 (-20.27%)
bpf_host.o       tail_handle_snat_fwd_ipv4              61616      67463    +5847 (+9.49%)
bpf_host.o       tail_handle_snat_fwd_ipv6              30802      22806   -7996 (-25.96%)
bpf_host.o       tail_ipv4_host_policy_ingress          20017      10528   -9489 (-47.40%)
bpf_host.o       tail_ipv6_host_policy_ingress          20693      17301   -3392 (-16.39%)
bpf_host.o       tail_nodeport_nat_egress_ipv4          16455      13684   -2771 (-16.84%)
bpf_host.o       tail_nodeport_nat_ingress_ipv4         36174      20080  -16094 (-44.49%)
bpf_host.o       tail_nodeport_nat_ingress_ipv6         48039      25779  -22260 (-46.34%)
bpf_lxc.o        tail_handle_ipv4                       13765      10001   -3764 (-27.34%)
bpf_lxc.o        tail_handle_ipv4_cont                  96891      68725  -28166 (-29.07%)
bpf_lxc.o        tail_handle_ipv6_cont                  21809      17697   -4112 (-18.85%)
bpf_lxc.o        tail_ipv4_ct_egress                    15949      17746   +1797 (+11.27%)
bpf_lxc.o        tail_nodeport_nat_egress_ipv4          16183      13432   -2751 (-17.00%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         18532      10697   -7835 (-42.28%)
bpf_overlay.o    tail_handle_inter_cluster_revsnat      15708      11099   -4609 (-29.34%)
bpf_overlay.o    tail_handle_ipv4                      105672      76108  -29564 (-27.98%)
bpf_overlay.o    tail_handle_ipv6                       15733      19944   +4211 (+26.77%)
bpf_overlay.o    tail_handle_snat_fwd_ipv4              19327      26468   +7141 (+36.95%)
bpf_overlay.o    tail_handle_snat_fwd_ipv6              20817      12556   -8261 (-39.68%)
bpf_overlay.o    tail_nodeport_nat_egress_ipv4          16175      12184   -3991 (-24.67%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         20760      11951   -8809 (-42.43%)
bpf_wireguard.o  tail_handle_ipv4                       27466      28909    +1443 (+5.25%)
bpf_wireguard.o  tail_nodeport_nat_egress_ipv4          15937      12094   -3843 (-24.11%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         20624      11993   -8631 (-41.85%)
bpf_xdp.o        tail_lb_ipv4                           42673      60855  +18182 (+42.61%)
bpf_xdp.o        tail_lb_ipv6                           87903     108585  +20682 (+23.53%)
bpf_xdp.o        tail_nodeport_nat_ingress_ipv4         28787      20991   -7796 (-27.08%)
bpf_xdp.o        tail_nodeport_nat_ingress_ipv6        207593     152012  -55581 (-26.77%)

Total progs: 134
Old success: 134
New success: 134
total_insns diff min:  -65.59%
total_insns diff max:   42.61%
0 -> value: 0
value -> 0: 0
total_insns abs max old: 207,593
total_insns abs max new: 152,012
 -70 .. -60  %: 1
 -50 .. -40  %: 7
 -40 .. -30  %: 9
 -30 .. -25  %: 9
 -25 .. -20  %: 12
 -20 .. -15  %: 7
 -15 .. -10  %: 14
 -10 .. -5   %: 6
  -5 .. 0    %: 16
   0 .. 5    %: 42
   5 .. 15   %: 5
  15 .. 25   %: 2
  25 .. 35   %: 2
  35 .. 45   %: 2

---
Alexei Starovoitov (5):
      bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
      selftests/bpf: update existing tests due to liveness changes
      selftests/bpf: adjust verifier_log buffers
      selftests/bpf: add new tests for static stack liveness analysis
      bpf: poison dead stack slots

Eduard Zingerman (8):
      bpf: share several utility functions as internal API
      bpf: save subprogram name in bpf_subprog_info
      bpf: make liveness.c track stack with 4-byte granularity
      bpf: 4-byte precise clean_verifier_state
      bpf: prepare bpf_liveness api for use by static analysis pass
      bpf: introduce forward arg-tracking dataflow analysis
      bpf: simplify liveness to use (callsite, depth) keyed func_instances
      bpf: change logging scheme for live stack analysis

 include/linux/bpf_verifier.h                       |   63 +-
 kernel/bpf/liveness.c                              | 1991 ++++++++++++++----
 kernel/bpf/log.c                                   |    9 +-
 kernel/bpf/verifier.c                              |  267 ++-
 .../selftests/bpf/prog_tests/verifier_log.c        |    6 +-
 .../selftests/bpf/progs/exceptions_assert.c        |    6 +-
 tools/testing/selftests/bpf/progs/uninit_stack.c   |    1 +
 tools/testing/selftests/bpf/progs/verifier_align.c |   10 +-
 .../selftests/bpf/progs/verifier_div_mod_bounds.c  |   18 +-
 .../selftests/bpf/progs/verifier_live_stack.c      | 2217 +++++++++++++++++++-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   26 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   10 +-
 .../bpf/progs/verifier_subprog_precision.c         |    8 +-
 13 files changed, 4013 insertions(+), 619 deletions(-)
---
base-commit: 6a14beefab457f267b8cedc6ac697a9562ec1244
change-id: 20260408-patch-set-29efd8c0f810
