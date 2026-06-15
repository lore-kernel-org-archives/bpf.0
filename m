Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5B8635D;
	Mon, 15 Jun 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545774; cv=none; b=cOqnko1h6MWT7HyRRTrFf8CAqGQUJdTND+KaZoA7+annoAymWQkSAKfzogGrfLhTB109oRguCFy9FFUgtigHBYpnf6TknJHySezwpVGgY4uPe1G8nYsYKEj9aEOlkV2Udnjdyc8nXW930oeGUDM2lsECygS/54vc5ZSIgL+e37k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545774; c=relaxed/simple;
	bh=mD76oGNe2iNjnoBNoMR424OP5bMiKH4V8RzOGS3TaH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTpBWlewTtLdhoPOTphBDTPcTEBC5UrNhoiHIYClU54iN9tzDNAWd7mU0MaI/xwf2pYB17ntGC9jbbvngY0I3bxOTbntakhQuJSLfc4Pd5PvmIy/HkO6lhPzHUvDdH1IDH5jTsoeajUVgsF7nRXIbCnMiPlnCVme3xnRw1vXHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=E4u5gGG7; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="E4u5gGG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=L+ls6H1/tlPpf6sxp+q0eeQIlWXoPBYARt
	oPsjLLuO0=; b=E4u5gGG7vaYgyFn6/jphz1CDOkqpNIi445yMRcQFttn8afBOeV
	v7x80f0kQRE6kcq71rjYWjSHzZg4MT/Ww0NpfmCndLM3t2Zm6N4mS8xI94elNXx7
	4a1B6i/hbHfwZjfeccdPFZCB0XBAOiBtuFUIiOYJuZnn3xtbymv2zZcQQ=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web4 (Coremail) with SMTP id ywQGZQA3SJ0XOzBqCjxLAg--.43171S2;
	Tue, 16 Jun 2026 01:49:18 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v5 0/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 17:49:06 +0000
Message-Id: <cover.1781539813.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQA3SJ0XOzBqCjxLAg--.43171S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxtr17Zw1UZw1fXr13Arb_yoW8Kr4kpa
	yFkryYgr4ktF43Z3ZxAa18AFy5uF4kXrW3C343A343tF15tryYvrW8Kw13XF9xtr98Ww4x
	AFy2vF90ga47ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU7pnPU
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writers may mutate packet data and therefore must
invalidate checked direct packet pointers. The normal verifier path had
coverage for bpf_dynptr_write() with concrete skb dynptrs, but missed
unspecialized global subprogram dynptr arguments. skb dynptr writer
kfuncs also did not participate in packet pointer invalidation.

Fix both paths by adding conservative static CFG predicates for
bpf_dynptr_write() and skb dynptr writer kfuncs, while keeping the normal
verifier invalidation tied to the checked dynptr argument. Track when a
LOCAL dynptr may actually be packet-backed, and propagate that state
through dynptr clones and returned dynptr slices.

Validation, rebased and tested on bpf.git master 0e0611827f33
("Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs"):

  git diff --check HEAD~2..HEAD: OK
  scripts/checkpatch.pl --strict --no-tree: OK
  make O=/tmp/patch008-v4-bpf-build -j16 \
    kernel/bpf/verifier.o kernel/bpf/cfg.o kernel/bpf/states.o: OK
  clang --target=bpfel ... dynptr_fail.c: OK
  make O=/tmp/patch008-v4-bpf-build -j16 bzImage: OK
  QEMU replay on 7.1.0-g7feeed42d8b9:
    PATCH008_SUMMARY failures=0 total=10

Changes in v5:
- Carry maybe-packet-backed dynptr state for unspecialized global
  subprogram dynptr arguments.
- Propagate that state through bpf_dynptr_clone() and dynptr slice returns.
- Invalidate LOCAL-typed dynptr slices when they may refer to packet data.
- Include the new dynptr state bit in stack state pruning comparisons.
- Add selftests for the global-dynptr clone and LOCAL-slice bypasses.
- Rebase onto bpf.git master 0e0611827f33.
- Link to v4: https://patch.msgid.link/cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn

Yiyang Chen (2):
  bpf: Fix packet pointer invalidation for skb dynptr writes
  selftests/bpf: Add skb dynptr writer packet invalidation tests

 include/linux/bpf_verifier.h                  |   6 +
 include/linux/filter.h                        |   5 +
 kernel/bpf/cfg.c                              |   4 +-
 kernel/bpf/states.c                           |   2 +
 kernel/bpf/verifier.c                         | 145 +++++++++--
 .../testing/selftests/bpf/progs/dynptr_fail.c | 238 ++++++++++++++++++
 6 files changed, 382 insertions(+), 18 deletions(-)


base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.34.1

