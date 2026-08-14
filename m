Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A31F3BB9EF
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786749611; cv=none; b=vCIhpXO8+xmSVIF+nIeFkkwZ4VR0oUyfcYs/HH7CYXUgMI8i3u/Wl8Ky8l0nh8x8ZkoIV5MwzogIvZCdgdQsoL7tZyPPjqgQdK2gSQA2fMf0ZrVwaCZ9T0QlevmhfJ8ug0q7TI4spY23FvoPztNnOeCl9CTEcdnvkIG4BaMP9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786749611; c=relaxed/simple;
	bh=j+/4cpJAITHGx0R/XRXl53mx/NwWObpZuts3v/a8ADg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrE/eW05arRuYXZTGSr3b0ZEZ/3ulm5oB/8lN4GhajJUS8KsE3MQkuELRJLwzoLq3qcqkUDtkTFk6RMyw+UsaVIWq7mLbkstpB1r9c3MMFq8O4In1NIcZGe6deKmOTyxJjMsiZZzya/V0hcaGfH1gAmEhw9OTkseNaPgMyTA3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1DmeXDK; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1DmeXDK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j+/4cpJAITHGx0R/XRXl53mx/NwWObpZuts3v/a8ADg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786749606; v=1; x=1787354406;
 b=a1DmeXDKTvWoEbs7dvhMPNWNOcAMuBALzKyUtRxk0LIlzYoywl/SLCnvUXJAxI8AHqXci4T0
 llgAcR8yU6bg7dX01flOty9OqxW1dpmTjhupwHZ1Pf59MWqzGw9C0WwwExBo8+Xi07Kv5NOebum
 OfymA7mAlxwUT+2UF/iwQTO0=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id d52ac6c6ebe5a4fb;
	Fri, 14 Aug 2026 23:19:56 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [RFC bpf-next 0/6] bpf: track scalar equality across the low 32 bits
Date: Fri, 14 Aug 2026 16:19:39 -0700
Message-ID: <20260814231945.3884596-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier's linked-scalar machinery tracks register equality only for the
full 64 bits (optionally with a constant delta). There is no way to record
"these two registers share just their low 32 bits", so a 32-bit mov from a
source with unknown high bits has to drop the relationship entirely, and a
later narrowing of the source never reaches the destination:

|  r6 = ...                    /* full 64-bit unknown */
|  w7 = w6                     /* 32-bit zero-extending mov          */
|  if w6 != 0 goto .Lxx        /* not taken: r6's low 32 bits are 0  */
|  if w7 == 0 goto .Lok   <-- not deduced today

The same gap exists for the 32-bit sign extension and was the
motivation for this patchset.

|  0: (61) r2 = *(u32 *)(r1 +24)
|  1: (bf) r0 = (s32)r2
|  2: (56) if w2 != 0x0 goto pc+10       ; R2=0 (branch taken)
|     ...
| 12: (95) exit

This matters more with bpf-gcc than clang: gcc emits far more sign extensions,
and the resulting rejections are real which show up in three ways

 - callback exit codes rejected with "R0 ... should have been in [0, 1]"

 - the errno-or-zero return pattern (verify_pkcs7_sig and many lsm.s progs)
   where a value clamped to [-4095, 0] is re-widened to [S32_MIN, S32_MAX]

 - and loops whose induction variable is sign-extended each iteration failing
   with "The sequence of 8193 jumps is too complex".

This series adds a low-32-only equality link in two flavours: the high half
is either zero (zero-extending mov) or the sign-extension of the low field
(32-bit sign extension) and teaches sync_linked_regs() to rebuild the
destination accordingly.

  1-2  NFC prep. Turn ->precise into a u8 flags field, then move the existing
       linked-scalar flags out of the top bits of ->id into it. ->id becomes a
       plain 32-bit identifier with no masking anywhere, which collapses
       check_scalar_ids() to a single check_ids(). Because ->flags sits past
       every memcmp() window used for state comparison, patch 2 also adds
       link_flags_match() and calls it from regs_exact(), restoring the
       discrimination the compound-id key used to provide for free.
  3-4  The zero-extending flavour, BPF_FLAG_SUBREG_ZEXT, plus tests.
  5-6  The sign-extending flavour, BPF_FLAG_SUBREG_SEXT, plus tests.

Sent as RFC mainly for the design questions below; the code is in shape.

