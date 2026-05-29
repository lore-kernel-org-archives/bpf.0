Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542C17D6
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041704; cv=pass; b=qYtxed8W0rUGfJionPLUy3bFYQIFkyMrTBmbf0ogVqf6+kkw+GbJZ1Nwf2YRqknQQfQ+MnxecSYVRuFmeaswHRNmEPyHWc1cZru+3j6gQWJj1TvCdv/Cf1Au+sB2Qtzje0R+NqTQRmxKu6L0Zt5vavVhlSp31z3Xx/wEvU0ZPl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041704; c=relaxed/simple;
	bh=BnSxB7MNKfuACgGegp9vQcxDloM1Xn3kSs5NA/LfGys=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mXaAHxJxqOVR1qRtnPCGERblGT3Q2Fr9cX0j1xsMGibwrtvCD1mQsB8lsxI7sZpZciIY8IO6eui9oMlQhYND/crheX0h9iM79Oy6MEopkMIuVtDt6ziMCK6GxMGzpeXrOHLlSYHWqUMCYIVbgl6ok2dvpyS66h4BWwuZyPjicvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClH2unIb; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClH2unIb"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd6460b0d11so2360845266b.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780041702; cv=none;
        d=google.com; s=arc-20240605;
        b=SjMuuADGR1nOqwHDPeDgM2vRIjxk5PuNcCRipI9mN4EaeewUoz/IPNjrjjtRBn33zX
         UxJcrkPHxZWagn4fjQfBC9LScDa/wOIWGRLVJyu+TvWI5yVAR38baaqxwdz9/xpor1aa
         Tjg9H8q6xpRlfO8LdXJkmljz1Dt0Jh3TheBzt4r2VPyxSeeToUmygTYC9Bek+tDXNeJl
         gJd9bXL9GRoav3rIbmSLhSlf7jVd0aBnGsu7lShPByH59lcbU/UVWpbxd9IPKfohfL78
         7euzJMzD9k/oTE5axf2O6wgldpIGRpAuXr+Cmwe+MhFFzApFq69W8hIcpQAV7ekcLxtc
         DaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p/7hRCDFxLMueRxm6cxWJtgPYfIyfdwPUvmOsgwP1QU=;
        fh=wHql9FK0lR9j+J1Tr70gAh7XWBJLqC+vzAahHYLqcNI=;
        b=evG4Mmvz8zZUp/G60fpsqTNLOX+w0gvhsuI5pgQ3X2z1r/FzKMu7t6S+4gpYZdStah
         H/eeK0yly5Out0ALi/tbw4w0nTLBUjBpPEgVQPpM6ci69lZkQCgi8eENrxbBAZv+t7am
         23B5NF2zMnX5AqAKTVRDhGpPpzWAkPFtGXv+pQ7VYQ94hCy5YzBzdxk+id5FrmWZ270A
         mLRQ+DS56fLWMX9NCw7mC5GrNMxRGVIe59nimkQ0hmWXAQ3uyHzEsupqh8uEueZAIU2Z
         zna4qRbChyG/v7fq/DkFf6jtSQszEDj51ya/Gpvnof9r59BTF2KTRhtLYpwQONEfPx8z
         vINg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780041702; x=1780646502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/7hRCDFxLMueRxm6cxWJtgPYfIyfdwPUvmOsgwP1QU=;
        b=ClH2unIbPJTEo1SNnZsS2e2NT6FZPN5C+fAEbewY3xh8a2FTsALKSz8eJbUomkISqI
         0sc6IKrjfTJf/rLhEYAdV85uHdPYVMHyorPLkgiV8NCh7JpA9k061756DpdvNPt9LDvh
         o/jTuaOjo+SOlBzBDdvu5DW0UE7Ou23Ue61KSzbXkAZzyhDDauO4BPTrMIm/GX3kaALf
         rA0LbGMrAWeBbJv5NUYEpHuqvqZb3ZATcl6/7ZpJ4lhogC0fz+UKOnHxIomhJfKvskJA
         H3WvFOEH9gE3r5daAInymZrUA46JrFAvm5YIkxxNg6IwDKPtR1Su6isoYuVNDpgxhtRc
         dMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780041702; x=1780646502;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/7hRCDFxLMueRxm6cxWJtgPYfIyfdwPUvmOsgwP1QU=;
        b=Y4tNcNiqVVy+UFRtvHq5jCOCM7cSgqz6FmvCe9rz+LMRhM+lGYnm1ftoWSnqGodBy1
         dj0KKomgg++vpGpjewrKZUMUsckxRnYFF4C7S8duERQqh0QP8X8kYWevWEhRBfxiWov2
         5plNCOXCWErrvecQA5ettsavSM40+x26B5cofw2Dvja9tTUyw99PbQgaYI5nO4ftUFcq
         lXd2cDj+Xp/H+zA8Blngp3Feh/DadclPQAKDoBs62ARTV9tVCt9WCHQ/Bm+1rr8qcIR9
         UguDpperOGSl/AYmgN29VeZ0YWYgG3yHz6NGZdxCpgkHEfAkiFfo0Lj3EwGH1q0eA/uT
         In/A==
