Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.152.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562911;
	b=k5K1giwLRFn3uSUHqTNzOnDLGHT1yf1royOhWM2fUmugB7b3ctWn2debWrMh+jmNCqOX
	 MgA52y5FykR2VOiOIcsoKIJUBy2yoYTLhS+Fvrt92mSwbaBS5zExIeCFIRUUijkONIU+P
	 UN5Z/tpjeuvOkM8flDt9LEzWlfvxlTD9mWFLVTQKqaBiylinmHyR8sM8mNSYCfXtbKW3k
	 kqN3zss983SR5MM2IBMaBmnJZ/zsK6wvu7ffZFGuU4ncpOzxpv9ufdGmRk+UFntkqcCCT
	 v7q42qwsxOJlXlUcUNaYvfWazNoiXkrCHSK/ADaaiPxpyI2jnSmltkys74jCspX66Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562911;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h8ZP1jcnBJ69e4OgdKWiZGmv8o1kdu5671Gq1KeTvqY=;
	b=RDZOJbmZYYjSlZtSbtA6tTPBCt36SJ6Va2sZekCfXrf2tz8pM35NLD7LmeV2F7F8fZf0
	 W/Ln1M1ul2T/BAykiPwd73Qp/+19PuZkEsHhpjKo8e4HSafPYahaJtBM+9NG3tIBxLZSc
	 exRx/PTKbWaYp/+CWTz3Oo3GdQYhHGHv9gbdcW1AZoLbUNGA7TuDaum9/XK9u/Sk2wzIC
	 q1L0ED0L6yyIBBsaiFFewKkKWT+Pz/WKpL71KcbbFQtuKaqpOkJYlIfbRXltrWba3ETu2
	 gFff7RaYdUExPobo03NoEe85n/ocwf2IfIaQKz8YMUk4sdJ3SNHF9jS9SRDGNjlWWyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=lWSZCyoq;
	arc=none smtp.remote-ip=148.163.152.16
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB7606A33D
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECB7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=lWSZCyoq
Received: from pps.filterd (m0354655.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1ESNUE2671675;
	Sun, 1 Nov 2026 19:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=h8ZP1jcnBJ69e4OgdKWiZGmv8o1kdu5671Gq1KeTvqY=; b=lWSZ
	Cyoq1gtQo3j8T6S4GpF49/UyTPsE3V/5OddK+FxnhPchwXQc9HFP4m0wBNSxpxQm
	QGqoBQ/D5ounEjt6lwMevZjPVTOQFk5gPAHrB3mzAS5hbF27F4kr7H1wE3f3GBYP
	QhYhT9A+n9l1ZTCPCZACUs4D6U2o34CVAD2611v4P77t067VZu7Ldyw1pseL+POs
	/OxjeHPsXaw1zp9lRsevbBFC1vIYB8y+lyRxTO85tR391vZCfSpy/D2GOvROuluy
	qVdwomNso/vyU36YVWNfoygVI1aNj8dmUexAXiU4HE5ds1YbK1I5LMsMl1bvoy3z
	ASnwtOWBh9Joi/MofQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4hnvkbhabq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 19:54:57 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 1 Nov 2026 19:54:55 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
Date: Sun, 1 Nov 2026 14:54:51 -0500
Message-ID: <20261101195453.3859308-2-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
References: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
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
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfXyKOCDa3GHkQD
 w13UiY007SCe7415ziId6MOzzoM4+OadKFseZmqWBClcxh7WqgAH5b0AomSuVrSLqRbKjCizsVv
 UYdy0SHRTBqTc9Br+hEx+hmED+IkLT529nujpuJwg9ivwAi1vJmo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfXxNfe4KqtY07r
 rDB0jT1NQk0zLL2tQO/k7dLZLxjdEFH/CWL6+NlfhDkQ5Q7eRcu61/AB0xmXBpJKU/oHnOUfWZ3
 OTYDgLnRSLeRPViKgdlZOnQdIY8wM7Bgvsct7OjobjiHZ75Ymh3e/YyARbLztOaklM04oSkPm9q
 L42raAtOqQvwTmUeQQa6/qZo8pT5n9Mqsch++mDcqumqs+aXUeQz2pEeUrAWRCUML3jkcSFP2I0
 N6VVUqhAaaOnOkd1qmy2rs+Pcx4Vr0YQ8Bf79A/G08SfcVEJDmFIn7VCLu2jmwJ80velaJOmvnc
 yx7+ulf1uDOeOOo3J7sPMfl6vAi9lXxrwQMm6RBVQU/i9+3AdHKJvg4qlkOUOvUhlYwVlZeyk8F
 ++m1p3LbLygxyK0LYfL2J1HmN4P2NZtcdXTs4EosfOh5sM50BVKgFmUHCpQ192dNF03HigXUASz
 nlC5HnxP8p09Rqwl6Lg==
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ae79911 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=vDKVRhTs-M86Ea50iKLw:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=SRqYExgKO4NbpJmBA6UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-GUID: hqmNAnAAUrJ0QdgzmuwFjIuFln4uGAY_
X-Proofpoint-ORIG-GUID: hqmNAnAAUrJ0QdgzmuwFjIuFln4uGAY_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010079

veristat used bpf_program__clone() to verify each program in
isolation. Replace it with BPF_PROG_LOAD_STRATEGY_MANUAL plus
bpf_program__load()/bpf_program__unload().

Unlike clone(), which skips binding RODATA maps to avoid mutating
shared object state, bpf_program__load() does bind them - but each
program is unloaded right after verification, dropping the binding
along with it.

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

