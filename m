Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4D3A872D
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038564; cv=pass; b=ET1Mx4EVWMlM5ZhrtaKCDez4oGTAP6r7j4O6s8Wlr3aMb2CTWtelGOdLrgrY5ug/lkyAthcJh+3zP75ifd4fGL6UbBD1XMuQY2Va1MnFXvfwOuwZw54B5L4NSKi+GA4DfCIdg5nQAift/waGxgEM7otJj1FBcQBNqmPxM18WCNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038564; c=relaxed/simple;
	bh=SvUE8CnaEnS9fsy3s6Vbf2aoFF7Z+40Uk97TWO4mhyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GEkrolRonkryIgJpltVnkvD632xpsOw6g3M1pNaqkGKUoDHjzIHGFv1Tq1FCjScutsDM1imn4l6o3D9UfVj9hJRc5AgK/w7NnrXf+/PFd8qivi0QKCchiU8KDSn0G6W7mA0j9vdJSHdwvR8EAD2EMLZozphX8YvGkL/8HWKozmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Gwmafd; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Gwmafd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45e6a4d0be0so6121703f8f.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 00:09:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780038560; cv=none;
        d=google.com; s=arc-20240605;
        b=DnyenfqacI6T4FV7+Ey68h97pVKjHq9XKaR4AqrKpy6FUJu2N2y9ivhCkaK6gxjNm0
         HP8zttC7VPSgbXf6LWXXBEGTBPPjIFJyDz6+ZppHQ5hXufyT6uRlp2dNq9qaLMwixj+J
         XSmdWZaAEm/IB/HJHks6248lKKFaS6vIEvqBFjbwaWXbGNwRCQyX6u/KLOzw1I3TTGyx
         LjPPcTlvAynVIg5A3f99jcm9Ug8CGafvSkSRxH0hkfVcU8zRSnNMMRjJd7Q/a8Eo573h
         f1UuIqInKUAmad3MIk9hvseu8FRLK/IWlCZ3S2L+XczOzXCsLKv5vlp/7A6yPkcwxDTK
         P4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7uZiQmfV4FOqTWrZGTDWbxEiU7+oAPPLXfmifWX+kbU=;
        fh=wHql9FK0lR9j+J1Tr70gAh7XWBJLqC+vzAahHYLqcNI=;
        b=LalehjRKpqwPQzxQOdg4FjdG6FnwZUOMhXC7ztgoERtCvNkFfchUVS6DYnEOG0cMtg
         iCOjaMSppxemLejQRTP1I4RdS2V72wge2kswQuS17gHkzEZA9FlO8LpIRMdGQFgpqL29
         6G3xuROUsYOQZJvRheqeWHjauEcW4CtAzja6mNWTs1D0ohKZFyKnXNAXXqdFSyP5Mf+F
         EtainsbKJfi51pBhl/qBO4rrEg2WoyAnnoEaKltUGE7+zNwan7Q7pXAlWT9FpiE/VWfG
         9WXNvsd+sVrhHfiXuiBx+7I/k09G5X7GA7lQf7zXihTO8DJ61Aipq/CWwvS/ZkMMXUj3
         VZQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780038560; x=1780643360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7uZiQmfV4FOqTWrZGTDWbxEiU7+oAPPLXfmifWX+kbU=;
        b=l7GwmafdI+Rwakck462Lx3d+zIMSmtjEZeNnmempkLQ/LhO+nO0nEcTUs3c+mkK5cb
         WkbxiAqjpMNr7o4TItqnVcjozEAzC42hYqt2jlVceNCIC5wptnQmozXAQJ+qSEWNSn0+
         UbicLbna9+CiGDSlByYkNoQG75lyYeHx7nSVj1PU833Hjtd3jlTPB6sIy/C1FTT2LWIw
         6LIQSjMcEmGpE6IMb2D+oJpLOEfVuNYw3cDgO/aWXh1UFUkhIUxFwJPRq/mwR0Zy83W1
         8zZGpDBIiBCRBfUTr/CDSNWW0/tdaHMq4j30P1KFaQVX18BkiMJ1IlkNUGA6LRLXpHrn
         BEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038560; x=1780643360;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uZiQmfV4FOqTWrZGTDWbxEiU7+oAPPLXfmifWX+kbU=;
        b=p2BsxwadPO36sdLcguiyixIS65KwMSi46sYWvrrqRwj5XkEIGP923cR7HHMXOye9+l
         mIzOZV2PmmmgdKZoSerS/2ULib98hMyC2YnSKbbwB+zQjPLkiWPfR+l13LkdUXBZUUs5
         PMRGfNxl9qWPBxQ7vEoPNHfyxs9O+aYugqWriEWbaMAKTQuMu81UD/03scxKJjDOh99l
         bvT/fy/q+Aogvy5+L9dVSjNbsW8h2H8CLoH1pfzaeoaiLo8swlS2KqKmz+tw6RoF9l4M
         kWIFKaPQgiiXENv1AXn74s28hkPHvcxTkifqMf+rVI3hgXBFM95ocA3cOOV5DNfm1HHm
         h/pg==
X-Gm-Message-State: AOJu0YyVb7B6i6DzI852eHsVU7cs3ZoOxZQVdcP1gZ0k8ocLYeWASEPN
	myE3r4NF9wTC0lFX6JVNtcGtN16obAr9sez9xd9WxCx3j9r2WANaeHeB7gzjYQoTIUUNQHc9Qda
	R7ZESoXbDSLllnYlgbBd81jRCRcLJ9yavSZnK
X-Gm-Gg: Acq92OFlBsBDKY1FkVfXckk3WVTPKFlF0HvFdhpH5q2kY71hQPGbDGCOGRGOQyhvHT9
	49nTkyfIJufMBg2CgWgEG25GMIJPZAgLC5Z3orY0zKucGJz0bkK1cDQYBhxAfaeLJd8yTRawqna
	P8Hl2s6IaEBr//t7V2stWH43KAZk+u7iUCR3Jy33+X7baVvjjIPNcIZUss5bwJHRHuuj26VhAZm
	u1OnrymXyOZfMjwu8+7H8A2Y+W8VY/ACQRPEV/t547t8Z2bYLp5UMhKEcf/GHcIU69QXPGcrqnP
	cZ8vFSaIwFrVe02g/QDe7MPUmlnR1IDZ6Ds+e78YpbS1RbrKVA==
X-Received: by 2002:a05:6000:4694:b0:45e:ee40:2185 with SMTP id
 ffacd0b85a97d-45ef142f104mr1896461f8f.14.1780038559751; Fri, 29 May 2026
 00:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Date: Fri, 29 May 2026 16:08:42 +0900
X-Gm-Features: AVHnY4LZaxUq8eoX_eQysBHfqeMagstnYNgR-Bm8DRkjS5m_nj0TgwoIH5Nxsq8
Message-ID: <CAOrxSK5sKv=8icjkT_SO67QcD=jE-ErcfYW2CksNoa6aHibDgw@mail.gmail.com>
Subject: [PATCH] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, puranjay@kernel.org
Content-Type: multipart/mixed; boundary="0000000000000a7b2a0652ef8681"

--0000000000000a7b2a0652ef8681
Content-Type: multipart/alternative; boundary="0000000000000a7b290652ef867f"

--0000000000000a7b290652ef867f
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

Hi,

I'm Sanghyun Park, a security researcher. I found this while auditing
the BPF task_iter code. The bug has existed since bpf_find_vma() was
introduced in 5.17 and affects all kernels since then, including all
major distros (Ubuntu 22.04+, Fedora 38+, Debian 12+, RHEL 9+).

The C reproducer is attached separately (repro.c).

 kernel/bpf/task_iter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 5af9e130e5..a1b2c3d4e5 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -758,6 +758,7 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,
u64, start,
  struct vm_area_struct *vma;
  bool irq_work_busy = false;
  struct mm_struct *mm;
+ bool foreign = task != current;
  int ret = -ENOENT;

  if (flags)
@@ -766,8 +767,13 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,
u64, start,
  if (!task)
  return -ENOENT;

- mm = task->mm;
- if (!mm)
+ if (foreign) {
+ mm = get_task_mm(task);
+ } else {
+ mm = task->mm;
+ }
+
+ if (!mm)
  return -ENOENT;

  irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
@@ -783,6 +789,8 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,
u64, start,
  ret = 0;
  }
  bpf_mmap_unlock_mm(work, mm);
+ if (foreign)
+ mmput(mm);
  return ret;
 }

