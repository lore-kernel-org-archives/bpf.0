Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44273F927E
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863299; cv=none; b=IXDGQx/cRutAW4GrGpBPWVJYZ9iRZq+mkvfZRjFzJ3BEmqqQZSgapPyEHriP+Tw2GgY5R1e+W3yVPhqCtffx4HKbDY3xeLmGKTdttXL6PDeEtrmE6A+aUYs+zvwVvABrUvOJkwK+W55e8s+bCxcvhMOTB727zKn8baHkr0HkuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863299; c=relaxed/simple;
	bh=3hNAaiR4ZlfYXtpbG/PId2FkplkENPT7MqXDDOBnFn4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bKqdY5oQ7XtFXbqrTASQANtvY/BUVyvaQs58XnzWd7E+EwtN4E1tFm2DzK+B5OtmTpbmNYEJCPJYtuWX3a6ZUQdS32KIr+2liufPHu7cyIiZ7UCCgD72TPogKAgNux35GmKa0GiQWjFPs2uhkTrok4DBjxJPOug870RAnwA7MvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlxd+YHj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlxd+YHj"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so321515e9.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863295; x=1779468095; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nH6Oz0qj3BS5COjXbRWw2uOYfMi24rwRQT1SPkqsjVs=;
        b=Vlxd+YHjO36GD+c9qqJRjfGCs7UsoVTrBSwSUw6LCo7CWxHwmwOMG0vom0ECZGPgOB
         RqzkHE3lbAFFe9O/d6CKLiZoTy5AI/5dJMEnNKP7+dwgBD5NXLHts0uL3p5gwDvSsuIB
         DPSbYgJKV/6/Q3xJWe13CGTdvXZ3HQgS832LsmARosymCuzN9/kSbm2lpiEiefV1s3sB
         ARP4yvDu9p7shX3ucGAugZOhkC4RUj4JdZ8iOfOMfTnii4m53IfKr+HYE+8rXu79itsL
         d19FZZaUQAimgQYtMYZRoIyjO4lqOgEpCmHksaONDRrLBZZy6KcXI7IgOSColVvumMu0
         /PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863295; x=1779468095;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH6Oz0qj3BS5COjXbRWw2uOYfMi24rwRQT1SPkqsjVs=;
        b=EuR3Jj1z9/FC1LfbpGbTncRghPqq7Tx011oWsB7ISoQPov973s3MSsqibvvAN/m1PR
         +T3AlKEFhQ/rXE+BHRgXoNrSJe55SKqRd4RxJjsEraRvnzEEoJZg2MtarPIyk2BcuDh1
         aY10B46jIwU9KQv0myPus34YqVQAy33xCX40Cx8It6oO/r1dXUBnF4iooeXuQXMyWJcR
         cK8RcDbnjxRWXeIk9OyW3t1nVR2odR/vUvf5y+KrehBcur1orS3k86TIh67/LS/KnyBy
         pGUA75Dn+U8I6jUjziDCO2GAfcu7/RoeDD9QATcLRWXJShWkEZYgFaKWxm89bCyyxlcd
         3Fjg==
X-Gm-Message-State: AOJu0YzWgFMHdRGguzREgdYRnFNBS8WWI2Tul7mG3rBK9h7hcSQielNz
	FvqVlFYjNvrNR63uIXbJeqcextpa+L9F9zEBO0kA87B5Lzhzg5uRXx8QVVhjBA==
X-Gm-Gg: Acq92OHM7+JYgzFA9L6Y7igP24p7aBPi4nt0oXqCvA3hnYN+vbdWZBLzV86/If4EdC6
	hrmX7Zq6q9vXKpO9bdRFZOSK5uvgJIsXuD0UAl8eiJLkgQtRdAx3xQp7/Y31PdNCZOfWmpoNKB8
	mFyYioeFpj68jV9i46d3VAsgTAgWLnFqwyJ/vucdUkXdzhm7CXBu0/+6dv1p7Suh3HTs4ffRsUJ
	HFIKwWHUubDt2LHIhaU/A8laynbJ4WiuJrhQfYqP67XJHHzDlIgXNbV3JLu3B1ITcjkfXGTdsB5
	qiUOaKbEUIt02JyLR2EUMkrBDuG9KX/BiCf6sqFaVa7HBSrJB1FwGW0zxhkEiIBbpf4KYCPoD3m
	PEHyaM2wHhpCnakZ+I5t2QB6gIAq0w8qRsOQQPHn4rU9Sp75fcM3QCQBlEKYEeIltYJmKpjghQu
	HGvQTz3ZdGjbFb
X-Received: by 2002:a05:6000:228a:b0:43c:4810:dc4a with SMTP id ffacd0b85a97d-45e5c5a83f1mr6359512f8f.38.1778863294756;
        Fri, 15 May 2026 09:41:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm15745826f8f.34.2026.05.15.09.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:41:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/3] tracing: Expose tracepoint BTF ids via
 tracefs
