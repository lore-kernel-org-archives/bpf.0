Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6023B101D
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784483985; cv=none; b=GN9SftNUSncM5cxW//JDFEieWLRSba1BOwtPI1diHEEx4BJA7TJ0acBGr+GSthn09Gnn4Cy0QxCHiUteh83agzrvh1667gxuoGPgZNn44vmBt8K1wksDV6E+Ag4g5+MtU5tVkGwXzxDtqyHOigr33ngV6Dd2gN5Kly7E0B6iWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784483985; c=relaxed/simple;
	bh=Ob9Uk8n41XrAofX3TGiFlzwoHBcolkTju+8ERVgL3n0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iOR+pT4CByU4akRwGQXajhVyS8Xso+aVX/tTVkoTSfiuK6Xyso70kSgN50mPQ5lpO0fPDdqy5/I4sAKJAXXnT8TCmrpSZ5Z2n6FndafqHN9FkJ1oo7yytN9JQB8A29Iro4TmHkpFH/xJaC6Klro8A73dXCiUcTZTIScrOnzYsFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYcQgLUk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYcQgLUk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so84688325ad.1
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784483979; x=1785088779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SdFRIlbYTmDhC0hB0dOxoiaAG7mMkQbRNp+A9dlR7GA=;
        b=ZYcQgLUkPKbP1mm0Djk9AHjQ4INrjkzUs8fQXkuajbZoqmYS9o3sVH5Y/i9kOYidH3
         wRfeynOwU2EBHQXE75AttKEeH9c/exvZAsNWgxoh3B2py97RtBFXze4nAWcrFQWJMeEv
         VfL/C0T8q9Qf9FD0mckrNTd0onJLpuSGZBuMImsqMpcBySXTtYZRZ9tkSMKxlWlTpnKc
         2kQr0HLQJG8KGGITaIJ2MPJ+ZNMvIO5//CCCNVrRAyb6QwcyhKWKJGYDER4S07usHNPS
         Jkj728lpW5GngkS38JMD0qUCCbz8wFedbaAfNfiKQxhgHvnTIO7bb1Ezo2Ds3At98gAD
         cIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784483979; x=1785088779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SdFRIlbYTmDhC0hB0dOxoiaAG7mMkQbRNp+A9dlR7GA=;
        b=JoQPXV4H7A2BuN8uVe89nxiC6SmpWX3rrs/VbMaJbeIlh+AktBqRTKZ1P0sMp/+Tye
         nc7yG1rJG4JlwiXYB8pdOpmJLWwloNdvVBy0FkLKOua0uex9ITkaFQev8Wsmdyq3tprg
         43zh+3V6GP26+5d7B1vzzH4E7IbxyMbZyzC+22XhRuBb9LNDM1c45fuMwYejrdLaZ0Wf
         w1rtWqdy405IUmiEcbp8jhcWgm+F3E1bt82lFI+VxS3TuUzQzdgCQI+fK6Sb8kRjlAYe
         F9VRZJiBoOzoKFqxiQsdkCFUMe/d/6wWrQCOQrUXpdq4Dmf5+kJOAY4Wz5Gd2+T7P7Y9
         9ZQw==
X-Forwarded-Encrypted: i=1; AHgh+RrgoPoyaXVbmCHG6edCKsVt4HgPHvPidBIxX5Kwlz8JK2E2zoxOV5oWNyeD6S+G6UOicvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXMm90n/cBZEOx7RvTn8ZWT3BIJG0bD27CEM1rBi6+SOiQ5+T
	KCXGYoDZyNFa7WWcZc4mYKut4PFYYbIviMOBtlqn32AOwVj3L62GtYa5
X-Gm-Gg: AfdE7ckii0b70AMleaFMZrbgRpxA6k/9qAiYAhF1bmSwwuk+6dzg4GOfDECTWXBibBr
	46H0AAGraljYN40PIIcKQrBGoyVH/z0bqnlii+jg2VOP2D+ryUrwSi5UQlycVhKMEGFRcb8D5Ek
	RUok2Ujn5bFYrQxOVWifhq43veiOjrbv/gjtsQfdwHe7gQu0znZT4ERdmmVsZn6I+gioXnSpafh
	jq+RRgQyjMtmXbMzOQRSitj4UOXBB5+foZodzTTT8huLmJ227IWfoo/qxBDfQKWgZcyp1hB8OB8
	4mIGHCRvOvHigaLgVHQdy3ikoL0PeGjTgJjdcuC+4OkM0keL+wbnJMIqBhfU7WEeNjlQRjRvzr3
	kSRIPZrO9Bg2bipEakMMxgWjn44Xm+JJhbloQg6g+UFnQSU2h3W63wrmIo2qA1KOpYg==
