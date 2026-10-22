Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627630;
	b=h3YVt06ZOGh2Rhy5hxntLvRej+GjNYk/hRpwvP+dSzZfy5USGGoRhh+11FSv6szZG/XQ
	 K6wztC+M0H4dbGYw08quVepH5rpmta2fFRVCOSDqqk2XATSZeNujbW4N/5F/4sr8JJCK0
	 qKRPzBixwiVTeZe70wUY5ZN917zYOokM7Ff2PMSdhzjo6G65wYOAnxWIHqZjLcv+oxunK
	 MshoOz0ZekbGIk40q+Tl3VftLb8fjw+j0YwjtRxjSgwrS4HIR6scbxXgt6it2Sr9dPPpa
	 VtL5b9xOWBv2JXluj+7Sqiw6YSaqAHgynO4YukALd9YkqHD7dybrGsbTkYfysYL6mUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=be/4y5Gr86A5bUUWrbeD4xA6mFb/f77D9SJgTHpWQPA=;
	b=SNPheeMrzikZfT/fYXrdG1reyhKaIuzncaxd9DoduVYHr27Tpu29ZOgnpkKWxbDA8rW1
	 JfD3BCCl2MYg2vVrQ77f1Pn9Ot662abyp4Xdp533d7T4hJI5Lnq9d0b6sDmCOEQYNMkmc
	 yQ30yvdqqW53ymkfLz2xV5Q7OxWKpv6d3JcRUinhjaA2IkmUQfWK0Nr/tNyFdWQ3jwIqe
	 ogRpQRJa5jRuwgsj3d8aYHKvQZq7p6yXCnrxyE5YcQE4yS4btscElA33uvXHERIxIgl7x
	 hOxocbTo4HI5wLXC6hB8G3p9IFsDoRiZHwHGYkhgxjcOxWNZAr+KaDlEKSUr+6Zioyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfCcb27S;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59FA606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59FA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfCcb27S
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-16079d54c17so2384701c88.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792627629; x=1793232429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=be/4y5Gr86A5bUUWrbeD4xA6mFb/f77D9SJgTHpWQPA=;
        b=BfCcb27SjvR0Od1idZCUBxQTaYQWesQ2IZgmSRqHqbuAmmPtnnp+F8sNI6XrPWmxqo
         +dFl9K9zXuze6w8nVI0mBaQLK1yOYV1G97y2h+7CHxEcanW9ZuY22+RmnATGWU7V579t
         px1jeO42+OUqOrfqOR5KoQoW9XkR3Ywlcvg/2lEHqVSHP2w8OrVfcvPca9vSn3vxNPeQ
         1ucQRxMU6mqSvE7WoxbPLv+paElLg2hhegQhLcbWS8pNwTTN0JsxsQSWmfO7eGo9Goo2
         RLCBmsgvdi4cJH+K6vdLoqN24HxJK0NRKOqwwA+YCZb+Noj5B8q70hpSzTfvH29OO5AZ
         WU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627629; x=1793232429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=be/4y5Gr86A5bUUWrbeD4xA6mFb/f77D9SJgTHpWQPA=;
        b=wFwcXq/vFsRgg/C6cEm5ixMBbVqskxHZImh3Dw91m9yg7o6qIOfEpWfDr/kp8qtRku
         UlG0DqH+p4JpLgvhO6CJAq1rpGhhxazDrId7GF/8Bp1izvVotiSu01xOI2RLERNBMZ2H
         hFLIhu9ZaG+5BRoMe49NZMhGVIUtoth+yKYakfUDWmuJDFfa6mOMiJ283g/pFtSWkPSU
         EiWL3/rhd/kyLFPKkpm7Vqk6pw08tXr2xuOF5mwCvXAvfXpv/1U8Ug1lQYZmUVeTsQbb
         dk5Y2v4VJKHZbdrTiddoc6X6Po7txj38Bm0/jdpyL/7maAOFCMpyEhKQUhLiBdot6D5G
         wupA==
X-Gm-Message-State: AFq9FYKRN+RPulkyCxWgTh/BCfOt4xIRSifskGEYMjzLDy3o9V9WNy5K
	sCRUsmukliafITO3zheFl7CEzfQZnmqyzHAG1QojLbH2ZJeNbSec6TzF48PMKwPn5g==