--0000000000000a7b290652ef867f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">bpf_find_vma() reads task-&gt;mm without holding task_lock=
() or taking an<br>mm reference via mmget()/mmget_not_zero(). When called o=
n a foreign task<br>obtained via bpf_task_from_pid(), a concurrent exit_mm(=
) can free the<br>mm_struct between the raw pointer read and mmap_read_tryl=
ock(mm),<br>resulting in a use-after-free on the mm&#39;s mmap_lock.<br><br=
>This is the same bug class fixed by commit d8e27d2d22b6 (&quot;bpf: fix mm=
<br>lifecycle in open-coded task_vma iterator&quot;) for the open-coded tas=
k_vma<br>iterator, but bpf_find_vma() in the same file was missed by that f=
ix.<br><br>For the current task, task-&gt;mm is stable and needs no extra r=
eference.<br>For a foreign task, use get_task_mm() which acquires task_lock=
(), checks<br>task-&gt;mm, and calls mmget() atomically, preventing the rac=
e with<br>exit_mm(). The reference is dropped via mmput() after the mmap lo=
ck is<br>released.<br><br>Race:<br><br>=C2=A0 CPU0 (BPF program) =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CPU1 (exiting task)<br>=
=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=C2=A0 bpf_find_vma(=
foreign_task):<br>=C2=A0 =C2=A0 mm =3D task-&gt;mm<br>=C2=A0 =C2=A0 // raw =
read, no reference<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 exit_mm():<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 task-&gt;mm =3D NULL<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmput(mm) -&gt; frees mm_struct<br>=C2=A0 =
=C2=A0 mmap_read_trylock(mm)<br>=C2=A0 =C2=A0 // UAF: mm is freed<br><br>Re=
production:<br><br>=C2=A0 1. Build kernel &gt;=3D 5.17 with CONFIG_KASAN=3D=
y, CONFIG_BPF_SYSCALL=3Dy<br>=C2=A0 2. Boot in a VM (QEMU works fine)<br>=
=C2=A0 3. Compile the reproducer below:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0gcc -=
O2 -o repro -static repro.c -lbpf -lelf -lz<br>=C2=A0 4. Run as root: ./rep=
ro<br>=C2=A0 5. Check dmesg for: BUG: KASAN: slab-use-after-free in down_re=
ad_trylock<br><br>=C2=A0 The reproducer attaches a BPF program that calls b=
pf_find_vma() on a<br>=C2=A0 foreign task obtained via bpf_task_from_pid().=
 A racing thread<br>=C2=A0 repeatedly fork+exit&#39;s that task, creating a=
 window where mm is freed.<br><br>KASAN report (reproduced on 6.12.91, CONF=
IG_PREEMPT + KASAN):<br><br>=C2=A0 BUG: KASAN: slab-use-after-free in down_=
read_trylock+0x380/0x3f0<br>=C2=A0 Read of size 8 at addr ffff888003cd2fd0 =
by task repro/164451<br><br>=C2=A0 Call Trace:<br>=C2=A0 =C2=A0down_read_tr=
ylock+0x380/0x3f0<br>=C2=A0 =C2=A0bpf_find_vma+0xdd/0x360<br>=C2=A0 =C2=A0b=
pf_prog_708df9c9a3e172a7_main_f+0x8b/0x9e<br>=C2=A0 =C2=A0bpf_trampoline_64=
42513469+0x43/0xa3<br><br>=C2=A0 Freed by task 164453:<br>=C2=A0 =C2=A0kmem=
_cache_free+0x15d/0x4b0<br>=C2=A0 =C2=A0finish_task_switch.isra.0+0x4ab/0x8=
10<br><br>Fixes: 7c7e3d31e785 (&quot;bpf: Introduce helper bpf_find_vma&quo=
t;)<br>Signed-off-by: Sanghyun Park &lt;<a href=3D"mailto:sanghyun.park.cnu=
@gmail.com">sanghyun.park.cnu@gmail.com</a>&gt;<br>---<br><br>Hi,<br><br>I&=
#39;m Sanghyun Park, a security researcher. I found this while auditing<br>=
the BPF task_iter code. The bug has existed since bpf_find_vma() was<br>int=
roduced in 5.17 and affects all kernels since then, including all<br>major =
distros (Ubuntu 22.04+, Fedora 38+, Debian 12+, RHEL 9+).<br><br>The C repr=
oducer is attached separately (repro.c).<br><br>=C2=A0kernel/bpf/task_iter.=
c | 12 ++++++++++--<br>=C2=A01 file changed, 10 insertions(+), 2 deletions(=
-)<br><br>diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c<br>i=
ndex 5af9e130e5..a1b2c3d4e5 100644<br>--- a/kernel/bpf/task_iter.c<br>+++ b=
/kernel/bpf/task_iter.c<br>@@ -758,6 +758,7 @@ BPF_CALL_5(bpf_find_vma, str=
uct task_struct *, task, u64, start,<br>=C2=A0	struct vm_area_struct *vma;<=
br>=C2=A0	bool irq_work_busy =3D false;<br>=C2=A0	struct mm_struct *mm;<br>=
+	bool foreign =3D task !=3D current;<br>=C2=A0	int ret =3D -ENOENT;<br>=C2=
=A0<br>=C2=A0	if (flags)<br>@@ -766,8 +767,13 @@ BPF_CALL_5(bpf_find_vma, s=
truct task_struct *, task, u64, start,<br>=C2=A0	if (!task)<br>=C2=A0		retu=
rn -ENOENT;<br>=C2=A0<br>-	mm =3D task-&gt;mm;<br>-	if (!mm)<br>+	if (forei=
gn) {<br>+		mm =3D get_task_mm(task);<br>+	} else {<br>+		mm =3D task-&gt;m=
m;<br>+	}<br>+<br>+	if (!mm)<br>=C2=A0		return -ENOENT;<br>=C2=A0<br>=C2=A0=
	irq_work_busy =3D bpf_mmap_unlock_get_irq_work(&amp;work);<br>@@ -783,6 +7=
89,8 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,<br=
>=C2=A0		ret =3D 0;<br>=C2=A0	}<br>=C2=A0	bpf_mmap_unlock_mm(work, mm);<br>=
+	if (foreign)<br>+		mmput(mm);<br>=C2=A0	return ret;<br>=C2=A0}<div><br></=
div></div>

--0000000000000a7b290652ef867f--
--0000000000000a7b2a0652ef8681
Content-Type: text/plain; charset="US-ASCII"; name="crash-log.txt"
Content-Disposition: attachment; filename="crash-log.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpqkyoo01>
X-Attachment-Id: f_mpqkyoo01