X-Received: by 2002:a17:902:da84:b0:2ca:f40a:be76 with SMTP id d9443c01a7336-2cf34a49283mr114413075ad.36.1784483978918;
        Sun, 19 Jul 2026 10:59:38 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 10:59:38 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	bpf@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Hoyeon Lee <hoyeon.rhee@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Nathan Chancellor <nathan@kernel.org>,
	netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 00/13] net: knod: in-kernel network offload device
Date: Sun, 19 Jul 2026 17:58:44 +0000
Message-ID: <20260719175857.4071636-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

knod (in-kernel network offload device) drives a GPU directly from the
Linux kernel - with no userspace GPU runtime such as CUDA or ROCm, and
no userspace component in the data path - to accelerate packet
processing.

The kernel itself allocates the GPU's queues, JIT-compiles the
per-packet program to GPU machine code, and dispatches it; the NIC DMAs
received packets straight into GPU memory and the GPU returns a verdict.
The GPU is programmed like any other in-kernel offload, not through a
userspace framework, so existing XDP programs and IPsec SAs can be
offloaded to it transparently.

The design and motivation were presented at Linux Plumbers Conference
2025:

  https://lpc.events/event/19/contributions/2267/

Motivation
==========

Line-rate packet processing that does non-trivial per-packet work - an
XDP program doing L4 load balancing, or IPsec crypto - is bound by the
host CPU: each core handles one packet at a time, so scaling means
spending more cores. A GPU is the opposite shape - thousands of lanes
running the same small program over many packets at once (SIMT) - which
happens to match the per-packet-program model of XDP.

knod moves that per-packet compute off the host CPU and onto a GPU. The
NIC DMAs received packets directly into GPU memory, the GPU runs the
program across a batch of packets in parallel, and only the result
comes back: a verdict for every packet, plus the packet itself for the
ones destined to the host. The CPU no longer pays the per-packet
program cost, and throughput scales with GPU occupancy rather than core
count.

Crucially this happens entirely inside the kernel. GPU packet processing
today generally launches work from a userspace GPU runtime (CUDA and
friends) and keeps that runtime in the data path; knod instead builds
the GPU queues, compiles the program, and dispatches it from the kernel,
so it plugs into existing offload paths (XDP, xfrm) with nothing to
install or keep running in userspace.

Model
=====

knod binds two endpoints through a third object:

  - a NIC-side netdev, registered by the NIC driver;
  - an accelerator (the GPU), registered by a provider built into the
    GPU driver;
  - an offload device, created on attach, that connects them and owns
    the per-queue data-path state.

The accelerator ops are feature-agnostic, so different per-packet
programs plug in behind one interface. This series ships two features
to show the framework is not tied to a single use case (the accel-type
uAPI also reserves "dpu" for future non-GPU backends):

  - BPF:   an XDP program attached in offload mode is JIT-compiled from
           eBPF to an AMD GCN shader and executed on the GPU.
  - IPsec: RX ESP full-packet decrypt on the GPU (proof of concept,
           see below).

Data path
=========

For a NIC RX queue bound to an accelerator, a received packet flows as
follows:

  1. Attach reconfigures the NIC's page_pool so its pages come from GPU
     memory, exported as a dma-buf and plugged in through the devmem
     memory provider. The NIC therefore DMAs the packet straight into
     GPU memory - there is no host-side copy on RX.

  2. Instead of building an skb and entering the stack, the NIC's NAPI
     pushes a small descriptor (memory ref + offset + length) onto a
     per-queue lock-free SPSC ring shared with the GPU.

  3. A persistent GPU worker drains descriptors and runs the active
     feature's shader over a batch of packets in parallel - one
     workgroup per packet - then writes a per-packet verdict back onto
     the ring: PASS, DROP or TX.

  4. Back on the NIC NAPI, each verdict is applied:
       - DROP: the GPU page is recycled to the pool;
       - TX:   the packet is sent back out the NIC directly from GPU
               memory (XDP_TX), with no host round-trip;
       - PASS: the packet is copied out of GPU memory into a host
               delivery page by the GPU's DMA engine (async SDMA),
               wrapped as an skb, and handed to the normal stack.

So only PASS packets ever touch host memory, and even then the copy is
done by the GPU, not the CPU.

