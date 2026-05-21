Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6093DA5D9;
	Thu, 21 May 2026 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373582; cv=none; b=UD8bTi0sUC7fD/+uzcPYjPtlhkvJOvlqNUir5V8SIKBKzC/8ASEZi+2iMH6+dx191q/Tt9q6gc3xqC00FZbU1tB36UJbrMVpdpBnWxQWMHSHy3oP4HtnBML+HgU9LLMiq1T9v2j5wktP0F2oYXgt9Qp9IxJ6G3EchlKuqcRIw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373582; c=relaxed/simple;
	bh=Coil9KclyKK7MQZtjsj+zggHftTuc+AXqbu8taw5uMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZguUjW/GSsp7y3S/gFsmYpYpV1qKsfMajCRK/kMBJmLHd7waYRSwDluss/2zSHbKkIqm+NEeweZYeWMRk6Au23d6zv5EQToIfy7TH2+4YXm6o/IUlRpeaM2EM0rDuc3Y+rPxbSDZZ/Iv1xdzAKJbX8oMoxrJnnb3QPKG/d1NDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1zg6m/i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1zg6m/i"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L6fYnI3442044;
	Thu, 21 May 2026 14:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=odsVNex6R2VPSghnY
	Dx1oLCB8plgZo4cXgSkUOTP2c4=; b=e1zg6m/iYlHhgLyx+hMuwAkAWk3ZzVC1B
	hLKRgi6y0zliDHyYukEbJqLRNpPszE9O/rfoK8J3C7hMt1oga5Fm9FVt+X7cao9L
	us8eq7TOGDSj32NBzHQKXhc1WzF6AeqvUF6v8JWaEjQdaFa56wbnLFbYRl3toqUe
	Wl13zVt8ztKByTSVIww/k3jD/1Jj3q64FYbZmQ6rstbre1B46cCmveWkWenD+2Pe
	XiyJ4WiE1ygNtxMutpqhNJYW3CF3IW9X88XTKDbrlx+DBRI4Taxn6zJ0lsoZ7JPE
	G6O6oIUzg7Ff/qdRvtnNsO9qBSLjkIWIPt6q8+ZgAbARWnnhDtmug==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawe81w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:25:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEO56O027486;
	Thu, 21 May 2026 14:25:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w4pek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:25:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEPn8I55575022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:25:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B9DA20040;
	Thu, 21 May 2026 14:25:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 218CC2004B;
	Thu, 21 May 2026 14:25:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 14:25:49 +0000 (GMT)
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
Subject: [PATCH v16 01/20] unwind_user: Add generic and arch-specific headers to MAINTAINERS
Date: Thu, 21 May 2026 16:25:27 +0200
Message-ID: <20260521142546.3908498-2-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfX92eZC6wen46x
 kxu8UG75ZEncSDV0735GvcPY4I9+w6aQWteAEM1zFldIBHPS/H1A/3mQy2tXIb3CqRS/sZrSXu+
 p7Jn0pLoFFuz9VcjINWcX4wSq+vUpbqFY6sHmwcHfC4+IpJAZ648LqiyDsA095TX3DEW8OAR3CO
 nQlPqPBE/0KI/ZcbvOvVglCSuokU6mVPIG/xi4FzOF6yGvNl8FtdC20wlYd7KJPWF73RyTGVJmt
 3XEP9iiTe3HuPvIHZmkEJCQ6dqbOx7FcjiYqZkPdkhuRfq8hryu9GkpFn1CaT6MTwi3QC/YafZA
 Q0R7/Gr3fIKpUWEUFED1xx7V8WD34A4rEFGnp64nZEA4qpmztglb3KFYZx96RVidb3QFQEGxxiA
 c5ADZ3Ek2IlvJBPVlc/g9EpNxjJSg1Y96QOtQ2BjlPtJi4NwRNGm2pIiHN9rwngS7f6BmHA3J3t
 Znr01a7wks369aWhEFA==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0f15f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=meVymXHHAAAA:8 a=HxY8WkbW6gBkmJkjgtEA:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-ORIG-GUID: E0A2RAdLlwCHEwSkTaCKzShIPO3jyXhx
X-Proofpoint-GUID: WjzRShqmm6nzPcB1FGiCH2jEoUe8nwSr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142

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

