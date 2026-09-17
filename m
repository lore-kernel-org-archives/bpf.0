Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4703CDBD3
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675547; cv=none; b=OMieyyDS6yhGLShhilFztrPUQ8CoQcngQ4LW3xN4s7AGHc1CvqHL3p5rD8FPjNAV+jsGOcxgPpwN7vhHvN7l1Og3Rby7bXUA7a0g5Gg5Ly9cc/RYO/2a3/+shmdrZ/2cEy5tCvGwhRSCDenVWGhnRHC7IXazhcqylcGsSxwSfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675547; c=relaxed/simple;
	bh=TfV+HzMprhU6jbU1gfZFGIyIbcZzWDRJ1Tg3asNbQ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lMnay3sP+0tIF6NonGfRuIB51qegzkqd4vGotpw3rxgkS40HUepUUaNHCTd60YkvsIBoJqI9qzjpcDk8c9pBDWrjY6KvydfkZ7au4qXn4n9LJDFbfFx4LVLdRPAtk4vQCXKMyNBz6vqBnxLuaqa0XvKGHu6uR/v/2lNTDtBw3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whp1GkD5; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whp1GkD5"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-80a71781323so649034a34.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675545; x=1790280345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LeldsrpJvM3CO1gHOjVnfm+w/hXn4RvNV1+Jm/71EHo=;
        b=Whp1GkD55v1SecmjapKPehb65JbhFgZad4jZFP2Jmiv3XvQK0aNoUYQTCMJ2L4aIdI
         PEfS1KfoeHtUm23Ir99vEVsZoBDQeYhwcTCfSvxGbXqkFJq0y61WCUT7X0/1UJa1LA9e
         iXSXHu/PEKyE10/BphOxoUCX0Z+cpUcNSj3v4TuVtkbMHTH7jiNHOI4CXPsWxRSzSyUs
         hdTMim0lo9Luj94ZMOBAjfjfOtJKpY450v1T0hEIhe29m6QzsZFWXaapOL3yirYZhppx
         uqNqdh633CsH2HQ6W14A9YU4PWfv7lCx7JlA1yWuwe0FbH43MoyYM/ww9MhZgABMsXXi
         jRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675545; x=1790280345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LeldsrpJvM3CO1gHOjVnfm+w/hXn4RvNV1+Jm/71EHo=;
        b=tR8KFh9web1q7MsSgxrdWrT4HKe8Pk0vrdRC2eo0qsjyRwXIA+x3dQ2kCkkzLM508u
         KrhsMHQcmQY76/Fo6bPtLp1PeEbu24FMcm74jr02wz30fNZdj8MPtj7h4maAa2hW+LHe
         rfPcopCXWkVil6neDiEcolCzba4bmBIZO1GPOwBTvBfxhav6tyYJ9Cli4O214ogdp+R6
         HaVNV2S/XSYjVzkbW7BvQfZvbAYDGQwb8XJMgUN9/7YP/4TKIThrzq+epx9t88oBaiGO
         wG056W9ZE3up3zLmS4VUfC6qlYKoc6iD9l7titzlNyNzgOszOTjUAhLIEBROsuz+HXA1
         57ZQ==
X-Gm-Message-State: AFuF++nZ7RvG7l3vinJT844768aFyF2isKJ7iXeI/B7Co1/8R+5VFR0g
	YXiKo0OAal/XpgY5ZHaUQHOy/fNWoBb5oMp86rSBZDK95fXSxUPOInfZGRjupg==
X-Gm-Gg: AYBFou30YTr/G/97f7bMgd2Zq6tXCTc638xK8hbeTGAJezqO3WxoVrH0NoG+kUqwnG/
	/b+0nUFIraZiEiayAuGm/6mQIoca/z7W3Rgb20IoNksaaoElL/D2oa6/PfGI+wd/stLE+7JBRzf
	OJwFXYVJ0v0f6M8DBcGYUky8G6HPUHS59GnItqsaiFWFXMgKazuZ50yMCnAlZrPz+vO44qoETDn
	CaJahQP6l0XNcN4rBxXHZz5YVIjuK8/Ad6O9PYkjsVKfYOYgKYsWWbOZ7R3ni1UcA9P0/KS2aQb
	mAaI99+o4KYcBh/VG8s5V6a2xk1ymM6bSdTPj1gjq47wbftW7MOmHRLf9ceoq2nCi5tdjaLFbq1
	XCB9ZAQ6lTV0A2XOpEBz3Kvg2e3rYoekszWqpGAxAgqBzuMjN0+3vOB20/q0tiOfv2m7bL+aCEz
	AshRrnyj04z+kUokZP+9rwbJa5bMYrwtAnK1jjP3K96vM3PVoHNikFYW+QSm/wtA==
X-Received: by 2002:a05:6830:412a:b0:801:6bec:ff18 with SMTP id 46e09a7af769-80ddfd6c36fmr282158a34.2.1789675544456;
        Thu, 17 Sep 2026 13:05:44 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c477cc3d3sm3957790a34.27.2026.09.17.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 00/15] bpf: A common way to attach struct_ops to a cgroup
Date: Thu, 17 Sep 2026 13:05:26 -0700
Message-ID: <20260917200542.3689605-1-ameryhung@gmail.com>
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

v3 -> v4
  - Rebase onto the latest bpf-next
  - Add Reviewed-by tags from Emil
  - Fix minor styling issues
  - Patch 9: Consolidate per-attach-type struct_ops metadata, document
    the RCU lifetime, simplify map-link auto-detach, factor out the
    struct_ops list-entry check, and validate that detached links exist
  - Patch 12: Keep the legacy WRITE_HDR_OPT callback gated by its
    opt-in flag, initialize bpf_opt_len for tcp_current_mss(), use
    ARG_MEM_SIZE for header-option buffers, and clean up comments

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
 include/linux/bpf.h                           |  55 +-
 include/linux/filter.h                        |   5 +
 include/net/tcp.h                             | 156 ++++-
 include/uapi/linux/bpf.h                      |  39 +-
 kernel/bpf/bpf_struct_ops.c                   | 142 +++--
 kernel/bpf/btf.c                              |  31 +-
 kernel/bpf/cgroup.c                           | 484 ++++++++++++++-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/syscall.c                          |   4 +
 net/core/filter.c                             |  33 +-
 net/ipv4/Makefile                             |   1 +
 net/ipv4/af_inet.c                            |   1 +
 net/ipv4/bpf_tcp_ca.c                         |  16 +
 net/ipv4/bpf_tcp_ops.c                        | 326 ++++++++++
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  17 +
 net/ipv4/tcp_output.c                         |  98 ++-
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
 .../selftests/bpf/progs/bpf_tcp_ops_hdr.c     |  86 +++
 31 files changed, 2280 insertions(+), 142 deletions(-)
 create mode 100644 net/ipv4/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops_hdr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_tcp_ops_hdr.c

-- 
2.52.0
