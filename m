Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DD2BB1D
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058582; cv=none; b=eSEpKaDqd2Yz1Q2wV2JC4h297Ba7zkUWg9kKm6ANlMRGei4VD+wddzzkFk5B1aTLWdMzK+qcCmtsv6PUPgam2jWNQI5ffHmEEaXLG0dtfqiF8YS1P/4urtrhw6GGVX1Uynz/z1k8BD31TCDOgHOLDMw2g5n+gPGzWK1xU+ew0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058582; c=relaxed/simple;
	bh=wSRHiF/iAAzsx2jvHZV6XSVECUmI1C044OnQ9FxcZ84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tC+THZM4Ki2EBxeOn5cE/Fp8vM0XT5Ydq3BcV8/qU79vV2eigH0NgM65z8jjcoM33tc27Naxs6bUBmrcR+8o5HQ/dNSYYRWEy9eNYZbsgTamimeRce0ynNmsbVGS3eAm3f4ib56Au86uQaCet+9S0V2qS+Pzd+ofozTmAeJsVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG+mx8gv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG+mx8gv"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso66997167b3.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058580; x=1777663380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/XK36S0OnYkMbF3RtEZADi61//Hk8+AwKwLMpkvu94=;
        b=kG+mx8gvE0q1eHrW/ikh6hP5U4SqJ0AAO9wjWs6WtuN/SZ+JeBK6GGBG9BUr9QK7Gk
         4idrdoEni6JqVoPrAQV9as4/00m7w5pZ0n0BuDxPQfcKFXMu4BXPrh7HM9WaJcLJf8aZ
         yvCQvWnkGGLiMsNo6qSzJHxg+lzwdVz20WfKwgxblY9uRTaq29GfPynXxC0uWv8Y+RyJ
         kLSZRudCgf9GPdmJp8iSKQBBcGR7sJkIaJcEawOcTjU77C/chZyIxMwQxKeNfgen0bgM
         Y2a5vMXCVhrEAKXVAM3ZCleJi2jOZ0kmSWkyaLIBxtKZcmkHJYgSDBRMjx0MGDdxEPvg
         JnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058580; x=1777663380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/XK36S0OnYkMbF3RtEZADi61//Hk8+AwKwLMpkvu94=;
        b=LOvyfuEGSTLZ/gd7OWShjL9cRFF1KOy/SDu1pJaBXsxXg9siPP3JvlOTgNkFhbChoR
         BsfeqFtZo2KnxVf/p+o5AWE2onFw5/KBcXkLwDVfLCnY18L9c9Jqsx0TmwsanUiZFiUU
         WfGhrHSY4GYJTCBowWCfb8KrWFRBdBnXEDeK82xyxYKYBAG/AiJO1z7AaJMxAAHDZQIH
         bL+dN0zkGIMKTkgDEMVlC2kUKT1xFm+uMfbdqtu9ECX0NlQ/vnl0tZf1C/iaggH7Z5Gf
         Vz3beGkWs4NV8lwIZxLLuRJgKibAsLCZJBLNQwR+rZo2r8nmVdm8Iq5DJ8elZ/hly5d6
         N/Mg==
X-Forwarded-Encrypted: i=1; AFNElJ9UUjXgtoipQUJgbAUQ10Hfoym0yej/bKJCV6y2U9eT3kUvx+WHhU5vcxD6jK46cfXjO/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskEmeGUICNoAGWudFU5NdjZvSZowI5SRqCVA50iPPO6fqACNf
	7R63629t8OvcpV+9aVEIcNaPqLpeetoZ8+ETFNQG7ioi7m+5BYdshAte
