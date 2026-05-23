Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92992383C9E;
	Sat, 23 May 2026 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528061; cv=none; b=coeufE+UGwVOgJb4okNGT3o7ndsOZIxJXXUVH1gQpRvhoL7+2UlCfZIHvEd780qCHwmaQnatbrQkpJsVCH5P//G7QV81V8RXMjh4i+1Iiq1aIu/7zyavqGH1XdzHCA5M3G7IkpF7Qy4+ciq+T2yGhSxt3o2renvKckwt20CxCr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528061; c=relaxed/simple;
	bh=clADxap8fJ1/jtqI+Wdzl38IMkRH37PAjp3q7ys8TO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbIiv8BOOr1YDAFy4WQEz5pzhUM9z+gOievAUex4HzJrwMX7SxxBnbX/WzIVYayncmkZNZQiIlAa/YiHBVtGD3idFWmUNt2h4qBqc1QJJHoLFE8D6+Su6jEXUJoSCnA8GZlnL9cLftRq9XEBF3IMWpzY5napyfeLGmNndA3NmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gMxT33SNkzKHMbr;
	Sat, 23 May 2026 17:20:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D2234056B;
	Sat, 23 May 2026 17:20:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgC3flpscRFqWE9VDQ--.41561S2;
	Sat, 23 May 2026 17:20:45 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf 0/2] Add return value check for BPF_LSM_CGROUP
Date: Sat, 23 May 2026 08:58:04 +0000
Message-ID: <20260523085806.417723-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3flpscRFqWE9VDQ--.41561S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWkZw4xJr1xAr1fCr4rZrb_yoW3GFg_uF
	yxZrykGrn7u3W8AFyqga1fZFWUJa1rtFyxZa4UtrsIkr1UWw12vr1rGr9xXr9rAF4kJw4D
	JFy3ua4fKw1YvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

Quan Sun reported a NULL pointer dereference caused by invalid return value of
BPF_LSM_CGROUP program [1].

The cause is that the BPF_LSM_CGROUP programs use bpf_set_retval() helper to
set return value for the target LSM hook, and the value is not validated,
making any arbitrary value legally accepted.

To fix it, add return value check for BPF_LSM_CGROUP programs. 

[1] https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn

Xu Kuohai (2):
  bpf: Add return value check for BPF_LSM_CGROUP
  selftests/bpf: Add return value tests for lsm cgroup

 kernel/bpf/verifier.c                         | 10 +++++
 .../selftests/bpf/progs/verifier_lsm.c        | 45 +++++++++++++++++++
 2 files changed, 55 insertions(+)

-- 
2.43.0

