Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1DF3D9055;
	Thu, 21 May 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373602; cv=none; b=diEnHSekN5gt1NLaOpnCW6FRPFFpXTM2fPcgNgZIfWe31Dvf8LwqUpETdjRU1IS+0MqYPGSyybXrqPwzTyMwbYtnFfecnSl7cZWlNI24sN5q+aMIKB0A+YiKoGxZmv7/JnbHnsMR4/4SxI3iE74vXwqjXwnpEjBvhbDQbsxrKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373602; c=relaxed/simple;
	bh=pOTifWMyDUr3KztHc7ELPe1Ms++E6svSTXBfgYLa2PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzLWjBS0TBRMAi64xZunXfcJZCHBt8d9UcLF8KLzDOs3sh017nHAm7s+aKwsT3Vr2G+uO4SR/Cnyvny7BPlvqqNl6YsW/Qd1FSbszznjAV6UQXwdpJKsWq/n9PccNcaaSw9pLMkQeEeGJbXCPIpVXP9c35IpgMw5VNQ55Gc+K8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSEyqh5w; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSEyqh5w"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LE9rhJ069465;
	Thu, 21 May 2026 14:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WbHj9iJ7NuBWvii1A
	/p//5DBJ1F6JGPeRMLlnMLO6Uc=; b=pSEyqh5wjnpwsukgafEIKddJxopOs7y00
	+ZVILJpPdafoQiR3lHLzdY5zow3hdI5apSbb2NO4bvdBltLH2yfsjKiBLhtoAC6r
	aGtZ6nz+50g9mzN/iO3g96O+nQkRGW5LQdt+SKahj/41CZPTp3Zglxmi5c3sbLDN
	q2pAHMqFQA6lL78WObsRroZc9t7F7Iv7Koy6w6IFomRnLPWjv5xCwhIst9nuYVuQ
	lihv2aMNneCF7saQ1ASb3sdwMBeBzDsulq5gVTD82ocvPGG9FyeXKE+cvIeGU8Zt
	0q0QqmC8YPudR2asfHbWJQD6iotyOVEq2dtQ1paDsVI26tW0FwIKA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mydaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:26:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEO5Xo006184;
	Thu, 21 May 2026 14:26:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyc9u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:26:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEPvdL28377478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:25:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FF9720040;
	Thu, 21 May 2026 14:25:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACC5120049;
	Thu, 21 May 2026 14:25:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 14:25:56 +0000 (GMT)
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
Subject: [PATCH v16 20/20] unwind_user/sframe: Add prctl() interface for registering .sframe sections
Date: Thu, 21 May 2026 16:25:46 +0200
Message-ID: <20260521142546.3908498-21-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521142546.3908498-1-jremus@linux.ibm.com>
References: <20260521142546.3908498-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: OUZAgxwN4FB_fHaCqX_mujPmJt2qr6ue
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0f15fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=1RKwvADtGVyjO38rMG4A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: zPlQu9xIGGGD_WQ6kxrO-9UCFhYyJMIb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfXyY3olyWCekyi
 Vgu5puGG/58e0KVOmBgnDleJsWKu5skVuUeu9MEMW540HMEn82k8pL2woSITI3dfVuzeQITqgtE
 FtQxRrvYhpYHLOrg0T/raneNKl51iH5L1KVi0ng359JsFiooL5Z6lGf7+f6dy0/d/sGxfamK7AH
 fZrNVBNTiJqPTvxgrc5D2EUrrz0we3uexp+nSYV8NhMnoE1NsY4/LucQpfFA36fnLF97CKsWXtN
 gPRDjnrjASTL7Sw2lOm+VqWFXNOTemJNkkSBXd7Qf3J7M6b/jiiIUVpTV+JNRIAYSsyJ7kBn/Ud
 nScPxkS3Jv0jMZv/WDl7gJ15AD7NrVuzaRJMCb8+fBiK2k/g7SwkOihgGyDmgCr/n194XKibiYF
 Olt5LUyD7TmnrXjN/02jsp+kn7tHLlK8xYpajCGfCRwXX65o5fGeUF5pOOJD+oc8kuv3kpG7OcH
 LO2C3nVxBMIQbx262eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142

From: Josh Poimboeuf <jpoimboe@kernel.org>

The kernel doesn't have direct visibility to the ELF contents of shared
libraries.  Add some prctl() interfaces which allow glibc to tell the
kernel where to find .sframe sections.

[
  This adds an interface for prctl() for testing loading of sframes for
  libraries. But this interface should really be a system call. This patch
  is for testing purposes only and should not be applied to mainline.
]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - Fix rebase error (missing break). (Sashiko AI)
    
    Changes in v14:
    - Bump PR_ADD_SFRAME and PR_REMOVE_SFRAME.

 include/uapi/linux/prctl.h | 4 ++++
 kernel/sys.c               | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index b6ec6f693719..bd0bf828b033 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -416,4 +416,8 @@ struct prctl_mm_map {
 # define PR_CFI_DISABLE		_BITUL(1)
 # define PR_CFI_LOCK		_BITUL(2)
 
+/* SFRAME management */
+#define PR_ADD_SFRAME			82
+#define PR_REMOVE_SFRAME		83
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 62e842055cc9..b0a9b1e3ccd7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -65,6 +65,7 @@
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
+#include <linux/sframe.h>
 
 #include <linux/nospec.h>
 
@@ -2907,6 +2908,14 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		if (arg3 & PR_CFI_LOCK && !(arg3 & PR_CFI_DISABLE))
 			error = arch_prctl_lock_branch_landing_pad_state(me);
 		break;
+	case PR_ADD_SFRAME:
+		error = sframe_add_section(arg2, arg3, arg4, arg5);
+		break;
+	case PR_REMOVE_SFRAME:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = sframe_remove_section(arg2);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
-- 
2.51.0