WyAgNjE1LjU2NTcwM10gQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0ZXItZnJlZSBpbiBkb3duX3Jl
YWRfdHJ5bG9jaysweDM4MC8weDNmMApbICA2MTUuNTY2NDY3XSBSZWFkIG9mIHNpemUgOCBhdCBh
ZGRyIGZmZmY4ODgwMDNjZDJmZDAgYnkgdGFzayByZXByby8xNjQ0NTEKClsgIDYxNS41NjczODJd
IENQVTogMCBVSUQ6IDAgUElEOiAxNjQ0NTEgQ29tbTogcmVwcm8gTm90IHRhaW50ZWQgNi4xMi45
MSAjNApbICA2MTUuNTY3MzkyXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFVidW50dSAyNS4wNCBQQyAo
aTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNi4zLWRlYmlhbi0xLjE2LjMtMiAwNC8wMS8y
MDE0ClsgIDYxNS41Njc0MDBdIENhbGwgVHJhY2U6ClsgIDYxNS41Njc0MTNdICA8VEFTSz4KWyAg
NjE1LjU2NzQyM10gIGR1bXBfc3RhY2tfbHZsKzB4YmEvMHgxMTAKWyAgNjE1LjU2NzQzN10gID8g
ZG93bl9yZWFkX3RyeWxvY2srMHgzODAvMHgzZjAKWyAgNjE1LjU2NzQ0Ml0gIHByaW50X3JlcG9y
dCsweDE3NC8weDRmNgpbICA2MTUuNTY3NDUwXSAgPyBfX3ZpcnRfYWRkcl92YWxpZCsweDg2LzB4
NjcwClsgIDYxNS41Njc0NTZdICA/IGRvd25fcmVhZF90cnlsb2NrKzB4MzgwLzB4M2YwClsgIDYx
NS41Njc0NjJdICBrYXNhbl9yZXBvcnQrMHhkYS8weDExMApbICA2MTUuNTY3NDY5XSAgPyBkb3du
X3JlYWRfdHJ5bG9jaysweDM4MC8weDNmMApbICA2MTUuNTY3NDc1XSAgZG93bl9yZWFkX3RyeWxv
Y2srMHgzODAvMHgzZjAKWyAgNjE1LjU2NzQ4MV0gID8gX19wZnhfZG93bl9yZWFkX3RyeWxvY2sr
MHgxMC8weDEwClsgIDYxNS41Njc0ODZdICA/IGJwZl9maW5kX3ZtYSsweGIxLzB4MzYwClsgIDYx
NS41Njc0OTRdICA/IDB4ZmZmZmZmZmZjMDIzNmQwOApbICA2MTUuNTY3NTExXSAgYnBmX2ZpbmRf
dm1hKzB4ZGQvMHgzNjAKWyAgNjE1LjU2NzUyMF0gIGJwZl9wcm9nXzcwOGRmOWM5YTNlMTcyYTdf
bWFpbl9mKzB4OGIvMHg5ZQpbICA2MTUuNTY3NTI0XSAgYnBmX3RyYW1wb2xpbmVfNjQ0MjUxMzQ2
OSsweDQzLzB4YTMKWyAgNjE1LjU2NzUyOF0gIF9fZG9fc3lzX2dldHBpZCsweDkvMHgzMApbICA2
MTUuNTY3NTMzXSAgZG9fc3lzY2FsbF82NCsweGJiLzB4MWYwClsgIDYxNS41Njc1NDBdICBlbnRy
eV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmClsgIDYxNS41Njc1NjNdIFJJUDog
MDAzMzoweDQyM2UxZApbICA2MTUuNTY3NTY4XSBDb2RlOiBkNSA0OSA4ZCAzYyAxYyBlYiA5ZiA2
NiAwZiAxZiA0NCAwMCAwMCBmMyAwZiAxZSBmYSA0OCA4OSBmOCA0OCA4OSBmNyA0OCA4OSBkNiA0
OCA4OSBjYSA0ZCA4OSBjMiA0ZCA4OSBjOCA0YyA4YiA0YyAyNCAwOCAwZiAwNSA8NDg+IDNkIDAx
IGYwIGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGQwIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAxIDQ4
ClsgIDYxNS41Njc1NzNdIFJTUDogMDAyYjowMDAwN2ZkMmUxNTRiMWE4IEVGTEFHUzogMDAwMDAy
NDYgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMjcKWyAgNjE1LjU2NzU5M10gUkFYOiBmZmZmZmZm
ZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMTM3YSBSQ1g6IDAwMDAwMDAwMDA0MjNlMWQKWyAg
NjE1LjU2NzU5OF0gUkRYOiAwMDAwMDAwMDAwNDIzZTFkIFJTSTogMDAwMDAwMDAwMDQyM2UxZCBS
REk6IDAwMDAwMDAwMDA0MjNlMWQKWyAgNjE1LjU2NzYwMV0gUkJQOiAwMDAwN2ZkMmUxNTRiMmYw
IFIwODogMDAwMDAwMDAwMDAwMDAwMSBSMDk6IDAwMDAwMDAwMDAwMDAwMDEKWyAgNjE1LjU2NzYw
NF0gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAw
MDAwMDAwMDAwMjAKWyAgNjE1LjU2NzYwN10gUjEzOiBmZmZmZmZmZmZmZmZmZmQwIFIxNDogMDAw
MDAwMDAwMDAwMDAwMCBSMTU6IDAwMDA3ZmZjOWQyZjBlMzAKWyAgNjE1LjU2NzYxM10gIDwvVEFT
Sz4KClsgIDYxNS41ODQzOTFdIEFsbG9jYXRlZCBieSB0YXNrIDE2NDQ1MzoKWyAgNjE1LjU4NDc5
N10gIGthc2FuX3NhdmVfc3RhY2srMHgzMC8weDUwClsgIDYxNS41ODUyMjZdICBrYXNhbl9zYXZl
X3RyYWNrKzB4MTQvMHgzMApbICA2MTUuNTg1NjQ2XSAgX19rYXNhbl9zbGFiX2FsbG9jKzB4ODkv
MHg5MApbICA2MTUuNTg2MDgxXSAga21lbV9jYWNoZV9hbGxvY19ub3Byb2YrMHgxMzMvMHgzNDAK
WyAgNjE1LjU4NjU4MV0gIGNvcHlfbW0rMHgzMjcvMHgyMzgwClsgIDYxNS41ODY5NTNdICBjb3B5
X3Byb2Nlc3MrMHg2YzViLzB4NzE4MApbICA2MTUuNTg3MzgyXSAga2VybmVsX2Nsb25lKzB4MTAx
LzB4ODcwClsgIDYxNS41ODc3OTZdICBfX2RvX3N5c19jbG9uZSsweGRhLzB4MTIwClsgIDYxNS41
ODgyMTNdICBkb19zeXNjYWxsXzY0KzB4YmIvMHgxZjAKWyAgNjE1LjU4ODYxN10gIGVudHJ5X1NZ
U0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YKClsgIDYxNS41ODkzNTJdIEZyZWVkIGJ5
IHRhc2sgMTY0NDUzOgpbICA2MTUuNTg5NzIxXSAga2FzYW5fc2F2ZV9zdGFjaysweDMwLzB4NTAK
WyAgNjE1LjU5MDE0NV0gIGthc2FuX3NhdmVfdHJhY2srMHgxNC8weDMwClsgIDYxNS41OTA1NjRd
ICBrYXNhbl9zYXZlX2ZyZWVfaW5mbysweDNiLzB4NzAKWyAgNjE1LjU5MTAxNF0gIF9fa2FzYW5f
c2xhYl9mcmVlKzB4NGYvMHg3MApbICA2MTUuNTkxNDQ2XSAga21lbV9jYWNoZV9mcmVlKzB4MTVk
LzB4NGIwClsgIDYxNS41OTE4NzJdICBmaW5pc2hfdGFza19zd2l0Y2guaXNyYS4wKzB4NGFiLzB4
ODEwClsgIDYxNS41OTIzODhdICBfX3NjaGVkdWxlKzB4ZjM5LzB4MmZjMApbICA2MTUuNTkyNzg1
XSAgc2NoZWR1bGUrMHhkZi8weDM0MApbICA2MTUuNTkzMTUzXSAgZG9fbmFub3NsZWVwKzB4MTU0
LzB4NTAwClsgIDYxNS41OTM1NTZdICBocnRpbWVyX25hbm9zbGVlcCsweDE1MC8weDM1MApbICA2
MTUuNTkzOTk5XSAgY29tbW9uX25zbGVlcCsweGE2LzB4ZDAKWyAgNjE1LjU5NDQwMF0gIF9feDY0
X3N5c19jbG9ja19uYW5vc2xlZXArMHgzM2MvMHg0ODAKWyAgNjE1LjU5NDkxMl0gIGRvX3N5c2Nh
bGxfNjQrMHhiYi8weDFmMApbICA2MTUuNTk1MzIyXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NzcvMHg3ZgoKWyAgNjE1LjU5NjA1Ml0gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25n
cyB0byB0aGUgb2JqZWN0IGF0IGZmZmY4ODgwMDNjZDJlNDAKICAgICAgICAgICAgICAgIHdoaWNo
IGJlbG9uZ3MgdG8gdGhlIGNhY2hlIG1tX3N0cnVjdCBvZiBzaXplIDIxOTIKWyAgNjE1LjU5NzMw
OV0gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCA0MDAgYnl0ZXMgaW5zaWRlIG9mCiAgICAg
ICAgICAgICAgICBmcmVlZCAyMTkyLWJ5dGUgcmVnaW9uIFtmZmZmODg4MDAzY2QyZTQwLCBmZmZm
ODg4MDAzY2QzNmQwKQoKWyAgNjE1LjU5ODc1MF0gVGhlIGJ1Z2d5IGFkZHJlc3MgYmVsb25ncyB0
byB0aGUgcGh5c2ljYWwgcGFnZToKWyAgNjE1LjU5OTMzNl0gcGFnZTogcmVmY291bnQ6MSBtYXBj
b3VudDowIG1hcHBpbmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4M2NkMApbICA2
MTUuNjAwMTcxXSBoZWFkOiBvcmRlcjozIG1hcGNvdW50OjAgZW50aXJlX21hcGNvdW50OjAgbnJf
cGFnZXNfbWFwcGVkOjAgcGluY291bnQ6MApbICA2MTUuNjAwOTcyXSBtZW1jZzpmZmZmODg4MDAy
NzgxODAxClsgIDYxNS42MDEzNTddIGFub24gZmxhZ3M6IDB4MTAwMDAwMDAwMDAwMDQwKGhlYWR8
bm9kZT0wfHpvbmU9MSkKWyAgNjE1LjYwMTk3NF0gcGFnZV90eXBlOiBmNShzbGFiKQpbICA2MTUu
NjAyMzM0XSByYXc6IDAxMDAwMDAwMDAwMDAwNDAgZmZmZjg4ODEwMDA0ZmRjMCAwMDAwMDAwMDAw
MDAwMDAwIGRlYWQwMDAwMDAwMDAwMDEKWyAgNjE1LjYwMzE0NV0gcmF3OiAwMDAwMDAwMDAwMDAw
MDAwIDAwMDAwMDAwMDAwZDAwMGQgMDAwMDAwMDFmNTAwMDAwMCBmZmZmODg4MDAyNzgxODAxClsg
IDYxNS42MDM5NjBdIGhlYWQ6IDAxMDAwMDAwMDAwMDAwNDAgZmZmZjg4ODEwMDA0ZmRjMCAwMDAw
MDAwMDAwMDAwMDAwIGRlYWQwMDAwMDAwMDAwMDEKWyAgNjE1LjYwNDc3N10gaGVhZDogMDAwMDAw
MDAwMDAwMDAwMCAwMDAwMDAwMDAwMGQwMDBkIDAwMDAwMDAxZjUwMDAwMDAgZmZmZjg4ODAwMjc4
MTgwMQpbICA2MTUuNjA1NTkxXSBoZWFkOiAwMTAwMDAwMDAwMDAwMDAzIGZmZmZlYTAwMDAwZjM0
MDEgZmZmZmZmZmZmZmZmZmZmZiAwMDAwMDAwMDAwMDAwMDAwClsgIDYxNS42MDY0MDZdIGhlYWQ6
IDAwMDAwMDAwMDAwMDAwMDggMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMGZmZmZmZmZmIDAwMDAw
MDAwMDAwMDAwMDAKWyAgNjE1LjYwNzIxOF0gcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJh
ZCBhY2Nlc3MgZGV0ZWN0ZWQKClsgIDYxNS42MDc5OTFdIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhl
IGJ1Z2d5IGFkZHJlc3M6ClsgIDYxNS42MDg1MDJdICBmZmZmODg4MDAzY2QyZTgwOiBmYiBmYiBm
YiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYgpbICA2MTUuNjA5MjYwXSAg
ZmZmZjg4ODAwM2NkMmYwMDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIg
ZmIgZmIgZmIKWyAgNjE1LjYxMDAxNF0gPmZmZmY4ODgwMDNjZDJmODA6IGZiIGZiIGZiIGZiIGZi
IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiClsgIDYxNS42MTA3ODFdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeClsgIDYxNS42MTEzOTRd
ICBmZmZmODg4MDAzY2QzMDAwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYiBmYgpbICA2MTUuNjEyMTU3XSAgZmZmZjg4ODAwM2NkMzA4MDogZmIgZmIgZmIgZmIg
ZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIKWyAgNjE1LjYxMjkwOV0gPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClsgIDYxNS42NzIzNjhdIERpc2FibGluZyBsb2NrIGRlYnVnZ2luZyBkdWUgdG8ga2VybmVs
IHRhaW50Cg==
--0000000000000a7b2a0652ef8681
Content-Type: application/octet-stream; name="repro.c"
Content-Disposition: attachment; filename="repro.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mpqkyedg0>
X-Attachment-Id: f_mpqkyedg0

