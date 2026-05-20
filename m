Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008D3FB074;
	Wed, 20 May 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291662; cv=none; b=l4aiZC6omFyrOilZSuRkgtHH+HEAwjJrIV/taG7zWT7pyT/HnFSKHbNh4rjOB0JsCcyXcOuQW8oqvKOgRZGmZDZDZgxvpY0J1squu4U/JRt3D2InAPd3B+U/eCrAiuBqwZmImVovjV+az0ZUQXphcMfyiTisl/WqMlbjrmhLV64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291662; c=relaxed/simple;
	bh=1uqNk2OW4T2BX4f0DYsbJdKnO4ILhTmLZQFcrbqg1Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI3KAEHfSlcxm+sYA/BbGGKvadxjUvNcDcm4cXz5DjyDupBx3jlYaVWvsogxI07u03YzX6vpy0kx9OLX1vlyG+XUtVz6+d4N8oktEuu942OJQf6kzNi4Ow9/mYf8MhW+v5WTEx5E5YDHZ9toIeGBpWhb7GpwM7l/NtTyS8JIvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LLt4z6q5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LLt4z6q5"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6k2lD513145;
	Wed, 20 May 2026 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fwe9ecz9H+oPKkp3z
	AdaLZRBVdDt0f4wFwOsmwqxdFk=; b=LLt4z6q5tiKzAzHNgRov9cJRFGW2Kq2yY
	BbcoFADK36lXnIEwuqGDTVINpyIiyUfMP8OXzDdLSyjTtFod7ED8THwpBaLBM8SP
	lO1DwGOxOttsYiVdbhp0L73YVvDSWhJlUU9KDT1SQ6jqBIds1WNlmEE+Zs5/bnGg
	8U3XyYv9MiaodOnrm96y26qDc4SxifMBIkTrrYKeQdEkJ6gCqZs4cvrVGnP4/+nZ
	IEVOpIyZ22WkHK76CxC0RWvEKSQxO5VHI5I8boq4DUEmtnNMFXFXYN7QNoOCvCtl
	nePqejl1Tt3uF8D+0ZwnLFQNQdCvfKHSX4DAD3kRiAJMajM/Tc1VA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h752taa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd5tP031969;
	Wed, 20 May 2026 15:40:18 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk801p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeEbu47251718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A3C42004D;
	Wed, 20 May 2026 15:40:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B917D20043;
	Wed, 20 May 2026 15:40:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:13 +0000 (GMT)
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
Subject: [PATCH v15 12/20] unwind_user/sframe: Add .sframe validation option
Date: Wed, 20 May 2026 17:39:56 +0200
Message-ID: <20260520154004.3845823-13-jremus@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dd5e4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=RXKZOtKmAAAA:8 a=iNKnMr3YqTL5pEm6fAYA:9
 a=2JgSa4NbpEOStq-L5dxp:22 a=UFF3uGjEBZWolfm0k6KQ:22
X-Proofpoint-ORIG-GUID: -mkfSxAZrBitVU35z00n1maSPFGjEpyV
X-Proofpoint-GUID: PcRSCFKq2nBAV8d8RsO-g8IszMq0jrZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfX+4A6NmuzGWeG
 gmHkZhotg90f9w+n46VxxVYmpLojP/Pt/cjMxbc+bsVsKbKMK3nWoUaXSAZS7+c3S9+4IuyB69u
 Q3N9BqkINDt6at0tT1rsTSuhQZ0e4OGlWGjyjnhGCSe8a6QPxHKHkxZR5WmP9q2cH/rBdaHOMoW
 185O2lPNMtCIlDj3X//0PqtRmPJ02kt8dhD1WK517q5fwGG6zRBOE9WtzjuQVlKHlV4Pb7DdFCk
 KIdf1PIMU0+Y/CgmbH5Aiz/kHFn0C1EvA8YH3ixcQCFRedYca5C0RDweYn0/B5IPfCzFD2nNFT/
 yhnmKZnnSw+TFjiZHfbgd2MEAsA2aPVclD8l6QxCLkVdjYr/lgqi7W7wk8MRyetKECNyQSYLsvV
 bd0FdsDcOuU3GhXqKbonzTbO0F15lUJBy6pL/1Lkz6tO/yF8oVvYpzMbOaF8iGRnXIf12me2j3l
 PZE36FK2khAMfW/k9zQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add a debug feature to validate all .sframe sections when first loading
the file rather than on demand.

