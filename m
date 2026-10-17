Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE2392C3D
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278594; cv=none; b=SKY6PXjQns2BcIzu/ZVVax2ttk8G1Vak3g3S3vc7I4ShfIekGbQ1lwutr6nZ+fu9La/pfSzgxgwbh3taN9kvMQTFTlTFX5yWP6EiNVSAVWIO99ckwg/qImcFTTY651nRpLDOFYA4oaRou6HnAmpvzqENR6AR7MRR9VPkiOmyKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278594; c=relaxed/simple;
	bh=vBB3U5M4Sfy7+uA4Fmssl39OQjybOECJSmarZHBVfL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ej5a+Q6Np9dBeljT+KoYz+pw90vvyU8s8LM0RedpeKSNik8SrBKPoRAHIAt+fCXulUNiGzIySbQoCuXnZlV/olp2P0tBST9rYNq++r0awuV9tWlogh3ZbH3/Ytah36IIT1xbySka7Fmy4hzLSOCWea50yuevHPwNGkg9Wx6yidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1np2/OI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1np2/OI"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e946155442so7681625ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278593; x=1792883393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0s42RPJjSg3gaj1FHh8IoUY+hAhMc8Dn2AxNPxFrcWo=;
        b=a1np2/OIpYzMKkbqkD2cQHXWRRikSOe1EiWW/FKXyTrWdEoX55mY/NG/PQuGrTkiCk
         dWH/asIi5jfxcHtkj58xH9YVz4PPZ5zxipE9KRsADSlzHvWQDbbCp2S+qNf2puQ9Yn3X
         w4/QgD9hjrVYdoNarszJ/MZHMAar/6G/NZsaA8EF+1fy9m0ZfNNV8e2hefYqwqPzmjOC
         Lg9hFltxNCkW/gDVGKkJrwpr6LTMC3Rtiq0mwskNUO99yOo6EpI3xxnPOGclPHgns2qr
         d5wZ1S5ohwOBCaeOTDfDXlxdy+HPR0pyv7o45TpWgctR7qVMZuMctHjEf28TG11e9oyI
         OSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278593; x=1792883393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0s42RPJjSg3gaj1FHh8IoUY+hAhMc8Dn2AxNPxFrcWo=;
        b=m/ZQtkCp5qvqC/KeGhEuZX+D4QnPiMN2bjwkjRjYn5Lo+IZEc3/GvFiHwI3UaxeSoK
         NKIBagJn4JbtBAKrz8TCV11N7TjRe5El71IABGlPKCMdlvWo+fHu9uAp/4+JC8kC//Hf
         bi5lLwgGbaUawCsApjrHbVvNB8Zf/pfP5HvyGZoovOUlMZG+RwDyPpZoobBCqbP6q9f3
         51Nr5VdI6pVyN1rw1GkCHSZ+BtpPQC+V5iFGZtLVDBZcR/5dz+ngXQxbZhegIuJI5eiW
         iFuKBn+tKQ9lprWotVsUK/8FeQSsnDf2zigmbvH7AvPOAH3wMEuflVU8YxU3j/8pCnoe
         j3WA==
X-Gm-Message-State: AFq9FYKk6bNAIHtD9LKXNH6yuN/Byjdpduwjzed3SkUxghQePFikUkgr
	x9B0H1vodJRdmzM6kugS9ZSFd8J8pH48PSaWybt74YFPrkshOITu1cc9GUxi5Q==
X-Gm-Gg: AYBFou3fQCEaAGmptT2e1dl1wuNTpb2seTZaKIQU9nKh0U+acAjJ3vhVfpVDGb21rQQ
	4UP8KX6ch7yhvG08aOZco/DNX4zDZ/D/bWNqouSLuWgDgjJD/zsRfEdmBLHiQbmFCSp0AN4hfHA
	YO4ehjwDM4GcW3kusVRPs41AQzPMSmuijv1JLFhOmvKLcexvHcgQguS+CFe75mTcUtrA5oMomrB
	6bHk1nqkNSPkRXJodqdWD1xgnRj5n2LFnN+GXBpjWUk3AJE/WRNl4GIMZfmUkWW9HN9wUPYr/hG
	H4jRsyFwY281Khh2Y0BVxDY1OClpsaOOxOn+Etr8DnPDpPDdZa4H+YDhFQN7qr0XKIjhUtE5cl4
	XJgKH/KlcRmCjSzaZL7X9NRH2UrpIa4fKtZ9zYXiSwqZ3Bqn48XI4vVxy+XFqEi+wO9sMMpMKvj
	uATnC525ZIcRQslEOsqqOPjeoF8lSeM8xcuMCWUBUhORgaObw2DJOCUufdAB93PmkYaknuQMMwj
	OMPws2AVhRdeIhEMGlbvU/4Poo3X+Mr9/sAq1MA9jwbvsZ1BORQt4moCOmHZE7JN5c8q99U2ZYj
	R5h7eB2NxjQ88yeJ5o89nzwhCX1019wjNOKcGyj2mx4=
X-Received: by 2002:a17:903:1a0e:b0:2e5:db61:e5d4 with SMTP id d9443c01a7336-2e9a7360229mr35061885ad.62.1792278592781;
        Sat, 17 Oct 2026 16:09:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e9esm25161345ad.27.2026.10.17.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:09:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 00/16] bpf: Memory safety, lifetime and locking fixes (followups)
Date: Sat, 17 Oct 2026 23:09:34 +0000
Message-ID: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The first 30 patches of v2 are applied. This is the rest of the series,
with what the reviews of v2 have found, and two fixes on top of patches
that are applied already. Most of the patches are from Josef.

Every bug was reproduced in a VM on top of bpf-next, on the kernel right
before and right after the patch that fixes it. The splats are in the
commit logs. That goes for what the reviews have found as well.