Notes and open questions
========================
- An earlier version detected loop headers to decide when forming an in-loop
  link was safe, but using Eduard's in works SCEV loop-analysis. However the
  conclusion was that was not the right problem/solution as the ensuing issue
  could be triggered in current codebase (w/o this series with a little tweak
  of the test: 

- regsafe() now checks the low-32 link flavour *above* the explore_alu_limits
  and !precise short-circuits, while the pre-existing BPF_FLAG_ADD_CONST check
  sits below them. The argument for checking early applies to both. Moving the
  ADD_CONST one makes regsafe() stricter on a path that predates this series --
  a pruning change worth measuring separately -- so it is left alone and the
  asymmetry is called out in a comment. Opinions welcome.

- reconstruct_sext32() rebuilds var_off with tnum_range() over the low-32
  signed bounds, so known bits that the range does not imply are lost. The
  zero-extending arm keeps the base's exact low-32 tnum. Sound but asymmetric;
  a follow-up could derive the tnum from tnum_subreg(src->var_off) instead.

- Only the 32-bit sign extension forms a link. (s8)/(s16) do not, so the flag
  alone carries the width and no extra field is needed. They are not seen in
  codegen so far.

Testing
=======
Baseline: bpf-next: 
   2026-08-14 f2aaa6215910 riscv, bpf: Fix missing sign-ext for signed 1-byte and 2-byte kfunc args

Full selftest runs with bpf-gcc and clang (-mcpu=v4). 

 - clang: no regressions (no improvements either)

 - bpf-gcc:

   Before: Summary: 635/5362 PASSED, 7786 SKIPPED, 115/412 FAILED
   After : Summary: 644/5439 PASSED, 8506 SKIPPED, 106/350 FAILED

   The measurable pass improvements come with the sign-extension patch;
   the zero-extension one is groundwork plus its own test.

   + "... should have been in [0, 1],  [-4095, 0]" 
     All 21 instances gone

   + of "The sequence of 8193 jumps is too complex."
     Down from 7 to 3

   + One regression vs. baseline: iters/iter_obfuscate_counter:FAIL

     It is now runaway to 1M, root-cause has been analysed and something
     to do with with bpf-gcc's branch codegen and costing.

For completeness, full diff of bpf-gcc run vs. bpf-next baseline

1. Existing tests OK now

> #25/1          bpf_ip_check_defrag/v4:OK
> #25/2          bpf_ip_check_defrag/v6:OK
> #25            bpf_ip_check_defrag:OK
> #26/5          bpf_iter/task_tid:OK
> #26/6          bpf_iter/task_pid:OK
> #26/7          bpf_iter/task_pidfd:OK
> #26/8          bpf_iter/task_sleepable:OK
> #26/14         bpf_iter/tcp4:OK
> #26/15         bpf_iter/tcp6:OK
> #26/16         bpf_iter/udp4:OK
> #26/17         bpf_iter/udp6:OK
> #26/25         bpf_iter/bpf_hash_map:OK
> #26/37         bpf_iter/ksym:OK
> #26/38         bpf_iter/bpf_sockmap_map_iter_fd:OK
> #36            bpf_sockmap_map_iter_fd:OK
> #82/8          cgroup_xattr/read_cgroupfs_xattr:OK
> #82            cgroup_xattr:OK
> #112/2         dynptr/test_dynptr_data:OK
> #112/3         dynptr/test_dynptr_copy:OK
> #112/4         dynptr/test_dynptr_copy_xdp:OK
> #112/5         dynptr/test_dynptr_memset_zero:OK
> #112/6         dynptr/test_dynptr_memset_notzero:OK
> #112/7         dynptr/test_dynptr_memset_zero_offset:OK
> #112/8         dynptr/test_dynptr_memset_zero_adjusted:OK
> #112/9         dynptr/test_dynptr_memset_overflow:OK
> #112/10        dynptr/test_dynptr_memset_overflow_offset:OK
> #112/11        dynptr/test_dynptr_memset_readonly:OK
> #112/12        dynptr/test_dynptr_memset_xdp_chunks:OK
> #112/13        dynptr/test_ringbuf:OK
> #112/14        dynptr/test_skb_readonly:OK
> #112/15        dynptr/test_dynptr_skb_data:OK
> #112/16        dynptr/test_dynptr_skb_meta_data:OK
> #112/17        dynptr/test_dynptr_skb_meta_flags:OK
> #112/18        dynptr/test_adjust:OK
> #112/19        dynptr/test_adjust_err:OK
> #112/20        dynptr/test_zero_size_dynptr:OK
> #112/21        dynptr/test_dynptr_is_null:OK
> #112/22        dynptr/test_dynptr_is_rdonly:OK
> #112/23        dynptr/test_dynptr_clone:OK
> #112/25        dynptr/test_dynptr_skb_strcmp:OK
> #112/27        dynptr/test_probe_read_user_dynptr:OK
> #112/28        dynptr/test_probe_read_kernel_dynptr:OK
> #112/29        dynptr/test_probe_read_user_str_dynptr:OK
> #112/30        dynptr/test_probe_read_kernel_str_dynptr:OK
> #112/31        dynptr/test_copy_from_user_dynptr:OK
> #112/32        dynptr/test_copy_from_user_str_dynptr:OK
> #112/33        dynptr/test_copy_from_user_task_dynptr:OK
> #112/34        dynptr/test_copy_from_user_task_str_dynptr:OK
> #117           exe_ctx:OK
> #239/9         mem_rdonly_untrusted/mixed_mem_type:OK
> #239           mem_rdonly_untrusted:OK
> #418           setget_sockopt:OK
> #441/7         sockmap_basic/sockmap copy:OK
> #441/8         sockmap_basic/sockhash copy:OK
> #441           sockmap_basic:OK
> #605/16        verifier_global_ptr_args/anything_to_untrusted_mem:OK
> #605           verifier_global_ptr_args:OK
> #614/1         verifier_iterating_callbacks/unsafe_on_2nd_iter:OK
> #721/1         verify_pkcs7_sig/pkcs7_sig_from_map:OK

2. New tests added pass

> #622/25        verifier_linked_scalars/subreg_eq_zext_mov_narrow:OK
> #622/26        verifier_linked_scalars/zext_mov_keeps_add_const_src:OK
> #622/27        verifier_linked_scalars/zext_dest_driven_does_not_narrow_base:OK
> #622/28        verifier_linked_scalars/sext_linked_low_narrow_to_zero:OK
> #622/29        verifier_linked_scalars/sext_linked_separate_dest_narrow_to_zero:OK
> #622/30        verifier_linked_scalars/sext_narrow_branch_on_source:OK
> #622/31        verifier_linked_scalars/sext_narrow_copied_back:OK
> #622/32        verifier_linked_scalars/sext_narrow_inplace_pre_copy:OK
> #622/33        verifier_linked_scalars/sext_narrow_spill_fill:OK
> #622/34        verifier_linked_scalars/sext_resext_preserves_range:OK
> #622/35        verifier_linked_scalars/sext_in_loop_converges:OK
> #622/36        verifier_linked_scalars/sext_in_loop_separate_dest_index:OK
> #622/37        verifier_linked_scalars/zext_mov_from_sext_src_zero_extends:OK
> #622/38        verifier_linked_scalars/sext_mov_keeps_add_const_src:OK
> #622/39        verifier_linked_scalars/sext_dest_driven_does_not_narrow_base:OK

3. Regression

< #171/47        iters/iter_obfuscate_counter:OK


Vineet Gupta (6):
  bpf: turn bpf_reg_state->precise into a flags field [NFC]
  bpf: move the linked-scalar flags into bpf_reg_state->flags [NFC]
  bpf: support low-32 subreg scalar linking for zero-extending movs
  selftests/bpf: cover low-32 subreg-equal link for zero-extending movs
  bpf: support low-32 subreg scalar linking for sign-extending movs
  selftests/bpf: cover 32-bit sign-extension low-32 links

 include/linux/bpf_verifier.h                  |  51 +-
 kernel/bpf/backtrack.c                        |  22 +-
 kernel/bpf/log.c                              |   6 +-
 kernel/bpf/states.c                           | 106 +++-
 kernel/bpf/verifier.c                         | 226 ++++++-
 .../selftests/bpf/progs/verifier_bounds.c     |  10 +-
 .../bpf/progs/verifier_linked_scalars.c       | 550 +++++++++++++++++-
 .../selftests/bpf/progs/verifier_reg_equal.c  |  16 +-
 8 files changed, 890 insertions(+), 97 deletions(-)

-- 
2.53.0-Meta

