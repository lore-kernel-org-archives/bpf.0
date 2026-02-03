Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45142F39A1;
	Tue,  3 Feb 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139276; cv=none; b=saSfsiCicJ9L5sFlo/vDnNYDA1LQ3ao2DXlvFiPLQy2Mxig+tGH52BxnE8y+7LgklhCKNW+MPJXjfbSxIkJ0saHi1OUOFKBbOFtCFw+eWe4oeIA0tRQxq/jIkYNg03MRc9KcIrf9SisUv9J0dJw68CTeiBSf4PGEJxxpExg8iec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139276; c=relaxed/simple;
	bh=eXSc+R+mgjt5bjfdI1QAyx8d43WTre6ueHjC8mD/Gbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiyCh/rYjY52B7xa+rt31obfPA8O62N06cuRnk4DD/0KFSoBFpbzFlwI6yL2yt2u54lBgzh8U3yLw1S+kJbNuFwDn3KHJkKH7Omh3Id+R5YARnNXyPG5P18kPp2EhRC6ocdojOdAmbNWkmwNrlBU1Docoz0l5N/MnC581Z0mawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bO9pc1Gl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bO9pc1Gl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6139JETP020418;
	Tue, 3 Feb 2026 17:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l0yHqCBqS1ZKJImeo
	J42JZTto0TnmtbsWjg6AbszB9U=; b=bO9pc1Gl6SE8zPetv3aref5y7gX/6ao0A
	KzA8bu+qMc2ByHYW4M+pUMFAsuuEnhWq1ppjImk4xeVAZkNYah4we91X+jnxxeRz
	U4bLt6dP0mynnVmPr1hzeG0KzYgaEAkPw1Lx7dweQNvC8mk4641/2tiKk1v1A5g2
	Klj7OysTeG9+Ra9xqug1UKZM2sN24JNjnep5yEMADsg9AZzcOwLvCdS5507DaVTe
	h2fXN9UHCd+pTK0Lj0ebKfWmWhfnYA71jmG15bwANVUNWVi1EROU+qZMTOwCrH5q
	HcKEk7WaNLG+lmqNS7cB9i3AawQIuq16vbYiXiEcahOTKhkUN4A6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gv7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 17:20:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 613HK84T029094;
	Tue, 3 Feb 2026 17:20:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185gv7ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 17:20:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613Ew6gF029052;
	Tue, 3 Feb 2026 17:20:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2sa45x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 17:20:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 613HK2dW42795460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 17:20:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41EA720040;
	Tue,  3 Feb 2026 17:20:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B1920043;
	Tue,  3 Feb 2026 17:20:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 17:20:01 +0000 (GMT)
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
Subject: [PATCH v7 4/6] x86/vdso: Use SYM_FUNC_{START,END} in __kernel_vsyscall()
Date: Tue,  3 Feb 2026 18:19:55 +0100
Message-ID: <20260203171958.1522030-5-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203171958.1522030-1-jremus@linux.ibm.com>
References: <20260203171958.1522030-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=69822e49 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8
 a=VnNF1IyMAAAA:8 a=lbqDleH5ITP0AWbVeFgA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: GNKdwioRoGA27afE0E8392Ul94d_ZrLP
X-Proofpoint-ORIG-GUID: gwQjZ6492zhW4tHMZpmyRT52VL26xYof
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEzNSBTYWx0ZWRfX+/PJ2lIh3fw/
 sv4dh477JTSQ7yp2Rt71pX9iCOgMa04FcmSn80PcpMZBnWejZqIh/dLt+G5fLsC8Ro2ka/Mpwic
 6NXd61tLZNI1FPA+xIbR3XRHXgfnsPqD2UFjkwxOnOBv4STFQqQe+c2VKoKmjJFmU17jEa8UnU/
 DJVRkPFWlyKJtynjaT7y7MscuTC0pEBjOlTiRfy8oRfdF5m/TgadUxsivg6YdMZSu+Lm0P0hgJ8
 kj1G5TuBWUeJQPF94Gc3KkHNCJw9i/dyNuGzitx1PnsnuAwGcpDh9OPGdQcvQ3FxopK/fOyoJD2
 5hg7i5E2U2prH+zAhtlw5g60h+SqIbFvcDRGXqJ9e0Sy8KfqaUHcoyd7AQrT1wg58ZkSQJVwspO
 QMQLput5dSW58cSw4tO/GQPO80HVIGQdMThPNmyq/BFelOvz6SWzHCCPJ1EVJCmq4nock0/oY8u
 z6EMN1Uj/DnJ5ENPwyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030135

From: Josh Poimboeuf <jpoimboe@kernel.org>

Use SYM_FUNC_{START,END} instead of all the boilerplate.  No functional
change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v7:
    - Rebase on H. Peter Anvin's vDSO changes on tip:x86/entry.

 arch/x86/entry/vdso/vdso32/system_call.S | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 9157cf9c5749..a90f4f7de396 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -9,11 +9,7 @@
 #include <asm/alternative.h>
 
 	.text
-	.globl __kernel_vsyscall
-	.type __kernel_vsyscall,@function
-	ALIGN
-__kernel_vsyscall:
-	CFI_STARTPROC
+SYM_FUNC_START(__kernel_vsyscall)
 
 	/*
 	 * If using int $0x80, there is no reason to muck about with the
@@ -85,7 +81,5 @@ SYM_INNER_LABEL(int80_landing_pad, SYM_L_GLOBAL)
 	CFI_RESTORE		ecx
 	CFI_ADJUST_CFA_OFFSET	-4
 	RET
-	CFI_ENDPROC
-
-	.size __kernel_vsyscall,.-__kernel_vsyscall
+SYM_FUNC_END(__kernel_vsyscall)
 	.previous
-- 
2.51.0

