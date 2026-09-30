Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7933F54CB
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796714; cv=none; b=nfZnDZ+2ZBJP46l7PvXbcRi2+x4NuR+ZP8CKgzmTSUqlfrsbhyb7iO2OM+ad/Fen1nniwdGHjpQZ11fIOxPAj2p+yDksALBkle8C4K0oaThWxrxTPbTl40iyET1BMcPjER3A/itfNjf/2s1DJquLtKxTBhlEVIMSx+SxQBzu43E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796714; c=relaxed/simple;
	bh=HcLZ3mdOPyttqzbLq+0nL7THR2XoEIqPguXAvuS00ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVhDttdxPAFWMovwWSX0oOHZB9St3qcojN5JvGbbth0mZENgohMpEpNJfjJ6Cx/USmqueo/03EDgCf+nSmr361OBo5+YLzP4hxkwJ6nsdmnoqMBAJe7LZYcJuCMoh4NrkwbDntglu7gyTlwtJEIRJqi5kGrtu99UW2aaNQFJ5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETvhJnmW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETvhJnmW"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2813911a91.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796712; x=1791401512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1xX+VEc/E9xgUO9MC/bKdczikrVhwCgSAAX9ueO7rI=;
        b=ETvhJnmWgr3ZgR8g/ygS061f5x4axiZsAOVrXLKkk3bcOtmWJ6hg/skOh3qqVmn+Kk
         cROsjBZ4WLMNsee4EenJ2xaMR2h1/FpH+vg9T1V41dEku8G0aXS2W6PZQteRXcp4Yw0L
         FBTO4/AywRKq1Ejxn8+mdhXpXjiKHxrcgEG9LwloCBhqvqLamu8PqQEAqyM0rIvAAtxS
         1M1A/i/4JaEiOltMDrXPQ/By8iT7xBPybF9JsLlC+89Pw0q4fyEqQ/1k5sONyu8tGS2E
         C3i2fn/kqrPHW1JDkQ6gM1KCiGQDrf2O24jeiLTGsE6hxBSTyqSh6ZVhgaW4CdZa0wAZ
         w9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796712; x=1791401512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1xX+VEc/E9xgUO9MC/bKdczikrVhwCgSAAX9ueO7rI=;
        b=K4DekdrPfhNvpaYUPh3fhtF7yuUvSHFuG8K6WNI3VhovLSEdG6TRkg9lgWmS4AqusZ
         ynm+nF205nCu/VPTHycUF46HbzlayDqI3sUa5kMYVE7ATQCyNhWnyLcH77DfRAbkqfoI
         RxMjxFPE526w7wnW1MKuHg27FsfJ3naeVhXEATHecil+mSBj3kJSLp9/NuFNxYULftFU
         V7CfCWPe4mg+oJbVwsx4Y6l2+CkY3gILTmL+TE5zqMthXmbhfCBYX005Jrp6N0wdmaeP
         wXDO0iz5FdlEqxLlzpQk/naX/xL3i4kKuWJPTq28Kxc5XHXy8+s93yev4d8jk/wSPpPp
         WNqw==
X-Gm-Message-State: AFq9FYL41cL9Y7ocoH2qtK51hWB3Pp7q/TcNoGW9vh6xTJkgoXY2rW3Y
	5Jf+rzPa0wbHj/SLRVYQLwR/KQ8wW19lBas2valDEh+jlHto6WLcId8CJedQw9Xv
X-Gm-Gg: AYBFou17HLtD1YOJ8CP/Qshs6xXNXFVYImmiWiidBnqMFmx9Au6IzvDix9NaIHHW8ur
	mTeGOJiXQiatkNwOcEpilYpyt5Zm8Y1W1FA5jNTVy7ExDMdvF3+cr1C8QLcvktCQGXtLHu8UN4o
	4uyK0a9pcaMhgwh2+tsOr567HWDXUn7PVucz3gdoNy73z7fdcw8hv3hHNWfBJ6Wv3j8wY/6JQtI
	xPXztk21vbUb1sLuAVT5q0uqlMcKzqQABFWi9qJ1tiDIX/Ik9ii2SnvYf1WhW3JrIgJtxFolvUj
	NNQ9FwxxPhhwu2toirCnvYC5rWxQLMi0MS8e2iCofOb67BSDIv59pZ/tfYH57gB9Cxpjuza6Yh5
	XEusWdwlqW9pXmVmERZF//+HwkE+WLOud8sDNJUjQs/dfs0eWF0AeVyVjdlQQeXbM6R8y1HuiTC
	mqr+k0k8IaqzTbgTXutpSLGa2Qb8uvLakemK50lJsKmTnUlQV+gFIavIt2EH8Y4oCw1ZobokONb
	zKllwq2CFchwqPtc9V96CdEg3ifhzV57P4+++gDklI27OCmxkJx7IPXOMabTum4ey5SzWILqc56
	a/X9M/kE61r8t53dSB5scu0wI47tP2YcZywOQC6xZhg=
X-Received: by 2002:a17:90a:2ce6:b0:3a4:f8da:246d with SMTP id 98e67ed59e1d1-3a4f8da3679mr32334a91.53.1790796712275;
        Wed, 30 Sep 2026 12:31:52 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f3ff67cfsm719555a91.0.2026.09.30.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:51 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 07/14] bpf: Allow arguments without names in static functions in BTF
Date: Wed, 30 Sep 2026 19:31:20 +0000
Message-ID: <20260930193127.2181684-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Some static functions in BTF of a Rust program have arguments without
names:

  [71] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
          '(anon)' type_id=72
  [81] FUNC 'unwrap_failed' type_id=71 linkage=static

and the kernel rejects such BTF with "Invalid arg#1". It's 5 of 25
static functions in scx_cosmos and 6 of 24 in scx_simple.

The verifier looks at types of the arguments. The names are printed only,
as "(anon)" when there is none. Allow such static FUNC. Global functions
are checked as before.

The test "func (Some arg has no name)" in prog_tests/btf.c has a static
function. Make it global to keep the check.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c                             | 4 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d27af5d8e495..c9d4b709380c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5752,6 +5752,10 @@ static int btf_func_check(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/* Rust leaves out names of some arguments of static functions */
+	if (btf_func_linkage(t) == BTF_FUNC_STATIC)
+		return 0;
+
 	args = (const struct btf_param *)(proto_type + 1);
 	nr_args = btf_type_vlen(proto_type);
 	for (i = 0; i < nr_args; i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 207341f4bd99..21fdeeb23405 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2793,7 +2793,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "func (Some arg has no name)",
+	.descr = "func (Some arg of global func has no name)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
@@ -2802,7 +2802,8 @@ static struct btf_raw_test raw_tests[] = {
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(0, 2),
 		/* void func(int a, unsigned int) */
-		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
+		BTF_TYPE_ENC(NAME_TBD,				/* [4] */
+			     BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 3),
 		BTF_END_RAW,
 	},
 	.str_sec = "\0a\0func",
-- 
2.55.0

