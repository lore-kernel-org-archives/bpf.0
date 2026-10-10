Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5A26ED3E
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643566; cv=none; b=on57aNNQm9aMuEQIbkuMFQEJkM3SnYohqI42X30rPeLCVEyJ67s+UqLkydW9unMx29B6OQINKgJaqhzd623kpJuZ8flIXRr+UA1X9865ZZs86AFIt67VU7C3XzMInso795Y/It8a29D40BF8HyqqUyhyKu3HHtxlTkiTJrDOeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643566; c=relaxed/simple;
	bh=KGTQ6VydaVM7MBtM+4bOMVSwqIlWc+yQ+xGWH/g3w50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUb4ay9NHUDbmFJZbNG8vzZscOHEz1HHCfTDwFeB0SJhrGwPOxK0ZU4O7xzOvds+ay4PN72+i8ZWmiDOw9vI4E0X4qORYsooZE3P42+qWtdD0HYcmFY3HRARFUyCVxf11vlivauhJx+bzg9mofvDqqLGArTQe1G8daMwUbJsYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=XYVlhcJW; arc=none smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="XYVlhcJW"
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ADKm8J2198634;
	Sat, 10 Oct 2026 14:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=5tegUWk6e21JjVV/lhhuqG2+C+L7mJFLHuEu+40Qf+U=; b=XYVl
	hcJWFtjsgTYsvdAYE8n8NChdCHsUh6+cAxbbmAgitBLbrbsABZuRc5gk/Aqg34YG
	CCrhmNrQu0zSjfbu1YZ6y7q2YhbU9NxfW0WRyBvqgZq5ThhJ1YKusXAMQmfermXx
	WHFKT/gm/kB/DsdGFWaQGd6X/jYEgtRYHJzWJrGPtQmoWhdQG8jxcp/2fL9JmrgR
	5XbaYJXdkgUnvX0HKdAwwwFqtonDtw6/hO6SEmee+ZjCxbijAN3CHMSmpL5fSd4R
	r+5JmksjHl4NYxF8KCf27Llborfd8UPF1GuOlgydD/LJJ/tfyRF5RXqvztmqLmTB
	oqZYnMgW6e53zEzfCw==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4h74ujtjjv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Oct 2026 14:32:02 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 10 Oct 2026 14:32:01 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>
CC: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next v6 4/7] libbpf: Support declarative manual load via SEC("!...") prefix
Date: Sat, 10 Oct 2026 10:31:53 -0400
Message-ID: <20261010143156.379864-5-andrey.grodzovsky@crowdstrike.com>
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
X-Authority-Analysis: v=2.4 cv=A7H5rKWG c=1 sm=1 tr=0 ts=6aca4c62 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=R_n4Uisa8axJ7jemP0ek:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=T_vuX43d8AknE0woFHgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX0ZYin7pKqhx5
 k0Ig72I1e49jbK22A9fqW+yHO3w46PiX71McdeklkkDsC2tr5nzZHRleRrMSk3lTRBGwrp272VK
 HIuEPZ9vvmH20HDkr3ckdfYzfH79QMUwgWxDy5QbNSnpjJg0biO7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NyBTYWx0ZWRfX3bBVd1205xSZ
 X/OAU1iN+RNJV7oOeptXsoVtIhUsnEUH49weXtbh96p6d20mnuO/q56dT+LoQE3MUYzV9XyuM4y
 48xyp392GL/r4xIqzadn9jcxyXBnYWKeGh28kgKDU+mu0fZmzwpbDhMg7y9kklhmMZcneDmF30V
 j0LLDY/HC/gyilJI/4L41teqv/7vA6jdzaztyUV8LH1dZ+xeqj3bonI0JD/GFQHolasgtgLrrG0
 xATHzSkv55oOo8rkyy6xt5AjKXfA/aB42x3c9rJLj2fuN84WL4dIzUFH/xV04RgBsalqK7dpTme
 4oKXjQByHu7N+6jVtJzd5axEXTA4KEaMIaSGcKLEmvwUYMgVVR45q9ZbmqZh3rWMOiDG0KWwG2v
 K6ORNDTSDl/3osTHTBdd039EcIuJLUPUYIbg9Zd1FvR2eJtdv2n8M3upL9Lui5VDQnQhA5/YfJL
 hcu/fozrFVbb6ejd6qA==
X-Proofpoint-GUID: gKYXe5hFsR0mJOcjYU2113Z2gLak5zWv
X-Proofpoint-ORIG-GUID: gKYXe5hFsR0mJOcjYU2113Z2gLak5zWv
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11931
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100057

Add a SEC("!...") section-name prefix, letting a program declare
itself manually loaded in its source following the exact
convention already used for SEC("?...").

Assisted-by: Claude:claude-sonnet-5
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
---
 tools/lib/bpf/libbpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 42fb687a9795..043f220ebb13 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -968,11 +968,19 @@ bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
 	/* libbpf's convention for SEC("?abc...") is that it's just like
 	 * SEC("abc...") but the corresponding bpf_program starts out with
 	 * autoload set to false.
+	 *
+	 * Similarly, SEC("!abc...") marks the program for manual loading:
+	 * it is skipped by the bulk auto-load pass and must be explicitly
+	 * loaded via bpf_program__load().
 	 */
 	if (sec_name[0] == '?') {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_DISABLED;
 		/* from now on forget there was ? in section name */
 		sec_name++;
+	} else if (sec_name[0] == '!') {
+		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_MANUAL;
+		/* from now on forget there was ! in section name */
+		sec_name++;
 	} else {
 		prog->load_strategy = BPF_PROG_LOAD_STRATEGY_AUTO;
 	}
-- 
2.34.1

