Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3770630568C
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783003026; cv=none; b=Pu252jvqGCrCc7nkAr6nD0NOL9GiPcT1xhWYNzMvVKmBhsXzRZh/r4RYQL5kTB3IHrJsgIHu4EfRA87SIHgNawzVa7eqLubJ5sinIxqutlkdfuXJtZ0b0bhbw7845I8iw06CUAWyaO96DhlwJTOijaAoZgUELp23lgMovZJ5Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783003026; c=relaxed/simple;
	bh=tZrn0WMs8HJ6csX7L1IvfqRv/8sv8heTisw3VYnGHeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxqnoGu4mcuqJ96crbzgnEKmXRUSCwc0Kl1mcnDs/JIThoizMQL2S6Muh5PzHoRb0Rtk9tyEj/yDRuyal8CWWJ9bUu1j+ioceXKpwujj72a0yHwgT15og7VtOQUtiDHQ53knRxk9TqMtw4YXlxMmdCROJ0rpt0OpfhjZ0pHoX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxZvCMd0ZqZ_EAAA--.5303S3;
	Thu, 02 Jul 2026 22:37:00 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeCKd0ZqzkW8AA--.30423S2;
	Thu, 02 Jul 2026 22:36:59 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
Subject: [PATCH bpf-next v7 0/2] Introduce jit_required to prevent a kernel panic
Date: Thu,  2 Jul 2026 22:36:54 +0800
Message-ID: <20260702143656.28845-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeCKd0ZqzkW8AA--.30423S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
	IYc2Ij64vIr41l4c8EcI0En4kS14v26r1Y6r17MxAqzxv26xkF7I0En4kS14v26r126r1D
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8P5r7UUUU
	U==

This series introduces a 'jit_required' flag in struct bpf_prog
to track programs that strictly require JIT.

The aim is to reject loading programs with inlined helpers when
JIT is unavailable to prevent a kernel panic.

Tiezhu Yang (2):
  bpf: Introduce jit_required flag and refactor kfunc path
  bpf: Reject programs with inlined helpers if JIT is unavailable

 include/linux/bpf.h   | 3 ++-
 kernel/bpf/core.c     | 3 +--
 kernel/bpf/fixups.c   | 4 +++-
 kernel/bpf/verifier.c | 2 ++
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.42.0

