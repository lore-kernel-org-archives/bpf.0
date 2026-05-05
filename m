Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E007393DDC;
	Tue,  5 May 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983498; cv=none; b=ix6JzyuWvkyhjV9M7ADpjAIrqbh93dnJlLZM/mzmIvrkDph0xr13clU3e4XodU5Yi6lEw7PTjBknp4HH25pt1pe7gtpofeI1wHscPRi4eJN/uh0dQZxLRTmtAvCmuqfkXoGRMVHJRlerENf8JUpFZEzc+ezXdsAgOjPABhMGRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983498; c=relaxed/simple;
	bh=fYp/UfRYBUkzJLmQCxdXC1AOIjsLrcAf3YX9BfFjL1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhUD3TPZ7PjtpprHajbK5joQClHlT8eYNTAcgrbq5PgeWNvwzmfIzljmuoju6OG4nkRh8WCWd5GwSMsWgbTwC6TEamoKvjXUJb092QBohlLmBeeKJ9zdZoW88c7gPkZkDEXYBV9NUdauVgGM5zQfneFLvrCTPnga8StlHM8TK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VEwxoKQy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VEwxoKQy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457XVQv3464145;
	Tue, 5 May 2026 12:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1rPRr3FZStWFGzetx
	6++VNjJW1FkjSSD795lGjO3e+g=; b=VEwxoKQytBh8r2anKmrQqsD/fQrUCoyYI
	dPEgpHAorlGbTKN9hFnqiHfk/Y70Z7kIWHvhdgrbZpSi4YaocTbjDKQqkv6lQWXL
	1o0+YDWR+sKsS/D/CcTo7avul1PUaW9nRyzLfsqTn1zBmM69KJpPyq+C7woDYKdN
	fcQRoxnIEWlCLJZM9kW2MrJB9BZtw+FmW8jW73vfP4fRPIkPcBtS8TRGL69vMoz7
	Vj89YJgsQw7Sd8KiewtLXRLG1ZLGtU18ROXSc1iTrGLOctoRq+2BOjp/mjPbUVh5
	MWNl3YnG8wqTMpFdrhyD/gKO4UfR7SmvWmh7J/4OBUyNEikLfXTog==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7bj9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9a40030210;
	Tue, 5 May 2026 12:17:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq9nmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHPVF59375896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 322A42004B;
	Tue,  5 May 2026 12:17:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98F42004E;
	Tue,  5 May 2026 12:17:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:24 +0000 (GMT)
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
Subject: [PATCH v14 09/19] unwind_user/sframe: Add support for outermost frame indication
Date: Tue,  5 May 2026 14:17:08 +0200
Message-ID: <20260505121718.3572346-10-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfXxs+poCAAGGNG
 9Cfil+KpyvOWZ9eNrzo7p0DMXBFB8ddw/Z1jToIBMfBbF8gMOySE1DKHJWcGx47Gnac7WNDTiLo
 taNPOzcwB6Y8H6i8+1Pp4KPU6O2MUhFcCVbjeAmZURahIZN00aaJLb84ENmOF9mGSz+ks67MlTr
 rWIEqS/rjtv0J3bSVM1foQruayIKEyaxqJNlMCE5TMuK5spshFERy06ksgWNkD9fIzJybSvy8B3
 ewWKJrKeorztqyjQ5ewij1YeHGFgGAgz/tqg52Kodd3NY4+bhgFswOXORS6TxaC/pufO+nVvMNa
 lvDsil9mJNjZR2uQAp/BAI5qeJIaCVQtOqPedhVQXoftsOrMd2EDrjECVrxiqBzenGD4t2J7Ncu
 CisLkq4sGFxUfvR9G99vD6Ar6DfjXVzC1S5QvuSL4Y/xZu+Qjhz09vn8ebdNyklOCvsy4Qs4CeP
 2aUlUKu8+wPP2shbgRw==
X-Proofpoint-GUID: efVzNbBCZREIKW4fO6gioglIN0VcT-tB
X-Proofpoint-ORIG-GUID: BJSUMIXg6C-mMKI5aio-_pcfAq0a41Zm
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9dfda cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=U72JrVpwKSe1qDC-WCIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

SFrame may represent an undefined return address (RA) as SFrame FRE
without any offsets as indication for an outermost frame.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 kernel/unwind/sframe.c | 15 ++++++++++++++-
 kernel/unwind/sframe.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index c60aa527984a..9c755965ab83 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -218,7 +218,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	UNSAFE_GET_USER_INC(info, cur, 1, Efault);
 	dataword_count = SFRAME_V3_FRE_DATAWORD_COUNT(info);
 	dataword_size  = dataword_size_enum_to_size(SFRAME_V3_FRE_DATAWORD_SIZE(info));
-	if (!dataword_count || !dataword_size)
+	if (!dataword_size)
 		return -EFAULT;
 
 	if (cur + (dataword_count * dataword_size) > sec->fres_end)
@@ -228,6 +228,17 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	if (fde_type != SFRAME_FDE_TYPE_DEFAULT)
 		return -EFAULT;
 
+	if (!dataword_count) {
+		/*
+		 * A FRE without data words indicates RA undefined /
+		 * outermost frame.
+		 */
+		cfa_off	= 0;
+		ra_off	= 0;
+		fp_off	= 0;
+		goto done;
+	}
+
 	UNSAFE_GET_USER_INC(cfa_off, cur, dataword_size, Efault);
 	dataword_count--;
 
@@ -248,6 +259,7 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	if (dataword_count)
 		return -EFAULT;
 
+done:
 	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
 	fre->ip_off	= ip_off;
 	fre->cfa_off	= cfa_off;
@@ -314,6 +326,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	frame->ra_off  = fre->ra_off;
 	frame->fp_off  = fre->fp_off;
 	frame->use_fp  = SFRAME_V3_FRE_CFA_BASE_REG_ID(fre->info) == SFRAME_BASE_REG_FP;
+	frame->outermost = SFRAME_V3_FRE_RA_UNDEFINED_P(fre->info);
 
 	return 0;
 }
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index fc2908e92c7b..ed111fd0d702 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -77,5 +77,6 @@ struct sframe_fda_v3 {
 #define SFRAME_V3_FRE_DATAWORD_COUNT(info)		(((info) >> 1) & 0xf)
 #define SFRAME_V3_FRE_DATAWORD_SIZE(info)		(((info) >> 5) & 0x3)
 #define SFRAME_V3_AARCH64_FRE_MANGLED_RA_P(info)	(((info) >> 7) & 0x1)
+#define SFRAME_V3_FRE_RA_UNDEFINED_P(info)		(SFRAME_V3_FRE_DATAWORD_COUNT(info) == 0)
 
 #endif /* _SFRAME_H */
-- 
2.51.0

