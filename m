Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF425B09A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726686; cv=none; b=BLqAYKAASHFSz2Jn85PlkGHfeNn4OFFDzJkOmAUwqbKVBFgbEPaiUYIG6yd5Uwi0JlUqBrYHKYvfzLD8e7Uj4LkTesPjnscBYmolag21wGw0tp/25kuvvzeH5eGTrWe7RKtXN+5qkzNhlruKu9rb+h529jx0EpVBLSF2e1abiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726686; c=relaxed/simple;
	bh=zCzuRC2b8g9giFeERPpAdcYjRecLjA3q7bhXtL//IrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og7CFwKlrpX2kphB0FgAdDX79Ru15KHw//FeIfcCbSOXkJZoAMxbrjOIyOP/P0cbgfVKoAwroilGRffgY6vMIAdTUPi41PqWKkKLTcLXVeVm868dEdyWl/vh3xFWmVT9Eg1m35mt6Yi//U++MtF7zurS0V5Ssu6XKo+ggWGv24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMa+2xuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMa+2xuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636241F000E9;
	Wed, 22 Jul 2026 13:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726684;
	bh=etPUH13WyFnLOg4e4ZM9jGKsRtcnncu1VVODAWleLkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jMa+2xuTKmVkCPf3Ym7igAIalHC2ktyQA6Mx8rIswe8lYdKP2Li4jwJPH1rRFUVAB
	 OhPhUioiRmmbFRK2G6m394PPY+szDkhMtN8/OAuQQNmpHoaYZevPvWziFUvUK59J/W
	 48BMrWqUzvqKNFMglGTi7qGtNkan7sZwk9acB8UF1cQhGh5nJWEBROZCXz5+TKXk3B
	 4XWoI0iVsp3l1oOzxvZL3IRoPjynNq6jN0mdFdLYMrPJobE0w+xopco+cvONvCIv5y
	 Gzu3A648gQlBCTPw7MdUY3wodHpfqks+OXOdJ3H1Euk4ZR/O6XXVrXAojUiRWaD74n
	 rrXcs0MgHniLg==
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
Subject: [PATCH bpf-next v3 3/6] bpf: Inline bpf_iter_num_destroy() kfunc
Date: Wed, 22 Jul 2026 06:24:18 -0700
Message-ID: <20260722132424.450230-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722132424.450230-1-puranjay@kernel.org>
References: <20260722132424.450230-1-puranjay@kernel.org>
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fb8fdd5d5b21..dec6bcba53a22 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19835,6 +19835,20 @@ static int inline_bpf_iter_num_next(struct bpf_insn *insn_buf)
 	return i;
 }
 
+/*
+ * Inline bpf_iter_num_destroy(). R1 holds the pointer to the iterator. Keep in sync with
+ * the kfunc in kernel/bpf/bpf_iter.c.
+ */
+static int inline_bpf_iter_num_destroy(struct bpf_insn *insn_buf)
+{
+	int i = 0;
+
+	/* s->cur = s->end = 0; */
+	insn_buf[i++] = BPF_ST_MEM(BPF_DW, BPF_REG_1, 0, 0);
+
+	return i;
+}
+
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
@@ -19968,6 +19982,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		*cnt = inline_bpf_iter_num_new(insn_buf);
 	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
 		*cnt = inline_bpf_iter_num_next(insn_buf);
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
+		*cnt = inline_bpf_iter_num_destroy(insn_buf);
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
-- 
2.53.0-Meta

