Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794739133;
	b=tzDjPKH8y08Ce9iYc5Cp/0t78h5mCjqu8eM7PmnRIP7tSVHMxRIeKMIiiyU4sQCMMK5z
	 3qwu7d4t0iSCqnTcMob6Jqop+gQHCYDXZy6lDsmg8fto2c8YjCsBc2RbTLtXT+3WG33K+
	 kzOjetFXNApsitNEf+HE3NdyPunCBXP4d/tryp5RLgxZoMyu4daInTb1vp+vC/hKdewi5
	 ba5RoDI7T4E77TNMoc6dx0sWKtD7XrjwzaPjR5ixiJE9heMFKIvNKkyFxDA1KyCIQe3NQ
	 22ijQ/XVIjSW8nvoO0YiGg7WpQUJMtxv3DyGMSweeSjf63RF4g88VJiBtkIwyf5jQiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ryb/wfZrmgOaxQ6NRfhb3Yyqal01lrdSf8WgQu2kxbs=;
	b=DasU8Yerfw9f8cYqh8+SWyBl4/rNSERKoWbAW3QK/SZYG5UtkUd+Yin+WNQ1NXB920dc
	 uwUkM0awhvqqOMyF8WCLa7xnEaLCfpMCQZb9SKShR4doozQlaEGWsG8NJuvttTAXMVTY+
	 RSgSWMxQhYrGvh/fSAah1Qrq94vioSnsxu2J5j7EYPPZ/Jo4GDPYMxBHCbwkDP+y5w/vb
	 8UL+LMZCeLfmEet0LC7WPxZgwLX/BL5o32xd/aDrxgiXksnp9HcqTeJ9KuzLHtp9qQL5V
	 InaTHd96NJoAwwDVObqcrrzvTPerwkSR4qm99Aj1XAfcojEqgwqiBZDiI1qyRzwfHGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+vmJn2P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D6606A31E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A96D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V+vmJn2P
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3acff0d1090so15512811fa.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 02:38:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794739131; cv=none;
        d=google.com; s=arc-20260327;
        b=skDrroAzem+evMlVPKCbXfYUxcqPXpFboMVcLUxvRT07ERcSXtqb0Npb5/blr7TmHV
         nAfR/KR1nMNmLSFo8P1QujKnnm/kQ66aV1sYL6k8veexa+LUzdfA6j7aekiPa1tmZYYP
         S1I23FewjU3do1MU9z40CyH8MKPZsSYHbcAfQoKT1AKsg3nJAUIGCTDCTJjCTdearVew
         Ewdc6Hd1Unawo1af86lBdZjeE3MDZW5GkfdkMCmJ9ulPMVkofIDtpYop8Ac8kIm/b03/
         vZuHGTZ763Gnpx+k7+KnsQ+Xbowmt5+jACMmAxMj6lWX1mBzRT76Dg21rh6wrJu/rPB6
         wKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Ryb/wfZrmgOaxQ6NRfhb3Yyqal01lrdSf8WgQu2kxbs=;
        fh=CaCCIH8sfE9gxgCtsfL0yo0py9XnFRvHQxa8wOiPwrM=;
        b=DYAC1nTksRNvFc+DmmVg0rnT5YuTg7BKUAgG6mTF4AZEbALdIsRM78BpSH89B2/QX4
         Mi+frvm/FMU05Vxak+T3mR/CW5RItcSIK3FIuQmtwUqmb/8zQ0bd6WvydWF66tOBPIrv
         qCeZ3wZl+h5u7avtRFWz0OPAqTEaGHApK89mY57AYrcmKA+mEJxRg1aT+tLtp10yJW3+
         KOw3nWJGl1dUwZLNlVsdskeXGotYru+CsG15UByMbPT0KWqXqtS/0wCRY5RMFOvrZX1s
         WxadT1qai924r42r8DpCRUE/kFb6xtsLi+GVMt0aZM2OdOxdUfTsUiedTQrxfKj13ZSG
         YKiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794739131; x=1795343931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ryb/wfZrmgOaxQ6NRfhb3Yyqal01lrdSf8WgQu2kxbs=;
        b=V+vmJn2PgHtlcho8H3vKkEnloQ+Ch3/mRwRIHa38K1ZHpjPdokVXxd7Qiz15njf1fp
         4GSwEETpcQBomyYRJuwl/DtOo1WEfVp8YLXF/8Yshp+ipovuPNC6LmI91uhVBYnS6uW2
         wy3CcTROJ91nZL120kL/qtITW5WVbmEx4VaOuj0TBIU2Kpwe+YPWPyFsbGmtcFdaq+5O
         4Kh9MrKsYSpUBYi1e6zxEF6kPlCNpaI4oG5RkUFkjKMvGLHLmd1182iM8WGFyEWFLpsJ
         qU/uYCPds4t1CrYZKh7knky96GWMOQHw9Apzx2Egxz+capMCMuHUdqLWUpj0kLQl/PZk
         50Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794739131; x=1795343931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ryb/wfZrmgOaxQ6NRfhb3Yyqal01lrdSf8WgQu2kxbs=;
        b=beLLEQl0vUKT9rMCA3OBa447REB8MV89Hn7mqt2YQBJ7lsY6ZW2STRy9knVgBrV1Nd
         DS8AQWobmmvsSXUyUW0Iq97yPiIw20r3vBi1o+HgNLe34bB+naEmcX73CyBQjx7CW61X
         MG90yKywZMuJ36NWYhlIv+eUXvLFc5qv7Ld1mFWpP9nNFLu+IqWdNXQvoCoJV3wMTM12
         Zu4DqmjPaYjmheYQu2FRdmQQf0Alj5CGeuFeqvAryp5N8r+Yv2db4+QDRnwnrqoeG/hN
         OMsf48RCD9SqxnYswdkYAds/2957Pccp6gPee5m60RpTu6GMjmE0fz3iZYV1Iu6yjX8D
         cZNg==
