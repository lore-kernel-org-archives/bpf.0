Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764406;
	b=2O++S7rQHMnJ5pBV8rlw2SmxV7zlFC6/AzXCRNHnIzljQ5mKE5m0Soi/cPegVehitXGU
	 H++Wab3Gw9VSaRfVfA/bHII5wpsw11ZI46frB+m8hNzEd8/2/K5I/8CSpnXiVUIEsKsrK
	 YidwDfQ91ajD0b7K8GX20PVMtu/dWNwlnu/AZGUUIkAux3SPMYlDnuS9N5w+BsV9ieHRD
	 RXGuc3nTG1qYTLX5VsftIVp2F+XP1JBHm99ynfsi/qcuxuxBXdYV+BXeei46mYOkVIBiB
	 HaV/NZmmyUmNUynhsFbL/81w6zAMb6FFoi4PpMqtZ4xRulByEpWYnMhE/1yyjQoTctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764406;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hvDsfihavbTWaTK1Z/ukDO+UT53gfddH3QclX6pgajA=;
	b=dFCk/2erquTky0Gq71xNF85MSrpeFiWKMytWa1GQIiZDWV4pHgOzCVNQAMYmobYvLqlH
	 9zjkJ7lB4Y9MA0qRTT5dQk0S3OKIqxmK12GLtUWNmzls2Id2O7cZ+cDiuTUirh2XMMyi6
	 zZ3i/xAK1ZUSSEYyEI3IHF4kQ6B+KL+uhjINzf9GnlnHiOAAvNnP3rkQnYQ/6D7zvVKwi
	 jQAHM9lXzuG+OX3nvVCFjUYChRI3ZVGFV7vGMTYo499dVvs1sewCd+/3nKf09vM8LA+iS
	 KYZrE2XsnN3d0PCsI9HCtxsw7QBrbU6JRtYwocY8KzygogzEYfzu3SGtCJuFU0Koybg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QgEEZcEi;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4071606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4071606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QgEEZcEi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QgEEZcEiPS91yy7SpMLySW6SnunQLKSmxzzNr/tPNyLHoZPFOcHCFa0GlieB+TU4BntAM/vcv1cO5
	 hbFrLfYZGvqOPTHrw3ETzr5C+B0vhp6woWhgrAG1N5eY76YWMv+3XILAkI6qJsSErYTZNnbldQe+w5
	 RNRSLnop3wTCKqMs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56aeaac2fcc5-96f12;
	Wed, 04 Nov 2026 11:53:21 +0800 (CST)
X-RM-TRANSID:2ee56aeaac2fcc5-96f12
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-eb75daa8a6be458c-20260816004526035 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aeaac2e3cc-116a0;
	Wed, 04 Nov 2026 11:53:21 +0800 (CST)
X-RM-TRANSID:2ee96aeaac2e3cc-116a0
From: zhangchujun <zhangchujun@cmss.chinamobile.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	zhangchujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] samples/bpf: hbm: check the return value of fopen()
Date: Wed,  4 Nov 2026 11:53:17 +0800
Message-ID: <20261104035317.1133-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

run_bpf_prog() passes the FILE pointer returned by fopen() directly
to fscanf() without checking it for NULL.  When the file cannot be
opened (e.g. the network interface is not named eth0), fscanf()
dereferences NULL and the program crashes.

Add a NULL check on the return value of fopen() at both call sites
and exit with an error message on failure.

Signed-off-by: zhangchujun <zhangchujun@cmss.chinamobile.com>
---
 samples/bpf/hbm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index fc88d4dbdf48..23304b988a45 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -226,6 +226,8 @@ static int run_bpf_prog(char *prog, int cg_id)
 			do_error("gettimeofday failed", true);
 		t_last =3D t0;
 		fin =3D fopen("/sys/class/net/eth0/statistics/tx_bytes", "r");
+		if (!fin)
+			do_error("fopen fails", true);
 		if (fscanf(fin, "%llu", &last_eth_tx_bytes) !=3D 1)
 			do_error("fscanf fails", false);
 		fclose(fin);
@@ -245,6 +247,8 @@ static int run_bpf_prog(char *prog, int cg_id)
 			t_last =3D t_new;
 			fin =3D fopen("/sys/class/net/eth0/statistics/tx_bytes",
 				    "r");
+			if (!fin)
+				do_error("fopen fails", true);
 			if (fscanf(fin, "%llu", &new_eth_tx_bytes) !=3D 1)
 				do_error("fscanf fails", false);
 			fclose(fin);
=0D


