Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C1532B111
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786792848; cv=none; b=hbYuhAxBuY1RuEHS+twYKZWeX+XVIpcQ8KuCYKX54G3tgnLB4qwMDrUtHUsPjeR/Lfm4DTYUz619j3/vYnID//PZxCH/78V1MGj6NpyiwwydZ8sDhEuOsYwPEvT3wKbXoBIczXyIu0A9aupxwznxW26jYIlGaQcMGI2ENuAM9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786792848; c=relaxed/simple;
	bh=djLZMpUah7Mihpof97k8hEqjZOn9/S4jD4Bgilil3vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oU7TEFKS8MrG/yUKjFiana5CBbJHA91mJLkDC409qNDFyDg+j+GsAA9qBxDnCK9DHhGZ+sYygkmDeaPdrM5nMVIsgs00GdbFNlIS0g1Dy/jwoNWOeZkCmQwuvDFJkjb3oe++07V0AdwnZ4LiQ5Y9/HHzQ2FTVYWY/pzGfxbEpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4mRdM4r; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4mRdM4r"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dbcb505578so18035287b3.3
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786792846; x=1787397646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+Pc3CG99YBm+EzYDINBR/q4A3NL6A7bn3Kkm4VNB1A=;
        b=k4mRdM4rQpUjwcAznPFhQOJfliG/ThLAXJ+nzL/wQ+gk7RXn1IZkyM3gwEBqliuGkt
         EVMFQTsJE2gQZE3z8eb4vlIQpmDT2lg70Qln5FkEBmVcRRzBERCNE6I4WagDM2/DMREY
         K3LLVNrTKJsHEx+aJ/318hCyJEA6qQo4JXWuajpk3XtNWguMXsnepnuP7yeezlI+51m3
         29Rv7V5r7SgnSRxDX3TLbNk1aUTOrwt1mGWx0nxYaJscKzpBpw0jgW/rUVRMpj4zGj4G
         eia9cCP/+6S3FntDVWKdSU56aldb6WMmLye7n3nkOtuRZhedce+nTr98KAp2Ry45oCjB
         jurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786792846; x=1787397646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+Pc3CG99YBm+EzYDINBR/q4A3NL6A7bn3Kkm4VNB1A=;
        b=VD9RguUM+IB4CSS7GGWzAs/W1mCaSRVH3IyQbA4cJQr2hQuchzS4q66xeHpoABNrx5
         uRrgzsqlfEvKsceMSCSuz4o28N5eIYV/GL4UN6bbjE2d6fZNtox18NCNGfMB+pkimqBj
         vG2z9B5lnxFX8WO4Sdid4TbNyQnrdmB/6kouYqwztSiBh+eMSqpQCmm8Ok3boCBqyD5w
         62S9DQUEv9T2785uM91pJ+1hFQGPzXJb6kXQiszVsFo6cYPuDiAnYbqVQ4Y1gtPQFr+9
         dqKuhWvzq/JPuk2w6Oa1mzVI3i32Rq3Mge/pu+2OcqRNT/ep/eOth5U8TQk8sIIdF0VD
         oFfw==
X-Forwarded-Encrypted: i=1; AHgh+RqjtLOYupYl2rR5BgnJpQn9IPMBVJSbFUZki1qvnuVj8GujsrlUJBsJAMSCk6d+nkdB+AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuL6IHXOebb56A6x1fFGPtz0miPHOk8gsfoyPBNZedOObvaMEP
	tX5S2o3l7nGsmewtS09yE0RGMAHNhNkrZNyQEj5kr1bjk5R3+NifzaHg
