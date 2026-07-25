Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B1B33A9C1;
	Sat, 25 Jul 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994293; cv=none; b=M0621Ue/NT6ysKDr6NkI6jve4heC0j/2p47Q2vkUGNbmaBAllEBhMDlJ+o7ZP+hyNc3CJG2goQAwAMgNpoaHBS8wZi+ZGmwNhs1f5Rbgt4SH+dLymrqClLdWc0rg+kkXvq8PQcIwp/tp4qjI+tY0tyHKJfaj38IACQpP1RGh5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994293; c=relaxed/simple;
	bh=kb5QUEIo2bft06iuoF17ty44R5IaizQ29kr/u+WwYgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N0+KyvNf/2d3ikiWav3nOAKMoegehsQXWge8oucdOz0YO6j0694ZRUGeGbfFTK+vb9Y9SpLdlE3eem7SWWGJDuHkPUafhYCFf2vJG4fiiHKfkuE0PtXTZ3/dmR/me4+3GymKBWq3eY+PDJ2zT8zG83diWZvLu+U0SPCzvkAlIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6q09380wzKHMZQ;
	Sat, 25 Jul 2026 23:43:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3757F4058F;
	Sat, 25 Jul 2026 23:44:42 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXpXHo2WRqLfYVCg--.46096S2;
	Sat, 25 Jul 2026 23:44:41 +0800 (CST)
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
	Huacai Chen <chenhuacai@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 0/9] Fixes for bpf_jit_free
Date: Sat, 25 Jul 2026 15:49:06 +0000
Message-Id: <20260725154915.2488611-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXpXHo2WRqLfYVCg--.46096S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1fXw1xCrW7urykKFWDtwb_yoW8Ww1xpr
	s5Ar13Cr1vgr92qws3J3W0qF15tw4rWw17WrW7W3yrJ3Z0qFyUZr1fCw15C398try8tay5
	XFy3Kry5C34kX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Fixes for bpf_jit_free identified by Sashiko, as previously noted in [0].

Link: https://lore.kernel.org/bpf/28ba19a4-b487-49fd-bbba-04410acdb113@iogearbox.net/ [0]

v3:
- Add fix for private stack leak on arm64. (Sashiko)
- Some minor fixes.

v2: https://lore.kernel.org/bpf/20260725102020.2287770-1-pulehui@huaweicloud.com
- Fix JITs not freeing leftover jit_data when jit_subprogs() aborts. (Sashiko)
- Drop fix for loongarch as it's applied.

v1: https://lore.kernel.org/bpf/20260722112754.1615201-1-pulehui@huaweicloud.com


Pu Lehui (9):
  bpf: Extract the bpf_jit_binary_hdr helper
  s390/bpf: Fix memory leak in bpf_jit_free
  parisc: Fix memory leak in bpf_jit_free
  bpf, sparc64: Fix memory leak in bpf_jit_free
  ARC, bpf: Fix memory leak in bpf_jit_free
  bpf, arm64: Fix memory leak in bpf_jit_free
  bpf, arm64: Fix private stack leak when JIT failed
  riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free
  bpf: Fix double-free RO header in bpf_jit_free

 arch/arc/net/bpf_jit_core.c      | 19 +++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c    |  6 +++---
 arch/loongarch/net/bpf_jit.c     |  6 ++----
 arch/parisc/net/bpf_jit_core.c   | 19 +++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp.c  |  5 +++--
 arch/riscv/net/bpf_jit_core.c    |  8 +++-----
 arch/s390/net/bpf_jit_comp.c     | 19 +++++++++++++++++++
 arch/sparc/net/bpf_jit_comp_64.c | 19 +++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c      |  7 ++-----
 include/linux/filter.h           |  2 ++
 kernel/bpf/core.c                | 19 ++++++++++---------
 11 files changed, 101 insertions(+), 28 deletions(-)

-- 
2.34.1

