Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761102;
	b=Lo/5HSXU99ft3k7Li7g4UEni7WYzluc8llNqBHRjnwtFZCuBQgUeS/qgHjy0J5zNs+DS
	 +EOlVTJw7uOuaADyZSL92ohciDG/Ph33DZVAthK71gsvfhj1yAjDdtlcgLVi7Vi5R96zi
	 kfa4nENBwiBYNZXDI858pdiJ9JspoklNkRLlI5nR5W9EVjVs0rEhgH8Xsd5fQ4f3hYagV
	 iHVjGtGYD5uuJfZhssjmPMfsV8MsEHLOTH4p5/mujhA6jAx80P3p7pvdNEiMThQvEeO+5
	 jiut3xtaaVvDueVHU6Gk+4aWjYr35k2Hb1+NeNElwxIuA5XxFemzvJdimCRRFLHmAzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761102;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HF7qbEfb7CKsF6zYI+1u2f7KkL3EuJcrpabIdQVqZzU=;
	b=1ByeXyL8t21q+qCSl+XzF/7rEdclmJNQ9wbwsni/V9uc9p6AFM1zPOTWrlvkjZxFCk5Q
	 N4f/ZN3ZyYEXECdNZV3LpgFc+Q2+bsM5wm0X1vkpLtoFzr+8Q93v0z508lYTyPVVWsb2J
	 H/elM/j6JAoaLsMbKSSjoJSCak7pRm8ptsp0EuGHrLL/jc6DvWlZ3Q33esevibx74+cd+
	 frmOZAGSwq4rTSQgSKMWoWrNctCz5Grv7sx9XRLMHEpvMxsDhjLU+9ZsTi7H2u9AV2J//
	 suqeR3HoFUHYXIehwX/vTPZvX2C7BGHOQSgBv4p2z/lfeZZLBSsdvySjI5INZ1PuYSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=whG8Eb+i;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B1606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1B1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=whG8Eb+i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=whG8Eb+iMCb4kdG4KwBwRy6bNx35SUwp87ChjnTcq+U9Mv0cPhIiTNJ7V79xMHsNqRydV+ffhC1wX
	 5MBQWlvjD5+Cw3OuLZQZALiaumWuFYr36E7bnWJQzcSnkcbUpusBGB7up99EceeiJjaWdxKav3Tley
	 wh00z4xs2DOXE7L8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aea9f491a6-d4b0e;
	Wed, 04 Nov 2026 10:58:17 +0800 (CST)
X-RM-TRANSID:2ee26aea9f491a6-d4b0e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16aea9f40f20-10581;
	Wed, 04 Nov 2026 10:58:17 +0800 (CST)
X-RM-TRANSID:2ee16aea9f40f20-10581
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v4 1/2] libbpf: Fix OOB read in BTF dumper zero-scan
Date: Wed,  4 Nov 2026 10:58:02 +0800
Message-ID: <20261104025806.1693-2-gubin@cmss.chinamobile.com>
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

btf_dump_type_data_check_zero() recurses into struct/union members and
array elements without checking the data against
d->typed_dump->data_end.  The dump path performs an overflow check
before reading a value, but that check does not apply to the zero-scan
recursion, so a caller passing a data_sz smaller than the type size
gets reads past the end of the buffer instead of the -E2BIG the API
promises, similar to the OOB read fixed by commit 5714ca8cba5e
("libbpf: Fix OOB read in btf_dump_get_bitfield_value").

Check for overflow in btf_dump_type_data_check_zero(), after the
toplevel exceptions: every member and element recursion passes through
it, mirroring what the dump path does before reading a value.

Also drop the direct *(char *)data == 0 test in the array branch; the
recursion for element 0 gives the same answer and is bounds-checked
now.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/lib/bpf/btf_dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7dedd3975c39..cda56f34921e 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2504,6 +2504,11 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 	     !d->typed_dump->is_array_char))
 		return 0;
 
+	/* members and elements get here without a check against data_end */
+	err = btf_dump_type_data_check_overflow(d, t, id, data, bits_offset, bit_sz);
+	if (err < 0)
+		return err;
+
 	t = skip_mods_and_typedefs(d->btf, id, NULL);
 
 	switch (btf_kind(t)) {
@@ -2533,14 +2538,12 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 		 * non-zero because the string is terminated.
 		 */
 		for (i = 0; i < array->nelems; i++) {
-			if (i == 0 && ischar && *(char *)data == 0)
-				return -ENODATA;
 			err = btf_dump_type_data_check_zero(d, elem_type,
 							    elem_type_id,
 							    data +
 							    (i * elem_size),
 							    bits_offset, 0);
-			if (err != -ENODATA)
+			if (err != -ENODATA || ischar)
 				return err;
 		}
 		return -ENODATA;
-- 
2.55.0.windows.3



