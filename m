Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1114E3762
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865167; cv=pass; b=NzipfMx0Ciaat6ngFUTn+JqqC6JHwiD4jFQQcZdK42ge6JxXQzwApInTsc0aoMCaEV9wd+pDtPaG72UZ+s1jjiy61x4fXe2pbmB4YS6fza7fyQpM7UhyX/pBjTh4gSNaBU8WJF+l6hciAZ2iTq3ph2URJCcpmwcnNDx5DkdsUPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865167; c=relaxed/simple;
	bh=4WKx6gawBE7XdJ3wZTcHwMgk+/Rh3SQVLgyfoOC7GUU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EMp3P/ZBaRkpZWGt5m5IdrAjN352X5Yehhp1GVi7UF37/ujpEUQGuJwCgtZ1N4SinZJ1BEiAU+/IHkPTy6c/wZdcu53kkrqMgUmADNqGXgGG0qnmakucRj39/TrYk+v5wEJb5O4WvjDEU3LpXMB2ox+oKJh0cgF3S8nMIZrjFM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivKaTWVf; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivKaTWVf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee4f241f42so3725826a34.1
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 03:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788865164; cv=none;
        d=google.com; s=arc-20260327;
        b=NseFglGbyKOScpDAHtVu2V+025x5w27E5TTCCQLFdpDL/7Tl/ddwAY2EQIMA2JghCa
         G52MHUhtoi65W74KeHhnLrUdHLRKv0Tde4qIWJISyFpb2D2VoqPB1/APft3j5u+l6LDT
         boWSyQbqDyVK2OiB29Mb2GbmsCz41Dy6ojdLL3QYpgR3q8RPoJcNURgLH1N/mWzDGL2t
         quoJ/jWeu58OT7BtQaVqhM+dZlyrJnTYr0uszBRPSB+VmNaybJm6aGC0CjCtaY0qeFyo
         oSmiBuxiXUX5bCrc+uQoGO+UCwRwGiKM0zfh+Dh7Z+77/j5z46e8KdZnWclYdVssNp3K
         FObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GbU8AI1fBsotQNmH8/0azcaMPzEbqCqdTE46+OPfF0A=;
        fh=1VydnEVNI01FYCwGoLlj2LNnfzyrdcD+ZCu5GkBwQwI=;
        b=exgOtN+yldwcI99ajmbfF2n1NerSjEaO5MxCNWiXlgxoG+BXk3fvhwB7IjzPNWWQ/2
         QOikEYa6cR5nmQV9a/G9n1aATmej+P2NFOPsAD+DZu1+KEsW9VfI7Lk5WqpyOe9eX3oe
         0GJD1QlyrQ/jiCMNaWgu0r424+3J0AEroYVBDqlF1cSgY9XsmYvaeBIm5jSyCBUkEKFX
         E4tkpkc1HJ03tu/PlnYY7gKUX2Y7L/Zhia/U3Dn9zN06bjNL3wnuzZr4OVyeZIxSygNQ
         L26ixQRDDcGJpkrEe8/z1u8qDS2E88pEkRpP7AkRbOCwjXlg/EXkkne83ox+Vd8TP8G5
         q6zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788865164; x=1789469964; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GbU8AI1fBsotQNmH8/0azcaMPzEbqCqdTE46+OPfF0A=;
        b=ivKaTWVfrMPfEHDY1GmQk6kWPZqbEYBYXsO011Fg8AraU6mcAvLSMsisRAlpKd4vzy
         L6Z3z/TAAizf+Ini3rI7O2NznC0JnB/EYg0FAPckqmwiOxKJNE6VJhBYQRRqU82XDzVP
         6I4SpAFUI6Fb/KtphH21qjtbzFEg6K57igd7sFWNxZtId8hC0GrH1BRGnNRFLdVXXPEA
         +mTNhyp2OtIj4diTWIk+ynxGnU3Ifg9O+iKq0PVc746lSg5c+YlFkTMDY65iNNECPcZ/
         RDY4qVKABktVzzxbzxwNfpdf5sdN2H54Hvhw0250cQ70OpCwWYDpJh0BdVREaAMqFipO
         SaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788865164; x=1789469964;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GbU8AI1fBsotQNmH8/0azcaMPzEbqCqdTE46+OPfF0A=;
        b=oCfBKm6+GJxzfK11dIMjhP1L843WVYX7cMrAxNSDQtxaThINsbVqKvNh2dmLNPS3os
         H/FD9cEGvoYn7npZhitsEKX3FTtkP2IyMQD0sI/8yL7triX9NoznTxzhVLrdk0gMA07p
         cJ12P59YgL9dJAYgDNuiuy9KMjuixW+aFXvRz/hzmT4l1OGtl9MvGThzGK4K5pcIaZCn
         n/WCGcEskuWYuBpqbjfYwv4G95rRsntO6yaYSFDe7c4DS/Fp5hj/+yqFl7c7HjQKOPkW
         M1pQ8H5QjUOnBN3iBrjGUlsWh2LVLD9VpngYH4sYL/6v870l8Mw3hpFmgHA+m/RNw9UA
         ii/A==
