Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F721383B9
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103189; cv=none; b=IcsRzUIHvcKYwPvBYLQ70d76pDzYCFfvNz2A7kT827DGURauMTqJmZvCneQbhW0O/RP6gHKEV7cyYUJ4JY61mjVUuFDWfKD8gooYlmCUrSmq65HnVNagQagk876ysHbgjXJTVZtAyckzBbfhzKs5ZsGTft3kzEIrnXnu8NxTwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103189; c=relaxed/simple;
	bh=qBdSKUV6UI4lvjHD0a7kDFiY26J77S/GrPIv9J9YKnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jw1qbH5sk4k4IsoRFzGKij/wsUhcbt76jvr3sbr93tToIIljAvqaps52GgKTqMOeoyT5cwEp/A5y+s1XT/v9lEg0IxwBRBYW/NLLxqTZMUnX0HqBfKThq2YMwS7KPWho02cwC/nxNCZcSi4bMRrL4rYV9lSFtkfMQoIKeba0A7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Kix4oiB7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kix4oiB7"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YqKj032321;
	Fri, 22 Mar 2024 10:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=kWfsBUrsa/VbSoOnKv3T23Ea6AOjLZLcdzisMx0qbGI=;
 b=Kix4oiB7xHeImPLMiwjBQpJFFNF4yRfuBoNWT0H8g8lPP4f9MIk9aJqq3B+O32mOoUBV
 7ow0NaA1UDj726wmJ5RdTUT7vEA0UJjNXUk3ybxsqj8mek/ynAMuzhHyspw5vnrcUjY/
 Gs/1Y2cUxQKbUnKoLIYuRSjXgbfdDslPcr1FAWYoPOxbh3MibAOok/CH0mzam9qCL4LD
 KB7tXmD1qeg/71z67wp7NXk8wCD0m5MZJJwnqvlFtISrGPm89Ooy4W+5sAcLuw+vs6fC
 XqyE0QRNQZaqnKiznJHXpRZgjdC0klHU1TKiMr6SMbFwN7nxrQp/2ZJnedCj7WLzSR+V uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvqrsbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:26:07 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M91WdG015063;
	Fri, 22 Mar 2024 10:26:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk2jfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 10:26:06 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42MAK0kn030399;
	Fri, 22 Mar 2024 10:26:05 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvk2h75-14;
	Fri, 22 Mar 2024 10:26:05 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org,
        masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 12/13] selftests/bpf: extend base reference tests cover BTF reconciliation
Date: Fri, 22 Mar 2024 10:24:54 +0000
Message-Id: <20240322102455.98558-14-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240322102455.98558-1-alan.maguire@oracle.com>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220074
X-Proofpoint-ORIG-GUID: vER9ljVgtZAm5ltVnsBsHQ3Kl0yB91EZ
X-Proofpoint-GUID: vER9ljVgtZAm5ltVnsBsHQ3Kl0yB91EZ

Ensure reconciled BTF looks as expected; in this case identical to
original split BTF.  More tests needed here for positive/negative
cases..

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../bpf/prog_tests/btf_split_base_ref.c       | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c b/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c
index d611167fa4b2..3f4382651fc8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_split_base_ref.c
@@ -158,6 +158,41 @@ static void test_split_base_ref(void)
 		"[16] CONST '(anon)' type_id=8",
 		"[17] PTR '(anon)' type_id=9");
 
+	if (!ASSERT_EQ(btf__reconcile(btf3, btf1), 0, "reconcile_split"))
+		goto cleanup;
+	VALIDATE_RAW_BTF(
+		btf3,
+		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
+		"[2] PTR '(anon)' type_id=1",
+		"[3] STRUCT 's1' size=8 vlen=1\n"
+		"\t'f1' type_id=2 bits_offset=0",
+		"[4] STRUCT '(anon)' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=3 bits_offset=32",
+		"[5] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)",
+		"[6] UNION 'u1' size=12 vlen=2\n"
+		"\t'f1' type_id=1 bits_offset=0\n"
+		"\t'f2' type_id=2 bits_offset=0",
+		"[7] UNION '(anon)' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[8] ENUM 'e1' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'v1' val=1",
+		"[9] ENUM '(anon)' encoding=UNSIGNED size=4 vlen=1\n"
+		"\t'av1' val=2",
+		"[10] ENUM64 'e641' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1024",
+		"[11] ENUM64 '(anon)' encoding=SIGNED size=8 vlen=1\n"
+		"\t'v1' val=1025",
+		"[12] STRUCT 'unneeded' size=4 vlen=1\n"
+		"\t'f1' type_id=1 bits_offset=0",
+		"[13] PTR '(anon)' type_id=3",
+		"[14] PTR '(anon)' type_id=4",
+		"[15] CONST '(anon)' type_id=6",
+		"[16] RESTRICT '(anon)' type_id=7",
+		"[17] VOLATILE '(anon)' type_id=8",
+		"[18] TYPEDEF 'et' type_id=9",
+		"[19] CONST '(anon)' type_id=10",
+		"[20] PTR '(anon)' type_id=11");
 cleanup:
 	btf__free(btf4);
 	btf__free(btf3);
-- 
2.39.3

