Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749268;
	b=0/IG28bwIBKlPO8MPpnmsWMJr8p6/XDXJc1V6YBegr7nWWYfuTXPII/IjpTUw9aeLqhU
	 HRRG9ZRPtyPgsXllckk1P02Hr2134X/N03SUT5FaGR1fq6CPJ4HXK179WdEdQ5JdIITh9
	 s9NtkHv5cK5AGFOIWn+id/r8hqkZ+l4CXylYQsnxpaLmiIhLlGoVI7sQZkUYk5+uZRL+Y
	 JQo9aLl9jRMVYgXXDKf7V5iG5I2K/OxH8BTNQem1pZsnOG0BjMUpI13qa8PmmBXlwR1wP
	 Ay3W0TbrYtg7cmCS0hFiN3FU3ze/+wKzNJgnAYk+vKv+nTZBR6/u+LPE/P3uUlbOGyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=X6N0vopjRHsBcYR4TOa+57wIbhfF1QJe/gAiDifAJ2Q=;
	b=NOradsdym0E5EWHzTCSjw2EknYbFqE+oW58sfp2Y/KlcIvzMdmGitRVTpWg/5fKG9yJ7
	 xh5c+yPxKCqx2Ag/29hE33r3sIxtFTu9lB13t3RZ1+tlBtpzdDlXKWnBjqpCKwH7hpf8s
	 DwNhd9D2VlBu+IbbMp3s34KKNJeTPm+DqwcsfCODj4Sf+Jsup67BJk65GsYtZ/taYiWt5
	 g63U96TxK333KIBpnJ5puoLo+rNms5U7/pOgScS6g+RFN2pCXTZ+tDenbhorVj9NXM/wU
	 V69/iIIXKx6lU8xp5aZfMUtWnHt7YiabLZ4gJuPvIZLVJZ1uErz6/Yf0TJlvUOhQw0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="AnY5tI/B";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0804606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0804606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AnY5tI/B
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so73574b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749267; x=1794354067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X6N0vopjRHsBcYR4TOa+57wIbhfF1QJe/gAiDifAJ2Q=;
        b=AnY5tI/BL3YHVU0pbvJsU/HVXNsAvGun+DLyOZ/dqdNhCDgv4VRGa93MExpY7E2PdW
         gZQRKfcaO8SO1F9DJgPFu/+pKtkxX15tzxFmkDOIsO5RxyCrlVx6h+XNmL9VXsEKKLht
         VRqaRnndSyeERlod+UOFx9NZoj63M5ECWm+aIG6z3UGTma/rdbwontANVI1GDVhPgkZe
         N+nOo8XT+zkzlQ5eTgqkvYkLTPcwyyw2HMW12ocVIiisREAP6pEAtm1aDDIl9mmfDIHI
         aocruxx741XNXgyrKEZMh/Fjwj01QiRwfVzPSeIUFnGWeEzup9UU84mH2RuDGs5+S2pf
         cu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749267; x=1794354067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X6N0vopjRHsBcYR4TOa+57wIbhfF1QJe/gAiDifAJ2Q=;
        b=JnAAsoYmo6YCySFGkeQzRmJDVeOOpqqJcJ2RfKP/w+tRsPWK+tKwi+QlykTHwRPFT3
         TNlOGwVVxN3M0IOkpShYC8r3rjc3+da8bPTw+rL37Nygk8cGYluzLNeSFZNgwf6etevN
         4RUt0uJZXWjCGeYXSzNp+PbE36xGCNsCAlSQHpL6rM0zrPDRPlH2oYjvj3MK52rtuzfJ
         k5Gyvre488gymkw/m21gAj1fo8yCeoFkdch6OPZx1qCeaDe9FpSSkcB6NsJsmyzJztPe
         bkU32BYoFiOUEHRFmCUEkT3yHnMPNldgksXbyG5S4ERUZ28nvBh3R/lNyJuSZz7X2N59
         LQJA==
X-Gm-Message-State: APuU4Z8zLyuxaZvsbe/2VqW2BgfKs0HZgg+XrICNAR5pKT+T3kSUKg64
	MwQNpfRpTjr3malsSb3hNbFsH6YprlC0vG0pQ8uymb169SISdiSLZn60VdB5dQ==
