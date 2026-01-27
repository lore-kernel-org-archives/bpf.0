Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57F35F8D9;
	Tue, 27 Jan 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526442; cv=none; b=qeD+Oq3uDBtC4400Eh8Xm+l75It9xhAGB3+yA3ZrGB9xMD6gRd7bUPgSQgH0Ua1Cx/9r+MQ7OC4/iBUOiUELCEytsgu7WXzW7xhW39RGxsNDnOiOD3jj9k8h19kC5qGSolJmg6QwF9JTQtf5UUavAgdodt3BqlBOQKuVIMPvq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526442; c=relaxed/simple;
	bh=XpCEuwTqijDt1RI03u6nXaFg8DOmFLBBMUIhU3r9CoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma3GazvBp2lyxEh3Ymeq9m6On+2UMBLvdnm/odObveSBQIHLMicAv4vQjTLX+XUC1RwELXzmynMBsCLFlMXhiAaYkaMZJVqIjFUxZXfDLBxJEhcbHqo8J09lVtanBJ/5WDSTiVgQX4hk018UzDlJtPH3ZImn2QhbSpoUozGvjXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mkPMWj8O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mkPMWj8O"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R8OYQK016222;
	Tue, 27 Jan 2026 15:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=j7PUs00n+iGXFRNku
	NqX2x1J88rk3p3akBKjU23hZu4=; b=mkPMWj8OFLLgSDNnS9OdTu/8KFhOUO0uU
	wQyWLa+f/i2FVk6p9PRzSOIof+TIBieeKLrkGObebgR84+d/Uj276IGB476jjH0d
	3735w+OwM2teAbkNuLPdL0xnJLHZlVErRLYdqTfnCAnAmu0NKo+98vXYul7b2u1B
	U1yalOAPBaIkEz2UDQgBNTM5Zvzf0r9Dz2j5RwcJZAz9QEmZvjfs4J4atO/SOcyp
	lD+94v2Hn4xts6Vt2B0jzBv/2d1DegpoIJqZD/6icBV6Is11YjrpchN+SmqFPICL
	44RWlajJfCmsTsiDwNnD8TQQBs7P+gebyI89SqI/1GvhssX04Gg1A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr646qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RF1ZwM025842;
	Tue, 27 Jan 2026 15:06:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnr646qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD5sZJ031040;
	Tue, 27 Jan 2026 15:06:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsh6cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:06:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RF5xBo37880180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:05:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBF8420040;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94D872004B;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:05:58 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH v13 05/18] unwind_user/sframe: Detect .sframe sections in executables
Date: Tue, 27 Jan 2026 16:05:40 +0100
Message-ID: <20260127150554.2760964-6-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfXxyX8eQDOJo7p
 Gv3tzaBiHVI8HxE1hmXjviiHlheagc1N6M7LH73B1548/7VVMeobn8G7uNDsHQSqGY5zaJMANfn
 0VIkTcVmYdEDgzqvCuBo7PD52dLzzdj6280ccbzsM4rolRC9Q5/OgbNxuFMXyuAeg/n1XzKK212
 B5MZLdE+0TLt4E58brgt4dmjfEd/HhvLaYzoqIkCEqwfwXSarJId9Ply3+azb/ktPKtUruLZoaQ
 D30uvGn++tqZ2dYCVvPfqsLJIee3byLLcPD2skEmPuTvCphkvYlC5GHft6ZLKf00LKfcHZC7N5h
 9bXl0sl7rckSPMLhnxE0coCGPcl/hZGS/r7kyvdfFZszdrQw/auSYtn6Z8AoG/9A3FAWpNeeu69
 Lz5V8CZS8BWUI542SPAGECtN+lHIJnzx0js41dViwqdwZZCceCAwjOLqrLhzX5UsjW7VetUfNbB
 /xRXBPsUJ/AMZKb3OPA==
