Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AF34EF14A
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677052; cv=none; b=m+Uoz+z7lh557d9iS7dEtBJWNrIaCvcNfmJBd8ZPyFTior43hLVgwJ6eatLMBLOqBB1JZUqUTyQTJTWtlsHXS5qGesIYH4KlsIfIEBsn6AyAg2zKrRcJ6V3DbiGfQgU3EGR2GjNHaI4RezAIB4qzThRYaiTo6RU7sKNnCqUs4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677052; c=relaxed/simple;
	bh=yrgq1Ia5bbF2q/1s+lfTAM2h6MqSX3ogo0ZAx0Pqzbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFHmp1wVCQofByRQQX1ikYuDRCqPySA66mZ+za/cqYSwBS7ZxuFLmsEI0Efoy+3uoxlpVkr75us4Z7YmKWdIJZsU8LbsV9FluFtbRalpS1HUwO08TmWY4qiOAw5RJo73D/+TTBJWgSsPtNRfp9H3ld3Z8sMk7bJLJgnGnhNHHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=YStOgRvM; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="YStOgRvM"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HI1UkW3637466;
	Thu, 17 Sep 2026 20:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=JDlYj/AT6T3d8FDAaHPIURJy+SaLP1STx1h3p+HwaxU=; b=YStO
	gRvMMmjrP/56dcJyrlwyUUBNG020sFR9bpLR5+rreb6zJRiahEaabEZPQqESy/xF
	gNMbDmHUOUpxOvCgjdxSw6pEAd4dSs19C0txxe8Ir6IeHq4GugExbxekUXC2tncd
	vVcj4N/9+lG3QKRn0IA80DvVNz4ETMw3vEqFv8AuGkPxCxxQ8nkWQgyJiX2oGxbg
	z2QTTthZxwmgYsk/9g2r0FoID9H5JAu2ChGsiookK8MY2dL8Qf6YDOafUUifes0t
	KDs2alLXmHK7IEbO64vI+7IAVy8h0EG5YP1+frpovpacy+cTlHKcpmWZIbZNoJ52
	PYue4hjw5GxcTj3eyg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4gqyajng0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 20:30:47 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 20:30:45 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v3 4/6] libbpf: Reject gen_loader for objects with already-manual programs
Date: Thu, 17 Sep 2026 16:30:38 -0400
Message-ID: <20260917203040.3150212-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX87wycr0wJcyM
 G+koFvD7SD4psOJXkv+n1YNc/iUvdfAvVFz1BU9oFPk64zctRSKpBLJ+9z+aUmkf3JY93TzJJAW
 pbL3D+TSuXksfe1LuBjowGhn9hR2+XxsvTIa0naWmCXGPczOtEOh
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6aac4df7 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=o5Nfn-qTtObFmKmQ79QA:9
X-Proofpoint-ORIG-GUID: lhdu_qBjdgY921_Q-3JOO4nIzBd6SObB
X-Proofpoint-GUID: lhdu_qBjdgY921_Q-3JOO4nIzBd6SObB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI5NCBTYWx0ZWRfX+AxYNXrrdGo9
 pRKY3PDPTiYwd/9CowvjkQf7JUR1vfvPUF1Zq0Am8MtaSslSyL7x+POl51835rU5A7x3lxtYHes
 XymzkujSbgAHt4MTckN+9IEvrb897st6+EAdfJiqSDWNMSRPCKSNNIbIdwegVgLX78wSIisCT6t
 AfDOM1wSqi9JIhbz10cXLaf+tsoi1+5keTc0RNkweTP/E23KP5WCTu+v52/OIyTnQ6o2SUn8wBe
 QZMfOTBJOYXgAK+utp6jjirF0ftWaFQIhewwMC1q6gXTKmkBrh2VKHr26PJVpN4ET8LCXNyuBEM
 ahcYUL8HAdHE1F92ZQJjQovnmHaj3bg1wosAmdMu8/x6inXMa7+9w0HxlyKOCciXO7jwqIIL81z
 yYhbx/jwluQ0gMoK6URvlRa7U7oM9wgbJOqnPS5o7Dvrrio2QrfPnBLemczOQh9UdZARDMG8rSK
 3SMhDINpIwrrmydue6w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11908
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170294

bpf_program__set_load_strategy()'s MANUAL case rejects setting MANUAL
strategy while a gen_loader is already attached, but a program marked
MANUAL declaratively (SEC("!...")) gets that strategy during
bpf_object__open(), before bpf_object__gen_loader() can ever be
called, so the existing guard can never observe it.

Left unchecked, bpf_object_load_progs() skips such programs, so
gen->nr_progs undercounts relative to the object's real program
count. bpf_gen__finish() only rejects the opposite mismatch direction
(nr_progs < gen->nr_progs), so this passes silently, and every
generated skeleton program slot after the manual one ends up wired to
the wrong prog_fd.

Catch it at the one point guaranteed to run after any MANUAL marking
has already happened: reject in bpf_object__gen_loader() itself if any
program already has load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL.

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c9a184d9626d..3ac7319ed0f4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9752,11 +9752,29 @@ int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
 int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 {
 	struct bpf_gen *gen;
+	size_t i;
 
 	if (!opts)
 		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
 		return libbpf_err(-EINVAL);
+
+	/*
+	 * Manually-loaded programs are not visible to gen_loader (see
+	 * bpf_program__set_load_strategy()'s MANUAL case), and marking a
+	 * program MANUAL happens during bpf_object__open(), before this
+	 * function can ever run, so that guard can never catch it here.
+	 * Reject any pre-existing MANUAL program now, since this is the
+	 * earliest point where both are known.
+	 */
+	for (i = 0; i < obj->nr_programs; i++) {
+		if (obj->programs[i].load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
+			pr_warn("prog '%s': gen_loader does not support manually-loaded programs\n",
+				obj->programs[i].name);
+			return libbpf_err(-EOPNOTSUPP);
+		}
+	}
+
 	gen = calloc(1, sizeof(*gen));
 	if (!gen)
 		return libbpf_err(-ENOMEM);
-- 
2.34.1