X-Gm-Gg: AeBDievFdE6G/aTvP+pRGpmU142HouXcq0L+D8iBc4k4XPIymJtcrMkiYbOEYHFQRQR
	PbDq9GqhS2H/k8qcM+B1qxL1r7iRWO7ifcO2ZBpiDuCoboVDHZ1x2dHxozVC03rVRxGD5DmXuft
	iFHEMgEzvke2GRRqEFP2DKZKi/zQE1lYxkousQ83FpkXEZ4w2k8LTgVoFiDrLoIJTbhmCwaeKS7
	kBWpQew+RFejejyT73uEf594eB8gl0P1v4MhNSWTdxyH4KZLpuBQoKI5GT3eXrIsJu5dedJVQcJ
	IVmEOtdOhlgpypHYYKjs9xB+iZ9RQVt0DFdqRkub7mtTyG5YKxS083q2D++bE+Cwc6XuzgThHld
	0HUzbM4EKE7ooWWkh0FoOJLLTcTNSR4xKvHi/Ia3NKtpjFthSkX1txy96Tsdtye9CJSE7FmcVao
	Buu+tqFyKOUGtxh3BFRBYw+t9zgjHhJ+3NQn/0sehfDvvl3vz3rQFEzDykuse1iXFZsYz5Wp33Q
	p7HnH6AJ9BdtdUei2VM
X-Received: by 2002:a05:690c:3344:b0:79a:bbe0:8cae with SMTP id 00721157ae682-7b9ece5abfemr363621367b3.1.1777058579861;
        Fri, 24 Apr 2026 12:22:59 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b5254sm94726757b3.41.2026.04.24.12.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:22:59 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 0/2] Allow storing referenced struct file kptrs in BPF maps
Date: Fri, 24 Apr 2026 15:22:50 -0400
Message-ID: <20260424192252.695240-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds a destructor for struct file, enabling it to be used as a
referenced kptr in BPF maps.

This iteration of the series just addresses a small test failure.

v1: https://lore.kernel.org/bpf/20260420203306.3107246-1-utilityemal77@gmail.com/
v2: https://lore.kernel.org/bpf/20260423152239.4140627-1-utilityemal77@gmail.com/

The destructor mirrors bpf_put_file() semantics and releases the reference
via fput(). This allows pointers returned from kfuncs such as
bpf_get_task_exe_file() to be safely stored and later reused with helpers
and kfuncs that operate on struct file.

This fills a gap compared to bpf_dynptr_from_file(), where the resulting
dynptr can be stored in a map, but cannot be passed to kfuncs expecting
a struct file *.

Use cases include caching file references across events and deferring
processing while keeping the underlying file alive.

Patch 1 adds the struct file kptr destructor and wires it into the BTF
kfunc sets.

Patch 2 adds selftests covering successful use and verifier rejection of
unreferenced pointers and success cases.

Changes for v3:

- Fix variable name in failure test case to pass.
- Better handle fd closure for file copy helper.
- Remove dead test function.

Changes for v2:

- Fix comment formatting based on sashiko feedback.
- Fix typo in commit based on sashiko feedback.
- Remove close_fd helper based on Song Liu's feedback.
- Expand selftests to include success and failure verifier tests.

Note on NMI safety:

An existing bug in NMI safety after further investigation from this
sashiko report [1] was found and reported here, with reproducer. [2]

Basically it is possible to invoke map dtors from within an nmi context
by attaching to specific tracepoints. Because the existing dtors rely on
rcu and/or locks, you can cause deadlocks. The fput added by this patch
is unsafe in nmi context and affected by this bug.

However, the solution requires deeper investigation into verifier safety
in NMI contexts, and is outside the scope of this patch.

[1] : https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] : https://lore.kernel.org/bpf/20260421201035.1729473-1-utilityemal77@gmail.com/

Justin Suess (2):
  bpf: Implement dtor for struct file BTF ID
  selftests/bpf: Add test for map-stored struct file kptrs

 kernel/bpf/helpers.c                          |  16 +-
 .../bpf/prog_tests/refcounted_kptr_file.c     | 247 ++++++++++++++++++
 .../bpf/progs/refcounted_kptr_file.c          | 158 +++++++++++
 .../bpf/progs/refcounted_kptr_file_fail.c     | 141 ++++++++++
 .../bpf/progs/refcounted_kptr_file_success.c  |  61 +++++
 5 files changed, 622 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/refcounted_kptr_file_success.c

-- 
2.53.0