X-Proofpoint-GUID: -aKMD8f0xVdm5za7MVxww0k3EWdzg2cu
X-Proofpoint-ORIG-GUID: d_lNCTprw3XggzNds1LbFi8sLbGXEVGt
X-Authority-Analysis: v=2.4 cv=X+Vf6WTe c=1 sm=1 tr=0 ts=6978d45c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8
 a=7d_E57ReAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=mDV3o1hIAAAA:8
 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=7mOBRU54AAAA:8 a=meVymXHHAAAA:8 a=7QiolxpzR31IVsMsWeYA:9
 a=k1Nq6YrhK2t884LQW06G:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=wa9RWnbW_A1YIeRBVszw:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270121

From: Josh Poimboeuf <jpoimboe@kernel.org>

When loading an ELF executable, automatically detect an .sframe section
and associate it with the mm_struct.

[ Jens Remus: Fix checkpatch warning "braces {} are not necessary for
single statement blocks". ]

Cc: linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Cc: Kees Cook <kees@kernel.org>
Cc: "Carlos O'Donell" <codonell@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 fs/binfmt_elf.c          | 48 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/elf.h |  1 +
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 3eb734c192e9..fc6ecb4d239e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -47,6 +47,7 @@
 #include <linux/dax.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/rseq.h>
+#include <linux/sframe.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
@@ -637,6 +638,21 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
 	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
 }
 
+static void elf_add_sframe(struct elf_phdr *text, struct elf_phdr *sframe,
+			   unsigned long base_addr)
+{
+	unsigned long sframe_start, sframe_end, text_start, text_end;
+
+	sframe_start = base_addr + sframe->p_vaddr;
+	sframe_end   = sframe_start + sframe->p_memsz;
+
+	text_start   = base_addr + text->p_vaddr;
+	text_end     = text_start + text->p_memsz;
+
+	/* Ignore return value, sframe section isn't critical */
+	sframe_add_section(sframe_start, sframe_end, text_start, text_end);
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -647,7 +663,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
 		struct arch_elf_state *arch_state)
 {
-	struct elf_phdr *eppnt;
+	struct elf_phdr *eppnt, *sframe_phdr = NULL;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
 	unsigned long error = ~0UL;
@@ -673,7 +689,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 
 	eppnt = interp_elf_phdata;
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
-		if (eppnt->p_type == PT_LOAD) {
+		switch (eppnt->p_type) {
+		case PT_LOAD: {
 			int elf_type = MAP_PRIVATE;
 			int elf_prot = make_prot(eppnt->p_flags, arch_state,
 						 true, true);
@@ -712,6 +729,19 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
+			break;
+		}
+		case PT_GNU_SFRAME:
+			sframe_phdr = eppnt;
+			break;
+		}
+	}
+
+	if (sframe_phdr) {
+		eppnt = interp_elf_phdata;
+		for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
+			if (eppnt->p_flags & PF_X)
+				elf_add_sframe(eppnt, sframe_phdr, load_addr);
 		}
 	}
 
@@ -836,7 +866,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int first_pt_load = 1;
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
-	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *elf_property_phdata = NULL, *sframe_phdr = NULL;
 	unsigned long elf_brk;
 	bool brk_moved = false;
 	int retval, i;
@@ -945,6 +975,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				executable_stack = EXSTACK_DISABLE_X;
 			break;
 
+		case PT_GNU_SFRAME:
+			sframe_phdr = elf_ppnt;
+			break;
+
 		case PT_LOPROC ... PT_HIPROC:
 			retval = arch_elf_pt_proc(elf_ex, elf_ppnt,
 						  bprm->file, false,
@@ -1242,6 +1276,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_brk = k;
 	}
 
+	if (sframe_phdr) {
+		for (i = 0, elf_ppnt = elf_phdata;
+		     i < elf_ex->e_phnum; i++, elf_ppnt++) {
+			if ((elf_ppnt->p_flags & PF_X))
+				elf_add_sframe(elf_ppnt, sframe_phdr, load_bias);
+		}
+	}
+
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
 	elf_brk += load_bias;
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 819ded2d39de..92c16c94fca8 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -41,6 +41,7 @@ typedef __u16	Elf64_Versym;
 #define PT_GNU_STACK	(PT_LOOS + 0x474e551)
 #define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
 #define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+#define PT_GNU_SFRAME	(PT_LOOS + 0x474e554)
 
 
 /* ARM MTE memory tag segment type */
-- 
2.51.0

