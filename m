Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C914D09F0;
	Tue, 29 Sep 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671855; cv=none; b=ZCKWJg90ZZtwhMZudoYrl1luQbeIL0P7KD/0bOCwwWB+63D8O7EM5OjkWYFq0t7HdEgNT5EFhTwOKyeKkldpYqQCq8aqmGwe1hcFZoVLAmiYg6lxwWx+2TlfUvHeF1kTbAEfTpbWsxn/aKtKrkeSw8I71XjSbt/g/r3xkt5AuCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671855; c=relaxed/simple;
	bh=JpwzgBSw1PBmi5MvhRzQ7k1ghpi7N2xgJdPLNa/FU3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gO5gm1Upk9xVu3uNCNlsAi3QCv+4JecL1q9NKuiqAmoKfgDzCKxoJ80lcp2XOub6eyNiYy8iy2Hr0obgA8HcoEEop53zHw9ISj2IMz6QuFf8oWv5MdjAK8x+1kz3W1EpOP+8nWolqMZqlkSjgCPTB0pf37iOF010LvxDid0hthg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvBhH3n7FzKHMdT;
	Tue, 29 Sep 2026 16:50:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E8AAD40576;
	Tue, 29 Sep 2026 16:50:42 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDn_iHie7tqgXJpCA--.48809S2;
	Tue, 29 Sep 2026 16:50:42 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/2] riscv, bpf: Support indirect calls to bpf subprogs (callx)
Date: Tue, 29 Sep 2026 08:54:48 +0000
Message-Id: <20260929085450.1852617-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDn_iHie7tqgXJpCA--.48809S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDArWfJF47Aw4rZr48Crg_yoWfXwbEk3
	9YqF97ta93AFsFya17Cwn5WFyUCw4aqry7KF12qFyayw1rWr45GF4vy34Yqry8Zay5Xa9I
	vr4Duay0kr4agjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRiSdgUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This series implements support for indirect calls to bpf subprogs on
riscv64 and enables the corresponding selftests.

Meanwhile, this series also resolves the test_verifier failures
previously captured by riscv-bpf-daily due to missing callx support [0].

[0] https://github.com/pulehui/riscv-bpf-daily/issues/11

Pu Lehui (2):
  riscv, bpf: Support indirect calls to bpf subprogs (callx)
  selftests/bpf: Enable callx related testcases for RV64

 arch/riscv/net/bpf_jit_comp64.c                      | 12 ++++++++++++
 .../selftests/bpf/prog_tests/callx_func_ptr_map.c    |  3 ++-
 .../selftests/bpf/prog_tests/callx_rodata_lskel.c    |  3 ++-
 tools/testing/selftests/bpf/progs/verifier_callx.c   |  3 ++-
 .../selftests/bpf/progs/verifier_callx_rodata.c      |  3 ++-
 5 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.34.1

