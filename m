Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F8B41D651;
	Thu, 16 Jul 2026 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203064; cv=none; b=rsjwDBMt350BS7VFEBa9mXUEu4OQfeJjXOgXCFTJcMjToP1GTRenXNn8ZXNumoYJqlEaNA/SsD0SJxLQDQ0z0KsLMaVPUDPD0iSxBMeceRCaJ+fTXOt7/5zo4UEMUtLvKaMTg8feh18oHqAoYnzb4b3sNdtT5G1RVBWDT9RzSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203064; c=relaxed/simple;
	bh=Mgv1FTh+js0Gq/7VL7h0wzNpDtA2yvRbwEycmfzhnCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=doJTTDzO21xqbByRaXImFFeNWBHoe5umjHw0VJQaxUFAcRTtqHpCgYqkIjFhjZOKfhND9vMnAITUY/2dcQ4JsAQY5e50mcEDguKQep/04j9fKtsjlsdApl2xR4fhAp4Hi+lSIi/XTylSxGgg4YcESzcOYDr5VRo63ZxTfvxxjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h1BNn4KhmzYQtt8;
	Thu, 16 Jul 2026 19:57:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 479FE40592;
	Thu, 16 Jul 2026 19:57:32 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3x3Mqx1hqeWi+BQ--.49322S2;
	Thu, 16 Jul 2026 19:57:32 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v3 0/3] Fixes for tailcall with subprog and callback
Date: Thu, 16 Jul 2026 12:01:54 +0000
Message-Id: <20260716120157.835937-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3x3Mqx1hqeWi+BQ--.49322S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4UAw4UAw4xZFyUtw4ktFb_yoWkJrc_A3
	yYqryDtrsxAF9Fka18Cr1rCryjk3yUW348JF4UtF97Gw4xXw1kuan3Wr43urnYqF95ZrZ3
	ta1DArW0qw4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This series fix two issues related to tailcall:

patch 1: Fix tail_call_reachable state leak across call branches.
patch 2: Reject callback subprogs invoke tailcall.
patch 3: testcases for patch 1 and 2.

v3:
- Fix tail_call_reachable state leak across call branches. (Sashiko)
- Add testcase for the above issue.

v2:
https://lore.kernel.org/bpf/20260714024459.420075-1-pulehui@huaweicloud.com
- Remove redantant testcase.
- Add ACK tag by Eduard.

v1:
https://lore.kernel.org/bpf/20260711104727.4023420-1-pulehui@huaweicloud.com

Pu Lehui (3):
  bpf: Sync tail_call_reachable with callee state on entry
  bpf: Reject callback subprogs invoke tailcall
  selftests/bpf: Add testcases for callback with tailcall

 kernel/bpf/verifier.c                         | 12 +--
 .../selftests/bpf/prog_tests/tailcalls.c      |  7 ++
 .../selftests/bpf/progs/tailcall_callback.c   | 81 +++++++++++++++++++
 3 files changed, 92 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_callback.c

-- 
2.34.1

