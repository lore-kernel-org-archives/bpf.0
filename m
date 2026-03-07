Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF1367
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841783; cv=none; b=lJjrgWD1t+H6wAtlJsItm8ZcUmJzwjuwDTVn9oNYBi/14GbG2PQfSIXsbDXgIVsTM+F894fioNzRLEHWAL/DAsAP/yqqHOW9ePx7HHvAGSOm8Drz0h3JbKeF4MoT9kTC0yFeEhJ++Fer82noqOgQlU9Nk0SNGQ4osCi+n/kbnEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841783; c=relaxed/simple;
	bh=pm1T5tFB3MP5D1XCk3kEIR7R8HlQMgk8Mhc8huabuBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iVphUaYqrCSxitBRAiyogYduft3srZ3e1pn53jFLYuYjGQDvOzs7IlmxhYeBC3bOW+SXXr9MgHB8jPLK1KSebumkas1qih1zRyz3+FclhDnLrDkhvAJTt8HvoZRCeJDS7Me/xPLRaeh+i56Arn42U9p9/qJy3PqGU50cO6GZQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObMokZ2q; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObMokZ2q"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732165d1eso10836702c88.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841781; x=1773446581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PfpsetY8FlURiuiv4PTaaclJ6YRUq2AQHJG77JUrzIM=;
        b=ObMokZ2qWGhk+HJKk1qZemwS+p99QhdTlOWWlmGfu8VxVAECPLt6Qwd2iPhoLfdH+9
         JnQXTzsDzr3ohB0lLpix07cPaFhnf6TO9A+6FMzjwzqwX1b4tsopn2o6qwQrF7/e9LMx
         GIeBjoa1V4jmBkYT2UDcwd9/6es45c/Mg9XewJIicPRWyJgVi308+1U4YQJC7bvyRwfw
         abava6TTvkCI5E+M7BUYr/S3AfQurmwVsPSlsxx/FEQB8BJXfzNcA8yPEBP7I+w9q06e
         6qC5wvJZUzDskD0M+JIEWra9I3jgSdIkJpqSjVBWQfU/o/DqH76ob+lxVBfOHVlj0Xzz
         8iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841781; x=1773446581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfpsetY8FlURiuiv4PTaaclJ6YRUq2AQHJG77JUrzIM=;
        b=PquRNkpAx5mcIE9pN+MLnjtKLEgd74fk595jUdSEkJAbi/8bEM+ql4P6nBLz2dLvRQ
         E1wVFFnIL6yz0izKcFQ8c655BVh1w7zvJi+LVOzIH2tlcwh5+3q7B4vKu2Kh2MeT1Qbp
         6UIHMszRirOmvNGw2oh95hUfglWEBIhh5jVTQeARBR5zEXMXMGWJdX2Lj2Iw5EXn5Ios
         oveZXuxy+EUppFLXFjgKLwY+ezCZVLmMtU2fJ0SjmYGotlRBIxpU28lrAMGnA7NvSSHx
         hNiPL9Fc9cgG3wN5wiOgg82X3OquXVg6MQijc3/NXxrUzQhIG54ssSa1scbAgKiLlLRY
         6KjQ==
X-Gm-Message-State: AOJu0YxE4IM03+fGyo9pv06X1v/Gz6pPV5CTHYDvine+LrYUbBw4W5HE
	aMntilEqQg9peJLtOxscv0bhFWNSsG+aoJ94YsDhCxEyn5XgFuMDJ8GJXB+iTwBu
