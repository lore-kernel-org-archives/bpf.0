Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A054279FD;
	Tue,  5 May 2026 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983505; cv=none; b=jr3V59qMkdgiiv21FesV7Qg0Cdm7Azy1UpS0LpELr+X10DJXiuKfKp9Oi3d1b7Vw+yrOi7QJTURlXG89tvVAV21ly+MXLN6qfgx6uKPPEQS7uHLxcFcNzNTF8AVq9uykSjyeBlrff36u+745hIFyAjNTDTKbOB5s2WPpihPkLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983505; c=relaxed/simple;
	bh=Rq8NtWyVBLzeSzuEWBLpmeUq4HoQkvathgaw2Gi8Y0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGbS1nEndys/W3OEjGqq+cLZ7h+Jvaa/Ec40QtFUSI0SoFUAicms3IgJFKp/VCDSOsppJFrJA3O1goYi9e+8wEgdxWtnr/Pb2bJSn2I96MhFvLmfb97PCJSvtJPUFrEwsdliO1mHK/n3cFJrfjqiWUrsCTDOJrJaP+ukvyEXIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bs2VY2sV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bs2VY2sV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6457HxL43253820;
	Tue, 5 May 2026 12:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fp1+xLYDCmmQpaXa0
	GhRyZ3txTr6LJNU+sIx4JTk2yo=; b=bs2VY2sVy88C+O8BUtObtf/+9iBZmh8wm
	GoW7GqpdXGmZZH/KUL2Z5h5409DdM0+PYcEg0eDezGMidxHsNaK5ShxPzS1sZ3Oh
	zRSg9q8xTOvsJTbza7XwsoXy8RlgSPA6kwyq7LmSq0TOwUfI4w49w+LueKvcktZD
	aRbSdDBOgwniqiQ3xT9Gg05re7SMsTgVMviIEkZPTD8vYUrJ8LXaevi7RcZ2ddCZ
	w1x7VTvGfEgBmyyhXKNHIt4uaR0jDJPPkKriGg34JjdF3anNLhwS4+Pwn9rBU7z8
	F0faT3dPyx4fWIVS7fTdCV9So6lZSw1c59XbVsE6Fhr5Y1P+yE8qg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6b773-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645C9aen028944;
	Tue, 5 May 2026 12:17:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg9bmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 12:17:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645CHQsK51577110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 12:17:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB1CD2004B;
	Tue,  5 May 2026 12:17:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DF0920049;
	Tue,  5 May 2026 12:17:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 12:17:26 +0000 (GMT)
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
Subject: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a register
Date: Tue,  5 May 2026 14:17:12 +0200
Message-ID: <20260505121718.3572346-14-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69f9dfdc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9BsmwnrB0_sKC25V_9YA:9
X-Proofpoint-ORIG-GUID: H2VCySc_vDGAaueYcs90S4FVKgDHL5RF
X-Proofpoint-GUID: eTbJ_UWu_DjCDFnu5ti1_ElXraB_HknH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNCBTYWx0ZWRfXwKMWSf7IevOd
 DpZx1N4JciusH35DQMxiGUsh0WrWOAHej9k6Zd05SLSE+MzQ5IFLn1JgaAHwqJ9ELE+1MpVOIfY
 G8+Orjk+3rKBI4+WlZwq8fOQChdEY8u+7Kkpaq3qJXvw0i6LBhBCabQuCh2Vda0ZUbWgJYp0m2W
 dtLp3ZkdVtJqYkLkJKVcjs4ZQ03W4ID5iJ4xlsf6WG8AWKRs+E+srO7uZItCT/cipVBU6ur3JXE
 ImQbABji0oKDJcrWWhbndDLIi3IJMUEgEFF3Yy5ff6TLVFPpAvgWkF9JZUdunc8OzWXv4qBjeBx
 YCyjiE3bJ1zxnUSKcztZwCK3dVfcANgD4VU4mWKtn9ZaXHcVAU58GTvxucI1VrjAEJsrqQqWEG6
 Zh4K2DIZY36tdsjz/NMnk4UJ0+Opoip4rfp27YrF/7bQalHbfeO4sSQqiWAKJPgeHYjHvM+iE4a
 bN4xQo4c4l5xMDZChuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050114

Not all architectures have the return address (RA) in user space saved
on the stack on function entry, such as x86-64 does due to its CALL
instruction pushing the RA onto the stack.  Architectures/ABIs, such as
s390, also do not necessarily enforce to save the RA in user space on
the stack in the function prologue or even at all, for instance in leaf
functions.

Treat a RA offset from CFA of zero as indication that the RA is not
saved (on the stack).  For the topmost frame treat it as indication that
the RA is in the link/RA register, such as on arm64 and s390, and obtain
it from there.  For non-topmost frames treat it as error, as the RA must
be saved.

Additionally allow the SP to be unchanged in the topmost frame, for
architectures where SP at function entry == SP at call site, such as
arm64 and s390.

Note that treating a RA offset from CFA of zero as indication that
the RA is not saved on the stack additionally allows for architectures,
such as s390, where the frame pointer (FP) may be saved without the RA
being saved as well.  Provided that such architectures represent this
in SFrame by encoding the "missing" RA offset using a padding RA offset
with a value of zero.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/unwind_user.h |  9 +++++++++
 kernel/unwind/sframe.c      |  6 ++----
 kernel/unwind/user.c        | 17 +++++++++++++----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 64618618febd..bc2edae39955 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -23,6 +23,15 @@ static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 #define unwind_user_at_function_start unwind_user_at_function_start
 #endif
 
+#ifndef unwind_user_get_ra_reg
+static inline int unwind_user_get_ra_reg(unsigned long *val)
+{
+	WARN_ON_ONCE(1);
+	return -EINVAL;
+}
+#define unwind_user_get_ra_reg unwind_user_get_ra_reg
+#endif
+
 int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 45988cdc5c37..d5e0fa04b99a 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -243,10 +243,8 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	dataword_count--;
 
 	ra_off = sec->ra_off;
-	if (!ra_off) {
-		if (!dataword_count--)
-			return -EFAULT;
-
+	if (!ra_off && dataword_count) {
+		dataword_count--;
 		UNSAFE_GET_USER_INC(ra_off, cur, dataword_size, Efault);
 	}
 
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index fdb1001e3750..9ceef9b2b8db 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -48,8 +48,12 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 	}
 	cfa += frame->cfa_off;
 
-	/* Make sure that stack is not going in wrong direction */
-	if (cfa <= state->sp)
+	/*
+	 * Make sure that stack is not going in wrong direction.  Allow SP
+	 * to be unchanged for the topmost frame, by subtracting topmost,
+	 * which is either 0 or 1.
+	 */
+	if (cfa <= state->sp - state->topmost)
 		return -EINVAL;
 
 	/* Make sure that the address is word aligned */
@@ -57,8 +61,13 @@ static int unwind_user_next_common(struct unwind_user_state *state,
 		return -EINVAL;
 
 	/* Get the Return Address (RA) */
-	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
-		return -EINVAL;
+	if (frame->ra_off) {
+		if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
+			return -EINVAL;
+	} else {
+		if (!state->topmost || unwind_user_get_ra_reg(&ra))
+			return -EINVAL;
+	}
 
 	/* Get the Frame Pointer (FP) */
 	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
-- 
2.51.0

