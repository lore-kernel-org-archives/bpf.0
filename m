Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537960;
	b=wXOrVBcO65zT3JcTdzGD9pipf1YzTL85UwrUx/iH1zlm4HRYV/fLoEDBjovxc0gIUhBH
	 rRCicZrlziaF7rm4xGuFg8UK36eKhM18ZUp5Zy7g5fPq2zJy7eYHpElzDnEdpgX+Dx5v4
	 y+FGS0SsvpKHzPbt3pHmJc8+qFTYWKqBnwxQtzyT7qk1bf7pWrcxNINpCg9j8sJbLnuvS
	 uOAh+jfvmeSStuQcyUFqGxQkBoJKedbb1Y3wcvXKaTAimNk8IiRQX7D7xZjrDK04hbj+z
	 I4yBm0WB7npHPy+xMz3j6YmAlGgQidNHZgznNs+qhiPUUE35yJjcyYkIEtMd+8YAlEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537960;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Grc4RaTtr7sxFjwCU2M3bNK9HqyEG1Agf8KoIn28fyU=;
	b=randSqMMRHehVfYJuCxNSFma1ODr+I02Z2jm+us+73MMLyYaCmJeFiZWINcGNkhV5U/C
	 9u75Pq3BZv3aO/5e3tkj2EBBR6uXOgDcsjZGBhWA0CvRr0KiIebs2Dra3c6P02HYN4wUZ
	 orBIPRFQobMKX8lMn7EKeqjhTw5+kZ59N7Yj8NdGIfTNU8SCarrtyugmdDigE5vxzpY56
	 XDKE0QbJTvPMjyEoX0dihoizz1AseJBUrUJ91IoWQPgJIUI30LofBVRq+YIyL0LVstGnE
	 9d9RlCVKvfyqnO3O1HvewBnAx8Ylta/TuogwTMSM5FU3TD+mBTSN+8PIt5sQrGd4mSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smail.nju.edu.cn;
	spf=pass smtp.mailfrom=smail.nju.edu.cn;
	dkim=pass header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=Q8bfY4+l;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23133606A32A;
	Fri, 13 Nov 2026 02:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23133606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.a=rsa-sha256 header.s=iohv2404 header.b=Q8bfY4+l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1794537909;
	bh=Grc4RaTtr7sxFjwCU2M3bNK9HqyEG1Agf8KoIn28fyU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Q8bfY4+lhZQ027A32t3yH72RQ4YEVol9z3z/hnlb3kfvqUU80JTRm97bS8K5fkqUg
	 Sy9QHL2/PAuuomhuHOxNXwVa4zIzwrH/qo2RFmeVyCK9iqK+DMUKluEIAjZcSFRsdX
	 5cbVd9vzM71K1dmuMT9qwSdZKkMJtSpgtIwSaeB8=
