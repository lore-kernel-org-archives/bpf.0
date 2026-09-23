Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97215328AD
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190706; cv=none; b=jVWK0Q80+/e2nc6fVUFD98mMZCQT1dDa06fd+I++EOOgSOsWvynrDdIwRV/usUBsq0vgVmMhN9Ugcd7zSZMalfdWyVwZJLTRvbPnNHgWjMdWCb/9TQp1cSVV8rsFOMAbN/DoSI0zQ4Vm3SwG7CYdACF0fmkb6vbESYemNZRO3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190706; c=relaxed/simple;
	bh=TAPKAL2Eo7nAyEnxL2O5WR/UawbrjeY7f2eUkQ4h4og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyWvFhC1p2JJA3J51HGk8WOf2kkoBIzqX/Z4PjoO/yOcbQrXR8/M8+vaUGfo1ZmgI9op32yNms5MUfLihlbn7vWovimbFgfSih6A2/0IEfVedYx1lUYd29klDSXCcWsnKn4KB2ii49C3+q4VkO/O1Y187/uhGOlBp1EQbm3GsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maOMp1ef; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maOMp1ef"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so368832f8f.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190702; x=1790795502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ms/rWu8RaoMUMzQd6eTodIQutk/LvSGU9t8EyM/qwxY=;
        b=maOMp1efj3VefFW7SsUQZDlFYH4aJDj5oZUjdVjJvlM2jkKbrkjMV/H1rnIELFA/qN
         iH4DIvGCAn2cTEg+4VYALkydt2R2S90SZm+Pl4cn50ObjO/entdMnOF46KDE7ObhHbYz
         WZ5nRsqxxB8MAYHwIf4aS0LuP5uWFCgwd2SoS2S8m44m1ch5WuKLt4eeUF75ofNyAxDw
         1f8QFgXkU0fM9vrPESNfBNGIoNNA0MTn8ZrFhWct12iQtP937fPRsPzN15338jAwEtJG
         ssVotnHMQ001AdhPAM88OfnYY6hB/HGbCe9b5oqw1g291bqDtzjX12PzhxPGM2ippowC
         6Tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190702; x=1790795502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ms/rWu8RaoMUMzQd6eTodIQutk/LvSGU9t8EyM/qwxY=;
        b=TLaR3vx4CyKXuDf9UXDJm3j2QG4XW1VqMiYjYuJB0gBEMlR+aH79QptEUzVQdVcYSN
         9n/RZOF6r/0xRli9ENGiznzDJNps4B1FN9j2MZQSNdceeT4/U+Jjp4qHpTXEB1LwfRIL
         2+A1Q1fDkLDX8gZPN/mVWO79bTIIwXM3vi5qoMTFlOu8rvp9nKMaPFYp9Tj9y6F6cdRu
         tVk9sg8AG9WxtwzYDAoke+07AL1YL9mXgJ2dE1Ym9nWrlB0Y/I/xm+ncVR99bwrCALTH
         ZKJYaz1ycotPhD6ko9xkT6x1vCORWCQvLWsVqMMdnO3mU+dSbnrZ2A4kqLu4E8b1v8zq
         4Q6g==
X-Gm-Message-State: AFuF++kTyF/VRjY+1uzulGPHfhdOvNgZoM/kVEfdDzF8ZCKHQGVBGJBR
	0YdvcC9XslaPO2k8vDlh5U0TwSbikQWqwHjludJ0nff6JrV0C6/MDNdJ3rCYXJh7
X-Gm-Gg: AYBFou2q7939QcwDCg+VyYQZUcL0FmZm/b/5qbvkFrx8CLboCjVvtowdX3cYbpbLH6m
	85Dc26mvJryFvDLCHu8BRLrM4K7poXpFO0bkOf6Jbdt3bLYJt3Vt64OdOkgRl93zjzNvW8eF2RK
	HYSPEE9ftipDMJPsCkcVSh1L63KXAF0PBCHzEp2C7s1FOGaXftcg+RgDKLFSR1oR4J4oSIDsDen
	LO2xhDHDisAlYj66V9lGOxyB/pv0xKHZd+N7ATdn6F3GNvUp/XXIU1SvF+p2IFXV9uwiSURMIwi
	3lNFQaRFng6aArpRVNwN7F6kwFqN2kWvs+vLBte+k3z9Z9EE2HSBOtmRD2C6g1KpPPsmXLsn6b6
	1OVAlR+VGgNMgfhbU+aQnZO6JoiIkY0gkFc01SxISO5wNYR61H92GfZsMgAH6jEI/iFdnODfNv8
	OUyV4uVdKy0dM6Qap/UiV3NG7oS+PvyOBaYrKzAcZrsr/dP4S9G/Go+O8bEbVn+92P2Y6LuBgrs
	S+5YUeqq0ZgLKdkSYgeBrtwCPgVRJSTztbmD3KMk7xddrM5E0LFB9qto8Y1i5y816jfJ7EYTB3f
	7MQGtcc39RJuYJ3htmp1BkkziEofM4MVdxNucQ==