X-Gm-Gg: AYBFou2YAMeL27Qv42AFwiO5gTRdRBFiGcX8vvSwM80L/sS+dTrLI8HSGaVnJxo9CQY
	AD31lqqz5wZz2KSeSS3KCd/aoH4B8mgSFXwWt9zDdfqU1AqEMdDAj1veBxksfBSbYea6N5yd8n/
	6zkbfXUfW8Mpjyu17whbuazmUGgql2l2qEpOdFDgZFQVsi8BWFf0z1EXJK5lb38oo/O3nO1Rjyh
	MBO3CqKXkm0IVuiCGHdhUZWgQHxRUmAM5qgV2g9RTCvL7iOGAsQGuWez58TYRga1IlR2PyeBVJI
	vnrHvkkoNFAQDbBAtCVJlivN1kcxHUpcgQUtGKc3vvt4WWXw1zhHjOj6oli7yEeU98Hdmo/TfXN
	yvNXKeouARJg0kql9eW2yxnYEqNkybiulxZYXXCSPsokqErIqAfhK3ErZdjVAmbE+4YZAyYL8m3
	njGeVfgKCYVwEwyY2b7zCkgoOKLdCF4SNYLmJm6Wn6R4z7S5NvLMkI9EGJy92L7gPQYtiZEITEy
	VsdSg9J1PgO29zB6S8+KYEVHOtcqc4926Ye7aykpnGhXBLnET1fYkyi7F9aUQLqQTnRXP22ceho
	/rBEqd+9VwpMPW8yryviRwsuONbzCQH+bBq5G7Xk3WF6rMVg3r/SFCihSC3Y2frB+pFRr454ab6
	Drmo4CQC4MMZLHmN6tmwWo66atQc/2VtKNfBU4z3QOZpBrmZxOs8IyZX0cGO3WjnVp9iU7srn7A
	==
X-Received: by 2002:a17:90a:dfc4:b0:3ae:521e:767f with SMTP id 98e67ed59e1d1-3ae897994e9mr10881130a91.36.1793749266687;
        Tue, 03 Nov 2026 15:41:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm6230077a91.5.2026.11.03.15.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 00/37] bpf: More precision, more counted loops, larger limits
Date: Tue,  3 Nov 2026 23:40:25 +0000
Message-ID: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
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

This series lets the verifier of today accept more of the code that
compilers make. The main pass does not change: it follows each path of
a prog and prunes, as before.

  precision   A packet pointer keeps its range when the prog adds a scalar
              that is not negative. A shift, a division and a remainder by
              a range have bounds.
  loops       Scalar evolution counts more forms of 'for' and 'while', and
              it has a formula for more of the registers that a loop
              changes. The verifier verifies such a loop one time.
  subprogs    The verifier takes the arguments of a static subprog from
              its code and not from BTF. A trampoline on such a subprog
              keeps what the code takes, or the attach is refused.
  limits      24 arguments of a static subprog, 1024 subprogs.

The patches
===========

  patches  1-2    a packet pointer keeps its range when the prog adds
                  a scalar >= 0
  patches  3-5    trampolines on static subprogs that BTF does not describe
  patches  6-7    stack arguments of a static subprog from its code
  patches  8-21   scalar evolution counts more loops: partial spills,
                  a bound in .rodata, ARG_ANYTHING, sums of constants,
                  ranges, more registers with a formula, over 256 exits
  patches 22-25   a 32-bit counter on the stack, several back edges
  patches 26-27   bounds for a shift, a division and a remainder by a range
  patches 28-31   more forms of the jump that counts a loop
  patch   32      more targets of a call through a table of functions
  patches 33-35   24 arguments of static subprogs
  patches 36-37   1024 subprogs

The tests of a patch are in the patch behind it, or in the last patch of
its group. Patches 32 and 36 raise a limit and have no test of their own.
Patches 3, 4 and 8 are fixes.

Precision
=========

  if (pkt + 54 > pkt_end || off > 38)
          return 0;
  *(u64 *)(pkt + off)

Today the verifier rejects the load: the range of pkt is 54 bytes, but the
sum has no range. With patch 1 the sum keeps the range, and the prog can
read the 16 bytes that are in the packet for each value of off.

  cpu = hash % nr_cpus;
  bit = 1 << order;

Today each result is an unknown scalar, unless the second operand is
a constant. With patch 26 the result has bounds that come from the ranges
of the two operands.

Loops
=====

Scalar evolution examines each loop before the main pass of the verifier.
For 'for (i = 0; i < 10; i++)' it calculates the number of iterations. If
it also has a formula for each live register that the loop changes, then
the verifier gives these registers their ranges over all iterations and
verifies the body one time. The verifier unrolls all other loops: it
verifies them one iteration at a time.

  loop --> is there a count? --> does each live register --> verified
                 |               have a formula?             one time
                 | no                  | no
                 v                     v
              unrolled              unrolled

