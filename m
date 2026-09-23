Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E8457E6D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206194; cv=none; b=Vs8UVh2c1L+Ogr1B3/EqsGfCU2obFBlfxDJCh59SWKKCGDXqbS6VrfXvZgOZbdI1q4fcGoLsq80MMWXifJX+uwE9LqxutFPGQ6sZi/xCSXmbeHnygeIAnmmzARlW/zglobFWXy92inXeeM8fiTOPHCODSeb+NHrUgJEj9vIpCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206194; c=relaxed/simple;
	bh=m/eiJG1tZvu9M+YAyL+KAiMhTUqH/uEA1kqDXAFvTMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX3gbvGnEqzWexQDO/PGWtPB+L/8fJpkCKmk4G9D9D3wIdLbRF3Bm4aYl0Xvf+hATCmeXiKi/3gxYLxtdcPFvSPqSkAXU6w5DpV782cHO4iYuezJu/mHeYX3glvBjzS76e0W8O/upwZzVxXIlFjZSyuPXLV8GMUi6ySVGKlF5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=Q/VIdT4a; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="Q/VIdT4a"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NKKnFO1558419;
	Wed, 23 Sep 2026 23:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=/XoNiAppMcTBFWTf4Skc+Aqw4SDakMbURAexgY6EGCo=; b=Q/VI
	dT4aEafu1aMUQGaAm9qvH+myPAZBmF/6wGZT7UblUiJYfma5Nw9GDCr/rWXs4ulE
	1Auj+M0EzlhqaauzXXmCgV8RisZsNrXvEtVBdQsxEG3StSqRq8MaK9GQgjIOY9Tr
	HOOSlKIANss3Gv9cO65I5+HRGSWkiiGkfmFNPRuAT5PtG/c6tF/jq8arvgpGGaA4
	Wd/5JNCoxO4p1/KRSv1o12fhWISPYWDfzxqZbyQHty0aKtLh0TdWtQIjxJw1v3Uu
	3H+He2jzInbL32Q/txaIvBLLZ86ow11G3XzcAOnEnCluK0hoUKnKmyVm8fWYP70z
	nMAlGe2LnSygdEQypw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gvnqq0h30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:45 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:43 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 4/8] libbpf: Reject gen_loader for objects with already-manual programs
Date: Wed, 23 Sep 2026 19:29:35 -0400
Message-ID: <20260923232939.1886328-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
References: <20260923232939.1886328-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH012.crowdstrike.sys (10.100.11.82) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX0E37oyQ+I7ht
 QhFFhPVzd27vx7BT1aeRhefvBXax5thDHbmRwcyHb4KCugrwuZ2I8B84PdzQbg1t3vffxAvugWv
 Bj+TFflm1wWMeB+NIL5XeNH6lrHU62cA0pHAw6BIxCOfoLEExsUmKlLdbwsbEvehXsK6YXDoGR8
 EmYo7kAkSmIoejxMSPCcckkGbXlTsYOaw02pKX07VgE9wO8/ErtYdOX4tjrAp7K4gAdhmR7GXS6
 d1y0KJt40HvADDJMiyy2pSv9zIZSn5M+mLF02le1N6SI9bdohnumnH7vWORKDwCscsU8krgPCVN
 7351dpFNHvTETO8boaitpVhHCrSaT5ymQ+LKSsLMV1sInaoG4S+ZOf0FXUVnkB0vgnMeUUJEGT2
 V8UaibPeZvCdDczrgN8r8nQzLR9XhOAJU2GhWfTLXP22E3VR2nClFiSTCFA3Ph39l2z73dMhlCk
 53MKdV37612IAwtqsZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX5edDxhCitVIC
 0cF7dyWyU6fOmYhqka0BofZ197vfnqHXzZN9BYKX+puCnl7h04ZUEk4npdHZTR/jpN8EIG51lE/
 mVwayxUuqmR800PHqj5XaSkp4JeZiCF30F6r0iEjWw21+EVmigt3
X-Authority-Analysis: v=2.4 cv=Is2L47/g c=1 sm=1 tr=0 ts=6ab460e9 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=fA5rxOzin2JeiXhilosA:9
X-Proofpoint-GUID: Hs4iziZSexX-ejnfAx-AbmqTb1e8fPHp
X-Proofpoint-ORIG-GUID: Hs4iziZSexX-ejnfAx-AbmqTb1e8fPHp
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230095

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
 tools/lib/bpf/libbpf.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d815e53e8295..85e1d9c775ab 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9859,11 +9859,31 @@ int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
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
+		struct bpf_program *prog = &obj->programs[i];
+
+		if (prog->load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
+			pr_warn("prog '%s': gen_loader does not support manually-loaded programs\n",
+				prog->name);
+			return libbpf_err(-EOPNOTSUPP);
+		}
+	}
+
 	gen = calloc(1, sizeof(*gen));
 	if (!gen)
 		return libbpf_err(-ENOMEM);
@@ -15470,16 +15490,10 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
 		break;
 	case BPF_PROG_LOAD_STRATEGY_MANUAL:
 		/*
-		 * Manually-loaded programs are not supported for gen_loader.
-		 * This is because bpf_object_load_prog is not called for
-		 * manually-loaded programs, so such programs are not visible
-		 * to gen_loader. For this reason, prevent calling
-		 * bpf_program__set_load_strategy(MANUAL) when gen_loader was
-		 * used to generate a BPF object loader.
-		 * A gen_loader implementation is being called for autoloaded
-		 * programs and defines its own model for loading BPF programs.
-		 * To pass a BPF program to gen_loader, set the program's load strategy
-		 * to BPF_PROG_LOAD_STRATEGY_AUTO.
+		 * Manually-loaded programs are not visible to gen_loader,
+		 * since bpf_object__load_progs() skips them during the bulk
+		 * load pass; see bpf_object__gen_loader()'s own guard for
+		 * the full explanation.
 		 */
 		if (obj->gen_loader)
 			return libbpf_err(-EOPNOTSUPP);
-- 
2.34.1

