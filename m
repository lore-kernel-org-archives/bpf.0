Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C3C35F603
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157322; cv=none; b=k2jJ0Y+FTHWMEnBwD/ZNq/ftiiMPnhP4Yt4JbXI/ozeynsCuW8+YUCpPCEPuk5nRuN3W0gs4AMIyluzfm6GgsZSiKQEEMHr7gOcB+ANo0MRYUUavn7qnFcTZJh15s4tbPzjIqynM5ZHD5JzKJI3QnV208D/7hd6iU2A729oDpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157322; c=relaxed/simple;
	bh=hIZXReb4G4Y1QNw7SJCa+2ofcrYjvDg3g4cAIclHq+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vD1sViJ9v32uEAGWGWZZ93Yo2Muz7qZ+ZKdX5etoLGRiJsaLPYbKahn/KsILhqBFJiXBmfG/5g3iBdADH6cgTQ/AtFDotqr0rjbSTgUw8tpbzQziz3xt80AvNqNCOBReLNishVJO64q63YKU5nIw0yC4J/YJJ1S8PJ1HJgTcNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxTm1onx; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxTm1onx"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so4314915a91.0
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 15:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777157320; x=1777762120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MbNLpICn5pXNPm56ItIMCLxiIAqRFIdUx8iG0ETiP8w=;
        b=hxTm1onxN81pVNS/p97fASrelDszXP0WBzV7tSXn8ovXFjsiTL2SoBaPrzuqYA0WcQ
         IVR0R68eQnc0BQRY4sDkUskhEtEQQSTPhhO/L3nPvaeA2an9VJX08ciQmKPjRAmmSLyk
         qLZwXRQX0jxCe0l6ltQS0dl8CzuNlPVA4y5ZMXaPy69GDYViM5vv5YBoqBDn6Zqojtzm
         HaJBO8JyW6gGT/Z13LKyq5Jt7OB2KDWgB0f7GPk5iiDR7V1LqZfPJF6GtiS51UVnfDZB
         A5mzGOccugkfYOPXE0PQBt3KzNYGIkP4joPQgSYRny0nFTKZFcbxii1aWQP6o3531Vo2
         Lo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157320; x=1777762120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbNLpICn5pXNPm56ItIMCLxiIAqRFIdUx8iG0ETiP8w=;
        b=Uzsa3vyNVq5JT6JkkwCpN+EZbhCQOPjDpxcVi3JBApcntcHKlbzmarVjn32bqluXcE
         rjnVarOY7PEsZOtNWktQ4AGp5Hkrv227ieEYjTmeQOMJbRljiKGipAUen3eG7PIdRx1G
         VXiAE6SX3NpN4CN1lHXV1FnEFTZwSOLyF+TWHwGqu2rTo7AAM8jll/19si6n85nQ6N6K
         /7UVtnjCgwng3hV2KNZsuZcRQbeJl7+FOL/4lXpp6Sgu136bKr2yEQQRiRr6V+GGm5QY
         3J/PYT66xrALl5HaZNQxFUcfiSswo9OtP2D1vv7GptZohnbxOZeceBkOaKN5RohgVdf0
         ppVg==
X-Gm-Message-State: AOJu0Yz57Vz6ySHZNYugIliwJ/wpjA9wNrpuTAmsN8upmjCrto7e0mof
	0ZqjR6NRkvgPldP0TLPXSEUVml5qy/BTSBTVHtIpC+qxjF9JwDX314IRi/KyB6ww
X-Gm-Gg: AeBDieu2IBnpUxEa1oh0pbiAw3WRITPcHiaZCs5zWT+abEs1pNylN7tLbxj9wpPUuHB
	z8ccvy0JiG/pSupX632S2V02Xwqy1u2bYsVjCtZB9Ro1hrdsuLHaYrJthISh7jQMtjFu4lBFWOC
	ZvN5Uu8fpvLGnKvFor7VZL24es6ITOE8S8v1g7uKzpFKdnUMt77d9wUO9DZglgI7S/9Iubba387
	yoOVOAtlYPm2FQ+IjI/XY1/+9mm9tF2TeXm5Cm3NsEg8nG/Q6sM0E0akuAnVJCLZG8ct404QOHS
	LEzWsUbfVi+rjn7Vh/nCiTAKOyNgeLB4xOa+5GOwcL3UGyqsttLej94qttILMCj5Tyw8zlDgvpN
	hq/zdtoQ1agtN6ZtHkPvdGDsmFL+4LeSyqi0Vjmwzga82I33JLsjsjvywzgZAwHL1jUTtkz9Ph8
	UHzpQc9Cqo8uGdmZRWfETe9iXQxUmCvv62K1abQyU8nixYTTXsg/Z9oK+oce1jG0ULKc690ZdZZ
	HBQZQ==
X-Received: by 2002:a17:90b:3950:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-361404659e2mr36890032a91.16.1777157319839;
        Sat, 25 Apr 2026 15:48:39 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7a9fsm27323615a91.12.2026.04.25.15.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:48:39 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: range_within() must check cnum ranges instead of min/max pairs
Date: Sat, 25 Apr 2026 15:48:22 -0700
Message-ID: <20260425-cnum-range-within-v1-0-2fdca70cb09d@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260425-cnum-range-within-4a755ba81e93
Content-Transfer-Encoding: 8bit

This is a follow-up for series [1].
is_state_visited() should check cnum's subset relations using
cnum-based operations, not min/max projections. See patch #1 for
detailed explanation and patch #2 for an example of buggy program
accepted by verifier w/o this fix.

