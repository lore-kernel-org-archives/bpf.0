Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E923D7F5;
	Mon, 16 Feb 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771232901; cv=none; b=pEFQFNeKj05v/CQDkuJ/OCdqvO91nT+PsTzPO0ayTB36Q/sdnbWtwqX6WgNVf2FVfBH3v4FxBBYQly0XGoaC0pFBQe4aSxZB7rU6/f4RSPJq7Ak+E3nZRl/SkNf4c3RLZX+NiJORnWiOBuDJHCVvdQKsVKIIgm7laNfalJ0Hw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771232901; c=relaxed/simple;
	bh=EmsBpwZcswJp831dNKU5TIkfzO4uVWk/FxZY7FFgZZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNlL7PgRYRm/AqSXdth1Kz4hJzHN9uZsqc7W1oI7fwTFbzD5SsC47DkguMS5ilbqARIbTE6jyvX322prMADB7JEj3yf20g3ZIXPZgo6RCKbOHjg0BblqlkSvxgWCInw/34yVQgEbKKTZ4UBAYTTXYkWzQrrZOxZluCfXyf8UqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TL6rn1n9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TL6rn1n9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FM1Jvd3669128;
	Mon, 16 Feb 2026 09:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6hXNBiqZPkQbA6Le8ee7aa29addL5XUf1lWMgYRQj
	Ag=; b=TL6rn1n9N9Aum70yTltJ22ntjvMcfqWztrrbI6EhesvuWpVKqpzGt8zq6
	ry8R4ArTG4+APAAruT+WTDikwhDYJXeItWRiGGIolQm4tJ/F5mpaTPwHmXm2vNiz
	G3aTLS+Uu+kQsS+C/oe1OODw/7rDfZjpKOmDNiBd/JsEzpbQd7l10NcLhwLycLIg
	ZKTpRosoogWJvgWBOf+eN6JLBD2x0Ac/A9wRLz3+Y/vxsGpf1NBJF1u+JZGmxjqF
	j97SQ1RkbCl9Rhh4cHHFDGV+q8ZS6LzQAZEUurC+0euTyHK6xeMP3+vbkFi/Cyg9
	htuetmtsY0zT7DsaZNVdJlKnWZcfQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj6fxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8Ih5K002845;
	Mon, 16 Feb 2026 09:08:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj4hev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:08:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G984ih31785248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 09:08:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D349A2004D;
	Mon, 16 Feb 2026 09:08:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 807CF20040;
	Mon, 16 Feb 2026 09:08:03 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 09:08:03 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/bpf: test accounting of tail calls when prog is NULL
Date: Mon, 16 Feb 2026 14:38:02 +0530
Message-ID: <20260216090802.1805655-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: izJ6T4ANjzNO_Jtcwb4tZE7v10NiLpcI
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992de77 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=75Qkm2aBJpJ5KZQQUp8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3MiBTYWx0ZWRfX4BHKTMk2uXyI
 1uU8cRtPPLDOs/Vvsn/Gw6q2Mb9C4Oxb69W42eugDARzLAxk7XVeGYcncnXRw+NaSdmb0M8NayH
 pBOXQDIN9MdzdewFwNUhQ9yBaiFSpCTTxgnDhcAvNQQBQmojsYgzbyFSxN8HMZKHDHjgapOKCSf
 hZJ7+gIiH/0GXHFopueFqBNaVpmUuoCjBpY+e+Oe9X3Yj+f3zfqsBPZUwGeVh7TeEfM76StcL6v
 SJfA4GoC80SK2ETCdPHNrmBHig9YWlYrN2zEKGbLVreuwM5dFprcrdT9KfuczogOWamrf4HOG+c
 QetgGyWajJlCNv8B/bQsTnEAXTb1cBCz99Adv2hXmtESJHpXmgrPa23e3QkkAaRfUEBm/EAtl1p
 VaiREgvntBqlMYl7mmuWbSQm12px9siOjrRjo6UQJTkGQevM4YOfGjiNyZlYn+T8Vp8Lcj/aQC2
 mO7H5sXOEwlOqoJxH8g==
X-Proofpoint-GUID: izJ6T4ANjzNO_Jtcwb4tZE7v10NiLpcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160072

Test whether tail call count is incorrectly accounted for, when the
tail call fails due to a missing BPF program.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

- powerpc64 BPF JIT has been incorrectly accounting for tailcall count
  even when BPF program to tailcall into is missing. A simple change
  to one of the tailcall selftests could have flagged it earlier.

    https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.com/

 tools/testing/selftests/bpf/progs/tailcall3.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/tailcall3.c b/tools/testing/selftests/bpf/progs/tailcall3.c
index f60bcd7b8d4b..204f19c30a3e 100644
--- a/tools/testing/selftests/bpf/progs/tailcall3.c
+++ b/tools/testing/selftests/bpf/progs/tailcall3.c
@@ -5,7 +5,7 @@
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__uint(key_size, sizeof(__u32));
 	__uint(value_size, sizeof(__u32));
 } jmp_table SEC(".maps");
@@ -23,6 +23,9 @@ int classifier_0(struct __sk_buff *skb)
 SEC("tc")
 int entry(struct __sk_buff *skb)
 {
+	/* prog == NULL case */
+	bpf_tail_call_static(skb, &jmp_table, 1);
+
 	bpf_tail_call_static(skb, &jmp_table, 0);
 	return 0;
 }
-- 
2.53.0

