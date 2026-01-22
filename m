Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41105481244
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097722; cv=none; b=Nb3AUIbNiJCypH684zADYRW9e1ZV4WEpiUhWIdNaNAcM8q0kPOIHwcB8chvy/TveWfnrBlvcXN+WWoTyZ5ifOG2DRFrO2S6E85yU5AwPHMPJJBfYfH1QNV9DZqNdH75YWBuTMwXavY3xDVwhguv28f6oR4bQ2wEXMxgtLrHMwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097722; c=relaxed/simple;
	bh=E7RtowIGn4nDXv09clmIivcZ3lhCc6PzuxUmFnFCxT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLGB68WN/9R2ywdcV2UY8Pu3FGDQLqEK5op6ZThmHgNI4f3p/1OdZnE6UPkeXyf62LItAoicsMLaSFGi+8kOHWj2by3dNsB4wi8sXywJkUFWWGsOLPTL/Lp1xsRamcE7Q6yBfSGZ2aj9Z1HVGZHap2iwvt8vNc5cgSMBs0f39ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IyusOf3o; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IyusOf3o"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MFC5lJ2070343
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=P97nsqVqFN/+MRp+4+NkVWD0wLuP+fZEFPSG0LXFGA8=; b=IyusOf3oRfIl
	DHUzp2uu6vEo8i/tYfVQqQqIK+N25fS6CDKNcrvlE223uD1X6QBF8rs9eiqE747y
	LaZa5zdL4DlUMzzSI12fh8eDC1gB+LWRqzXN7JlFqfTUOPSLp4XuiDkAWOQfYLAd
	P1vLpRnOw1bqgHPXvCWtPWTcYOaimAqBhyjapM4Nd6Yfz2bzv6O5ksaAO+smRjIb
	gCS6GAsisPEzbcog9YzkkjwfL24EMdYTu54lIZ8ygBKokj6ed7/2P0O2+v53URje
	+GEUBMIPEz6I/EJMZ5pjRsWqOvXTVUz2ymdBfIxPzFJWTulCntRUebCJl61IkBSJ
	Twt7qCXtMQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bubagvbr5-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:54 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:49 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id 9AFFC10A69E82; Thu, 22 Jan 2026 08:01:41 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 01/13] bpf: Add bpf_stream_print_stack stack dumping kfunc
Date: Thu, 22 Jan 2026 08:01:19 -0800
Message-ID: <20260122160131.2238331-2-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122160131.2238331-1-etsal@meta.com>
References: <20260122160131.2238331-1-etsal@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B-Eg9kC2c2RxitafJk92r5iRyGWrsdXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfXzfJerHO/IzyX
 y0DOl68dSZgUMNzc6znRtwlEKpnzfYNkTfiWrkaDxIzntBd1W3pNGNAUgSdWwcwB5zeAp4i4Omj
 0n9BS1YsZU6/VryPVOo91av1KRrBrm4AYkv5mvlxqlNFOfVHx5++2t07dyaTNMBhV5izUu+XQzS
 vVJLIe9r+N7Gv8yacLbLjhQ4ZTNca6XhbWGqCbUoSrsZcNBYblGxMeqo1jIF9Ell/yR+H4UL3kg
 FWGnAIwtp+9hhTG/mZZVkroJ0Ddhdf00gRP0pcelfMSVZdrJOUyfXviiibZ9llr7Lf2JnDjtwNg
 +ZIEPrA+jCxkYYyOy2XHDodi0BnBgD5cUdiGfW9O09SFsMFK6ykXDbA+KaR4Y8rJy+9DaqJEimC
 HcUjbyCNGbFS977HxzWrZu/0GcMlQ9uI6BoMX3csnNlo0fbyArvNKjd+Nt9WAIf6rul6R2C7m0P
 xV6pg8x0fvuXT5t8pFA==
X-Authority-Analysis: v=2.4 cv=UJnQ3Sfy c=1 sm=1 tr=0 ts=697249f2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=yJRT9AEQcBMRr3qBu0YA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: B-Eg9kC2c2RxitafJk92r5iRyGWrsdXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add a new kfunc called bpf_stream_print_stack to be used by programs
that need to print out their current BPF stack. The kfunc is essentially
a wrapper around the existing bpf_stream_dump_stack functionality used
to generate stack traces for error events like may_goto violations and
BPF-side arena page faults.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/helpers.c        |  1 +
 kernel/bpf/stream.c         | 13 +++++++++++++
 tools/lib/bpf/bpf_helpers.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f8aa1320e2f7..0e131283780f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4534,6 +4534,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 24730df55e69..6e2cbe5f34e7 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -245,6 +245,19 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, co=
nst char *fmt__str, const vo
 	return ret;
 }
=20
+/* Directly trigger a stack dump from the program. */
+__bpf_kfunc void bpf_stream_print_stack(struct bpf_prog_aux *aux)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog =3D aux->main_prog_aux->prog;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
 __bpf_kfunc_end_defs();
=20
 /* Added kfunc to common_btf_ids */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index c145da05a67c..6d8ae3887618 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -343,6 +343,8 @@ extern int bpf_stream_vprintk(int stream_id, const ch=
ar *fmt__str, const void *a
 /* Helper macro to print out debug messages */
 #define bpf_printk(fmt, args...) ___bpf_pick_printk(args)(fmt, ##args)
=20
+extern void bpf_stream_print_stack(void) __weak __ksym;
+
 struct bpf_iter_num;
=20
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)=
 __weak __ksym;
--=20
2.47.3

