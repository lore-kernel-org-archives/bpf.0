Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A6D3128CF
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775698408; cv=none; b=ZAfVIwblFte2NUe1NbtggJCeEYHw76m992GSMHuqlDyg+YEb9A/TXDDZkiPewifK0I6TU0xWKny2JkE5CFw1Z8u5sqYEAvfr46L8UjjSU+xer5a16p+FPuQoy8jj0QtcSR7POElleUD9bp4bSHON40bCy5dI53Y/HZbXHJAyVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775698408; c=relaxed/simple;
	bh=PGy7ysE4Z/sX2DlaFVflLX44zI+pokplSU8/XQLrnP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gLfw6Rth7FA0xhwoo1pjT5wIRvTWbGCVU7nblv2vieWmhlsUVG6IE2lQ5bfkAFd6tDHiG7dxQymivEXTgyql5h40HS7wxHj5+IopGoYdSObhUFG5mfnUJVYcMSWTebAZJO022+7CM5ZRyl3EyQvFZ0OPexn8EcGKUBVMnrPVfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTSpI9Bz; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTSpI9Bz"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1a170a50so223727c88.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775698403; x=1776303203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33cIFgjAepXFurnFBHzeY6HxjU5bbRuMyGdWXwEg/jA=;
        b=eTSpI9BzcLZc2+4AanSY8D1ys+ap3+oL0i3olGvifVo27duqrUnsU7m+zt3uqH6y6W
         RSN/bUQVl0+j/OWnMRnUtC1P50OxHIQ2H1xjO00TomlxgqFBktKdgo+BV+F1zwCngAIL
         T0my0jCnGrljYN7RasItVqhcmQ6kiPY5ca1P4+64ZqeLsIep0NK7r6yQes+r7/3yv7gp
         FPTA3s18jRg3XmrdgCiQ8dW14K118b2yeBKKW1QH7h5bDxQhGDq0Nbqd+fOfsX3VdLK+
         P86z2Nc0C35WkSFrewQ4PYW8XZHm5l0bv2lxfRrCyFZpc+pw0flqGZjlU3qLT5ySJkWf
         gZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775698403; x=1776303203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33cIFgjAepXFurnFBHzeY6HxjU5bbRuMyGdWXwEg/jA=;
        b=pyfDhriL8/B/YkmTsE5PhO5bWFFvNuW+4N6VxZUmqfp6Ha2UAIe+fuEywr+I2Sh/Ii
         /lvA6KH/A/vIhKhXQsI9401auFwW2wtBtpFe9gfkpGNfBWFk52RqljuNDRVDkGZipHP6
         QmvpO3sXzjkUtBGwOAyAO07xEdEiIaPfTSFkqYNiPRzTi8/GFBuZTruCQMlrAK+xvYRJ
         ZQYkBe7AGyG91KBertbX3SsjmfJ5cjz9jmHTcWIvgQNKHhhjK1/SpWOPW7fc+f6nexu2
         zVyxMEqGsrznVOlLQ+n02L4QGDomoFQLq3+3rtKebQFs+5Ek3Wc3yiL7e+eKtFzRsd4E
         hdgw==
X-Gm-Message-State: AOJu0YyfiqqwhtxWgAc6FhZ77elovoFca0DPKzrYCo45ZYMhZxuh1FiM
	Ufv+KjgBPVu55KipLvXmDv1/uRLse9QyamsB2lKUBSwgkU+vffa6CZ+PP+tRx4kV
X-Gm-Gg: AeBDieuPQIV+1JEL17Aa1UPmfJdGWA/VXVkxI+7TAchd+8/tyLvbM7vcQuk0rNEYVx/
	2ag1NSpCWizAl3VcE1tCJsucoNZyle6/ha07S4ciXNXynTb8bcWbo3Zp1TzIMmNVhpY6u6HkZvi
	VwspVG+yabZVizMh+9P9fQ2IDsxzxcRSbdE8QGDZT6h5tfGa+Hjk3j4rCYuyRFXsTYM3/8gtkod
	JO6imKPXJLHgZaj/dddiAyGMgn82ZC4RyLdtX1wj3PvKqsf6dzxZdhh7OQe202xGdsLEpw91QPv
	97Nx5qGwWJrEwiAwgxu7pcSTg6JXAlO3QUVdnsEPiEomVN+ATR0QHXHJ7CxOndEXAXXWsBtZl2m
	VFy3N/+60fZCNsdNZwn70z4b3mgDv6GVkrHNben+OXih2umRzxRFmdqYckpWUznZJArqX7S4nBK
	bzVXFNPLq8Oa1yKhdDQOi6VlSI5+2803TfKe3dsEeKS7bqdErMPBPTJ5xiS+eDBcUyXJIyTe8hT
	rQ=
X-Received: by 2002:a05:7022:321:b0:119:e55a:9bf6 with SMTP id a92af1059eb24-12bfb73b855mr12564182c88.18.1775698403348;
        Wed, 08 Apr 2026 18:33:23 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::c05])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm15943230c88.3.2026.04.08.18.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 18:33:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 00/14] bpf: static stack liveness data flow analysis
Date: Wed,  8 Apr 2026 18:33:02 -0700
Message-ID: <20260408-patch-set-v1-0-1a666e860d42@gmail.com>
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

Eduard Zingerman (9):
      bpf: share several utility functions as internal API
      bpf: save subprogram name in bpf_subprog_info
      bpf: make liveness.c track stack with 4-byte granularity
      bpf: 4-byte precise clean_verifier_state
      bpf: prepare bpf_liveness api for use by static analysis pass
      bpf: introduce forward arg-tracking dataflow analysis
      bpf: record arg tracking results in bpf_liveness masks
      bpf: simplify liveness to use (callsite, depth) keyed func_instances
      bpf: change logging scheme for live stack analysis

 include/linux/bpf_verifier.h                       |   68 +-
 kernel/bpf/liveness.c                              | 1981 ++++++++++++++----
 kernel/bpf/log.c                                   |    9 +-
 kernel/bpf/verifier.c                              |  259 ++-
 .../selftests/bpf/prog_tests/verifier_log.c        |    6 +-
 .../selftests/bpf/progs/exceptions_assert.c        |    6 +-
 tools/testing/selftests/bpf/progs/uninit_stack.c   |    1 +
 tools/testing/selftests/bpf/progs/verifier_align.c |   10 +-
 .../selftests/bpf/progs/verifier_div_mod_bounds.c  |   18 +-
 .../selftests/bpf/progs/verifier_live_stack.c      | 2191 +++++++++++++++++++-
 .../selftests/bpf/progs/verifier_scalar_ids.c      |   26 +-
 .../selftests/bpf/progs/verifier_spill_fill.c      |   10 +-
 .../bpf/progs/verifier_subprog_precision.c         |    8 +-
 13 files changed, 3978 insertions(+), 615 deletions(-)
---
base-commit: 6a14beefab457f267b8cedc6ac697a9562ec1244
change-id: 20260408-patch-set-29efd8c0f810
