Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057922;
	b=agWVpWuI/2Q8h40F4vuJPYHuekSwcjn5z007tJcX8L2m4H2coANCDfGFnV7OG8a6vRPE
	 4Hr7TeVUMsOuKuL2cLTCLhy7H12FjIqufDfYJbIQNt33xKtzxptqeWKPD+QCVPfUq7UDY
	 5XXbfJ7a822vasQncDEO5kAf3YIAiVyB2hA357dB+hYNWZcg3kB63IT7kDCKYjZ8XNp/w
	 POT4mmR7oSAprquAFCcdTvrxgRIWx7Z91Fl2Sw0zOZ6IcESJKfa2Urg4g0gZ/Irq/cCFS
	 K61BFP6I+6Fb/Cxe1KZPYeV/+7Gw+AIEV53/ACgdIZiFiRBWqpzolB5Dk313cAgGqAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:X-Change-ID:
	 Content-Transfer-Encoding;
	bh=6sS5g1uRMzUPP9HTVBf04wupCXwZqnTcFxrTZdCbF5k=;
	b=c64Iop9F0APGcaPwssXrfwQJJ8VaDHwVvpkgH1P1QY9pdIE6uvFvTnTy82tHm8CBAT+8
	 6+6FLvgI53FBvkawN2nD+858lswXGaVYfaNsiJySBLDL8OL8JmmlEzJeyNe4V3FKSMM4Q
	 1yvR+cpe+sxPLAVQclDcII+GIPIPjlnu1WgP6qpTO2Cz5saPQT9Mi5WESHjLVDxiHB2Iz
	 +O3JQkOHEFU058K1hvBZh7z/WYbUIkwLKrChhLo5x8EmFFxZoU9ZbM1OR+gEVkIHEGYGo
	 qLdpg6klwncLnBmd20VSF9s/sjRskzV+TgIZU8JAONPZa/p6z9XIgsd5HLSjnc6umKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwSHwWJY;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E39606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E39606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QwSHwWJY
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3adc4590de4so2415101a91.2
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057921; x=1793662721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6sS5g1uRMzUPP9HTVBf04wupCXwZqnTcFxrTZdCbF5k=;
        b=QwSHwWJYSEeGz6tSLwwKGReo+Jll6TJymLt5Lv/eIUWw8b0i2yX98ah2xtfGJlWHNG
         FZhHKijzqmWnY/X4XR6dNVKbei4ADCpOCFD2lgl59mpYAgLrF+4slhZFYBmx1qCHIJMP
         Q9bvAWanAQE35iFnO0y8rNu9XM6OD6Sx6jDXhzA0h9kD2QLOR0/VqnprsJZ3z8dfgLnG
         ldeY+YUia/4bnuRZI6au2vUrC0oygOD+Pt9+qjfS3KXdxQU1qyPMJhLTGFo9Dxp42e/5
         JF1qwqhgRPijEBOjvNvhBbelnzn2c9VzaJsJoLGUI2d/okcfqKApKwjHAwMOcPn279mD
         eiCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057921; x=1793662721;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6sS5g1uRMzUPP9HTVBf04wupCXwZqnTcFxrTZdCbF5k=;
        b=lgpJV5klVdzZCbZk3/+oLy4MYXItpc3TxHOydoZlANlH61w/27wS/WA/EhPc+f6Yf4
         GlHdPSU2xN2XHcxkJW5g3lc65ghhfOUxDn/k2PZ4PY8ycrY9RBWT8366QPxu22FroaLz
         2NB/55HOV6RWqD1U9pqmWWOn5dmqsGxwaHz+03er71eIT8SFhPRVH4NYdREev5Dbdc8V
         bVJcLNHaxNw3NvnrmlIHCBhVhg8IT9Jopgb21G9XSkSwDXL7pXDYvWb1UetmGo5IC/yB
         hqQEirgBpQ8J5bNO8e3nWY29TOHwILfw4cUWJ33tMd6KiiuDunVsQ0D2ISIlaRXvMi6i
         8Jvg==
