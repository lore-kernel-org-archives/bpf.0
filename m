Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DA33FB7FC;
	Wed, 20 May 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291665; cv=none; b=Ql78oy2KZ8pN/tEwL2DsITeKdCRNvxBKnMB87aRIt6+RQGddAR9rLqEjfzD96lh/rkv/PuMRy1zfX5mnAaRn7FyI6/mV+5dwSjdQ0uAhktuWda3Rs1ePw37oUlz077wo/AYvvgduSxW8OjqcDRJ4D+7jVRFxSL2b2cEdm6qnEWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291665; c=relaxed/simple;
	bh=Coil9KclyKK7MQZtjsj+zggHftTuc+AXqbu8taw5uMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmosNduN3qJV9QnUyw2c0tXUO+bxNfHdyzYDhPO4V+B1Gwwa+68eo+WfQkzGowZ8C6N1bpBzs7AiV718WmxxJoQk6j6DbMzuBVajdIwatFn1rDHZ5G9VAevInGd6t+gG2tLCIl9ud0hkrEYtcVtsoGeYtKTg3IuEd6Ft5R6e1+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DkbeqmY0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DkbeqmY0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6ocj7834424;
	Wed, 20 May 2026 15:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=odsVNex6R2VPSghnY
	Dx1oLCB8plgZo4cXgSkUOTP2c4=; b=DkbeqmY0FpKoye0tkduxW3umy/JdqbtxD
	6/xtJ+lGDCVdYMbJVcxk+y0crv4PoTalkDb0o7px6e4IiJHP9bDf+Pva3gOpRej0
	nFQ8/RH7jX+FQ/Jc4QeIw27lnmKmMp6q100/zrJ4WbXkgxf6qs6MRtbp21PVpbb4
	utDDLO9U0X7mI7HtGhSrfxewg1S0UYD3n/QC3DdgjNGvMnbXTbSLyDklfZKo7Iol
	HTVebyT+Ugr04GfhnCQd0Nal47ueV1FsCOykPP5OO9/axmVL2fRpfHtEYA1fh8UK
	rtr93pl+IR2ONvyWqnXYIvEHlihLQH92a2TAfEMsGlIt+9tKuzGZA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mtsp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFdACW016266;
	Wed, 20 May 2026 15:40:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gfrhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFe7v344892612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6DB20043;
	Wed, 20 May 2026 15:40:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB932004B;
	Wed, 20 May 2026 15:40:07 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:07 +0000 (GMT)
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
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v15 01/20] unwind_user: Add generic and arch-specific headers to MAINTAINERS
Date: Wed, 20 May 2026 17:39:45 +0200
Message-ID: <20260520154004.3845823-2-jremus@linux.ibm.com>
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
X-Proofpoint-GUID: YKvfFXI6TIxbisoowa3fG8e0_F0on43b
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dd5dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=HxY8WkbW6gBkmJkjgtEA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: hi_SJXSzHYSz7oiCOl1mI8qRHjox_iF9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXyhBN7BRDhO4V
 fLT3CBvE35SKtEj/bGNwvGcyb80PUunwDw8MWIrpJDxnHfqOzZPLRSAbLjrpqOgA166QrqXlbXf
 +a/SDwN0ZCyoKUA9pdsHIVJGkx9wy/OzNBRAkMVt0AIVEn3D6Z2LiFaCCcWJ2dr7Rrr6/v7q4/N
 MET/5n7AzhxawpcaqYxAZk5mX6S883co5SuU8p8w0nS6TiDoDafGFkbpzNhr6y9xL9OWKY82pZE
 /9po9qQF21/u84dndhQ8jhmTPiXeyL7Wa9NYW0H1xjfJrHTJfKw4pgYLX+H09uXQdwkp6NAmqop
 kQ4jDz2pWlW0FeY9B9A4Vl2wD+DRvmq/M04w1L3HowEzyIPyQjezkC0EfCNUjA3wvOziGDq9BZa
 clBxs22wAyMm+1+D5TRXdWg2//wLH9uOnhdHuh5KsLRQYUjLXxe+XKJT/YJ3QHREXBIIqOufAmn
 5ZKNCpsfzF+e6tHPtFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

Commit 71753c6ed2bf ("unwind_user: Add user space unwinding API with
frame pointer support") introduced include/asm-generic/unwind_user.h
without adding it to MAINTAINERS, as well as any future arch-specific
versions such as the one added by commit 49cf34c0815f
("unwind_user/x86: Enable frame pointer unwinding on x86") which
introduced arch/x86/include/asm/unwind_user.h.

Suggested-by: Dylan Hatch <dylanbhatch@google.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v14:
    - New patch.

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..7434e9d7b33f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27874,6 +27874,8 @@ USERSPACE STACK UNWINDING
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Steven Rostedt <rostedt@goodmis.org>
 S:	Maintained
+F:	arch/*/include/asm/unwind_user.h
+F:	include/asm-generic/unwind_user.h
 F:	include/linux/unwind*.h
 F:	kernel/unwind/
 
-- 
2.51.0

