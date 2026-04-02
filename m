Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF038AC8B;
	Thu,  2 Apr 2026 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115803; cv=none; b=kqrVrlOHVR97sYYj2JkIToE6l/bT8E5mBstRLqRVBH9cMEqJNzWkqXWkIOAfvsBbr2hdEW83ydbxvqKY0kXDpFq7ckwXDe9JA8GmvPqWuz1A1YB2sl1+Kf09Sb7227ct1KPhWG7kPnUZdCuJQb4KT4kJapQGKvlW3DnbU5sctWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115803; c=relaxed/simple;
	bh=YX13sLn6pbupoGA3DKDkyfLdyhL4r9A4RGREkwORFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcatzhPV5oIC7hvcwb01CXEjkraXBD4Gk49QTFC6oqzo4/L5ACxHvqsL03Mws3bG4RpqzgzKL60+Axz4x9tgZhERtO9JgWlaQC5at3hm+mxp0fxb2NtS1NFTd46Il/Z/rjo3tvjPM6VWodbCJl8XG2jrFfVNLWHtidrCdH57apY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JEby+ykI; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JEby+ykI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775115765;
	bh=yJVKkdX5pQnrGRfKGg0vycfLU3Us3QpJnv9UWNiLO1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JEby+ykIGcKnLojJh5kL3uSpzO6YkoDFZoQtDpWPHRS59DWS4aOruZU4ePlnc0Rbh
	 a5vylmOaEHTDFsOjJ9liRGdgsp/J+WhBfD6ArqnKMoBHVkDWL+ym34FtnQs8V50Zw2
	 uVqqpG2JG5701TGkFidohtIlMSBRVerVsDvTb0hA=
X-QQ-mid: zesmtpip2t1775115759tb8549609
X-QQ-Originating-IP: 2uwqqGjE8Rfb5i0j4GW8DbKfmCOczpjPJ97I+24bzqk=
Received: from xulang-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:42:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11635830478050872402
EX-QQ-RecipientCnt: 20
From: xulang <xulang@uniontech.com>
To: martin.lau@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dzm91@hust.edu.cn,
	eddyz87@gmail.com,
	haoluo@google.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kaiyanm@hust.edu.cn,
	kernel@uniontech.com,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Lang Xu <xulang@uniontech.com>
Subject: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
Date: Thu,  2 Apr 2026 15:42:35 +0800
Message-ID: <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NlBVHrzzRXkubixekQ6m9C6QmARH1JU4vNwWehDFCpzgBT7yzItLuxYd
	3+WDtZ0UeIGmTsl2ALABBg5H9JOnO8fczk05xb6nG+Eq1PTYpCWTpwAlE4QpJJvPu9xY8Dc
	JFIS5jLhEj1zM4ZPZ4oBUEGZqp7HfLoFcFFaxk7NxSmWhr9NSGiNrLrY1y/Kk6hLGEyZdtf
	b1hdIivNq0t0cbWr8S3wrvMLLeu8FCqKJ9MmgIpTZ65yzpxj1aiv1VeKfg0duah4VdRCK7Q
	YLf14w8RWpkY/I/HXTMQ6z3Zl21R/islRjxtZxlp5CyUl5HdPA3K6icD4ZzPS7XYH/Ppi+R
	JmKX6inZWB7mIiLqNFjpYlUB+Jd+SQRpa3VSBAPRGjERv1+ZN3fMfBUTeB4i7d/39BMJoqv
	1ZDs4QbDbgW64pFNIo2okONqdZHcGEuPk/fYbs9iEAlpFOcGWmCWhJupLJU1vZwwhCniUpp
	ztcpzktJf7+y5IHv7V5IV8ldlx4X508j+WDCDjb2EJSbPRz7vaaLKPpXzrdVtc5iY7n4izj
	7LCIaaGNesdOpcqG71X1AwCmpX0Y8igib1Jm4EdVy5VFQIl7rzO3pk9+u82/0GW1qmwUhfG
	fhMxlX/0WZ1QIU1+IAHP4qZcMJkeHeeqr6HrKNHhBaeSDkmWFnX+hSuvueo1WhQ+csrgt4p
	J21AKKf7iwwW7rZtKMzyPKx/vV3Dn/5lmb/8Tu3AyYS+NJ2Wi46JW0d0XgrZrFW/0UUOO+0
	dtoa0v7Uj8NBuLBfpQrA5SgQHkwNgya30EDE8B71lRQxEKhsE+icRNWif8YjBUWa2dFmsx4
	UldgeDn15xJM/YYrBiNU8frUXTrKhg4N/IyqJHkNjJfnbuOwLbJ0R/zJlOjPVevrdNMefVM
	2jEJiSKkP2J0GCxJB70Xe9+bIa4TQfCVFPMzU509E5hqRGyn1f6ePytGX0bkD+PFdJIw/fv
	mTojzEtEwMxzDyLoAlVh7sJnRG1DZY7/kN5SXDbAX2MrykRjyG780wxUzoDSYbnUXj0rsgj
	lHds3DjUwxiDDKzBchswjW5shOFjB7wsX3AelUQa6qM6WlkIckE5iB6I4+u8iluy4byBt9b
	jc3Z6HQXSauAJmWWyDCGH1a0d3d1yhAnuL0YwRxyTiLIRBgOoyF/l/+ONf2v9O/+qR896xY
	h7M6N4RgMvMCGQ3G+EEHQkSI1AVY62f1tv7rdkRuQJ514us=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Lang Xu <xulang@uniontech.com>

An out-of-bounds read occurs when copying element from a
BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
same value_size that is not rounded up to 8 bytes.

The issue happens when:
1. A CGROUP_STORAGE map is created with value_size not aligned to
   8 bytes (e.g., 4 bytes)
2. A pcpu map is created with the same value_size (e.g., 4 bytes)
3. Update element in 2 with data in 1

pcpu_init_value assumes that all sources are rounded up to 8 bytes,
and invokes copy_map_value_long to make a data copy, However, the
assumption doesn't stand since there are some cases where the source
may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE, skb->data.
the verifier verifies exactly the size that the source claims, not
the size rounded up to 8 bytes by kernel, an OOB happens when the
source has only 4 bytes while the copy size(4) is rounded up to 8.

Fixes: d3bec0138bfb ("bpf: Zero-fill re-used per-cpu map element")
Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
Signed-off-by: Lang Xu <xulang@uniontech.com>
---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..fb8123cfa5ec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1056,7 +1056,7 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			if (cpu == current_cpu)
-				copy_map_value_long(&htab->map, per_cpu_ptr(pptr, cpu), value);
+				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
 		}
-- 
2.51.0

