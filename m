Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABC28B4FD
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110853; cv=none; b=J5b5MuwN8BZ10CCUqGGVkgzEGXDIMabhiMrnsfunVJ5+2SW+hOJ6duiVWnf49lSyBhkL7SYpZaPs1Y121VKZVaNjNMHz6UBC09/nISzTWBkDsx+eLy9hCTiAvwZAZrq4tQLuut+UtwEBmzfOu860DWY3NTmJ1u2R7fJ8Yurf7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110853; c=relaxed/simple;
	bh=O5J0vYzDS7A+/iIa4EdklVFws50tlMNiHPs02QGGc3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1ZQ2IbE+iL45XwID1p1B1Jy+nCh2HbvZArQJPtL8Tce+dafDxp5RhjSaA/x7vRyotgBlvhqOBYzQVadabN2dG6S168CLOfcu6fVA6cTt0/ZhkeZMc3DGlFLTQucoGcVFJuL5R1gWw99X4KnmCOX1K/3jF+e514TgZwtvPxktvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT7oxRAZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT7oxRAZ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8ac4806e210so43566427b3.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792110851; x=1792715651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gfgwBh8XWxGCsSck4UIs9y6r8K229wZcXz7rxtjthGQ=;
        b=IT7oxRAZGPvMteQEIJvLCQeq42tHPkMiDpnamv+hvBZL0spXtpHKbh5aSGfwvb1IA0
         uGGE/POaj3gf+xzNP2vSDteSp4hwuHlUeG+NkmPjrN+W8JPN36L3CGsL68v3L96NC9ML
         ifjJD1FEVXKWvuJfx5yJvQG914R7dROmH24rJzY0JfThcv3Hxrlwk7PSoR2fECt9N8w7
         Ko6AfRMyB8M42IbkKliGYm6ZB8oEjANkpGx5YeWoKz4cBoRlcvvaGSbHII6r2PvDSyt6
         yJHaZAO9p3wp3SOhKRILq5heO1IZROOdiGFh8IC/rl8Y62Wc1O+ef/xdlqr42QF0Et/e
         ULFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110851; x=1792715651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gfgwBh8XWxGCsSck4UIs9y6r8K229wZcXz7rxtjthGQ=;
        b=eSW1aTF7ldl5wEeZxhOl6V+a9QFVCakijsi+wOnKaFwGAOm1Q2EjiBwA73R5jEF/Ie
         /9T8XuEpz1tqfOzUYOP+CquMvQgg1kYftxWHfKagaxcfW+H63zC3N5nVF8FRtkF8bvtI
         q5eZ4HVq0QH+2invQr7CUu2uUNEDBZDAO//6cBOeSP+IgH0OeQqFrBawQWCJZrgqV3Gk
         0Sw1qkOq2AfGdRbBxmATvgr75mAbT7x1b6dpguas/CH8yeCQaA9/nrgcU2zAeyzTVluA
         pxbIFbHrh3aa1IEez7Hcel8sxOyIGC2etxfRzXLK/sjN4dliKIo7LdKwcN+rqkid+lXf
         FoQA==
X-Gm-Message-State: AFq9FYLT9grybpJ1tZClgRBgMIf2TW+JAzzMdjC7NksWTLYVj5tq8tCM
	+OIKG7q6bLPPdck3lVOo8YzYY8Zr9lsNtOz9u5G/g0w0lg/TkMfFcOZR2hq3FYys5As=
X-Gm-Gg: AYBFou1OPjZUEUv8sHAkfNZ7JIsRidhsRa2W341F/q5ZnNG07Q9kfWtEB1Op3bEvtfj
	vIUJiahOaaw9oNF+heahVy2kVcAejd8RkESAQl/NadT2nemcz5a5H/kS+fQiKyI9R+ez/gPhYoH
	xF9ZPqm27TDTRs1e4DPXqnPtPHy756NZgBT+n0uUzKdfCgzQZTTAIjVQOMV4+bG0U+ew4JltnIB
	tZhstJSe/z6lcweiedhkN03GQdgLfyDWt7+EkD9gxs8J9VoSpeOMgLCGVy2fWC7kfukJ5tXYENU
	Lp5wYUIbzjHxypFJpseuubzsEUUN9inF12HIUHg8G6yMpKdoA5PgqRFwSp2Q3OZS9xFYHJFNrdj
	H/hbGA94zEVQVvJf6RbFgH2YmSpo+NpdgWcRP54venc3IfLyWVrCK1IPPeSJKraIWtwPvN7UlB/
	94ki+hSssqe/yh8m2MszTIcw5sD3h5IqQfqTVui2rw59bZKLDOkLA=
X-Received: by 2002:a05:690c:39d:b0:873:5c0f:283 with SMTP id 00721157ae682-8b07eda095bmr83218097b3.45.1792110850855;
        Thu, 15 Oct 2026 17:34:10 -0700 (PDT)
