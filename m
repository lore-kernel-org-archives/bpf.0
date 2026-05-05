Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E5842B757;
	Tue,  5 May 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983503; cv=none; b=TtlXA3eQNhHkJcrvOEXgfJ+BUrRNqcz+0Obb15sE8Pvd0Jij8jF/8AmdtR1hyCJQN5Qun63wRvXdBmHnSJfGs/am6bTrVZqDn8AEMqiR1Z1Ts9wvcmTL9q3w99ygl3vIzbxEChtmIkZZk3jGzsqbAnNgTu0Q/+72DzOmxRyLzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983503; c=relaxed/simple;
	bh=uIbdJGh/N9lQH49AE2Fc0NOhYTqYuvXPbyX/MRP5T8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RddPHLeqJcOF27Lphh2dcPCHeX1Ta8TKdDRbyrMxm4nRXNU4XniOlBmobcRlNqPHob42UU5pR3LvNdeuuziHWMT5BbWkxd1FVNNa0tBvryTshFRNCVpSjTedHYxYqLLHKHMu/iY2GdcphnMDSjkyAnhjn14egtCzuAozVU6Xt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKjdzuXb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKjdzuXb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644JlCCH1181000;
	Tue, 5 May 2026 12:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9jk0sPM0F49+3xsbm
	n4sxo0rBP2j0R4q+y+vLeY7bZ8=; b=iKjdzuXbrhhlc+2Znc7c8kyL0c4RZpLnp
	BsPiUnGfd5H1BpjtK7Ii1Hnbi2kO41H15cRcsI9xc9BSx+VqMV5WwkliFfvqo0zu
	9pxpEBBfiriW0rrufpMrfJGziKG9HvVY09+A22EmBthGCtFTwWGBlkarsllS3+A4
	50dRIK7E0oJk6E/WmfYq1gxXJ5zrZI/UFOVDqLzLv59lIzNKIaktsp3HFd1sg2jA
	fuCOBiY6tfQ3lJ0cwz7l7IUSEZVUBRt8D+3pegzfXMiFx4lSFSr9/vOVQ7umGgVy
	LclKif646wOdKpC4dgdxFuGAx8voNl8WQUASUzOk9R4NY61Ro0tew==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7bj95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9okw028585;
	Tue, 5 May 2026 12:17:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw1m34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHN1828836326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD4D20049;
	Tue,  5 May 2026 12:17:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A16172004E;
	Tue,  5 May 2026 12:17:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:22 +0000 (GMT)
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
Subject: [PATCH v14 04/19] x86/uaccess: Add unsafe_copy_from_user() implementation
Date: Tue,  5 May 2026 14:17:03 +0200
Message-ID: <20260505121718.3572346-5-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505121718.3572346-1-jremus@linux.ibm.com>
References: <20260505121718.3572346-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfX0ihancRXGt18
 IJyGZUNmBcdxherEL9XDBqFi4UN2bl8lc7rvenJ4XR1yTQCEpuIGpBsBKpuLuN2FabrdAXx9j5N
 XM9G6pf5t5G/J+Yv6LavDjt/Y58BfuZQKUTMv2L89oFYLmGxMfSVMX5l7tU2gCGYGuCwIxjBdy/
 KNERiGkGifCQQs/YfrAQMXlvAfN2nMR8U4ADMEjRyqdA71NztLqpbFvJZkIxC7XBId/jUlZkHWx
 xQXUUc7aaOeyWYS1xhq+hv1hkZW2PbvvPzHd81xbcyNI8DtZz9x7rCTTddjnQ3fKG47ko33hk60
 VjuMCZJzdMWzyYtpFK4c/ImOgvHMZs4L7FFzquAwSX+GbWyqX//6heV+0KI14c374rhIWnAfXD/
 QPT2HNS6MiE02BAJy4h8bVOLLQPogUAYMOumG6h4CYOB3uOACP11bSOBqeYeHE0ohXCtMr9z9M+
 8wW08tLZ1GXf69M7LHw==
X-Proofpoint-GUID: 3xPfsk7dxks5BRMKUV_Iwiir8jU8tnjU
X-Proofpoint-ORIG-GUID: hJbz80oBTd2cuT1HmERswDPItq9JtWhh
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9dfd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=-G4kms3_kQfBhqX38bYA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add an x86 implementation of unsafe_copy_from_user() similar to the
existing unsafe_copy_to_user().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/x86/include/asm/uaccess.h | 39 +++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233..79679779f1ea 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -598,7 +598,7 @@ _label:									\
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
  */
-#define unsafe_copy_loop(dst, src, len, type, label)				\
+#define unsafe_copy_to_user_loop(dst, src, len, type, label)			\
 	while (len >= sizeof(type)) {						\
 		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
 		dst += sizeof(type);						\
@@ -606,15 +606,34 @@ _label:									\
 		len -= sizeof(type);						\
 	}
 
-#define unsafe_copy_to_user(_dst,_src,_len,label)			\
-do {									\
-	char __user *__ucu_dst = (_dst);				\
-	const char *__ucu_src = (_src);					\
-	size_t __ucu_len = (_len);					\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
-	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+#define unsafe_copy_to_user(_dst, _src, _len, label)				\
+do {										\
+	void __user *__dst = (_dst);						\
+	const void *__src = (_src);						\
+	size_t __len = (_len);							\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_to_user_loop(__dst, __src, __len, u8,  label);		\
+} while (0)
+
+#define unsafe_copy_from_user_loop(dst, src, len, type, label)			\
+	while (len >= sizeof(type)) {						\
+		unsafe_get_user(*(type *)(dst), (type __user *)(src), label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_from_user(_dst, _src, _len, label)				\
+do {										\
+	void *__dst = (_dst);							\
+	void __user *__src = (_src);						\
+	size_t __len = (_len);							\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u64, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u32, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u16, label);		\
+	unsafe_copy_from_user_loop(__dst, __src, __len, u8,  label);		\
 } while (0)
 
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
-- 
2.51.0

