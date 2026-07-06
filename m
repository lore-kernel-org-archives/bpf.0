Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457E91A682F
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310423; cv=none; b=hj40Y2HQihAJqpvt3NBbqfZLBom+ZvIhSMqqJ4H86rhD7eCX2TCh5C++NgD3p/KJj7t+zxbhWBtpmYlen85eh+LB010g0Qczj+lFbrvRL7PRO3+mUTTnMNnMyZ/DV9ZIOF+K3VTZoTj9T6zN9lxfhE/j6JaEsxynDeTA/pYZ8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310423; c=relaxed/simple;
	bh=xaZLghahuAKDgBH0MeBFRv6MdroClVLRholyo4h6rMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAqMLcSVQiV/w5OvMpuea9pqpBVyDw+60pGWtqGJJL7DICbTK1CnpVKDDv5gZa3cBbwz/xQy+g316fnVL4yH6gouZsgN1RuqQ4+30UUVyQmfl5eeV3cpntxVmy4+a0T1ALEkW9Jmhf2uuAtfSu4P2ERHR9kdhgPi0IzRN5IwJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx6vBSKEtqnkUAAA--.1394S3;
	Mon, 06 Jul 2026 12:00:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxfsVHKEtqQ8MBAA--.9722S2;
	Mon, 06 Jul 2026 12:00:08 +0800 (CST)
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
Subject: [PATCH bpf-next v8 0/2] Introduce jit_required to prevent a kernel panic
Date: Mon,  6 Jul 2026 12:00:04 +0800
Message-ID: <20260706040006.10331-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxfsVHKEtqQ8MBAA--.9722S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFWfWF4rKrWxCryDAFWkuFX_yoW3ZrX_ur
	W0q3s7Xrs3ZFyav3W7Gr1ftrn5KrWxKr40y392qrWfJr13Wa1UJFW8XFy7uF9Iva1vyrZ8
	tws3Ar4vvryruosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUUUU=

This series introduces a 'jit_required' flag in struct bpf_prog
to track programs that strictly require JIT.

The aim is to prevent a kernel panic by rejecting programs with
inlined helpers when JIT is not available.

v8:
  -- Completely remove bpf_prog_has_kfunc_call().
  -- Set jit_required at the entry of bpf_add_kfunc_call().
  -- Generalize the error message to:
     "program requires BPF JIT compiler but it is not available"

Tiezhu Yang (2):
  bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
  bpf: Reject programs with inlined helpers if JIT is not available

 include/linux/bpf.h   | 9 ++-------
 kernel/bpf/core.c     | 3 +--
 kernel/bpf/fixups.c   | 9 +++++----
 kernel/bpf/verifier.c | 7 ++-----
 4 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.42.0

