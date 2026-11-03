Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676394;
	b=Jh0thWCAccR4CvuZeXXQHLF4jFQDo5AAJhW4TNs4iiFB2tuV/SRFUjumULGdbKkt324X
	 wfDLl65bdoAwpH0UfAZYjZZHzRfgdCIc/ZCkL+TIfj8Of6aKG/VWU+isw2UsfACVLrcch
	 Xl/r8rUPFup5NZWpr5xA5+o7aWLT8wrWCZJNjYsY4ZDAlPYEACTT9b/5R/rbLlrWmCoen
	 Z5oVGCDTDNJpxMxxVB5793FuuE4aUv/D3Z+QNj0RAEHutt4qvFo5lO2HoiyEssOpRgKeO
	 bBz+v+3/aWFXA7OeeM/4T4WPfrvjUk//K3uz/dsCbZAonXmrFS0M0GZOT4YAVCZ+jJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676394;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uHVcmrbykHP9wZBTInUCTuzJ9tnHgcmQZl6a/N+36AU=;
	b=JsdZrLmMkkA6jLWL64RbmxiZVMHU1k9xwNagAGdKKhmfkFigMG27026N5mPZrnpsbeQz
	 y14WVC6gNO/Ix4XjcmAPO1diEzjJZaCOWLRQ45Bmb3sUNBy3W06Y5tkCRIsyKbDShr1q4
	 Ip+SJXqQwyRoj8mRZS/F1TraOcY4xlazwAZ4jVQQQtUHU+35I24DIB10uoFyMdNRd1UW0
	 H+e6YHmIJ1DaCV2AjU37Es1fHFIzeAClrlPacV+9qM+NzlyzyODMwyjjeVOCj9gFi4M05
	 3IXABdsguoh1phIfv+CG+ApiQOKPPdYJ0A1t5glAhyz3a4gAR4YjaDygvO2T0n4rtFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UBZ1reVl;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC8D606A327
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC8D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UBZ1reVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=UBZ1reVlO0CHMATV9Z8M7+GKnh70tGs97yHCApvaS9I0l8c7G7+DsIZPGmM8tR/27tdcdRkNfg3DF
	 VtGB/Sc4Yf8vGj26S8bPmoa3U4AlNZ4AhfvPLUpHfAIwlLfAXTsTYKwXFQucm+hOwVwVNcIY2/Kqs9
	 P0QPR0TuC/dVnD6Y=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26ae9546671d-cb00d;
	Tue, 03 Nov 2026 11:26:30 +0800 (CST)
X-RM-TRANSID:2ee26ae9546671d-cb00d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae9545dbf2-e8c6d;
	Tue, 03 Nov 2026 11:26:30 +0800 (CST)
X-RM-TRANSID:2ee56ae9545dbf2-e8c6d
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add overflow test for BTF dump zero-scan
Date: Tue,  3 Nov 2026 11:26:16 +0800
Message-ID: <20261103032619.1378-3-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
References: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
 <20261103032619.1378-1-gubin@cmss.chinamobile.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a TEST_BTF_DUMP_DATA_OVER() case that dumps an all-zero
union bpf_iter_link_info with a data_sz one byte short of the type
size.  Without the overflow check in
btf_dump_type_data_check_zero() the zero-scan reads past
data_end; with it, btf_dump__dump_type_data() returns -E2BIG.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index dbef014f75ac..f6cff6cc56c4 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1161,6 +1161,13 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 			   "(union bpf_iter_link_info){.cgroup = (struct){.cgroup_fd = (__u32)1,},.task = (struct){.pid = (__u32)1,},}",
 			   { .cgroup = { .cgroup_fd = 1 }});
 
+	/* overflow test for all-zero union: with a data_sz one byte short
+	 * of the type size, the zero-scan must not read past data_end and
+	 * must return -E2BIG.
+	 */
+	TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link_info,
+				sizeof(union bpf_iter_link_info) - 1, "", {});
+
 	/* struct skb with nested structs/unions; because type output is so
 	 * complex, we don't do a string comparison, just verify we return
 	 * the type size as the amount of data displayed.
-- 
2.55.0.windows.3



