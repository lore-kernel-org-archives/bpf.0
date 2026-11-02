Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582983;
	b=SdBB4R89fp/sg3T+aPd1afx7eOWJOYR2xVJ5RSBiKvYosVhd8LpNo3NWkusjSUdnj6bg
	 uI0A7BCHIoKYVh1IMksPVEQTug+XqxK2rCDG7lMhWgKao99FXbI6P5utx+cZz2Nk1CW4g
	 m9UiNVVw+JcPagJPF3BYeaEe7T1aG8Rbz3JuSb55Jd+mgdUbKb2GQ5cVKtPYJ9FNo0gFn
	 FZkg1zApQyghDk1XTX/CnA5GLGTA5HokQB4NyLPaiYC4Dtg6g8Gbwbg1HuePFoYjce1b4
	 JwpZgEftSKI7Nlt3XScGddrBuGK79htmK8G3MXoSuCtDF1NFwcEBaPjb+PD1g8EWMZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=X5KDX/zi7y4jA0n8PNSRiNBaBsgiwdPhayLjJ43VC9c=;
	b=mwkgaWdyS/zvlin8WdjIwRfL58icCQVexmOlt4HzSfyJHqw77Qj5jDwrSXzzPmmTYh5G
	 3QD/f3fDcbtz2QMqz3aO4reki14AV5UnnfLL5l5fJ2xPhV7acLC2+koat7llznH07ueKO
	 9EPAhuhygniD7JvEdjmFS6A8FLVCfVwBcPDdS8d759UwrJw4q6xxXTN2/dLUktBrYgiMQ
	 J5Xvn/OyZZ2DbbHDj/gvkkBHeQtCeo4ZM6KJsU76GqfFYdz+3/Ca8HTMMR2dpKeoGSTqZ
	 nhwGbzYsTa+xnQ/Cx5ezWlWczWmcppNYLc3QNxa1XQiGRXK8QIFuwiqMQMA+g/MJjoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhMtSPaV;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44290606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 01:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44290606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OhMtSPaV
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so1397500b3a.3
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 17:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793582983; x=1794187783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5KDX/zi7y4jA0n8PNSRiNBaBsgiwdPhayLjJ43VC9c=;
        b=OhMtSPaV9ehseU95W+hs4wYeSGyzDFI2qXhHVbVYgGKlti2TCLX6pe9EJk6Ykj68aI
         3tRwaxzdJSV23omkJWGpgVCixZgEorfQzco9jvoHZn8YsrLdNIS2QxgHDu+xC03L+LFu
         j3usuF2T+3oR0Kwq+3zVhskX4/Elr59HRkxY4ecN7xM27MXaZHRD+oboQuUqqyQgCaV3
         PhtXkZSvwOm62GUYdkyspFHdlc8yvFh9Qf/l8OyZ07FQy8zxn4rHy1kotmhaq6lwEVxw
         0XKcWYf1IaPJ94Nb/L1oVkUd4oRAEQrZTzjDk1AZ4ozP2MbVcjJZGYJ38E4GUIOUec9O
         ew+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793582983; x=1794187783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5KDX/zi7y4jA0n8PNSRiNBaBsgiwdPhayLjJ43VC9c=;
        b=lJOTpivGH/UXXY6UtbRL9K8V1ljRacUPmEZsJU3E+AbBA50GtBPmryAsKnuwIAbZ4Y
         i1jHBUUbmR1QTcNUZWMibsxVs9WJpevhAYv7YehS3jyDnuMD/o3HpXOfpNG8OlIgR1Wz
         BKgkpilkls8zsDEJhkbg1zuIgLwk8jZiXPLSKEFatvGoOpMOLIOHL7QFU9RxCYZEeeZF
         WGfAUR+jtmlRrcf/9aNoWiQTBbVnJc8ECAHQT/V7fZlErL7rUpiA9i7LyOwo+3Az/tAG
         rJwbBKaZS+aVX//d1L8q17LCndiCmsaw+Dg/8LGTNVQgfLKUxopcVe7vYPXuXFUHxP3q
         neCA==
