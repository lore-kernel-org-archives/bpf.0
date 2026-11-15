Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794746341;
	b=psHPI1ajjE1yqBm3oRAlk2CxudJKaqzqD7YCr7RywW1J56e068bLaqvOi3nn9qpx0EJN
	 yoEsXEm6c71lVCr/NvfWMEv/eZUada1ri7qEsV7i4NP2xE8WmOD2Sg1P+p0mlDwpR/AYY
	 jQAdJGVddHuT/on1DruNf0ppo2JBCIqQhEwnDnR1f1R9kygNEpeFIIwYWhfvpnx+io1Fm
	 /khbIGPz6UIMTNxdZJqrxgKe0Tw/NeG1ILX8wmFJnTXO2Zl+jd9pu6IE5pRpQ2YG1mksV
	 Jl+COL/DXIGi0sBUgYGd9PstoCI/IySN/RnIqbeQdzIt4g+tKxUMqx7V8Ut5xWYirSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
	b=gJrRrga+fASo1evQKMXYND7i4kkY07RPZVYaeMo/HAMsWeIoUNWpSPT8NfbAULs5KF+x
	 NM91MAnsRVpZbLeNNkNQ0zCBXAEgQoDwh/GP75xWYNnN12PmF7LMBMIveIAPqw5+G47Xa
	 bRCBbYAwqrTF9Xv+jYGbZfiOYRPxN7jLdFPtq+xqGPczI06LOAkXorvKROpLBKKfO7hcH
	 xG1J2SfH+q3ndmi0XbXeZdKKUCiZ2putwVGIU58p6tsAncpQGtepPGL+O8GV0tHVSZnFI
	 xA3Mmjqv+fsKajocqcnASdIfcwlw5sk6hRVk5aKpOLUk0Ne2pxCSs/PIORGyTi9Rvdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJ36kAFi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7D606A8B5
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 12:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E7D606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJ36kAFi
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so11485605e9.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 04:39:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794746340; cv=none;
        d=google.com; s=arc-20260327;
        b=guvu7vrIpXyxgyy+hehP9dDvk/f4393holHuH6FGGH1XDmRYbfIp53+hBKN4ewctig
         xAIP9ynBJUtnImbXFuJyAO9OHHVd/5gCetaOdAUUVBgUtCawsi5kNb/O0YV4zcaI/bU9
         YbxmjgX55KS7aP1r+dtMBFsNeyjJvXa3FRN8OICtX+1pltoLk6qs8KNy7FB60te31hlR
         gTm37L9mXVw3WKr9qSdw222u549Zd5mmzjIRGF9PEl2baJrWh3Ew2rw1l2NV9hFVoxZQ
         +v1Y7ShkpuaE974TecyqYIOJyRPzGuaebuFKbMOpoWzqJfCNpbzsD92tbhqKh4+g2b0O
         jWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        fh=OL9S+spmCa/EIFLCEtudmmlZSAWyRZa2XJzWsA/SNgc=;
        b=sC4lKH1nkc9XeMI41iLpB2sbNWgNMb+VH+2z7baVGdCzQsTyasvWEOZyw85x4xxak8
         4tLET/4giaSRQoRBy8BmfSAa5QknwrQHb4e4fJZHOzRS5EERbwbjGC+dTIpz93AABtKI
         tEtLkniILzqU1WKSzOlPeoEkExKmGG73eFLKCPnC/B7j2dnAUGCFXubaW+n7MMZp+O9k
         THKiKNcjF0MEmCoVz2OvOLS1Do5MW9phoR8TSYLQM+yptfaChHKxGgS3XsXKimA56dIq
         npfefy9QnqTb/e4Wv6lgZOAQbeQHJ+hTqlVG3LS7pzCTsYus0ZneaaXgqBPeTAlL0oTB
         6NIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794746340; x=1795351140; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        b=BJ36kAFisWI5ih5bwMiDop313OMjE5OLHzq+6Pu6yPkDGZEpvnuq1bNXktEwYQwKZt
         wChbY+F3uoBgh/O54EERerUoHZzaD3fiQm/1nG2IpsXhlpRTfpBRBfA0IPeof3aN/Rqp
         Hz2cmwiEwID8GaFDdUg6WX3tfiXDZEeVik5zp0Wmy7JQJ1i2aDTmoc781g8/4TBQWCbr
         N4syUuCmK3EqQNW3TRRsVzMbfRiT9hskZld6ZCS7zj4Jbgj0LwLsrTNHWkeMC38JQ5oq
         SHON0IbzHFYmJ7fk7JtqgUcQCRpsWtG6OK+IJiQp9XFMK9f2Bye0sDtKhb2mnhnqs+mj
         66EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794746340; x=1795351140;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=44tLgdq9NOaC8pOpPru94NuUZdRK65F+mroo+sF8M4A=;
        b=M4dZ+ULPE/7P6zzjghRAiz4cyXQhOgz5XsaJFIbXn2sTTPUXEBxlDeKoXRUPBbDTid
         VDMFsCaQFRLNop4zLsCWEurgRX9SEdhjxKR/0KXOeWLWVWkC22jefZD9oFwvcXYXtP+T
         4PfXX/flBNBj5J20X+V3gFEVAz1KZmPN0z1vqNgMdQTAjZfZiQJIkbsNVnPDaIhqy+Lk
         CCBVGO+vTfQZAAQUX0ayfqeOb5btKWcmNoAtKgdUTe17l2O8xrrsNRsE5U64a1jXsh2m
         3kih2ZpXVa31osO9Muqek3IwnnVe/C9uXMj3LKwxJafSf/8JScDlJhRxPqBvKAfJ0DUi
         R/CQ==
