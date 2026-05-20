Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F31285072;
	Wed, 20 May 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291653; cv=none; b=N415vpsXK1KP9p6VCowUV61gbmMlKzfdXeYguSG0DcRj0Gsj62Dt3QGkJHG44+1Sisa0UvCzds4q1nfoAGR/l1F/D3Ppxz0x1+nfFzHVZLw1jNYYVf6gaayXIJSzpxS3l8ePceMKCmEq17VC3wAxcja3z8sN9D+ULo3XdlUpLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291653; c=relaxed/simple;
	bh=lOecHyF8OzA6DjC/qe3jutuuLV3mk+I5Os3HbhzakrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4C9qWnhlVz2mn90PWGHs0gUDWmjQ1wC0ZJaUQ5pWVBxmVx7rkLE3ptADw5LsDejeINsxzlMyzsG1qneNm3p/qAjbpg2TU4Sx15Bsu5fSxUkHj2t+usib3GUZDiBraDbIy91T9i3F6PrV1jOuz9kROZ1m7k+Zfh8VQn+ZmyYVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ts7uHLp5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ts7uHLp5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBdqLq3067542;
	Wed, 20 May 2026 15:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uzN6ExvwjSRFvHa4Q
	SSdgJXqamOyosXCIwBkfX5X/iU=; b=ts7uHLp5+jAdPzzdtXNwyUUJbq/sFvFAn
	lLvSzN9o3lEosyNNra60yNtsXvldsho217Evi4tQ/f6VWXM7qoXRFwI0Ks0GQLn4
	yeWFIOIcB/ZEZmnS6sH3ms430Ie3nFlv8kzjCxdxhBLgy3h5K4UCxgOmBIxS9tlU
	6HYLJj86mFIC0G075qvhefxzMq3eqvYJGSX+MmCIxR5DfUtgpK1cKZtYxd8+UWpb
	yaj4fhX4LSHxiITZLaEtVcVZiodoWKBhIJurFv00ee1E2F5xzu9r+pfYNXeGapYT
	8thbbO9WyfwgMMVK3bT4atxW59264X66EKiDYrbGU/+ZO5VByL1tg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6haw9u5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFdANZ026110;
	Wed, 20 May 2026 15:40:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky7q6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeHFO46268892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0DD2004D;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 403F82004B;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
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
Subject: [PATCH v15 18/20] unwind_user/sframe: Duplicate registered .sframe section data on clone/fork
Date: Wed, 20 May 2026 17:40:02 +0200
Message-ID: <20260520154004.3845823-19-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfXzDf0BBVwHN8H
 OeYMoeWwylZgdLIw/zdKsHPEr0h8qkx6aYfbKMNVY9M4EMtgIL7FrGt/O8Naku/9q0paeWVFdT4
 gTsgm4xKJrGYSMlt0O2RDqFlmAUBKrEsCB1AxRjVb2EvoJ2E9H0YcTI+wp9lFMafcrpr0kZmm+5
 2ydSK8BuLe5n5lKwwDWKM2PPlEx8YzqBbcsyc8jVx/Qhw6RKIVi7RcqOxVA1aK9voiJwsqlaTPj
 jk5RhH3M9d6K/Yf9SrOe5RMg2N8S3TLy7o6W/7o62UTeiW2fgCgm2TmTU3Qndx3jJ7cDxoBUTeI
 +zogwZ3kW8aNY9XginzO89ilwIE7sHIiAc/mYrLI3FcSmuijRjUw2MHdlGPqRe56gV6LwYFCP3a
 UrC+ER0nKFYbe6vXYBtEQpvek90hqt4hoMEZXida0H8Erda/xzhjqn7rAjEn4dvzVZcsg+j/76v
 9Jvx3aYknaAT05uHjeA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0dd5e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=H1ImvsCuyUzGZUZlsssA:9
X-Proofpoint-ORIG-GUID: 0v1vB95jkJXiZWaV3My4cqKvh1HEwtRJ
X-Proofpoint-GUID: eDqNSvCepqPb2rATY0Fc-wAC4b6k_woA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

When duplicating a process' virtual memory mappings also duplicate all
of its registered .sframe sections stored in the per-mm maple tree to
enable stacktracing using sframe of the child process.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 include/linux/sframe.h       |  5 ++++
 kernel/unwind/sframe.c       | 48 ++++++++++++++++++++++++++++++++++++
 kernel/unwind/sframe_debug.h |  7 ++++++
 mm/mmap.c                    |  9 +++++++
 4 files changed, 69 insertions(+)