Received: from corey ([2600:1702:5081:b900::49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e58892cfsm2982937b3.10.2026.10.15.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 17:34:09 -0700 (PDT)
From: Igor Malovitsa <igor.malovitsa@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org,
	Igor Malovitsa <igor.malovitsa@gmail.com>
Subject: [PATCH bpf 0/2] bpf: Fix ring buffer checks on 32-bit position wrap
Date: Fri, 16 Oct 2026 00:33:16 +0000
Message-ID: <20261016003318.529860-1-igor.malovitsa@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two more places where ring buffer positions are compared in a way that
breaks once they wrap on a 32-bit kernel. Two earlier fixes of the same
kind are commit 6ff5b56a50c5
("bpf: Fix pending_pos walk on 32-bit ring position wrap") and
commit 3f611e9b820e
("bpf: Fix available-data accounting on 32-bit wrap in overwrite mode").
The remaining two:

- __bpf_ringbuf_reserve() reads consumer_pos before taking the lock, so
  a reservation that stalls long enough can pass the space check with a
  value about 2^32 bytes stale and overwrite records the consumer has
  not read.

- __bpf_user_ringbuf_peek() widens the positions to u64 and compares
  them, so once producer_pos wraps and consumer_pos has not, the ring
  reads as empty from then on and the user-space producer gets -ENOSPC.

Both need about 4 GiB of ring traffic on a 32-bit kernel. Neither
changes anything on 64-bit.

How they were found and tested: a formal model of the ring buffer
protocol, written in Lean on the ORC11 memory model with the help of an
LLM coding assistant, showed both executions. Each was then confirmed on
32-bit QEMU guests (i386, arm and riscv32) by a test-only initcall (not
part of this series) that puts the positions in the wrapped state and
calls the real __bpf_ringbuf_reserve() and __bpf_user_ringbuf_peek():
without the patches it reports both bugs, with them both cases behave
correctly. With each patch, kernel/bpf/ringbuf.c builds without warnings
with W=1 on x86_64 and i386.

No selftest is added: reaching the states needs about 4 GiB of traffic
or instrumentation that only a test build can have.

The ring buffer selftests pass with the series applied on x86_64,
aarch64 and riscv64 (vmtest.sh, test_progs -t ringbuf: ringbuf,
ringbuf_multi, user_ringbuf and verifier_ringbuf, 33 subtests), and on
x86_64 without it. On riscv64 QEMU ran with -cpu max: the cross-compiled
test_progs uses Zbb/Zcb instructions that the CPU vmtest.sh picks lacks.

Reproducer (test-only, not for merging): a late_initcall in ringbuf.c,
built for i386 (tinyconfig), arm and riscv32 (their defconfigs), each
with BPF_SYSCALL, and booted in QEMU. For the first bug, a hook between
the consumer_pos load and the lock in __bpf_ringbuf_reserve() stands in
for the stalled reservation: it moves the positions to where 4 GiB of
traffic would leave them, so the load before the lock still holds the
old 0. Condensed, without the message prefix:

  /* hook, called just before raw_res_spin_lock_irqsave() */
  WRITE_ONCE(rb->consumer_pos, ULONG_MAX - PAGE_SIZE + 1);
  WRITE_ONCE(rb->producer_pos, ULONG_MAX - 7);
  WRITE_ONCE(rb->pending_pos, ULONG_MAX - 7);

  /* initcall: the ring is full, so the reservation must fail */
  rb = bpf_ringbuf_alloc(PAGE_SIZE, NUMA_NO_NODE, false);
  if (__bpf_ringbuf_reserve(rb, 0))
      pr_emerg("cons-under-lock: BUG reproduced (reservation accepted)\n");
  else
      pr_emerg("cons-under-lock: fixed (reservation rejected)\n");

  /* one empty sample at consumer_pos, producer_pos just past the wrap */
  rb = bpf_ringbuf_alloc(PAGE_SIZE, NUMA_NO_NODE, false);
  rb->consumer_pos = ULONG_MAX - 7;
  rb->producer_pos = 0;
  hdr = (void *)rb->data + (rb->consumer_pos & rb->mask);
  hdr->len = 0;
  hdr->pg_off = 0;
  err = __bpf_user_ringbuf_peek(rb, &sample, &size);
  if (err == -ENODATA)
      pr_emerg("user-ringbuf-wrap: BUG reproduced (false empty)\n");
  else if (!err && size == 0)
      pr_emerg("user-ringbuf-wrap: fixed (sample found)\n");

Output without this series:

  BPF_RINGBUF_REPRO: cons-under-lock: BUG reproduced (reservation accepted)
  BPF_RINGBUF_REPRO: user-ringbuf-wrap: BUG reproduced (false empty)

and with it:

  BPF_RINGBUF_REPRO: cons-under-lock: fixed (reservation rejected)
  BPF_RINGBUF_REPRO: user-ringbuf-wrap: fixed (sample found)

Igor Malovitsa (2):
  bpf: Load ringbuf consumer_pos under the spinlock
  bpf: Fix user ringbuf empty check on 32-bit position wrap

 kernel/bpf/ringbuf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
-- 
2.53.0

