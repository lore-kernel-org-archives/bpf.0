Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013118EC3
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101486; cv=none; b=a1mHqdHwlBhuxHpaPbrEvAq1ajvv+TKQx8G0sCeN0ALVq9f52iuICTxjzIkD5xrJFDd6MKExG0dtHl7iQjtMfROECpVFFYbYKmVFdcQg53uiz9iFu1fmxWD0BQB7vOyg9v8YKiONpBwf7N/ERwPaX+vY7fnOSgLb1tRVhmM8bgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101486; c=relaxed/simple;
	bh=vLFV7F76/JVZpJeJYlhRcKAtHlTPSh+30SRk1mtpDCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cn9ByWl8eJeOqWHc0fco99XMi9nXTioj1eOdzOSOjmZrvr4bBmH1ky5OxJDAiyqc+H7wrY9/z1KuTOiwaXwIxe22tqYQK+WGCU9KpHDsfK/1cX/QpRD2j3EyXfMiBF6YJU25GaCD65vjfsXrdBw6iShWE1tmQWRWrjDoauM1h3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zyvvf6Ou; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zyvvf6Ou"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YJit008385;
	Fri, 22 Mar 2024 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=NR+i9tr8ZTnjbYC4xCbgGbJLuTlsaWoAqzTqAgrwr90=;
 b=Zyvvf6OumSK5azjrdY7LbZQIzqJFBQLz5wC/3JqJB9omvlQ1t/B8S03+tX1yil0kpH/K
 ShJu/LLDSesiecEC39ZwBBkDsa96KVVZLsj9Cw8043i9JTVu4L0rH7WdInDUpkm+bbBE
 b4pJoUj6sz5QnTMMCDri+IhUCg6Vdd+UZ34ZWmphORx0CqiIC0NAuJYyF3cXdch0KwMa
 5FvfwLoh2gITaxMTdUssiaccufpUn9F4bnO8J0X862NHQQB4R/6IRBhQZIh/1A9rykkV
 krmFEPAJFKUcSUKXDN7+MddXoeVV0RIE+y6ICQNL5MzOhxTFbaa1e4rFA6/H5S5bkFwe RA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvm8qty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 09:57:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42M9EHfw012671;
	Fri, 22 Mar 2024 09:57:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvfsf54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 09:57:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42M9vXpA006466;
	Fri, 22 Mar 2024 09:57:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-192-105.vpn.oracle.com [10.175.192.105])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x0wvfsf3f-1;
	Fri, 22 Mar 2024 09:57:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, eddyz87@gmail.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, houtao1@huawei.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next] selftests/bench: use syscall(SYS_gettid) as libc support for gettid() is sometimes absent
Date: Fri, 22 Mar 2024 09:57:28 +0000
Message-Id: <20240322095728.95671-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220070
X-Proofpoint-GUID: oedWY9ivDPOhFTKPHIUHUG-JCYrmab-e
X-Proofpoint-ORIG-GUID: oedWY9ivDPOhFTKPHIUHUG-JCYrmab-e

With glibc 2.28, selftests compilation fails for benchs/bench_trigger.c:

benchs/bench_trigger.c: In function ‘inc_counter’:
benchs/bench_trigger.c:25:23: error: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Werror=implicit-function-declaration]
   25 |                 tid = gettid();
      |                       ^~~~~~
      |                       getgid
cc1: all warnings being treated as errors

It appears support for the gettid() wrapper is variable across glibc
versions, so may be safer to use syscall(SYS_gettid) instead.

Fixes: 520fad2e3206 ("selftests/bpf: scale benchmark counting by using per-CPU counters")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/bpf/benchs/bench_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index b7aea79495ba..9c50412f72e9 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -22,7 +22,7 @@ static __always_inline void inc_counter(struct counter *counters)
 	unsigned slot;
 
 	if (unlikely(tid == 0))
-		tid = gettid();
+		tid = syscall(SYS_gettid);
 
 	/* multiplicative hashing, it's fast */
 	slot = 2654435769U * tid;
-- 
2.31.1