LyoKICogcmVwcm8uYyDigJQgS0FTQU4gUG9DIGZvciBicGZfZmluZF92bWEoKSBmb3JlaWduIG1t
IFVBRgogKgogKiBCdWc6IGJwZl9maW5kX3ZtYSgpIHJlYWRzIHRhc2stPm1tIChsaW5lIDc3Mikg
d2l0aG91dCBob2xkaW5nIHRhc2tfbG9jaygpCiAqIG9yIGNhbGxpbmcgbW1nZXQoKS4gSWYgYSBm
b3JlaWduIHRhc2sgZXhpdHMgY29uY3VycmVudGx5LCBtbV9zdHJ1Y3QgaXMKICogZnJlZWQgYmV0
d2VlbiB0aGUgcmF3IHJlYWQgYW5kIG1tYXBfcmVhZF90cnlsb2NrKCksIGNhdXNpbmcgVUFGLgog
KgogKiBTYW1lIGJ1ZyBjbGFzcyBhcyBmaXhlZCBpbiAyMzljZWMyNWEyICh0YXNrX3ZtYSBpdGVy
YXRvcikgYnV0IHRoZQogKiBicGZfZmluZF92bWEoKSBoZWxwZXIgd2FzIG1pc3NlZCBpbiB0aGF0
IGZpeC4KICoKICogVHJpZ2dlcjogQlBGX1BST0dfVFlQRV9UUkFDSU5HIChmZW50cnkgb24gX194
NjRfc3lzX2dldHBpZCkgcHJvZ3JhbQogKiBjYWxsaW5nIGJwZl90YXNrX2Zyb21fcGlkKCkgKyBi
cGZfZmluZF92bWEoKSBvbiBhIHZpY3RpbSB0YXNrIHRoYXQKICogaXMgY29uY3VycmVudGx5IGV4
aXRpbmcuCiAqCiAqIFByZXJlcXVpc2l0ZXM6IENBUF9CUEYgKyBDQVBfUEVSRk1PTiAodHJhY2lu
ZyBCUEYpCiAqCiAqIEV4cGVjdGVkIEtBU0FOIG91dHB1dDoKICogICBCVUc6IEtBU0FOOiBzbGFi
LXVzZS1hZnRlci1mcmVlIGluIG1tYXBfcmVhZF90cnlsb2NrKzB4Li4uLzB4Li4uCiAqICAgUmVh
ZCBvZiBzaXplIDggYXQgYWRkciBmZmZmLi4uCiAqICAgQ2FsbCBUcmFjZToKICogICAgYnBmX2Zp
bmRfdm1hCiAqICAgIGJwZl90cmFjaW5nX2Z1bmNfcHJvdG8KICovCiNkZWZpbmUgX0dOVV9TT1VS
Q0UKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8cHRocmVh
ZC5oPgojaW5jbHVkZSA8c2NoZWQuaD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3Rk
aW50Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxz
dHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNs
dWRlIDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy9z
dGF0Lmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgojaW5jbHVkZSA8bGludXgvYnBmLmg+CiNpbmNs
dWRlIDxsaW51eC9wZXJmX2V2ZW50Lmg+CgovKiAtLS0tIEJQRiBpbnN0cnVjdGlvbiBtYWNyb3Mg
LS0tLSAqLwojZGVmaW5lIEJQRl9SQVdfSU5TTihDT0RFLERTVCxTUkMsT0ZGLElNTSkgXAogICAg
KChzdHJ1Y3QgYnBmX2luc24pey5jb2RlPUNPREUsLmRzdF9yZWc9RFNULC5zcmNfcmVnPVNSQywu
b2ZmPU9GRiwuaW1tPUlNTX0pCiNkZWZpbmUgQlBGX01PVjY0X1JFRyhELFMpIEJQRl9SQVdfSU5T
TihCUEZfQUxVNjR8QlBGX01PVnxCUEZfWCxELFMsMCwwKQojZGVmaW5lIEJQRl9NT1Y2NF9JTU0o
RCxJKSBCUEZfUkFXX0lOU04oQlBGX0FMVTY0fEJQRl9NT1Z8QlBGX0ssRCwwLDAsSSkKI2RlZmlu
ZSBCUEZfQUxVNjRfSU1NKE8sRCxJKSBCUEZfUkFXX0lOU04oQlBGX0FMVTY0fEJQRl9PUChPKXxC
UEZfSyxELDAsMCxJKQojZGVmaW5lIEJQRl9MRFhfTUVNKFNaLEQsUyxPKSBCUEZfUkFXX0lOU04o
QlBGX0xEWHxCUEZfU0laRShTWil8QlBGX01FTSxELFMsTywwKQojZGVmaW5lIEJQRl9TVFhfTUVN
KFNaLEQsUyxPKSBCUEZfUkFXX0lOU04oQlBGX1NUWHxCUEZfU0laRShTWil8QlBGX01FTSxELFMs
TywwKQojZGVmaW5lIEJQRl9TVF9NRU0oU1osRCxPLEkpIEJQRl9SQVdfSU5TTihCUEZfU1R8QlBG
X1NJWkUoU1opfEJQRl9NRU0sRCwwLE8sSSkKI2RlZmluZSBCUEZfSk1QX0lNTShPLEQsSSxGKSBC
UEZfUkFXX0lOU04oQlBGX0pNUHxCUEZfT1AoTyl8QlBGX0ssRCwwLEYsSSkKI2RlZmluZSBCUEZf
RVhJVF9JTlNOKCkgQlBGX1JBV19JTlNOKEJQRl9KTVB8QlBGX0VYSVQsMCwwLDAsMCkKI2RlZmlu
ZSBCUEZfTERfTUFQX0ZEKEQsRikgQlBGX1JBV19JTlNOKEJQRl9MRHxCUEZfRFd8QlBGX0lNTSxE
LDEsMCxGKSxCUEZfUkFXX0lOU04oMCwwLDAsMCwwKQojZGVmaW5lIEJQRl9FTUlUX0NBTEwoRikg
QlBGX1JBV19JTlNOKEJQRl9KTVB8QlBGX0NBTEwsMCwwLDAsRikKI2RlZmluZSBCUEZfRU1JVF9D
QUxMX0tGVU5DKEIpIEJQRl9SQVdfSU5TTihCUEZfSk1QfEJQRl9DQUxMLDAsMiwwLEIpCiNpZm5k
ZWYgQlBGX1BTRVVET19GVU5DCiNkZWZpbmUgQlBGX1BTRVVET19GVU5DIDQKI2VuZGlmCgojZGVm
aW5lIFZJQ1RJTV9NTUFQX0FERFIgMHgyMDAwMDAwMFVMTAojZGVmaW5lIFZJQ1RJTV9NTUFQX1NJ
WkUgMHg0MDAwCgpzdGF0aWMgaW50IGJwZl9zeXMoaW50IGMsIHVuaW9uIGJwZl9hdHRyICphLCB1
bnNpZ25lZCBzKQp7CiAgICByZXR1cm4gc3lzY2FsbChfX05SX2JwZiwgYywgYSwgcyk7Cn0KCi8q
IC0tLS0gQlRGIGhlbHBlcnMgKHJldXNlZCBmcm9tIEJ1ZyAjMikgLS0tLSAqLwpzdGF0aWMgaW50
IGZpbmRfa2Z1bmMoY29uc3QgY2hhciAqbmFtZSkKewogICAgaW50IGZkID0gb3BlbigiL3N5cy9r
ZXJuZWwvYnRmL3ZtbGludXgiLCBPX1JET05MWSk7CiAgICBpZiAoZmQgPCAwKSByZXR1cm4gLTE7
CiAgICBvZmZfdCBzeiA9IGxzZWVrKGZkLCAwLCBTRUVLX0VORCk7IGxzZWVrKGZkLCAwLCBTRUVL
X1NFVCk7CiAgICB1aW50OF90ICpkID0gbWFsbG9jKHN6KTsKICAgIHNpemVfdCB0ciA9IDA7CiAg
ICB3aGlsZSAodHIgPCAoc2l6ZV90KXN6KSB7IHNzaXplX3QgbiA9IHJlYWQoZmQsIGQrdHIsIHN6
LXRyKTsgaWYgKG48PTApIGJyZWFrOyB0ciArPSBuOyB9CiAgICBjbG9zZShmZCk7CiAgICB1aW50
MzJfdCBobCA9ICoodWludDMyX3QqKShkKzQpLCB0byA9ICoodWludDMyX3QqKShkKzgpOwogICAg
dWludDMyX3QgdGwgPSAqKHVpbnQzMl90KikoZCsxMiksIHNvID0gKih1aW50MzJfdCopKGQrMTYp
OwogICAgdWludDhfdCAqdGQgPSBkK2hsK3RvLCAqc2QgPSBkK2hsK3NvOwogICAgdWludDMyX3Qg
b2ZmID0gMDsgaW50IHRpZCA9IDAsIGZvdW5kID0gLTE7CiAgICB3aGlsZSAob2ZmIDwgdGwpIHsK
ICAgICAgICB0aWQrKzsKICAgICAgICB1aW50MzJfdCAqdCA9ICh1aW50MzJfdCopKHRkK29mZik7
CiAgICAgICAgaW50IGtpbmQgPSAodFsxXT4+MjQpJjB4MWYsIHZsZW4gPSB0WzFdJjB4ZmZmZjsK
ICAgICAgICBpZiAoa2luZCA9PSAxMiAmJiBzdHJjbXAoKGNoYXIqKShzZCt0WzBdKSwgbmFtZSkg
PT0gMCkgeyBmb3VuZCA9IHRpZDsgYnJlYWs7IH0KICAgICAgICBvZmYgKz0gMTI7CiAgICAgICAg
c3dpdGNoKGtpbmQpIHsKICAgICAgICAgICAgY2FzZSAxOiBvZmYrPTQ7IGJyZWFrOyAgICAgICAv
KiBJTlQgKi8KICAgICAgICAgICAgY2FzZSAyOiBicmVhazsgICAgICAgICAgICAgICAvKiBQVFIg
Ki8KICAgICAgICAgICAgY2FzZSAzOiBvZmYrPTEyOyBicmVhazsgICAgICAvKiBBUlJBWSAqLwog
ICAgICAgICAgICBjYXNlIDQ6IGNhc2UgNTogb2ZmKz12bGVuKjEyOyBicmVhazsgLyogU1RSVUNU
LCBVTklPTiAqLwogICAgICAgICAgICBjYXNlIDY6IG9mZis9dmxlbio4OyBicmVhazsgIC8qIEVO
VU0gKi8KICAgICAgICAgICAgY2FzZSA3OiBicmVhazsgICAgICAgICAgICAgICAvKiBGV0QgKi8K
ICAgICAgICAgICAgY2FzZSA4OiBicmVhazsgICAgICAgICAgICAgICAvKiBUWVBFREVGICovCiAg
ICAgICAgICAgIGNhc2UgOTogYnJlYWs7ICAgICAgICAgICAgICAgLyogVk9MQVRJTEUgKi8KICAg
ICAgICAgICAgY2FzZSAxMDogYnJlYWs7ICAgICAgICAgICAgICAvKiBDT05TVCAqLwogICAgICAg
ICAgICBjYXNlIDExOiBicmVhazsgICAgICAgICAgICAgIC8qIFJFU1RSSUNUICovCiAgICAgICAg
ICAgIGNhc2UgMTI6IGJyZWFrOyAgICAgICAgICAgICAgLyogRlVOQyAqLwogICAgICAgICAgICBj
YXNlIDEzOiBvZmYrPXZsZW4qODsgYnJlYWs7IC8qIEZVTkNfUFJPVE8gKi8KICAgICAgICAgICAg
Y2FzZSAxNDogb2ZmKz00OyBicmVhazsgICAgICAvKiBWQVIgKi8KICAgICAgICAgICAgY2FzZSAx
NTogb2ZmKz12bGVuKjEyOyBicmVhazsvKiBEQVRBU0VDICovCiAgICAgICAgICAgIGNhc2UgMTY6
IGJyZWFrOyAgICAgICAgICAgICAgLyogRkxPQVQgKi8KICAgICAgICAgICAgY2FzZSAxNzogb2Zm
Kz00OyBicmVhazsgICAgICAvKiBERUNMX1RBRyAqLwogICAgICAgICAgICBjYXNlIDE4OiBicmVh
azsgICAgICAgICAgICAgIC8qIFRZUEVfVEFHICovCiAgICAgICAgICAgIGNhc2UgMTk6IG9mZis9
dmxlbioxMjsgYnJlYWs7LyogRU5VTTY0ICovCiAgICAgICAgICAgIGRlZmF1bHQ6IGJyZWFrOwog
ICAgICAgIH0KICAgIH0KICAgIGZyZWUoZCk7IHJldHVybiBmb3VuZDsKfQoKLyogRmluZCBCVEYg
SUQgZm9yIGEgZnVuY3Rpb24gKGtpbmQ9MTIgRlVOQykgYnkgbmFtZSwgZm9yIGZlbnRyeSBhdHRh
Y2ggKi8Kc3RhdGljIGludCBmaW5kX2J0Zl9mdW5jKGNvbnN0IGNoYXIgKm5hbWUpCnsKICAgIHJl
dHVybiBmaW5kX2tmdW5jKG5hbWUpOyAvKiBzYW1lIGxvZ2ljIOKAlCBraW5kIDEyID0gRlVOQyAq
Lwp9CgovKiBMb2FkIHByb2cgQlRGOiBtYWluX2YgKyB2bWFfY2Igc3VicHJvZyAqLwpzdGF0aWMg
aW50IGxvYWRfcHJvZ19idGYodm9pZCkKewogICAgY2hhciBzW109IlwwaW50XDBtYWluX2ZcMHZt
YV9jYiI7CiAgICB1aW50OF90IHRiWzEyOF07IGludCBwPTA7CiNkZWZpbmUgRSh2KSBkb3t1aW50
MzJfdCBfdj0odik7bWVtY3B5KHRiK3AsJl92LDQpO3ArPTQ7fXdoaWxlKDApCiAgICBFKDEpO0Uo
KDE8PDI0KSk7RSg0KTtFKCgxPDwyNCl8MzIpOyAgICAgLyogdDE6IElOVCBpbnQgKi8KICAgIEUo
MCk7RSgoMTM8PDI0KSk7RSgxKTsgICAgICAgICAgICAgICAgICAgLyogdDI6IEZVTkNfUFJPVE8o
KS0+dDEgKi8KICAgIEUoNSk7RSgoMTI8PDI0KSk7RSgyKTsgICAgICAgICAgICAgICAgICAgLyog
dDM6IEZVTkMgbWFpbl9mICovCiAgICBFKDApO0UoKDEzPDwyNCkpO0UoMSk7ICAgICAgICAgICAg
ICAgICAgIC8qIHQ0OiBGVU5DX1BST1RPKCktPnQxICovCiAgICBFKDEzKTtFKCgxMjw8MjQpKTtF
KDQpOyAgICAgICAgICAgICAgICAgIC8qIHQ1OiBGVU5DIHZtYV9jYiAqLwojdW5kZWYgRQogICAg
aW50IHRsPXAsIHNsPXNpemVvZihzKSwgdG90PTI0K3RsK3NsOwogICAgdWludDhfdCAqYj1jYWxs
b2MoMSx0b3QpOyAqKHVpbnQxNl90KiliPTB4RUI5RjsgYlsyXT0xOwogICAgdWludDMyX3QgKmg9
KHVpbnQzMl90KikoYis0KTsgaFswXT0yNDtoWzFdPTA7aFsyXT10bDtoWzNdPXRsO2hbNF09c2w7
CiAgICBtZW1jcHkoYisyNCx0Yix0bCk7IG1lbWNweShiKzI0K3RsLHMsc2wpOwogICAgY2hhciBs
Yls0MDk2XT17fTsKICAgIHVuaW9uIGJwZl9hdHRyIGE9e307IGEuYnRmPSh1aW50NjRfdCliOyBh
LmJ0Zl9zaXplPXRvdDsKICAgIGEuYnRmX2xvZ19idWY9KHVpbnQ2NF90KWxiOyBhLmJ0Zl9sb2df
c2l6ZT1zaXplb2YobGIpOyBhLmJ0Zl9sb2dfbGV2ZWw9MTsKICAgIGludCBmZD1icGZfc3lzKEJQ
Rl9CVEZfTE9BRCwmYSxzaXplb2YoYSkpOyBmcmVlKGIpOwogICAgaWYoZmQ8MCkgZnByaW50Zihz
dGRlcnIsInByb2cgQlRGOiAlc1xuJXNcbiIsc3RyZXJyb3IoZXJybm8pLGxiKTsKICAgIHJldHVy
biBmZDsKfQoKLyogQ3JlYXRlIGFycmF5IG1hcCB0byBob2xkIHZpY3RpbSBQSUQgKi8Kc3RhdGlj
IGludCBjcmVhdGVfcGlkX21hcCh2b2lkKQp7CiAgICB1bmlvbiBicGZfYXR0ciBhID0ge307CiAg
ICBhLm1hcF90eXBlID0gQlBGX01BUF9UWVBFX0FSUkFZOwogICAgYS5rZXlfc2l6ZSA9IDQ7CiAg
ICBhLnZhbHVlX3NpemUgPSA0OwogICAgYS5tYXhfZW50cmllcyA9IDE7CiAgICBpbnQgZmQgPSBi
cGZfc3lzKEJQRl9NQVBfQ1JFQVRFLCAmYSwgc2l6ZW9mKGEpKTsKICAgIGlmIChmZCA8IDApIGZw
cmludGYoc3RkZXJyLCAibWFwIGNyZWF0ZTogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICBy
ZXR1cm4gZmQ7Cn0KCi8qCiAqIEJQRiBwcm9ncmFtIChmZW50cnkgb24gX194NjRfc3lzX2dldHBp
ZCk6CiAqCiAqICAgbWFpbl9mOgogKiAgICAga2V5ID0gMAogKiAgICAgdmFsID0gbWFwX2xvb2t1
cF9lbGVtKG1hcCwgJmtleSkKICogICAgIGlmICghdmFsKSBnb3RvIG91dAogKiAgICAgcGlkID0g
KnZhbAogKiAgICAgaWYgKHBpZCA9PSAwKSBnb3RvIG91dAogKiAgICAgdGFzayA9IGJwZl90YXNr
X2Zyb21fcGlkKHBpZCkgICAgICAvLyBrZnVuYywgS0ZfQUNRVUlSRXxLRl9SRVRfTlVMTAogKiAg
ICAgaWYgKCF0YXNrKSBnb3RvIG91dAogKiAgICAgYnBmX2ZpbmRfdm1hKHRhc2ssIDB4MjAwMDAw
MDAsIHZtYV9jYiwgTlVMTCwgMCkgIC8vIGhlbHBlciAxODAKICogICAgIGJwZl90YXNrX3JlbGVh
c2UodGFzaykgICAgICAgICAgICAgLy8ga2Z1bmMsIEtGX1JFTEVBU0UKICogICBvdXQ6CiAqICAg
ICByZXR1cm4gMAogKgogKiAgIHZtYV9jYjoKICogICAgIHJldHVybiAwCiAqLwpzdGF0aWMgaW50
IGxvYWRfdHJhY2luZ19wcm9nKGludCBtYXBfZmQsIGludCBwcm9nX2J0Zl9mZCwKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbnQga2ZfdGFza19mcm9tX3BpZCwgaW50IGtmX3Rhc2tfcmVs
ZWFzZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgYXR0YWNoX2J0Zl9pZCkKewog
ICAgLyoKICAgICAqIEluc24gbGF5b3V0OgogICAgICogIDA6IHI2ID0gcjEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoc2F2ZSBjdHgpCiAgICAgKiAgMTogKih1MzIqKShyMTAgLSA0KSA9IDAg
ICAgICAgICAgICAgIChrZXkgPSAwKQogICAgICogIDItMzogcjEgPSBtYXBfZmQgICAgICAgICAg
ICAgICAgICAgICAoTERfTUFQX0ZEKQogICAgICogIDQ6IHIyID0gcjEwCiAgICAgKiAgNTogcjIg
Kz0gLTQKICAgICAqICA2OiBjYWxsIG1hcF9sb29rdXBfZWxlbSAoIzEpCiAgICAgKiAgNzogaWYg
cjAgPT0gMCBnb3RvICsxMyDihpIgaW5zbiAyMSAgICAob3V0KQogICAgICogIDg6IHI3ID0gKih1
MzIqKShyMCArIDApICAgICAgICAgICAgICAocGlkID0gKnZhbCkKICAgICAqICA5OiBpZiByNyA9
PSAwIGdvdG8gKzExIOKGkiBpbnNuIDIxICAgIChvdXQpCiAgICAgKiAxMDogcjEgPSByNyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChwaWQgYXJnIGZvciB0YXNrX2Zyb21fcGlkKQogICAgICog
MTE6IGNhbGwgYnBmX3Rhc2tfZnJvbV9waWQgICAgICAgICAgICAoa2Z1bmMpCiAgICAgKiAxMjog
aWYgcjAgPT0gMCBnb3RvICs4IOKGkiBpbnNuIDIxICAgICAob3V0LCBOVUxMIGNoZWNrIGZvciBL
Rl9SRVRfTlVMTCkKICAgICAqIDEzOiByNiA9IHIwICAgICAgICAgICAgICAgICAgICAgICAgICAg
KHNhdmUgdGFzayBwdHIpCiAgICAgKiAxNDogcjEgPSByNiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICh0YXNrKQogICAgICogMTU6IHIyID0gVklDVElNX01NQVBfQUREUiAgICAgICAgICAgIChh
ZGRyLCBsb3cgMzIgYml0cykKICAgICAqIDE2OiAoaGlnaCAzMiBiaXRzID0gMCwgcGFydCBvZiBM
RF9JTU02NCBmb3IgcjIg4oCUIGFjdHVhbGx5IHVzZSBNT1Y2NF9JTU0gZm9yIDMyLWJpdCBhZGRy
KQogICAgICogICAgIEFjdHVhbGx5IGJwZl9maW5kX3ZtYSBhcmcyIGlzIHU2NCwgYnV0IDB4MjAw
MDAwMDAgZml0cyBpbiBzMzIuCiAgICAgKiAxNTogcjIgPSAweDIwMDAwMDAwCiAgICAgKiAxNi0x
NzogcjMgPSBQU0VVRE9fRlVOQyDihpIgdm1hX2NiIGF0IGluc24gMjMKICAgICAqIDE4OiByNCA9
IDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGNhbGxiYWNrX2N0eCA9IE5VTEwpCiAgICAg
KiAxOTogcjUgPSAwICAgICAgICAgICAgICAgICAgICAgICAgICAgIChmbGFncyA9IDApCiAgICAg
KiAyMDogY2FsbCBicGZfZmluZF92bWEgKCMxODApCiAgICAgKiAtLSBub3cgcmVsZWFzZSB0YXNr
IC0tCiAgICAgKiAyMTogcjEgPSByNiAgICAgICAgICAgICAgICAgICAgICAgICAgICh0YXNrKQog
ICAgICogMjI6IGNhbGwgYnBmX3Rhc2tfcmVsZWFzZSAgICAgICAgICAgICAoa2Z1bmMpCiAgICAg
KiAyMzogcjAgPSAwICAgICAgICAgICAgICAgICAgICAgICAgICAgIChvdXQgbGFiZWwgd2FzIHdy
b25nLCByZWNhbGN1bGF0ZSkKICAgICAqIDI0OiBleGl0CiAgICAgKiAyNTogdm1hX2NiIHN1YnBy
b2cKICAgICAqIDI2OiByMCA9IDAKICAgICAqIDI3OiBleGl0CiAgICAgKgogICAgICogV2FpdCDi
gJQgbmVlZCB0byByZWNhbGN1bGF0ZSBqdW1wcy4gTGV0IG1lIGxheSBpdCBvdXQgY2FyZWZ1bGx5
LgogICAgICovCgogICAgLyogUmVjYWxjdWxhdGUgd2l0aCBjb3JyZWN0IG9mZnNldHMgKi8KICAg
IHN0cnVjdCBicGZfaW5zbiBpbnNuc1tdID0gewogICAgICAgIC8qIDAgICovIEJQRl9NT1Y2NF9S
RUcoNiwgMSksCiAgICAgICAgLyogMSAgKi8gQlBGX1NUX01FTShCUEZfVywgMTAsIC00LCAwKSwK
ICAgICAgICAvKiAyLTMqLyBCUEZfTERfTUFQX0ZEKDEsIG1hcF9mZCksCiAgICAgICAgLyogNCAg
Ki8gQlBGX01PVjY0X1JFRygyLCAxMCksCiAgICAgICAgLyogNSAgKi8gQlBGX0FMVTY0X0lNTShC
UEZfQURELCAyLCAtNCksCiAgICAgICAgLyogNiAgKi8gQlBGX0VNSVRfQ0FMTCgxKSwgLyogbWFw
X2xvb2t1cF9lbGVtICovCiAgICAgICAgLyogNyAgKi8gQlBGX0pNUF9JTU0oQlBGX0pFUSwgMCwg
MCwgMTcpLCAvKiBpZiByMD09MCBnb3RvIDI1IChvdXQpICovCiAgICAgICAgLyogOCAgKi8gQlBG
X0xEWF9NRU0oQlBGX1csIDcsIDAsIDApLCAvKiByNyA9ICoodTMyKikocjArMCkgPSBwaWQgKi8K
ICAgICAgICAvKiA5ICAqLyBCUEZfSk1QX0lNTShCUEZfSkVRLCA3LCAwLCAxNSksIC8qIGlmIHBp
ZD09MCBnb3RvIDI1ICovCiAgICAgICAgLyogMTAgKi8gQlBGX01PVjY0X1JFRygxLCA3KSwgLyog
cjEgPSBwaWQgKi8KICAgICAgICAvKiAxMSAqLyBCUEZfRU1JVF9DQUxMX0tGVU5DKGtmX3Rhc2tf
ZnJvbV9waWQpLAogICAgICAgIC8qIDEyICovIEJQRl9KTVBfSU1NKEJQRl9KRVEsIDAsIDAsIDEy
KSwgLyogaWYgcjA9PTAgZ290byAyNSAqLwogICAgICAgIC8qIDEzICovIEJQRl9NT1Y2NF9SRUco
NiwgMCksIC8qIHI2ID0gdGFzayAoc2F2ZSBmb3IgcmVsZWFzZSkgKi8KICAgICAgICAvKiAxNCAq
LyBCUEZfTU9WNjRfUkVHKDEsIDYpLCAvKiByMSA9IHRhc2sgKi8KICAgICAgICAvKiAxNSAqLyBC
UEZfTU9WNjRfSU1NKDIsIDB4MjAwMDAwMDApLCAvKiByMiA9IGFkZHIgKi8KICAgICAgICAvKiAx
Ni0xNzogcjMgPSBQU0VVRE9fRlVOQyDihpIgdm1hX2NiIGF0IGluc24gMjcgKi8KICAgICAgICAv
KiAgICAgaW1tID0gMjcgLSAxNiAtIDEgPSAxMC4uLiBubywgUFNFVURPX0ZVTkMgaW1tIGlzIHRo
ZSB0YXJnZXQgaW5zbiBvZmZzZXQgKi8KICAgICAgICAvKiAgICAgQWN0dWFsbHkgUFNFVURPX0ZV
TkMgaW1tID0gdGFyZ2V0X2luc24gLSAoY3VycmVudF9pbnNuICsgMSkgLi4uICovCiAgICAgICAg
LyogICAgIE5vOiBMRF9JTU02NCB3aXRoIFBTRVVET19GVU5DLCBpbW0gZmllbGQgPSBvZmZzZXQg
b2Ygc3VicHJvZyBmcm9tIHN0YXJ0ICovCiAgICAgICAgLyogICAgIFBlciBrZXJuZWw6IGltbSA9
IHN1YnByb2dfc3RhcnRfaW5zbl9pZHguIExldCdzIGp1c3Qgc2V0IGltbSA9IHRhcmdldCAtIHNy
YyAqLwogICAgICAgIC8qICAgICBMb29raW5nIGF0IEJ1ZyAjMjogaW5zbiAxNS0xNiBoYWQgaW1t
PTEyIGZvciB0YXJnZXQgYXQgaW5zbiAyOCwgZnJvbSBpbnNuIDE1ICovCiAgICAgICAgLyogICAg
IFNvIGltbSA9IDI4IC0gMTUgLSAxID0gMTIuIEZvciB1czogdGFyZ2V0PTI3LCBzcmM9MTYsIGlt
bSA9IDI3LTE2LTEgPSAxMCAqLwogICAgICAgIEJQRl9SQVdfSU5TTihCUEZfTER8QlBGX0RXfEJQ
Rl9JTU0sIDMsIEJQRl9QU0VVRE9fRlVOQywgMCwgMTApLAogICAgICAgIEJQRl9SQVdfSU5TTigw
LCAwLCAwLCAwLCAwKSwKICAgICAgICAvKiAxOCAqLyBCUEZfTU9WNjRfSU1NKDQsIDApLCAvKiBj
YWxsYmFja19jdHggPSBOVUxMICovCiAgICAgICAgLyogMTkgKi8gQlBGX01PVjY0X0lNTSg1LCAw
KSwgLyogZmxhZ3MgPSAwICovCiAgICAgICAgLyogMjAgKi8gQlBGX0VNSVRfQ0FMTCgxODApLCAv
KiBicGZfZmluZF92bWEgKi8KICAgICAgICAvKiAyMSAqLyBCUEZfTU9WNjRfUkVHKDEsIDYpLCAv
KiByMSA9IHRhc2sgZm9yIHJlbGVhc2UgKi8KICAgICAgICAvKiAyMiAqLyBCUEZfRU1JVF9DQUxM
X0tGVU5DKGtmX3Rhc2tfcmVsZWFzZSksCiAgICAgICAgLyogMjMgKi8gQlBGX01PVjY0X0lNTSgw
LCAwKSwKICAgICAgICAvKiAyNCAqLyBCUEZfRVhJVF9JTlNOKCksCiAgICAgICAgLyogMjU6IG91
dCAoanVtcGVkIGhlcmUgd2hlbiBubyB0YXNrIC8gbm8gcGlkKSAqLwogICAgICAgIEJQRl9NT1Y2
NF9JTU0oMCwgMCksCiAgICAgICAgLyogMjYgKi8gQlBGX0VYSVRfSU5TTigpLAogICAgICAgIC8q
IDI3OiB2bWFfY2Igc3VicHJvZyAqLwogICAgICAgIEJQRl9NT1Y2NF9JTU0oMCwgMCksCiAgICAg
ICAgLyogMjggKi8gQlBGX0VYSVRfSU5TTigpLAogICAgfTsKCiAgICAvKgogICAgICogV2FpdCDi
gJQgdGhlIGp1bXAgdGFyZ2V0cyBuZWVkIHJlY2hlY2tpbmcuCiAgICAgKiBpbnNuIDc6ICBpZiBy
MD09MCBnb3RvICsxNyDihpIgNysxKzE3ID0gMjUuIOKckwogICAgICogaW5zbiA5OiAgaWYgcjc9
PTAgZ290byArMTUg4oaSIDkrMSsxNSA9IDI1LiDinJMKICAgICAqIGluc24gMTI6IGlmIHIwPT0w
IGdvdG8gKzEyIOKGkiAxMisxKzEyID0gMjUuIOKckwogICAgICoKICAgICAqIEJ1dCB0aGVyZSdz
IGEgcHJvYmxlbTogd2hlbiB3ZSBqdW1wIHRvIDI1IChvdXQpIHdlIHNraXAgYnBmX3Rhc2tfcmVs
ZWFzZS4KICAgICAqIFRoYXQncyBmaW5lIGZvciBpbnNucyA3IGFuZCA5ICh0YXNrIG5vdCBhY3F1
aXJlZCB5ZXQpLgogICAgICogRm9yIGluc24gMTI6IHRhc2tfZnJvbV9waWQgcmV0dXJuZWQgTlVM
TCwgc28gbm8gcmVsZWFzZSBuZWVkZWQuIOKckwogICAgICoKICAgICAqIFBTRVVET19GVU5DOiBp
bnNuIDE2IChmaXJzdCBvZiBMRF9JTU02NCBwYWlyKSwgdGFyZ2V0ID0gMjcuCiAgICAgKiBpbW0g
PSAyNyAtIDE2IC0gMSA9IDEwLiBCdXQgbGV0IG1lIHZlcmlmeSBhZ2FpbnN0IEJ1ZyAjMjoKICAg
ICAqIEJ1ZyAjMiBoYWQgUFNFVURPX0ZVTkMgYXQgaW5zbiAxNSwgdGFyZ2V0IGF0IGluc24gMjgs
IGltbSA9IDEyLgogICAgICogMjggLSAxNSA9IDEzLCBub3QgMTIuIEhtbS4uLgogICAgICogQWN0
dWFsbHkgUFNFVURPX0ZVTkMgaW1tIGlzIGp1c3QgdGhlIHJhdyB2YWx1ZSB0aGF0IGdldHMgcGF0
Y2hlZAogICAgICogYnkgdGhlIHZlcmlmaWVyLiBUaGUgdmVyaWZpZXIgY29udmVydHMgaXQgdG8g
dGhlIHN1YnByb2cgaW5kZXguCiAgICAgKiBJbiBwcmFjdGljZSwgaW1tIHNob3VsZCBiZSBzZXQg
dG8gKHRhcmdldCAtIHNyY19pbnNuKS4KICAgICAqIEJ1ZyAjMjogdGFyZ2V0PTI4LCBzcmM9MTUs
IGltbT0yOC0xNT0xMy4uLiBidXQgaXQgdXNlZCAxMi4KICAgICAqIExldCBtZSByZS1jaGVjazog
bWF5YmUgaW1tID0gdGFyZ2V0IC0gKHNyYysxKSA9IDI4LTE2ID0gMTIuIFllcyEKICAgICAqIFRo
ZSBMRF9JTU02NCBvY2N1cGllcyBUV08gaW5zbnMgKDE1LTE2KSwgc28gIm5leHQgaW5zbiIgaXMg
MTcuCiAgICAgKiBCdXQgdGhlIGNvbnZlbnRpb24gaXMgaW1tID0gdGFyZ2V0IC0gc3JjID0gMjgg
LSAxNSA9IDEzPyBObywgaXQgdXNlZCAxMi4KICAgICAqIEFjdHVhbGx5IGxvb2tpbmcgYXQgdGhl
IGNvZGU6IGltbSA9IHRhcmdldF9pbnNuIC0gaW5zbl9hZnRlcl9sZGltbTY0CiAgICAgKiA9IDI4
IC0gKDE1KzIpID0gMTE/IE5vIHRoYXQncyAxMSBub3QgMTIuCiAgICAgKgogICAgICogTGV0IG1l
IGp1c3QgbG9vayBhdCB3aGF0IHRoZSBrZXJuZWwgZG9lcyB3aXRoIFBTRVVET19GVU5DOgogICAg
ICogSXQgc3RvcmVzIHRoZSBvZmZzZXQgZnJvbSB0aGUgTERfSU1NNjQgaW5zbiB0byB0aGUgdGFy
Z2V0LgogICAgICogaW1tID0gdGFyZ2V0IC0gbGRpbW02NF9pbnNuX2lkeCA9IDI4IC0gMTUgPSAx
MyBpbiBCdWcgIzI/CiAgICAgKiBCdXQgQnVnICMyIHVzZWQgMTIgYW5kIGl0IFdPUktFRC4gU28g
aW1tID0gdGFyZ2V0IC0gbGRpbW02NF9pZHggLSAxLgogICAgICogRm9yIHVzOiBpbW0gPSAyNyAt
IDE2IC0gMSA9IDEwLgogICAgICoKICAgICAqIEFDVFVBTExZOiBUaGUgTERfSU1NNjQgZm9yIFBT
RVVET19GVU5DIGF0IGluc24gMTUgaW4gQnVnICMyOgogICAgICogaW5zbiAxNSBpcyB0aGUgZmly
c3QgaW5zbiBvZiB0aGUgcGFpci4gaW1tID0gMTIuCiAgICAgKiB0YXJnZXQgPSAyOC4gMjggLSAx
NSA9IDEzLiAyOCAtIDE2ID0gMTIuIFNvIGltbSA9IHRhcmdldCAtIChzcmMrMSkuCiAgICAgKiBI
bW0gdGhhdCdzIGFsc28gMTIuIFNvIGltbSA9IHRhcmdldCAtIGZpcnN0X2luc24gLSAxPyAyOC0x
NS0xPTEyLiBZZXMuCiAgICAgKgogICAgICogRm9yIHVzOiBmaXJzdF9pbnNuID0gMTYsIHRhcmdl
dCA9IDI3LiBpbW0gPSAyNyAtIDE2IC0gMSA9IDEwLiDinJMKICAgICAqLwoKICAgIHN0cnVjdCB7
CiAgICAgICAgdWludDMyX3QgaW5zbl9vZmY7CiAgICAgICAgdWludDMyX3QgdHlwZV9pZDsKICAg
IH0gZnVuY19pbmZvW10gPSB7CiAgICAgICAgeyAwLCAzIH0sICAgLyogbWFpbl9mICovCiAgICAg
ICAgeyAyNywgNSB9LCAgLyogdm1hX2NiICovCiAgICB9OwoKICAgIGNoYXIgbG9nWzY1NTM2XSA9
IHt9OwogICAgdW5pb24gYnBmX2F0dHIgYSA9IHt9OwogICAgYS5wcm9nX3R5cGUgPSBCUEZfUFJP
R19UWVBFX1RSQUNJTkc7CiAgICBhLmV4cGVjdGVkX2F0dGFjaF90eXBlID0gMjQ7IC8qIEJQRl9U
UkFDRV9GRU5UUlkgKi8KICAgIGEuaW5zbnMgPSAodWludDY0X3QpaW5zbnM7CiAgICBhLmluc25f
Y250ID0gc2l6ZW9mKGluc25zKSAvIHNpemVvZihpbnNuc1swXSk7CiAgICBhLmxpY2Vuc2UgPSAo
dWludDY0X3QpIkdQTCI7CiAgICBhLmxvZ19idWYgPSAodWludDY0X3QpbG9nOwogICAgYS5sb2df
c2l6ZSA9IHNpemVvZihsb2cpOwogICAgYS5sb2dfbGV2ZWwgPSAxOwogICAgYS5wcm9nX2J0Zl9m
ZCA9IHByb2dfYnRmX2ZkOwogICAgYS5mdW5jX2luZm8gPSAodWludDY0X3QpZnVuY19pbmZvOwog
ICAgYS5mdW5jX2luZm9fY250ID0gMjsKICAgIGEuZnVuY19pbmZvX3JlY19zaXplID0gODsKICAg
IGEuYXR0YWNoX2J0Zl9pZCA9IGF0dGFjaF9idGZfaWQ7CiAgICBhLmF0dGFjaF9idGZfb2JqX2Zk
ID0gMDsgLyogdm1saW51eCAqLwoKICAgIGludCBmZCA9IGJwZl9zeXMoQlBGX1BST0dfTE9BRCwg
JmEsIHNpemVvZihhKSk7CiAgICBpZiAoZmQgPCAwKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIs
ICJwcm9nIGxvYWQ6ICVzXG5Mb2cgKGZpcnN0IDQwOTYpOlxuJS40MDk2c1xuIiwgc3RyZXJyb3Io
ZXJybm8pLCBsb2cpOwogICAgfQogICAgcmV0dXJuIGZkOwp9CgpzdGF0aWMgdm9sYXRpbGUgaW50
IHN0b3BfcmFjaW5nID0gMDsKCnN0YXRpYyB2b2lkIHBpbl9jcHUoaW50IGNwdSkKewogICAgY3B1
X3NldF90IHNldDsKICAgIENQVV9aRVJPKCZzZXQpOwogICAgQ1BVX1NFVChjcHUsICZzZXQpOwog
ICAgc2NoZWRfc2V0YWZmaW5pdHkoMCwgc2l6ZW9mKHNldCksICZzZXQpOwp9CgovKgogKiBWaWN0
aW0gdGhyZWFkOiBjb250aW51b3VzbHkgZm9yayBhIGNoaWxkIHRoYXQgbW1hcHMgYW5kIGV4aXRz
LgogKiBUaGUgcGFyZW50IHVwZGF0ZXMgdGhlIFBJRCBtYXAgc28gdGhlIEJQRiBwcm9ncmFtIHRh
cmdldHMgdGhlIGNoaWxkLgogKi8Kc3RhdGljIGludCBnX21hcF9mZCA9IC0xOwoKc3RhdGljIHZv
aWQgKnZpY3RpbV90aHJlYWQodm9pZCAqYXJnKQp7CiAgICBwaW5fY3B1KDEpOwogICAgKHZvaWQp
YXJnOwogICAgaW50IHBpcGVmZFsyXTsKCiAgICB3aGlsZSAoIXN0b3BfcmFjaW5nKSB7CiAgICAg
ICAgaWYgKHBpcGUocGlwZWZkKSA8IDApIGNvbnRpbnVlOwogICAgICAgIHBpZF90IGNoaWxkID0g
Zm9yaygpOwogICAgICAgIGlmIChjaGlsZCA9PSAwKSB7CiAgICAgICAgICAgIGNsb3NlKHBpcGVm
ZFsxXSk7CiAgICAgICAgICAgIHZvaWQgKnAgPSBtbWFwKCh2b2lkKilWSUNUSU1fTU1BUF9BRERS
LCBWSUNUSU1fTU1BUF9TSVpFLAogICAgICAgICAgICAgICAgICAgICAgICAgIFBST1RfUkVBRHxQ
Uk9UX1dSSVRFLAogICAgICAgICAgICAgICAgICAgICAgICAgIE1BUF9QUklWQVRFfE1BUF9BTk9O
WU1PVVN8TUFQX0ZJWEVELCAtMSwgMCk7CiAgICAgICAgICAgIGlmIChwICE9IE1BUF9GQUlMRUQp
CiAgICAgICAgICAgICAgICAqKHZvbGF0aWxlIGNoYXIqKXAgPSAnWCc7CiAgICAgICAgICAgIGNo
YXIgYzsKICAgICAgICAgICAgcmVhZChwaXBlZmRbMF0sICZjLCAxKTsKICAgICAgICAgICAgY2xv
c2UocGlwZWZkWzBdKTsKICAgICAgICAgICAgX2V4aXQoMCk7CiAgICAgICAgfQogICAgICAgIGlm
IChjaGlsZCA+IDApIHsKICAgICAgICAgICAgY2xvc2UocGlwZWZkWzBdKTsKICAgICAgICAgICAg
dWludDMyX3Qga2V5ID0gMDsKICAgICAgICAgICAgdWludDMyX3QgdmFsID0gKHVpbnQzMl90KWNo
aWxkOwogICAgICAgICAgICB1bmlvbiBicGZfYXR0ciB1YSA9IHt9OwogICAgICAgICAgICB1YS5t
YXBfZmQgPSBnX21hcF9mZDsKICAgICAgICAgICAgdWEua2V5ID0gKHVpbnQ2NF90KSZrZXk7CiAg
ICAgICAgICAgIHVhLnZhbHVlID0gKHVpbnQ2NF90KSZ2YWw7CiAgICAgICAgICAgIHVhLmZsYWdz
ID0gQlBGX0FOWTsKICAgICAgICAgICAgYnBmX3N5cyhCUEZfTUFQX1VQREFURV9FTEVNLCAmdWEs
IHNpemVvZih1YSkpOwoKICAgICAgICAgICAgdXNsZWVwKDUwKTsKICAgICAgICAgICAgd3JpdGUo
cGlwZWZkWzFdLCAieCIsIDEpOwogICAgICAgICAgICBjbG9zZShwaXBlZmRbMV0pOwogICAgICAg
ICAgICB1c2xlZXAoMSk7CiAgICAgICAgICAgIHdhaXRwaWQoY2hpbGQsIE5VTEwsIDApOwogICAg
ICAgIH0KICAgIH0KICAgIHJldHVybiBOVUxMOwp9CgovKgogKiBUcmlnZ2VyIHRocmVhZDogcmVw
ZWF0ZWRseSBjYWxsIGdldHBpZCgpIHRvIGZpcmUgdGhlIGZlbnRyeSBCUEYgcHJvZ3JhbS4KICov
CnN0YXRpYyB2b2lkICp0cmlnZ2VyX3RocmVhZCh2b2lkICphcmcpCnsKICAgIHBpbl9jcHUoMCk7
CiAgICAodm9pZClhcmc7CiAgICB3aGlsZSAoIXN0b3BfcmFjaW5nKSB7CiAgICAgICAgZm9yIChp
bnQgaSA9IDA7IGkgPCAxMDAwMDsgaSsrKQogICAgICAgICAgICBzeXNjYWxsKF9fTlJfZ2V0cGlk
KTsKICAgICAgICBzY2hlZF95aWVsZCgpOwogICAgfQogICAgcmV0dXJuIE5VTEw7Cn0KCmludCBt
YWluKHZvaWQpCnsKICAgIHNldHZidWYoc3Rkb3V0LCBOVUxMLCBfSU9OQkYsIDApOwogICAgc2V0
dmJ1ZihzdGRlcnIsIE5VTEwsIF9JT05CRiwgMCk7CiAgICBwcmludGYoIj09PSBicGZfZmluZF92
bWEoKSBmb3JlaWduIG1tIFVBRiBQb0MgPT09XG5cbiIpOwoKICAgIC8qIEZpbmQga2Z1bmMgQlRG
IElEcyAqLwogICAgaW50IGtmX3Rhc2tfZnJvbV9waWQgPSBmaW5kX2tmdW5jKCJicGZfdGFza19m
cm9tX3BpZCIpOwogICAgaW50IGtmX3Rhc2tfcmVsZWFzZSA9IGZpbmRfa2Z1bmMoImJwZl90YXNr
X3JlbGVhc2UiKTsKICAgIHByaW50Zigia2Z1bmMgSURzOiB0YXNrX2Zyb21fcGlkPSVkLCB0YXNr
X3JlbGVhc2U9JWRcbiIsCiAgICAgICAgICAga2ZfdGFza19mcm9tX3BpZCwga2ZfdGFza19yZWxl
YXNlKTsKICAgIGlmIChrZl90YXNrX2Zyb21fcGlkIDwgMCB8fCBrZl90YXNrX3JlbGVhc2UgPCAw
KSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJDYW5ub3QgZmluZCB0YXNrIGtmdW5jIEJURiBJ
RHNcbiIpOwogICAgICAgIHJldHVybiAxOwogICAgfQoKICAgIC8qIEZpbmQgQlRGIElEIGZvciBm
ZW50cnkgYXR0YWNoIHRhcmdldCAqLwogICAgaW50IGF0dGFjaF9pZCA9IGZpbmRfYnRmX2Z1bmMo
Il9fZG9fc3lzX2dldHBpZCIpOwogICAgcHJpbnRmKCJBdHRhY2ggQlRGIElEIChfX2RvX3N5c19n
ZXRwaWQpOiAlZFxuIiwgYXR0YWNoX2lkKTsKICAgIGlmIChhdHRhY2hfaWQgPCAwKSB7CiAgICAg
ICAgZnByaW50ZihzdGRlcnIsICJDYW5ub3QgZmluZCBzeXNfZ2V0cGlkIEJURiBJRCBmb3IgZmVu
dHJ5IGF0dGFjaFxuIik7CiAgICAgICAgcmV0dXJuIDE7CiAgICB9CgogICAgaW50IHByb2dfYnRm
ID0gbG9hZF9wcm9nX2J0ZigpOwogICAgaWYgKHByb2dfYnRmIDwgMCkgcmV0dXJuIDE7CiAgICBw
cmludGYoIlByb2cgQlRGIGxvYWRlZDogZmQ9JWRcbiIsIHByb2dfYnRmKTsKCiAgICBpbnQgbWFw
X2ZkID0gY3JlYXRlX3BpZF9tYXAoKTsKICAgIGlmIChtYXBfZmQgPCAwKSByZXR1cm4gMTsKICAg
IGdfbWFwX2ZkID0gbWFwX2ZkOwogICAgcHJpbnRmKCJQSUQgbWFwIGNyZWF0ZWQ6IGZkPSVkXG4i
LCBtYXBfZmQpOwoKICAgIHByaW50ZigiTG9hZGluZyB0cmFjaW5nIGZlbnRyeSBwcm9ncmFtLi4u
XG4iKTsKICAgIGludCBwcm9nX2ZkID0gbG9hZF90cmFjaW5nX3Byb2cobWFwX2ZkLCBwcm9nX2J0
ZiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtmX3Rhc2tfZnJvbV9waWQs
IGtmX3Rhc2tfcmVsZWFzZSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0
dGFjaF9pZCk7CiAgICBpZiAocHJvZ19mZCA8IDApIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IkZhaWxlZCB0byBsb2FkIEJQRiBwcm9ncmFtLlxuIik7CiAgICAgICAgcmV0dXJuIDE7CiAgICB9
CiAgICBwcmludGYoIlByb2dyYW0gbG9hZGVkOiBmZD0lZFxuIiwgcHJvZ19mZCk7CgogICAgewog
ICAgICAgIHVuaW9uIGJwZl9hdHRyIGlhID0ge307CiAgICAgICAgc3RydWN0IGJwZl9wcm9nX2lu
Zm8gaW5mbyA9IHt9OwogICAgICAgIGlhLmluZm8uYnBmX2ZkID0gcHJvZ19mZDsKICAgICAgICBp
YS5pbmZvLmluZm9fbGVuID0gc2l6ZW9mKGluZm8pOwogICAgICAgIGlhLmluZm8uaW5mbyA9ICh1
aW50NjRfdCkmaW5mbzsKICAgICAgICBpZiAoYnBmX3N5cyhCUEZfT0JKX0dFVF9JTkZPX0JZX0ZE
LCAmaWEsIHNpemVvZihpYSkpID09IDApIHsKICAgICAgICAgICAgcHJpbnRmKCJQcm9nIGluZm86
IHR5cGU9JXVcbiIsIGluZm8udHlwZSk7CiAgICAgICAgfQogICAgfQoKICAgIC8qIEF0dGFjaCB0
aGUgZmVudHJ5IHByb2dyYW0gdmlhIEJQRl9SQVdfVFJBQ0VQT0lOVF9PUEVOICovCiAgICB7CiAg
ICAgICAgdW5pb24gYnBmX2F0dHIgYSA9IHt9OwogICAgICAgIGEucmF3X3RyYWNlcG9pbnQucHJv
Z19mZCA9IHByb2dfZmQ7CiAgICAgICAgYS5yYXdfdHJhY2Vwb2ludC5uYW1lID0gMDsgLyogTlVM
TCBmb3IgZmVudHJ5ICovCiAgICAgICAgaW50IGxpbmtfZmQgPSBicGZfc3lzKEJQRl9SQVdfVFJB
Q0VQT0lOVF9PUEVOLCAmYSwgc2l6ZW9mKGEpKTsKICAgICAgICBpZiAobGlua19mZCA8IDApIHsK
ICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJSQVdfVFJBQ0VQT0lOVF9PUEVOOiAlcyAoZXJy
bm8gJWQpXG4iLCBzdHJlcnJvcihlcnJubyksIGVycm5vKTsKICAgICAgICAgICAgLyogVHJ5IEJQ
Rl9MSU5LX0NSRUFURSBpbnN0ZWFkICovCiAgICAgICAgICAgIG1lbXNldCgmYSwgMCwgc2l6ZW9m
KGEpKTsKICAgICAgICAgICAgYS5saW5rX2NyZWF0ZS5wcm9nX2ZkID0gcHJvZ19mZDsKICAgICAg
ICAgICAgYS5saW5rX2NyZWF0ZS50YXJnZXRfZmQgPSAwOwogICAgICAgICAgICBhLmxpbmtfY3Jl
YXRlLmF0dGFjaF90eXBlID0gMjQ7IC8qIEJQRl9UUkFDRV9GRU5UUlkgKi8KICAgICAgICAgICAg
bGlua19mZCA9IGJwZl9zeXMoQlBGX0xJTktfQ1JFQVRFLCAmYSwgc2l6ZW9mKGEpKTsKICAgICAg
ICAgICAgaWYgKGxpbmtfZmQgPCAwKSB7CiAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwg
IkxJTktfQ1JFQVRFOiAlcyAoZXJybm8gJWQpXG4iLCBzdHJlcnJvcihlcnJubyksIGVycm5vKTsK
ICAgICAgICAgICAgICAgIHJldHVybiAxOwogICAgICAgICAgICB9CiAgICAgICAgfQogICAgICAg
IHByaW50ZigiRmVudHJ5IGF0dGFjaGVkOiBsaW5rX2ZkPSVkXG4iLCBsaW5rX2ZkKTsKICAgIH0K
CiAgICBwcmludGYoIlxuUmFjaW5nIGJwZl9maW5kX3ZtYSAodmlhIGZlbnRyeS9nZXRwaWQpIHZz
IHZpY3RpbSB0YXNrIGV4aXQuLi5cbiIpOwogICAgcHJpbnRmKCJDUFUwOiB0cmlnZ2VyIChnZXRw
aWQpLCBDUFUxOiB2aWN0aW0gKGZvcmsrbW1hcCtleGl0KVxuXG4iKTsKCiNkZWZpbmUgTl9UUklH
IDQKI2RlZmluZSBOX1ZJQ1RJTSAyCiNkZWZpbmUgUk9VTkRTIDMwMAogICAgcHRocmVhZF90IHRp
ZHNbTl9UUklHICsgTl9WSUNUSU1dOwogICAgaW50IHQgPSAwOwogICAgZm9yIChpbnQgaSA9IDA7
IGkgPCBOX1RSSUc7IGkrKykKICAgICAgICBwdGhyZWFkX2NyZWF0ZSgmdGlkc1t0KytdLCBOVUxM
LCB0cmlnZ2VyX3RocmVhZCwgTlVMTCk7CiAgICBmb3IgKGludCBpID0gMDsgaSA8IE5fVklDVElN
OyBpKyspCiAgICAgICAgcHRocmVhZF9jcmVhdGUoJnRpZHNbdCsrXSwgTlVMTCwgdmljdGltX3Ro
cmVhZCwgTlVMTCk7CgogICAgZm9yIChpbnQgciA9IDA7IHIgPCBST1VORFM7IHIrKykgewogICAg
ICAgIHNsZWVwKDEpOwogICAgICAgIGlmIChyICUgMTAgPT0gMCkKICAgICAgICAgICAgcHJpbnRm
KCIgIFJvdW5kICVkLyVkLi4uXG4iLCByKzEsIFJPVU5EUyk7CiAgICB9CgogICAgc3RvcF9yYWNp
bmcgPSAxOwogICAgZm9yIChpbnQgaSA9IDA7IGkgPCB0OyBpKyspCiAgICAgICAgcHRocmVhZF9q
b2luKHRpZHNbaV0sIE5VTEwpOwoKICAgIHByaW50ZigiXG5Eb25lLiBDaGVjayBkbWVzZyBmb3Ig
S0FTQU4gcmVwb3J0cy5cbiIpOwogICAgcmV0dXJuIDA7Cn0K
--0000000000000a7b2a0652ef8681--