X-Gm-Message-State: AFuF++lpEtfdS4wNQiaruABOUrV6Vds2jonRYqAouhq3JTeWl98J88Wy
	dhtRAqbCRT0SlZG5WIS2bdJbfAzisT2aSX+ScGh7PDIJQcQhkDb4pjJRQ57f5M1Yl+IHY5yqcLm
	Pgyx9JPTOgfbHMKi0eeLw0L5mlog7bf33+DF96eI=
X-Gm-Gg: AYBFou3wj/zhip08BkSZhDm9AOwx1TDrP28BMTsDGyxoQzODHB2yu9qEKh7+IT/ya40
	+f2NTPnHQCP6SqYA8J/AU6fd68S/E7RCmeZoKcX7Z9uXxzZk6LAP+PRQ7RckDAVN/usakZhRwUN
	iyuU77Ooectz+n5avMREywSIHN78nG02YqIJ+0il0HBo3y6+QykTivLXiDm4fSp9xYB8z3jgdYo
	S/nEklAwW4+jeNbIknC0JvaahBqyj2zDgour7wnbMdNH94NyiwOyvG7l5dZYa/yXkZhP12L1cIU
	Dn6BgAnKrecvc6mz/TgqB38idi76zIfafiN/tsfwh401KxTP32vOb6pvzF1MDL/L/dUAJZcCjD7
	2Lw==
X-Received: by 2002:a05:6820:f034:b0:6b9:3295:76fe with SMTP id
 006d021491bc7-6b932957a7emr6205281eaf.8.1788865164243; Tue, 08 Sep 2026
 03:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: musthaq ahamed <amusthaq56@gmail.com>
