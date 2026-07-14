Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95B381AE4;
	Tue, 14 Jul 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996841; cv=none; b=ZxhawpX6Uw8PMaCO30GxJ/vUfq9dIsiyF6MIDonGHZlvfPOFZbwDYY00zXLzNHf/nUbTMLYI9FJqJLWY8zKKFJxWxukKdomDrQ3Ls6kMSbIolbDqGDP/WRML/dO5PtogDdm/CSBoFIqPjHujX0dqZMYcZb/stXoXApopc6gmbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996841; c=relaxed/simple;
	bh=P/hPB5zOzjpnfJ4d4ovzckvuxlEqk6oCdtGLSbJzvj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Op87sFDbO6DOO/pD6FfE5IhEA7kIbZYiUZOiUULcrg5D6AJYebG/xOaDNMKLia3/sPi1EWRqozqqmlijMshhI2nSUXLdlWffiWbMW8UNoyX370PZMqHkDfGAUTvk8e8ufPzqkZQm+tJlMO9W+c8wkf5gAqjGmlLtIs0XE3lVKXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzk7B0TJzzYQtjX;
	Tue, 14 Jul 2026 10:40:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9FACB4058F;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgC3xXGioVVq8TueBA--.48464S2;
	Tue, 14 Jul 2026 10:40:36 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/2] Reject callback subprogs invoke tailcall
Date: Tue, 14 Jul 2026 02:44:57 +0000
Message-Id: <20260714024459.420075-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC3xXGioVVq8TueBA--.48464S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1DXF4Utw4UJr45Gw4rXwb_yoWDZFgEva
	13tF98Xrn7CFnIkFWUCF4rZrWUC3yDWryxJF4UtFW7Gr4xXr15Zan7ZrZ5Wr95tFyFq39x
	Jrs5Aay8tw4I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Some JIT compilers, such as x86_64, rely on a register to pass the TCC.
When subprograms of synchronous callback invoke tailcall, C helpers
invoking bpf callback clobber this register, and the corrupted TCC may
bypass the TCC limit, leading to infinite tailcall.

Fix this by rejecting tailcall inside all subprogs of sync callback.
This also cleanly consolidates the existing async and exception callback
checks into a single unified `is_cb` check.

v2:
- remove redantant testcase.
- Add ACK tag by Eduard.

v1: https://lore.kernel.org/bpf/20260711104727.4023420-1-pulehui@huaweicloud.com

Pu Lehui (2):
  bpf: Reject callback subprogs invoke tailcall
  selftests/bpf: Add testcase for callback with tailcall

 kernel/bpf/verifier.c                         |  8 +--
 .../selftests/bpf/prog_tests/tailcalls.c      |  7 +++
 .../bpf/progs/tailcall_bpf2bpf_callback.c     | 62 +++++++++++++++++++
 3 files changed, 71 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_callback.c

-- 
2.34.1