X-Received: by 2002:a05:600c:c16d:b0:49f:cac3:c68a with SMTP id 5b1f17b1804b1-49fe66f9ff1mr2330075e9.31.1790190701481;
        Wed, 23 Sep 2026 12:11:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889409sm7330546f8f.35.2026.09.23.12.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:11:40 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/18] Raise BPF program stack size to 2KiB
Date: Wed, 23 Sep 2026 21:11:07 +0200
Message-ID: <20260923191139.2816206-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8308; i=memxor@gmail.com; h=from:subject; bh=TAPKAL2Eo7nAyEnxL2O5WR/UawbrjeY7f2eUkQ4h4og=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4ucD3+PaHY4xe/nO4upqDk8OPD/v7QTOa9HGv8K2u tglrajuKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQCrzH8s1ybFKlrfTOEpY/V 9vKalzu1JA8Yf5lr/zzyMyvLLG1bG4b/ZXd/Kd2/ciBk7vel93xYNkVmlRueZQxem2/csDDHfLE eFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF programs get 512 bytes of stack. This series raises that to 2 KiB
on x86-64 and arm64. The budget covers a whole call chain, or each frame
on a private stack, and a single function may use all of it. The
interpreter, offloaded programs and the other JITs keep 512 bytes.

The x86-64 and arm64 JITs do not depend on 512-byte frames: both encode
frame sizes in wide enough immediates, and on both a tail call pops the
caller's frame and lands in the target's prologue before the target sets
up its own.

The verifier needs several changes, however. Its bookkeeping assumes at
most 64 slots per frame: the jump history and linked register records
carry 6-bit slot indexes, backtracking and the scratched-slot log keep
one u64 per frame, the id map is sized for 64 slots per frame, and
liveness keeps three fixed 128-bit masks per instruction per frame.
Growing all of this fourfold would make every program pay for stack
limits that most program will not exercise. Therefore, some dynamicity
is needed without blowing verifier memory usage out of proportion.

The series first removes these assumptions without changing what
verifies (patches 1-8). The liveness masks become bitmaps as wide as the
stack a frame actually uses, and the id scratch grows on demand. It then
adds a per-program budget, bpf_prog_stack_limit(): 2 KiB when the
program is JITed, not offloaded, and the JIT reports
bpf_jit_supports_large_stack() along with tail calls from subprograms,
and 512 bytes otherwise. Finally, it turns the budget on for x86-64 and
arm64.

Tail calls need no separate limit. A tail call pops the frame that makes
it, and the frames its callers leave behind are still limited to 256
bytes by the existing rule for tail calls from subprograms. Only the
final program's frame in a tail call chain grows, from 512 bytes to 2
KiB, so the chain's worst-case kernel stack use grows from about 8.5 KiB
to about 10 KiB. The budget does not depend on privilege: an
unprivileged program cannot call other BPF functions, so its tail calls
leave no frame behind and its worst case is a single 2 KiB frame.

Memory was measured as the peak kernel memory allocated during each
BPF_PROG_LOAD, for all 5075 loadable selftest programs, against bpf-next
at 79dc258c9392. "Total" is the sum of the per-program peaks. Two runs of
one kernel agree to 0.01% in total; a handful of small programs differ by
one 64 KiB allocation between runs, and those one-off jumps are left out
of the per-program rows.

                                      patches 1-8   whole series
  total                                  -0.72%        -0.51%
    4940 programs under 1 MiB            -0.32%        -0.14%
     116 programs of 1-16 MiB            -0.58%        +0.23%
      19 programs of 16 MiB or more      -1.10%        -1.05%
  median program                          0.0%          0.0%
  programs growing by more than 5%          7            56
  largest increase                        +16%		+19%
  largest decrease                       -5.0%         -5.0%

The savings come from liveness: a frame within 256 bytes needs 24 bytes
of masks per instruction instead of 48. The largest are pyperf600
(-5.2 MiB, -2.0%), pyperf180 (-3.2 MiB, -2.8%), pyperf100 (-2.8 MiB,
-3.1%) and test_verif_scale2 (-1.0 MiB, -5.0%).

