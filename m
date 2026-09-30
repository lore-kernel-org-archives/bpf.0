Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69E46A60D;
	Wed, 30 Sep 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757087; cv=none; b=YfY/WvUOUW9jhUz7jDapPwqGp8H2s17aHsz3yRElKPpFlYKF0ZOag6Ua0bBJllsIuSHBTIGt9eO/bDP3Yyc65yH7YjjFH1cuO364NXi+PNto7kw1O2PiUyrPsnOQDgzVRa+Dz+5RND9S4hCDMoxvgRoXkDqXspcC7Y+gMAMfaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757087; c=relaxed/simple;
	bh=Km2xZkmkLKBW4ecZ5V90FNwDATFDvl5jlAwZuYRFCZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YrSzRX2Sq3NlNGJhbkejSVfv/EG0/OKm+apmhOem3rpZdi2fdtiWG0hpf9WE9NXDH1oLo18HPsaFelN3t8/hktrJrx3RNwhMcI+wkxKb0JU2i5opiuLbjHjqp9w95B9jc2fXdYr7dKlnpLEZKdRvLCXuyBFK+pWIFvU2YrNPbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hvpCP3MMYzKHMc1;
	Wed, 30 Sep 2026 16:30:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 805A840574;
	Wed, 30 Sep 2026 16:31:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyrRyLxq8dflCA--.24306S6;
	Wed, 30 Sep 2026 16:31:18 +0800 (CST)
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Update DENYLIST.riscv64
Date: Wed, 30 Sep 2026 08:35:22 +0000
Message-Id: <20260930083522.1914145-5-pulehui@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXpyrRyLxq8dflCA--.24306S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17WrykZFy7tw4DZF4ktFb_yoW8Wr1DpF
	ZIgw1Yk3s5XF4avr1xGrWDGFWFvrWkZFWfJw48Xry3ArsrtFW7uan2gayftrn3urWUW34a
	yF1Iy345uryDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Both probe_user and stacktrace_build_id fail on riscv64 due to riscv64's
trap-based kprobe handling.

For probe_user, kprobes on riscv64 are handled via traps where the entry
path invokes irqentry_nmi_enter(). Because bpf_probe_write_user()
rejects execution in NMI context, the test fails. Upstream discussions
regarding NMI semantics on riscv are ongoing [0] and will be tracked.

For stacktrace_build_id, under the kprobe trap context with interrupts
disabled, bpf_get_stackid() obtains a valid build_id, but the queued
irq_work is deferred. As a result, subsequent bpf_get_stack() fails to
acquire mmap_read_trylock() and falls back to BPF_STACK_BUILD_ID_IP,
causing an inconsistency between the two results.

Since stacktrace_build_id is already included in the generic DENYLIST,
only add probe_user to DENYLIST.riscv64.

Link: https://lore.kernel.org/linux-riscv/20230702025708.784106-1-guoren@kernel.org [0]
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.riscv64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
index ca1beae7fe8f..75a9690fb2f2 100644
--- a/tools/testing/selftests/bpf/DENYLIST.riscv64
+++ b/tools/testing/selftests/bpf/DENYLIST.riscv64
@@ -1,2 +1,3 @@
 # riscv64 deny list for BPF CI and local vmtest
 exceptions					# JIT does not support exceptions
+probe_user					# kprobe hit in trap
-- 
2.34.1