diff --git a/include/linux/sframe.h b/include/linux/sframe.h
index b79c5ec09229..91889b4fe3dd 100644
--- a/include/linux/sframe.h
+++ b/include/linux/sframe.h
@@ -28,6 +28,7 @@ struct sframe_section {
 };
 
 #define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
+extern int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm);
 extern void sframe_free_mm(struct mm_struct *mm);
 
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
@@ -45,6 +46,10 @@ static inline bool current_has_sframe(void)
 #else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
 
 #define INIT_MM_SFRAME
+static inline int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	return 0;
+}
 static inline void sframe_free_mm(struct mm_struct *mm) {}
 static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 				     unsigned long text_start, unsigned long text_end)
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index ec8318977a2e..0661090dd5bc 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -886,6 +886,54 @@ int sframe_remove_section(unsigned long sframe_start)
 	return 0;
 }
 
+static void __sframe_dup_section(struct sframe_section *sec, struct sframe_section *oldsec)
+{
+	sec->sframe_start	= oldsec->sframe_start;
+	sec->sframe_end		= oldsec->sframe_end;
+	sec->text_start		= oldsec->text_start;
+	sec->text_end		= oldsec->text_end;
+
+	sec->fdes_start		= oldsec->fdes_start;
+	sec->fres_start		= oldsec->fres_start;
+	sec->fres_end		= oldsec->fres_end;
+	sec->num_fdes		= oldsec->num_fdes;
+
+	sec->ra_off		= oldsec->ra_off;
+	sec->fp_off		= oldsec->fp_off;
+
+	dbg_dup(sec, oldsec);
+}
+
+int sframe_dup_mm(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	struct sframe_section *sec, *oldsec;
+	unsigned long index = 0;
+	int ret;
+
+	guard(srcu)(&sframe_srcu);
+
+	mt_for_each(&oldmm->sframe_mt, oldsec, index, ULONG_MAX) {
+		sec = kzalloc(sizeof(*sec), GFP_KERNEL_ACCOUNT);
+		if (!sec)
+			return -ENOMEM;
+
+		__sframe_dup_section(sec, oldsec);
+
+		ret = mtree_insert_range(&mm->sframe_mt,
+					 sec->text_start,
+					 sec->text_end - 1,
+					 sec, GFP_KERNEL_ACCOUNT);
+		if (ret)
+			goto err_free;
+	}
+
+	return 0;
+
+err_free:
+	free_section(sec);
+	return ret;
+}
+
 void sframe_free_mm(struct mm_struct *mm)
 {
 	struct sframe_section *sec;
diff --git a/kernel/unwind/sframe_debug.h b/kernel/unwind/sframe_debug.h
index a63e75cccc70..2503972155e8 100644
--- a/kernel/unwind/sframe_debug.h
+++ b/kernel/unwind/sframe_debug.h
@@ -48,6 +48,12 @@ static inline void dbg_init(struct sframe_section *sec)
 		sec->filename = kstrdup("(anonymous)", GFP_KERNEL_ACCOUNT);
 }
 
+static inline void dbg_dup(struct sframe_section *sec, struct sframe_section *oldsec)
+{
+	if (oldsec->filename)
+		sec->filename = kstrdup(oldsec->filename, GFP_KERNEL_ACCOUNT);
+}
+
 static inline void dbg_free(struct sframe_section *sec)
 {
 	kfree(sec->filename);
@@ -61,6 +67,7 @@ static inline void dbg_free(struct sframe_section *sec)
 static inline void dbg_print_header(struct sframe_section *sec) {}
 
 static inline void dbg_init(struct sframe_section *sec) {}
+static inline void dbg_dup(struct sframe_section *sec, struct sframe_section *oldsec) {}
 static inline void dbg_free(struct sframe_section *sec) {}
 
 #endif /* !CONFIG_DYNAMIC_DEBUG */
diff --git a/mm/mmap.c b/mm/mmap.c
index 5754d1c36462..250e8bea73ef 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,7 @@
 #include <linux/sched/mm.h>
 #include <linux/ksm.h>
 #include <linux/memfd.h>
+#include <linux/sframe.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -1846,6 +1847,11 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+	if (!retval) {
+		retval = sframe_dup_mm(mm, oldmm);
+	}
+#endif
 loop_out:
 	vma_iter_free(&vmi);
 	if (!retval) {
@@ -1893,6 +1899,9 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 			vm_unacct_memory(charge);
 		}
 		__mt_destroy(&mm->mm_mt);
+#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
+		sframe_free_mm(mm);
+#endif
 		/*
 		 * The mm_struct is going to exit, but the locks will be dropped
 		 * first.  Set the mm_struct as unstable is advisable as it is
-- 
2.51.0