Date: Tue, 8 Sep 2026 16:29:11 +0530
X-Gm-Features: AcwNN1WekVR6XxZo7fWmgS8MWjIYXl3GaCD9tOmIv9PiyAvaPJHke2FasLuRM7o
Message-ID: <CADxQDVrOwfhz8B_ijEzTqFj7CG7TLQacALd1Odv2Tyc3x21Z-g@mail.gmail.com>
Subject: bpf: BPF_MAP_UPDATE_BATCH into a fresh NO_PREALLOC LPM trie / hash
 map returns -ENOMEM at element 2 on AWS Graviton5 (bpf_mem_alloc refill IPI
 races the syscall)
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	houtao1@huawei.com, toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Bug report with a reproducer and an untested RFC patch. Amazon Linux
asked me to raise it here
(https://github.com/amazonlinux/amazon-linux-2023/issues/1129).

Symptom
-------
On AWS EC2 generation-9 instances (Graviton5, Neoverse-V3: m9g, m9gd,
c9g) running Amazon Linux 2023 kernel 6.18.41 (arm64, PREEMPT_NONE,
HZ=100), a single bpf(BPF_MAP_UPDATE_BATCH) of 7 elements into a freshly
created BPF_MAP_TYPE_LPM_TRIE (key_size 260, value_size 8, max_entries
128, BPF_F_NO_PREALLOC) returns -1/ENOMEM with batch.count written back
as 1. The node has >100 GB free, memcg limits are unset, nothing in
dmesg. It fails on 99-100 % of attempts on every CPU of every such
instance we launched (8 instances, spot and on-demand, 3 AZs), and one
host in ~8 fails only on a subset of CPUs.

The same call passes 100 % on Graviton3/4 (m7g, m8g, c7g, c8g) with the
same kernel image, and 100 % on Graviton5 with kernel 6.12.100. A
BPF_MAP_TYPE_HASH with the same key/value/flags fails identically on
Graviton5 on BOTH 6.18.41 and 6.12.100 and passes on Graviton3. Seven
single BPF_MAP_UPDATE_ELEM calls, a batch of 1, or elements <= 256 bytes
never fail.

Analysis
--------
kernel/bpf/memalloc.c: for unit_size > 256 prefill_mem_cache() seeds ONE
object per CPU; the per-CPU free list is refilled only from
bpf_mem_refill() in an irq_work raised through a self-IPI when
unit_alloc() sees the list below its low watermark. unit_alloc() has no
fallback: an empty list returns NULL and trie_update_elem() /
alloc_htab_elem() return -ENOMEM. generic_map_update_batch() stops at the
first error and writes back the count.

Since 3d8dc43eb2a3 ("bpf: Switch to bpf mem allocator for LPM trie") the
trie leaf (296 bytes for a 260-byte key) comes from this allocator.
Element 1 of the batch consumes the prefilled object and raises the
IPI; element 2 runs a few hundred ns later in the same syscall.

bpftrace on the failing hosts: arch_irq_work_raise() takes ~170 ns on
Graviton5 and the IRQ-work interrupt lands ~715 ns after the raise,
after element 2 has already failed; bpf_mem_refill() then runs exactly
once per failed batch. On Graviton3 the same raise takes ~1.5 us (the
SGI write exits to the hypervisor) and the interrupt is pending when
the guest resumes, so the refill runs inside element 1's
local_irq_restore() and element 2 succeeds. IRQ-work IPI counters
advance on both, so no IPI is lost; the refill is late, not missing.
Interrupts are enabled for almost the whole path between the two
inserts (bpf_map_update_value() uses migrate_disable(), not IRQ-off), so
this is a latency race the batch loses on a platform with a cheap
asynchronous self-IPI. Kernel 6.12 is immune for LPM tries only because
its trie still uses bpf_map_kmalloc_node() directly; NO_PREALLOC hash
maps have taken >256-byte elements from bpf_mem_alloc since 6.1 and
fail there too.

I believe this is the same class as the Feb-2025 thread "bpf: Add a
retry after refilling the free list when unit_alloc() fails".

Reproducer
----------
Raw bpf(2) via Python ctypes, fresh map per iteration, one CPU pinned
per loop; inline in the GitHub issue above. Results (100 iterations x
32 CPUs):

  variant                                  m9gd 6.18.41  m7g 6.18.41
m9gd 6.12.100
  LPM key260 batch x7                      3192/3200     0/3200       0/3200
  HASH key260 NO_PREALLOC batch x7         3117/3200     0/3200       3183/3200
  LPM 7 x UPDATE_ELEM                      0/3200        0/3200       0/3200
  LPM batch x1                             0/3200        0/3200       0/3200
  HASH key8 batch x7                       0/3200        0/3200       0/3200

RFC patch (untested)
--------------------
Attached to the GitHub issue: on the bpf(2) syscall path,
bpf_map_update_value() pushes a run context so map implementations can
recognise "syscall, no program running"; trie_update_elem() and
htab_map_update_elem() then call a new bpf_mem_cache_reserve(ma, cnt)
BEFORE taking the map lock, which tops up this CPU's free list with
GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT objects charged to the map's
memcg (the same allocation the irq_work refill does). Nothing changes
for BPF programs and nothing allocates under trie->lock or a bucket
lock. I have not built or booted it; I am reporting rather than
submitting. Happy to test a fix on the affected hardware.

Real-world impact: an eBPF egress agent for CI runners makes exactly
this call per pod; on these hosts every pod loses DNS.

Thanks,
Musthaq Ahamed
