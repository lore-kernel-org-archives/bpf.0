Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794895404;
	b=hCMhzJI3EWPL4MOv2jVQqfwFt9PyIld8rAOL48q0YWWkWELFGCJEmuoHbj00/qjfabRS
	 FHez/mnAtll5LLeDnzwNJ6jIZEWWhO/UNAeRa9koLfNC4rpZ79VvW2RYAp+EcYxKJOdyf
	 Mk2pV8DDg1Db4coYQMW181fgShbJDnVH5JVWIGeEirUMvVPYRdsxcpjHt94V4UGC34+UL
	 LKXL/VzN3QEHi6+A8acbYXypkjbVOo1tC2nGPSsKXj42EUZ9Nt3ij6mVB3UwRJ2gM9GDn
	 PtdpPZwfxzrKQRzgo4ojoGCpw6cN1puLdCSFtYdYbCjUGJShQIswMx1N7hOtJFWJCLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gIZhjHYfEvWsFhzGaQU0o3C9UFd/rJ6DA75PnrIKr1w=;
	b=0a9dAkDN7/z/8woDbo8sQc5jIDU5cybluYbPxaKEY7YZSVsiVlrzIFmDXXtxeflklS6L
	 2ydY3ey0bI7FXqDY6I6B6sGvIdf7VHzUZwlx3LJiUQSxgZwn3lKPvscbhcBJj74SsJvBj
	 +psNhNQsCJiplmwbzYWlqqPKuD0K42RStOvYMd2zm2cikXqE27oB8jbWIAkaqQ+kpSzXg
	 7pqzqh9sqD0VqDewvL0PBYg/fqjm9Hf2JT/as0zbrjelTFRxiAm6fmBnubQ/JslCkrcs3
	 C1l36kuD7xRyKRWbnrTmIwrdkkKLdK+dbB4TaxGMOMlfljR/I33JXsF9jyTsIzQvKyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aydbje44;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.75