X-Gm-Gg: AYBFou3i+FDESDE7vTgcu4AtQyqBLxtrVgA8EPZnJI0vapI1/4ipxkZO8Ukz5RcNk+C
	aQUjcQBK8qZcQ7QCemr7Dv3LLCUVLAiAnMoNgJtpnXWfUwgTzJneO6CUi8FEBb7JXJjLjIjnxX2
	JImzBCoaxiYoTaBrRpaIyaULLdMLAgStyWU/59YTpCvwoGQlkbXCJJoX1zVBGCIsXnW3IL1QQZL
	JOf77+dKxLUik/yvVk9nujbuLmlwp2ZmJ37nQJe4XbnKfz1vP6noXZ6NcNPhb/VZxOnoqnjyxPb
	xPOPHBfi8wVbbNuKE9jBQ75aB9u06+ISrpVvXZTDV9i2YtMFQUdXilfZ4OxvcIKQB+/AFERx2VE
	jbfHwUSV71GxFygdmps5vMduY2t69EB89SGWXAraJ0rt9Qb3eYAhad0f8kT4zCW2cIEKyU3+pKQ
	/NWv7+fuYa4BWxv7EMkVqU7OWmSRtOWjD+FdWZKn4+tPmhTS6cQv/NoGRN+MZkR21N+W9dS0Lbb
	kO6mFxmByDxhKxHIbgUoNwgIvIV8+0H1lpcL2DhLzrJgsKs2Rt+ouQiV+HUF5KOgg==
X-Received: by 2002:a05:701b:42c1:10b0:16c:eaf1:335d with SMTP id a92af1059eb24-190a67fdd85mr4492204c88.30.1792627628617;
        Wed, 21 Oct 2026 17:07:08 -0700 (PDT)
Received: from localhost.localdomain ([185.220.238.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1902f96dc4bsm10682583c88.0.2026.10.21.17.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 17:07:08 -0700 (PDT)
From: Wang Yibo <szwyb123@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: name the failing registration in bpf_testmod_init
Date: Thu, 22 Oct 2026 08:07:05 +0800
Message-Id: <20261022080500.100-3-szwyb123@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022080500.100-1-szwyb123@gmail.com>
References: <20261022080500.100-1-szwyb123@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_testmod_init() chains its registrations with ret = ret ?: ...;
when one of them fails the module only reports the final error code,
and there is no way to tell which call failed without instrumenting
the code. Wrap the calls in a macro that prints the failing expression
and its return value instead.

Signed-off-by: Wang Yibo <szwyb123@gmail.com>
---
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 41 +++++++++++--------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 6380f52f4..625b6dc3b 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -2593,22 +2593,31 @@ static int bpf_testmod_init(void)
 	void **tramp;
 	int ret;
 
-	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
-	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
-	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
-	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
-	ret = ret ?: register_bpf_struct_ops(&testmod_st_ops, bpf_testmod_st_ops);
-	ret = ret ?: register_bpf_struct_ops(&testmod_multi_st_ops, bpf_testmod_multi_st_ops);
-	ret = ret ?: register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
-						 ARRAY_SIZE(bpf_testmod_dtors),
-						 THIS_MODULE);
-	if (ret < 0)
-		return ret;
+#define TRY(expr)							\
+	do {								\
+		ret = (expr);						\
+		if (ret < 0) {						\
+			pr_err("%s: %s failed, ret %d\n",		\
+			       __func__, #expr, ret);			\
+			return ret;					\
+		}							\
+	} while (0)
+
+	TRY(register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_testmod_common_kfunc_set));
+	TRY(register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set));
+	TRY(register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set));
+	TRY(register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set));
+	TRY(register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set));
+	TRY(register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set));
+	TRY(register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops));
+	TRY(register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2));
+	TRY(register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3));
+	TRY(register_bpf_struct_ops(&testmod_st_ops, bpf_testmod_st_ops));
+	TRY(register_bpf_struct_ops(&testmod_multi_st_ops, bpf_testmod_multi_st_ops));
+	TRY(register_btf_id_dtor_kfuncs(bpf_testmod_dtors,
+					ARRAY_SIZE(bpf_testmod_dtors),
+					THIS_MODULE));
+#undef TRY
 	if (bpf_fentry_test1(0) < 0)
 		return -EINVAL;
 	sock = NULL;
-- 
2.51.0