The control plane is a generic netlink family ("knod") for
attach/detach, accelerator/NIC inventory, and per-accelerator feature
selection, with notifications on bind/unbind.

Code layout
===========

knod separates into a subsystem-neutral core and a GPU-specific
provider; nothing in the core knows about GPUs. Roughly:

  - core + control plane + NIC drivers   net/, kernel/bpf/       (~4.4k)
  - GPU provider (queues, JIT, shaders)  drivers/gpu/drm/amd/    (~39k)

The provider is the bulk of the diff, but most of it is self-contained
GPU code generation and hand-written shaders, not core logic. It lives
under amdkfd because that is where AMD GPU compute lives; the
load-bearing boundary is the accelerator interface, not amdkfd.

Usage
=====

The control plane is driven with the in-tree YNL CLI. Examples, run from
the kernel tree (ifindex is the NIC's ifindex, e.g. from `ip -j link`):

  SPEC=Documentation/netlink/specs/knod.yaml
  CLI="tools/net/ynl/pyynl/cli.py --spec $SPEC"

  # list accelerators (id, type, supported/enabled features)
  $CLI --dump accel-get

  # attach a NIC to accelerator 0
  $CLI --do attach --json '{"nic-ifindex": <ifindex>, "accel-id": 0}'

  # enable a feature on accelerator 0 ("none" | "bpf" | "ipsec")
  $CLI --do accel-set --json '{"id": 0, "feature-ena": "bpf"}'

  # show current NIC <-> accelerator bindings
  $CLI --dump dev-get

  # detach the NIC
  $CLI --do detach --json '{"nic-ifindex": <ifindex>}'

Attach/detach also emit notifications on the "mgmt" multicast group
(dev-add-ntf / dev-del-ntf), which the CLI can watch with
`--subscribe mgmt`.

Hardware
========

The reference GPUs are GCN (Radeon RX Vega64) and RDNA2 (Radeon RX 6600
and Radeon PRO V620). GCN does not implement the 64-bit atomics the
data path relies on, so active development targets RDNA2; all numbers
below are measured on RDNA2.

Performance
===========

The BPF path is measured with kondor, a katran-based L4 load balancer
running as the offloaded XDP program.

  Feature     GPU        Throughput   GPU power
  ---------   --------   ----------   -------------------
  BPF (XDP)   RX 6600     32 Mpps      41 W (100 W board)
  BPF (XDP)   V620        70 Mpps      80 W (300 W board)
  IPsec RX    RX 6600     80 Gbps     100 W
  IPsec RX    V620        80 Gbps     100 W

Host CPU utilization drops by roughly the cost of the XDP program or
the IPsec crypto that no longer runs on the CPU, offset by a small knod
bookkeeping overhead (SPSC ring management and packet delivery).

IPsec status
============

The IPsec feature is a functional proof of concept and should be read
as "this is possible on the framework", not as a production-ready
implementation. It is RX only (no TX offload) and supports both tunnel
and transport mode.

Development tree
================

Work continues in a public tree:

  https://github.com/TaeheeYoo/knod/tree/knod-7.2

Taehee Yoo (13):
  net: knod: add uapi and core headers
  net: devmem: extend memory provider for knod
  net: core: add XDP_MODE_HW offload hook for knod
  net: knod: add offload device core and control plane
  bpf: offload: allow PERCPU_ARRAY maps for offloaded programs
  drm/amdkfd: prepare kfd core for the knod provider
  drm/amdkfd: add knod provider core
  drm/amdkfd: add GPU instruction emitter and disassembler
  drm/amdkfd: add BPF-to-GPU JIT offload
  net/mlx5e: add knod XDP offload support
  bnxt_en: add knod XDP offload support
  selftests: drivers/net: add knod tests
  drm/amdkfd: add IPsec full-packet offload

 Documentation/netlink/specs/knod.yaml         |   176 +
 drivers/gpu/drm/amd/amdgpu/Makefile           |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |    13 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    65 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |     3 +
 drivers/gpu/drm/amd/amdkfd/Kconfig            |    31 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |     9 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |   117 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |    20 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |   112 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h       |     4 +
 drivers/gpu/drm/amd/amdkfd/kfd_hsa.h          |   451 +
 drivers/gpu/drm/amd/amdkfd/kfd_knod.c         |  2202 +++
 drivers/gpu/drm/amd/amdkfd/kfd_module.c       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |    34 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |    26 +-
 .../gpu/drm/amd/amdkfd/knod/aesgcm_shader.h   |   984 ++
 .../drm/amd/amdkfd/knod/ipsec_fused_gfx10.h   |  1796 +++
 .../drm/amd/amdkfd/knod/ipsec_fused_gfx9.h    |  1349 ++
 drivers/gpu/drm/amd/amdkfd/knod/kfd_knod.h    |   270 +
 drivers/gpu/drm/amd/amdkfd/knod/knod_amdgpu.h |   173 +
 .../drm/amd/amdkfd/knod/knod_amdgpu_insn.h    |  6362 +++++++++
 drivers/gpu/drm/amd/amdkfd/knod/knod_bpf.c    | 11554 ++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/knod/knod_bpf.h    |   597 +
 .../gpu/drm/amd/amdkfd/knod/knod_gfx10_insn.h |  3978 ++++++
 .../gpu/drm/amd/amdkfd/knod/knod_gfx9_insn.h  |  4068 ++++++
 drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.c  |  4273 ++++++
 drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.h  |   596 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   155 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |    12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   274 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |    12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |    10 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   351 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |    19 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |    38 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   107 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |    45 +
 include/net/devmem.h                          |    58 +
 include/net/knod.h                            |   467 +
 include/net/netmem.h                          |     9 +
 include/net/page_pool/memory_provider.h       |     4 +
 include/net/page_pool/types.h                 |    23 +-
 include/net/spsc_ring.h                       |   645 +
 include/uapi/linux/knod.h                     |    67 +
 kernel/bpf/offload.c                          |     3 +-
 net/Kconfig                                   |     2 +
 net/Makefile                                  |     1 +
 net/core/dev.c                                |     2 +-
 net/core/devmem.c                             |   103 +-
 net/core/devmem.h                             |     7 +-
 net/core/page_pool.c                          |    22 +-
 net/knod/Kconfig                              |     5 +
 net/knod/Makefile                             |     8 +
 net/knod/knod-nl-gen.c                        |   121 +
 net/knod/knod-nl-gen.h                        |    31 +
 net/knod/knod.h                               |    26 +
 net/knod/knod_core.c                          |  1231 ++
 net/knod/knod_nl.c                            |   406 +
 .../selftests/drivers/net/knod/Makefile       |    17 +
 .../testing/selftests/drivers/net/knod/config |     8 +
 .../selftests/drivers/net/knod/knod_attach.sh |   135 +
 .../drivers/net/knod/knod_xdp_ktime.sh        |   173 +
 .../drivers/net/knod/knod_xdp_loop.sh         |   129 +
 .../testing/selftests/drivers/net/knod/lib.sh |   181 +
 .../drivers/net/knod/xdp_ktime.bpf.c          |    32 +
 .../selftests/drivers/net/knod/xdp_loop.bpf.c |    42 +
 67 files changed, 44131 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/netlink/specs/knod.yaml
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_hsa.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_knod.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/aesgcm_shader.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx10.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/ipsec_fused_gfx9.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/kfd_knod.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_amdgpu.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_amdgpu_insn.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_bpf.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_bpf.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_gfx10_insn.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_gfx9_insn.h
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/knod/knod_ipsec.h
 create mode 100644 include/net/devmem.h
 create mode 100644 include/net/knod.h
 create mode 100644 include/net/spsc_ring.h
 create mode 100644 include/uapi/linux/knod.h
 create mode 100644 net/knod/Kconfig
 create mode 100644 net/knod/Makefile
 create mode 100644 net/knod/knod-nl-gen.c
 create mode 100644 net/knod/knod-nl-gen.h
 create mode 100644 net/knod/knod.h
 create mode 100644 net/knod/knod_core.c
 create mode 100644 net/knod/knod_nl.c
 create mode 100644 tools/testing/selftests/drivers/net/knod/Makefile
 create mode 100644 tools/testing/selftests/drivers/net/knod/config
 create mode 100755 tools/testing/selftests/drivers/net/knod/knod_attach.sh
 create mode 100755 tools/testing/selftests/drivers/net/knod/knod_xdp_ktime.sh
 create mode 100755 tools/testing/selftests/drivers/net/knod/knod_xdp_loop.sh
 create mode 100755 tools/testing/selftests/drivers/net/knod/lib.sh
 create mode 100644 tools/testing/selftests/drivers/net/knod/xdp_ktime.bpf.c
 create mode 100644 tools/testing/selftests/drivers/net/knod/xdp_loop.bpf.c


base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
-- 
2.43.0