X-Gm-Message-State: APuU4Z8uZCUzpDLwDzBgJZVgkZgM7BIBrUQSaSf/CrKCYfIKge7cmVvV
	zuG5qzr59pG2q4VkTUgNJxszo1iaEjPTNmEsSn9ss+z8o8diCJ2sgXDWlssazzJtI1EJGVgq0An
	3Su2CbriEU9qmL4JhaUtNHPwYdpr8TbdPfVBUwNQ=
X-Gm-Gg: AYBFou1Mx0SQPB31mSAbpCrHvb0mqlH+nYCc04/90FXbrv4glZiz7YP/+IxutmxHazo
	VbOvLN3uvdIEhNVD/5RJ2UCSX9Y0BiG9NzcV9ZOFqLg3x8TMUkRAzrg/Snv6Wt6trL3EEWJZZVk
	qRes+w2BHJEuqOKOd08yfFI4hhmbcOJg3JHwxkSa+QWUT7hgeTAqII3lYf0nY+zrfjnHSQUL91S
	v8s34FKbM8gCvBZWIMRnH5xVaeIDhbPsPD9tkv/YfGyOj5A4TBibnVuiNv5iE251n2oXk/MYkgU
	9zb3gsP3Erw8BqP3XAaeuRLEAeSiLZ1/k+9RljTjL8rnjp3IQxQS/Bb36zqjc76mLjoP9CGKUCI
	d7BU6P4kU+UZEA9I5XB4Eh1JBexoiOpC9Y7+mnY16gKkQ5OZ7+M8B3Lkdg29ABC9A+Do=
X-Received: by 2002:a05:600c:608c:b0:4bb:680f:9a3 with SMTP id
 5b1f17b1804b1-4bb680f0a64mr68135785e9.2.1794746339530; Sun, 15 Nov 2026
 04:38:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sec Ops <infoosec.ops@gmail.com>
Date: Sun, 15 Nov 2026 18:08:46 +0530
X-Gm-Features: AclHuK8sSF4ErKQa1M440LXIVvLA47LPhhDqUdjyYivbtwpIdI3z5E0qGskC3lk
Message-ID: <CAOW9kW-N6ZU8RPd64rBukjfYkGwfj5QgLF-sRGfkd-nGtFYbfw@mail.gmail.com>
Subject: [RFC] Security observability of sched_ext: sub-watchdog EDR telemetry
 starvation & BPF LSM / tracepoint mitigations