X-Gm-Message-State: APuU4Z930puN6LfnZBpwjTtcIakneXY8QS4Vku9BXGIaF01i2vW9W6R8
	QcNjdl9QJiVqbNbavytzIWODBLVT+1rQQMq5oLAhvLI5CAe/8JdW5mffQKFoFg==
X-Gm-Gg: AYBFou0aM9OQObiOG2BAGjA0OYtq2v6l4NSjvxiuBCiUVD5phEuZ9rdrmmvidYPoQHh
	k3FNhoj5sdC+lMXKwasZcIWELHn8F3LBY3ZCCcd32WhQtIpyN+9L2VfB+GRG+KiIoeiuHabJpvG
	1IcuFa9GuIgY6esQqO5SnJnstfFdaWQ7KR93WREnOgRJ1gnXjdgfmp5QCYE8/5qQgX1sL8ELETt
	C6bCal8drRHsNWv9pY7687GAWiEMC/EkqPfjG2QTFdreZw8h3BEkIeVruK7mKTlL2udaaHvduRm
	1gT9zhDvTDXPCaBd4lodfvpMAUoMKv+AfIz2QyBIGqVa5A9326yIc0I+/nHBUMrH8AOerlaXbH6
	NvSZwtQU6bOPah/s3j9PUzK3jkdjyye8P966ityz/cS1KtJ4W3bEUbpzO37EIq2CO6GsSvS2kyC
	96TU7iYrmlTSW8Q4y2fk6+h5yZlZbHQmkkqof/7d07c99WGnOcf/Fivat688FiLMYjUlO4RUMY8
	pEKzoMGpQpUAYASyxPOOoYL/giwfBVG2TzFAHzcuhBssdCIOyBO9EsbsEGBjodSF7gtbQ0nvWRZ
	ljwd3ATOqd8kvDkLV26SUYSjudJ3bhMLcUhKeqYelbgejgb8pKzzhHIsDnDRUVVgVjICONC4Zij
	0zhXfcHJCy67p5gU7TeHgyjUxtTOmDDUJQHhWR/nSXGRmDObe8Q1E3E+9tSPvDSd3AWFtgrbq1z
	Q=
X-Received: by 2002:a05:6a00:3c90:b0:89f:5ac6:32f6 with SMTP id d2e1a72fcca58-8a9bddbdc16mr6260729b3a.24.1793582982259;
        Sun, 01 Nov 2026 17:29:42 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9638149sm1257181b3a.20.2026.11.01.17.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 17:29:41 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	odys.yuan@gmail.com
Subject: [PATCH bpf-next v3 00/13] bpf: Replace bpf_patch_insn_data() with a list of deferred patches
Date: Mon,  2 Nov 2026 01:29:27 +0000
Message-ID: <20261102012940.1756142-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

After verification the verifier rewrites the prog in several passes. A pass
calls bpf_patch_insn_data() for each insn that it replaces, and
verifier_remove_insns() for each range that it removes. Each call moves all
insns behind that place and walks all insns to adjust the jumps. It also
walks each table that names insns: aux data, subprogs, line info and more.
Thus a pass that changes M of the N insns of a prog does O(N * M) work.
With bpf_jit_harden=2 pyperf600 from the selftests loads in 3.509 s, and in
0.223 s with this series.

The idea
========

A pass queues its changes in a patch list, in the order of the insns. It
commits them one time, at its end. No insn moves before the commit, thus
the pass uses old indexes only. The commit calculates two maps from old
index to new index. Then it builds the new image, and all that names an
insn goes through one of the maps. The commit costs O(N + inserted insns).

  old image   patch list        new_off[]   new_tgt[]   new image
  0: a                           0           0           0: a
  1: b        patch, 3 insns     1           1           1: b1
                                                         2: b2
                                                         3: b3
  2: c                           4           4           4: c
  3: d        removal            5           5
  4: e                           5           5           5: e
  5: f        insert 1 insn      6           7           6: i1
                                                         7: f

  map         what goes through it
  new_off[]   calls, subprogs, function pointers, line info
  new_tgt[]   jumps, insn arrays, poke descriptors

The maps differ only where insns are inserted in front of an insn. For
example, the setup of the may_goto count goes in front of a subprog. A call
of the subprog runs the setup, and a jump to its first insn does not.

