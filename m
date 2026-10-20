Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504164;
	b=UHDPAmikwm36giTQOTX+IooUHjwwubIB3xT/L9/8Nsv0/e6nhZPs+GtD8ZqVY5vUydZ1
	 ARmzy9TBSWC4F+MeaD1/zWhUQAlJ04VsvYA8WEQY5oLcKojvto/PV9DPEeRSPJhs+J2Jp
	 96BSvIYqzsCjJxJ/ubpL2W2P41fIn6oGO9khJMaUbZ34u2+/uho1Jy9KARB6SQpFJVh44
	 FRP6a3s2bC8VgxmA73PG98WPbIScFDfpie13IwjSdLG+srV4GFGm25lM4EebsZOgI3J2o
	 WNeLZ8Uh+aKoVulAWolhRHJjbk57X1gzw6fr48lKoitmOD8OHyUQwcQr3htZifvTWPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504164;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Vn8Ztz//w7NbknoA+iaa0rZfASeliaKwL9N6AWdgSLw=;
	b=hFkSy1d9fyRCryyQtzsoDApbDuDYb9ozTwjkuS9wSQ68dLzHzrtjB5wAb9it606mfFP0
	 wPYgTjqN7d2t62+T/hHI1ahUdEt4Tp+oUXtq4msrUDP0dHSbIrFmQz0oHvMs555eW4S7U
	 bqAgz0DBEvcd5BeSbtItfeR69Xf8O95LwjeJ6BbqDCAchF+XzO8jeHFRntaCpaHYK4Uia
	 8p8hsAMH5wXmCvwd3mBXOfq9gnyF5JjwwkwYlnRTfWjE8LdGGLxRrF8k+12tBHptN1Z8G
	 GSaE4wV9/i1PcWUde1lztvKgGelAaXctbkBx94frj5F064n5bAKj0OUAinKfXR+Bmzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E1606AB3C;
	Tue, 20 Oct 2026 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B5E1606AB3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKm6xCbzYQtrf;
	Tue, 20 Oct 2026 21:49:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EF4E240570;
	Tue, 20 Oct 2026 21:49:18 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S2;
	Tue, 20 Oct 2026 21:49:18 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 00/16] Add percpu variable support for bpf arena
Date: Tue, 20 Oct 2026 13:22:45 +0000
Message-ID: <cover.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1kKr48JFWkCF1fGr1ftFb_yoW7Gry5pw
	4fWry3tr4DXrs3uw1Duw4xArWfurs5Xw1ftw1xKFyrZw15ZrW7JrWIk3WrZF9xGryfXr1F
	vayjgrnrKa4UZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To use percpu data in a bpf arena today, we need to define an array
sized to the maximum possible cpu number, like the cpu_ctxs array
defined in tools/sched_ext/scx_qmap.h. This is not a convenient
pattern. It lacks performance and scalability, and wastes memory.

Inspired by [1], this series introduces percpu variables for the
arena. The basic idea is to use a separate ELF section to collect the
percpu variables declared in the program. At load time, a separate
chunk is created for each cpu, and the initial data from the ELF
section is copied to each cpu's chunk. Every chunk is page aligned,
and is populated on the target cpu's NUMA node at creation time.

To declare a percpu variable in the arena, a bpf prog declares the
variable with the __arena_percpu macro:

__u64 __arena_percpu hits;

The macro tells the compiler to collect the variable into the
dedicated ELF section. The variable itself is read or written by the
bpf prog as a normal variable. At run time, its address is mapped by
the JIT to the address of the replica on the running cpu.

User space sees the same data through its arena mapping and can
address any cpu's copy directly:

total += *bpf_map__arena_percpu_ptr(arena, &skel->arena_percpu->hits, cpu);

Cross cpu access is only allowed for user space. A bpf prog can only
read or write the replica of the running cpu. The other replicas are
not visible to the bpf prog.

# arena layout

When the global arena data sits at the end of the arena, the percpu chunks
are placed right before it:

+------------+---------+---------+----+---------+--------+
|            | percpu  | percpu  |... | percpu  | global |
|            | chunk 0 | chunk 1 |    | chunk N | data   |
+------------+---------+---------+----+---------+--------+

Otherwise, the global data stays at the start of the arena, and the
percpu chunks are placed right after it:

+---------+---------+---------+----+---------+------------+
| global  | percpu  | percpu  |... | percpu  |            |
| data    | chunk 0 | chunk 1 |    | chunk N |            |
+---------+---------+---------+----+---------+------------+

Any kernel that supports arena percpu variables is new enough to
accept these offsets, so in practice the first layout is the one in
use.

A chunk is created for every possible cpu, so N + 1 is the number of
possible cpus on the system.

# pseudo instruction

A pseudo instruction is introduced for arena percpu variables. The
normal ld_imm64 instruction that references an arena percpu variable
is rewritten to the pseudo instruction by libbpf at relocation time.
The pseudo instruction carries the symbol offset in the arena, and
the verifier checks the offset to make sure it is inside cpu 0's
chunk. The pseudo instruction is JITed to compute the actual address
in the running cpu's replica, using:

dst_reg = address in chunk 0 + chunk_size * smp_processor_id()

[1] https://lore.kernel.org/bpf/20260813152324.97937-1-leon.hwang@linux.dev/

Xu Kuohai (16):
  libbpf: Collect arena percpu data section
  libbpf: Create arena percpu chunk from the arena percpu ELF section
  libbpf: Place the percpu chunks in the bpf arena
  libbpf: Copy the percpu chunks into the bpf arena
  libbpf: Add the arena percpu chunk attribute to map creation options
  libbpf: Relocate arena percpu access instructions
  libbpf: Add arena percpu feature probe
  bpf: Extend syscall to accept arena percpu information
  bpf: Teach verifier about arena percpu instructions
  bpf, x86: Add support for arena percpu
  bpf, arm64: Add support for arena percpu
  libbpf: Introduce arena percpu helpers for user space
  bpftool: Emit the arena percpu datasec into skeleton
  selftests/bpf: Add test for arena percpu-only object
  selftests/bpf: Add test for mixed arena percpu object
  selftests/bpf: Add test for arena percpu bounds

 arch/arm64/net/bpf_jit_comp.c                 |  51 ++-
 arch/x86/net/bpf_jit_comp.c                   |  33 ++
 include/linux/bpf.h                           |   5 +-
 include/linux/filter.h                        |   1 +
 include/uapi/linux/bpf.h                      |  17 +
 kernel/bpf/arena.c                            |  43 ++-
 kernel/bpf/core.c                             |  22 +-
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  69 +++-
 tools/bpf/bpftool/gen.c                       |  69 +++-
 tools/include/uapi/linux/bpf.h                |  17 +
 tools/lib/bpf/bpf.c                           |   4 +-
 tools/lib/bpf/bpf.h                           |   4 +
 tools/lib/bpf/features.c                      |  50 +++
 tools/lib/bpf/libbpf.c                        | 248 +++++++++++-
 tools/lib/bpf/libbpf.h                        |  33 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../bpf/libarena/include/bpf_arena_common.h   |   2 +
 .../selftests/bpf/prog_tests/arena_percpu.c   | 361 ++++++++++++++++++
 .../selftests/bpf/progs/arena_percpu_mixed.c  |  29 ++
 .../selftests/bpf/progs/arena_percpu_only.c   |  21 +
 22 files changed, 1054 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_percpu.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_percpu_mixed.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_percpu_only.c

-- 
2.47.3