Patch 8 is a fix: the second question got a wrong 'yes' for a number in
a part of a stack slot. The other patches let more loops pass:

  patch  question  the loop
  -----  --------  --------------------------------------------------------
  10     count     The bound is in .rodata.
  12     count     The counter is in the stack, and a helper gets the
                   address of a stack slot as a number.
  14     count     'r += 1; r += 1', 'r -= 1', '(u32)r' made of two shifts
  16     count     The first value or the bound is a range.
  18     formula   A number that only loses bits, a pointer to arena,
                   a register that gets the same constant each time
  20     count     The loop has more than 256 exits.
  22     formula   The counter is an 'int' that lives on the stack.
  24     count     'continue', or a copy of the test at the end of each
                   path: several back edges
  28     count     The latch is false in the first iteration.
  29     count     'for (i = 63; i >= 0; i--)', 'while (n--)'
  30     count     The latch tests a flag that a jump sets.

The latch is the jump that closes the loop.

The verifier relies on the count: nothing stops a counted loop at run time,
and the ranges of the variables come from the count. It does not rely on
the formulas of patch 18: it compares the state that returns to the loop
head with the state at the head.

The verifier verifies a counted loop with ranges and never goes back to one
iteration at a time. Thus each patch that counts more loops can lose a prog
that needs exact values in each iteration. The logs describe these progs.
None of them is in the corpora below.

Static subprogs and limits
==========================

BTF of a static subprog describes the source. It does not describe what the
compiler passes. rustc adds a hidden pointer to the result, and it passes
a pair in two registers. Then a function with 4 parameters takes
6 arguments.

  patch  the static subprog                  the verifier
  -----  ----------------------------------  ------------------------------
  3      has unreliable BTF and returns in   refuses fexit, fmod_ret and
         R0:R2                               fsession: they keep only R0
  4      reads a register of r1-r5 that BTF  marks BTF as unreliable: then
         does not have                       a trampoline keeps r1-r5
  6      loads more stack arguments than     accepts the prog, and refuses
         BTF has                             to attach a trampoline

  limit                                            today  with the series
  -----------------------------------------------  -----  ---------------
  arguments of a static subprog                       12               24
  subprogs                                           256             1024
  functions that a load from a table of functions     64             1024
  can give

The limits of kfuncs, trampolines and global subprogs do not change.

The limits are what the progs of https://github.com/4ast/rust-bpf need.
These progs do not load yet: they need more changes of the verifier.

Veristat changes
================

A: bpf-next d4bf9e34e299. B: this series. The two runs use the same
objects. The selftests that the series adds or changes are not counted:
they test the verifier itself.
Insns is the number of insns that the verifier processes. It is not the
size of a prog.
Progs is the number of progs that load in the two runs.

Corpus                 Progs  Insns (A)  Insns (B)      Insns (DIFF)
---------------------  -----  ---------  ---------  ----------------
selftests               3573    6993083    6574720  -418363 (-5.98%)
selftests, no_alu32     3430    6287968    6044572  -243396 (-3.87%)
selftests, cpuv4        3444    5120894    5117161    -3733 (-0.07%)
selftests, bpf_gcc      3211    1520384    1438463   -81921 (-5.39%)
37 builds of Cilium     5189   42046146   42046146       +0 (+0.00%)
sched-ext/scx            493    2971692    2851736  -119956 (-4.04%)
scx, as BPF CI has it    428    1321821    1315591    -6230 (-0.47%)
tools/sched_ext          240     118790     118790       +0 (+0.00%)
public progs of Meta     511   10383121   10360656   -22465 (-0.22%)

libarena is in the first row only.

Verdict changes
---------------

No prog is lost. 5 progs load only in B:

  scx_pandemonium.bpf.o     pandemonium_enqueue
  scx_pandemonium.bpf.o     pandemonium_select_cpu
  bpf_gcc/profiler1.bpf.o   raw_tracepoint__sched_process_exit
  bpf_gcc/profiler2.bpf.o   raw_tracepoint__sched_process_exit
  bpf_gcc/profiler3.bpf.o   raw_tracepoint__sched_process_exit

scx_pandemonium, patch 8: a counted loop also changes a 32-bit number in
the stack. The verifier took the slot for an unknown scalar and did not
unroll the loop. But the number differs each time at the loop head, so the
verifier cannot prune there: "The sequence of 8193 jumps is too complex".

profiler, patch 24: gcc moves a pointer through a map value and ends the
loop with 'if r7 != r4', where r4 is the pointer to the end. The verifier
does not decide this jump and goes on behind the last element: "invalid
access to map value". The loop has two back edges. With a count the pointer
has its range.

Regressions
-----------

Progs that load in the two runs. The larger Insns is 1,000 or more, and B
needs at least 5% more insns. The list is complete.

