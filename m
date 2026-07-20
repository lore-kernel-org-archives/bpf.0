Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07134302F6;
	Mon, 20 Jul 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565791; cv=none; b=IZEKcfo9Bw7NAXrbIXJ/SRcCuKVv89E/iMc4wkjEvkEKpZ9ZEWF6/B6HBjVIolflcC4jXgxpeiZx99FEfBA8EVKcTNXLE6utEY9pUKoN64YA6/vGYXuEUT7k8Lc9Sj7PtSpLFAOq6EFOc20Rvs916Zhsnb7sF3/pd3d2Dt7W9VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565791; c=relaxed/simple;
	bh=nrsV3aQGDUDpGrlMw0JqI3UoiNvNrEbtvZ+8ZYaYDDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qz/8/qr6/QQIGjp/lLZZlq5k7znOBpy9LJnh3hLlf6sTFgp08EGGQs4naqeYNNnoojypw4uerYIjDaxDHpVAXsCOoImTXgNyrFZYSJFzprKSQdk7/aD6ZrTLxEQRFBBaQwVfM8/Px1ByX59EP4LxqBBPgMhFwruPzNDkCxGFxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=rDdeMk0i; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="rDdeMk0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ScHLL
	W7PsgGNyPwTlAbUCgZuDTdFZhxn8kRVhx7oDCk=; b=rDdeMk0iEF3/WVZNfvtl+
	JzmxbcaWIrPDAli0MjNEVlF2TxBpzwK4PqX5Ki6orXJBXrWT4jrklnazWlwORcvw
	QRoJZoMJzJLqUeZn4IFtvL6RNjgsTkGqCzWu1ahmrm+iwNmfM6/WIbpT3uZ3qTzC
	BXCNJKtIKgIw3uGLKm1j9I=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQDX1bcGUF5q2kYhAA--.51004S2;
	Tue, 21 Jul 2026 00:42:49 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Preserve stack frame number for commuted stack arithmetic
Date: Mon, 20 Jul 2026 16:37:43 +0000
Message-Id: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDX1bcGUF5q2kYhAA--.51004S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFW3Kr1kWFWrZFyxZw4fXwb_yoWDKwc_ua
	9ava90ywsrAFs2gFy7CF1fZrW3Ca1fXryxAa1DtF13trn8Xrn8WF1kur15G3yIqF4jqrZx
	ZF9Yq34F9r1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb6AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwV
	WUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUsXo7UUUUU=
	=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The verifier uses reg->frameno to distinguish stack pointers that have the
same offset but refer to different call frames. The scalar += pointer path
copies pointer type and id to the destination register, but it also needs to
preserve frameno when the source pointer is PTR_TO_STACK.

Preserve the frame number for commuted stack pointer arithmetic and add a
verifier regression test where a callee derives its frame pointer through
scalar += fp before overwriting and reloading the same stack slot.

Yiyang Chen (2):
  bpf: Preserve stack frame number for commuted arithmetic
  selftests/bpf: Cover stack frame number after scalar plus fp

 kernel/bpf/verifier.c                         |  7 +++-
 .../selftests/bpf/prog_tests/verifier.c       |  2 -
 .../bpf/prog_tests/verifier_basic_stack.c     | 28 +++++++++++++
 .../bpf/progs/verifier_basic_stack.c          | 41 +++++++++++++++++++
 4 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_basic_stack.c


base-commit: cfce77b63375dac81d53f2f85593c548415206b7
-- 
2.34.1

