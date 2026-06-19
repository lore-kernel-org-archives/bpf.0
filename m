Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1B34EEFD;
	Fri, 19 Jun 2026 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856028; cv=none; b=SlxlnqEE5odvPmOtw79vcZRRZgXHRLG6x8y/Bqm4fEs/ZSzvqEu/HzxwkHxuYSdLsuhCa2EwPGTjKfLv21AINccIw8EFYTZs7uTA0vagP5miFXxZEXrQ6EEKclhEUjiFwQPOAW+jfHNO2ZfKxEaOq+wDAiNhMHr54VZ2BGBl8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856028; c=relaxed/simple;
	bh=AU0kru10oOHDYGRzc++U3OAyFQRFB2Fg6dlVEr3MJvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bczcAgM+Z8lRsnudEdLk/R8MYf+kQmx0MV9LRhX/v3qebLCBxtAVbcXpz+botfDSRYfdtdqnedCyA0+hL2bGxWm7RMb/e4Xr5qXBQtvAFj+XN7WoSmfgSA/QwnD9vr+YVrdnx3xW3+BlxgW9LmCFliXOz05pYV7TTp+nQYgWcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=XW2ZXcbo; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="XW2ZXcbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=RUvlT
	Pv2/zOYsfgVOzMpPqajJTkUOWgwChhaLC9uq1g=; b=XW2ZXcbojMK3iMSBcDIDW
	+cbPOnYKuSMa3nfagDLGWYcLIMQjLngouI9OAgvY8HuCl/wrU8MGhnpUTW+aFA2H
	Vb8K9b3SDwW/pYKpduSRfpPgeXNE3yPDrhLKPG+mTG6gfS2IbS/0FKsBhZpTtIUT
	KZnp0JjR5JebWFj5Y0UqPU=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQAX85r79jRqhz5nAg--.64298S2;
	Fri, 19 Jun 2026 16:00:01 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Reject offset refcount acquire arguments
Date: Fri, 19 Jun 2026 07:59:52 +0000
Message-Id: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQAX85r79jRqhz5nAg--.64298S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1fGryrtr47Zw48Xw18Krg_yoW5WF4rpa
	yrWFnIgF1kta4xCanF9ay8uryrGwn5G3y5G3ZrGr18AF9rJFyrta4Y9ryqqF95Krn0qw10
	vrySgasF9w15ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14
	v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRA73kDUUU
	U
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

bpf_refcount_acquire() is modeled as returning a refcounted allocation
base, but it currently accepts PTR_TO_BTF_ID | MEM_ALLOC arguments whose
offset already points at an embedded graph node returned from a list or
rbtree operation.

At runtime the kfunc starts from the supplied pointer and adds the type's
refcount offset.  With a graph-node pointer, that starts from base +
node_off, while the verifier treats the returned pointer as the allocation
base.  Reject non-zero-offset arguments to keep the runtime operation and
the verifier model aligned.

Programs that pop graph nodes can still acquire a reference after
normalizing the node pointer with container_of().

Patch 1 adds the verifier-side zero-offset check for
KF_ARG_PTR_TO_REFCOUNTED_KPTR.

Patch 2 adds regression coverage for the accepted container_of() case and
the rejected direct list and rbtree node cases.

Validation, rebased on current bpf-next master e771677c937d
("Merge tag 'for-linus-iommufd' of
git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd"):

  git ls-remote https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git \
    refs/heads/master: e771677c937d
  git diff --check e771677c937d..HEAD: OK
  make O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-latest-20260618 \
    kernel/bpf/verifier.o: OK
  make -C tools/testing/selftests/bpf \
    O=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-latest-20260618 \
    OUTPUT=/tmp/c5-027-selftests \
    VMLINUX_BTF=/root/ebpf-verifier-bug-detection/kernel-build/bpf-next-latest-20260618/vmlinux \
    /tmp/c5-027-selftests/refcounted_kptr.bpf.o \
    /tmp/c5-027-selftests/refcounted_kptr_fail.bpf.o: OK
  make -C tools/testing/selftests/bpf ... BPF_STRICT_BUILD=0 test_progs: OK
  ./test_progs --list: listed refcounted_kptr and refcounted_kptr_fail

The BPF object build needed a local-only generated-vmlinux.h fixup for
missing experimental kfunc prototypes in this environment.  No source-tree
files were changed for that workaround.

The explicit runtime run was attempted with:

  ./test_progs -t refcounted_kptr

It failed before verifier checks in this local container because libbpf
could not load a trivial BPF program after failing to raise RLIMIT_MEMLOCK
(-EPERM).  The container's memlock limit is 64 KiB and cannot be raised
here ("Operation not permitted").

Yiyang Chen (2):
  bpf: Reject offset refcount acquire arguments
  selftests/bpf: Cover refcount acquire node offsets

 kernel/bpf/verifier.c                         |  5 ++
 .../selftests/bpf/progs/refcounted_kptr.c     | 33 ++++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 84 +++++++++++++++++++
 3 files changed, 122 insertions(+)


base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
-- 
2.34.1

