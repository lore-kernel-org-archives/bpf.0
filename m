Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19D3126D6;
	Mon, 22 Jun 2026 02:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095197; cv=none; b=R+ZEu7q96zM3miZoeix5Kw+64Y/eo+Xd6EE2v76pGVWrRRpLq7AX7/tCQ1S5IY4ur3IWDYPBQH2/UsgCxH8MhtXgaypsyeovZrSbSpeYNPSuM8NxIriCniX/Mp+tPktWMWh6Z/KhSwhAdikr3NXJ5BbKhuspSBHSzDXPWOaPiD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095197; c=relaxed/simple;
	bh=4rTIJMMSnSal4Y3STjsg8okwhAdfK4fIfYVPjthGR4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9px70p+GGA4xWrVM7TD0OTveyHRuS+1YohEL046UEInU0p7/nB0rrl9HV3UtXzJOQeX5sFwP4dKIOyiRIh/TlEF25TDEcVu05IGrR6hvfQmsESBRBrzSBDeY1XeX1ed4m7dIfJzv64byrDFbaio4FmYxJBIszFajy5wvxSFwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=laqt9ILa; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="laqt9ILa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=rRzv1kCof3iIKul+Ydor+P1hpWSMpDDxWW
	GE+r9ZrnM=; b=laqt9ILaDVIpt8BJybGll6OFTj9REYDr1J66soNUORvIoS3JlA
	K0ipi2DAU0P0+Y/4oQJGXd4YJgDLcF9oyyUvhdiZerokqtM+YQKmcjDiXmRqhi/5
	JQwUuwEyl9s95Tv9PEIUuVcpYg8TtbQWGfE/s7gHdE1RKN3vN9FGdBVac=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQCHQcEynThqj7qZAg--.19827S2;
	Mon, 22 Jun 2026 10:26:04 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/2] bpf: Reject offset refcount acquire arguments
Date: Mon, 22 Jun 2026 02:25:50 +0000
Message-Id: <cover.1781979133.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCHQcEynThqj7qZAg--.19827S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrW8GFyDCr4UJFyrCw4UArb_yoW8CFyUp3
	yrX3Z0vrn2yry7Cwsaq3W09ryrGws3urWFkry8Wr18AFW3Wa48tas5Kryj9as5Jan3Jw1j
	qa4F9wnxu3W5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67
	AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRisqXtUU
	UUU==
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

Patch 2 adds rejected direct list and rbtree node cases.

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
  - Add a Fixes tag to the selftest patch.
  - Rebase to bpf-next master a975094bf98c.

Yiyang Chen (2):
  bpf: Reject offset refcount acquire arguments
  selftests/bpf: Cover refcount acquire node offsets

 kernel/bpf/verifier.c                         | 32 +++++---
 .../bpf/progs/refcounted_kptr_fail.c          | 77 +++++++++++++++++++
 2 files changed, 99 insertions(+), 10 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.34.1

