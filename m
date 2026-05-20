Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6953F39C7;
	Wed, 20 May 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291656; cv=none; b=MkeYso+FL2Sgm2vUs0SAUnORqRtxJ0+i5qkXpNHcbPKQylGeZNZz5MLqVDhtdA0Q/WIwVtn0KdOux23nDw0BKyOr0xUEeSzYl0hPV1m5AGZrFqbXvFhlYFTbY+DSoWrLvDOt6n9+O9ksBkFMZDgFRzTqjIwHpDlgZFXqPlWK7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291656; c=relaxed/simple;
	bh=DDG6LWTokjCdp4UzdxN028k7J5ktN5XMEru8OAyKYwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMu0uoOUdsDuHZktbFzKKIpgdhu5qv1sbaipoJX/yfcayN2Thw+wgYOMmvi3uA7695kcjsRQ3yoMjG+OCqyXOMwQg4150iyOMPQ9/8CTBtIRd0OaRTx6uljRxmx0tY8a5Uo+AqMB7a9MZThyLh9cbbs3ph4LBUiyih7HGYssgKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mTr+uoCV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mTr+uoCV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K5Itqd271835;
	Wed, 20 May 2026 15:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dTUbK7erAEyEThYdI
	dixL+JXuiVep7aSC0c1ik+NOOM=; b=mTr+uoCVVoF/1i+h/hCWqBNPXnjsMOb9k
	hupFReay8nQdXo9NL9llKTwEkww6zR9HfR9/S000UJcLvn/mWzFZ+Ki8sc0JSoiC
	WeVZ4bAvx+g3QBfaQ/iresoTzR6qivLBvo+RIG/fLc0m6lOzFx6xEvu/EadBO8PT
	7X19JtPYbpktjnKFpXTeP3h6sDvQZkeE3zMBQMq+fYSYNfdcVZget0exkqDRWVOx
	InZCQEf5duwFQJwNCrpcIJjnGuDxnqri+MLX1eaZ5ScYNlu2pxjKvPCffulbyHGc
	GrhF486xBOJ2yUn2BHEYKbezhZivmMjnoKiyuLMqTrTli7nu2H95g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752ta7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd6ai031984;
	Wed, 20 May 2026 15:40:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk801g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeD7649217844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 219812004B;
	Wed, 20 May 2026 15:40:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93C252004D;
	Wed, 20 May 2026 15:40:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:12 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>
Cc: Jens Remus <jremus@linux.ibm.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
        Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v15 10/20] unwind_user/sframe: Remove .sframe section on detected corruption
Date: Wed, 20 May 2026 17:39:54 +0200
Message-ID: <20260520154004.3845823-11-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520154004.3845823-1-jremus@linux.ibm.com>
References: <20260520154004.3845823-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dd5e3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=yLRsOmMQGpVHI0ogWx0A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: veXC281t-x8pUsd_KRr4ocx8fXCOmcCb
X-Proofpoint-GUID: BXFZlkLxsxRGpSJbt-MqdCy5geQBe9y1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXztA7Qa75XLln
 /qY82xY+uZY2Bjg++7j2TKASy9G0ehTabDtfHznKosfWTSvoO9G+li0TpDK0/LMEmNHqdpvt19g
 0HqHY1yTq7HzbVRGQQ2pcLO5E9MgnNkoXq5e5vIXWupvSv4yfvWtjKPociHnYrSlE1eLfskkB9W
 9fEDDRZYq+4ZQMeGNkauL1op/J++0j60etavTCjHQOIbFArWSOlWzykN3d9xpCCbqqFkhvHTYfJ
 peRPAei9Kh86Dh3xnCSQInumGvYZSxZKVI/5E6dwDQzYW0USAV1Yv63dHOV5RsJ/lm5koXtpiSF
 xyx8D01OWEfeWpLWGdngDEXiGdtkBf6RJ1mB+eB7Z0h4lOiRCF9ood4IC69pUpuP8GuJE+IhuYk
 vwaNj78I4i95mRuPiPxfgxHbtyLvAKNk83JuJ5jqYVhv5DjzJF6hqe9vsD7bRWICuq+OYNxCbQq
 cdKoJ+U7jP9JShLOw3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

From: Josh Poimboeuf <jpoimboe@kernel.org>

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - sframe_find(): Align to normalized error code usage and remove .sframe
      for all but ENOENT.  Also remove if user_read_access_begin() fails.

 kernel/unwind/sframe.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f723c1a32f90..02331956009a 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -360,16 +360,23 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 		return -ENOENT;
 
 	if (!user_read_access_begin((void __user *)sec->sframe_start,
-				    sec->sframe_end - sec->sframe_start))
-		return -EFAULT;
+				    sec->sframe_end - sec->sframe_start)) {
+		ret = -EFAULT;
+		goto end;
+	}
 
 	ret = __find_fde(sec, ip, &fde);
 	if (ret)
-		goto end;
+		goto end_uaccess;
 
 	ret = __find_fre(sec, &fde, ip, frame);
-end:
+end_uaccess:
 	user_read_access_end();
+
+end:
+	if (ret && ret != -ENOENT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 }
 
-- 
2.51.0