X-Gm-Message-State: AOJu0YwpTf8J85c6uQt9d3g4XG2MEuIzJIhYAnDBI8r3j5VPBDPBbKNV
	I7DuE9vgBS3D7fK8rrDH0TFSvjHvfYxYi1xjP4WzpdVI1ZslgY7trChm3HiEfNoSyNVMDO1rTxz
	X9jPCdUoTt2OHjssCPO3lyH9LJ+aGB9qxY48K3Ts=
X-Gm-Gg: Acq92OHCGL5lfy9tMWneBusPFO1IzP+pXuwrIDA0v1i2iLN3QN2r6ABXmqaGZmcGiDY
	Iv37M50ID3zUVlvS5SIhtY/1rk5Oh4ia94v0teKnchr/WPqf8WazPJUG3TZ16dnXWQblvRs52Kn
	zfTtipDdls1KqRHgtyVusW+T6cwhr9HgfrXsb1BNcv2H3/WvVFWEdUrtjaZJMRyqauOE+TuWZcA
	YDZPfsNf45g8yFJzJhDGGO3osVecJeLJVMTXOv3Oe0/G+PzfdbaqTEdjgz6XdIGg44w+j0iclVu
	0NwCElb1vKMGhdyiIVUBmS+a8rLmZksmd9qzpRKzLB5YhZra4A==
X-Received: by 2002:a17:907:7b91:b0:bd4:7bed:512a with SMTP id
 a640c23a62f3a-be9ccd77561mr82061066b.30.1780041701586; Fri, 29 May 2026
 01:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Fri, 29 May 2026 17:01:02 +0900
X-Gm-Features: AVHnY4JQvv523fz0OjYrhufApmA8nMXikUDlTLVeTqDx-h6qgEpNtI_ZkFuyy10
Message-ID: <CAOrxSK5_7e4114VyfEU9htGi+UneuNt88fGVKOAa3_ZenPOFkA@mail.gmail.com>
Subject: [PATCH v2] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, puranjay@kernel.org
Content-Type: text/plain; charset="UTF-8"

bpf_find_vma() reads task->mm without holding task_lock() or taking an
mm reference via mmget()/mmget_not_zero(). When called on a foreign task
obtained via bpf_task_from_pid(), a concurrent exit_mm() can free the
mm_struct between the raw pointer read and mmap_read_trylock(mm),
resulting in a use-after-free on the mm's mmap_lock.

This is the same bug class fixed by commit d8e27d2d22b6 ("bpf: fix mm
lifecycle in open-coded task_vma iterator") for the open-coded task_vma
iterator, but bpf_find_vma() in the same file was missed by that fix.

For the current task, task->mm is stable and needs no extra reference.
For a foreign task, use get_task_mm() which acquires task_lock(), checks
task->mm, and calls mmget() atomically, preventing the race with
exit_mm(). The reference is dropped via mmput() after the mmap lock is
released.

Race:
  CPU0 (BPF program)                  CPU1 (exiting task)
  ============================        ==========================
  bpf_find_vma(foreign_task):
    mm = task->mm
    // raw read, no reference
                                      exit_mm():
                                        task->mm = NULL
                                        mmput(mm) -> frees mm_struct
    mmap_read_trylock(mm)
    // UAF: mm is freed

Reproduction:

  1. Build kernel >= 5.17 with CONFIG_KASAN=y, CONFIG_BPF_SYSCALL=y
  2. Boot in a VM (QEMU works fine)
  3. Compile the reproducer below:
       gcc -O2 -o repro -static repro.c -lbpf -lelf -lz
  4. Run as root: ./repro
  5. Check dmesg for: BUG: KASAN: slab-use-after-free in down_read_trylock

  The reproducer attaches a BPF program that calls bpf_find_vma() on a
  foreign task obtained via bpf_task_from_pid(). A racing thread
  repeatedly fork+exit's that task, creating a window where mm is freed.

KASAN report (reproduced on 6.12.91, CONFIG_PREEMPT + KASAN):

  BUG: KASAN: slab-use-after-free in down_read_trylock+0x380/0x3f0
  Read of size 8 at addr ffff888003cd2fd0 by task repro/164451

  Call Trace:
   down_read_trylock+0x380/0x3f0
   bpf_find_vma+0xdd/0x360
   bpf_prog_708df9c9a3e172a7_main_f+0x8b/0x9e
   bpf_trampoline_6442513469+0x43/0xa3

  Freed by task 164453:
   kmem_cache_free+0x15d/0x4b0
   finish_task_switch.isra.0+0x4ab/0x810

Fixes: 7c7e3d31e785 ("bpf: Introduce helper bpf_find_vma")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
v2: Rebased onto bpf-next to fix merge conflict (no code changes).

 kernel/bpf/task_iter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index e791ae065c..015399e62b 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -757,6 +757,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
task, u64, start,
  struct vm_area_struct *vma;
  bool irq_work_busy = false;
  struct mm_struct *mm;
+ bool foreign = task != current;
  int ret = -ENOENT;

  if (flags)
@@ -765,7 +766,12 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
task, u64, start,
  if (!task)
  return -ENOENT;

- mm = task->mm;
+ if (foreign) {
+ mm = get_task_mm(task);
+ } else {
+ mm = task->mm;
+ }
+
  if (!mm)
  return -ENOENT;

@@ -782,6 +788,8 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *,
task, u64, start,
  ret = 0;
  }
  bpf_mmap_unlock_mm(work, mm);
+ if (foreign)
+ mmput(mm);
  return ret;
 }

-- 
2.48.1
