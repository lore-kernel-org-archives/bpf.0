Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562911;
	b=ZZI0COoYOlBVYc2HUMxvC/oy0MMXS9D85fqNP0mzYD1cFyGXe7DqiPqgKxGUb9QI0rXS
	 0Qe+fgPfDtAVB/ClW5ZEXvZPIlHZe5w+Aa87beZdZz58s+zcB8u6TkYg7Nm23pUtVBmP0
	 vWPoX3PhF4en7GwGuGApn6YcsGjfVglwKmTY2xyuCdwHXhVodscKeEF8iTHZCGC3S4TNQ
	 Y+sVDdITg9XDAWeJxVDo/Hm6YLPjQK7xaYnBJALMJRxOOvK1dMn07HUmO8NTfT1/l6O8F
	 e1EgGMKl2QSpXyc2JH44l4ayHTjRXnXoudYXnbZ1GH5IpoopO3Xr5z0hL8YvwQ9TaPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562911;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9d0fEb66lWmW5ch2zGpXwAQ7HnAJP3BSBlHtj7F9MUk=;
	b=ezts3NisxjwgchMKUxvlM6l2D8Q4kAeNKAKIigQu3jDFU279ShrZv0ZIFRqvw+8TFekF
	 KKH+O1Ok2k0QXiZFa9ctD1tQuK5fXethwpM+JtKUQxFqmO7w8NrwErWn7Nep5LRD4eqBo
	 Vmk590Un6I3WKksxR7DhvQWALHmRlA0OJ1nbGQB/pjVN8scDcr4IN9gvGUVeP3DL4auNa
	 5MG+vPGMYGx4rESaTgWH6VUUOOFIWMwUMU/sjH2jN/BwuQYkFbOWhasBOZ97LG+ije9BU
	 UmeBnjwOjJZ/ZUUaspm7ew8apermiozCLdq2QJefEw7SOaGVQYfF8Ip3CT4XlgUFxUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b="KE5EI8Y/";
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5E60A2603
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C5E60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=KE5EI8Y/
Received: from pps.filterd (m0354651.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1F06rm3901218;
	Sun, 1 Nov 2026 19:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=9d0fEb66lWmW5ch2zGpXwAQ7HnAJP3BSBlHtj7F9MUk=; b=KE5E
	I8Y/bC+pmTu5wUNvL8BNFC9jgMfgK4smfYraIKGR5GsqPgD6SIvLmL2/fKg9ty6R
	Pjg5tc20QWkzFyfAnPHCF8a405wwDMbRGFCW9cLqOzsFDRwJk8Hj14Tnijp+wZVz
	2az+8tEUF4wxSQ4DkzqpTzqrtW6+LsZZamQisaGnpiZKlbIEkhU2XPqTuHurDSqf
	CiGfCw0OkPAFB5+w3ib3lZwMaCJViPIuESAZp8QAZL02vj417dUPe2J61mAFxCpe
	eu8QpRzeDINe7oAcMV8RnSBLtQT3iXTDPjyJlJD3wxPOcu1Kq7oUs/D+zMdpGEeV
	f73T3kMEyYmJH0Z1oA==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hnuk01p9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 19:54:58 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 1 Nov 2026 19:54:56 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Test arena autobind with BPF_PROG_LOAD_STRATEGY_MANUAL
Date: Sun, 1 Nov 2026 14:54:52 -0500
Message-ID: <20261101195453.3859308-3-andrey.grodzovsky@crowdstrike.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfX1BkKGr/SNEE2
 MAuyTe+Fh6RBJFKhhIEwpzuTjohU/jMW2qG28oU5o3SYPI3MrFBNm2SsYBgLFXzDgn8uXfcH04i
 ek6CZ3ILn4wNNLDBqNy/m7xBihtgIfXnLO829aqw099xNleYvzYF
X-Proofpoint-ORIG-GUID: zy65_YtPZoxhBE5EkR-_k8GSrdPXGEic
X-Proofpoint-GUID: zy65_YtPZoxhBE5EkR-_k8GSrdPXGEic
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfX3rxMk9A5Vcu+
 zetR9BKv1n8NJmstg2jTbESoSb9ob8S19iZBkQIBwoalpLzxjw4pFhFWYozUZLxgAYPIKEwZdv3
 i0xmLeZ4GYPg0L5eW7c5jhTBNzXEQ9IaxYLPwMWOCDACKZONsmYfqihwbz0Vjt0ztxog+aYhp7a
 QhNIyF3FgQK6JG5L7WkedEqA1dF/q4tN0Ous18RHtiOWLsUYg+xNb0mFiHDoY2HahdAPgQ8Hjni
 +UwkClcTCP+t26gaFCd2HeiLwws10lcXLDFfhK5Qu1KfHrdRicvC67thEUi3Oiu2VGujZJ+Vr6u
 JNovsyq+YX/5hUR18dPSEzZrltEGnf+giqCMqc9+EsG5ApTQrMt9c+zrQ4z/sV7Rxw2gqtrtL+8
 guErwOXW8IbzRkY7Wb05xU7DUYq1w1HxahvOXSmfPYPu6urmy6kRthhF3grdk7aJW28k7tYd9CJ
 LcPYkr2ctLA+ouI2B6w==
X-Authority-Analysis: v=2.4 cv=OaINnRTY c=1 sm=1 tr=0 ts=6ae79912 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=b3B37AjAgz0HnGB3MuNd:22 a=pl6vuDidAAAA:8
 a=DM_DfuoHlUZaQI8iarQA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611010079

Add an arena_autobind_manual subtest to struct_ops_arena. It marks every
program of struct_ops_arena_autobind as MANUAL, prepares the object, then
loads each program with bpf_program__load() and checks that it is bound to
the arena before unloading it. This is the same check
arena_autobind_clone does for bpf_program__clone().

Also reword the arena_autobind_clone() comment, which no longer refers to
veristat.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 48 +++++++++++++++++--
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index e7580b9f0fc2..a8bd10bab5dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -192,9 +192,9 @@ static void arena_autobind(void)
 }
 
 /*
- * The same binding through bpf_object__prepare() and bpf_program__clone(), the
- * way veristat loads a program: the arena takes slot 0 of a continuous
- * fd_array, next to the module BTF of the kfunc the trigger calls.
+ * The same binding through bpf_object__prepare() and bpf_program__clone(),
+ * the arena takes slot 0 of a continuous fd_array, next to the module BTF
+ * of the kfunc the trigger calls.
  */
 static void arena_autobind_clone(void)
 {
@@ -225,6 +225,46 @@ static void arena_autobind_clone(void)
 	struct_ops_arena_autobind__destroy(skel);
 }
 