X-Forwarded-Encrypted: i=1; AL+hErFTo+HKmTPlbuY7IT5yNN1XhpnZ5bJ1czg7i4Rwoq0Dlzx8g79BZMJYHovJfxEZ5DchAGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nsyB+S+u6fivpzjdH0rQ8cfKzE/FgpMZXDOVPOlIPQ6UOYc7R
	ir9IKx1FPPxsY9vEoCVnMYCJOsMTVPKywCHhvzOlwDsoH/T0hj4wh19x46oggj8Z3Do/LgfstTM
	V3WNxIYYjE/ns35E9INwkPb0Un9GuboE=
X-Gm-Gg: AYBFou2zr/oyQ0VPOHPjieffoljtVlYREZQmIwAaioPpeHbXKUi1phFcMg67QVsbDet
	KQWGgvaL4fnml9aaNyTptxHVEUYGfl9yPdHnN/HC2ZZp2K4LevjHnJpuc2Wk4MMGwAA5ZsmnU5J
	kMvMob6l92pBj4gP8lBqX2i/14yv2kCux9dAVm88IhsBZEZzbOwPkElNMWcboY3ZSbQvI2FK5Bf
	3JFjGw8f8BMZZ76WHT8G0fdVETO+q45nyC2pi94pil4E/EqjelqeBrIJlVE8wLBAOlFwbUnbw1Q
	bwbmSLwRxJ/RxpMSkF7iFt3w+lK6Vz/f8wUHYyStKzl3ur12LNJ5/NTDZRHjMHAWETcPrG+yF3t
	9ja/oH43lVvZUGJfNyyi0APADw/K4Yn43fROAdAkoiwPcVZx2lshDIcKVwHwe8ToMQI3Y4hzzJ9
	tRPXl2YXnlnpU=
X-Received: by 2002:a05:651c:1616:b0:39c:624d:82b9 with SMTP id
 38308e7fff4ca-3ae2b4c7796mr23017721fa.4.1794739130352; Sun, 15 Nov 2026
 02:38:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Sun, 15 Nov 2026 18:38:37 +0800
X-Gm-Features: AclHuK-fYt9ioa0lktiCE_vrn3KMWe83BvFzaVAXQXnSoIIgq1MmbSv-CgZhcBQ
Message-ID: <CAO-4RZ11U=6F_oMmkRpH_KLqX51fMA048Z5eZTa=+dg0q0UjkA@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_WARNING_in_register=5Ffprobe=5Fips_=E2=80=94_large_kmall?=
	=?UTF-8?Q?oc_during_fprobe_registration_=28mm=2Fslub=2Ec=3A5459=2C_v7=2E4=2Drc2=29?=
To: mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

We found a reproducible warning during BPF kprobe-multi link attachment
on v7.4-rc2 with syzkaller:

The following is an excerpt from the run-3 verification log in the reposito=
ry,
logs/external-verification/external-verification-serial-run3.log
(selected call-trace frames):

  [  135.891732][T14253] WARNING: mm/slub.c:5459 at
___kmalloc_large_node+0x13f/0x180, CPU#0: syz.4.95/14253
  [  135.909930][T14253] RDX: 00000000ffffffff RSI: 0000000000000dc0
RDI: 0000000002000030
  [  135.912869][T14253] R13: 0000000000100000 R14: dffffc0000000000
R15: 0000000002000030
  [  135.916749][T14253] Call Trace:
  [  135.917020][T14253]  <TASK>
  [  135.917261][T14253]  __kmalloc_large_node_noprof+0x1f/0x80
  [  135.918112][T14253]  __kmalloc_noprof+0x53c/0x7f0
  [  135.918959][T14253]  register_fprobe_ips+0x199/0x1df0
  [  135.919866][T14253]  bpf_kprobe_multi_link_attach+0xf50/0x13f0
  [  135.923516][T14253]  __sys_bpf+0x4a20/0x4ef0
  [  135.931744][T14253]  __x64_sys_bpf+0xd0/0x140
  [  135.932506][T14253]  do_syscall_64+0x132/0x7c0
  [  135.932870][T14253]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  [  135.939128][T14253] Kernel panic - not syncing: kernel:
panic_on_warn set ...

The triggering program uses bpf$BPF_LINK_CREATE_XDP with the @kprobe_multi
branch, specifying cnt =3D 0x100000 (1,048,576) =E2=80=94 exactly MAX_KPROB=
E_MULTI_CNT
(1U << 20, kernel/trace/bpf_trace.c:45). The count passes the existing
limit check and proceeds to register_fprobe_ips(), which calls
kzalloc_flex(*hlist_array, array, num) (kernel/trace/fprobe.c:918) with
num =3D 0x100000. The resulting ~32 MiB kzalloc triggers the SLUB size
check WARNING. Our guest runs with panic_on_warn=3D1, which escalates this
warning to a kernel panic.

A question for maintainers: should the BPF count limit also account for
the actual memory footprint of the fprobe internal array, or is the SLUB
warning expected for this allocation size?

Kernel/config: 7.4.0-rc2-kernsight-kasan #1, built from v7.4-rc2 with
CONFIG_KASAN=3Dy, booted with oops=3Dpanic and panic_on_warn=3D1.

How to reproduce
----------------

The crash depends on kernel state built up by preceding operations. The
reproducer is an ordered set of 84 programs; the triggering kprobe-multi
operation is program 78 (0-based).

1. Boot a fresh Debian trixie x86_64 VM (6 GiB RAM, 4 vCPU, KVM) with the
   v7.4-rc2 kernel image described above (bzImage sha256
   e47d1c181af5f2615519de03ffc7bf73dad36b8ffb84b86e50391ed53bb731d6) and th=
e
   QEMU command line in environment.txt.
2. Copy syz-execprog and syz-executor (syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1) and
   reproducer/repro.kernsight.prog into the guest.
3. In the guest, as root, run:

  syz-execprog -procs=3D8 -threaded -repeat=3D1 -executor ./syz-executor
repro.kernsight.prog

The programs are replayed with 8 parallel workers (-repeat=3D1); runs 1-2 u=
sed
chunked single-pass replay of the same 84-program set. The warning appears
about 2-13 minutes after boot. It was reproduced 3/3 times on fresh VMs, at
384.3 s, 774.4 s and 135.9 s after boot for runs 1-3, respectively. The thr=
ee
full consoles are in logs/external-verification/.

Related upstream work:

We checked the earlier BPF fix:

https://github.com/torvalds/linux/commit/d6d1e6c17cab2dcb7b8530c599f00e7de9=
06d380

The fix introduced MAX_KPROBE_MULTI_CNT (1U << 20) and rejects larger
kprobe-multi counts with -E2BIG. We verified that both the limit and
the corresponding check are present in our clean v7.4-rc2 source tree.

However, the reproducer uses cnt =3D 0x100000, which is exactly the
permitted maximum. The warning is reached later through
bpf_kprobe_multi_link_attach() and register_fprobe_ips(), when
fprobe_init() attempts to allocate its internal array using
kzalloc_flex().

The crash log shows an allocation request of 0x2000030 bytes (32 MiB +
48 bytes).
The earlier limit was sized for the `cnt * sizeof(*addrs)` array (8 MiB at =
the
maximum); `struct fprobe_hlist_node` is 32 bytes, so the same permitted cou=
nt
also drives a 32 MiB allocation, above the 4 MiB KMALLOC_MAX_SIZE of this
configuration.

We also noticed the following SLUB patch discussion:

https://lists.openwall.net/linux-kernel/2026/08/31/138

This describes an explicit KMALLOC_MAX_SIZE check that warns and
returns NULL for unsupported allocation sizes.

Our report therefore concerns an oversized allocation request reaching
this check from the BPF/fprobe registration path, despite the existing
kprobe-multi count limit.

We have not established whether an additional count limit, a different
allocation strategy, or warning suppression would be the preferred
fix.

A full write-up, the reproducer and the crash artifacts are available at:

  https://github.com/Zheng-zheng-codes/fprobe-registration-kmalloc-warning

Repository contents:
  - README.md                      full bug report: phenomenon, stack trace=
,
                                   mechanism, verified reproduction runs
  - reproducer/repro.kernsight.prog
                                   pipeline-verified reproducer (84-program
                                   ordered set)
  - reproducer/repro.prog          single-program reproducer generated by t=
he
                                   original fuzzing pipeline; does not
                                   independently reproduce this warning
  - reproducer/repro.priming.prog  state-priming program set (pipeline reci=
pe)
  - kernel.config                  kernel configuration used
  - environment.txt                kernel image info (sha256), QEMU command
                                   line, syzkaller commit, reproducer comma=
nd
  - logs/log-0.txt, logs/report-0.txt
                                   original syzkaller execution log and cra=
sh
                                   report from the fuzzing pipeline
  - logs/machineInfo-*.txt, logs/title-stat.json
                                   guest environment info and title statist=
ics
  - logs/external-verification/    external verification artifacts
                                   (serial consoles of 3 verified runs)

Happy to provide the kernel image, additional crash instances or raw
artifacts if useful.

Best regards,
Zheng Zheng