The interface
=============

  bpf_patch_list_add()     queue a patch: new insns replace insn i
  bpf_patch_list_insert()  queue new insns that go in front of insn i
  bpf_patch_list_del()     queue the removal of insn i
  bpf_patch_list_commit()  build the new image, move all tables, install it
  bpf_patch_list_apply()   static in core.c: the commit for classic BPF

During a commit one part of bpf_verifier_env (env) describes the old image,
and a different part describes the new image. Thus the order of the steps
is a rule:

  1. all that can fail   Build the maps and the new image, allocate the new
                         aux data and the prog. An error changes nothing.
  2. removed insns       Tell the offload device, free what their aux data
                         points to. All of env describes the old image.
  3. the tables          A new entry depends only on the old entry and on
                         the maps. Function pointers also need the old
                         subprogs, thus they move before the subprogs.
                         No helper that reads the insns, prog->len or a
                         table from env or the prog.
  4. the new image       Write the insns and prog->len last.

The patches
===========

  pass                                  patch  what it needs (patch)
  ------------------------------------  -----  ----------------------------
  bpf_do_misc_fixups(), main loop       3      list (1), commit (2)
  bpf_opt_remove_dead_code()            5      removal (4)
  bpf_opt_remove_nops()                 5      removal (4)
  bpf_opt_subreg_zext_lo32_rnd_hi32()   5
  bpf_convert_ctx_accesses()            8      second patch (6), insert (7)
  bpf_do_misc_fixups(), may_goto count  9      insert (7)
  add_hidden_subprog()                  9
  bpf_optimize_bpf_loop()               9
  bpf_jit_blind_constants()             10     commit without env (10)

Read patches 1, 2, 4 and 7 first: they are the design. Patch 11 removes the
old code. Patches 12-13 are selftests.

The results
===========

Load times in an x86_64 VM with 8 vCPUs, bpf-next without and with the
series. Wall time of 'veristat -q <obj>', mean of 30 runs, and of 10 runs
with BPF_F_TEST_RND_HI32 or bpf_jit_harden=2. BPF_PROG_LOAD of a prog with
131072 'goto +0', mean of 3 runs.

                                   base       patched
  pyperf180                       0.148 s    0.085 s
  pyperf600                       0.430 s    0.220 s
  strobemeta                      0.149 s    0.148 s
  test_verif_scale2               0.121 s    0.122 s
  pyperf180, BPF_F_TEST_RND_HI32  0.610 s    0.091 s
  pyperf600, BPF_F_TEST_RND_HI32  1.830 s    0.223 s
  pyperf180, bpf_jit_harden=2     1.216 s    0.085 s
  pyperf600, bpf_jit_harden=2     3.509 s    0.223 s
  131072 'goto +0'               33.288 s    0.245 s

With bpf_jit_harden=2 the prog of
"ld_dw: xor semi-random 64 bit imms, test 5" of test_verifier does not load
in 900 s on the base. With the series the test takes 1.5 s.

What users can see, apart from the load time:
 - Patches 3, 5, 8, 9 and 10: a jump that patches push out of range fails
   the load with -ERANGE, not -ENOMEM. The verifier log names the jump, not
   the patched insn. For patch 10 that is true for a prog with subprogs. A
   prog of one function gets -ENOTSUPP or goes to the interpreter, as
   before.
 - Patch 3: a backward may_goto that patches push beyond -32768 loads.
 - Patch 5: bpf_opt_remove_nops() also removes a 'goto' or a may_goto that
   jumps over 'goto +0' only.
 - Patches 8 and 9: a jump back to an insn keeps its offset when insns are
   inserted in front of that insn. On the base an offset near -32768 fails
   the load.

The series does not change the code of progs in other ways. In selftests,
scx and Cilium only these nops differ in xlated insns, line info and func
info. That is also true with BPF_F_TEST_RND_HI32 and with bpf_jit_harden=2.

Eduard pointed out the cost in pyperf180 [1]. The split between core.c and
the verifier follows Jiong's RFC [2]. Andrii suggested the map there.

I picked up Qiliang's series to speed things up: patches 1-12 are his, with
my changes as listed below.

v2 -> v3:
- Rebase: patches 4 and 6 of v2 touched the arena_scalar rewrite, which
  is gone