Programs that are attached to other programs:
  01 a tracing program with a target program passes for an iterator program
  02 extensions reach further into the context than their target
  04 extensions of functions that run sleepable
  11 extensions get the unclone prologue without an skb in R1

Lifetime of local storage, programs, sockets and devices:
  03 values of a dead owner are freed under sleepable programs
  05 the exception table of a program that still runs is not found
  06 BPF_PROG_TEST_RUN of sk_lookup uses the socket outside of RCU
  07 cpumap uses the device of a queued frame after it is gone

Dynptrs of packets, where a write can reallocate the head of the skb:
  08 kfuncs that write through a dynptr
  09 bpf_dynptr_write() in a global function
  10 a dynptr passed to a global function
  12 kfuncs that write through a dynptr do not unclone the skb
  13 the source of the write is a slice of the same skb
  14 overlapping source and destination in an skb
  15 overlapping source and destination in an xdp_buff
  16 slices as arguments of helpers that change the packet

Some of the fixes make the kernel refuse what it has accepted so far:

 - 01: a tracing program with BPF_TRACE_ITER cannot have a target program.
 - 02: an extension of a raw tracepoint, tracepoint or syscall program
   cannot be attached if it reaches further into the context than that
   program. A program that leaves the context to its extensions has to
   touch as much of it as they do.
 - 04: the main function of a sleepable program, and a global function that
   is called without the RCU read lock, cannot be extended. The
   summarization selftest is adjusted.
 - 08-10, 16: packet pointers and slices are invalidated in more places.
   That hits some programs which are harmless at run time. A program that
   keeps a packet pointer across a global function which only writes to a
   ringbuf dynptr is one example.
 - 11: an extension of a tc, lwt_xmit or sk_skb program that writes to
   packet data has to get the context as its first argument, and scalars
   beside it.

test_progs in its three flavors, test_maps and test_verifier show no new
failures. cpumask/test_insert_leave is flaky when the tests run in
parallel, with and without the series: its program does not check
is_test_task(), so any other fork in the system makes it fail.

veristat sees no difference for the 5691 programs of the selftests, nor for
the 466 programs of the sched_ext schedulers that BPF CI builds: same
verdicts, insns, states and stack depth.

v2 -> v3, after the reviews by sashiko and the BPF CI bot. The numbers in
brackets are those of v2:
 - rebased on top of patches 1-30
 - 01: new. A tracing program with attach_prog_fd got around [26].
 - 02: new. What [28] says of max_tp_access holds for max_ctx_offset too.
 - 03 [31]: map_free() took smap away from an element whose fields
   destroy() had left to the RCU Tasks Trace callback: they were leaked
 - 09 [37]: Fixes tag
 - 10 [38]: the dynptr of the bpf_user_ringbuf_drain() callback was taken
   for an argument of a global function
 - 11 [39]: look at the arguments only if there is a prologue. Extensions
   of XDP, sk_msg and sockopt programs were refused for no reason.
 - 14 [42], 16 [43]: commit logs
 - 15: new. XDP was missed in [42].
 - 05 [33], 07 [35]: no change. The symbols have to outlive the grace
   period, and an order 3 allocation per cpumap entry is fine.

Not in this version: the prologue of an extension can move the head of the
skb under the packet pointers of its caller, as sashiko has pointed out for
[39]. To count such an extension as one that changes packet data would
refuse what commit 7e40781cc8b7 ("bpf: verifier: Use target program's type
for access verifications") has made possible. That takes more thought.

v2: https://lore.kernel.org/bpf/20261017163745.3341787-1-alexei.starovoitov@gmail.com/
v1: https://lore.kernel.org/bpf/20261017012058.355787-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (6):
  bpf: Don't take a program with a target program for an iterator
  bpf: Don't let an extension reach further into the context than its
    target
  bpf: Don't take an extension for a function that runs sleepable
  bpf: Refuse the prologue for an extension that cannot take it
  bpf: Unclone the skb for kfuncs that write through a dynptr
  bpf: Use memmove() to store bytes in an xdp_buff

Josef Bacik (10):
  bpf: Keep values of a dead owner for sleepable programs
  bpf: Keep the symbols of a program until it has ended
  bpf: Use the socket of a sk_lookup test run under RCU
  bpf, cpumap: Hold the device of frames in the queue
  bpf: Drop packet pointers behind kfuncs writing an skb
  bpf: Let bpf_dynptr_write() mark a global function
  bpf: Don't take a dynptr argument for a local dynptr
  bpf: Follow the head if an skb is written from a slice
  bpf: Use memmove() to store bytes in an skb
  bpf: Refuse packet slices for packet-changing helpers

 include/linux/bpf.h                           |  2 +
 include/linux/bpf_verifier.h                  |  2 +
 kernel/bpf/bpf_iter.c                         |  6 +-
 kernel/bpf/bpf_local_storage.c                | 31 +++++--
 kernel/bpf/cfg.c                              |  4 +-
 kernel/bpf/core.c                             | 50 +++++++----
 kernel/bpf/cpumap.c                           | 35 ++++++--
 kernel/bpf/fixups.c                           | 25 ++++++
 kernel/bpf/map_in_map.c                       |  7 +-
 kernel/bpf/syscall.c                          | 18 +++-
 kernel/bpf/verifier.c                         | 90 +++++++++++++++++--
 net/bpf/test_run.c                            | 19 ++--
 net/core/filter.c                             | 28 +++++-
 .../selftests/bpf/prog_tests/summarization.c  | 21 ++---
 14 files changed, 265 insertions(+), 73 deletions(-)


base-commit: c058636f788f8751e419b407206516280226e568
-- 
2.55.0

