Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDC46AECF;
	Wed, 30 Sep 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757087; cv=none; b=riMmIs3WclOkszpIbUyGkR+xBxrbx+YGbQjAfQ6RAgdrAFH56OZETv++ZQ+vBV5HujEsSRfubgUyU7cy5JJ2ndlxuAJXdIRyxv7QBy3lNCr2ffmsuv/rCt78PwS1DCEKE66rKSQG6NxtvL4/UZHyMetWq6ONHzNxeMeUy3aLwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757087; c=relaxed/simple;
	bh=hSs7lsm7Q/JsMSfWG3M4hW2vvBimz+9bN/Yg9cGjgAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAp3v3ERwlwXSiGVoAhXd7eXWYUTCo4jaV+9QQeNs6UBfFwp1SJXqZwhtcjQTxBOFOX3WXLvpXcQXYAvfAGoW3Eu0pYlm9JERyUiQB1zu5xIef6ObLaHKmlgbu7rnjtFCd+iPrUbhK0Z3gA9An70Qy/1qncmjGMreFKDOkpsk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hvpCX6tkzzYQtyy;
	Wed, 30 Sep 2026 16:30:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 969494056D;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyrRyLxq8dflCA--.24306S4;
	Wed, 30 Sep 2026 16:31:17 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Avoid jiffies quantization error in setget_sockopt
Date: Wed, 30 Sep 2026 08:35:20 +0000
Message-Id: <20260930083522.1914145-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930083522.1914145-1-pulehui@huaweicloud.com>
References: <20260930083522.1914145-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXpyrRyLxq8dflCA--.24306S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8KFykWw4DZFWDtrWUJwb_yoW8ZFy5pF
	4rta45Kw4kuF1xZ39rJFyagFy5Kws3GrW8AFyfJr4kA34xGF1vqry2yr43K3W3uay3Xr9Y
	v34vqr1Yv3WDXa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRipB-tUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The setget_sockopt selftest fails on kernels with HZ=250 (such as the
default on riscv64), specifically in the TCP_BPF_DELACK_MAX and
TCP_BPF_RTO_MIN sub-tests.

The test sets a socket option value in microseconds via bpf_setsockopt()
and immediately reads it back via bpf_getsockopt() to verify that it
matches. However, the kernel converts the value to jiffies internally
for storage and converts it back to microseconds upon retrieval. When
HZ=250 (4000 us per jiffy), 30000 us cannot be divided evenly:

  usecs_to_jiffies(30000) -> 8 jiffies
  jiffies_to_usecs(8)     -> 32000 us (!= 30000 us)

This mismatch triggers an assertion failure.

Change the test value from 30000 to 40000. 40000 us divides evenly
across common kernel timer frequencies (HZ=100, HZ=250, and HZ=1000),
avoiding quantization errors and making the test robust across different
architectures.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index d96e99b67aeb..95e6a337ab71 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,8 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
-	{ .opt = TCP_BPF_DELACK_MAX, .new = 30000, .expected = 30000, },
-	{ .opt = TCP_BPF_RTO_MIN, .new = 30000, .expected = 30000, },
+	{ .opt = TCP_BPF_DELACK_MAX, .new = 40000, .expected = 40000, },
+	{ .opt = TCP_BPF_RTO_MIN, .new = 40000, .expected = 40000, },
 	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
-- 
2.34.1

