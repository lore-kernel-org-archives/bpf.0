Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842540DB4C
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206192; cv=none; b=gMzsuc3wNTGYglysZH9cbLoX5SaD24YfvgOTxgvXY/dLbpZwrbAUbVgxOHjj9aP1+ZiLl/C9SUlXfWis6oA1XEMd26XWn5VWoL8wiSO4IOsfO/IJYO2FUTIg99dRk/aRHvJDbE/zbl8L6zroYwD1f+Tdl0XznVcjN+lksmVRsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206192; c=relaxed/simple;
	bh=dTgoIbnw7TLeNDrNn273NkVwNnH5aut2fRhrtujWy5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXHwuvpZ/dVqtkvQHr5A0t44zmaBHVK1C0JLXQB3S5Tu+JdiOv0RiRK+gneoZLG20RqESY40f0KOCzUYirzhPb3jPCUMIzurCEUsdNTGrqACw4a76VKb42/hIUhbIz9OSL1qWYpLBLwq+/UIZV0ODYD5g736BVkNJXlha+3gVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=kWlJ5EfL; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="kWlJ5EfL"
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NK436r405551;
	Wed, 23 Sep 2026 23:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=YD35DE7S3I8VV5QQI8fYDwDL+T7H3KGIjlj+JdBJ5f4=; b=kWlJ
	5EfLZVCkTTKRV9L3pdSjHS7o7OYCKwnTmGRFRQCykIts9CZQytjy2pGeO/arqKQL
	oeZdJPLS5Gkz/eDeqCHF7O4KkIfDpXWuEwqwsVhOUtXTh1KjUFBjVuPzdAgwN3+J
	GsxgQ9iPInyRk+JO1Z9n603H9PgcO/LBpFBh75qQT0ey428VEm+wZvEjHQebT1NT
	Y5r9gZp5YXvz91GlMnfWBsTvClpEVvHgxa52zTO6naQopaIq0Lx+Nsgk++ciau+Y
	f6TSTwnO/tfGh/uwjpIkwJeGKlyLb0tsUjrh3TGdzIl8YgnvQpbdAdTpRQWOiFdu
	1Jno/EQeQYRUmmiXng==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4gv0wedf72-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 23:29:48 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:29:47 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
        <linux-open-source@crowdstrike.com>
Subject: [PATCH bpf-next v5 8/8] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
Date: Wed, 23 Sep 2026 19:29:39 -0400
Message-ID: <20260923232939.1886328-9-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=eJKGH3p1 c=1 sm=1 tr=0 ts=6ab460ec cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=SRqYExgKO4NbpJmBA6UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX7uLxZuhvVAe5
 97DT+0kdturbsB1qnl1jL3hnveLgkzNUX3JWZMSPHzw5u3QH3O+N/aifqoBc+IsxMAa4FOPtJlm
 jWKjfeK2zFmWKwpyUY3aBdCUvBOKufwtumkP5YeI8MHdbFic/ucE
X-Proofpoint-GUID: i65x9V0-tpr7PD7zA4y6U8Q6QGcjBxkD
X-Proofpoint-ORIG-GUID: i65x9V0-tpr7PD7zA4y6U8Q6QGcjBxkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NSBTYWx0ZWRfX3wWq7vsezs+/
 qH5F57jpqoYougyr2oa9ABPnDZSlp0FCHYCxwmQs57Yg1Cnfl5BkMfTydq7QAzeO5LhxpJpUnBF
 14xunJJOyi+jJR9sp4ARrVHMhM7GVwAFiG9kBiUdNjV7YSKam/9f/lEyQmDaeiZzxzO3gxLazjo
 +7tv1kkMqBqxhhiPwM3+2fBSG/C7o6RObzbyOYk0OotPLHNxCeIzosw1DFTi29/wJc1TRfOqUwe
 zywmAxDfJoyaVNbS6wJd9pY1DZ/g7hClTl4egwxfIS7ywXB6vWZAbFMS7Da1TVh404q3NjlmzIG
 khwR36+gkknWfjnyPrCGlDOXl7Ck1umEKkfWrh6oWB7VdRrCIxSN/hsdk2mLfPZvkExPpZm+a11
 zEG0+dkdgJtRVCzUhE63kq7sS2xgK6/H9pZqbbgKcU9iEEyITf0PVmakv2FmV1GN/lbfrwSRff0
 UWDC884jcYhVlzLvc7A==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230095

veristat used bpf_program__clone() to verify each program in
isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
bpf_program__load()/bpf_program__unload(): process_obj() marks every
program MANUAL and calls bpf_object__prepare() instead of
bpf_object__load(); process_prog() loads and unloads one program at a
time, using bpf_program__set_log_buf()/set_log_level() for the
per-call verifier log clone()'s opts used to provide.

Unlike clone(), which skips binding RODATA maps to avoid mutating
shared object state, bpf_program__load() does bind them - but each
program is unloaded right after verification, dropping the binding
along with it.

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/testing/selftests/bpf/veristat.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9cfc9b4b41c1..0cd19b59037f 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1678,7 +1678,6 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	const char *base_filename = basename(strdupa(filename));
 	const char *prog_name = bpf_program__name(prog);
 	long mem_peak_a, mem_peak_b, mem_peak = -1;
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
@@ -1726,18 +1725,15 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (env.force_reg_invariants)
 		bpf_program__add_flags(prog, BPF_F_TEST_REG_INVARIANTS);
 
-	opts.log_buf = buf;
-	opts.log_size = buf_sz;
-	opts.log_level = log_level;
+	bpf_program__set_log_buf(prog, buf, buf_sz);
+	bpf_program__set_log_level(prog, log_level);
 
 	cgroup_err = reset_stat_cgroup();
 	mem_peak_a = cgroup_memory_peak();
-	fd = bpf_program__clone(prog, &opts);
-	if (fd < 0) {
-		err = fd;
-		if (env.verbose)
-			fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
-	}
+	err = bpf_program__load(prog);
+	fd = err == 0 ? bpf_program__fd(prog) : -1;
+	if (err && env.verbose)
+		fprintf(stderr, "Failed to load program %s %d\n", prog_name, err);
 	mem_peak_b = cgroup_memory_peak();
 	if (!cgroup_err && mem_peak_a >= 0 && mem_peak_b >= 0)
 		mem_peak = mem_peak_b - mem_peak_a;
@@ -1774,7 +1770,7 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	if (verif_log_buf != buf)
 		free(buf);
 	if (fd > 0)
-		close(fd);
+		bpf_program__unload(prog);
 	return 0;
 }
 
@@ -2297,7 +2293,7 @@ static int process_obj(const char *filename)
 	env.files_processed++;
 
 	bpf_object__for_each_program(prog, obj) {
-		bpf_program__set_autoload(prog, true);
+		bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
 		prog_cnt++;
 	}
 
-- 
2.34.1

