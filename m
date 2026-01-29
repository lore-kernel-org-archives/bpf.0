Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB4290D81;
	Thu, 29 Jan 2026 05:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769663489; cv=none; b=VtkUL7GanAvUAO518eAilzzFU0Id3yF+FzSK5/dPiBLe9j0hvkdUYN1o0OT5aFvpGKs6XuBseNWqA9LFE2+bQ6KD0lmuDkJDc1amEETB16USFhFzoY+NLlnAoUrxQ4haVvFb5gLH09hZoUuNSGbVdiW3AfkFSxBIbsPhRgPI4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769663489; c=relaxed/simple;
	bh=l4YOvOYeQfbJPbvW/6BVCJAK0sIoCxpWbPYBm0pII+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXLJLlyIsWC0BjIl8uN/Mbf3HkG84bnGVFG/ScmTiy0Sll73bl/xfqeuroAX9bqq3y2ybbYuDb0FpUHHhSqjQNkT8W5NE0wzP8vhmrwgBejGhk+cKaxuwgEo+mRqdWgoQtTuY5exnZW706nyZuu5zM4Xzmko19xWgDkGl3Cmqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f4NAJSpM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f4NAJSpM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60SLbEe5011220;
	Thu, 29 Jan 2026 05:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5HMp74l3nXZmihzZGDOA6kp8Vkxvva+IyohqlmChU
	7I=; b=f4NAJSpM7GBNhk8/2DbFnJv2+d/3XIn8+QPS5UOsja1CUY4SII1B4StFv
	picj5JJcxlM+oyGuFYfhWqvf2x5Fh21lASH1GAmKM2CRajfkBxbxgIVrbV+MkGZy
	RzyqyoPyCC5xb/JTSIv0AG1qmWIzdF7EnjEyFc0jxShG+7MQBz34n3Et8Mart/5S
	bfN6IaObPpxyUHd1Fo9hucCOweDi+nKXNaQ2Z7kyW7Z/IaCMzDt0LZ92k6pKqDo0
	JzDMNNhGuGSgeR66TTaDdK2p3/RueR0lfhjZ2EtVfXd8B7TVZS1yBySlgSAPiemr
	g7oyXcw+aipvTYQ2saoUVnc3BnvaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg4jx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:10:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60T59xST005801;
	Thu, 29 Jan 2026 05:09:59 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg4jx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:09:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60T2H3CF018238;
	Thu, 29 Jan 2026 05:09:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb42054q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 05:09:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60T59sqC31326680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 05:09:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C005D20049;
	Thu, 29 Jan 2026 05:09:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FC0820040;
	Thu, 29 Jan 2026 05:09:50 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.in.ibm.com (unknown [9.109.207.131])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 Jan 2026 05:09:50 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Return -1 from get_preempt_count() for unsupported architecture
Date: Thu, 29 Jan 2026 10:39:49 +0530
Message-ID: <20260129050949.157410-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697aeba8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=kBCxnNGEB59kz7Bupv8A:9
X-Proofpoint-GUID: cP31cogwq2tLo8eu0HRCw-dpwrdE4me8
X-Proofpoint-ORIG-GUID: mlJ0k09fByYYuswVLyz6fTplnwpQHrJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDAzMCBTYWx0ZWRfXwpqtR7zZ/Bv+
 V+5AAdxknApBapzrCwYohBZDayjxgZkoqa9FrxqVGp14Wv0D/xithrdG3bJg/AikXnNL6sOJJOP
 A6CEm8G7ulrfATfIbImr1KlM1qI7Y3fKujWHfzJqHFzDADAc0Jrda9YpOQC97drkOHv9GTn7pmH
 Aa+7YE/Wrp0G9I86/aKyzEVHpWJzoHGbFyWznb0DJ7N4+08j4KfktvEq7DSFLv4SZIBTYdqfnYB
 cSosRa+YSsFAhKHyeJ9qOfOpT4ej06M5FPcsbESWsMuYSlLR0hW0Ar1hCI4A+mIiiFegPoAstLn
 VseTbCaQ+077XEqMKIjJ2u9dk34sDfTeZ97BW8yfTvLyTTyEma3zKeNiCkqH67zoK83I6m9JLZo
 2g4rpK2v9kxGOzXvj5oB667Zby9Ag7J7s3Mv1nKyzf9DDPyyR8yx8OGDJM8axgavZfoeVYtp9Il
 esTfK3E3b7l1DqxZe9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290030

Make get_preempt_count() to return -1 for unsupported
architectures instead of 0, so callers can distinguish not supported
from a valid preempt_count of 0.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/bpf_experimental.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2cd9165c7348..6759d2ae6151 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -631,7 +631,7 @@ static inline int get_preempt_count(void)
 #elif defined(bpf_target_arm64)
 	return bpf_get_current_task_btf()->thread_info.preempt.count;
 #endif
-	return 0;
+	return -1;
 }
 
 /* Description
-- 
2.52.0

