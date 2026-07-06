Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99738F252
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358364; cv=none; b=F6s7NVQT9m06YH8LJWD46jbM/P3OKil4qvFRh4enRbBmK2RG4sN2rmq+dhmADrwAqiwB31F7e85C2G8Yo6pcmLz4ZmMIBR0WNNGVU9JLkcEa6j9fFUFoae4JvF9ic6oIxofBcQ4doS82LkGpmR9X0XwLsDJ6lY2wRW8imInYQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358364; c=relaxed/simple;
	bh=ehUPaU/1dF2KpG5kToZV7U5XhlQnUkBKHuGMy/qSzhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGquObv3MqAuBOSUQSn4VcSuoBnwVYS/rjN2OXPSylbBxBok+02XOXkYTGl0l5I+nvZhIU4zNt5eNFCoRSlFfkpMPCKbXfOneBq9LruZTDyMVIQf7UXK/w0/ITQi7F8sTPq9DOALdWeCSGqBaYwG5LvtSeOkITHQtnP5Nb1Otws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3yJ6Xan; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3yJ6Xan"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb4d8a21a8so2164367a34.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358362; x=1783963162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CcnEKxuZvnrlq/X8pfnKmD+Iim0hx24bDmSujajdu2Y=;
        b=C3yJ6Xanaw0+kWmedBpRUt76aNgktRzzTp8Df+YloZ3DIltOIyRAV1ucL9hjoK/V5T
         zVJ8n5mqkPPp0O5tRbnxpP6lxm6E9STbO2CIADU7Iqnx/eO+PaK+0Q3+wmDyKy0hr2nV
         fCAorBCKqpK5ZOxVKHxreVoDHRqPyaVqK5F8NLCCCghNhFpMkIsFWTYd2cnFOwtcHRur
         v0k681+ldBt41nucDVaON0IBhkSVxUZag2SQQNF9H3mzCeeJpjz6AYyIO8nYkG0wNbsA
         cgM27kAZDV5FoWkGsL1yoJmX5z4EFd9tOLnX/dJ92CStg6UT0iOCdGE520uWRQ252wrf
         BzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358362; x=1783963162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CcnEKxuZvnrlq/X8pfnKmD+Iim0hx24bDmSujajdu2Y=;
        b=jzrvsQ8nZ0vRbpWkBvV3aaVeRpbFsaMKzlhdqDPlYJ4J4z75+wD7+Wjn/PkaceF9zY
         6qfLc5QBicDxA1cf2+6cBmSHF2ZigA268F6PLwO4g1BPOkBPfVlM43/vsUmt49pb3e8q
         MAXP1BAjuMxOyrs0j7eUdmCxYWzR0LjSDGDHEFkKHlTID74hPe31b5UXDTn/Cj6b3CS/
         aguZBN7Pah3uqEGWthsYfPbKzH0H/7MITCeSn9KDm7AeCqj8vV0MKMUhmA5rv4EuEHQ4
         WP9QacSVm4/4/8IfW3t6ZgzNDDu4WuSvONQcAJ3ysynqFr62ltiUu32wmjADBftO6aQO
         YA4w==
X-Gm-Message-State: AOJu0YwePzvdRkIghCBY0ZQC4JJkvhSIXiYJ6VFnpeKsOLfWyKY9RpAe
	KhXcdxnHGymVWS7F3HE82csaUjrQzAXRRf/JR4GX40uIzLg08cdnHRGBXSm0Gw==
X-Gm-Gg: AfdE7ckrFg2VNhy3oszOnVo7I82Wnsw0N0WI9idvJy2H8WhoaOdJaSYu2MVzQf0x+K3
	YMWpNj38HWR+g2hBC8QTSoB5zO54gzhvr38i1RVM9v76Groaeuo9sY2Kv5y+ioz8X5j0Cfe9EBr
	fQ3dKXmD+J51tz+BgtcfwaCr0qon78RJ5Rh/gaTkulsil+C9TXicQYPhoRvuMCsLBkSTNbX9RKy
	Qrsr3HcEJbj5152WlQISwe8Zd2Px0PtOm04TA48jvAutfDCrnJfQOzukkzMbFB9LRZJbXaajguP
	Uu2fvcBT/yPK7L/HqiU1C3K3y4a5QNbY2NuDFTZYBKoPQmPRQRE8JYRxTCd2KDcUHflNdPvjLKg
	jHhsysXiVcvvS/2f0tBWLNJargIWfE8l+02h+QDnfwnsVLntUfncWjTOCIaek0v3NkPr+7tajUu
	7vH6kA1RdGknNy5w==
X-Received: by 2002:a05:6830:608d:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7ebb2262664mr900845a34.12.1783358361740;
        Mon, 06 Jul 2026 10:19:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54521db4sm11966334a34.25.2026.07.06.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Mon,  6 Jul 2026 10:19:02 -0700
Message-ID: <20260706171918.317102-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
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

v2 -> v3
  - Patch 3: Remove redundant bpf_struct_ops_kdata_map_id (Sashiko)
  - Patch 11: Reject sleepable programs (Sashiko)
  - Patch 12: Silence warning when casting ctx to arg pointer
  - Patch 13: Fix incorrect libbpf API addition (Andrii)
  - Patch 14: Fix selftest cgroup cleanup (Sashiko)
  - Patch 15: Use network_helpers.c

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
 kernel/bpf/bpf_struct_ops.c                   | 142 +++--
 kernel/bpf/btf.c                              |  23 +-
 kernel/bpf/cgroup.c                           | 472 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 324 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  48 ++
 net/ipv4/tcp_timer.c                          |   1 +
 net/sched/bpf_qdisc.c                         |   2 -
 tools/include/uapi/linux/bpf.h                |  39 +-
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  64 ++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ops.c    | 560 ++++++++++++++++++
 .../bpf/prog_tests/bpf_tcp_ops_hdr.c          |  77 +++
 .../testing/selftests/bpf/progs/bpf_tcp_ops.c | 141 +++++
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  83 +++
 31 files changed, 2224 insertions(+), 121 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.52.0