Updated veristat performance numbers compared to master before [1]
merge follow. Measurements done for the same set of selftests/
sched_ext/meta/cilium programs as in [1].

Net increase:   98K insn 88 programs
Net decrease: -282K insn 52 programs

Raw stats filtered as -f insns_pct>1 -f !insns<10000:

========= selftests: master vs experiment =========

File  Program  Insns (A)  Insns (B)  Insns (DIFF)
----  -------  ---------  ---------  ------------

Total progs: 4665
total_insns diff min:   -0.44%
total_insns diff max:   52.94%
total_insns abs max old: 837,487
total_insns abs max new: 837,487
  -5 .. 0    %: 8
   0 .. 5    %: 4652
   5 .. 15   %: 1
  40 .. 50   %: 3
  50 .. 55   %: 1

========= scx: master vs experiment =========

File               Program          Insns (A)  Insns (B)  Insns     (DIFF)
-----------------  ---------------  ---------  ---------  ----------------
scx_layered.bpf.o  layered_enqueue      13718      14402     +684 (+4.99%)
scx_rusty.bpf.o    rusty_enqueue        39842      22053  -17789 (-44.65%)
scx_rusty.bpf.o    rusty_stopping       37738      19949  -17789 (-47.14%)
scx_wd40.bpf.o     wd40_stopping        37729      19880  -17849 (-47.31%)

Total progs: 376
total_insns diff min:  -47.31%
total_insns diff max:   19.61%
total_insns abs max old: 233,669
total_insns abs max new: 233,696
 -50 .. -40  %: 3
  -5 .. 0    %: 3
   0 .. 5    %: 367
   5 .. 15   %: 2
  15 .. 20   %: 1

========= meta: master vs experiment =========

File                                    Program              Insns (A)  Insns (B)  Insns     (DIFF)
--------------------------------------  -------------------  ---------  ---------  ----------------
<sandbox>                               test_file_open           88771     104160  +15389 (+17.34%)
<profiler>                              on_perf_event            48056      54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059      54547   +6488 (+13.50%)
<profiler>                              on_perf_event            48056      54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059      54547   +6488 (+13.50%)
<profiler>                              on_alloc                 50445      56933   +6488 (+12.86%)
<profiler>                              on_free                  50251      56739   +6488 (+12.91%)
<profiler>                              on_perf_event            48056      54544   +6488 (+13.50%)
<profiler>                              on_tracepoint_event      48059      54547   +6488 (+13.50%)
<profiler>                              future_iter_resume       50114      56602   +6488 (+12.95%)
<profiler>                              on_py_event              50042      56530   +6488 (+12.97%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13287      13963     +676 (+5.09%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13269      13945     +676 (+5.09%)
scx_layered_bpf_skel_genskel-bpf.bpf.o  layered_enqueue          13269      13945     +676 (+5.09%)
<firewall>                              ..._egress              222327     164648  -57679 (-25.94%)
<firewall>                              ..._tc_eg               222839     164772  -58067 (-26.06%)
<firewall>                              ..._egress              222327     164648  -57679 (-25.94%)
<firewall>                              ..._tc_eg               222839     164772  -58067 (-26.06%)

Total progs: 1540
total_insns diff min:  -26.06%
total_insns diff max:   37.25%
total_insns abs max old: 666,036
total_insns abs max new: 666,036
 -30 .. -20  %: 4
  -5 .. 0    %: 10
   0 .. 5    %: 1494
   5 .. 10   %: 10
  10 .. 15   %: 13
  15 .. 25   %: 5
  35 .. 40   %: 4

========= cilium: master vs experiment =========

File             Program                            Insns (A)  Insns (B)  Insns    (DIFF)
---------------  ---------------------------------  ---------  ---------  ---------------
bpf_host.o       tail_handle_ipv4_cont_from_host        20962      26024  +5062 (+24.15%)
bpf_host.o       tail_handle_ipv6_cont_from_host        17036      18672   +1636 (+9.60%)
bpf_host.o       tail_nodeport_nat_ingress_ipv4         20080      19858    -222 (-1.11%)
bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         10697      10510    -187 (-1.75%)
bpf_overlay.o    tail_handle_inter_cluster_revsnat      11099      10857    -242 (-2.18%)
bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         11951      11768    -183 (-1.53%)
bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         11993      11811    -182 (-1.52%)

Total progs: 134
total_insns diff min:   -3.32%
total_insns diff max:   24.15%
total_insns abs max old: 152,012
total_insns abs max new: 152,012
  -5 .. 0    %: 12
   0 .. 5    %: 120
   5 .. 15   %: 1
  20 .. 25   %: 1

[1] https://lore.kernel.org/bpf/fd376f47b9512daf669a87b23573f614ec146385.camel@gmail.com/T/

---
Eduard Zingerman (2):
      bpf: range_within() must check cnum ranges instead of min/max pairs
      selftests/bpf: a test for proper cnums compare in is_state_visited()

 include/linux/cnum.h                               |  2 ++
 kernel/bpf/cnum_defs.h                             | 14 +++++++++++
 kernel/bpf/states.c                                | 11 +++------
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 27 ++++++++++++++++++++++
 4 files changed, 46 insertions(+), 8 deletions(-)
---
base-commit: 6c60b2dd5a7889a583389e95e79689191206f86f
change-id: 20260425-cnum-range-within-4a755ba81e93