To: sched-ext@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am sharing an empirical systems security study and open-source
artifact repository examining how Linux 6.12+ sched_ext
(BPF_MAP_TYPE_STRUCT_OPS) interacts with user-space security telemetry
consumers (specifically CNCF Falco and Cilium Tetragon) in
post-compromise scenarios:

Repository, Dataset & Paper: https://github.com/rootagi/scx_research

Summary of Empirical Findings & Artifacts:

1. Sub-Watchdog EDR Ring-Buffer Starvation (`scx_starve` &
`scx_forensic_delay`):
   While loading a `sched_ext` policy requires `CAP_SYS_ADMIN`, an
adversarial scheduler can selectively route user-space security
daemons (`falco`, `tetragon`) or forensic CLI utilities (`strace`,
`gdb`, `perf`, `bpftool`, `ausearch`, `lsof`) to a low-priority custom
DSQ (`DSQ_STARVE`) with microsecond-scale time slices (e.g., 50us) and
probabilistic dispatch skipping. Because the target tasks still
receive minimal CPU quanta, the 5000ms `sched_ext` runnable task
watchdog is never triggered, but the user-space ring-buffer consumers
fall behind kernel event production. Across 150 trials per sensor (30
trials across 5 intensity levels), this induces silent alert drop
rates reaching up to 100% in Falco and 97.3% in Tetragon without
detaching any kernel probes or terminating the EDR process.

2. Scheduler-Assisted Covert Channel (`experiments/covert_channel/`):
   We also evaluate a cross-privilege timing covert channel modulated
via `sched_ext` slice contention (`scx_covert_tx` / `scx_covert_rx`),
achieving up to 100 bps with 0.0% BER under quiet conditions and >20
bps under background load.

3. Immediately Deployable Defense via BPF LSM (`defenses/scx_guard_lsm.bpf.c`):
   Because standard runtime security policies rarely gate
`BPF_MAP_TYPE_STRUCT_OPS` map creations, the repository includes
`scx_monitor`, a lightweight BPF LSM daemon hooking
`lsm/bpf_map_create`. In active enforcement mode (`-e`), it validates
`BPF_MAP_TYPE_STRUCT_OPS` registrations against a trusted scheduler
allowlist and synchronously blocks unauthorized scheduler loads with
`-EPERM`.

4. Draft RFC Kernel Patches (`patches/`):
   For upstream discussion, the `patches/` directory contains two
clean RFC patches against `kernel/sched/ext.c` and
`include/trace/events/sched_ext.h`:
   - `0001-sched_ext-Enforce-minimum-dispatch-slice-floor-for-p.patch`:
Illustrates clamping execution slices in `scx_bpf_dispatch()` and
`scx_bpf_dispatch_vtime()` to at least `SCX_SLICE_DFL` (20ms) for
monitoring tasks holding `CAP_SYS_PTRACE`.
   - `0002-sched_ext-Add-scx_scheduler_load-and-scx_dsq_dispatc.patch`:
Proposes `sched_ext:scx_scheduler_load` and
`sched_ext:scx_dsq_dispatch` tracepoints so existing auditing
subsystems can observe scheduler registration (`link->id`,
`scx_ops.name`, `pid`, `uid`) and anomalous micro-slice dispatch
patterns with zero fast-path overhead when disabled.

For user-space EDR maintainers, we also document a practical userspace
hardening mitigation: elevating ring-buffer consumer threads to
`SCHED_FIFO` or `SCHED_RR`, as the real-time scheduling class executes
above `SCHED_EXT` in the kernel scheduler hierarchy.

Note on Methodology: Artificial Intelligence scaffolded the benchmark
harness and drafted the manuscript; however, all eBPF programs, LSM
defenses, RFC patches, and 300-trial Falco/Tetragon telemetry datasets
were compiled and empirically executed on a live Linux 6.12+ testbed.

Feedback and thoughts from the maintainers on the tracepoint RFC and
BPF LSM approach are very welcome.

Best regards,
rootagi
