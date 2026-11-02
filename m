Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625409;
	b=lM6C1JeQrzxIwy1jgODB94GmIH4f2gz+rFjz8ytITywlTpwWdyqPNAhrVOWrek7MQOk2
	 /iQXOUejUOSA2dIRHZD9ipDZ2QXGwO2tbYELMez916kb0v0IXQ7t+u+f/iJ5A0yipBIFy
	 77POgPKDH7VG44HSFWyC21Vu/QynkpMMUPEilZkuCLt2C+Lr+goB/VCgOuNktcbeegtc3
	 44Ia+0M7lDjqHaPplFIZmouI2MU62ft6qvSsmp2DBHcz9pVPuSsQG4PVuNcFUBlEKm8TM
	 HRFSUXmIp3t0qU6FOfEu8sRpDwpylIG9SKL8jl9/x0M/Qv0zJovwtdwgTCPMtDgakag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625409;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NTGss7nnEBqzeWJCl9cFJRFgTFm2OzdJpRqK90NLg+Q=;
	b=hYOHiZPql1+oGeV3NFiJacAB6wjkTukhUC2aTlLWAL/VLg0ICLy9FeRHXWev4IeOgTVw
	 Q0uMSPjqtlLXaSrihZ6j3a6K392iyp6jBfrTarBP0zv8whfY970l9sQc4ysB3ys1PUVp9
	 EK7YajW/ml1LG/MXPY+mCuE5JYVmZS9IiOAuQSrxVVU6RtMECCd0L7f4VxOzzKsaTkBcD
	 po+i4+9uwaPLlRmOoPd/mK9Z/JgIZUKda6c0a2tsprdTdQaeB6eW5E4hZUIglUO9vLhhO
	 bppp5utBnf4/owuHRNOJdxDC4W/Aaw+NBh8LJD8LnUkpRPtCpguo1/XXNTfb5fneVAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RBL4VMAQ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2F606A32C
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 13:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51E2F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=RBL4VMAQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RBL4VMAQ9JQmgGWX5pDJAcexw5vyXICem7DnyVCcdwTGA2NEcAp5UYVf8oNDvMA1+wOhx0OCaD9OV
	 WMYkGR5uCBHax4WE6IM80u3XUPAtXOaD+o2pNNaieAX9E4Qvld9xmCNYg1C1UslQ1PRuuaGg2cnE91
	 opwn339Z/c7Iqjtw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ae88d37561-29e7d;
	Mon, 02 Nov 2026 21:16:44 +0800 (CST)
X-RM-TRANSID:2ee46ae88d37561-29e7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26ae88d31524-d2f35;
	Mon, 02 Nov 2026 21:16:44 +0800 (CST)
X-RM-TRANSID:2ee26ae88d31524-d2f35
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com
Subject: [PATCH v2] libbpf: Fix ENODATA comparison and unbounded zero-scan in btf_dump
Date: Mon,  2 Nov 2026 21:16:31 +0800
Message-ID: <20261102131632.1124-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261102085122.916-1-gubin@cmss.chinamobile.com>
References: <20261102085122.916-1-gubin@cmss.chinamobile.com>
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

In btf_dump_type_data_check_zero(), the BTF_KIND_STRUCT/UNION branch
compares the per-member result with ENODATA (no minus sign), unlike
every other branch which uses -ENODATA.  The function returns
-ENODATA, 0, or propagated errors such as -EINVAL and -E2BIG; it never
returns the positive ENODATA, so the comparison is always true and the
loop bails out on the first member: a struct whose later members are
non-zero is reported as empty and skipped by the dumper.

Separately, the zero-scan loops over struct/union members and array
elements do not check for overflow: btf_dump_type_data_check_overflow()
only validates base types, while the scan recurses into aggregates and
reads member data without bounds checks.  The library explicitly
supports a data_sz smaller than the type size, so the scan can read
past the caller's buffer, similar to the OOB read fixed by commit
5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value").

Fix the comparison to use -ENODATA, so the zero-scan visits every
member and a nested struct or union whose leading members are zero is
dumped when a later member is non-zero.  Also bound the zero-scan:
call btf_dump_type_data_check_overflow() on each struct/union member
and array element before the check_zero() recursion, mirroring what
the dump path does before reading a value.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
Changes in v2 (addressing the bpf-ci review of v1):

- v1's commit message claimed check_zero() "only ever returns
  -ENODATA"; it actually returns 0, -ENODATA, or propagated errors
  (-EINVAL, -E2BIG), and never the positive ENODATA, which is what
  makes the comparison always true.  Reworded.

- v1 fixed only the sign.  That made the struct/union zero-scan walk
  past the first member for the first time, making an existing
  unbounded-scan OOB reachable on that path (the array branch already
  had the same unbounded scan, it just was not triggered by the sign
  bug).  v2 bounds both loops by running check_overflow() on each
  member/element before the check_zero() recursion.

- The message now also states the behaviour change: nested
  structs/unions whose leading members are zero are no longer
  reported as empty when a later member is non-zero.
---
 tools/lib/bpf/btf_dump.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7dedd3975c39..113d89ef1cd9 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2533,6 +2533,12 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 		 * non-zero because the string is terminated.
 		 */
 		for (i = 0; i < array->nelems; i++) {
+			/* Check overflow first, as the dump path does. */
+			err = btf_dump_type_data_check_overflow(d, elem_type,
+				elem_type_id, data + (i * elem_size),
+				bits_offset, 0);
+			if (err < 0)
+				return err;
 			if (i == 0 && ischar && *(char *)data == 0)
 				return -ENODATA;
 			err = btf_dump_type_data_check_zero(d, elem_type,
@@ -2565,9 +2571,15 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 			 * of member can retrieve it.
 			 */
 			bit_sz = btf_member_bitfield_size(t, i);
+			/* Check overflow first, as the dump path does. */
+			err = btf_dump_type_data_check_overflow(d, mtype, m->type,
+							       data + moffset / 8,
+							       moffset % 8, bit_sz);
+			if (err < 0)
+				return err;
 			err = btf_dump_type_data_check_zero(d, mtype, m->type, data + moffset / 8,
 							    moffset % 8, bit_sz);
-			if (err != ENODATA)
+			if (err != -ENODATA)
 				return err;
 		}
 		return -ENODATA;
-- 
2.55.0.windows.3



