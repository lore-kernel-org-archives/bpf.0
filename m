Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F379023ABBE
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938279; cv=none; b=rpb34ItHWkBHTH6zzugTSL0RMbb119DNsKbSxCHZHNiKuchfRae52TB7dXopcWw4QNC/ul3xmNgtwGw16cS0roFUPe5iKS/Aj3u4htRfYlLE50bSiHGyt/z3+RBoqO7V/x/oHawM4A5yZntaSkHbA/8BEcPrdkvt6Ayx3JWVs0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938279; c=relaxed/simple;
	bh=PaoNmXiHoQf4Qn+GdroQNjdNrZO8CJIVCNa1ju9eDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhjqHHDdxIAl04SoIogLsi34wnCEJ4ttMbqMzX04F8n+RsCB8MIh1ivLOoU65rEdJ1dpJcCjk5F3fPr5oZv8bs7ia1oq+2QsKClHBWixoYpRQHCSzXYFB8ZMhyzAnnHt0FW/E501NybJTdQzgvrPmdpwf3LZSn1N4C813NS8ldY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=hKv/6MqH; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="hKv/6MqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=zZ5C0GofVh
	gDgyVNIxbE7MM+Z1fSQ+Oa2ECkukeXh74=; b=hKv/6MqH+KrQDrDMbPfXC1KhM+
	S30+dZiij9SRxn0/KyAppWCvfmPERTalKXhxPYocMcL4+LjsdUfMgQvVku0Uy6MY
	rRdggATxwjr+81+c9ILFGM2kh102h1Ff5ze/zBKgRFNeyALDageCWtVM/OX4a03O
	zxnRlip2ndD7w0Jw8=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgB3dCtYSrBq0jBAAQ--.2113S2;
	Mon, 21 Sep 2026 05:04:24 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	sun.jian.kdev@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: Reject non-negative stack object offsets
Date: Mon, 21 Sep 2026 05:04:20 +0800
Message-ID: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgB3dCtYSrBq0jBAAQ--.2113S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4rKrWxCFyxXF45GF1kuFg_yoW8Cryrpa
	97Cay3tFWDt3WfKa17Ga17Cry5Kan5GF15JF1xJwnYvrWUXr1kAFZakw18uF9F9ryxXr17
	uF1YvF9xJr1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_CwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
	UvcSsGvfC2KfnxnUUI43ZEXa7IUY83vUUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Reject non-negative offsets before converting a stack object address to a
stack slot index. Add a regression test for iterator destruction through
fp+0.

Changes in v2:
- Split the kernel change and selftest as requested by Andrii.
- Rebase onto bpf/master at a11212910cf09b2fe8db9afa41ef60c4f81879c5.
- Keep the original code and test changes unchanged and retain Sun Jian's
  Reviewed-by on both parts.

v1: https://lore.kernel.org/bpf/20260911084314.3481637-1-xyx2021@mail.ustc.edu.cn/
Split request: https://lore.kernel.org/bpf/CAEf4BzbYzt-Riekpc-A=MfQft9ZELwSDSE8kkQO1ZOyR3O_FAg@mail.gmail.com/

Validation on this exact candidate with a matching bpf_testmod:
  - W=1 verifier, full kernel/modules, changed BPF objects and test_progs
    builds passed.
  - iters: 1/97 passed; 0 skipped.
  - dynptr: 2/132 passed; 0 skipped.
  - irq: 1/33 passed; 0 skipped.
  - res_spin_lock: 3/14 passed; 1 skipped.
  - file_reader: 1/8 passed; 0 skipped.
  - kmem_cache_iter: 1/3 passed; 0 skipped.
  - dmabuf_iter: 1/4 passed; 0 skipped.

No selected test failed. The VM ran with panic_on_warn and panic_on_oops;
no kernel WARN, Oops or panic was found.

res_spin_lock_stress skips because the VM has no hardware PMU.

Annotated verifier tests check load outcomes and diagnostics. The full
unfiltered suite, sanitizer configurations and architecture matrix were
not run.

Please queue this fix for stable after it reaches the BPF tree.

Xu Yunxiang (2):
  bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
  selftests/bpf: Reject iterator destruction through fp+0

 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/progs/iters_state_safety.c  | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)


base-commit: a11212910cf09b2fe8db9afa41ef60c4f81879c5
-- 
2.43.0

