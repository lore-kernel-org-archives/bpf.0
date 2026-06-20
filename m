Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B0392C3C;
	Sat, 20 Jun 2026 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781967891; cv=none; b=U4nUC8Gig9KFxM1YeOaMOxll1eTBx80IFzmuRY6QeoU/rgDfnVztiY2L/2KFaqEgbiwM1K7CYBUTmcVibo0SFVdCx+fOHFxhZXyDfQoPMTyowLmjXHmMTcyz3z5IK0+W6/qEbXSnGSYmQqJGPcYszKeBbnoIHSQFAwH+KaJgA/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781967891; c=relaxed/simple;
	bh=81WCnRxtqaMbqher2RgveJzaHlPJuc8+t+RA7Ce4Pr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDxEvWXphempL1zeyxOGzUq7e+xy8T3ZRwaAhz/Utuq1gxbY3bYLopZxT/GrDMigU2Rwd4vknolBpz2RRyz4n/DtAI5B7rJaY0zV5ZWUGmAzHGoXBQC/eqrKXVLSoLcuJkxHRQXr20b7/RVUiXesThqAriYN6DeWdE4skNpyhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ovmvkHxK; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ovmvkHxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gEg1WcxWQxT8e3/qBbZq/XuBngE4nIL8KX
	RuQvp+tNc=; b=ovmvkHxKZtNmavDI3rHghbcxqLIO4eaHANQ232ySwoGJziXj7z
	CDipIL1PwqFKa/AFQ39vqvnBJw7n/6qqZrIPHyvUghANJAx2bmxvVBuVfvIunnPr
	GtjBqCGg1DOSL9api5yIlY684qaws3YcdhOkP9KrILFNx1pCTtO3cYEHE=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQBnep_zqzZqVGBnAg--.37531S2;
	Sat, 20 Jun 2026 23:04:26 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf: Reject offset refcount acquire arguments
Date: Sat, 20 Jun 2026 15:04:16 +0000
Message-Id: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQBnep_zqzZqVGBnAg--.37531S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8GFyDCr4UJFyrCw4UArb_yoW8AryUp3
	yrX3Z0qr4vyryxCr4Sv3W0vry5Wa1kCrWrCFy8Wr18Aa43Gay8K3s5Kryj9F95Ars3Jw1j
	qryS9wnxC3W5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm0b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	F7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26r4a6rW5MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pEL0eDUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_refcount_acquire() is modeled as returning a refcounted allocation
base, but it currently accepts PTR_TO_BTF_ID | MEM_ALLOC arguments whose
offset already points at an embedded graph node returned from a list or
rbtree operation.

At runtime the kfunc starts from the supplied pointer and adds the type's
refcount offset. With a graph-node pointer, that starts from base +
node_off, while the verifier treats the returned pointer as the allocation
base. Reject non-zero fixed-offset arguments to keep the runtime operation
and the verifier model aligned.

Programs that pop graph nodes can still acquire a reference after
normalizing the node pointer with container_of().

Patch 1 adds a PTR_ZERO_OFF argument flag and handles the zero fixed-offset
requirement through check_func_arg_reg_off() / __check_ptr_off_reg().

Patch 2 adds rejected direct list and rbtree node cases.

Changes from v1:
  - Move zero fixed-offset enforcement into check_func_arg_reg_off() /
    __check_ptr_off_reg(), as suggested by Eduard.
  - Drop the positive container_of() selftest case.
  - Remove the stale bpf_obj_drop() after bpf_list_push_front(), since the
    pushed reference is consumed even when the verifier explores the error
    branch.
  - Add a Fixes tag to the selftest patch.
  - Rebase to bpf-next master a975094bf98c.

Yiyang Chen (2):
  bpf: Reject offset refcount acquire arguments
  selftests/bpf: Cover refcount acquire node offsets

 include/linux/bpf.h                           |  3 +
 kernel/bpf/verifier.c                         | 18 +++--
 .../bpf/progs/refcounted_kptr_fail.c          | 77 +++++++++++++++++++
 3 files changed, 91 insertions(+), 7 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

