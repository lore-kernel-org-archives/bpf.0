Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FA3AFCF3
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015232; cv=none; b=OxSZ0raD4GAdkerqZAj82ldjkQt/3uya981qJV2+FZtPVlDqhZ7253EfQWOW+7jlq6go4KQG1IHYrlx0tlljKf5Mj/cmOMlcdxBeZJZT6PzzDMpbEuc+QarOK7EY8ls6uIb86pgsgzsN9G4vC+pmuQPFC0N6k1NA1kADagR34oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015232; c=relaxed/simple;
	bh=ZRl/8qOJALFD7ImD9iByKavMjoySw909eBPVffwFXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ck3DeGmQeFDzpmtrwABzjo5hgObFzOK42OBAC2QrH6OT78Gl5UX7duwrhHRX1mzPsL35kMQI2BfM6SAA6nEXxKPfDBdIikFoCS+nysPkXdnexAEZ+rTFl6IdyulcdT00pycjBlR/oSM2yA6zYw7tu9EZGqk70i3bXkWl3QgcJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=emfZyGul; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="emfZyGul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=fxD2xx9DjS
	Jak+YDEunaRm+uBaojGSiwbqnfXEyJnxo=; b=emfZyGulGhQKjxE5HVg8x8Kzjk
	8RjcKwFVYO1lq4hEbSsVWVBZn+dHTIZchRiVJWuOCz7UgHUMTQg37eaqrbs5Kv1j
	ONSM+AiF+kfFcWbQNMrRJcmhdvO4EtyL9gLQeAC6qo8aCJRF+oKA3PMVgHecfEiV
	s9Ua5gSHxHat41BmA=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgDXzSSoNKJqgDL_AA--.352S2;
	Thu, 10 Sep 2026 12:40:08 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v2 0/2] bpf: Preserve escaped dynptr slice ancestry
Date: Thu, 10 Sep 2026 12:40:04 +0800
Message-ID: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgDXzSSoNKJqgDL_AA--.352S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxtw4xGr1UAFyxuw45Jrb_yoW5Wry7pa
	1F9rWYqr4kAF12krW3ZFWUWa4FkFs3X343Ga4xtryrJrn8JFyrZFW0g345ZF90kr4kC3yj
	9w18Xa13Gr4UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
	IYCTnIWIevJa73UjIFyTuYvjxUyT7NUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Sashiko reported a verifier lifetime gap for a dynptr slice derived from a
clone in a subprogram. The slice can escape into its caller before the
subprogram returns. Once the clone's frame is gone, the slice still names
the clone id as its parent, but that graph node no longer exists. Releasing
the original dynptr therefore fails to reach the escaped slice, and the
verifier permits a subsequent access to the released ring buffer
reservation.

The same disconnect affects a dynptr constructed from another referenced
object. In particular, an skb dynptr created from a referenced qdisc skb
has the skb reference as its parent even though the skb dynptr type does
not own a reference itself.

Patch 1 reparents surviving slices from every callee-local dynptr that has
a tracked parent before the callee frame is freed. Patch 2 tests both the
ring buffer clone case and an skb slice returned from a subprogram and used
after the qdisc skb is released.

On the exact unpatched base, the new ring buffer stale-access test and the
qdisc stale-access test both loaded. The v1 fix rejected the ring buffer
case, but still allowed the qdisc case. With v2, both stale accesses are
rejected and the legal ring buffer control still loads.

The checks require CAP_BPF. This series is submitted as a verifier
correctness fix.

Please queue the verifier fix for stable after it reaches the BPF tree.

Tests:
  - W=1 make O=<build> kernel/bpf/verifier.o
  - make O=<build> -j12 bzImage modules
  - test_progs -t dynptr -v --workers=1
    (Summary: 2/134 PASSED, 0 SKIPPED, 0/0 FAILED)
  - test_progs -t ns_bpf_qdisc/invalid_dynptr_returned_slice -v
    --workers=1
    (Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED)
  - baseline/v1/v2 differential checks for the ring buffer and qdisc cases

The full unfiltered BPF selftest suite was not run.

Changes in v2:
  - Reparent slices from any dynptr with a tracked parent, covering skb
    dynptrs constructed from referenced qdisc skbs.
  - Add a qdisc regression test for a returned slice used after skb
    release.
  - Fix the selftest comment style and mark the expected failing access.

v1: https://lore.kernel.org/r/20260909042858.1734125-1-xyx2021@mail.ustc.edu.cn

Xu Yunxiang (2):
  bpf: Preserve escaped dynptr slice ancestry on subprog return
  selftests/bpf: Test dynptr slices escaping a call frame

 kernel/bpf/verifier.c                         | 34 +++++++++
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 49 ++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c


base-commit: 15e2565f1c43771af0bc5324971cabaad79ac286
-- 
2.43.0

