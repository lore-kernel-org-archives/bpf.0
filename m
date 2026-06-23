Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E693D3D1B
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216174; cv=none; b=uVMiIMC2TQWS7drKxIwSul6tcWtpkM0dFJMWTTr2aRWW4e3qHMlVVB4+oqNNvCCqDlEq62sdbuTYuCaHcQBDjn7x+kLwHGoDC/AReKNYjxEF9Q9CGCuzSqWaNE2uoKL9MJNBA0ntgtYW1wd3hwfS7cLF/J7fCyEKMrFAJ/yeOP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216174; c=relaxed/simple;
	bh=xmr+R1rvtEOWOsYwhP+mV+swZE+If5+5wzq2QUV6UnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPttvVDu7cZFGt0k6QWYuYdQfwj4AWdfezYs3+iPAro4qUicxkAckFXjXZiULwOKunmHZtQJ8goBJlz9Ar2KbQGfAQNnUsGVM0UdkzMldcrWL2LegB6dOsjvRm2xZILDTxJuOK3gQR65vq+D0moYWNxRa3PG+FhkOOUGUD4iF+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.57.97])
	by mtasvr (Coremail) with SMTP id _____wCnJezkdTpqcHz9Ag--.11690S3;
	Tue, 23 Jun 2026 20:02:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.162.57.97])
	by mail-app3 (Coremail) with SMTP id zS_KCgBHMnfidTpqNvtzAg--.9662S2;
	Tue, 23 Jun 2026 20:02:42 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 0/2] bpf: support shift operations with non-const source operand
Date: Tue, 23 Jun 2026 20:02:16 +0800
Message-ID: <20260623120218.25869-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgBHMnfidTpqNvtzAg--.9662S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?hy4prQXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083jO/wNhIP+pglnkLd0BnOsdS609x3IKM8nbvtgZitABFuSTPoR9AjU77qrwcC8Gua9b+
	CqmHexTAZ3NJI7fvXhHN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFW7JFWxZFyfWFyxKw47Jrc_yoWDXFXEk3
	yft34DWFyUWFZ0qa4IgF4S9a45CrsrKFnIyFWjqF9rZw1DZrWUWFs2qF93Xas0v3WkWrs3
	JFnIv3sYyrsrZosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwrWrDUUUU

Add support for BPF shift operations (BPF_LSH, BPF_RSH, BPF_ARSH)
when the source operand is not a constant.

---

v2 => v3:
- Make comments in scalar32_min_max_arsh and scalar_min_max_arsh
  more concise.
- Change the variable name: umin/umax -> min_shift/max_shift.
- Add tests for non-const src shift operations:
  1. overflow for lsh, rsh and arsh
  2. positive, negative and mixed range dst for arsh

v2: https://lore.kernel.org/bpf/20260612121041.25254-1-ziye@zju.edu.cn/

v1 => v2:
- Fix incorrect comments in scalar32_min_max_arsh and scalar_min_max_arsh.

v1: https://lore.kernel.org/bpf/20260612093818.18609-1-ziye@zju.edu.cn/

Tianci Cao (2):
  bpf: support shift operations with non-const src operand
  selftests/bpf: Add tests for non-const src shift with bounded dst

 kernel/bpf/verifier.c                         |  99 ++++++++---
 .../selftests/bpf/progs/verifier_bounds.c     | 167 ++++++++++++++++++
 2 files changed, 241 insertions(+), 25 deletions(-)

-- 
2.43.0

