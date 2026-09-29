Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8903E7167;
	Tue, 29 Sep 2026 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670925; cv=none; b=ZbG2k7qCTOa0o2FtrwHGrODRyBHNyE+rrxJzDDD7HdOmPL5Z1Al/0aHFD8e69cpLoolXR/2+kXDQsQLuRM9ljrquj0wRMBdhwwfdG8Z97VC/lyvOM2Ka8Zhx5Ngo/VKNUH8U3nx6IbIBcXbpVMmrNjxKQX5GHzMm8OLEtbshUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670925; c=relaxed/simple;
	bh=qGPdiQJQKB9PlWeV98xyrwcxGvHm6WmMf4OnN5gLaQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YjWUztOFTchDbG+DEpZfFOgeHuQxdy/WG+k7fvn+0a6rPzlGUD1ZV8ZALg9FnQL2qFe7dzPvkvfwOKW+a+P/zFu1+6BN2W0aAl1UBkYFIi2n0Y3rjdGhzEWtk3mqO6D2FO8GZVh2mTDNIiAz99YXgkrhLO6imwt1y44R5Hophw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvBLV0Q5kzKHMc9;
	Tue, 29 Sep 2026 16:34:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E7B74057B;
	Tue, 29 Sep 2026 16:35:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBXdShEeLtqhxloCA--.42471S2;
	Tue, 29 Sep 2026 16:35:16 +0800 (CST)
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
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 0/5] riscv, bpf: Prepare for upcoming daily CI
Date: Tue, 29 Sep 2026 08:39:19 +0000
Message-Id: <20260929083924.1851840-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXdShEeLtqhxloCA--.42471S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4kZr4DAF17tFW8JF4xWFg_yoW8tFy5pa
	95Gr1jyr95Xr13tay293yUurW8XF4kCr13Cw1kGwn8AryqgFW0qFn2k3ySqF9xCryDXr4a
	yasIgrnY9w18ZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07j7l19UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

For some time, bpf selftests on riscv64 have suffered from several
silent breakages and test failures. These mainly stemmed from changes
such as riscv ftrace atomic patching [0], qemu pmu behavior changes, and
environment mismatches. While some issues have already been addressed in
previous patches [1-3], the remaining ones are handled in this series.

To catch regressions promptly and close this long-standing riscv bpf CI
gap, the riscv-bpf-daily project [4] is introduced here. With the
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
[4] https://github.com/pulehui/riscv-bpf-daily

Kumar Kartikeya Dwivedi (1):
  bpf, riscv: Fix stack-passed arguments for indirect trampolines

Pu Lehui (4):
  selftests/bpf: Set CONFIG_HZ_100 for riscv64
  selftests/bpf: Use /tmp for temporary file in d_path
  selftests/bpf: Update qemu config for riscv64 in vmtest.sh
  selftests/bpf: Update DENYLIST.riscv64

 arch/riscv/net/bpf_jit_comp64.c                 | 14 ++++++++++----
 tools/testing/selftests/bpf/DENYLIST.riscv64    |  2 ++
 tools/testing/selftests/bpf/config.riscv64      |  1 +
 tools/testing/selftests/bpf/prog_tests/d_path.c |  2 +-
 tools/testing/selftests/bpf/vmtest.sh           |  4 ++--
 5 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.34.1

