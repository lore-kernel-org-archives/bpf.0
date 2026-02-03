Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2383242D2
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157654; cv=none; b=X6/0MCb2kiU9FFFy36V8w1fgYpIdMk3jxvAACg/KezC/6Kzb3m6ZBx7NhaaC+E6zdu3sAKpOkituicsHVBDaRJ9eKqmg2WcNY8vHAeyllQhVdxl0I2VUiA52f0aWl8yAFQUfltdPTp8cjUmxDnPSysgddmAp4N4fQ00w1UOwAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157654; c=relaxed/simple;
	bh=xWcU6TYSCGkMYQjpSwHo71rjhAkKpoYVc77GCTEgllE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j5jzshxucUUzXRxFO8cffLvUSnvY7MhjCfis/dGkEf81f/UWRrtQcoTw7HVK8sPs2YFk68rdo15py9LurjM6GfmGp+0KNRH0VpB40xCWF27j0ON0/3m8c54U0gXylUWop2jqDqAGTLy9IMDAJkq53Qfap36NachIFY/w3Mt3oXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivR7g2Pm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivR7g2Pm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BF6C116D0;
	Tue,  3 Feb 2026 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770157653;
	bh=xWcU6TYSCGkMYQjpSwHo71rjhAkKpoYVc77GCTEgllE=;
	h=From:To:Cc:Subject:Date:From;
	b=ivR7g2PmNuwbPGbQkijKJLYNo296m9Hp5Tmo5uG6Ncz3JhJVbKYHA04uR1r/9RVpp
	 SMiwKdv/FE/nXxfnFLFPuQQtPdFjri9m3piUcS2m701rYrP2Ao3jtPi+EtyO4bkEwG
	 p2rjSXhLGTE5fSVBW7THRDcGF3PAhActqsoMwMmuWlKqmC6P8nfqp9F/c1N49mtSje
	 tRvgFA9v/hdJNzykTvamrW0IjqrjtRcowqTYZL+yWJnGOGlay4LPkVk2navi6DWjR7
	 ngrsD4XOTEsK4RnKfRzEKEaDCHzCjuJSFknVrwTOfIl6CH4ah5Xz9HvZdk+nuXBwM5
	 Dj90GJzveK2RA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] bpf: Improve linked register tracking
Date: Tue,  3 Feb 2026 14:26:16 -0800
Message-ID: <20260203222643.994713-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V2: https://lore.kernel.org/all/20260113152529.3217648-1-puranjay@kernel.org/
Changes in v2->v3:
- Added another selftest showing a real usage pattern
- Rebased on bpf-next/master

v1: https://lore.kernel.org/bpf/20260107203941.1063754-1-puranjay@kernel.org/
Changes in v1->v2:
- Add support for alu32 operations in linked register tracking (Alexei)
- Squash the selftest fix with the first patch (Eduard)
- Add more selftests to detect edge cases

This series extends the BPF verifier's linked register tracking to handle
negative offsets, BPF_SUB operations, and alu32 operations, enabling better bounds propagation for
common arithmetic patterns.

The verifier previously only tracked positive constant deltas between linked
registers using BPF_ADD. This meant patterns using negative offsets or
subtraction couldn't benefit from bounds propagation:

  void alu32_negative_offset(void)
  {
          volatile char path[5];
          volatile int offset = bpf_get_prandom_u32();
          int off = offset;
  
          if (off >= 5 && off < 10)
                  path[off - 5] = '.';
  }

this gets compiled to:

0000000000000478 <alu32_negative_offset>:
     143:       call 0x7
     144:       *(u32 *)(r10 - 0xc) = w0
     145:       w1 = *(u32 *)(r10 - 0xc)
     146:       w2 = w1				// w2 and w1 share the same id
     147:       w2 += -0x5			// verifier knows w1 = w2 + 5
     148:       if w2 > 0x4 goto +0x5 <L0>	// in fall-through: verifier knows w2 ∈ [0,4] => w1 ∈ [5, 9]
     149:       r2 = r10
     150:       r2 += -0x5			// r2 = fp - 5
     151:       r2 += r1			// r2 = fp - 5 + r1 (∈ [5, 9]) => r2 ∈ [fp, fp + 4]
     152:       w1 = 0x2e
     153:       *(u8 *)(r2 - 0x5) = w1		// r2 ∈ [fp, fp + 4] => r2 - 5 ∈ [fp - 5, fp - 1]
<L0>:
     154:       exit

After the changes, the verifier could link 32-bit scalars and also supported -ve offsets for linking:

	146:       w2 = w1
	147:       w2 += -0x5

It allowed the verifier to correctly propagate bounds, without the
changes in this patchset, verifier would reject this program with:

invalid unbounded variable-offset write to stack R2

This program has been added as a selftest in the second patch.

Veristat comparison on programs from sched_ext, selftests, and some meta internal programs:

Scx Progs
File               Program           Verdict (A)  Verdict (B)  Verdict (DIFF)  Insns (A)  Insns (B)  Insns  (DIFF)
-----------------  ----------------  -----------  -----------  --------------  ---------  ---------  -------------
scx_layered.bpf.o  layered_runnable  success      success      MATCH                5674       6077  +403 (+7.10%)

