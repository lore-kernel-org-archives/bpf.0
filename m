Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED40446071;
	Tue, 21 Jul 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626816; cv=none; b=JIF5yzI5iVTE6erXhf9as6f7ynxcfApQWj1AaXIYISmPrqyI/gqWHxov92Jvbb5EFHtpOD3JNdal46Gw/zmyiVAa9dicOWGtwO05Yjf7rn8ZfEC5uhuqQ7RqUlBdwDB4d1F60QpoxO8yUy0/bIWXHCFmjlB5zAUCHf1wL4KGrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626816; c=relaxed/simple;
	bh=DNg9cx5D/bFI7aXIgJiqqnb5Rckme3lTmPc4cu3HGnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PDyCMpxVGGZiBWXlWJm7u6zw4wsNMevlxbS2oVUYC8pcG1VCChNwu6UAQy6PWbKAqJADwNzVkTUYC9O5OC9FdxZVGGcszPNCXpusFcM7M2L7oVwcTe+8B3pd17OIxL4oq9o1/ZapxeKfb5Rt+SCx4bYBKSOZI2WXxdXVaCEOffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=o5flln19; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="o5flln19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Zf3+a
	t1KQeQ0JWCC0ZIpNZdTxi+bBMzHz5pcVRwf5fg=; b=o5flln19ExOH3aHYIJDoE
	40+34hgdHdfpg23BsUA8Al3iJBRPHd4yRcTSQ8kHXtkdNevVtq0J/MtQfxPW3klD
	W0IaS8bYxDFxlk0uOGTnKBbLDqnAgqhGHT3IlpPnnTb3AH0zd2p0t+EPKMzkzvpL
	OhS6UOSqJvJmtSSTNohiAY=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQB3dbdfPl9q4NAnAA--.61424S2;
	Tue, 21 Jul 2026 17:39:50 +0800 (CST)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v2 0/2] bpf: Preserve stack frame number for commuted arithmetic
Date: Tue, 21 Jul 2026 09:39:41 +0000
Message-Id: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQB3dbdfPl9q4NAnAA--.61424S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17trWfZF4fury3GF47XFb_yoW8XryfpF
	Z29asaqa1kAr1xK3y3AF47ZFyrZFs29345Cr18tw17Zw1jyryjqrW7KFWUXrZ5CFyxJw1F
	vF15X3s5uayUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjWxR3UU
	UUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The verifier uses reg->frameno to distinguish stack pointers that have
the same offset but refer to different call frames. The scalar += pointer
path copies pointer type and id to the destination register, but it also
needs to preserve pointer provenance fields such as the stack frame
number.

Preserve the full pointer register state for commuted stack pointer
arithmetic and add a verifier regression test where a callee derives its
frame pointer through scalar += fp before overwriting and reloading the
same stack slot.

Changes in v2:
- Preserve the full pointer register state instead of copying only
  selected fields, as suggested by Eduard.
- Use a temporary scalar offset register for the commuted scalar += fp
  case, as suggested by Eduard.
- Add a Fixes tag to the verifier change.
- Drop CAP_SYS_ADMIN handling from the new verifier_basic_stack harness,
  as requested by Eduard.

Yiyang Chen (2):
  bpf: Preserve stack frame number for commuted arithmetic
  selftests/bpf: Cover stack frame number after scalar plus fp

 kernel/bpf/verifier.c                         | 14 +++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |  2 -
 .../bpf/prog_tests/verifier_basic_stack.c     | 14 ++++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 4 files changed, 64 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c


base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2
--
2.34.1

