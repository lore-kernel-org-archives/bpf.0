Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D36394463;
	Mon, 20 Jul 2026 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517992; cv=none; b=O5uRq5b76SPNcOYhuhtw7DaHG4QEVn6l4vcQEEeuQWEZoI82PdGSrx+oWz3KEbfMDcnmQI4zywKePjy9jTteiXLjdkjJXCc9NFEZ/UgTKEtGsmqOcvqLfjsIXmvs75vlzyCSGuvC/vFf4MVgvR1uUDM/DG8CcAegguj3G+TSVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517992; c=relaxed/simple;
	bh=5s0AKzBmbwPd66DHoWMps/FgJsNxsxNck15MqocqU7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sAqVqeaSiQRYeAwo8pmCwNNaf0ut0hu1uBd8VRD+BIpQvCa6fTsbvoZa2w1alnBTzsfO7fTbPSIdtJEBJLv+MdvIfyXZQykIwu/xF3YpaFjUanYglMfc2+q3wDYOmk+6EyZ9+hEbeMddjXqeeApzdYUu7T3q+80gBKmYwpEB1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3Qs61JChzYQv3B;
	Mon, 20 Jul 2026 11:26:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 204D84056D;
	Mon, 20 Jul 2026 11:26:27 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXMm9hlV1q56Z3Bw--.11895S2;
	Mon, 20 Jul 2026 11:26:26 +0800 (CST)
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
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v3 0/3] Fixes for bpf link update
Date: Mon, 20 Jul 2026 03:30:52 +0000
Message-Id: <20260720033055.1215477-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXMm9hlV1q56Z3Bw--.11895S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryrtr1UZrWkKrWfXFW7twb_yoWDuwcEk3
	4fJryrtw4kGan8Wa48trsxJryUKrWUZryrG3W8trZ7ArnrZrn3Wrs5Jry3ZFs8A3ZYqr98
	tr98Zr1xJFnxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
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

From: Pu Lehui <pulehui@huawei.com>

patch 1: fix for UAF issue when reading bpf link info.
patch 2: fix for storage not restored when update_effective_progs failed.
patch 3: Fix storage null-ptr-deref after replacing prog in cgrp_bpf.

v3:
- Add new fix for UAF issue when reading bpf link info. (Sashiko)
- Add new fix for storage not restored when update_effective_progs
  failed. (Sashiko)

v2:
https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweicloud.com
- Fix invalid access for in-place update when storage changed. (Sashiko)

v1:
https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com

Pu Lehui (3):
  bpf: Fix potential UAF when reading bpf link info
  bpf, cgroup: Fix storage not restored when update_effective_progs
    failed
  bpf, cgroup: Fix storage null-ptr-deref after replacing prog

 kernel/bpf/cgroup.c  | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c | 27 +++++++++++++++++++++++----
 2 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.34.1

