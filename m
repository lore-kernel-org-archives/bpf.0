Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086321E091;
	Mon, 15 Jun 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536579; cv=none; b=YPcjiCjj+KCYBFhlFtP/RJjasFzl8eCFwyf8IOOxYASwq0eTG1oER1uIgCumcXNqREdkUHJpfEzh3+ZMecCzreL3h4NpqCHgSVkHJvRX4t9MFjBCJ6xRn54Y//URoWQHRr8vL/SJZ7hd9fy2mTGh4XGZ+eHS8bRLd+bSwo9gMdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536579; c=relaxed/simple;
	bh=9p2KZruHB8YRgQvZdsHhjxa3aFilI0ToX/jzjdQYVX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NfVeVBDVsN+Dn9xa832kJZJNTaD5kiFMebEnjcfEuWtKrX4+Gl6vDUdTBRLB/ikGvNSGIaOcOlrXeHQDCjqF3NLpa2W4n9GIwV29a++xGk35zt3FrY+dWErb6RwoM6pScAjWP8Yk6LB6m60mk8TDdksXhJKkHg0nJRlPWlM4Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Y3vaiKZG; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Y3vaiKZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Bz6hiZE3qoifyXnYKRHlX429opYt734GRo
	RO4OY10DM=; b=Y3vaiKZGx+1xSBSYcVlGmUPL+jQ6ljN+WBCOBxnSiNBI0GhA6U
	WZBtiWnJpLQ3Hrn2Y+x1Qvpt+VdJItA76bsEnZ1dgZRJMxMUE8X5qPVIKrn45yo4
	k6U8UuNtuM5I8RAQkrBRsF7oSIwhmkXHqbRrbnkMIq9676eyB2WwT7PXc=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQDXj78mFzBqGxJyAg--.21012S2;
	Mon, 15 Jun 2026 23:16:00 +0800 (CST)
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
Subject: [PATCH bpf v4 0/2] bpf: Fix packet pointer invalidation for skb dynptr writes
Date: Mon, 15 Jun 2026 15:15:47 +0000
Message-Id: <cover.1781535194.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQDXj78mFzBqGxJyAg--.21012S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyxtr17Zw1UZw1fXr13Arb_yoW8Kryxpa
	4rCryYqr4kta1aq3ZrAF40yrWfJFs5XrW7Gry3Kry5ZF1Yqry5ZrWxKr15XF9xtrnxWw42
	yFW2vr98G34UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUoyx_U
	UUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

skb-backed dynptr writers may mutate packet data and therefore must
invalidate checked direct packet pointers. The normal verifier path had
coverage for bpf_dynptr_write() with concrete skb dynptrs, but missed
unspecialized global subprogram dynptr arguments. skb dynptr writer
kfuncs also did not participate in packet pointer invalidation.

Fix both paths by adding conservative static CFG predicates for
bpf_dynptr_write() and skb dynptr writer kfuncs, while keeping the normal
verifier invalidation tied to the checked dynptr argument. Extend
dynptr_fail coverage for helper and kfunc writes, including global
subprogram caller-side and callee-side cases.

Validation, rebased and tested on bpf.git master 8cd9520d35a6
("Linux 7.1"):

  git diff --check HEAD~2..HEAD: OK
  scripts/checkpatch.pl --strict --no-tree: OK
  make O=/tmp/patch008-v4-bpf-build olddefconfig: OK
  make O=/tmp/patch008-v4-bpf-build -j$(nproc) \
    kernel/bpf/verifier.o kernel/bpf/cfg.o: OK
  clang --target=bpfel ... dynptr_fail.c: OK
  make O=/tmp/patch008-v4-bpf-build -j$(nproc) bzImage: OK
  QEMU replay on 7.1.0-g5a2ca20101d9: PATCH008_SUMMARY failures=0 total=8

Changes in v4:
- Rebase from bpf-next to current bpf.git master 8cd9520d35a6 to resolve
  CI conflict.
- Address the helper-side global subprogram case for bpf_dynptr_write().
- Keep bpf_helper_changes_pkt_data() precise and add a separate static
  bpf_helper_may_change_pkt_data() predicate for CFG summaries.
- Keep kfunc CFG summaries conservative while preserving checked-argument
  precision in the normal verifier path.
- Extend selftests and QEMU replay coverage with bpf_dynptr_write()
  global-subprogram cases.
- Link to v3: https://patch.msgid.link/cover.1781531784.git.chenyy23@mails.tsinghua.edu.cn

Yiyang Chen (2):
  bpf: Fix packet pointer invalidation for skb dynptr writes
  selftests/bpf: Add skb dynptr writer packet invalidation tests

 include/linux/bpf_verifier.h                  |   3 +
 include/linux/filter.h                        |   5 +
 kernel/bpf/cfg.c                              |   4 +-
 kernel/bpf/verifier.c                         |  88 ++++++++-
 .../testing/selftests/bpf/progs/dynptr_fail.c | 183 ++++++++++++++++++
 5 files changed, 278 insertions(+), 5 deletions(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.34.1

