Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260E16F288
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928164; cv=none; b=qPMCJPao8gkir9wYr1XDibujgTkWpAYj4PHgXnsYTo6ZtDMHoURVB+nkCQ3JFwLVW3s7umDAY9uP1eRvJddDEUXLARojt5XzJeCMxdH24PZTHL9zAf/4mMqpG+QcqiuCzSk2tYEBYSYh9kvmpJyDeKKNBc+a4vIRgJfZKnnA/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928164; c=relaxed/simple;
	bh=Ed48g+5AC3GxF0EcCRigYpcR11fxdtnkv7jZM5ahyns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrbCj4ZEX02BS5v65mo6a965vtOW/f+Wabr7fXTVnMpvQfpzjCMSzcmc9YP3HpozlZ8HU7JKgrrGInuO82DqmMlehsxMT6B+hiLq8A4j4t+T2bq2XIxRG9KFy+H8JSljNh6+WAwHCgIVGw3cMYxvIxUylIyxAQZlDHcqYUUri/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=ljhTStTE; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ljhTStTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=WZ75AQXmF3znIA8aj1Zc0n/2XTw2DIkS5W
	jxzEGcxgQ=; b=ljhTStTEbN+6yKEo5AociDf1nYnX8hefxoIQmZNOASYGaQ2gbD
	CIHQkDhXDmHkQPpdvffViljwvThTp2B86r/V0klht0OzOoGKBNOfZ3jJPZhUK6jL
	CL3fW1X25QZKCWMFIZOAU45/ka0/AKWKUidfc2T0h5UAhVGKfpH1YAfDs=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHRSyZ4KBqNz_5AA--.330S2;
	Wed, 09 Sep 2026 12:29:13 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf 2/2] selftests/bpf: Reject task VMA snapshot use after destroy
Date: Wed,  9 Sep 2026 12:29:07 +0800
Message-ID: <20260909042907.1734153-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn>
References: <20260909042907.1734153-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBHRSyZ4KBqNz_5AA--.330S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xtrW5uw1xKw13ur4Durg_yoW5JrWxpa
	n7C3sIkr4fJa13KF97Jr4Du3Wagan5Za45G34vy3Z8Cr4vyw48WF1rtr4YvF1rArW0qFnI
	vrWIkanxGr48JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8tUUUUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add a verifier test that obtains a task VMA snapshot, destroys its
iterator, and then attempts to read the snapshot.  The verifier must reject
the stale access.

Also verify that an RCU-protected task pointer remains usable after
destroying its task iterator.  That iterator's empty destructor must not
shorten the surrounding RCU protection.  The existing iter_next_trusted
test continues to cover a trusted-kfunc use while the VMA iterator is live.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/progs/iters_testmod.c       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters_testmod.c b/tools/testing/selftests/bpf/progs/iters_testmod.c
index 76012dbbdb413..b8c8a3b24582f 100644
--- a/tools/testing/selftests/bpf/progs/iters_testmod.c
+++ b/tools/testing/selftests/bpf/progs/iters_testmod.c
@@ -28,6 +28,27 @@ int iter_next_trusted(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+__failure __msg("invalid mem access 'scalar'")
+int iter_next_trusted_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task_vma vma_it;
+	struct vm_area_struct *vma_ptr;
+
+	bpf_iter_task_vma_new(&vma_it, cur_task, 0);
+
+	vma_ptr = bpf_iter_task_vma_next(&vma_it);
+	if (!vma_ptr)
+		goto out;
+
+	bpf_iter_task_vma_destroy(&vma_it);
+	return vma_ptr->vm_start;
+out:
+	bpf_iter_task_vma_destroy(&vma_it);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_trusted_or_null(const void *ctx)
@@ -66,6 +87,28 @@ int iter_next_rcu(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp/sys_enter")
+__success
+int iter_next_rcu_after_destroy(const void *ctx)
+{
+	struct task_struct *cur_task = bpf_get_current_task_btf();
+	struct bpf_iter_task task_it;
+	struct task_struct *task_ptr;
+
+	bpf_iter_task_new(&task_it, cur_task, 0);
+
+	task_ptr = bpf_iter_task_next(&task_it);
+	if (!task_ptr)
+		goto out;
+
+	bpf_iter_task_destroy(&task_it);
+	bpf_kfunc_rcu_task_test(task_ptr);
+	return 0;
+out:
+	bpf_iter_task_destroy(&task_it);
+	return 0;
+}
+
 SEC("raw_tp/sys_enter")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int iter_next_rcu_or_null(const void *ctx)
-- 
2.43.0

