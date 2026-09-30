Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E87E341ADD;
	Wed, 30 Sep 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757089; cv=none; b=uOMLvSBeRaXvNIZllNQO5VkBii7BBay0NImz7bRsoykWABL2ubKelTORa76ZgyzvLhM+KFf/9uwdV95KyjQ0JTjCDpAltQU9kyItLkJi4ktCOsNiDiDOMEuIoDeKzW6wFVTNt0P/zd9rGtvbezXRv1aLuB1Qzcf+EheaDt3H1WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757089; c=relaxed/simple;
	bh=gUb34fs6wqHqGoeJQwZq2pZDXwYl369jj/nVD0Mg0fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=me6Egr+jjl5ZpTT1/Xundzw/FHo/DUtQmXY2UH09QKNJ8j4u+UjrVLa8z7fZB03Lkfdxskguw/t5MiHcjMqWD9iGFVy+NXSVWvE0SMrpIzS6NdhdvFQ5/YATz68RFP/vTCZA9SGeFptkPIIaWZbCrLQyWRv35QesPQPkZi6mP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvpCX5g5tzYQtwH;
	Wed, 30 Sep 2026 16:30:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6884D4056F;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyrRyLxq8dflCA--.24306S2;
	Wed, 30 Sep 2026 16:31:15 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/4] riscv, bpf: Prepare for upcoming daily CI
Date: Wed, 30 Sep 2026 08:35:18 +0000
Message-Id: <20260930083522.1914145-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXpyrRyLxq8dflCA--.24306S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4ruw4kKFy8XFWUZFy8Grg_yoW5Xr4UpF
	Z5Cr15ur95Wr1aq39Fk3y7ZFW0gr4kCr13Cw18Ww15ZrZ0gFy0qrn29rWYqFZxCFyDW3ya
	ya4agrnY9w18ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7sRidbbtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

For some time, bpf selftests on riscv64 have suffered from several
silent breakages and test failures. These mainly stemmed from changes
such as riscv ftrace atomic patching [0], qemu pmu behavior changes, and
environment mismatches. While some issues have already been addressed in
previous patches [1-3] and some are in progress [4], the remaining ones
are handled in this series.

To catch regressions promptly and close this long-standing riscv bpf CI
gap, the riscv-bpf-daily project [5] is introduced here. With the
assistance of LLMs, putting together this automated workflow was fairly
straightforward. The pipeline pulls the latest bpf-next branch daily,
executes both test_progs and test_verifier, and automatically creates
github issues with brief failure descriptions and sends notifications
when failures occur. It has been running smoothly for over a week and
has already proven its value by catching some real jit bugs.

To pave the way for riscv-bpf-daily, this patchset addresses the
remaining fixes, test adaptations, and environment dependencies.

[0] https://lore.kernel.org/all/20250407180838.42877-5-andybnac@gmail.com/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2820d227ad4e
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f2aaa6215910
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7e617552938
[4] https://lore.kernel.org/bpf/20260722140015.1982158-1-varunrmallya@gmail.com
[5] https://github.com/pulehui/riscv-bpf-daily

v3:
- Update comment in vmtest.sh about qemu.

v2: https://lore.kernel.org/bpf/20260930064607.1908864-1-pulehui@huaweicloud.com
- Change test value in setget_sockopt to avoid quantization error.
- Drop path modify in d_path testcase as will mount /dev/shm in rootfs.

v1: https://lore.kernel.org/bpf/20260929083924.1851840-1-pulehui@huaweicloud.com

Kumar Kartikeya Dwivedi (1):
  bpf, riscv: Fix stack-passed arguments for indirect trampolines

Pu Lehui (3):
  selftests/bpf: Avoid jiffies quantization error in setget_sockopt
  selftests/bpf: Update qemu config for riscv64 in vmtest.sh
  selftests/bpf: Update DENYLIST.riscv64

 arch/riscv/net/bpf_jit_comp64.c                    | 14 ++++++++++----
 tools/testing/selftests/bpf/DENYLIST.riscv64       |  1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c |  4 ++--
 tools/testing/selftests/bpf/vmtest.sh              |  6 +++---
 4 files changed, 16 insertions(+), 9 deletions(-)

-- 
2.34.1

