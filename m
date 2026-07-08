Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DBB38C2DE
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505899; cv=none; b=DglHBmyIMNOaLj1YBM+ZNu4YwE3EeHv+yGA3ut/2IqZKvim6Uyz993SnDX8OwA4v5qx2ek71YsnSnGhlBwQGewdfJ86HwdPFEA5URO4tHzOI31by+Dua3iaVCg1tuYDExXjykN+il/PZ45k98eAzfJ2csCOkYPJvkkI3uoOxuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505899; c=relaxed/simple;
	bh=k6nr6Brz5MyM2eK3LsRevz/L4b+u1ey1Pmtrs1xZev0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4JagVl1ojBvDOjHgW1ICUrgvuk1ma378h0hvdhD8jTeJgxER8lw616y3AC5cIci/oQtVg2ZAlwIFErPuvQNXni7zEWjgL00PulTqHmpEfOjhc1bi/epfwkVfRozW5P8rSpzYKK/q7/4WWZIYEhKJ77QNj6Xbt3B2Tcy2dZLaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOOvgI05qfmIBAA--.5882S3;
	Wed, 08 Jul 2026 18:18:08 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxTOXfI05qK20FAA--.4099S2;
	Wed, 08 Jul 2026 18:18:08 +0800 (CST)
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
Subject: [PATCH bpf-next v9 0/2] Introduce jit_required to prevent a kernel panic
Date: Wed,  8 Jul 2026 18:18:04 +0800
Message-ID: <20260708101806.18885-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOXfI05qK20FAA--.4099S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFWfWF4kJF13Aw43WF18CrX_yoWfGrb_CF
	ySqrykWr4kuF4Sv3W7Grs3try8KrW8tr18Aa1vqFWrGrn8KFs8AFWkJF9ruFZIqw4DArs8
	Jw43Zr4qvr1fuosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5fHUUUUUU=

This series introduces a 'jit_required' flag in struct bpf_prog
to track programs that strictly require JIT.

The aim is to prevent a kernel panic by rejecting programs with
inlined helpers when JIT is not available.

v8 -> v9:
  -- Initialize 'fp->jit_required' with
     'IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON)'
     in bpf_prog_alloc_no_stats()
  -- Simplify __bpf_prog_select_runtime()
  -- Simplify the commit description for patch 1
  -- Enhance the commit description for patch 2

Tiezhu Yang (2):
  bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()
  bpf: Reject programs with inlined helpers if JIT is not available

 include/linux/bpf.h   | 9 ++-------
 kernel/bpf/core.c     | 7 ++-----
 kernel/bpf/fixups.c   | 9 +++++----
 kernel/bpf/verifier.c | 7 ++-----
 4 files changed, 11 insertions(+), 21 deletions(-)

-- 
2.42.0

