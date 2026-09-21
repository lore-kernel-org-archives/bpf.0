Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06B51991C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790030400; cv=none; b=pAamMg/yNL5wegB4pVRj5YlUaudM9cRoKyo+JfV6DB6YACWHNz/thL4+zo9DaisMLZpe1sRX0/FyWU4PqPwPGliwwQhaLGxND9RKzl1XWXzXv4Mvd8R/m6ZiMs+q0ExU8cEzQ9AV0j5nNBFnmViGegcmZIrYGgV0L+WAgrCPIAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790030400; c=relaxed/simple;
	bh=34FOgJUv/VMJkUy0DVc9WJ/a83Lyw7MPljx5L4qxUeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgtEuWIsRuTuJ5CVoSx4rLSEJY3VdjsTtHAdNKO3Fpq2FEfjdMQa+MrziqqZeb8Gczhq3q84W0tD2d3HAXvu4zVcZQ0Gv+H7TLjQboagwOAG13GkgLhQ3QM4hbqXbY32SDVdpvTyeNWvF1ba3m0WkthMWREQyRqEVUS0NTmaWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=jusYSHTm; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="jusYSHTm"
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LHuiLK3819043;
	Mon, 21 Sep 2026 22:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=9C2+jCNv/usQzV///Sn7Ox0ON8OZV1AE2DWku2qMW1o=; b=jusY
	SHTm/woWZhZSxhRQybmBJPBoiqABRgkW71jq2xE8BpH8Cmbiw1P4SrG3499/Oe+g
	wfIr6HTLBg1UMycbf2zYKT2HMSuv+dZvG0GYz+V5ApCbbSRam6id3oKFxKPkjrmY
	1Yl18Go56lexDKY1BFjoDRQ2f79vFe7K5LbuI+Lx9rw6jnv5giUriYNbS+kjMnmH
	HZkD4g6SsugbWfIzHFmknFmT8QDKn6N8eE5eoGa4ODqnqzzgzwke9ia38D5bE7cX
	a/pGa6PKTL2n1tjFj4+rMupzaaxyd/bHD5SoEieyhFjszHVshYLyEv3CGpEXuHTX
	GGNMxxVKOQvivh4Srg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gu9e5rxes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 22:39:45 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 22:39:43 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>, <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v4 4/7] libbpf: Reject gen_loader for objects with already-manual programs
Date: Mon, 21 Sep 2026 18:39:34 -0400
Message-ID: <20260921223937.3203093-5-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH014.crowdstrike.sys (10.100.11.87) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-ORIG-GUID: iT6aXHjFQ7M_WCF5InrLtIofW5jT5Lj2
X-Authority-Analysis: v=2.4 cv=L/iI0OT8 c=1 sm=1 tr=0 ts=6ab1b231 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=gRXIs5T5hpNW7KenNA0A:9
X-Proofpoint-GUID: iT6aXHjFQ7M_WCF5InrLtIofW5jT5Lj2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX87PjygqPlyjz
 M7z7LKqSdcsQ79XtkLi8LDSXpCdnHMk/O9pOdHYjY4XcZ4jw7dQ5A2Qjg2saWXnRWeRjCfvhQkK
 8QJhlFjOejm1VWR3wVVgo5hG9R5fO1scHRrz2iqI2xzQ+blETYpD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDMzMSBTYWx0ZWRfX0LJxIPYct0LB
 H7AKNvVmCHwW9x/C9nvS2oTu48OXQ/vbDN2EeoEjSK7++6mSS8QAek2dbronJzWteCcrb4KEp0w
 9Q0Et/AfeMc3bdAnfprefX4x2tAeINo2djbWYNlx7L8ZvMwAD90e1avXnLMGkXFakslbFRGV4h9
 7ikf+0xp1Xe0A5n41uNY4RQ45S6TZ2gaYas2Ed1+KtoRhy93TB7DEwMpL7FSXt2YwAkPj3blVv1
 iR3gZLg25nasH8FCDjc4tsZhvp+ThUhhNgxMLP6aAWgsOlo039McceEMC4coajk08WP5CVMpgCy
 stKZcgMfZ0QcUqEiWHFktGypO0tvv3sRyGBgrfvwyg/q2bgYKwyBeqCSdW4MFdVF/BHlmWMyGpC
 B2IHd0XCg2SPD1koDHR/JFUeyJdwKWMcuvU6RqORSN0Te5MOYcSh7g5BvuqAZ1cffu0VzlhJ393
 9+tMG+iOjUhxL6kGf3Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210331

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
index 789d2df7eaae..6e7ec026d944 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9788,11 +9788,31 @@ int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
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
@@ -15399,16 +15419,10 @@ int bpf_program__set_load_strategy(struct bpf_program *prog, enum bpf_prog_load_
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