- Squash neighbours: the 22 patches of v2 are patches 1-12, patch 13 is new
- Fix a NULL function pointer in .rodata: the commit looked up a function
  by its old offset after prog->len was the new length (patch 4)
- Give the commit the order above: one function per table, the image
  last, the line info map built with the image (patches 1, 2, 4)
- Give all instructions of a patch the orig_idx of the patched one: the
  range message said "insn 0" for the jump of may_goto (patch 2)
- Patches 4 and 5 of v2 are one patch (3): in between a backward may_goto
  at -32768 didn't load
- Walk from the end in bpf_opt_remove_nops(): the look-back was
  quadratic and couldn't be killed (patch 5)
- Commit the prologue before bpf_convert_ctx_accesses() rewrites
  instructions in place: a rewrite of the first one was lost (patch 8)
- Make bpf_patch_list_apply() static (patch 10)
- Comments of may_goto_expand(), bpf_patch_list_commit() and the error
  path of bpf_jit_blind_constants() (CI bot)
- Write may_goto as a raw instruction in the tests, so that the assembler
  doesn't have to know it (Sashiko on 22/22)
- Tests of v2 (patch 12): check the final offset of the gotol, let gotox
  return another value for each wrong landing, run the may_goto tests on
  arm64 too, run serially because of bpf_jit_harden
- Test callx after the program shrinks (patch 13)
- Test the tables of the commit that had no test, the new nop rule and
  the blinding of a classic filter (patch 13)
- Rewrite the commit logs and the cover letter, say what users can see

v1 -> v2:
- Convert every pass and remove the old patching code (Alexei)
- Build the new image in core.c, so that blinding without a verifier env
  uses the list too
- Let the list remove instructions, insert in front of one and patch one
  twice
- Pick JEQ or gotol for a backward may_goto from its offset grown by the
  patches in between, v1 picked JEQ when that offset was -32768 (CI bot)
- Test a backward may_goto expanded to gotol
- Test a jump that the patches push out of its 16-bit range, and a gotox
  to a patched insn

v2: https://lore.kernel.org/r/20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com
v1: https://lore.kernel.org/r/20261001-bpf-verifier-patch-batch-v1-0-a12df8a09160@gmail.com

[1] https://lore.kernel.org/bpf/a714ee96d0ad96bbc9d51037616e5c4e2790a8ec.camel@gmail.com/
[2] https://lore.kernel.org/bpf/1562275611-31790-1-git-send-email-jiong.wang@netronome.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (1):
  selftests/bpf: Test the tables that follow patched and removed
    instructions

Qiliang Yuan (12):
  bpf: Add a list of deferred instruction patches
  bpf: Remap the verifier state through the patch list
  bpf: Queue the rewrites of bpf_do_misc_fixups()
  bpf: Let the patch list remove instructions
  bpf: Move the bpf_opt_*() passes to the patch list
  bpf: Allow patching an instruction twice through the patch list
  bpf: Teach the patch list to insert in front of an instruction
  bpf: Move bpf_convert_ctx_accesses() to the patch list
  bpf: Move the remaining verifier rewrites to the patch list
  bpf: Blind constants through the patch list
  bpf: Remove the old instruction patching code
  selftests/bpf: Test jumps around patched instructions

 include/linux/bpf.h                           |    4 +-
 include/linux/bpf_verifier.h                  |   88 +-
 include/linux/filter.h                        |   16 -
 kernel/bpf/bpf_insn_array.c                   |   36 +-
 kernel/bpf/core.c                             |  605 +++++---
 kernel/bpf/fixups.c                           | 1306 ++++++++---------
 kernel/bpf/verifier.c                         |   46 +-
 .../selftests/bpf/prog_tests/patch_list.c     |  256 ++++
 .../selftests/bpf/prog_tests/verifier.c       |    3 +
 .../testing/selftests/bpf/progs/patch_list.c  |  136 ++
 .../bpf/progs/verifier_callx_rodata.c         |  100 ++
 .../selftests/bpf/progs/verifier_patch_list.c |  426 ++++++
 12 files changed, 2040 insertions(+), 982 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/patch_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/patch_list.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_patch_list.c


base-commit: a30c772627b2ef4bc715332b1b04938a914556cd
-- 
2.55.0

