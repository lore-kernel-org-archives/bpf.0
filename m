Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254E379C26
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780214167; cv=none; b=D4pqqdmiZZYJTDRKNfl6SeTDxbSoIhm6e+RlXBHWFgUcmKUeGGinZzrpXYQ6HrbpQt47yV6I5Vvzkx1RCLihPZc79EbQaODokvToCxMSAruqDydKJ0sIpcvgHPNdB/R1XbFuO5Nt+ZnL0D39z/XHS9WNRk6ddXA4f6N+hZKBiGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780214167; c=relaxed/simple;
	bh=0ZTzmpsL/SyhVqtE6wYgN91abnB599baUcenUwOH+F0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YFPZ88LLE37NXckkxzm2tDkqvSnyXpkYqqnyd2NKnWjkLMpZJqYDBwHRLDQpYMFBYdx08qL4ZNdi7QaENbNm5BwGwo+xEylEq+OzcXMPdb8453YuzCSwMk5kEBW2rnJj8K88uMM1+JinU/3fvH0WrCskCfmvY2GwPduVxxwLSbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qAMJk8jL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qAMJk8jL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf0453031aso44869315ad.2
        for <bpf@vger.kernel.org>; Sun, 31 May 2026 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780214164; x=1780818964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ww2TKAwQFzWKllAfke4cPw7GXPWVedMoRg4O7J0u2ac=;
        b=qAMJk8jLgHUwbcEmcA+JJfeHfgZlbdSNWmg6vCBdRmTDYxVjSZGjaKHB5qXyWCEaxH
         5bfpm3zfOytZ9ejNKyFxrY/p1GsmV1/UmDuAOYto4E2pw1FxsQE/x3J0Bd4FC/XyJdGl
         An7eepQhEXW5jfri1d202DEQkegcoUVjEu52xAiofioZeFpf7yczPU9a5cPu02qLW61p
         Lsmvte25czgcbhaic8c/Xq/I+GmVYJ59oGSwX5WOrEt8OHTC+gEGn7byeQDjpisaPPlu
         p5ZUArN/91iFNS8oN1/BgYCZ+Jn0odZ/E6jYAFMMsmRK3qivzVGQvKDoliplv+EQS90t
         TcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780214164; x=1780818964;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww2TKAwQFzWKllAfke4cPw7GXPWVedMoRg4O7J0u2ac=;
        b=hEI/06AWCoVE1/HzCS7BldLv+VeeSpLjuptHVB+R+w+FB3I72MJIPoJjJzzoqKy5Gy
         /QN4KpjOBeOVRSdTXSvdYIc2ZI01YS/MOnikEidgOsJCzP14kXnm0eHUEc9sWLJi473J
         Nz7umibX8ZxgGwMLxcEVrcxpJ6lJtDiSc1SI4TznTcfKtR0gbzM4oaxy0zlsiJEIYKNz
         x6ckTIicT1tQSDTp8uyvtkqLR86Svm4oNe3ufQYCTX072beNXhj21o9S7yLWuu6QHes3
         Vtiv8nJcvVmXx7m0Xx/U3MJfPvEDHu1OiGHCtQwjV4nxbrEGF/jLRDUMYvbaW88o3FUo
         Teaw==
X-Forwarded-Encrypted: i=1; AFNElJ8vhAl0NjFqBLU6isZ75qGiCgq8zedDpCXl9j5NIEYDq4mRRTYFwVeGT/PAV5FbgsmOvVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6/bLyHHW9Ge0dCU0ldDRdVDA27/CThKDahyTU65Y3p6W6G+s
	YRkgA2I1aMG4QV6YzSfCQu2dMYqStOulIN30f4B+WtnyCtdAdx3NEEl5baTBSLSVGs9jmAuY9HT
	IvA2+c/USlCb1/whAZWtKBGvb6Q==
X-Received: from pleg17.prod.google.com ([2002:a17:902:e391:b0:2bd:40d4:e407])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e543:b0:2bd:6e1c:3ce with SMTP id d9443c01a7336-2bf3684e3e8mr75086395ad.20.1780214163562;
 Sun, 31 May 2026 00:56:03 -0700 (PDT)
Date: Sun, 31 May 2026 15:55:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531075600.4058207-1-yuyanghuang@google.com>
Subject: [PATCH bpf-next v3 0/2] bpf: Align syscall writeback behavior with
 user-declared size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series fixes an out-of-bounds write vulnerability in BPF_PROG_QUERY
while maintaining backward compatibility for older userspace applications.

BPF_PROG_QUERY unconditionally writes back the 'query.revision' field
to userspace. If userspace passes a smaller 'bpf_attr' structure (e.g. 40
bytes, which was the cgroup query layout before 'query.revision' was
added), the kernel performs an out-of-bounds write.

We address this by propagating the user-provided 'uattr_size' down to
the cgroup query handlers and conditionally skipping the write-back of
'query.revision' if the buffer is too small. This allows legacy cgroup
queries to succeed safely.

tcx and netkit queries are left unchanged since they were introduced in
the same merge window as 'query.revision' and have no legacy callers.

Finally, we add a selftest to verify these boundary behaviors.

Changes since v2:
- Propagate uattr_size to __cgroup_bpf_query() and conditionally write
  revision (instead of unconditionally rejecting smaller sizes in front-gate).
- Update BPF selftests to verify that cgroup queries succeed with
  OLD_QUERY_SIZE without writing revision, and succeed with FULL_QUERY_SIZE.
- Remove early size checks in the front-gate to keep the patch minimal.

Changes since v1:
- Simplify the kernel fix to checking the size only in bpf_prog_query().
- Revert all other subsystem query plumbing changes.
- Update BPF selftest to target BPF_CGROUP_INET_INGRESS cgroup query, and
  add verification for attr size boundaries.

Yuyang Huang (2):
  bpf: fix BPF_PROG_QUERY OOB write and cgroup backward compat
  selftests/bpf: add verification for BPF_PROG_QUERY attr size
    boundaries

 include/linux/bpf-cgroup.h                    |  5 +-
 kernel/bpf/cgroup.c                           | 13 ++--
 kernel/bpf/syscall.c                          |  6 +-
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 69 +++++++++++++++++++
 4 files changed, 82 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

-- 
2.54.0.823.g6e5bcc1fc9-goog
