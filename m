Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305D395AF8;
	Sat, 27 Jun 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571974; cv=none; b=RHNoQxqwkpS3FvvWoRDb1JLMSlWVoQ9cEzDEsj4dYHvhNPuXIC1EoixH122icoAbbL75U46RlaD+xuNkL+exELpBCDIiHpPVluEIpBpRnpdtKLPs9pGhfms7c6Ri3p0MrVQYQL9ey8zcTMYFAGP5U8vAhPY8XcMxKRBsaPw/Czk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571974; c=relaxed/simple;
	bh=GaiExgbJnn/2M6Nk+fslgCgm/r9PthpmmceZ1nVVoPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofLtPLK5icAz/CdzRlpsl9z8KTlRdX1TeaIGOuOLwpqemdxhSsO1xYWFQ1OnMXTgYyuJkp5fNL6U393G4IfDWmY0/OSwyX18WE4R166ZwREeIxiAkvQgpC1urW0V9B0R52W3bVYwgeLe/mcgmJojSj5zgWwdoDvayb7CXi8Qhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gnb9B5sfqzYQtKM;
	Sat, 27 Jun 2026 22:51:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9A5FF4056E;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S2;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 00/12] bpf: Introduce static-defined tracing probe for BPF
Date: Sat, 27 Jun 2026 22:51:34 +0000
Message-ID: <cover.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kAFyxCw1fXw18tF1rXrb_yoWrZw48pa
	1kWr98Cr4kXa1Ska4xJay8uryFyw4kWrWUCF1fJryjv3W5X3yxtr1IgrWavryakryFkw1r
	Zr1a9ryFk347Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUIhSdDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

This series introduces static-defined tracing probes for BPF programs.
BPF SDT (static-defined tracing) works similarly to USDT. User defines
probes in the BPF source code. The probes are built into NOP instructions
in the ELF. At runtime, when an observer is attached, the NOP instruction
is patched to a CALL instruction to the observer prog trampoline.

Unlike USDT, BPF SDT requires explicit macros to generate the function
prototype BTF for each probe. This allows the verifier to validate the
probe sites against the declared types, and observer programs can be
attached similarly to normal tracing programs using the function prototype
information.

A probe with two arguments in the target program can be declared and defined
like:

    BPF_SDT_DECLARE2(my_trace, int, int);

    SEC("xdp")
    int xdp_prog(struct xdp_md *ctx)
    {
        int len = ctx->data_end - ctx->data;
        int ret = XDP_DROP;
        ...
        BPF_SDT_PROBE2(my_trace, len, ret);
        ...
    }

An observer would be like:

    SEC("bpf_sdt")
    int BPF_PROG(observer_prog, int len, int ret)
    {
        bpf_printk("len=%d ret=%d\n", len, ret);
        return 0;
    }

The target program and probe site for the observer program should be set
at load time via bpf_program__set_attach_target() manually, since program
names are not unique and program IDs are allocated at runtime - there is
no static way to identify the target program.

For BPF_SDT_DECLARE2(my_trace, int, int) and BPF_SDT_PROBE2(my_trace, len, ret)
macros, the compiler produces:

  [code section, e.g. xdp]
      goto +0                  // NOP, patched to CALL at attach time

  [.bpf_sdt_notes section]
      ___sdt_jt_my_trace:      // symbol marking this entry's boundary
      .quad  0b                // 8 bytes: offset of the NOP in the code
                               // section (resolved by the linker via
                               // R_BPF_64_ABS64 relocation)
      r1 = %[arg1_reg]         // 8 bytes per argument: BPF move insn
                               // whose src_reg field encodes the BPF
                               // register holding each probe argument
      r2 = %[arg2_reg]

      ....

  [.BTF section]
      FUNC_PROTO (int, int) -> void   // from BPF_SDT_DECLARE2 stub
      DECL_TAG "bpf_sdt:my_trace:2"   // keyed by name + nargs

The .BTF and .bpf_sdt_notes sections are parsed by libbpf and ultimately
converted to an insn_array map per bpf program. Each map slot records the
instruction offset, jited address, FUNC_PROTO BTF ID, and argument register
for each probe site.

When an observer prog is loaded, the probe is resolved against the target
program's SDT map using the target fd and probe name passed by the user.

For attach, the existing bpf trampoline is reused with per-argument register
mappings declared by the SDT macro.

Xu Kuohai (12):
  libbpf: Prepare bpf SDT probe section for the linker
  libbpf: Introduce bpf SDT probe macros
  libbpf: Add bpf_sdt_notes section parser
  bpf: Create insn_array map for bpf SDT probe
  bpf: Collect SDT probe BTF IDs from BTF decl tags
  bpf: Add type check for SDT probe site
  bpf: Record probe name in SDT map
  libbpf: Add libbpf support to load SDT observer program
  bpf: Add kernel support to load SDT observer program
  bpf: Support attach and detach for SDT observer program
  bpf, x86: Add JIT support SDT for probe
  selftests/bpf: Add tests for bpf SDT probe

 arch/x86/net/bpf_jit_comp.c                   |  38 +-
 include/linux/bpf.h                           |  26 +-
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   3 +
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  21 +-
 kernel/bpf/bpf_insn_array.c                   |  64 ++-
 kernel/bpf/cfg.c                              |   3 +
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/fixups.c                           |   4 +
 kernel/bpf/liveness.c                         |  24 +-
 kernel/bpf/syscall.c                          | 163 +++++-
 kernel/bpf/trampoline.c                       |   4 +
 kernel/bpf/verifier.c                         | 174 +++++-
 tools/include/uapi/linux/bpf.h                |  21 +-
 tools/lib/bpf/Makefile                        |   2 +-
 tools/lib/bpf/bpf.c                           |  10 +-
 tools/lib/bpf/bpf.h                           |   9 +-
 tools/lib/bpf/bpf_sdt.h                       | 346 ++++++++++++
 tools/lib/bpf/libbpf.c                        | 513 +++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h               |   1 +
 tools/lib/bpf/linker.c                        |   9 +
 .../selftests/bpf/prog_tests/test_bpf_sdt.c   | 151 ++++++
 .../selftests/bpf/progs/bpf_sdt_observer.c    |  30 +
 .../selftests/bpf/progs/bpf_sdt_target.c      |  34 ++
 25 files changed, 1622 insertions(+), 35 deletions(-)
 create mode 100644 tools/lib/bpf/bpf_sdt.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_sdt.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_observer.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_sdt_target.c

-- 
2.47.3

