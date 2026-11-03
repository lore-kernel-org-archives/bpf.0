Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676393;
	b=ETSqdVqRPLZk87TMBsuWuQdMLIDGRZnzLUn0x2PhGu0X7bnDRcRQCR/iv1571+GCUYfb
	 CDxGx60/ixySyriz5QAuBd/Vu3gNDGfc3N7yRGi+K2WhAu1YU5+BtQF4Nl9BbyFGYYpr1
	 hPGY0ZdHmHd+x8JyXNC2vkPSzxxQejnXxTU5b3P3Hgm6GR7HLQ9hrW43M85rNrEZ9HaI+
	 2F9m67iSlmvO3qCPlIyIyEGXvfBJWs6C3rzmIQCyVVmFC/l/wL7waR4q5b0OTueGnHKLd
	 61rr6O0plrHv/quMGiRZC9ofyjLPbxaHkYCaX914WhzvELSvDv0/VIhToRvbNKXWg8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676393;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DADBhInDimNTVh/BhH/5JIaeE+0uHDMJtNKLrwYEfWA=;
	b=zmUOQ296CRtvMR6zQsUem/Uh0LrP7pzinVpvFSF+hrFuuOQ3xz4sLs6WzVXtF0noSpjb
	 j8MyDAvlX7ZlDN4pCw65uNGB0l3rPAaTvXO8aP4Tf8/323scCavp3e9CeTDCX+fdJJvCB
	 4m3OWZhYFeKlm9Ox3ZBDrBuYmXgLYU1TAnT2K+77dPhFXL1Oq34DaXUFvliytnMsKqt2p
	 SLh8hp8jkAySXkHOXCeUpIaIvaiSIm+sI7CGl5r47aN6Pi4zDdenMC5Y/5z3lB7ksNDTT
	 hW165Id/9jQSW0tjgf7+pitjRO/tuBeik+9aV+coUzU7FYcD4uAFt/CksfVTaCh0RvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YcOfS8FT;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430A606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4430A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=YcOfS8FT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YcOfS8FTJqCQS6AqhFKH2ZfJtsrimg2stknipCaxb+u4Zd7yuTBzAmUrHH6w8kni/IIyOXqsSVolg
	 L63uzMZiN3i942rWgu5a3bJFBbzYoccF8KE9+vIaoSnc/wSiYKwweNBMrZrhDHi1SsVQO2svtriwMV
	 UwTnjALfBdJ1Uuug=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ae95466fde-5b2d1;
	Tue, 03 Nov 2026 11:26:30 +0800 (CST)
X-RM-TRANSID:2ee36ae95466fde-5b2d1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ae9545dbf2-e8c6a;
	Tue, 03 Nov 2026 11:26:30 +0800 (CST)
X-RM-TRANSID:2ee56ae9545dbf2-e8c6a
From: Gu Bin <gubin@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v3 1/2] libbpf: Fix OOB read in BTF dumper zero-scan
Date: Tue,  3 Nov 2026 11:26:15 +0800
Message-ID: <20261103032619.1378-2-gubin@cmss.chinamobile.com>
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
index ea9a34db4c00..d842ae14ef5c 100644
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



