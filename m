Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12538D686
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237010; cv=none; b=qV0YK4dc7hspWvErcBGaR9DxTAOUsl1vCG5zRbanOjGGiqKI3uUyjoArCmucYDoA0ZqK91+EMTosNfHFVjrLqpZYy2YMqBtCXzUcGf9dZ0MZRS13MrqrXDzpmtVfpJzNC3Hs4ke3Qy2fQNt6TnZxmUJJJJ5h6PK91uSiTNz3q8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237010; c=relaxed/simple;
	bh=J4Mmg50ei5MqCilxr8JVSS/g8YXU0rdSBLfRIFuLPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9U5O4VlkF+Hvv9/CuG8+omPHpdp30QdNZ7UfhYNYOaX6CQNE1iGgyBN7E3NLmAEdQ5tQKoAXEOYNoaodu9XOZ9lzlavzVvIxkg1ez+SLj2Th++rY1gj9FgiEBy9x3Fh34j39zIcP0im5UpMM6jAj8tcb2ul2mOeG9iqDZf6Zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPnPftCa; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPnPftCa"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-69ed219d3ecso118709eaf.2
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237008; x=1782841808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5T1ktDtWc3MIt0N1DGCs0NMaU/i1dfQECQKpgA5t4J0=;
        b=dPnPftCaVwoCNrSuOpSm50wf6msfZN1PLHmqDbVUfcCgNSUkg9iXBRb8WX052kOw+v
         yVhefuAKLQ9mJB9i3oba0ANuIViVKIsPgzZMKNl8cy1b86jagfORDbWhDqD8jx5PqTs2
         4ct3AmpFxgXEBe04dXB7uEQU/wTwTsrLp2+v+rD7lfjiyyU1aXbreRP3G0fMH0NjcPQc
         AzUse3DDXSdm2V5iPMlzPHGquPomRJZtDKjrOLhgO/HKD5q0BPSHwnGKtQLGUiXbKniQ
         sqdZ6qL/1vnkqeXdZf/rbLfNoKjfKGOiG+Ojy0Z0VARYSepYlpxXNqCrriAK+MXh1bCN
         xqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237008; x=1782841808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T1ktDtWc3MIt0N1DGCs0NMaU/i1dfQECQKpgA5t4J0=;
        b=O9Cw9kIKKRdMXlqyS2M2dq/sUjzZPWPvpyQA9oHTh81BW0vbKtpvBSC9aWdqjdJKfO
         uz+TzZipP2qyVo32cTh0CUQUu300rp06SiHM6coioMNXH8SxJSqmkv9BKA/RNeJ3H+/i
         bnulFdRVt7nabLEWKAbw/d+RqG8hezIHJCA4YGWGcMyhYObJa2pBCqY1tLIUk2DJ2oBd
         +2mpdBAnelgyjWRoxHrcmHhMMVPpWI/EhI4uR1yugtoh53TBKRoCea9S6EZfe3/BrE9D
         OtqnvsildLPkwVRuyv201aIxTjOOf2Imvxlk+5seDK/V54xPn/DYeqVLoMvkzjM3XCL8
         LS2g==
X-Gm-Message-State: AOJu0Yww9iEiLGepxJ2GDnoIhrZY7Zz2PPINXDGgrkSBK079lLikrwSi
	sdddQZX2GaN7PWqhcYx0q0keNgQWwa0v+vcqrwMd4m0ueNMxDdUMfKu1IfD+KQ==
X-Gm-Gg: AfdE7cnGzPHQbQRera3/UjbM/XSWLmVhUyILBBwFXI2xDsH0lv1AOnSGrsqd0yGKi7M
	8K+msqxUNvpJbvS/8FFXZwhLEPvuePell16tUy4yC+ErGsi1JwP4CTq3jBbbv2B87qhqtlhopt1
	bpAdh1m2ZQkxQEiLXs9vek8DBpJxhp3Fn9EUDZ5P+hquC8TrvNN2T6ShbC67579gb/09NFVkeJH
	qoBpZFPisyRepo17B0HgsWPMiUDgjdsbimkgxWebPYCcoNFcvt4EkzMbcbuYNBuainKC/6bu5av
	n6Zmz8xy23Wgla2Z095VcHbyVTsoQyB4FQiPM36H7JnGAyOE636YOLJUFL3nGVkAZQpg94ONBTC
	EglElmNLdTYXSfOZ7769rGWB+9tXda7OmEBIm/jbCOi8ARCxRQ1ywKYXFm4O0x0rLbl9IRIFSLn
	YFxe4=
