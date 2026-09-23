Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A2415B8E;
	Wed, 23 Sep 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154457; cv=none; b=m2dOcS1kDjXXIuWYxzWTnkISSfWz5mi8aEmEW64yKSxFNC3qqOvlsdbRyU0UCBCzr+SLNh8MiDMFuII4DYRzbq7pumf/zAXojXZpoAu1gy/GmdvH9a/5xOXki4uANSZriLLrQlPvAVLQ6d79+CDq6SUzEGRDmpKFB5WU8rT+oTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154457; c=relaxed/simple;
	bh=HGgYm9qGLtOperaISr/aJq9Y9j4XNTtLD47q3ReqFbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6wHy99V8Ejx8gsFmzFQOIr9WVjj/R+phzSDA7F7SeT7oUP8rbtU82cB5p7XkgQbRutiGRax4ZkXIAVevoXW7pRsAGobfLmD1DJwfyBtV7q0Sgm6DjiuSadBFd7KNaHUKJ2syFLbLuuemzMa/QhAiVnXP8URJSQs1iOimNjy8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AI0UpREB; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AI0UpREB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ek
	/Rk6bCy5QsmhvpMdt5/FZmTHXY1qQDmWgitxSiKiA=; b=AI0UpREBGtv5v4KDX7
	L21bVbFv3k2mRyValzxbO7faltC0Y6YgWBjfYw4SwPPZr2pfN4i9XlGvWw3E7t2Z
	DeCUFo1+p6Ttpsn89duTtRqeHxyeNQ4lXJS4fGGKApi9KuAzMPEScC+O+pOQOQBg
	o7e5Pol8Z6MKrMsxGvpbN7smU=
Received: from nec8-i7 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXvIWmlrNqQZffAw--.40141S2;
	Wed, 23 Sep 2026 17:06:46 +0800 (CST)
From: chenyuan_fl@163.com
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Yuan Chen <chenyuan@kylinos.cn>
Subject: [PATCH bpf-next 0/2] bpf: Keep target extended until its last freplace link detaches
Date: Wed, 23 Sep 2026 17:06:33 +0800
Message-ID: <20260923090635.368488-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXvIWmlrNqQZffAw--.40141S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4rCrW7CF17Gr43CF43trb_yoW8Jw18pF
	WkXw15Jr48JFZ2qayfCw4UX34fua1kG3y5GryfWryrAas5KrW0gFWIgw1ayF98trsaqw1Y
	vF1vgr1kGw4xCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0jgxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5gZWFGqzlqZc-wAA3o

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

Yuan Chen (2):
  bpf: Keep target extended until its last freplace link detaches
  selftests/bpf: Verify is_extended with multiple freplace links

 include/linux/bpf.h                           |  4 +-
 kernel/bpf/arraymap.c                         |   2 +-
 kernel/bpf/trampoline.c                       |  10 ++-
 .../selftests/bpf/prog_tests/tailcalls.c      |  74 +++++++++++++++++++
 .../bpf/progs/tailcall_freplace_multi.c       |  27 +++++++
 5 files changed, 110 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_freplace_multi.c

-- 
2.54.0

