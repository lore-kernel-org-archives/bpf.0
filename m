Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AE139934C
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643675; cv=none; b=o+2NfCCe7n8bXBz5vhgYGAzMPOFxxmXT1F+OmGHJAWqPTaMARtvE/Rk0bvs0CdtKOcNEuqgnuxk1LmpAtwIiWrW+8d4baruk7f/KK9fp5xUGnQ73xw8DW8uxWoC2MTPc0kbp67IHL+9ZDN9GoB95zDOD4aKCX6cHRy1+BFwX1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643675; c=relaxed/simple;
	bh=93seZE5kY3elrrC1HFM4AxjJZsxq7w+sLS2kA1A7kAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+EET9gZ9Lmbae0OeGp1mhmeZcuZtldCbo36TyXPUpFpIYsco2ihomYrLPBD96w5FCqDGffH4qe9fStYbeZc6ZRaUfmLD5Mbh20f9DWJhT5TIcSWJ3+D7GfSsMl8rQYmYLROpYAiEMg9mB7+XjYbxeao4kS9P0u3s0WdKEvT/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=r6rBehUf; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="r6rBehUf"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKhaN1828981;
	Sat, 10 Oct 2026 14:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=Xved4twHt78jP15H6/0qx76YxoLF7HVJXf2xLdyepGI=; b=r6rB
	ehUf9WqrBSdB6d6WXi06YQhj+EoyCe43QFxRLwQ0gC+zqpc2pxE9KVFYW1iRQCtE
	5lSpWH2O6MXszR+Znc0rHs8Nbaq58VOI1RGxnqYfwz6OOZtTYg24Mqe5eMWIk8H6
	Vkx5xXqldsA6b0+mffMhAz0RIWNcsHa9dB3+hC/WpqczUmGQotNfx5/gOHmHWUEV
	iWcC6bkNVznHkwQldGXLcj9Ocx887dguZQjO6dp0Rgns0aOOUHoQAUB5abfm8N8m
	fC5crgdbtFu0PynRVnCt7fhHRHW1cpE1yx6P4A+lLjB37UuR5HY97wook5EzNto1
	8ltxV3JhMn/xlrk5eg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74uhanbv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:05 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:32:04 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 7/7] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
Date: Sat, 10 Oct 2026 10:31:56 -0400
Message-ID: <20261010143156.379864-8-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
References: <20261010143156.379864-1-andrey.grodzovsky@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX482kb7vUlkk3
 UGEtREF95bwQsJiO4umVGTeCWs3MClys4AU3U6gyKHiGKR8PAd0PLlJ7LP17UTeWkCJigKCCRzU
 sIeWnZw+qscgk8tIsGF7E2lzLIgBfnIiwNIRPsegOXKSQAym3XfbN3JC74GRmqrlHHaig9l5VMz
 Hs6ZMpvK96WXSihpFro7Q9f0i8kDfn2doIvFfCRzNDTyIkUQWurLwFDarbbWf7kVai8s7LuGFmz
 /DpS54ojFfpiyG6DSl7qWi6gNWAP3ndlwnKFqdCqifeHMM82l+nD08Ap4svwU/C3p/cSvZDkBJw
 9zvN7Mumz28TWT1u156XfzjLCIfyBP36rJ4lbZebNMXppUP8P4cBU12YB1VvujDS8HKfmXW3aqo
 RcB/PRzbNRzu+hSSL/25DKkyzn/OOpgZTYSXMsDm+Fpnd18aAX+kVSMyaGJx2JaMHLsebsdyA1o
 GFNfiSCJ34agsHByO9w==
X-Proofpoint-GUID: jhQ8eV3jAk3n3XgqkAaaikxdT1-_CoDS
X-Authority-Analysis: v=2.4 cv=DOcacCNb c=1 sm=1 tr=0 ts=6aca4c65 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=SRqYExgKO4NbpJmBA6UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX9NnYutoXZQe8
 RZTHtbZnoayr6JNJ+OtRlokqQJASJ2LGKxy5tvC54Ueni/JkF+vLG47l2eCQ0jYAjzHxla0LcB1
 30LElVxEqF+nHPW6jrzCb/IZRvIAw31J4AgG4S9RSsvhFdXCvoL7
X-Proofpoint-ORIG-GUID: jhQ8eV3jAk3n3XgqkAaaikxdT1-_CoDS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100057

veristat used bpf_program__clone() to verify each program in
isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
bpf_program__load()/bpf_program__unload().
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