X-Received: by 2002:a05:6820:190f:b0:6a0:c3ed:be45 with SMTP id 006d021491bc7-6a0d8d5d523mr14664965eaf.54.1782237007813;
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0ea102694sm7193449eaf.13.2026.06.23.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:07 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Tue, 23 Jun 2026 10:49:48 -0700
Message-ID: <20260623175006.3136053-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am continuing Martin's work to support attaching struct_ops to cgroup.

At LSF/MM/BPF 2025, Martin presented [1] the need for a new interface
to extend tcp_sock operations instead of adding more BPF_SOCK_OPS_*CB
enum values. The need for predictable ordering when attaching struct_ops
to a cgroup was also briefly discussed.

At LSF/MM/BPF 2026, additional use cases were raised, in particular
OOM and memcg use cases that also need to attach struct_ops to a
cgroup.

BPF already has a common bpf_link-based API for attaching different
BPF program types to a cgroup. It provides common attach, detach,
update, ordering, and query semantics across those program types.

This series extends the same model to struct_ops. Conceptually,
struct_ops is a group of BPF programs, so using similar
attachment/detachment/update/query APIs and ordering semantics for
cgroup attachment keeps the interface consistent with existing cgroup
BPF links.

This series uses a new struct bpf_tcp_ops as the first user. The
struct_ops mirrors the TCP-related sockops hooks except
BPF_SOCK_OPS_NEEDS_ECN and BPF_SOCK_OPS_BASE_RTT, which are
intentionally left out.

The selftests cover attach, query, update, ordering, before/after
placement, retval chaining, the header option hooks, and inheritance
across a multi-level cgroup hierarchy.

The map_free_pre_rcu addition in patch 2 is not very ideal; it will
need some thought too.

[1] page 13: https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view?usp=sharing


Changelog

RFC v1 -> v2
  - Fix UAF of cfi_stubs
  - Fix retval: use bpf_tramp_run_ctx instead of bpf_cg_run_ctx and
    expose bpf_get_retval() to bpf_tcp_ops
  - Add selftests
    - struct_ops cgroup attachment
      - Test bpf_get_retval()
      - Test before/after order
      - Test cgroup hierarchy and inheritance
    - Test TCP header option hooks and helpers
  - Move bpf_tcp_ops out of legacy BPF_SOCK_OPS_TEST_FLAG guard
  - Complete bpf_tcp_ops (make it comparable to legacy sockops tcp)

---

Amery Hung (4):
  bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
  bpf: tcp: Support selected sock_ops callbacks as struct_ops
  bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
  selftests/bpf: Add test for bpf_tcp_ops header option hooks

Martin KaFai Lau (11):
  bpf: Remove __rcu tagging in st_link->map
  bpf: Make struct_ops tasks_rcu grace period optional
  bpf: Add bpf_struct_ops accessor helpers
  bpf: Remove unnecessary prog_list_prog() check
  bpf: Replace prog_list_prog() check with direct pl->prog and pl->link
    check
  bpf: Add prog_list_init_item(), prog_list_replace_item(), and
    prog_list_id()
  bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
  bpf: Add a few bpf_cgroup_array_* helper functions
  bpf: Add infrastructure to support attaching struct_ops to cgroups
  libbpf: Support attaching struct_ops to a cgroup
  selftests/bpf: Test attaching struct_ops to a cgroup

 include/linux/bpf-cgroup-defs.h               |   1 +
 include/linux/bpf-cgroup.h                    |  28 +
 include/linux/bpf.h                           |  56 +-
 include/linux/filter.h                        |   5 +
 include/net/tcp.h                             | 153 ++++-
 include/uapi/linux/bpf.h                      |  39 +-
 kernel/bpf/bpf_struct_ops.c                   | 152 +++--
 kernel/bpf/btf.c                              |  23 +-
 kernel/bpf/cgroup.c                           | 472 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 310 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  48 ++
 net/ipv4/tcp_timer.c                          |   1 +
 net/sched/bpf_qdisc.c                         |   2 -
 tools/include/uapi/linux/bpf.h                |  39 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  59 ++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/lib/bpf/libbpf_version.h                |   2 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 554 ++++++++++++++++++
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          |  97 +++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  83 +++
 32 files changed, 2234 insertions(+), 122 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.53.0-Meta

