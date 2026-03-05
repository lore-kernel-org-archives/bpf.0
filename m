Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4543659E9
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751336; cv=none; b=fYv5ByhpqQ3FNTk80pRaG/BBtUpggc0pcKFjWkwyBLIXNRejSdDZ+UFgpDX1MfcW9thdmBxAml+rgpdJI5fc2YbGIhoK0WgMUfX0lYk76l3BalqQh0iOLHELRO24XX5grf6fcnpj0Tw5TJfMMEUWiHLtw7rRqeau3tl41EeSbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751336; c=relaxed/simple;
	bh=uODyuNdh7x5Jz8OLp0UbCOex0Lp+8dbJXwpLGBFAfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua6rE6HUPUcSJOoX54g0CgGsyRgnnKzKVUtpn++XQoH5Gi7k+iHdP6W51wFUxWJUahKrK40ZTjo32sie1yRcDWTMvqy21QbqG6ESvtp4TlNdSxfWHJ29RsYsIF9FlFSbCtuvi5o0wKPaHIRQ1tm3N83HN8NqbPG+p94A2te/YaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7824022AAAA9E; Thu,  5 Mar 2026 14:55:21 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves 5/9] dwarf_loader: Change exprlen checking condition in parameter__reg()
Date: Thu,  5 Mar 2026 14:55:21 -0800
Message-ID: <20260305225521.1153821-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305225455.1151066-1-yonghong.song@linux.dev>
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The change does not change any functionalities. But it allows
DW_OP_stack_value preserved in longer location list for future
parameter checking.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 3d9b626..684115d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1226,7 +1226,7 @@ static int parameter__reg(Dwarf_Attribute *attr, in=
t expected_reg)
 		 * DW_OP_stack_value instructs interpreter to pop current value from
 		 * DWARF expression evaluation stack, and thus is not important here.
 		 */
-		if (exprlen > 1 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_value)
+		if (exprlen =3D=3D 2 && expr[exprlen - 1].atom =3D=3D DW_OP_stack_valu=
e)
 			exprlen--;
=20
 		if (exprlen !=3D 1)
--=20
2.47.3