X-QQ-mid: zesmtpip3t1794537903t31bc6a9b
X-QQ-Originating-IP: Dss3OIyHQufrU6DxWq/SRtgZ6ekhwUmlBjwaknWgAoM=
Received: from workstation-Precision-7920-Towe ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Nov 2026 10:45:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2940849686373519213
From: Kang Chen <k.chen@smail.nju.edu.cn>
To: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Test that a drained task_vma iterator keeps returning NULL
Date: Fri, 13 Nov 2026 10:45:00 +0800
Message-Id: <20261113024500.922824-2-k.chen@smail.nju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113024500.922824-1-k.chen@smail.nju.edu.cn>
References: <20261113024500.922824-1-k.chen@smail.nju.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MSstRF5C1p/jw4kh0Y21FyaU1F5v1HINJJD9sDTaeAHUEbuS/THfhn+q
	OpuumD/IlW6NA819oEsUjwurqJ4FehQbPksqVYhYgjTQSSVrNL0bjWMSkixhyJdTToZb22V
	nZHkrezrLyokwLH62lWQG4HR/zKB3frRUE6RrEVb+M1ZfzWZPrK/v9cgHE5bXuder+rfEnx
	LGRMyEvLzqiMOx+Aln2qspsECQjx+eYGtBFJVIbmSIGzNNNkM9c1sCBMtqTEoiudzrI9NbU
	OQoatyKslmZSxc+39+z9zG9ApwUcanWTAZhbkgnVQFU/Ma1KXDd8+mCwxtuPaIlb0CR5PVe
	H1vXIsdxi72yVWWYX+vUkQD87mZKgm1/ussWH9i+hUQ33R560IWj3bUhZMa3M2GhM8k/m3J
	sdIGvKW14Ads6BSKrb2PdercxeHC3LLe5xP17y76RaWCL6RNhZiXpgbyOnaUv3vZVhbgJwz
	oXpsMkGACziv9CA7ksTqkuNER1HjRpMw8c3I5OH2vUVE3H7woc3+kLzzX6VOB2oKUX0IfQX
	eNFQcRDMfdc7pH7Ly7VwUlITW7ShEFjVqmwyUcDS6yrM2adRwI3JZ7qMBmIY6qUivwfyqau
	pNlamVx61gH9cTiiFKgd1xAkNG/10LLgCoiMqkBdJH4wK0OXpilEBavpuRMNZSwA1kY4ryH
	bKEAgEaJ38xHZ7ifZgp+FCDHT3eMdsqZVGIdVDf9R+R51Q7e0j3Myllmmkijoj522fZ3z+z
	cuP3wZui/zGownqF/1jUNDjjOD6T5jJpLhT4OKIM9/6pfWZL0EEEZLjeiJOmdk7dxfKGL2E
	ZFRIMtBpeh/shhRy483jtVpiMyTjU7utPhxM7awYMofsF/TLgrKiJkTDDSVeRKKP4qI/OO6
	GX7bLSA/IElFo6yUpGRsk0LweamVvwzV5SyBCq3IswXB1VBLF4bC16wASQeT5AQCUuw7UYl
	J25V+iVZrCcpGRs+1on1oTkXMhBqemWeyucgSlUAF4ptda2VPwZCm9btr/as/ZnEMFEI3cG
	2T8X9Epo81ZPAFl2WEeZAteyBDB421jaoqf6TkvMRBkKZ6DMmDO/KhVO1w2/I=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Add a syscall program that walks the current task's VMAs, records the
last vm_end, drains the iterator and lets a user-space thread map a new
VMA at that address.  The program waits in bpf_loop() until the mapping
is ready, then calls bpf_iter_task_vma_next() once more and stores the
raw result.

The user-space test checks that bpf_iter_task_vma_new() succeeded, that
at least one VMA was drained, that the mapper ran (go_seen), and that
the extra next() returned NULL.  The new VMA makes the test fail on a
kernel without the drain state: the iterator would return the new VMA
again.

Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
---
 .../selftests/bpf/prog_tests/task_vma_iter.c  | 89 +++++++++++++++++++
 .../selftests/bpf/progs/task_vma_iter.c       | 53 +++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_vma_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_vma_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_vma_iter.c b/tools/testing/selftests/bpf/prog_tests/task_vma_iter.c
