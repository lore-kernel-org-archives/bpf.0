Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A8435508;
	Wed, 30 Sep 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750733; cv=none; b=nn0YQWnFkAtAfnZ5Z0F3HhaRDsTXuY+xv2PLnRZDKuZYdftKpE3ZApEh//XJgkx3rGK3EvDySU3Ru2sSm3N6IbCo+vAnETqEu+w0Zo1y++m381hifCuyHN4+0H7XB/qsEoqXrf1hn8Zhq4OC4u9E2s+0gXu2P5ADrWJb1q5n9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750733; c=relaxed/simple;
	bh=JpwzgBSw1PBmi5MvhRzQ7k1ghpi7N2xgJdPLNa/FU3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xt9HFLRaKJN4ejM6m87ErV1X6fDvFSmMSdJXF9xTkQ+SyxECR7jShUuLikNnorYlTh/ea5DShiA7UxI1t4bGD1gERfYk4zj6vi4X+DhKBeY/3VoDJjuPUlblPglZTRxdqg24S0FLMDI3eBv/Bb5qqk8vRsJm7SwaK/xrj8kG5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvls735qczKHMTK;
	Wed, 30 Sep 2026 14:44:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5765F40574;
	Wed, 30 Sep 2026 14:45:20 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgD3xSj_r7xqrobcCA--.8426S2;
	Wed, 30 Sep 2026 14:45:20 +0800 (CST)
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
Subject: [RESEND PATCH bpf-next 0/2] riscv, bpf: Support indirect calls to bpf subprogs (callx)
Date: Wed, 30 Sep 2026 06:49:26 +0000
Message-Id: <20260930064928.1909085-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3xSj_r7xqrobcCA--.8426S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWDArWfJF47Aw4rZr48Crg_yoWfXwbEk3
	9YqF97ta93AFsFya17Cwn5WFyUCw4aqry7KF12qFyayw1rWr45GF4vy34Yqry8Zay5Xa9I
	vr4Duay0kr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjTRRBT5DUUUU
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