+/*
+ * The same binding through BPF_PROG_LOAD_STRATEGY_MANUAL: every program is
+ * loaded with bpf_program__load() after bpf_object__prepare() and unloaded
+ * again, the way veristat loads programs.
+ */
+static void arena_autobind_manual(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	struct bpf_program *prog;
+	int err;
+
+	skel = struct_ops_arena_autobind__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open"))
+		return;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		err = bpf_program__set_load_strategy(prog, BPF_PROG_LOAD_STRATEGY_MANUAL);
+		if (!ASSERT_OK(err, "set_load_strategy"))
+			goto out;
+	}
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "prepare"))
+		goto out;
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	bpf_object__for_each_program(prog, skel->obj) {
+		err = bpf_program__load(prog);
+		if (!ASSERT_OK(err, bpf_program__name(prog)))
+			continue;
+		assert_prog_map(bpf_program__fd(prog), info.id, bpf_program__name(prog));
+		bpf_program__unload(prog);
+		ASSERT_LT(bpf_program__fd(prog), 0, "unloaded");
+	}
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
 /*
  * An arena exclusive to a program is bound to that program all the same: the
  * kernel checks an exclusive map against the digest of the final program, so
@@ -315,6 +355,8 @@ void serial_test_struct_ops_arena(void)
 		arena_autobind();
 	if (test__start_subtest("arena_autobind_clone"))
 		arena_autobind_clone();
+	if (test__start_subtest("arena_autobind_manual"))
+		arena_autobind_manual();
 	if (test__start_subtest("arena_autobind_excl"))
 		arena_autobind_excl();
 #else
-- 
2.34.1