FB Progs
File          Program           Verdict (A)  Verdict (B)  Verdict (DIFF)  Insns (A)  Insns (B)  Insns      (DIFF)
------------  ----------------  -----------  -----------  --------------  ---------  ---------  -----------------
bpf232.bpf.o  layered_dump      success      success      MATCH                1151       1218       +67 (+5.82%)
bpf257.bpf.o  layered_runnable  success      success      MATCH                5743       6143      +400 (+6.97%)
bpf252.bpf.o  layered_runnable  success      success      MATCH                5677       6075      +398 (+7.01%)
bpf227.bpf.o  layered_dump      success      success      MATCH                 915        982       +67 (+7.32%)
bpf239.bpf.o  layered_runnable  success      success      MATCH                5459       5861      +402 (+7.36%)
bpf246.bpf.o  layered_runnable  success      success      MATCH                5562       6008      +446 (+8.02%)
bpf229.bpf.o  layered_runnable  success      success      MATCH                2559       3011     +452 (+17.66%)
bpf231.bpf.o  layered_runnable  success      success      MATCH                2559       3011     +452 (+17.66%)
bpf234.bpf.o  layered_runnable  success      success      MATCH                2549       3001     +452 (+17.73%)
bpf019.bpf.o  do_sendmsg        success      success      MATCH              124823     153523   +28700 (+22.99%)
bpf019.bpf.o  do_parse          success      success      MATCH              124809     153509   +28700 (+23.00%)
bpf227.bpf.o  layered_runnable  success      success      MATCH                1915       2356     +441 (+23.03%)
bpf228.bpf.o  layered_runnable  success      success      MATCH                1700       2152     +452 (+26.59%)
bpf232.bpf.o  layered_runnable  success      success      MATCH                1499       1951     +452 (+30.15%)

bpf312.bpf.o  mount_exit        success      success      MATCH               19253      62883  +43630 (+226.61%)
bpf312.bpf.o  umount_exit       success      success      MATCH               19253      62883  +43630 (+226.61%)
bpf311.bpf.o  mount_exit        success      success      MATCH               19226      62863  +43637 (+226.97%)
bpf311.bpf.o  umount_exit       success      success      MATCH               19226      62863  +43637 (+226.97%)

The above four programs have specific patters that make the verifier explore a lot more states:

    for (; depth < MAX_DIR_DEPTH; depth++) {
        const unsigned char* name = BPF_CORE_READ(dentry, d_name.name);
        if (offset >= MAX_PATH_LEN - MAX_DIR_LEN) {
            return depth;
        }
        int len = bpf_probe_read_kernel_str(&path[offset], MAX_DIR_LEN, name);
        offset += len;
        if (len == MAX_DIR_LEN) {
            if (offset - 2 < MAX_PATH_LEN) {   // <---- (a)
                path[offset - 2] = '.';
            }
            if (offset - 3 < MAX_PATH_LEN) {   // <---- (b)
                path[offset - 3] = '.';
            }
            if (offset - 4 < MAX_PATH_LEN) {   // <---- (c)
                path[offset - 4] = '.';
            }
        }
    }

When at some depth == N false branches of conditions (a), (b) and (c) are scheduled for
verification, constraints for offset at depth == N+1 are:
1. offset >= MAX_PATH_LEN + 2
2. offset >= MAX_PATH_LEN + 3
3. offset >= MAX_PATH_LEN + 4 (visited before others)

And after offset += len it becomes:
1. offset >= MAX_PATH_LEN - 4093 
2. offset >= MAX_PATH_LEN - 4092 
3. offset >= MAX_PATH_LEN - 4091 (visited before others) 

Because of the DFS states exploration logic, the states above are visited in order 3, 2, 1; 3 is not
a subset of 2 and 1 is not a subset of 2, so pruning logic does not kick in.
Previously this was not a problem, because range for offset was not propagated through the
statements (a), (b), (c).

As the root cause of this regression is understood, this is not a blocker for this change.

Selftest Progs
File                                Program                   Verdict (A)  Verdict (B)  Verdict (DIFF)  Insns (A)  Insns (B)  Insns   (DIFF)
----------------------------------  ------------------------  -----------  -----------  --------------  ---------  ---------  --------------
linked_list_peek.bpf.o              list_peek                 success      success      MATCH                 152         88   -64 (-42.11%)
verifier_iterating_callbacks.bpf.o  cond_break2               success      success      MATCH                 110         88   -22 (-20.00%)

These are the added selftests that failed earlier but are passing now:

verifier_linked_scalars.bpf.o       alu32_negative_offset     failure      success      MISMATCH               11         13    +2 (+18.18%)
verifier_linked_scalars.bpf.o       scalars_alu32_big_offset  failure      success      MISMATCH                7         10    +3 (+42.86%)
verifier_linked_scalars.bpf.o       scalars_neg_alu32_add     failure      success      MISMATCH                7         10    +3 (+42.86%)
verifier_linked_scalars.bpf.o       scalars_neg_alu32_sub     failure      success      MISMATCH                7         10    +3 (+42.86%)
verifier_linked_scalars.bpf.o       scalars_neg               failure      success      MISMATCH                7         10    +3 (+42.86%)
verifier_linked_scalars.bpf.o       scalars_neg_sub           failure      success      MISMATCH                7         10    +3 (+42.86%)
verifier_linked_scalars.bpf.o       scalars_sub_neg_imm       failure      success      MISMATCH                7         10    +3 (+42.86%)

iters.bpf.o                         iter_obfuscate_counter    success      success      MATCH                  83        119   +36 (+43.37%)
bpf_cubic.bpf.o                     bpf_cubic_acked           success      success      MATCH                 243        430  +187 (+76.95%)

Puranjay Mohan (2):
  bpf: Support negative offsets, BPF_SUB, and alu32 for linked register
    tracking
  selftests/bpf: Add tests for improved linked register tracking

 include/linux/bpf_verifier.h                  |   6 +-
 kernel/bpf/verifier.c                         |  49 ++-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../bpf/progs/verifier_linked_scalars.c       | 300 +++++++++++++++++-
 4 files changed, 342 insertions(+), 15 deletions(-)


base-commit: f11f7cf90ee09dbcf76413818063ffc38ed2d9fe
-- 
2.47.3

