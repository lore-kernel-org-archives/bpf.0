Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EC3BCD29;
	Sat, 11 Jul 2026 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766597; cv=none; b=nw+JGs3+tE2Tzy4hxh+fnGE/uBzzAWOhvjr758zXe/aGYe/e0Vk4j4XpqUh/4reCejfjdjnNz1pWsn1rI5uev7aDTXQPGpBWi0+lStcUiI6z8L0vNysVfTs0emJORQ4Ig2NmnfAYo9rmQ98ZC9WEw3l65Vi8taehsqyU3QnaK/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766597; c=relaxed/simple;
	bh=7PaEPzsPK0tyoPk/llApkUjVzWsGCS2PWZyjVj7GdiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rHy6NqXesnL9JTm6yxI+gkHpA4XgvcgfjsXiJ5Z3bENIS9QWI5au8NmKbbP3RvhhHtirXIkxlIaczC/Rent7GmVVeZkaCLwEVwDqfV9sWaiaSaJxt7Ek1NOMmTaQi1fQQH8pvIGZCvK5azFSK4wpVa4dOJCN1n/jHqN40zs2HEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gy4z43brhzKHM09;
	Sat, 11 Jul 2026 18:42:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 32BE8407C9;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHIm84HlJqX_VcAw--.36025S2;
	Sat, 11 Jul 2026 18:43:06 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/2] Reject callback subprogs invoke tailcall
Date: Sat, 11 Jul 2026 10:47:25 +0000
Message-Id: <20260711104727.4023420-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHIm84HlJqX_VcAw--.36025S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1DXF4Utw4UJr45Gw4rXwb_yoWfWrXEvw
	45tFyDXrnxCFnrAFyUCF4rZrWkC3yUury7JF4UtFW7Jw4xXr15ZFWkZrZ5uryktFy2q39x
	Jrs8Aayxtw4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Some JIT compilers, such as x86_64, rely on a register to pass the TCC.
When subprograms of synchronous callback invoke tailcall, C helpers
invoking bpf callback clobber this register, and the corrupted TCC may
bypass the TCC limit, leading to infinite tailcall.

Fix this by rejecting tailcall inside all subprogs of sync callback.
This also cleanly consolidates the existing async and exception callback
checks into a single unified `is_cb` check.

Pu Lehui (2):
  bpf: Reject callback subprogs invoke tailcall
  selftests/bpf: Add testcases for callback with tailcall

 kernel/bpf/verifier.c                         |   8 +-
 .../selftests/bpf/prog_tests/tailcalls.c      |   7 +
 .../selftests/bpf/progs/tailcall_callback.c   | 129 ++++++++++++++++++
 3 files changed, 138 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_callback.c

-- 
2.34.1

