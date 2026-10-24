Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800245;
	b=N4z17KQadmQvindbhvWjk76wM9E7YhnIGxnphu6ohszrkpHh9GPOQoUdOMfIUQjLRND+
	 61fX8I+sx64A+sqJUA//9pYD3AlAgk3drZwNJjWW83Ql0yVL60Y7rS1aSTkael3ZSa7e2
	 2KPHtuVkOWFPnaxBkHyr0uUA2QWfOb/s691Rr/EaWXaJYu8OEw7eQJnrYM38KEgtsFPz8
	 Xzrdw2ATlMk+kxNkeXUm9MKbBQMIfs3L0OdbEKVC5M5ZlVlz+ExmLOdNRHL5NwFJL8Qx3
	 3mE32HHQFnEY6b4jX9ryEzVxKqoXF3qHkkPos1nW0kY+FzVYYGFwRyNQI3EmCSkk9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:
	 Content-Transfer-Encoding;
	bh=0MvOWP8q3jjHxQXzuneqM8MkkyYA2riDTAktDqhG12E=;
	b=tkIxHaL2nJ0UPqQG30LFMmKDy2WWjh5ETb3hqiehPy18DcXvbwtuoXgV8wBYDPF1nGYv
	 Mv66U8fdJKX2tzTc1/KfE1ZGbXa9dxWlI1fNdNYe2wtFAK0M0i4lje1+Ie8wYLQpeOc9E
	 QK/VQJfS6LZUybb/hUss23+WFpYM20LtaBp+AVBS4Jv4HLLgek4PxlvrGHSWeAyRt2+D0
	 RxwT7NRl+Xah7SFCHTTdFRz6KyU2gzuwS9CNZ0A5opNub/FyfzJ+8kt+9iZtFfJg6b7iz
	 8v1pRfd6JZapqvTS7XLSQjfRxkmmPb4xZ9c5me9kaon/U0jj3bdUvcgnRfL7oes0IPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rNwg0eL7;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145A606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B145A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rNwg0eL7
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so539511a12.1
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800244; x=1793405044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0MvOWP8q3jjHxQXzuneqM8MkkyYA2riDTAktDqhG12E=;
        b=rNwg0eL7BCuYoPyTg6K7mT6U64jHT//2BKY5e//mLLIrhYvBvcC3hPMXMkFzIp1fvE
         EAD3+NpBXkaurTe/XI5hZ+uuXOSpkf/iYF65M5cLnp8qc+MSrtrShsrYaTsU7PYAm7Ae
         q+TjT6+B+Erf3TMJ/gyceYyoX1MvEUApbqvBDe9SJ/XIQTrBfx525PxLHPeODzbtGr7z
         nifwHk13Qb4ihkf7nWfmsi9Ln+TK7RHPMnnj+foxt/Ax85nqai5jf+RWlBILZFsNbZsC
         HmGDYmieOsEOqzfA/Pv3SARVRKt8xbBu9rFViAIRxeIH3aRqns3k9zmfCFPl/1GyALX5
         yyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800244; x=1793405044;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0MvOWP8q3jjHxQXzuneqM8MkkyYA2riDTAktDqhG12E=;
        b=yKNDbve9pDPhM9uQ1MdkP9OjtnReOMR3u27V4umKMHJfIo6nviwWu3UjtVYKEzlgvt
         kEjX/dsRNAj27W5Y3D5ROIGluYz81Tidzx7eYvKKwryFi/FSrp1wC1N2rqdlmglZuDI3
         HPU52fDRkgeHR+5RSqV7lYdiQv4rfROpPKtiSoG+yrL7zYFdgtFGUXdSlj1d2bvuJ7QU
         gMRNB5A4mVExbmXl0qrNz8gzgz+pU/lyxDiir2dRDY35IK2SZhBtFf/wE5O/WFrmXwpX
         yWR2yrzUYMPCpjb2LfO7gewHSBXevTG4zdSz64HonMhuLb1bvKwF4JMnsugiIaQBOFby
         b6NQ==
X-Gm-Message-State: AFq9FYIuWHg71fieIQZu0Aa8QFajn7u7RJO+eFqPE1Ukhm12uxbIJzqn
	ZSCy8IMDGj06/aJ2b+0ghKj4KS/Rnu1vHS3g9sY7O4J3p+onIUTuOa1WojEdF2U1
X-Gm-Gg: AYBFou0wdlpLhHF4aLxZfTISXirC/PG7SLWtwToSBNIciIhuHfwty7IXzA1LCSzKEZy
	lNYMT6n9rpsPUdGdsAn8Haak+VowB46csgMtvW8a2tw+rS4TcWGRfmlWDlFiAMmooiN2CuU5KaH
	G6uafy2I6ZztvMnOxxpFRZAs+TVSL0uV5fRhY08p3LP7ZfZ8dsLtpzRSPmEpBi5y6YAl2ua+kMC
	ietZvXAaVX7aZP1PvLqYuAbW76obmYqRp/N87+bIOZgqngjORck+1LTZKHzFY2mwvJJsYeTv+62
	gX9kAk+vejgwCKsh4rcGHXXnklEqFytohjnAr1vZEaoX1NOLML+U/ptrSlt7d0zRDQeC4bkk7ra
	wGSSUFZFtlD/IbNNvI7L83CYCV/R6f3XI71OLwFY1J/dNSEPpOrO8a/2KLHnp5K6p+NWRvXDwPq
	uZEYIye3Q7mmcttu1SSBEuL4+SjLEGJGLmAPc8/xUpMGO2c+iLmtvkPwobQreQZJVopCmbcvih0
	rvdnowVfljl2pf1gBjhdlX4aVZcS11zp6gwftE3rShwnWIav5VYbdlWBkaM90XsVI2y7gUJLdFr
	/eb5fUCv+MNnuJyhyA==