new file mode 100644
index 000000000000..bb9feb840a27
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_vma_iter.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <pthread.h>
+#include <sched.h>
+#include <sys/mman.h>
+#include "task_vma_iter.skel.h"
+
+struct map_ctx {
+	struct task_vma_iter *skel;
+	void *addr;
+	int err;
+};
+
+static void *map_new_vma(void *arg)
+{
+	struct map_ctx *ctx = arg;
+	struct task_vma_iter *skel = ctx->skel;
+	void *addr;
+
+	while (!__atomic_load_n(&skel->bss->drain_done, __ATOMIC_RELAXED))
+		sched_yield();
+
+	if (!skel->bss->new_ret) {
+		addr = (void *)(unsigned long)skel->bss->last_end;
+		ctx->addr = mmap(addr, getpagesize(), PROT_READ | PROT_WRITE,
+				 MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED_NOREPLACE,
+				 -1, 0);
+		if (ctx->addr == MAP_FAILED)
+			ctx->err = errno;
+	}
+
+	__atomic_store_n(&skel->bss->go, 1, __ATOMIC_RELEASE);
+	return NULL;
+}
+
+static void test_task_vma_iter_next_after_drain(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct task_vma_iter *skel;
+	struct map_ctx ctx;
+	pthread_t thread;
+	int err, fd;
+
+	skel = task_vma_iter__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "task_vma_iter__open_and_load"))
+		return;
+
+	ctx.skel = skel;
+	ctx.addr = NULL;
+	ctx.err = 0;
+
+	if (!ASSERT_OK(pthread_create(&thread, NULL, map_new_vma, &ctx),
+		       "pthread_create"))
+		goto out;
+
+	fd = bpf_program__fd(skel->progs.iter_task_vma_next_after_drain);
+	err = bpf_prog_test_run_opts(fd, &topts);
+	if (err) {
+		/* Release the mapper if the program never ran. */
+		skel->bss->new_ret = -1;
+		__atomic_store_n(&skel->bss->drain_done, 1, __ATOMIC_RELEASE);
+		__atomic_store_n(&skel->bss->go, 1, __ATOMIC_RELEASE);
+	}
+	pthread_join(thread, NULL);
+
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		goto out;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		goto out;
+
+	ASSERT_OK(ctx.err, "mmap new VMA");
+	ASSERT_OK(skel->bss->new_ret, "new_ret");
+	ASSERT_GT(skel->bss->vma_count, 0, "vma_count");
+	ASSERT_EQ(skel->bss->go_seen, 1, "go_seen");
+	/* last_end is set, so a restarted walk would find the new VMA */
+	ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
+
+out:
+	if (ctx.addr && ctx.addr != MAP_FAILED)
+		munmap(ctx.addr, getpagesize());
+	task_vma_iter__destroy(skel);
+}
+
+void test_task_vma_iter(void)
+{
+	if (test__start_subtest("next_after_drain"))
+		test_task_vma_iter_next_after_drain();
+}
diff --git a/tools/testing/selftests/bpf/progs/task_vma_iter.c b/tools/testing/selftests/bpf/progs/task_vma_iter.c
new file mode 100644
index 000000000000..9159aa7fc48e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_vma_iter.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include "bpf_experimental.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Result of a bpf_iter_task_vma_next() call after the iterator was drained */
+__u64 next_after_drain = -1;
+__u64 last_end;
+__u64 drain_done;
+__u64 go;
+int new_ret;
+int go_seen;
+__u64 vma_count;
+
+static long wait_for_go(u32 index, void *ctx)
+{
+	return go ? 1 : 0;
+}
+
+SEC("syscall")
+int iter_task_vma_next_after_drain(const void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma it;
+	struct vm_area_struct *vma;
+
+	new_ret = bpf_iter_task_vma_new(&it, task, 0);
+	if (new_ret) {
+		drain_done = 1;
+		go = 1;
+		goto out;
+	}
+
+	while ((vma = bpf_iter_task_vma_next(&it))) {
+		vma_count++;
+		last_end = vma->vm_end;
+	}
+
+	/* Let user space map a new VMA at last_end before the extra next(). */
+	drain_done = 1;
+	bpf_loop(1000000, wait_for_go, NULL, 0);
+	go_seen = go;
+
+	/* Store the raw value; the verifier would remove a branch on it */
+	next_after_drain = (__u64)bpf_iter_task_vma_next(&it);
+
+out:
+	/* The destructor is called even when the constructor failed. */
+	bpf_iter_task_vma_destroy(&it);
+	return 0;
+}
-- 
2.34.1