File                              Program            Insns (A)  Insns (B)      Insns (DIFF)
--------------------------------  -----------------  ---------  ---------  ----------------
lib_alloc_selftests_noasan.bpf.o  alloc_selftest         23569      29898   +6329 (+26.85%)
str_map_test.bpf.o                test_str_match           859       1038    +179 (+20.84%)
ci/scx_flow.bpf.o                 flow_dispatch         147592     166903  +19311 (+13.08%)
libarena_asan.bpf.o               test_buddy_create       4563       4865     +302 (+6.62%)
libarena_asan.bpf.o               arena_buddy_reset       4597       4900     +303 (+6.59%)
scx_pandemonium.bpf.o             pandemonium_tick        1044       1103      +59 (+5.65%)

alloc_selftest, test_str_match, flow_dispatch and pandemonium_tick shift,
divide or take a remainder by a range. The result was an unknown scalar.
With patch 26 it has bounds, so states that were equal differ now, and the
verifier prunes fewer paths. The same bounds decide jumps in other progs:
see scx_rusty and scx_flow below.

In the two progs of libarena loops that had no count are counted now.

Top wins (30 of 89)
-------------------

Progs that load in the two runs. The larger Insns is 1,000 or more, and B
needs at least 5% fewer insns. A prog that is in several builds is listed
one time: the build with the most insns in A.
no_alu32/, bpf_gcc/: the build of the selftests. ci/: scx, as BPF CI has
it. Ranked by percentage change, then by the change of Insns, file,
program.