[ Jens Remus: Add support for SFrame V3.  Add support for PC-relative
FDE function start offset.  Adjust to rename of struct sframe_fre to
sframe_fre_internal.  Use %#x/%#lx format specifiers. ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - sframe_validate_section(): Fix format specifier for number of FREs
      in debug message. (Sashiko AI)
    - Normalize error code usage (.sframe is removed for all but ENOENT):
      ENOENT: No sframe or no FDE for IP found
              (FDE found but no FRE is EINVAL)
      EFAULT: Bad address
      EINVAL: Invalid input or sframe
    
    Changes in v14:
    - Add debug message if safe_read_fde() fails.
    - Update function names in debug messages.
    - Uppercase terms FDE and FRE in debug messages.
    
    Changes in v13:
    - Update to SFrame V3:
      - Print struct sframe_fde_internal fields fda_off and info2 in debug
        message.
    - Adjust to rename of struct sframe_fde_internal field func_start_addr
      to func_addr.
    - Use format strings "%#x" and "%#lx" instead of "0x%x" and "0x%lx".
    - Reword commit message (my changes).

 arch/Kconfig           |  19 ++++++++
 kernel/unwind/sframe.c | 101 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 37549832bd1f..132249d342a3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -490,6 +490,25 @@ config HAVE_UNWIND_USER_SFRAME
 	bool
 	select UNWIND_USER
 
+config SFRAME_VALIDATION
+	bool "Enable .sframe section debugging"
+	depends on HAVE_UNWIND_USER_SFRAME
+	depends on DYNAMIC_DEBUG
+	help
+	  When adding an .sframe section for a task, validate the entire
+	  section immediately rather than on demand.
+
+	  This is a debug feature which is helpful for rooting out .sframe
+	  section issues.  If the .sframe section is corrupt, it will fail to
+	  load immediately, with more information provided in dynamic printks.
+
+	  This has a significant page cache footprint due to its reading of the
+	  entire .sframe section for every loaded executable and shared
+	  library.  Also, it's done for all processes, even those which don't
+	  get stack traced by the kernel.  Not recommended for general use.
+
+	  If unsure, say N.
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index f931932bd34a..b5f984fb2df2 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -382,6 +382,103 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 	return ret;
 }
 
+#ifdef CONFIG_SFRAME_VALIDATION
+
+static int safe_read_fde(struct sframe_section *sec,
+			 unsigned int fde_num, struct sframe_fde_internal *fde)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fde(sec, fde_num, fde);
+	user_read_access_end();
+	return ret;
+}
+
+static int safe_read_fre(struct sframe_section *sec,
+			 struct sframe_fde_internal *fde,
+			 unsigned long fre_addr,
+			 struct sframe_fre_internal *fre)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fre(sec, fde, fre_addr, fre);
+	user_read_access_end();
+	return ret;
+}
+
+static int sframe_validate_section(struct sframe_section *sec)
+{
+	unsigned long prev_ip = 0;
+	unsigned int i;
+
+	for (i = 0; i < sec->num_fdes; i++) {
+		struct sframe_fre_internal *fre, *prev_fre = NULL;
+		unsigned long ip, fre_addr;
+		struct sframe_fde_internal fde;
+		struct sframe_fre_internal fres[2];
+		bool which = false;
+		unsigned int j;
+		int ret;
+
+		ret = safe_read_fde(sec, i, &fde);
+		if (ret) {
+			dbg_sec("safe_read_fde(%u) failed\n", i);
+			return ret;
+		}
+
+		ip = fde.func_addr;
+		if (ip <= prev_ip) {
+			dbg_sec("FDE %u not sorted\n", i);
+			return -EINVAL;
+		}
+		prev_ip = ip;
+
+		fre_addr = sec->fres_start + fde.fres_off;
+		for (j = 0; j < fde.fres_num; j++) {
+			int ret;
+
+			fre = which ? fres : fres + 1;
+			which = !which;
+
+			ret = safe_read_fre(sec, &fde, fre_addr, fre);
+			if (ret) {
+				dbg_sec("FDE %u: safe_read_fre(%u) failed\n", i, j);
+				dbg_sec("FDE: func_addr:%#lx func_size:%#x fda_off:%#x fres_off:%#x fres_num:%u info:%u info2:%u rep_size:%u\n",
+					fde.func_addr, fde.func_size,
+					fde.fda_off,
+					fde.fres_off, fde.fres_num,
+					fde.info, fde.info2,
+					fde.rep_size);
+				return ret;
+			}
+
+			fre_addr += fre->size;
+
+			if (prev_fre && fre->ip_off <= prev_fre->ip_off) {
+				dbg_sec("FDE %u: FRE %u not sorted\n", i, j);
+				return -EINVAL;
+			}
+
+			prev_fre = fre;
+		}
+	}
+
+	return 0;
+}
+
+#else /*  !CONFIG_SFRAME_VALIDATION */
+
+static int sframe_validate_section(struct sframe_section *sec) { return 0; }
+
+#endif /* !CONFIG_SFRAME_VALIDATION */
+
+
 static void free_section(struct sframe_section *sec)
 {
 	dbg_free(sec);
@@ -500,6 +597,10 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
 		goto err_free;
 	}
 
+	ret = sframe_validate_section(sec);
+	if (ret)
+		goto err_free;
+
 	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end - 1,
 				 sec, GFP_KERNEL_ACCOUNT);
 	if (ret) {
-- 
2.51.0

