Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C53F0746;
	Thu, 21 May 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373587; cv=none; b=GZo33IuqjAtL1wd7MtVv6V2dYPtw/J7TJghRY1GRrw0ePu6nhLtIhVr9nhbSL6oq+cUPRM27NNYDgLK7XEQWLcTKZayzHrieHDNQFloFWou0vRvqes3HeiRaALNrbnXhl07L5Us4j2XcZ3Zuv9wCQvEZxHmE/CpBXNPoqmdz+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373587; c=relaxed/simple;
	bh=hCINMaJDj7DdoNxUYM6s6ApHXzn9LGNe4xtm80Mux+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h419NMABrbTEbSimWB7GDQGbB60fVfHEeszLJ73uu6eiDZwANODxBxei6DGarxn7qAOikebBkjUCoJ4jJCF6M30uxa0EHxJ7941aHTpQdXR0rEL5w7UAE22KL5rvETleluA/RkoG6Y4DvPLeACvE/6FbqBUhEUPJiHrlCGuQhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXiwd8eI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXiwd8eI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3Sedp3907161;
	Thu, 21 May 2026 14:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Jllwd3IYu88g5M0bX
	d8eQQThFlgyU/4CLxomaWScev4=; b=KXiwd8eIpi+PCPdzIKhYx1dhvbjNizdNs
	j2PtIbsXFMXpibMHMcXUcodPo4AwZ6hH7mg4UIZDjjBqNmIhZVlb+jAwgdoHLAlx
	nHHw15HDLkGzRs+s79+oA3+c8lyGr9mdiWKjRCG/Uy01N5kjcFr2ve3QwXk3ShLu
	jNllobYArrhrkv3dMDQUuWptZmxqtcEuiqPKxYAbmeIBYh05OXXazEJWLqz0th+o
	Iw9C/QofyE5oI7bkBMicamLYunfDtxmFOqj1/RBMMcCdyjRfHmfGLuIippOlGocJ
	kkHgNQGX3S1yQ3NfvneHdurDgzdnWx51vpCrxckA0uwoZESlKMcTg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8p5ry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:25:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEODcN027545;
	Thu, 21 May 2026 14:25:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w4pey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:25:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEPrrM57278946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:25:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FF120049;
	Thu, 21 May 2026 14:25:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B586120040;
	Thu, 21 May 2026 14:25:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 14:25:52 +0000 (GMT)
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
Subject: [PATCH v16 10/20] unwind_user/sframe: Remove .sframe section on detected corruption
Date: Thu, 21 May 2026 16:25:36 +0200
Message-ID: <20260521142546.3908498-11-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MiBTYWx0ZWRfX5Cb9SNjh14zV
 CLa3w/v/zIcsC358NYpHV7oe41D+S35qEgs/fiIYo7k3IxWQQD3j+Nb56SExE/70gCmw6AIRrvK
 sBXLd3/Oup55nFRYOQ5rz9fEfCCds3b1+NSk6UXvwuPy/t5KO1qan2jOYXpc5yaBzxWBF7jmbl2
 rit11+e4j8jSDSZAl5vVnldt5Q9yX5FvWZV+RW1vtQy5i72HrCtzlaf9XP1ESoKqbLUdWgq4r9g
 u/d7fPKXnGzDF+Ql3IgLdWCM1nD+qqMCCBTEkRrdOOHYQOeC1j/x/KQMjpRms2lWhKUVycAquqp
 53XF2HZ3mtlMViozEINL9rG2nEuCrJt9OhZpC27FAsoqi8wUCyU9mkgGEl0kiwmHPUwvyZAz2m+
 FPH1KwpW2IT2pOXJ/fXnkwC0Vy+uJtw2Z8AeTBWVCa+xRIjl7tV9ouqET1wLYvVIvMlUiVoREi+
 zXY88qfywmdsoq07W5A==
X-Proofpoint-GUID: Fx4VTBMqCayqEJuwq0j-4rAKT7n5LpoY
X-Proofpoint-ORIG-GUID: Q54U5td7LPxOfnBGczdYla305bi7dNFy
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0f15f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=yLRsOmMQGpVHI0ogWx0A:9 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210142

From: Josh Poimboeuf <jpoimboe@kernel.org>

To avoid continued attempted use of a bad .sframe section, remove it
on demand when the first sign of corruption is detected.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v15:
    - sframe_find(): Align to normalized error code usage and remove .sframe
      for all but ENOENT.  Also remove if user_read_access_begin() fails.

 kernel/unwind/sframe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 41ece3ca62a1..e0eb2adf5a07 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -371,10 +371,15 @@ int sframe_find(unsigned long ip, struct unwind_user_frame *frame)
 			ret = __find_fre(sec, &fde, ip, frame);
 	}
 
+end:
+	if (ret && ret != -ENOENT)
+		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));
+
 	return ret;
 
 Efault:
-	return -EFAULT;
+	ret = -EFAULT;
+	goto end;
 }
 
 static void free_section(struct sframe_section *sec)
-- 
2.51.0