X-Gm-Gg: ATEYQzypZxLOrKOAMAP5WhB09MmW7tACEUkPStw7i+BjAlRvh7HZECOx3wuiyYBVAsD
	ONaPkgt2QWpoe/4IAJgC++yKdGVGy3NLeXGWxSlhH5fG3PZuVzvFUwuJGwfeuJbQ/OTVDCCZ6M9
	bc+eWmaEmXsGMbG2IJEbhFvw8CYOhrW3gg21LYqHdSIpXDKxHTKadKam9bEFmk8OgpUCtzJfRek
	RivET4DbqN7Wu/TeSdvJr6scPe8H0l+ugxygYVKjCPaphoAkKXFMkzVfryyStjBwrjl5tBlOcj0
	aoaET8aZ9L+1BuzIJcKhkgA5ygw2TPdy17Lg0iCu80dSNpWMcUuXUgjLhlfqXMLOnHeDRAtyP9m
	BH4GyWcDLQcaCvSq4e72Y9Qsr8qMf6wL9Shdfxwaz9rzT3NrZKh+gUtNUY7lVWsTPM28XM8+q/d
	T6W3Ugzr+EE/zoe47fXws3qifhO8DR+Ks7drTELUBYfIIwUPyt7Svo8JZvPQ4rM0IFn8750pk1g
	DUcONU=
X-Received: by 2002:a05:7022:e28:b0:127:5c70:926 with SMTP id a92af1059eb24-128c2e96d1emr1730623c88.28.1772841780972;
        Fri, 06 Mar 2026 16:03:00 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3bf4cb2sm2153786c88.0.2026.03.06.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:03:00 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf 0/2] bpf: Fix precision backtracking bug with linked registers
Date: Fri,  6 Mar 2026 16:02:46 -0800
Message-ID: <20260306-linked-regs-and-propagate-precision-v1-0-18e859be570d@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260306-linked-regs-and-propagate-precision-3d28e2ef5cf5
Content-Transfer-Encoding: 8bit

Emil Tsalapatis reported a verifier bug hit by the scx_lavd sched_ext
scheduler. The essential part of the verifier log looks as follows:

  436: ...
  // checkpoint hit for 438: (1d) if r7 == r8 goto ...
  frame 3: propagating r2,r7,r8
  frame 2: propagating r6
  mark_precise: frame3: last_idx ...
  mark_precise: frame3: regs=r2,r7,r8 stack= before 436: ...
  mark_precise: frame3: regs=r2,r7 stack= before 435: ...
  mark_precise: frame3: regs=r2,r7 stack= before 434: (85) call bpf_trace_vprintk#177
  verifier bug: backtracking call unexpected regs 84

The log complains that registers r2 and r7 are tracked as precise
while processing the bpf_trace_vprintk() call in precision backtracking.
This can't be right, as r2 is reset by the call and there is nothing
to backtrack it to. The precision propagation is triggered when
a checkpoint is hit at instruction 438, r2 is dead at that instruction.

This happens because of the following sequence of events:
- Instruction 438 is first reached with registers r2 and r7 having
  the same id via a path that does not call bpf_trace_vprintk():
  - Checkpoint is created at 438.
  - The jump at 438 is predicted, hence r7 and registers linked to it
    (r2) are propagated as precise, marking r2 and r7 precise in the
    checkpoint.
- Instruction 438 is reached a second time with r2 undefined and via
  a path that calls bpf_trace_vprintk():
  - Checkpoint is hit.
  - propagate_precision() picks registers r2 and r7 and propagates
    precision marks for those up to the helper call.

The root cause is the fact that states_equal() and
propagate_precision() assume that the precision flag can't be set for a
dead register (as computed by compute_live_registers()).
However, this is not the case when linked registers are at play.
Fix this by accounting for live register flags in
collect_linked_regs().

---
Eduard Zingerman (2):
      bpf: collect only live registers in linked regs
      selftests/bpf: add reproducer for spurious precision propagation through calls

 kernel/bpf/verifier.c                              | 13 ++++-
 .../selftests/bpf/progs/exceptions_assert.c        | 34 ++++++------
 .../selftests/bpf/progs/verifier_linked_scalars.c  | 64 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_scalar_ids.c      | 56 ++++++++++++++-----
 tools/testing/selftests/bpf/verifier/precise.c     |  8 +--
 5 files changed, 137 insertions(+), 38 deletions(-)
---
base-commit: 56145d237385ca0e7ca9ff7b226aaf2eb8ef368b
change-id: 20260306-linked-regs-and-propagate-precision-3d28e2ef5cf5