The increases have two causes:

 * history: the jump history entry grows from 16 to 20 bytes, which
   penalizes loop-heavy programs. This is already present in patches 1-8.
 * masks: a frame read as a whole through a pointer of unknown offset
   keeps liveness masks as wide as the 2 KiB budget. This appears only
   once the budget is raised.

The largest absolute increases for the whole series (peak in MiB):

  program                                   before  after   MiB      %  cause
  loop1/nested_loops                          17.6   19.2  +1.5    +9%  history
  strobemeta_bpf_loop/on_event                10.5   11.8  +1.3   +12%  masks
  verifier_loops1/jumps_out_rather_than_in     4.4    5.1  +0.7   +16%  history
  pyperf600_bpf_loop/on_event                  5.6    6.3  +0.7   +12%  masks
  pyperf600_nounroll/on_event                 80.3   80.9  +0.6    +1%  history
  strobemeta_nounroll2/on_event               44.5   45.1  +0.6    +1%  both
  strobemeta/on_event                        201.8  202.4  +0.5  +0.3%  history
  test_tcp_custom_syncookie                   10.8   11.2  +0.4    +4%  masks
  strobemeta_nounroll1/on_event               20.9   21.3  +0.4    +2%  both
  linked_list/global_list_push_pop_multiple    5.0    5.4  +0.3    +6%  history

The largest relative increases are small programs whose frame is read as
a whole, each growing by 50 to 110 KiB: verifier_bitfield_write +15 to
19%, test_tc_tunnel +13 to 15% and dynptr_success +12%.

In terms of verification time, the changes are within margin of error.

For more details, please see the individual commits.

Kumar Kartikeya Dwivedi (18):
  bpf: Add accessors for verifier stack slots
  bpf: Widen the stack slot index in the jump history
  bpf: Store linked registers in the jump history as an array
  bpf: Track backtracking stack slots with bitmaps
  bpf: Track scratched stack slots with a bitmap
  bpf: Treat unknown-size stack reads as reaching the frame top
  bpf: Size liveness stack masks by the stack each frame uses
  bpf: Grow the verifier id scratch on demand
  selftests/bpf: Cover the tail call caller stack depth limit
  selftests/bpf: Check that narrow stack stores define no slot
  selftests/bpf: Check liveness merge of masks with different widths
  bpf: Size the per-frame verifier structures for a 2 KiB stack
  bpf: Bound program stack use by a per-program limit
  selftests/bpf: Add load conditions on the program stack limit
  selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
  bpf, x86: Allow programs 2 KiB of stack
  bpf, arm64: Allow programs 2 KiB of stack
  selftests/bpf: Test the 2 KiB stack budget

 Documentation/bpf/bpf_design_QA.rst           |  10 +-
 arch/arm64/net/bpf_jit_comp.c                 |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  12 +
 include/linux/bpf_verifier.h                  | 191 ++++-----
 include/linux/filter.h                        |   6 +
 kernel/bpf/backtrack.c                        |  97 +++--
 kernel/bpf/core.c                             |  13 +
 kernel/bpf/diagnostics.c                      |   6 +-
 kernel/bpf/liveness.c                         | 362 +++++++++++------
 kernel/bpf/log.c                              |  13 +-
 kernel/bpf/states.c                           | 130 +++---
 kernel/bpf/verifier.c                         | 315 ++++++++-------
 .../bpf/prog_tests/struct_ops_private_stack.c |  31 ++
 .../selftests/bpf/prog_tests/tailcalls.c      |  42 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/async_stack_depth.c   |  75 ++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   3 +
 .../bpf/progs/struct_ops_private_stack_fail.c |  47 ++-
 .../progs/struct_ops_private_stack_large.c    |  51 +++
 .../bpf/progs/tailcall_large_stack.c          |  62 +++
 .../selftests/bpf/progs/test_global_func1.c   |  65 +++
 .../bpf/progs/test_global_func_deep_stack.c   |  33 +-
 .../bpf/progs/verifier_large_stack.c          | 377 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c |  79 +++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  21 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  53 +++
 .../selftests/bpf/progs/verifier_tailcall.c   |  57 +++
 .../selftests/bpf/progs/verifier_var_off.c    |  32 ++
 tools/testing/selftests/bpf/test_loader.c     |  24 ++
 tools/testing/selftests/bpf/testing_helpers.c |  41 ++
 tools/testing/selftests/bpf/testing_helpers.h |   1 +
 tools/testing/selftests/bpf/verifier/calls.c  | 122 ++++--
 32 files changed, 1883 insertions(+), 495 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_large_stack.c


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.53.0