File                                    Program                                  Insns (A)  Insns (B)       Insns (DIFF)
--------------------------------------  ---------------------------------------  ---------  ---------  -----------------
no_alu32/timer_start_delete_race.bpf.o  start_timer                                  46008         32   -45976 (-99.93%)
no_alu32/timer_start_delete_race.bpf.o  delete_elem                                  20004         15   -19989 (-99.93%)
no_alu32/access_map_in_map.bpf.o        access_map_in_array                          24606         43   -24563 (-99.83%)
no_alu32/access_map_in_map.bpf.o        access_map_in_htab                           24606         43   -24563 (-99.83%)
no_alu32/access_map_in_map.bpf.o        sleepable_access_map_in_array                24606         43   -24563 (-99.83%)
no_alu32/access_map_in_map.bpf.o        sleepable_access_map_in_htab                 24606         43   -24563 (-99.83%)
no_alu32/linked_list.bpf.o              clear_global_array_list                      15384         66   -15318 (-99.57%)
no_alu32/linked_list.bpf.o              clear_global_nested_list                      5634         25    -5609 (-99.56%)
no_alu32/linked_list.bpf.o              clear_global_list                             4866         22    -4844 (-99.55%)
no_alu32/linked_list.bpf.o              clear_map_list                                4877         33    -4844 (-99.32%)
no_alu32/linked_list.bpf.o              clear_inner_map_list                          4885         41    -4844 (-99.16%)
no_alu32/rhash.bpf.o                    test_rhash_update_elements                    8866        103    -8763 (-98.84%)
no_alu32/timer.bpf.o                    test1                                         5011        263    -4748 (-94.75%)
bpf_gcc/bpf_iter_unix.bpf.o             dump_unix                                     5591        302    -5289 (-94.60%)
libarena_asan.bpf.o                     test_buddy_alloc_multiple                   242319      17506  -224813 (-92.78%)
bpf_gcc/bpf_iter_task_stack.bpf.o       dump_task_stack                               7245        636    -6609 (-91.22%)
verity_enforce.bpf.o                    bpfj_verity_mmap_file                         6313        876    -5437 (-86.12%)
no_alu32/verifier_arena_large.bpf.o     big_alloc2                                    3231        487    -2744 (-84.93%)
bpf_gcc/rbtree_search_kptr.bpf.o        rbtree_search_kptr_ref                        1085        241     -844 (-77.79%)
libarena.bpf.o                          test_rbtree_add_remove_circular_reverse      13930       6349    -7581 (-54.42%)
bpf_gcc/profiler1.bpf.o                 kprobe__proc_sys_write                        2607       1250    -1357 (-52.05%)
no_alu32/linked_list.bpf.o              inner_map_list_push_pop_multiple             14553       7229    -7324 (-50.33%)
no_alu32/linked_list.bpf.o              map_list_push_pop_multiple                   14744       7420    -7324 (-49.67%)
no_alu32/linked_list.bpf.o              global_list_push_pop_multiple                13931       7201    -6730 (-48.31%)
bpf_gcc/profiler1.bpf.o                 tracepoint__syscalls__sys_enter_kill         24035      12812   -11223 (-46.69%)
ci/scx_rusty.bpf.o                      rusty_stopping                               21750      11901    -9849 (-45.28%)
bpf_gcc/profiler1.bpf.o                 raw_tracepoint__sched_process_exec            3080       1727    -1353 (-43.93%)
libarena.bpf.o                          test_rbtree_insert_many_noalloc              11478       6741    -4737 (-41.27%)
libarena.bpf.o                          test_rbtree_insert_many_update               11478       6741    -4737 (-41.27%)
scx_flow.bpf.o                          flow_select_cpu                             145475      89352   -56123 (-38.58%)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (37):
  bpf: Keep the range of a packet pointer when a number >= 0 is added
  selftests/bpf: Test range of a packet pointer after a number is added
  bpf: Refuse fexit on an unreliable static subprog that returns in
    R0:R2
  bpf: Don't trust BTF of a static subprog that reads more registers
  selftests/bpf: Test trampolines on subprogs that take more than BTF
    says
  bpf: Count stack arguments of a static subprog from its code
  selftests/bpf: Test static subprogs that don't take what BTF says
  bpf: Don't treat a partial spill as widened in scalar evolution
  selftests/bpf: Test loops that change a partial spill
  bpf: Let scalar evolution see loads from read-only maps
  selftests/bpf: Test scalar evolution with a loop bound in .rodata
  bpf: Helpers don't write through ARG_ANYTHING
  selftests/bpf: Test scalar evolution with stack address as
    ARG_ANYTHING
  bpf: Fold sums of constants and two shifts by 32 in scalar evolution
  selftests/bpf: Test sums of constants and shifts by 32 in scalar
    evolution
  bpf: Count loops whose first value or bound is a range
  selftests/bpf: Test loops whose first value or bound is a range
  bpf: Describe more registers of a counted loop
  selftests/bpf: Test more registers of a counted loop
  bpf: Compute scev for a loop that has more than 256 exits
  selftests/bpf: Test a loop with 301 exits
  bpf: Describe a 32-bit counter that lives on the stack
  selftests/bpf: Test a 32-bit counter that lives on the stack
  bpf: Count a loop with several back edges
  selftests/bpf: Test loops with several back edges
  bpf: Compute bounds for a shift, a division and a remainder by a range
  selftests/bpf: Test a shift, a division and a remainder by a range
  bpf: Count a loop whose latch is false in the first iteration
  bpf: Count '!=' across 0 in 32 bits and loops that go down
  bpf: Count a loop whose latch tests a flag that a jump sets
  selftests/bpf: Test more latches of counted loops
  bpf: Allow BPF_MAX_SUBPROGS targets of a read from a table of
    functions
  bpf: Keep the frame of analyze_subprog() small
  bpf: Allow 24 arguments of static subprogs
  selftests/bpf: Test a static subprog with 24 arguments
  bpf: Bump BPF_MAX_SUBPROGS to 1024
  selftests/bpf: Make room in veristat for the stats of 1024 subprogs

 include/linux/bpf.h                           |   19 +-
 include/linux/bpf_verifier.h                  |   40 +-
 kernel/bpf/backtrack.c                        |    2 +-
 kernel/bpf/btf.c                              |   18 +-
 kernel/bpf/const_fold.c                       |   11 +-
 kernel/bpf/fixups.c                           |    2 +-
 kernel/bpf/liveness.c                         |   34 +-
 kernel/bpf/loops.c                            |  105 +-
 kernel/bpf/scev.c                             | 1041 +++++++++++++++--
 kernel/bpf/verifier.c                         |  263 +++--
 .../selftests/bpf/prog_tests/tracing_struct.c |   30 +-
 .../selftests/bpf/prog_tests/verifier.c       |    4 +
 .../bpf/progs/tracing_struct_int128_tgt.c     |   22 +-
 .../bpf/progs/tracing_struct_int128_tracer.c  |    6 +-
 .../selftests/bpf/progs/verifier_alu_range.c  |  168 +++
 .../bpf/progs/verifier_direct_packet_access.c |  100 ++
 .../selftests/bpf/progs/verifier_loop_latch.c |  165 +++
 .../selftests/bpf/progs/verifier_precision.c  |   11 +-
 .../selftests/bpf/progs/verifier_scev.c       |  692 ++++++++++-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  325 ++++-
 .../bpf/progs/verifier_stack_arg_order.c      |    8 +-
 tools/testing/selftests/bpf/veristat.c        |    7 +-
 22 files changed, 2749 insertions(+), 324 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_alu_range.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_loop_latch.c

-- 
2.55.0

