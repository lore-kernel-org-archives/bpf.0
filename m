Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68903136672
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770909640; cv=none; b=UXRem2KfHRRgHLxi7wZP0bBTGIMOOOGkNSYm3VROG9NDM0nf+wE8r8vRxd98ivTd1uSiXaulxfKbM3GflaM9L8macuv0umOc9fqhTq8V+D7ZZQX1c/LOOxlElfB3FSdjo1AWoDr3+h4wsokZ207t0viA70c4PJmJ3pNd9sjG5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770909640; c=relaxed/simple;
	bh=Gqxx94/TBZoBI7LhDZx99gNDM2173gryzavutBlKrrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5h/wi0yPIUBW4U0TVHjWWm6AeLPZQQ7N73C50hPsTN6x/22eUEKZyJDH+KHrFbUCsTpHvivLkBCjgj6UAmuV3eGJfW7fcZMwib/z5CbpjxjGnVFfKfyfaaXB+vf+5ejfTTzKf5tojMLy8zMXC5nDjDe9+qX0W0hc/nQTWhFBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0kQujF4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0kQujF4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a9057b2ec3so15728255ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770909638; x=1771514438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5OC9IS7FbuAeXEzPS/HflFuL5Amk/C9+TIXAnhWmuiU=;
        b=W0kQujF45qUs7PfgMC9ty3powhHueTtmtReIPnbHsoDZxQqvn5Wlukgu3XeWpbWFv7
         7NsgpVONk0Yp2UpoeAKs6ywhakx1zkmif2lvQUvdZzKT8bHkXTl7q1Mw/nAUTf7h076B
         1TzExGDmfpBzLB+5oZSjGBM6dTQBrQj5C7BAwvFAzB3zkrH4YR+xrBsFPQxRLGXVAu50
         Q1Zsn/rIYUkNRqHp7spQvOQPPJsmm2Va7vTTIcRFJGDAd+8LHZQEDyJuVIk9hbarSvgx
         s2+A9/sN/u1+F70foNVhPVOzl43SQTRQttKq7ggArFl/xm/C6+nkw6m6XQm7j1Eq3Uw0
         tntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770909638; x=1771514438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OC9IS7FbuAeXEzPS/HflFuL5Amk/C9+TIXAnhWmuiU=;
        b=STivvP+FD/Tq5w3k2CKX7nxRXkMNbXMzLYTrU9PVDtiiKqaQr84MiyxkGPre81TZhH
         t7Pj0FjFawgfrZXqlaiNUoyKDkBCm8I8FtJfBirlfVSOy/Kl3gzQaIY7WqV9Hog2f1ug
         8XNFktFO85xx1N+JPCV81jcQHX1ZyhV8UcezCWDqLzj8mJdBLfLMQ8BtvIWTsn0KHYNX
         nITcwKsdBEB3YXeVQmPAo//iDaoDdfepVVxDufF7kiyhvvkcrJeXtV7nOXv0bDw4gpv/
         M6mHjyarKJRrUwfZvsLER44574VGnEIGJ5hllplTdYoNJBtpJa6/4wnzPHRdCPXvowQY
         z9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxv7mXf1nmotEbMzVT5LDrDDTs1bU2OMnxjPn66+3CQIlLMbWVmZ6yJUN+R4LBzoTSNuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZq6jO0AnGVMiaVEv37fpOGFCLAE7/RM9pgU8k+lKnhkZDGmcq
	7nHBH5jZx9PltmTSDs53PDVhv8cXZRaIeLXFhphQy/h9duPi5BxhcHpG
X-Gm-Gg: AZuq6aLKC2c/l3uRLYW/eQZdODwtnX8IJCT9HK0Pf45xBLGM07ID0ZfiFef9XMmPda4
	Nr7rbakalR+UjV21luctxF6ESBG2qK8ttPw7WDPVjJ8etGNRmgLaTEIWhXsckpG5QAjJEErEgD3
	ec5udneHVkLJbZOL4n3DDH0CH98B+xi8Fd70NuP+ORv2xf17JGzc6YOgW4RjnoIDDxPg8WaGg5H
	Dq7EWd3ClHtsp2OwyrguIIjpzGO/K74xtj9jur8ncCfSMSmc6jzN2VEacdfpWBQ0yvUhAq2yZuM
	k8Wn2IwgqgvPy1ceyEeAny9ijfNE7Jei5SI/JjhoyLrwS7lCRdXdqPRC6lk1hKyt1eqkhBCKjvB
	SLYL/jgT8EPaibprmO88iQtFesFCMeYM7cg8aQdwktfp7BLOtzlx2auExYBWA4vmV8KI65IcBeI
	+V+wL655k6Hpyk+87Qd3ArIxop3S/gaR76MU7KmJWjxsX67jo4TwDYCqFpp/0exVIth/s=
X-Received: by 2002:a17:903:1986:b0:2aa:d29f:1441 with SMTP id d9443c01a7336-2ab3b183d24mr24557415ad.2.1770909637499;
        Thu, 12 Feb 2026 07:20:37 -0800 (PST)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b4:a82::10c:60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm55943795ad.6.2026.02.12.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:20:37 -0800 (PST)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [RFC PATCH bpf-next 0/1] Upgrading uprobe and kprobe to their `multi` counterparts.
Date: Thu, 12 Feb 2026 20:50:12 +0530
Message-ID: <20260212152013.17351-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patch explores auto-upgrading standard uprobes to use the 
multi-uprobe infrastructure when supported by the underlying kernel.

Background:
The BPF token concept allows privileged operations inside non-privileged 
user namespaces. However, attaching standard uprobes and kprobes 
currently relies on the perf_event_open() syscall, which is not BPF 
token-aware. Multi-uprobes and multi-kprobes bypass 
perf_event_open() entirely, attaching via the bpf() syscall instead, 
making them compatible with BPF tokens. 

To bridge this gap, the goal is to switch SEC("uprobe") and 
SEC("kprobe") to use multi-uprobe/kprobe under the hood. To maintain 
backward compatibility for cases where singular uprobes are explicitly 
desired, this patch also introduces SEC("uprobe.single") and 
SEC("kprobe.single").

Current Implementation:
The decision to upgrade is made at BPF program load time in 
`bpf_object_init_progs()`. If the kernel supports FEAT_UPROBE_MULTI_LINK,
we intercept programs with section names matching "u[ret]probe" and change 
their `expected_attach_type` to BPF_TRACE_UPROBE_MULTI.

During attachment, `attach_uprobe` checks this expected type and 
routes the attachment to `bpf_program__attach_uprobe_multi` accordingly.

I am currently hitting an issue with selftests, and I would appreciate 
some guidance before proceeding to implement this for kprobes and fix it
for uprobes.

Selftests that rely on auto-attachment pass. However, tests that bypass 
auto-attach and manually call `bpf_program__attach_uprobe_opts()` are 
failing. Because the program's `expected_attach_type` is modified to 
multi-uprobe at load time inside `bpf_object_init_progs()`, directly 
calling the legacy attach options subsequently dies due to the type 
mismatch. 

How should we handle legacy manual attachments for auto-upgraded programs? 
Should `bpf_program__attach_uprobe_opts()` be taught to internally 
redirect to the multi-uprobe path if the expected type was upgraded?

Thanks,
Varun

Varun R Mallya (1):
  libbpf: Auto-upgrade uprobes to multi-uprobes when supported

 tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.52.0