X-Gm-Gg: AR+sD12WPSpYSjauBJa80og1xoSG6MeYuDOflqJjVcA3sh6vbeDIEbgZKr75fC/4rN7
	zzuEROWiRSqfaP/Y4n1n7to9CnVkbeIkTlqt0eOTsTbWOzZmygDY4HX/Q8yn2qQOL4Udk14RJLW
	NwfD+ZnswphUe5WFFKbWrQxOrX60onJ0iaSPCb7UfVvA5CXnUcUeOjDD/c34Sc12y8Tf10wcJ0x
	gWB4q89AVJaMM7Dlw61vDq7/Pihjr8OK5OABsCrA9eh6VRDmNXrabnrdn6PBlbi6vXbsgnRxjGd
	QUJuIOmINEy07prGKHh3vzYk4+0nLTOuGG7bwSaoXnCjVEMTezbQWe5jX9DhVHvm6IUUYo0GnDT
	JqO61ZphIYjBProd8hHwzZMbvJNkesHJt1+kUcDLZHZqDtu40Rv0QB9JiRJ/7n6VeyhP81+WZvn
	xk4gFkKFcJt1iu/D+iw9mq8ytKS2pVmVWoJmUezsT7l1R0G9t00I+XSsqW268cRYyLlVtBews4O
	WLsoa5mqZihu7RaAo79t7Y=
X-Received: by 2002:a05:690c:a4c8:b0:81d:a1e5:a4d7 with SMTP id 00721157ae682-8370c93d31amr36153457b3.5.1786792846338;
        Sat, 15 Aug 2026 04:20:46 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:31f0:efe0:f2d8:ae44])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c36a84d9sm24388037b3.46.2026.08.15.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:20:46 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query locked_down state
Date: Sat, 15 Aug 2026 07:20:39 -0400
Message-ID: <20260815112041.1248855-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Howdy,

BPF programs can attach to the locked_down LSM hook and contribute a
verdict, but they have never been able to ask the locked_down question
themselves: there is no way for a program to invoke the hook and learn
whether a given operation is locked down. (i.e be a caller of
security_locked_down rather than a consumer).

Today the state has to be fed in out of band, for example userspace
reading /sys/kernel/security/lockdown and writing the result into a
map. That is a time-of-check/time-of-use race: a security_locked_down
verdict can be raised at runtime, so the cached answer can be stale
by the time the program acts on it.

Add a bpf_security_locked_down() kfunc that calls
security_locked_down() and returns its verdict, letting LSM and
syscall programs query locked_down state at decision time. Out-of-range
reasons are rejected with -EINVAL before dispatching the hook, and the
kfunc is refused to programs attached to the locked_down hook itself,
which would recurse into the dispatch. (how the obvious recursion issue
is addressed).

As this is the first pure-lsm-hook kfunc, add a new file security/lsm_kfuncs.c
to host it.

This kfunc has no reliance on / relation to the Lockdown LSM, despite the
similar naming. It is an LSM-agnostic caller of security_locked_down, and
Lockdown just happens to be the only in-tree subscriber to this hook at the
moment.

In fact, the test environment does not rely on CONFIG_SECURITY_LOCKDOWN at
all, and uses a BPF implementation of security_locked_down.

This kfunc can cause notices to be printed with kmsg if the Lockdown LSM is
enabled due to this line in security/lockdown/lockdown.c:

  pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
				                 current->comm, lockdown_reasons[what]);

Patch 1 adds the kfunc, patch 2 the selftests. This is based on bpf-next/master, but
applies cleanly to the lsm tree.

Justin

Justin Suess (2):
  lsm: add bpf_security_locked_down() kfunc
  selftests/bpf: Test bpf_security_locked_down kfunc

 security/Makefile                             |  1 +
 security/lsm_kfuncs.c                         | 84 +++++++++++++++++++
 .../selftests/bpf/prog_tests/lsm_kfuncs.c     | 28 +++++++
 .../testing/selftests/bpf/progs/lsm_kfuncs.c  | 34 ++++++++
 .../selftests/bpf/progs/lsm_kfuncs_fail.c     | 26 ++++++
 5 files changed, 173 insertions(+)
 create mode 100644 security/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_kfuncs_fail.c


base-commit: d82ebfc685c91e7f5623a8be949da1ddb767420b
-- 
2.54.0