X-Gm-Message-State: AFq9FYL+lNEcnk5OOTOA7/Dr440C9cahQT4y1oJwUyedRN9xvJ+MZmIC
	GTwxReUmsMBRkXGIRN0fBQm6uy1HyngcDHrbKb6+FrrMGI7nTXA13VkQ3jjqyw==
X-Gm-Gg: AYBFou2a7rvMyqv/Jw9VirFgg8v28/bGS4VHEdbEdDFVqKIconJa0iR4N5r3U6j92hG
	hJcZV6vaJk2qXAHN9pjFCTT+PPxrFLzasF2YtJr/FhWFWRJoy4Dpt+eCLZGc0Rwuwp8VusZlOpT
	VkJYTZT8cBXZwWTOAvmyFDgZ3yIG6hqVpXUW72x7CRB3OJ0nuvXqXX2lxVn6Ka8OGOocwHOEBrv
	hNswwWR1xoPXMTCFcEvAo/VKkAGMYYk/jsMATOlMr+D/G6WZErjSO9lHPKvVm4nc/fbBws/a/yU
	XJ4dRkQb/tU+2TJuSQwr/XXnm3kitCs56teJRGRiKPGRXUU5oEDHBCaNrLV8jK4xarxq34rFp+1
	vgavdUPYjCtyuITck3Wycvw0xPLOYb9PC7issku2j+saM2H9WtE9+NPRFxmSvl/Jm3CQB9d+8PB
	7O431M4vSF77OrzddjEqJ5tHmum1PnD43b6f06fxWrssGKjGHPCc+Ix1G6u6eLwro0sHBYn+7UD
	E3plboC1zOJCKy/HNYMBG8fCJu5igWRLx371PVoKnBZrnjjGe0RpXw+q8j6FYxPT6Y4X6V93Dba
	KjMSDZ0o7Ds7vWokhSteetE=
X-Received: by 2002:a17:90a:d00e:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3adeaf9857fmr6548885a91.50.1793057921215;
        Mon, 26 Oct 2026 16:38:41 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:40 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 00/11] bpf: fixes and follow-ups for 32-/64-bit scalar evolution
Date: Mon, 26 Oct 2026 16:38:20 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
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
- bpf: avoid false infinite loop reports after changes in SCEV clamping
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

Changelog:
v1 -> v2:
- changed series target to bpf.
- change in the bpf_is_state_visited() to avoid infinite loop
  detection interference for terminating loops.

v1: https://lore.kernel.org/bpf/dc27fabc3f3c7d862c3f2ae583a3650a4d48804d.camel@gmail.com/T/47e07d3ab05
---
Eduard Zingerman (11):
      bpf: reject pointer operands for 32-bit recurrences/latches
      bpf: do not intersect with current register range on clamp
      bpf: avoid false infinite loop reports after changes in SCEV clamping
      bpf: check the iteration count before the predicted exit value
      bpf: (zext32 (zext32 X)) -> (zext32 X) SCEV simplification rule
      bpf: print 32-bit SCEV bounds as 32-bit numbers
      selftests/bpf: pointer operands for 32-bit recurrences/latches
      selftests/bpf: cases with empty range error under old clamping logic
      selftests/bpf: cases for SCEV interaction with infinite loop detection
      selftests/bpf: 32-bit copy of the counter compared at the latch
      selftests/bpf: Restore stack pointer subrange pruning coverage

 include/linux/bpf_verifier.h                       |   1 +
 kernel/bpf/log.c                                   |   8 +
 kernel/bpf/scev.c                                  |  47 ++--
 kernel/bpf/states.c                                |  36 ++-
 tools/testing/selftests/bpf/progs/verifier_scev.c  | 295 ++++++++++++++++++++-
 .../selftests/bpf/progs/verifier_stack_ptr.c       |  30 ++-
 6 files changed, 369 insertions(+), 48 deletions(-)
---
base-commit: 195a3519ff27bff5575e05b5086e38ee92715776
change-id: 20261022-scev-simpler-clamp-4b5486b201d2
