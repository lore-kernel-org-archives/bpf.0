Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD863FA5D5;
	Wed, 20 May 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291662; cv=none; b=IpAOSqHj0W4EY8MSOJqLLFQcborpZAmUkWRVK6RGrTbW4w04LH9QR9fBYyEtJcAE3ldtKJyenQoeE28DB95qzFGWsbYYSX+7wD4ZFbSy5TI0tyq6eYLlgb6jvFFDiV+Klcvix3m+A+un43A7DojmqHK9+/PJVpQkvF5PPMdpntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291662; c=relaxed/simple;
	bh=cUMaT42PYMgYRx//7d7rZUYO+3pg4AsELfxyvEyNKZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLKkaLjGbFsMBXx3inFBTY47WDUFC4TA/7B/6HixlGCxmeN34Y1DXcgUlAMjG/DJmmudHcxQV8PjvNdHYqitNPM6xFBjbyr0LTk7Y0e1CGgKhL4iKp/gQtVFpFIlWrJPVmLGn4qCjX1ZAn7avXjNArhd83ILPt/inyplY67joSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RD/g3fY6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RD/g3fY6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K8u58O1853987;
	Wed, 20 May 2026 15:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZeB+AJY8s5POZxP6b
	M/RVogEAvg1ms4HdMyeqTBjyvM=; b=RD/g3fY6EWfDNp/w0UBgEicMypatyenKy
	3RaR6ERIwaRcMUXiFrIx6r/03GAazGh82we7wWWWqzBM+XR1yQGzALnCKoT3n6eV
	Cs92fLX5MxM83uUwDzlRx9Un3ag4rSP2U/Khbk5VLLa1hCeklN04lMuJ6cF/aOYy
	0FDx9uPD3e5mDaUYVwnbL/YWEJvfy84r+MKC7fIk+4JGUNPOYfDdvUIY4SJ32gA+
	Y/BLEHuJagYpn/517TNMafhT6dSWxqklpGL8r7ZU7F+0Nr+wZi9iTbJWIffLA1/3
	a7pF8Mvc8mtUkCnXBeLwa4TCJAz9O6XRHbkKxl+2zzUhOgWklWH3w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8hsp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KFd6ER008370;
	Wed, 20 May 2026 15:40:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w03bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 15:40:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KFeHI154395282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 15:40:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389E820040;
	Wed, 20 May 2026 15:40:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7C192004D;
	Wed, 20 May 2026 15:40:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 15:40:16 +0000 (GMT)
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
Subject: [PATCH v15 17/20] unwind_user/sframe: Separate reading of FRE from reading of FRE data words
Date: Wed, 20 May 2026 17:40:01 +0200
Message-ID: <20260520154004.3845823-18-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1MSBTYWx0ZWRfX0Trjn55NgIGF
 nFmj/AwOweeBjV4fx2+U7L9IXxopDOpSf3IMh+f+iQuKqg2g/UFGCEWRJLxq1evIeIipnxL1wD4
 WO5Ugye7TwkFmDmUsmSDTv2Px4OEmXuRE9rpQf+8iJuKl0mup4uxrAbeSA5+sTPkIcBUp1EZ5a9
 31OyFIv+q+f+IBHE+E7hjXnt41amhLbONtF/nZVwNviCKmT0cNZOR2be22oYgcNXMknU37TSenK
 oDpmuIEMqKxIBQQDqnAMtSa2HZVcioTqs1mit4BSIlUv7NuGvpEfEean+BqxtdPiNQY3iSMqc9K
 J8YjX1wmXYo0gFU3qYhnukPCGT+v+MRBuCWAro9c9G2MV5OPUiSdoU2EMUfT49QbFr0/yFw+pQR
 QE6SvzIzOtrNFpIiyh8o6vmJprL+biT1rHv9eMBwye72Lbeigoh+s/xsiBNoA9SbnGD5eWf4YCZ
 fux8iZg6Sw96LsdfbUA==
X-Proofpoint-GUID: daHlmjUCKwnUU2QR6CcS6CYQF7OeHemo
X-Proofpoint-ORIG-GUID: EJZsbENNxJMgg-1nssR3pfk7dgGh3IgB
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0dd5e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=RXKZOtKmAAAA:8
 a=p_lxmaMNnb8s4VerTYQA:9 a=UFF3uGjEBZWolfm0k6KQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200151