Received: from mail-lr2-f11.google.com (mail-lr2-f11.google.com [74.125.230.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED5606A32C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 06:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5ED5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aydbje44
Received: by mail-lr2-f11.google.com with SMTP id 38308e7fff4ca-3ae3d6e579bso14078921fa.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 22:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794895402; cv=none;
        d=google.com; s=arc-20260327;
        b=jz+R4hnjTiZi2cH5LZWXAFfRLTjmHKC09ymnm/pDE5zkzR0l/nQtad4uFfBBSafrcI
         9e+NhriD3ASHyyNJW5KZ1eIz68ioK8c5rlygxc5mALkMG7sErCiDixStFLKwPnkS/STE
         vwIvxWdiFxy++2Vg/wbpe/agI5zf/tmU0GSjMc7ywCREXczWtkATQ5oii87ukmxWIze4
         QlyDGo8Jt0zSsnQo7MSb3ZwxXu26D9Rd4JyVGR17IBlF7IRADE6se5mst+ewbY6ygKWU
         tx1+vtkDcXEh9A4RZ1rm6zTq4A6DhNE9eewlbq4LYeRYOG+0HfRtW9M9aLcFu5NPa6E6
         wAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gIZhjHYfEvWsFhzGaQU0o3C9UFd/rJ6DA75PnrIKr1w=;
        fh=jj3CyHUcLDY15U8+Ghu7wWqPq8RsO4TB2+6tbcLGOBc=;
        b=pCu/8JTThXY3c5LGEiQbw7wavylkYfPQpBYjvjOXwPckgMIbLsIgldw0FET4uTvSmb
         HiPOyNufqlYJwujXCJ4yOq1ARUFS+bh/LCDbY2CkHaq26up2lH6iPyKEpi6JwnTfCteC
         b6ttcFPcEtAhz112AcUNlXgtGkTfyybnJPjSoNs8pDzS5nFO3J3haS3ONRi5Hz72Mc/Y
         wKHITQfk/eIXGAh/9j8OSV5yYSflrNxmB97XF7o6opLxEtxcbGsROIUJG0WAlA97JQvh
         PLsR0CdxQWIDieoo3d87ZLNvpam/dSRnjwAXUKdANp2lTINFHsUx5zbP0xgid58wNkSN
         UuXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895402; x=1795500202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gIZhjHYfEvWsFhzGaQU0o3C9UFd/rJ6DA75PnrIKr1w=;
        b=aydbje44qaC4TghnGiJ2uqbtriSyssK2JFbgpb65AHuqh8AWcxLwhCUmIWrXfyNbfg
         4lggBoQQNzjL2M/2Sqk3pQYbTQwSycNFZ6/bKKEMqxLJB8vOIIuBZGegWy7qdKInke46
         kzdUjLofzKkFWWS5piUf9MxCA8ZF7uzycDvG18j3dLtVGsNi7O/wVgvVjVdCDKXuWteD
         /bzYxxGanx0LgijL7/UxogmZfYwiC3tNL+tu0rltfDHVCi+gD7Ym+T9HtzUE2BZEyyQf
         ld+QDfBHH5fpEoqyeB68kjJsRRic3WUSNZaIjUqJtSz0IfSQQzmZtVAQt7FjdETR1tIf
         mnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895402; x=1795500202;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gIZhjHYfEvWsFhzGaQU0o3C9UFd/rJ6DA75PnrIKr1w=;
        b=of80Slsj7B/TEtACSJbyKtJCx8Tha5tRyUf2mVH/q9zKg60AM3r+yZGNnUA7Elc69V
         Lxv8k+IA7Pk0scHRkkVSbaeMkcwEPTMabm86sSpfVxPYNN0GsruALVHoGedb2Dgln3GZ
         aNDFSYF7yih+9YfCZm5pidb5s4ExNBWUJbvjMxtn9zxBK4IMDxeaoQX/6M4vS04CuTFr
         cqWaDKX03mN9SkcEJ52Oaw1Djs/oh/LZ1RAWhpBSe+wyqwCmEA/SOn7EP3ezSQ66yi1f
         4ncvFP91zdL7EU63aAX/FYhrs49On6U1rS6YC2s8VQVb3sM28KSk2rgUBOkoZz+mlXnQ
         NduA==
X-Forwarded-Encrypted: i=1; AL+hErEawTU+jLhWYiZhR81wWKyEfUAYHInqNfH+2WzRKPXFZmOpGVlm7ib2oX0VVIBrZrDq/mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ax5PGgwHZ6wEYUyxW9W6HHFDtOKuKMgr0KlBVZLlqf9Uy4kN/
	VwSsAXD+fbPVwpxUxlVFzzJYVAd7QwRsRZOj7HlNuhu0gAbPSeYDh1Ph3fITX/ayOUpaRfGz98/
	73SZq9gqQNCYF41jgmxbToWRjK/Br/rE=
X-Gm-Gg: AYBFou2Sww48wcr3B2YO/pR5876eqFJrktjUz5xLrn85mxTBBU+mYE9usIPR4mm3w7O
	9x0jTFZJGtjyfx1h+Nam/sB5J9K8p4qvhmqfsJhoyR0/qXMox0v0Nkp0XDRHXOQyMJS+nJgBdiw
	pk7wJigxeyiLHNJUGdotL8UNKkU0vGDL2Nxt+qQTQ+uU6BlU1ynD3Z9h1XeQca/EnmOIbdBC6H+
	FskXgGUCQeWE853rtHQjsQhQno1NQfRRfM1Eeu2OVaKEKl9SUo7NZ9+PxIu9Y1S5IwZUr4hUQwS
	v+ige1C2ioMGsL6Y1Mqzog+h7ZG9cZPQ18vRDuquhf7gfvjXiuCaPS4f2ja6Ym0UYlqMYZtmW6E
	6ap7+vODWP4sYpU6KZ+sKclpgBLePxr2LMzTHmZuLo2BXcMkJVEj3Pl9kqgA679tpwXVgwg==
X-Received: by 2002:a2e:a105:0:b0:3ae:68:d07b with SMTP id 38308e7fff4ca-3ae2b5399b8mr34774561fa.11.1794895401501;
 Mon, 16 Nov 2026 22:03:21 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAO-4RZ28RXpMv-o0R9uxiuoSR7mB5OtFCc-_JjBK2UZLYZVWDA@mail.gmail.com>
In-Reply-To: <CAO-4RZ28RXpMv-o0R9uxiuoSR7mB5OtFCc-_JjBK2UZLYZVWDA@mail.gmail.com>
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Tue, 17 Nov 2026 14:03:06 +0800
X-Gm-Features: AclHuK9_G1iU2pO1rNcQ40e3mKSLDnGM0oVMq69q9-lv0SS0urI6F0Lt-wycoik
Message-ID: <CAO-4RZ20wmkA8PAeaqwe7jm2jvKe3VLUJrVVqOtfmNb0Dx+4yQ@mail.gmail.com>
Subject: Re: [BUG] HID: uhid: general protection fault in synchronize_srcu on
 device-creation failure
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin, Jiri,

We found a reproducible general protection fault in the HID-BPF device
teardown path on v7.4-rc3 with syzkaller.

Key log excerpt from the rc3 external run
(logs/external-verification/run1-serial.log, hit at 126.45 s):

  [  126.449391][T13653] Oops: general protection fault, probably for
non-canonical address 0xdffffc0000000030: 0000 [#1] SMP KASAN NOPTI
  [  126.466709][T13653] KASAN: null-ptr-deref in range
[0x0000000000000180-0x0000000000000187]
  [  126.467342][T13653] CPU: 3 UID: 0 PID: 13653 Comm: syz.7.99
Tainted: G            E       7.4.0-rc3-kernsight-kasan #1
PREEMPT(full)
  [  126.469386][T13653] RIP: 0010:synchronize_srcu+0x53/0x3c0
  [  126.472346][T13653] RDX: 0000000000000030 RSI: ffffffff890fc26c
RDI: 0000000000000180
  [  126.472942][T13653] RBP: ff1100014fa06198 R08: 0000000000000000
R09: fffffbfff25642dc
  [  126.473537][T13653] R10: ffffffff92b216e7 R11: 0000000000000001
R12: ff1100014fa061d8
  [  126.474212][T13653] R13: ff1100014fa05eb0 R14: ff1100014fb20098
R15: ff1100014fb200a0
  [  126.476884][T13653] Call Trace:
  [  126.477142][T13653]  <TASK>
  [  126.477375][T13653]  hid_bpf_destroy_device+0x64/0x80
  [  126.477785][T13653]  hid_destroy_device+0x28/0x240
  [  126.478174][T13653]  hid_allocate_device+0x453/0x520
  [  126.478576][T13653]  uhid_dev_create2+0x16a/0x910
  [  126.478968][T13653]  uhid_char_write+0xa68/0x1040
  [  126.479352][T13653]  vfs_write+0x2b6/0x1140
  [  126.481239][T13653]  ksys_write+0x1f4/0x240
  [  126.482438][T13653]  do_syscall_64+0x132/0x7c0
  [  126.482803][T13653]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  ...
  [  126.502908][T13653] Kernel panic - not syncing: Fatal exception

Critical call chain:

  synchronize_srcu+0x53/0x3c0
   hid_bpf_destroy_device+0x64/0x80
    hid_destroy_device+0x28/0x240
     hid_allocate_device+0x453/0x520
      uhid_dev_create2+0x16a/0x910
       uhid_char_write+0xa68/0x1040
        vfs_write
         ksys_write
          do_syscall_64

What seems to happen:

- `hid_allocate_device()` calls `hid_bpf_device_init(hdev)`, which does
  `init_srcu_struct(&hdev->bpf.srcu)`.
- If that initialization fails, `hid_allocate_device()` jumps to `out_err`
  and calls `hid_destroy_device(hdev)`.
- `hid_destroy_device()` calls `hid_bpf_destroy_device()`, which does:

    synchronize_srcu(&hdev->bpf.srcu);
    cleanup_srcu_struct(&hdev->bpf.srcu);

  even though `hdev->bpf.srcu` was never successfully initialized.

The faulting address (`0xdffffc0000000030`) and the `0x180` offset to the
SRCU fields are consistent with dereferencing that uninitialized structure.

Should `hid_bpf_destroy_device()` tolerate an uninitialized/failed SRCU
setup, or should `hid_allocate_device()` avoid the destroy path when
`hid_bpf_device_init()` failed? The former looks safer for other error path=
s,
but we have not established which fix you would prefer.

How to reproduce reliably:

1. Build vanilla v7.4-rc3 with:
     CONFIG_KASAN=3Dy
     CONFIG_PROVE_LOCKING=3Dy
     CONFIG_HID_BPF=3Dy
     CONFIG_DEBUG_INFO=3Dy
   The bzImage used here has sha256
   0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882.

2. Boot a Debian trixie x86_64 guest (6 GiB RAM, 4 vCPU, KVM) with at least=
:
     root=3D/dev/sda console=3DttyS0 oops=3Dpanic panic_on_warn=3D1
   The full QEMU command line is in environment.txt.

3. Copy syz-execprog and syz-executor built from syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1, plus
   reproducer/repro.kernsight.prog, into the guest.

4. In the guest, as root, run:

     syz-execprog -procs=3D8 -threaded -repeat=3D1 \
         -executor ./syz-executor repro.kernsight.prog

Expected result: GPF in `synchronize_srcu` after roughly 2 minutes, with th=
e
call chain above, followed by `Kernel panic - not syncing: Fatal exception`=
.
We observed the hit 2/2 on fresh VMs:

  Run 1: 126.45 s after boot
  Run 2: 135.87 s after boot

The recipe is an 83-entry state-reconstruction recipe and is self-contained=
.

Repository contents (all v7.4-rc3):

  https://github.com/Zheng-zheng-codes/synchronize-srcu-general-protection-=
fault

- README.md: report, root-cause analysis and reproduction notes.
- environment.txt: rc3 kernel/guest image hashes, QEMU command line and
  syzkaller revision.
- kernel.config: v7.4-rc3 kernel configuration.
- reproducer/repro.kernsight.prog: 83-entry self-contained state recipe.
- reproducer/repro.priming.prog: priming portion of the state recipe.
- reproducer/repro.prog: triggering testcase.
- reproducer/repro.report, repro.stats, repro.outcomes.jsonl,
  repro.context.json: pipeline verification evidence (2/2 fresh-VM replay).
- logs/log-0.txt, logs/report-0.txt: original rc3 syzkaller log and crash
  report.
- logs/machineInfo-0.txt, logs/title-stat.json: guest environment and title
  statistics.
- logs/external-verification/run1-serial.log,
  run2-serial.log: full serial consoles of the two independent rc3
  reproductions (126.45 s and 135.87 s).
- logs/external-verification/*-run.log: the corresponding run records.
- SHA256SUMS: checksums for the inputs and logs.

Best regards,
Zheng Zheng

On Sat, Oct 24, 2026 at 11:27=E2=80=AFPM =E9=93=AE <fengaojigui88@gmail.com=
> wrote:
>
> Hi Jiri and Benjamin,
>
> I observed a general protection fault (KASAN null-ptr-deref) in
> synchronize_srcu() while fuzzing HID/uhid with syzkaller. I reproduced it=
 on
> Linux 7.1.3 and on Linux 7.3.0.
>
> The fault happens on the error path of hid_allocate_device(). With fault
> injection making hid_bpf_device_init() fail (init_srcu_struct() allocatio=
n
> failure, failslab), hid_allocate_device() jumps to out_err and calls
> hid_destroy_device() -> hid_bpf_destroy_device(), which unconditionally c=
alls
> synchronize_srcu(&hdev->bpf.srcu) and cleanup_srcu_struct(). SRCU
> initialization failed, but the error path still invokes synchronize_srcu(=
) on
> the unsuccessfully initialized SRCU structure; check_init_srcu_struct() t=
hen
> dereferences it and the kernel takes a GPF:
>
>   hid_bpf_destroy_device drivers/hid/bpf/hid_bpf_dispatch.c:632
>   hid_destroy_device     drivers/hid/hid-core.c:3085
>   hid_allocate_device    drivers/hid/hid-core.c:3056   (out_err path)
>   uhid_dev_create2       drivers/hid/uhid.c:511
>
> Related patch
> -------------
> The following posted patch appears to address this error path:
>
>   "[PATCH] HID: core: fix device cleanup on allocation failure"
>   by Tristan Madani (2026-09-04)
>   https://lkml.iu.edu/2609.0/09658.html
>
> The patch replaces hid_destroy_device() with put_device() in the
> hid_allocate_device() error path; it also carries
> Fixes: 6cd735f0e57a ("HID: bpf: protect HID-BPF prog_list access by a SRC=
U")
> and Cc: stable.
>
> The kernels I tested (7.1.3 and 7.3.0) do not include that fix:
> hid_allocate_device() still calls hid_destroy_device() on the
> hid_bpf_device_init() failure path, and the crash reproduces there. Pleas=
e
> confirm whether the patch has been queued for stable/backporting; I can t=
est
> the backport if useful.
>
> Environment
> -----------
> - Kernel A (found and reproduced): 7.1.3-kernsight-kasan #13 SMP
>   PREEMPT_DYNAMIC (2026-10-13), x86_64, KASAN/KCOV,
>   CONFIG_FAULT_INJECTION=3Dy, failslab enabled. No HID source changes.
> - Kernel B (reproduced 2026-10-24): 7.3.0-kernsight-kasan #1 SMP
>   PREEMPT_DYNAMIC (2026-10-20), x86_64. Vanilla 7.3.0 tarball
>   (sha256 87363c24f10e06321eb362765521094e94471f6bff8bce2d6b3e40f39f00495=
3),
>   built with KASAN/KCOV and fault injection. No HID source changes.
> - Guest: QEMU 6.2.0, 4 vCPU, 6 GiB, KVM, x86_64. A fresh VM per run.
> - Syzkaller: revision 853b104bb454141a5b0fc0e4218ec78e9f34ffb1+ (2026-09-=
18).
>   The "+" denotes local KernSight integration changes (seed ordering/stat=
e
>   feedback: pkg/kernsight, prog/kernsight_*, syz-manager/kernsight_*,
>   pkg/execbackend, snapshot support in vm/qemu). The executor used is the=
 one
>   built from this tree.
> - Reproduction rate: 7.1.3: syz reproducer verified (no C reproducer was
>   produced). 7.3.0: 1/1 with the stored 68-program sequence; the standalo=
ne
>   two-call program did not reproduce in 2 runs. (1/1 does not establish
>   stability.)
> - Kernel command line (7.1.3; 7.3.0 is identical, see repository):
>   root=3D/dev/sda console=3DttyS0 fstab=3Dno rw earlyprintk=3Dserial
> net.ifnames=3D0 oops=3Dpanic panic_on_warn=3D1 panic=3D86400 hung_task_pa=
nic=3D1
> softlockup_panic=3D1 nmi_watchdog=3Dpanic
> sysctl.kernel.hung_task_all_cpu_backtrace=3D1
> sysctl.kernel.panic_on_rcu_stall=3D1
> sysctl.kernel.max_rcu_stall_to_panic=3D1 rcupdate.rcu_expedited=3D1
> rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_pointers page_owner=3Don
> sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4
> secretmem.enable=3D1 msr.allow_writes=3Doff coredump_filter=3D0xffff
> vsyscall=3Dnative kvm-intel.nested=3D1 spec_store_bypass_disable=3Dprctl
> nopcid vivid.n_devs=3D64
> vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1=
,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2
> netrom.nr_ndevs=3D32 rose.rose_ndevs=3D32 smp.csd_lock_timeout=3D100000
> watchdog_thresh=3D55 workqueue.watchdog_thresh=3D140
> sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=3D16
> max_loop=3D32 nbd.nbds_max=3D32 comedi.comedi_num_legacy_minors=3D4
> kunit.autorun=3D0 vcan.echo=3D1
>
> Reproduction on 7.1.3
> ---------------------
> Fresh KVM guest, kernel as above, from the guest's /tmp:
>
>   scp syz-execprog syz-executor repro.prog root@guest:/tmp/
>   ssh root@guest
>   cd /tmp && chmod +x syz-execprog syz-executor
>   ./syz-execprog -procs=3D1 -repeat=3D1 -disable=3Dswap -executor
> ./syz-executor ./repro.prog
>
> Settings: sandbox=3Dnone, threaded executor, procs=3D1, repeat=3D1, no ad=
ditional
> syzkaller features; a single program.
>
> The program (2 calls; fail_nth: 5 on the UHID write):
>
>   r0 =3D openat$uhid(0xffffffffffffff9c, &(0x7f0000000000), 0x2, 0x0)
>   write$UHID_CREATE(r0, &(0x7f0000000140)=3D{0x0, {'syz1\x00',
> 'syz0\x00', 'syz0\x00', &(0x7f0000001300)=3D""/191, 0xbf, 0x24, 0x2,
> 0x160e, 0x3, 0xffff8000}}, 0x120) (fail_nth: 5)
>
> No C reproducer was produced for this report.
>
> Reproduction on 7.3.0
> ---------------------
> Same procedure with the 7.3.0 kernel and the stored execution sequence:
>
>   scp syz-execprog syz-executor repro.kernsight.prog root@guest:/tmp/
>   ssh root@guest
>   cd /tmp && chmod +x syz-execprog syz-executor
>   ./syz-execprog -procs=3D1 -repeat=3D1 -disable=3Dswap -executor
> ./syz-executor ./repro.kernsight.prog
>
> The sequence contains 68 programs replayed by a single executor process
> (procs=3D1), one at a time in file order (repeat=3D1, sandbox=3Dnone, thr=
eaded
> executor). Note that repro.prog retains the original syzkaller repro opti=
ons in
> its first line (Threaded:true Repeat:true Procs:6 ...); the manual replay=
s used
> the command above. The host/guest commands and console outputs of all thr=
ee
> runs are in RUNS.md in the repository. The UHID trigger is program #64
> and appears again inside the final
> program #67. There is no parallel replay, but earlier programs can leave
> kernel-side asynchronous work behind, so their effects may persist.
>
> Materials (programs, full logs, reports, kernel configs, command lines,
> sha256 manifest, and a verify.sh that re-checks the numbers quoted here):
>   https://github.com/Zheng-zheng-codes/hid-uhid-synchronize-srcu-repro
>
> In our runs the sequence log contains exactly one GPF report, first print=
ed at
> t=3D276.2 s. In the two standalone 7.3.0 runs, syz-execprog exited with s=
tatus 0
> and neither serial log contains the GPF; the captured output does not inc=
lude a
> final executed-program count.
>
> Fault injection was enabled for this reproduction
> -------------------------------------------------
> The write$UHID_CREATE() call is annotated with fail_nth: 5. During this
> execution the kernel logged:
>
>   FAULT_INJECTION: forcing a failure.
>   name failslab, interval 1, probability 0, space 0, times 0
>
> followed by the GPF report.
>
> GPF report (7.3.0, latest verification)
> ---------------------------------------
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc000000002f: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000178-0x000000000000017f]
> CPU: 3 UID: 0 PID: 12655 Comm: syz.4.84 Not tainted
> 7.3.0-kernsight-kasan #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:synchronize_srcu+0x53/0x3b0
> Code: 48 83 ec 08 80 3c 02 00 0f 85 f1 02 00 00 48 b8 00 00 00 00 00
> fc ff df 48 8b 5d 40 48 8d bb 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
> 02 00 0f 85 c1 02 00 00 48 8b 83 78 01 00 00 a8 03 74 08 48
> RSP: 0018:ffa000000519fa20 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000002f RSI: ffffffff88fa6f1c RDI: 0000000000000178
> RBP: ff110001208be198 R08: 0000000000000000 R09: fffffbfff251b453
> R10: ffffffff928da29f R11: 0000000000000001 R12: ff110001208be1d8
> R13: ff110001208bdeb0 R14: ff11000110774098 R15: ff110001107740a0
> FS:  00007fb68b6b0640(0000) GS:ff110001ef83e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001300 CR3: 000000011c3bd000 CR4: 0000000000753ef0
> PKRU: 00000000
> Call Trace:
>  <TASK>
>  hid_bpf_destroy_device+0x64/0x80
>  hid_destroy_device+0x28/0x240
>  hid_allocate_device+0x453/0x520
>  uhid_dev_create2+0x16a/0x910
>  uhid_dev_create+0x448/0x560
>  ? __pfx_uhid_dev_create+0x10/0x10
>  ? __might_fault+0xe5/0x190
>  uhid_char_write+0xe06/0x1040
>  vfs_write+0x2b6/0x1160
>  ? __pfx_uhid_char_write+0x10/0x10
>  ? __pfx_vfs_write+0x10/0x10
>  ? __fget_files+0x1f6/0x3b0
>  ? __fget_files+0x200/0x3b0
>  ksys_write+0x1f4/0x240
>  ? __pfx_ksys_write+0x10/0x10
>  do_syscall_64+0x12e/0x7a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb68a7b2b7d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fb68b6aff98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fb68aa45fa0 RCX: 00007fb68a7b2b7d
> RDX: 0000000000000120 RSI: 0000200000000140 RDI: 0000000000000003
> RBP: 00007fb68b6b0010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007fb68aa46038 R14: 00007fb68aa45fa0 R15: 00007fb68b690000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:synchronize_srcu+0x53/0x3b0
> Code: 48 83 ec 08 80 3c 02 00 0f 85 f1 02 00 00 48 b8 00 00 00 00 00
> fc ff df 48 8b 5d 40 48 8d bb 78 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c
> 02 00 0f 85 c1 02 00 00 48 8b 83 78 01 00 00 a8 03 74 08 48
> RSP: 0018:ffa000000519fa20 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000002f RSI: ffffffff88fa6f1c RDI: 0000000000000178
> RBP: ff110001208be198 R08: 0000000000000000 R09: fffffbfff251b453
> R10: ffffffff928da29f R11: 0000000000000001 R12: ff110001208be1d8
> R13: ff110001208bdeb0 R14: ff11000110774098 R15: ff110001107740a0
> FS:  00007fb68b6b0640(0000) GS:ff110001ef83e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000001300 CR3: 000000011c3bd000 CR4: 0000000000753ef0
> PKRU: 00000000
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
> The 7.1.3 report is included in the repository (logs/report-7.1.3.txt) an=
d has
> the same path:
>
>   RIP: synchronize_srcu+0x53/0x3b0 kernel/rcu/srcutree.c:1576
>   check_init_srcu_struct ... srcutree.c:441 [inline]
>   hid_bpf_destroy_device+0x64/0x80 drivers/hid/bpf/hid_bpf_dispatch.c:632
>   hid_destroy_device+0x28/0x240 drivers/hid/hid-core.c:3085
>   hid_allocate_device+0x453/0x520 drivers/hid/hid-core.c:3056
>   uhid_dev_create2+0x16a/0x910 drivers/hid/uhid.c:511
>
> Analysis
> --------
> hid_allocate_device() initializes the HID-BPF SRCU via hid_bpf_device_ini=
t();
> when that fails, the error path calls hid_destroy_device(), whose BPF tea=
rdown
> runs synchronize_srcu()/cleanup_srcu_struct() on the unsuccessfully initi=
alized
> SRCU structure. The posted patch proposes to address this by releasing
> the device directly
> with put_device() on the error path, which matches this analysis.
>
> Could you confirm whether this is the issue addressed by the patch above,=
 or
> whether a separate fix is needed for the hid_allocate_device() error path=
? I am
> happy to test proposed patches.
>
> Attachments / repository contents
> ---------------------------------
>   repro/repro.prog               syz program, includes fail_nth: 5 (7.1.3=
)
>   repro/repro.kernsight.prog     68-program execution sequence (7.3.0)
>   logs/report-7.1.3.txt          original 7.1.3 report
>   logs/repro-report-7.1.3.log    7.1.3 reproduction report
>   logs/gpf-7.3.txt               7.3.0 GPF report (also inline)
>   logs/serial-7.3.log            full 7.3.0 console (sequence replay)
>   logs/serial-7.3-minimal1.log   7.3.0 standalone run 1 (no trigger)
>   logs/serial-7.3-minimal2.log   7.3.0 standalone run 2 (no trigger)
>   kernel/kernel-7.1.3.config, kernel/kernel-7.3.config
>   cmdline/cmdline-7.1.3.txt, cmdline/cmdline-7.3.0.txt
>   verify.sh                      re-checks the numbers quoted in this mai=
l
>   scripts/replay-kernsight-prog.sh   the exact run script used for the re=
plays
>   MANIFEST.sha256                sha256 of every file
>
> Best regards,
> Zheng Zheng
