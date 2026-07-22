Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF42E3033E3;
	Wed, 22 Jul 2026 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698096; cv=none; b=jih7zHpeP7/gejMVbdL32QPhxvX4A0jbdByo0L5AZik3LNBlqoYLEQvFQXazBjyWKBAOqdD+gw1oqIKDbuRvlVB0X9BLK6tQHH5jLgcQeDYhN5IViPFiinVqwkD/z3YWdqd5w4j6cFqqhyhv9HfHhrQFvAWmkCCF+N+26cK0O4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698096; c=relaxed/simple;
	bh=muVH/8VnpgZNbMVYh7bbi4wdX7q3dli/6gWxdRsqc2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jhNMBOXGUOEsDGxTrqqOR8CQ6GAErdtB0TbeBNtr+oyys12/XrNc0m2iRByutUGb8m7Vrd/dcSCFhK1vd147mtmCq2JzxxJ1Awa39MSQf0UA2oBvIdM7rmsSSPI28U8BSqrWt5rOCrLizxS/bqmnhiQpawwNRlmLak3S6UVKlZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=JkES9v2V; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="JkES9v2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=tuvGR
	TbqaHAYdDoh0TyOD5qmpr6Qy83eIXAXZ0ZrnUU=; b=JkES9v2V+EQfUoDkerFdA
	a/Yi640C3dI7qXZhK69V7GZwZ0Rwa2iUQFKGOoGKkBQ6HRqSqzzJmfbsGRdiUoSR
	tbV6vp6Go+6IWzebKq3TLBx3vyRLGiRakfXse1LpG/CDZ1fETwAiCmOHXWHV4sJl
	jW49Cczwx0gWozKgOx8eiM=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web3 (Coremail) with SMTP id ygQGZQCHWRjYVGBqhCwkAA--.51860S2;
	Wed, 22 Jul 2026 13:27:55 +0800 (CST)
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
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] bpf: Preserve pointer state for commuted arithmetic
Date: Wed, 22 Jul 2026 05:27:30 +0000
Message-Id: <cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQCHWRjYVGBqhCwkAA--.51860S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF1kGF1xtFy5KryfGr48Zwb_yoW5Jw4xpF
	Z5GayYqrn2yr1xJa9xAF4UAFyrAanYqFW5Cw13J34xZ3Z8JFyFqFW8KF1UXFZ8CryIgw1j
	vr4aqa4Duay7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuksgDUUU
	U
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

This series fixes pointer-state propagation for commuted scalar += pointer
arithmetic in the verifier.

Patch 1 keeps the full pointer register state when the pointer operand is
the source of the add, which preserves fields such as the stack frame
number and parent id instead of copying only type and id.

Patch 2 builds on that state propagation and moves the untrusted PTR_TO_MEM
early return after it, so scalar += untrusted_pointer is modeled as
PTR_TO_MEM and remains usable through the probe-read path.

Patch 3 adds verifier selftests for stack frame number preservation,
readonly-untrusted memory access, and dynptr data-slice invalidation.

Changes in v3:
- Preserve the complete pointer register state with verifier-env scratch
  storage, addressing Eduard's comment that copying selected fields is
  fragile and avoiding a temporary bpf_reg_state on the verifier stack.
- Keep the existing RUN(verifier_basic_stack) dispatch unchanged and add the
  stack regression directly to the existing verifier_basic_stack program.
- Keep the original operand direction inside adjust_ptr_min_max_vals() by
  saving the scalar operand in env->fake_reg[0].
- Move untrusted PTR_TO_MEM handling after the unified pointer-state copy so
  the commuted form remains PTR_TO_MEM before the early return.
- Add readonly-untrusted and dynptr selftest coverage, responding to the
  bpf-ci/static review finding that the untrusted pointer case needs a
  regression test.
- Clear the original dynptr data-slice register after deriving the commuted
  alias so the regression test isolates parent-id propagation.
- Make the readonly-untrusted return value endian-neutral by loading an int.
- Rebase to bpf-next base a23a71823352.

v2: https://lore.kernel.org/bpf/cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn/

Yiyang Chen (3):
  bpf: Preserve pointer state for commuted arithmetic
  bpf: Propagate untrusted pointer state in commuted arithmetic
  selftests/bpf: Cover commuted pointer state propagation

 kernel/bpf/verifier.c                         | 35 +++++++++-------
 .../testing/selftests/bpf/progs/dynptr_fail.c | 31 ++++++++++++++
 .../bpf/progs/mem_rdonly_untrusted.c          | 17 ++++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 4 files changed, 110 insertions(+), 14 deletions(-)


base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
-- 
2.34.1

