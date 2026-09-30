Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2248CD7F
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764986; cv=none; b=pMNpftfswtRMyPANcIDwkb+p6//Vcohsy0eVw4tXFtDBxYykcmiDU10CJjrZjRXPzxyuYvuYq5li0BSOxcNfsJVnc9kJVFRHgN7WKUd3fwfSIKXzxXx26SBXY/BGIm8CBHK6TI7LT/EpS/HMgC6FKH4RUrX/iZ0TWZATzHQYoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764986; c=relaxed/simple;
	bh=soFI/8w1oGqLIedwGHhtHwuwn9kpTW6DxOdhNgm1g+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WijtSLR4CrHErSv2aDSB6CdSkFO9U64JMFN1tAA9DpbsADOtCvU6SPMZpmtXBvfFoqV1Tx86YKbTf6dnpSETkVKyk0dZgCHedWn6AzS2/eyiOvoj7TgZte2MBGfOYZPkXyqzbG7qteb88wrH7aZrvkedHdThVgddmqFM0hAkABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvs7B67RNzKHMh7
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 18:42:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0C9BA40888
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 18:42:52 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBHZCeq57xqgX_xCA--.57102S2;
	Wed, 30 Sep 2026 18:42:51 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] MAINTAINERS: Add myself as co-maintainer of riscv bpf
Date: Wed, 30 Sep 2026 10:46:59 +0000
Message-Id: <20260930104659.1919027-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHZCeq57xqgX_xCA--.57102S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrAr17XF1fKr1rXr48Crg_yoW8AF43pa
	15Gw15C34kWr1xAr4rGF1jqayrA3WkG3y5CrZrW3s8AFn3Kw10gr10ka1Uua109FWrur4S
	yry3Xr1vyaykAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Over the years, I have been actively involved in the development and
have proactively taken on maintenance responsibilities for the RV64 JIT,
covering the related bpf core, riscv architecture, and selftests/CI
infrastructure. With the continuous growth of riscv bpf features and
testing workload, adding a co-maintainer helps share the review burden
and ensure timely patch handling.

As for the RV32 JIT, there has been a lack of active maintainer response
for several years, leaving incoming patches occasionally stalled. Active
maintenance is needed to review incoming patches and ensure issues are
addressed in a timely manner.

Therefore, I would like to request taking on the co-maintainer role for
both the RV64 and RV32 JITs. For me, being a maintainer is both an honor
and a responsibility, and it also makes it easier for me to participate
in riscv bpf work, where I look forward to dedicating more time and
effort.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eafcbbd78..c27119500152 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4872,6 +4872,7 @@ F:	arch/powerpc/net/
 BPF JIT for RISC-V (32-bit)
 M:	Luke Nelson <luke.r.nels@gmail.com>
 M:	Xi Wang <xi.wang@gmail.com>
+M:	Pu Lehui <pulehui@huawei.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/
@@ -4879,7 +4880,7 @@ X:	arch/riscv/net/bpf_jit_comp64.c
 
 BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn@kernel.org>
-R:	Pu Lehui <pulehui@huawei.com>
+M:	Pu Lehui <pulehui@huawei.com>
 R:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.34.1

