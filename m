Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761103;
	b=c2cgIcdc4/jZxKZLW3v8E2bYGrsu1xagFvPUR+aLGhq1ZwftnqPIQ4qh+AqMjwqocGX6
	 4RRqj2S7eTbbY6fB/ssle/P+vqTk4BZhgp3ClZwz5QQKZRESp+xE3SQERxgUPgXQtrBoB
	 vLpBjT3zsajsSel0fW/0UDEgT0qVBA1XfvEOLsiytMnYWdhbPmh0VZhpOJ3e6zPr+PXbZ
	 uBMz7IHwRO9wCkRHPbB7I830PTJY1bKy0UhEm1O+rFgwn+SKy8MDxSTHHRrBGjiETf6Pk
	 qUbKphMd3KZXtWtpFzR0f2Hj19aGlzeowIFPnpIIJeTkJ1UX12ZrRLIbqGlgWOcLShg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761103;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HQ4gHYff5L7fcOeozhMbaE0ny7o9npnXhM/+Uvm4J34=;
	b=q5sMbKTrGW0IEmsc1LOlLmda6l187QtIOyz/briUdfsCzXZlXR4euqqG1U3LacjCweVQ
	 HnHySx686VQfTB+u1bfRA0UBhcQR+y+kW1nZl/Yrq/4MWHt9cgvOP5VbxwS0TE7JMZw3n
	 1/Z7xeltSI+9kuegPq+/nnkaUFsskDgY8NIR9H5XR4mctAdpULDb6wQhLSmbJSCo+QM+5
	 uuNnc3qy4XtI55aaOb2Winok6cBB6gAFHayV7tpJHf7f6TsG38elHpWn+wrix7mqSnxLE
	 SCgp19am0RsUCsvkWu+vr5xRN/gRyR05vZ6lupno+YNQkRo3GYw9Aod6KZITJJl8a3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qYveRbrz;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC159606A32E
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC159606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qYveRbrz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qYveRbrzeadA0BnOmeB4fzMCcHcVgaHgNe6Ao7zItGyCXiNgIUiiAtLXc5MNvg/rghL6KmZGaHIws
	 avvIs67SwcJA4BmI1iDDxTsYivupaGEIXF7PyezNLTFXY2GNXwA4TZee/r6ySiCS3o5OnyGK35nr+o
	 LrbJG+VfYLg735sQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76aea9f4a773-99be9;
	Wed, 04 Nov 2026 10:58:18 +0800 (CST)
X-RM-TRANSID:2ee76aea9f4a773-99be9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aea9f40f20-10582;
	Wed, 04 Nov 2026 10:58:18 +0800 (CST)
X-RM-TRANSID:2ee16aea9f40f20-10582
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add overflow test for BTF dump zero-scan
Date: Wed,  4 Nov 2026 10:58:03 +0800
Message-ID: <20261104025806.1693-3-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261104025806.1693-1-gubin@cmss.chinamobile.com>
References: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
 <20261104025806.1693-1-gubin@cmss.chinamobile.com>
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
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 35f214e254da..68f33f8a54ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -1156,6 +1156,15 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.cgroup = (struct){.order = (enum bpf_cgroup_iter_order)BPF_CGROUP_ITER_SELF_ONLY,.cgroup_fd = (__u32)1,},.task = (struct){.tid = (__u32)1,.pid = (__u32)1,},}",
 			   { .cgroup = { .order = 1, .cgroup_fd = 1, }});
 
+	/*
+	 * overflow test for all-zero union: with a data_sz one byte short
+	 * of the type size, the zero-scan must not read past data_end and
+	 * must return -E2BIG.
+	 */
+	TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link_info,
+				sizeof(union bpf_iter_link_info) - 1,
+				"(union bpf_iter_link_info){\n", {});
+
 	/* struct skb with nested structs/unions; because type output is so
 	 * complex, we don't do a string comparison, just verify we return
 	 * the type size as the amount of data displayed.
-- 
2.55.0.windows.3



