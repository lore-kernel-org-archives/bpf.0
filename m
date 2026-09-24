Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC522305E3B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217510; cv=none; b=MX9JkGijEQ2s4BTHyDCL4ZEN62ZY00GblCPy4fKwk5g1ozr4xxJv/jBrVAGbUcwl1zlBYHHBvnT68xpQh912IOpnvThqqs8tyJb0EDtj7SDCl9wzS7NDjEQZrSuQn1kIiaNyjyzuMOHgFrwu3xcRf5R69+RUHnw+Zk1pdy6FfsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217510; c=relaxed/simple;
	bh=LEUyTJnxMGbRyTu5Og6VoSg5ZBzcxDsvWmfcVUAlKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MKumE/+1OPMcx1TYaebG3aRwp9/p3FYcddd85OP6ruRhAJI7SDQcDNHlm9Xl+LVHVe05scnjjhnzj8O3ID5AVJ+sahiDxbB8ZBP4Pw53tF48xN6q/7mbB2liGWQZ4MPg1PcWwd18VW4ZiN6f/mMWb9gWGtf6mc2xKOWuZGFXsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FU+u3Ay0; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FU+u3Ay0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=WI
	8qghahgT2SXAVV7tUzdwj++Tiez+KBST3aj5Tat0s=; b=FU+u3Ay01lsv8yOFhd
	acNsP9s5we/TnNcK7/SK7Hc9ls1dIHPuW4IsGoto7MV2CP5hF2C9pChpS3RVfv+9
	Byo3HPLu5MUSVFFScVG+eQUChjNNTCsbvy7gLrc+xYt7TcDo+eETyqjLtjAzrdv3
	yd+mUMfw8YyiAVPCYC8jKAfsU=
Received: from nec8-i7 (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHgUr7jLRq5ltfBA--.14507S2;
	Thu, 24 Sep 2026 10:37:48 +0800 (CST)
From: chenyuan_fl@163.com
To: alexei.starovoitov@gmail.com,
	ast@kernel.org,
	leon.hwang@linux.dev
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	song@kernel.org,
	ihor.solodrai@linux.dev,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Keep target extended until its last freplace link detaches
Date: Thu, 24 Sep 2026 10:37:35 +0800
Message-ID: <20260924023737.1140521-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHgUr7jLRq5ltfBA--.14507S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rCrW7CF17Gr43CF43trb_yoW8Zry3pF
	Z5Xw15Jr1kXrZ2q3yfGw47Gayfua1kGws8GryfW348Aas8GrW0gFySgwnIyF98t3yvy3WY
	vF1vgr1kCa18CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAhwq52q0jPwW7AAA3H

From: Yuan Chen <chenyuan@kylinos.cn>

is_extended is a plain boolean, but one target prog can carry several
freplace links at the same time, one on its entry and one on a global
subprogram.  __bpf_trampoline_unlink_prog() cleared it whenever *any*
of them detached, so with two links on one target, detaching one of
them re-armed the unbounded tail call loop closed by commit
d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace"):
a single BPF_PROG_TEST_RUN on the tail-called target then panics the
kernel, reproduced on both bpf-next and master.

Patch 1 replaces the boolean with a count of the freplace links
attached to each target prog, so the target stays extended until its
last link detaches.  Patch 2 adds a selftest covering the sequence.

Changes since v1:

- freplace_link_cnt is u16 instead of u64, per Alexei's review: it is
  bounded by BPF_MAX_SUBPROGS, which counts the entry function too, so
  up to 256 links, one past u8, and it sits in the padding next to
  stack_arg_sp_adjust, so bpf_prog_aux does not grow
- dropped the separate is_extended boolean, deriving the extended state
  from the count itself
- renamed bpf_freplace_check_tgt_prog() to bpf_freplace_link_tgt_prog(),
  it reserves the target on success
- dropped the WARN_ON_ONCE() on detach, per Leon's review: the count is
  paired by the link lifetime and the sibling prog_array_member_cnt
  decrement is not guarded either

Yuan Chen (2):
  bpf: Keep target extended until its last freplace link detaches
  selftests/bpf: Verify is_extended with multiple freplace links

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/arraymap.c                         |  2 +-
 kernel/bpf/trampoline.c                       |  8 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 74 +++++++++++++++++++
 .../bpf/progs/tailcall_freplace_multi.c       | 27 +++++++
 5 files changed, 108 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c

-- 
2.54.0

