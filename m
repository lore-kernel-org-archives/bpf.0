Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB941E7C18
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783290; cv=none; b=C1iTejw19URSZDLXMR5E5PrCw4mLN/58wOupPviIUUNm5X4+dzNSPPB2vmFUReHkmKOeP40L4fynXwildXrGNqeY03U17N+nRpKae/E0jK7GPvndDPVA9eQeMrEOo6zxFjYFJcQNm7LvTzS6sJhZEdgW3qr8iISQeeChQgOgSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783290; c=relaxed/simple;
	bh=RVCNNI7wjdUeDGcuek+A83Z7cOqK/vWCbnH3x2ECDJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPMkvS4XVoPwWIl09QHwwwvbGWl7GBKUUCUKuxSl1xFMlqKdpZSwqVpznGPmR9s6iJlyPI0rb1S0B0txsASENCUfHkvyAI8zf2kw26USXTvnbu8UpXb0qk2TmR+xA528yB5foapr41FmjmDM4w/cPBSQJxyC3DiKNtmxViGMErM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiiSt3hv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiiSt3hv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso2878295ad.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783288; x=1785388088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjgBs7JFZ85Ut4vQwe7QGxIdoRiZKPgr3+MFaiLeQ5I=;
        b=EiiSt3hv5DH7hXyNOtjCFtDNDIGOnGPSWttrC6YuIZp6h7zj0IzMhfdDMmuc5Ut0XQ
         BBVRr0/9D+c/e8e0O7KTR3JtbdeS7ZhtFMlVCPSVN/aF0bEzJ51fJkFLB1D3U414ZtGj
         JJplZrA6k2SMwKd7JPRbrUM3nBLbBNTQKKvXnC+YrvWUJKA3rAlE1LOqkRjDjr3oC6+t
         mZKs6GzYwJO+c3soiE9hVJY+T6roAZ9p+keJRm53Uaz9OUITTBXyh6hHVEwOlqXv4pBw
         U9tAnKFIGMpchHKy+VjBZ/IByNfdiLGV7gPb6QRpAV+1y4qLFu0uCWbHHXVRf6JRey5e
         Ianw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783288; x=1785388088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjgBs7JFZ85Ut4vQwe7QGxIdoRiZKPgr3+MFaiLeQ5I=;
        b=kA1MZUCpEM7jgyUdReACFVVl8Ps3S9GSBvbOaAmzng+f/C/B05vI32c60Ipr7lQ05c
         TzXQ0LxaUx0UkbE+iwAJiovSww/CnDPRv3Tb2umP4KuxqcvAVBda8OvBTJ/vImhhqTZ+
         DmvoiZsfIKJ6Vu9OBulB3fZtvQ+J4pzoiXr8TAdNfVVtpN6IAW1PZ6YJEoHs9Zee2PNt
         fl9SEwdVvZV7S7naTIqfgU364AVozfUzM5l4WYDMFX6U3N8lczCXoCPnGuMPYIOojuJt
         yszOytfdJY4Pr/ujI833u+MBThcT282MtpW2szfHcWFwqwVCRbn3yweM/BFi6IeSgX5O
         LoAw==
X-Gm-Message-State: AOJu0YxTHJ6yfumpx4YMucJxnNjv0xnUY/Va2s1YXEkU5A3E5iQ4aReJ
	czfIWup1IUVkwa3Z1D9+3I4E5ti/6ujsq30Ib9O0bz6P4TF1KM8ilMB5BgF2bw==
X-Gm-Gg: AR+sD11ox6+FCSgKBnlsmctRJDsxIl5dMiOpAPBtY4W8uBxZ/1rpH5pKZ4hHMn2tOvR
	qHxSJL5SI1yTpEiG0joY4cIMOBjw/HSyZqbsk1LRnePC8ZX5sfod6MuK3lIeC/ppXlGzB0pS95M
	4R7HR5J2JzuEF11c9tgkDAFAFgufEPtPDv1lsh5mTQD1nSEAaD+yDZtP/ud69W6caYT5cndSVgD
	lLgixFCBX/Gnw/5LpTvZgrRbk0YHKBd4D6I+6pr3n8tslJ0fMx0BO0ojfbIUrnUgjevwSTNFORy
	afgZxEzheThB8hCTr71Ope0UhbTU+Sbr6KJ/EMjNHJYzT9hHbUKMWqPDCAAy7wHM0UXn76HSnXf
	10ZrdtjBe5c8UORNjk47ggNZWQG8oIpFEzlnsH6r/ntKxXRXP8ke2Y/r5HIXLlfaXoPBE
X-Received: by 2002:a17:903:24c:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2cfa71dc76emr20675205ad.14.1784783288220;
        Wed, 22 Jul 2026 22:08:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efddfe1sm26157645ad.32.2026.07.22.22.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/18] Generate bpf_func_proto for kfunc
Date: Wed, 22 Jul 2026 22:07:48 -0700
Message-ID: <20260723050806.1158442-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the second of three patch sets to unify kfunc and helper
argument verification. It:

  1) further aligns the kfunc and helper argument checks,
  2) makes kfunc argument type classification depend solely on BTF, and
  3) generates a bpf_func_proto for each kfunc.

With classification now a pure function of the kfunc's BTF, it is computed
once at add-call time and cached in the generated bpf_func_proto, rather
than re-derived on every verification of the call. Along the way it also
fixes a few issues.

The next patch set will align the argument register compatibility checks
and route helper and kfunc argument verification through a single shared
function.


[1/3] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/


Amery Hung (18):
  bpf: Drop process_timer_func wrappers
  bpf: Unify const map ptr argument checking for helpers and kfuncs
  bpf: Split kfunc map argument into __const_map and __map
  bpf: Pass kfunc meta to mem and mem_size check
  bpf: Check helper and kfunc mem+size arguments identically
  selftests/bpf: Add tests for helper and kfunc mem+size arguments
  bpf: Check fixed-size mem args of helpers and kfuncs the same way
  bpf: Express ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE |
    SCALAR_MAYBE_ZERO
  bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
  bpf: Fold __szk const size handling into the scalar arg path
  bpf: Classify kfunc mem_size args from BTF without register state
  bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
  bpf: Distinguish fixed- and variable-size kfunc mem args with
    MEM_FIXED_SIZE
  bpf: Check helper mem+size in ARG_PTR_TO_MEM case
  bpf: Classify kfunc pointer arguments from BTF, resolve type against
    the register
  bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
  bpf: Classify scalar kfunc arguments from BTF
  bpf: Generate kfunc argument prototype at add-call time

 Documentation/bpf/kfuncs.rst                  |  30 +-
 include/linux/bpf.h                           |  42 +-
 include/linux/bpf_verifier.h                  |  31 +-
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   8 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/bpf/helpers.c                          |  42 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/stackmap.c                         |  10 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         | 799 ++++++++++--------
 kernel/trace/bpf_trace.c                      |  62 +-
 net/core/filter.c                             | 116 +--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../progs/verifier_helper_access_var_len.c    |   6 +-
 .../bpf/progs/verifier_helper_value_access.c  |   2 +-
 .../bpf/progs/verifier_mem_size_reg.c         |  60 ++
 .../selftests/bpf/progs/verifier_vfs_reject.c |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 25 files changed, 726 insertions(+), 524 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

-- 
2.52.0

