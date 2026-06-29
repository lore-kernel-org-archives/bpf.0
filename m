Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5D33260D;
	Mon, 29 Jun 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741406; cv=none; b=H9+RQlhGBh8BoKzhrnpciO6ivaanmms0U2qnLCktY+X8VvmqR6WrISXAbOxHPunKSkSJoo/g7eEtgKxlMMRXQGhbsVew0mpEbw4McH4S4D1zXhczjM2CCjPgmjVoExwlAJmYMDTsVXrZJRXf0PyzSi9mhoOVslhs8XiI+/MdIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741406; c=relaxed/simple;
	bh=BWWjH4RfhEeBD2gQymRxkx6ZPGBW2rTPixUYWoUOTcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q6Y3yUvtTYXKpcg+ZtcqM1bu/uElnWbvz7MW4dd6KFFHaI4qWW/j24QklOAWaJyHi+ogjW87D69XK2Bgvbr32MRXBUbDE+CbFozlNpjpzdUec5tdhVEREiEwoY4JJ70vE5BaBG+/m/UJ6V5OSDTISLjdpPoa0xntDQiQYvNySwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpnrH1yy0zKHMdW;
	Mon, 29 Jun 2026 21:56:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B917740596;
	Mon, 29 Jun 2026 21:56:37 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCXBfOUeUJqDlQCAQ--.44260S2;
	Mon, 29 Jun 2026 21:56:37 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v4 0/6] Mixing bpf2bpf and tailcalls for RV64
Date: Mon, 29 Jun 2026 14:00:42 +0000
Message-Id: <20260629140048.733346-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXBfOUeUJqDlQCAQ--.44260S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kKFyrCF4DGF15ZFWrKrg_yoW8KF1Upa
	yfuF13Gryvgr1xAw4xta18Xa4rCF4S93W7Cr17tw1rAa1F9FyvgF1xKa1Fqas8AFZa934Y
	vr1YqF45C3y8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

In the current RV64 JIT, if we just don't initialize the TCC in subprog,
the TCC can be propagated from the parent process to the subprocess, but
the updated TCC of the parent process cannot be restored when the
subprocess exits. Since the RV64 TCC is initialized before saving the
callee saved registers into the stack, we cannot use the callee saved
register to pass the TCC, otherwise the original value of the callee
saved register will be destroyed. So we implemented mixing bpf2bpf and
tailcalls similar to x86_64, i.e. using a non-callee saved register to
transfer the TCC between functions, and saving that register to the
stack to protect the TCC value. As for the tailcall hierarchy issue,
inspired by the s390's low-overhead approach, we store TCC from
RV_REG_TCC back to stack after calling bpf2bpf call or calling orig bpf
func in bpf trampoline.

In addition, some code cleans are also attached to this patchset.

Tests test_bpf.ko and test_verifier have passed, as well as the relative
testcases of test_progs*.

v4:
- Fix tailcall hierarchy issue.
- use is_struct_ops_tramp helper in bpf trampoline

v3: https://lore.kernel.org/bpf/20240201083351.943121-1-pulehui@huaweicloud.com
- Remove duplicate RV_REG_TCC load in epiloguei. (Björn Töpel)

v2: https://lore.kernel.org/bpf/20240130040958.230673-1-pulehui@huaweicloud.com
- Fix emit restore RV_REG_TCC double times when `flags &
  BPF_TRAMP_F_CALL_ORIG`
- Use bpf_is_subprog helper

v1: https://lore.kernel.org/bpf/20230919035711.3297256-1-pulehui@huaweicloud.com

Pu Lehui (6):
  bpf: Extract the is_struct_ops_tramp helper
  riscv, bpf: Remove redundant ctx->offset initialization
  riscv, bpf: Using kvzalloc_objs to allocate cache buffer
  riscv, bpf: Add RV_TAILCALL_OFFSET macro to format tailcall offset
  riscv, bpf: Mixing bpf2bpf and tailcalls
  selftests/bpf: Remove tailcalls tests from DENYLIST.riscv64

 arch/arm64/net/bpf_jit_comp.c                |   6 -
 arch/loongarch/net/bpf_jit.c                 |   2 +-
 arch/riscv/net/bpf_jit.h                     |   1 +
 arch/riscv/net/bpf_jit_comp64.c              | 120 +++++++++----------
 arch/riscv/net/bpf_jit_core.c                |   9 +-
 include/linux/bpf.h                          |   6 +
 tools/testing/selftests/bpf/DENYLIST.riscv64 |   1 -
 7 files changed, 68 insertions(+), 77 deletions(-)

-- 
2.34.1

