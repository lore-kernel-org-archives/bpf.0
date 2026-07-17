Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2B23F8EA6
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289768; cv=none; b=p270buL7/HkPX15Ykqb/1zfgNDgDDpuTIAb0ijJtjW/re/vh9t2nRZQWNxf2MzPz4jF3E6qiURN7TL9p9QiFxm2pOoP8i9zoKf+Seoa7z61n7sXWc3DEcoMHmS50xSPAjpDdhayV1hVs2Dxn18MTDOdUvBPjrKEtEKLNaSaGf6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289768; c=relaxed/simple;
	bh=WDQvjxDFqEnQYYWDl1n6QsHZD/5qq1ab2Ni+S65V/mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouI5cGfJbyqPz9eu6HjkyDkXFbwTI5bb20TxiTlZ7DHDqcTFh+6r36y5gDmCKcnnc3K0dgyclbQwf6asKQ1ljozhMcZsbc4aajJPGtubYfRA4F9gkngH/iGnY1u1b9Eo2ZNq1xkFpgS0SzclNzH4RNRKhVo/papToZKycKMtRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV6JUpfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV6JUpfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAD51F000E9;
	Fri, 17 Jul 2026 12:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289766;
	bh=ny6s3PtAed2b1adVltjhzi1mpkKVVlk8Z2uJ2EAmQco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZV6JUpfYQ2+157c5XdhEiwt2shsksaBIGJOFx0fiS6esXxAGErCIN3YZGUU/+deIN
	 C7YHdGF+wnWIJSVm28r8qQS7XGAMAhS6iPnwYj6RLqlVee6W0LG3TTDZ41u1SD7Gv1
	 Gs2cns4Su3RqvMHLYNwe980XLs68px+m4p7IKZM6Yt2kbAOK/8zBrsJo8ZQMhNwrw9
	 0Q5HACxRSFp4fcLgmNEbY/ugOEo0mxQ1m5BG1L9jy9jELkJk/23kAbsTpRWZYREE/M
	 hqMKd5ff19yjIEfBK+gU2hBVN1DRj9kYgPA6b2o+S16ok7CLu0+RUNGl504hoSxU43
	 cYgWuWQpWH89Q==
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
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 3/4] bpf: Inline bpf_iter_num_destroy() kfunc
Date: Fri, 17 Jul 2026 05:02:11 -0700
Message-ID: <20260717120215.2171057-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717120215.2171057-1-puranjay@kernel.org>
References: <20260717120215.2171057-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_iter_num_destroy() only zeroes the on-stack iterator state, which is
a single 8-byte store. Open-code it in the verifier to drop the call
emitted at the end of every bpf_for() loop.

Inline it in bpf_fixup_kfunc_call() by replacing the call with a store of
zero to the iterator, matching the kfunc which clears both s->cur and
s->end. R1 holds the pointer to the on-stack bpf_iter_num.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 832785b0670f5..64108bc9d461c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19784,6 +19784,18 @@ static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
 	return 9;
 }
 
+/*
+ * Inline bpf_iter_num_destroy(). R1 holds the pointer to the iterator. Keep in
+ * sync with the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
+{
+	/* s->cur = s->end = 0; */
+	insn_buf[0] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+
+	return 1;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19917,6 +19929,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = inline_bpf_iter_num_new(insn_buf);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
 		*cnt = inline_bpf_iter_num_next(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+		*cnt = inline_bpf_iter_num_destroy(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

