Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8E46EC73;
	Thu, 24 Sep 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265851; cv=none; b=DIt5gdpTTbYxY+vnb0ffTmMt3d+D9N5tHOHXI/JRls1bTItJZo7BQkBvBxgO6/kMsThkwuUIUGNHz9LtRg2l3fOmdH5hCICeQ7MkX+eI3CgbtusPff7ojHoP6f16m/LTVcg824VA6tzxz8VvbWzBB1HFSzKWJq8VoHGafJn3tIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265851; c=relaxed/simple;
	bh=3f3Lx2ouYVjnR0WxjXvlo1q6cDtABINru71vn3B1Bdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJap28NJ/trXSwS4OmIwXa0MCUGtqw+40DMc38YRDfoOcsVQ4U5CHJ2LdsIdQYolov4FPqJkMduEMpOZ0birFuaSJ89X/qRgjdXUqKQu9U43WXEHnchqqL6q81hgLeIvEV7c4POrZ+6RRwi3jxDad8OMIdRODcKZYSTxn+a2bO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxllYQ9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxllYQ9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3091F0089B;
	Thu, 24 Sep 2026 16:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265850;
	bh=tE5XqUikraNPAR6DwWUFzsaCKQULIzICdYL06hBRZVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bxllYQ9odh6H9WdCFbsEo4yIhILgLfKSO5HTW4pTWmRa0L3G1cBF/IfKNEFrZz2GI
	 Efhy/hOX+mAO61fjFZeNlomnKz4dNEXejtzyjDyG5WWxNoARNCxIYsP9Gz2q6h4oht
	 jIIfL0RpwNffBLk+C+NDOtRN9IDmJdLlzX1APDbzPrYGCrcP5VzjWBFNN6tME3s8SN
	 F326g9Py5Tj0t24hWEv50XtKzvBc5+CUnxlOtlXNOq5dVCrgrpW1E8G7SOINNjEeti
	 K5yuRL6KXRTgXMs0Yeqs2WdNSV9aT12g+jxFK7RlunDN6VVTciFZgirZ2l+OqjWLCL
	 suY2PPbi+C5aw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Tejun Heo" <tj@kernel.org>,
	"David Vernet" <void@manifault.com>,
	"Andrea Righi" <arighi@nvidia.com>,
	"Changwoo Min" <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/3] sched_ext: Stop citing the x86 JIT for the cmask cmpxchg loop
Date: Thu, 24 Sep 2026 09:03:49 -0700
Message-ID: <20260924160354.531101-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924160354.531101-1-puranjay@kernel.org>
References: <20260924160354.531101-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cid.bpf.h explains its hand-rolled cmpxchg loop by saying the x86 BPF JIT
rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena pointers, and
names bpf_jit_supports_insn() as the place that does it. That function no
longer rejects anything, so the comment sends the reader to code that
contradicts it.

The loop itself still has to stay: arm64 without LSE rejects every arena
read-modify-write atomic. Reword the comment to say that instead.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/sched_ext/include/scx/cid.bpf.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/sched_ext/include/scx/cid.bpf.h b/tools/sched_ext/include/scx/cid.bpf.h
index 69fb4e97bc771..41060dcf5f5f2 100644
--- a/tools/sched_ext/include/scx/cid.bpf.h
+++ b/tools/sched_ext/include/scx/cid.bpf.h
@@ -130,10 +130,10 @@ static __always_inline bool cmask_test(u32 cid, const struct scx_cmask __arena *
 }
 
 /*
- * x86 BPF JIT rejects BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on arena
- * pointers (see bpf_jit_supports_insn() in arch/x86/net/bpf_jit_comp.c). Only
- * BPF_CMPXCHG / BPF_XCHG / BPF_ADD with FETCH are allowed. Implement
- * test_and_{set,clear} and the atomic set/clear via a cmpxchg loop.
+ * Not every BPF JIT accepts BPF_OR | BPF_FETCH and BPF_AND | BPF_FETCH on
+ * arena pointers: arm64 without LSE rejects every arena read-modify-write
+ * atomic. Implement test_and_{set,clear} and the atomic set/clear via a
+ * cmpxchg loop so this works everywhere.
  *
  * CMASK_CAS_TRIES is sized so exhausting it means seconds of real spinning
  * on one word - past any plausible contention. Abort hard.
-- 
2.53.0-Meta