Date: Fri, 15 May 2026 09:41:00 -0700
Message-Id: <20260515-generic_tracepoint-v1-0-aa619fa94132@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ1MB2oC/x3MQQqDMBAF0KsMf20gSq0hVymlxDjqbMYwCUUQ7
 17oO8C7UNmEKyJdMP5KlUMRqe8IeU+6sZMFkTD44elHH9zGyib50yxlLodoc8sjhDSmKc19QEc
 oxquc//SFuaxO+Wx43/cPxrtSIm4AAAA=
X-Change-ID: 20260508-generic_tracepoint-d488a5a7ab18
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org, 
 rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778863293; l=3677;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=3hNAaiR4ZlfYXtpbG/PId2FkplkENPT7MqXDDOBnFn4=;
 b=BBzsVsC/zpQAmiqIbkn4dThyRxbKUTu50Vc6CuwvXJTr8mQ9c+6jIpoo16kerIWDws86OwJHT
 0g+D9lItgN5Cq5EnygGLNawL2KbFQ4Qcbj76ofALA0u9baW+FawQRtc
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

BPF and other consumers that want to attach to or decode a generic
tracepoint need three pieces of BTF information for it:

  - the BTF of the object that owns the tracepoint's types
  - the FUNC_PROTO describing the tracepoint arguments (with names),
    consumed by raw_tp / tp_btf BPF programs
  - the STRUCT id of trace_event_raw_<call>, the ring-buffer record
    consumed by classic BPF_PROG_TYPE_TRACEPOINT programs

Today none of this is easily discoverable from userspace. The kernel
knows the ids - resolve_btfids fills them in at link time - but
consumers have to search them by the naming convention
("__bpf_trace_<name>", "trace_event_raw_<name>"), walking BTF for
every tracepoint.

This series stores those ids in trace_event_class and exposes them
via events/<sys>/<event>/btf_ids, e.g.

  # cat /sys/kernel/tracing/events/sched/sched_switch/btf_ids
    btf_obj_id: 1
    raw_btf_id: 28882
    tp_btf_id: 106335

  # bpftool btf dump id 1 root_id 28882 format raw
  [28882] FUNC_PROTO '(anon)' ret_type_id=0 vlen=5
        '__data' type_id=9
        'preempt' type_id=60674
        'prev' type_id=219
        'next' type_id=219
        'prev_state' type_id=108689

  # bpftool btf dump id 1 root_id 106335 format raw
  [106335] STRUCT 'trace_event_raw_sched_switch' size=64 vlen=9
        'ent' type_id=104654 bits_offset=0
        'prev_comm' type_id=580 bits_offset=64
        'prev_pid' type_id=92875 bits_offset=192
        'prev_prio' type_id=79365 bits_offset=224
        'prev_state' type_id=83958 bits_offset=256
        'next_comm' type_id=580 bits_offset=320
        'next_pid' type_id=92875 bits_offset=448
        'next_prio' type_id=79365 bits_offset=480
        '__data' type_id=407 bits_offset=512

For per-syscall events (all sharing the same dispatcher), raw_btf_id
is 0 — raw_tp / tp_btf programs attach to raw_syscalls/sys_{enter,exit},
not per-syscall events:

  # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/btf_ids
    btf_obj_id: 1
    raw_btf_id: 0
    tp_btf_id: 106540

This unlocks few usecases for consumers:

  - Resolving tp_btf attach targets and argument types directly,
    instead of constructing "__bpf_trace_*" names and
    re-discovering them in vmlinux BTF.
  - Get a stable, machine-readable contract for tracepoint payloads,
    with field names preserved.

Patch 1 exports the two BTF helpers the tracing core needs.
Patch 2 wires DECLARE_EVENT_CLASS to publish the ids, adds the tracefs
        reader, and wires the syscall classes so per-syscall events
        carry tp_btf_id (raw_btf_id is 0 there — see above).
Patch 3 adds a selftest covering the sched_switch tracepoint.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (3):
      bpf: Export btf_get_module_btf() and btf_relocate_id()
      tracing: Expose tracepoint BTF ids via tracefs
      selftests/bpf: Add test for tracepoint btf_ids tracefs file

 include/linux/btf.h                                |   2 +
 include/linux/trace_events.h                       |   9 ++
 include/trace/trace_events.h                       |  24 ++++
 kernel/bpf/btf.c                                   |   6 +-
 kernel/trace/trace_events.c                        |  81 +++++++++++++-
 kernel/trace/trace_syscalls.c                      |  17 +++
 .../testing/selftests/bpf/prog_tests/tp_btf_ids.c  | 124 +++++++++++++++++++++
 7 files changed, 260 insertions(+), 3 deletions(-)
---
base-commit: 3fe213c040b3a175f6051ed3aaf823a430ac0b08
change-id: 20260508-generic_tracepoint-d488a5a7ab18

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