X-Received: by 2002:a17:90a:e705:b0:3aa:fc22:8ab4 with SMTP id 98e67ed59e1d1-3adeafab04fmr587251a91.29.1792800244041;
        Fri, 23 Oct 2026 17:04:04 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:03 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 00/11] bpf: fixes and follow-ups for 32-/64-bit scalar evolution
Date: Fri, 23 Oct 2026 17:03:42 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
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
X-Change-ID: 20261022-scev-simpler-clamp-4b5486b201d2
Content-Transfer-Encoding: 8bit

Fixes:
- bpf: look for current loop in upper frames in states_equal()
- bpf: do not intersect with current register range on clamp
- bpf: reject pointer operands for 32-bit recurrences/latches

Follow-ups:
- bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
- bpf: check the iteration count before the predicted exit value

Note: this supersedes [1].

[1] bpf: reject pointer operands for 32-bit recurrences/latches
    https://lore.kernel.org/bpf/a7b9422e00b9a3f5438e996f01e97bef476040e0.camel@gmail.com/

There are some veristat improvements after clamping changes and new
zext32 simplification rule.

A: master; B: scev-simpler-clamp. Corpora: cilium, meta, scx, selftests.
Object exclusions: verifier_scev.bpf.o.
Histogram: selected programs, without the table filters.

Total progs: 8071
 -85 .. -75  %: 1
 -35 .. -25  %: 3
 -25 .. -20  %: 18
 -20 .. -10  %: 5
 -10 .. 0    %: 13
   0 .. 5    %: 8031

Tables: success in both runs; baseline Insns >= 5,000.
Ranked by percentage change, then instruction-count change, file, program.
Meta names are anonymized; numbered objects are distinct files.

Top wins
--------

File                       Program                            Insns (A)  Insns (B)      Insns (DIFF)
-------------------------  ---------------------------------  ---------  ---------  ----------------
profiler-06.bpf.o          on_perf_event                          94751      64595  -30156 (-31.83%)
profiler-19.bpf.o          sched_switch_offcpu                    21906      15726   -6180 (-28.21%)
profiler-12.bpf.o          sched_switch                           12105       9015   -3090 (-25.53%)
profiler-26.bpf.o          handle_cu_mem_address_reserve          12702       9738   -2964 (-23.33%)
profiler-26.bpf.o          handle_cu_mem_create                   12702       9738   -2964 (-23.33%)
profiler-26.bpf.o          handle_malloc                          12702       9738   -2964 (-23.33%)
profiler-26.bpf.o          handle_cu_mem_map                      12900       9936   -2964 (-22.98%)
profiler-09.bpf.o          on_custom_event_start                  12951       9987   -2964 (-22.89%)
profiler-09.bpf.o          trace_func_entry                       12951       9987   -2964 (-22.89%)
profiler-19.bpf.o          sched_waking                            6642       5160   -1482 (-22.31%)
profiler-27.bpf.o          handle_cuda_launch_exc                  6665       5183   -1482 (-22.24%)
profiler-27.bpf.o          handle_cuda_launch                      6678       5196   -1482 (-22.19%)
profiler-12.bpf.o          on_custom_event_begin                   6885       5403   -1482 (-21.53%)
profiler-12.bpf.o          on_custom_event_end                     6889       5407   -1482 (-21.51%)
profiler-26.bpf.o          handle_mtia_cached_alloc               13870      10906   -2964 (-21.37%)
profiler-26.bpf.o          handle_mtia_allocate_enter             13931      10967   -2964 (-21.28%)
profiler-26.bpf.o          handle_pytorch_malloc                  14223      11259   -2964 (-20.84%)
profiler-19.bpf.o          oncpu                                   7178       5696   -1482 (-20.65%)
profiler-12.bpf.o          on_task_enqueued                        7223       5741   -1482 (-20.52%)
profiler-12.bpf.o          sched_waking                            7258       5776   -1482 (-20.42%)
profiler-12.bpf.o          on_task_dequeued                        7398       5916   -1482 (-20.03%)
profiler-12.bpf.o          on_request_context_event                7489       6007   -1482 (-19.79%)
profiler-12.bpf.o          on_pytorch_event                        7490       6008   -1482 (-19.79%)
profiler-12.bpf.o          on_task_stats                           7572       6090   -1482 (-19.57%)
profiler-12.bpf.o          oncpu                                   7676       6194   -1482 (-19.31%)
profiler-12.bpf.o          get_crochet_walltime_stacks            22063      18973   -3090 (-14.01%)
profiler-24.bpf.o          get_task_stacks                        64928      61154    -3774 (-5.81%)

---
Eduard Zingerman (11):
      bpf: reject pointer operands for 32-bit recurrences/latches
      bpf: do not intersect with current register range on clamp
      bpf: look for current loop in upper frames in states_equal()
      bpf: check the iteration count before the predicted exit value
      bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
      bpf: print 32-bit SCEV bounds as 32-bit numbers
      selftests/bpf: pointer operands for 32-bit recurrences/latches
      selftests/bpf: cases with empty range error under old clamping logic
      selftests/bpf: case reporting infinite loop w/o current_loop() changes
      selftests/bpf: 32-bit copy of the counter compared at the latch
      selftests/bpf: Restore stack pointer subrange pruning coverage

 include/linux/bpf_verifier.h                       |   1 +
 kernel/bpf/log.c                                   |   8 +
 kernel/bpf/scev.c                                  |  47 +++--
 kernel/bpf/states.c                                |  10 +-
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 235 ++++++++++++++++++++-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |  30 +--
 6 files changed, 289 insertions(+), 42 deletions(-)
---
base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
change-id: 20261022-scev-simpler-clamp-4b5486b201d2
