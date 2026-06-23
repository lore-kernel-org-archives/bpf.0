Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01453AFB1B;
	Tue, 23 Jun 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195119; cv=none; b=j5qeKBfrgIlH0gTe0Iw+Zvtq5z1bbhH+/8qhHm4QOOXtr+69lrDfuy2ykWPkTyxyhUdt2gJypgOpHhPcsiL+duwIsJsnqD8eoV35ZqSv9xfk3uwsiiMdfgo/4XfqCwMqwYW2cCjPR587wfUTESnXuKBdSOov7WSzfi30Ij+FR9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195119; c=relaxed/simple;
	bh=SFE+n92nV/aiYiKgiiJg3UHjDXNx07v+CPPydxAikXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bJdvJVH5gIT+/yGCJc9OCngjbap/wN/8Tc9B3EemTM22go2hU2w+pVtotCQlY0nLrW7LFrfwnJ0uEFHu5IpZRaZQvxnmx72qQlmgupKOmmfDef3y/0dqeU18+ER3eIBIhY66RFiVcBJgZkaRoaZe5fiRXQivhdo2DhvYM8LKqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=MiucgvSS; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="MiucgvSS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=pCJbk
	muJfju09ou2x2V+w0+SSqTTN4WWo/jzMYeHGtI=; b=MiucgvSS+sJFuvJkMqovg
	0ANLa6GP9veLyWC98gz4o4uk3qNk8UkBeTekM67fUJxVrLL22CWJuYqeX1fQK1sm
	AtR5wncR6f/Mlfp+7gTTiEQmn/RXYrlkCFS0vDi9951Zky4c9Pk2nAv1FCUz8GLM
	A99RkkZKJgFF0VW65rN8oo=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQAXKJ1_Izpqkgx3Ag--.57670S2;
	Tue, 23 Jun 2026 14:11:22 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/2] bpf: Reject offset refcount acquire arguments
Date: Tue, 23 Jun 2026 06:11:08 +0000
Message-Id: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQAXKJ1_Izpqkgx3Ag--.57670S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8GFyDCr4UJFyrCw4UArb_yoW8Kw17p3
	yrXr15trn7tryxCrZavw1UCryrCan5CrWFkF1xGw18ZFW3WFy8Wa4rKr1jvas8A3s7Jw10
	v34fuF9xC3W5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_GF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRJtx6UUUU
	U
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

Patch 1 handles the zero fixed-offset requirement in the existing
check_func_arg_reg_off() / __check_ptr_off_reg() path without consuming a
bpf_type_flag bit.

Patch 2 adds a rejected direct list-node case.

Changes from v3:
  - Add Eduard's Acked-by to patch 1.
  - Drop the redundant rbtree selftest case; the list case exercises the same
    refcount-acquire fixed-offset rejection path.
  - Trim the selftest commit message and remove the selftest Fixes tag.

Changes from v2:
  - Avoid adding a new bpf_type_flag bit.
  - Carry the refcount-acquire zero fixed-offset requirement with an
    internal check_func_arg_reg_off() parameter.

Changes from v1:
  - Move zero fixed-offset enforcement into check_func_arg_reg_off() /
    __check_ptr_off_reg(), as suggested by Eduard.
  - Drop the positive container_of() selftest case.
  - Remove the stale bpf_obj_drop() after bpf_list_push_front(), since the
    pushed reference is consumed even when the verifier explores the error
    branch.
  - Rebase to bpf-next master a975094bf98c.

v3: https://lore.kernel.org/bpf/cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn/
v2: https://lore.kernel.org/bpf/cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (2):
  bpf: Reject offset refcount acquire arguments
  selftests/bpf: Cover refcount acquire node offsets

 kernel/bpf/verifier.c                         | 32 +++++++++++------
 .../bpf/progs/refcounted_kptr_fail.c          | 34 +++++++++++++++++++
 2 files changed, 56 insertions(+), 10 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

