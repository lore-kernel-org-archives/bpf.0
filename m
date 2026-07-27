Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94743EB108;
	Mon, 27 Jul 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145138; cv=none; b=WA61Cr5BsV11azYBoVkJ3uO0ZGex3VXc4EZuWJlHDB6cOqKSaDWPeVBtc/2nE/moGMmwMvGMLgrO9m0vYlFdZflRoOJmq+wFDYyQA4PTVll1M09dg4rqyAUv+XMR51aR5p9Q3rozbn6xZnx2FZopFYVRyCGa2fuJLHAomsfGXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145138; c=relaxed/simple;
	bh=AopayA9zNkYR2FXzxybjKXwxDjCDHYa81cE63mIkark=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1ez2DXuvqnN4m5YUId7jWa7iDGcf1z2jXOJ8vzeYJ7gtSHaN24oAGYvQgBIVXOJEK6s/3PtzbuSf8boIBkOJI2L6Wd36MDkp4mMfO4Aliu7/yCoG3kIhJlq56uI+mp7K/x7Bs7cw4bXK3SEM5y9ghJ2JuvIsrkXee7bg52mG5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZzkXiltZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZzkXiltZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9UdKb1859634;
	Mon, 27 Jul 2026 09:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5oeNvXJxmOzvEwWOXjwpLUuLAopkHZ4zsqqNq8quH
	xU=; b=ZzkXiltZb3Fsix6UwIoTWQ3LbHeGuBY3yA+U6S6GPecWmPLMKxdQUiAzx
	xdSdhIioC+1iCM7MDmrpHycOd5EIPUWF4+jLPG8lNJdrS+XzWd6C8mAUiAQP7n9c
	lg2df7x5EX1k8GKt20iQKT2RjqhYZKtmroI1JgBo75oMOstb+2ae3zEjYivFoYgI
	RnthPaZgUjKBeIYWkSMZNIrK8E6XxjTgF9LbmAUJMonMgri4EaSuI+Yf+qfMyBLc
	bJgiuuH5P6dO4/BFPR4Dtn3FUuQT1pZ8qpthRv925RYpl4qwvw++aeB5CJEvSHhq
	YTAKCTfSNMaMXUxWxzd0MdqBrK03g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcpwv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:38:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R9UWnF004629;
	Mon, 27 Jul 2026 09:38:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjvss7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 09:38:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66R9cZ2Q12583422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 09:38:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AE7720113;
	Mon, 27 Jul 2026 09:38:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00A5720112;
	Mon, 27 Jul 2026 09:38:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 09:38:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Add __bpfcall attribute to bpf_task_work_callback()
Date: Mon, 27 Jul 2026 11:38:34 +0200
Message-ID: <20260727093834.2178900-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eDtZDZHYJFEuJrp1YKP2vr6OdRb2jrgc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MSBTYWx0ZWRfX4tUtMmcfGW3b
 /qAf0WYwW3ckeU9esXXDIOvPjkbYLf/aGmtv4XMzE+BUtTYa2LmVtKQrNd27kwg2DAWG2HxI+Yy
 mLSOkxotzqRjNIyi9srzWk31OovObI4=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67271e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=6ODzoUJai7YaroCwgDgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MSBTYWx0ZWRfX8veC44mydbOJ
 5JZFCujfrD9HGi22+So5Wn7eVOGxswG9KNT8ieOTnjtHWIWKOv8ypuHUl3EQSP8l8KM3PwegNZi
 TCkDaAyV+TuG++wReldaYDltJTE+Qi0K9BHrgRygQbE6mjnSzcUIqRxX8H6Zj5+GMtx5nSp5agI
 6KTPS01Wyrlicf1VF1/kFvD/XesZKr3Bt12JBEtCEEkdUMsTjNk9/Fardq0qpzFGp0AUyal0DU3
 dk1MHjRlU9ZkYDX9cCL+8iAOAb8oQaXMojZ8gmrOd2Z6/9+QFfRtwjfKTK1BANW+HDzz/o/Yd49
 wXq3mAoi+wgtnzC9ZGvugzdnZrOFjSax/u718O5vg80zTe6gc8NuPNUlCc+EqfE0aczi0juaeZv
 x/Yik0sBrvFo3DTJOk3HHgF2F+CW09XBV+trLOadjYkYwVKORAKwz0E9nBhpek1W4hfdRPlkiUH
 55K0w1/Pxvvgf9DMkvg==
X-Proofpoint-GUID: 4ffrbc_7TuZ7KLkOFn0ajMqsvwKB8T1q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270091

BPF kCFI support is optional for architectures which support kCFI.
If an architecture provides bpf kCFI support it must override the
default __bpfcall define (which translates to __nocfi).

Add the missing __bpfcall attribute to bpf_task_work_callback() which
calls bpf programs indirectly to avoid CFI checks for such cases.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 88b38db47de9..9bf82c9ea1da 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4447,7 +4447,7 @@ static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
 		bpf_task_work_ctx_put(ctx);
 }
 
-static void bpf_task_work_callback(struct callback_head *cb)
+static __bpfcall void bpf_task_work_callback(struct callback_head *cb)
 {
 	struct bpf_task_work_ctx *ctx = container_of(cb, struct bpf_task_work_ctx, work);
 	enum bpf_task_work_state state;
-- 
2.53.0

