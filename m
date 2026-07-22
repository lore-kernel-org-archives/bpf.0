Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DAF4C9012;
	Wed, 22 Jul 2026 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719410; cv=none; b=h/7pIWWPUfHNnMeR926Err8YuLTZxcW9tXIdvylTcteXiIQN7CYb8xKc2hnV0nu1QvEASqtQW8v9y76m1cEP1SOx/qKypUt6k2UnRdccwx9Nds7BtSGlA8/Odq/Sn4p1KQ/pwSfefiEsXT5yObWxT8z+LAM9o/YHKXzkKIzbQVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719410; c=relaxed/simple;
	bh=tK39drdYwJ+jtw6Cx6R3NVE5HRnd5/ANiJQ0Ax9aP6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DaPzG9Kc/G4ORKSencQ51+yOEIIMkZvlImQAfJpcoxt/V4Hm4sMTHbeRZaV/Vxh5/ZbG9tPZAIOYYm+EY3S5G1gPnnp+HcNwbE9Ejz2juxASZdwwnSmzYgwk6+9K4GsV2m93nthLDSAwpV4VDitIx0crknYX6/i3wDBj1Tzv6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4sLR3wnCzYQtsd;
	Wed, 22 Jul 2026 19:22:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 792A34056F;
	Wed, 22 Jul 2026 19:23:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3qVorqGBqllacCA--.32600S2;
	Wed, 22 Jul 2026 19:23:24 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/4] Fixes for bpf_jit_free
Date: Wed, 22 Jul 2026 11:27:50 +0000
Message-Id: <20260722112754.1615201-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3qVorqGBqllacCA--.32600S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtryxuryktw4rAFWkZFW5Wrg_yoW3GFb_K3
	47XFyxJwn5Xw4jyr4qyr45ArnrKr95KF1rur1SgFyjvr98ZF15JFWxtryIg34DXr1kKrZ8
	Z3s7Ar97Xa1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIda
	VFxhVjvjDU0xZFpf9x0pRHUDLUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Fixes for bpf_jit_free identified by Sashiko, as previously noted in [0].

Link: https://lore.kernel.org/bpf/28ba19a4-b487-49fd-bbba-04410acdb113@iogearbox.net/ [0]

Pu Lehui (4):
  bpf, arm64: Fix memory leak in bpf_jit_free
  LoongArch: BPF: Fix memory leak in bpf_jit_free
  riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
  bpf: Fix double-free RO header in bpf_jit_free

 arch/arm64/net/bpf_jit_comp.c   | 3 ++-
 arch/loongarch/net/bpf_jit.c    | 3 ++-
 arch/powerpc/net/bpf_jit_comp.c | 4 +++-
 arch/riscv/net/bpf_jit_core.c   | 3 ++-
 arch/x86/net/bpf_jit_comp.c     | 2 +-
 kernel/bpf/core.c               | 5 ++---
 6 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.34.1