__find_fre() performs linear search for a matching SFrame FRE for a
given IP.  For that purpose it uses __read_fre(), which reads the whole
FRE.  That is the variable-size FRE structure as well as the trailing
variable-length array of variable-size data words.  For the search logic
to skip over the FRE it would be sufficient to read the variable-size
FRE structure only, which includes the count and size of data words.

Add fields to struct sframe_fre_internal to store the FRE data word's
address, count, and size.  Change __read_fre() to read the variable-
size FRE structure only and populate those new fields.  Change
__read_fre_datawords() to use those new fields.  Change __find_fre()
to use __read_fre_datawords() to read the FRE data words only after a
matching FRE has been found.  Introduce safe_read_fre_datawords() and
use it in sframe_validate_section() to validate that the FRE data words.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - sframe_validate_section(): Fix format specifier for number of FREs
      in debug message. (Sashiko AI)
    
    Changes in v14:
    - Adjust to rename of SFRAME_FDE_TYPE_* and
      __read_default_fre_datawords().
    - Update function name in debug message.

 kernel/unwind/sframe.c | 100 ++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 36 deletions(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 48709f0bafc7..ec8318977a2e 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -39,6 +39,9 @@ struct sframe_fre_internal {
 	u32		fp_ctl;
 	s32		fp_off;
 	u8		info;
+	unsigned long	dw_addr;
+	unsigned char	dw_count;
+	unsigned char	dw_size;
 };
 
 DEFINE_STATIC_SRCU(sframe_srcu);
@@ -207,11 +210,11 @@ static __always_inline int __find_fde(struct sframe_section *sec,
 static __always_inline int
 __read_default_fre_datawords(struct sframe_section *sec,
 			     struct sframe_fde_internal *fde,
-			     unsigned long cur,
-			     unsigned char dataword_count,
-			     unsigned char dataword_size,
 			     struct sframe_fre_internal *fre)
 {
+	unsigned char dataword_count = fre->dw_count;
+	unsigned char dataword_size = fre->dw_size;
+	unsigned long cur = fre->dw_addr;
 	s32 cfa_off, ra_off, fp_off;
 	unsigned int cfa_regnum;
 
@@ -253,11 +256,11 @@ __read_default_fre_datawords(struct sframe_section *sec,
 static __always_inline int
 __read_flex_fde_fre_datawords(struct sframe_section *sec,
 			      struct sframe_fde_internal *fde,
-			      unsigned long cur,
-			      unsigned char dataword_count,
-			      unsigned char dataword_size,
 			      struct sframe_fre_internal *fre)
 {
+	unsigned char dataword_count = fre->dw_count;
+	unsigned char dataword_size = fre->dw_size;
+	unsigned long cur = fre->dw_addr;
 	u32 cfa_ctl, ra_ctl, fp_ctl;
 	s32 cfa_off, ra_off, fp_off;
 
@@ -325,24 +328,34 @@ __read_flex_fde_fre_datawords(struct sframe_section *sec,
 static __always_inline int
 __read_fre_datawords(struct sframe_section *sec,
 		     struct sframe_fde_internal *fde,
-		     unsigned long cur,
-		     unsigned char dataword_count,
-		     unsigned char dataword_size,
 		     struct sframe_fre_internal *fre)
 {
 	unsigned char fde_type = SFRAME_V3_FDE_TYPE(fde->info2);
+	unsigned char dataword_count = fre->dw_count;
+
+	if (!dataword_count) {
+		/*
+		 * A FRE without datawords indicates an outermost
+		 * frame.  Zero-initialize CFA, RA, and FP location
+		 * info, except for the CFA control word, so that
+		 * neither sframe_init_cfa_rule_data() nor
+		 * sframe_init_rule_data() fail.
+		 */
+		fre->cfa_ctl	= (SFRAME_REG_SP << 3) | 1; /* regnum=SP, deref_p=0, reg_p=1 */
+		fre->cfa_off	= 0;
+		fre->ra_ctl	= 0;
+		fre->ra_off	= 0;
+		fre->fp_ctl	= 0;
+		fre->fp_off	= 0;
+
+		return 0;
+	}
 
 	switch (fde_type) {
 	case SFRAME_FDE_TYPE_DEFAULT:
-		return __read_default_fre_datawords(sec, fde, cur,
-						    dataword_count,
-						    dataword_size,
-						    fre);
+		return __read_default_fre_datawords(sec, fde, fre);
 	case SFRAME_FDE_TYPE_FLEX:
-		return __read_flex_fde_fre_datawords(sec, fde, cur,
-						     dataword_count,
-						     dataword_size,
-						     fre);
+		return __read_flex_fde_fre_datawords(sec, fde, fre);
 	default:
 		return -EINVAL;
 	}
@@ -385,26 +398,11 @@ static __always_inline int __read_fre(struct sframe_section *sec,
 	fre->size	= addr_size + 1 + (dataword_count * dataword_size);
 	fre->ip_off	= ip_off;
 	fre->info	= info;
+	fre->dw_addr	= cur;
+	fre->dw_count	= dataword_count;
+	fre->dw_size	= dataword_size;
 
-	if (!dataword_count) {
-		/*
-		 * A FRE without datawords indicates an outermost
-		 * frame.  Zero-initialize CFA, RA, and FP location
-		 * info, except for the CFA control word, so that
-		 * neither sframe_init_cfa_rule_data() nor
-		 * sframe_init_rule_data() fail.
-		 */
-		fre->cfa_ctl	= (SFRAME_REG_SP << 3) | 1; /* regnum=SP, deref_p=0, reg_p=1 */
-		fre->cfa_off	= 0;
-		fre->ra_ctl	= 0;
-		fre->ra_off	= 0;
-		fre->fp_ctl	= 0;
-		fre->fp_off	= 0;
-
-		return 0;
-	}
-
-	return __read_fre_datawords(sec, fde, cur, dataword_count, dataword_size, fre);
+	return 0;
 
 Efault:
 	return -EFAULT;
@@ -491,6 +489,7 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 	bool which = false;
 	unsigned int i;
 	u32 ip_off;
+	int ret;
 
 	ip_off = ip - fde->func_addr;
 
@@ -528,6 +527,10 @@ static __always_inline int __find_fre(struct sframe_section *sec,
 		return -EINVAL;
 	fre = prev_fre;
 
+	ret = __read_fre_datawords(sec, fde, fre);
+	if (ret)
+		return ret;
+
 	ret = sframe_init_cfa_rule_data(&frame->cfa, fre->cfa_ctl, fre->cfa_off);
 	if (ret)
 		return ret;
@@ -611,6 +614,20 @@ static int safe_read_fre(struct sframe_section *sec,
 	return ret;
 }
 
+static int safe_read_fre_datawords(struct sframe_section *sec,
+				   struct sframe_fde_internal *fde,
+				   struct sframe_fre_internal *fre)
+{
+	int ret;
+
+	if (!user_read_access_begin((void __user *)sec->sframe_start,
+				    sec->sframe_end - sec->sframe_start))
+		return -EFAULT;
+	ret = __read_fre_datawords(sec, fde, fre);
+	user_read_access_end();
+	return ret;
+}
+
 static int sframe_validate_section(struct sframe_section *sec)
 {
 	unsigned long prev_ip = 0;
@@ -656,6 +673,17 @@ static int sframe_validate_section(struct sframe_section *sec)
 					fde.rep_size);
 				return ret;
 			}
+			ret = safe_read_fre_datawords(sec, &fde, fre);
+			if (ret) {
+				dbg_sec("FDE %u: safe_read_fre_datawords(%u) failed\n", i, j);
+				dbg_sec("FDE: func_addr:%#lx func_size:%#x fda_off:%#x fres_off:%#x fres_num:%u info:%u info2:%u rep_size:%u\n",
+					fde.func_addr, fde.func_size,
+					fde.fda_off,
+					fde.fres_off, fde.fres_num,
+					fde.info, fde.info2,
+					fde.rep_size);
+				return ret;
+			}
 
 			fre_addr += fre->size;
 
-- 
2.51.0

