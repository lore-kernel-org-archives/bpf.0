Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F928CF5D;
	Wed, 15 Apr 2026 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223356; cv=none; b=kL1AdxYWaNEuF3ANzjjxBRXVkKSEAmou9CIRJBPkJtspB8iwzTzOf529EltCBHfaekvuT5x+Xeeevb100ivxsvjqNhLaknwUlSk1HClGs0PotxkFoPBBAyj6flVz7ea9DCfZFYg8uwLqagB653aytuoq3U0DKFnNaB4/nYcj5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223356; c=relaxed/simple;
	bh=XBtFNZF0vzYnDBAemLLNAuSdSB5HXypPmUawhF0VY2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBYKjWXT74J69cnttKvWoFL0tq/O0mCKTyKIYnoUC0tpqCnhx0A3I919ao0IoA2/K/7U1Tc7EAHFE5dI8/SENk/tHjGcSEf8IA1NjRkby8X8ZP/tW5IwnbmVTWBG1cTbrcZTf50I0o7t+wmsLoa/htwwvF6Y10fOhezdsf5yFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HOeBnZ5/; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HOeBnZ5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776223310;
	bh=PFYqnV7qM/6YAqub7pCrrliAUYG41gyQubmQPGVobFk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HOeBnZ5/zZLx1RHgaR/gBvqg0D5tk14lRZG6Q89OxdFLMUwdRqFOa/MPI4FKuQG/x
	 lJ4gZa9/+KITgscYPAWdO138yrCJWZGq3BYHhi7zum4yacTC0cXUeK1Go519jMeTVt
	 s6mkpuzgqjbj8LCevdXb/5lBhCclcWMYXCoQwSQ4=
X-QQ-mid: zesmtpip4t1776223302ta285388f
X-QQ-Originating-IP: RpSASEtGQvFEjJ1Fg6DA05FHi/8mF8/eAC2QI2zpL6E=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Apr 2026 11:21:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2927168095533109201
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	paul.chaignon@gmail.com,
	alan.maguire@oracle.com,
	kernel@uniontech.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v2 1/2] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Wed, 15 Apr 2026 11:21:25 +0800
Message-Id: <20260415032126.1096299-2-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260415032126.1096299-1-dingyihan@uniontech.com>
References: <20260415032126.1096299-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MDMF6hDQSemcJTwScwwtWE43Utv8WOcJUKfVEXsEMMtMDXANeFEWd2qj
	Pq3LQPrz/OKoD3OTsvb5hsO/ZukWaphOssiLmUqgkeHcHEjOTmFDBCojD8CbcjkQXkwjPkZ
	Ygx57NQhcS1dIm4NhnNFTmGRAAHu0yUSTG7MIv94mbTR1bOaTeXVCYSPUig3Yjgu/p+zxor
	uQSBejv/I5Wh7a6TfCUAibd5fWYwxKMXuOXLye2goRUtAAsFlwEqksdqT8yOgXmMzslZ95s
	6e/bfEDO3nqJJFNi7wTD8X8dp1M8PtgPnWZfxhwJ6JEMmNEAbOne5FHVH6/oiWpT97R3a7S
	hvuqfN2bLFNHcHUZEFpUBdx0ebo5qp8fi7xpr4pMZbv7P2jg/1R/cb1hCs5GN7zdOy/+b4M
	j9IfPrJ51d1fiviL1K/Z4Ip7VJsoV4wpbVImqo1ughmZUwTkxiRUrO7ntoz6q0eyWNjZ/Cn
	Uycmfx4pCAibQH3GgwSe9Ph4Rf8HmZo3ZQ5YV9TMcAH9E6sp7jIhGaEl8h9nAQmcW1n8DGp
	37llVdG0UhH0wa9dHSVvETjJYZvoNHC2oZv/uMFLnYI43U0fZtgJKfImGzc+7NgErPdcch/
	7v/zcUqaiTn9Il4HL3C8LiI1jvyfu781RePZywzq9l3mScEJdR4X01L0oIUoYcyd5+Hcrmq
	kQYhJUndTVpaGZB1fVNk5ISWjcMhIRRP6E0gMQZGq1OJnfHakZbDOqmxMaebfqcG0eO7WKK
	1SiPGQyWM8K9hAYvDUWTOt5I7BF7MZmeFa6DhI14bFbu1vcBaYgSn7QQEu8zIwi2UnPLZ7U
	Zy+Q2Z8hn30Ub3/8ABduG+89frny8L/qgeweIy/ibHtpU262SpbkdMnlSWKqMXC29B3N4Rv
	VDDyJd4pU1gloNqu/+94BbdzEEn/5oaTaHDBfRqhQEamtskoc0IwcyBVq0jZP3ju3lB5Ye0
	ekWc31W5WfY+dVjjmERADaJWv/6WKUD4wZvAnb7OAYhuXbi6ST30PnUvW6HSTy92KpcxkXo
	eOx77QxTeLbytFnIsZ0yVI38i1iv0=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

bpf_bprintf_prepare() only needs ASCII parsing for conversion
specifiers. Plain text can safely carry bytes >= 0x80, so allow
UTF-8 literals outside '%' sequences while keeping ASCII control
bytes rejected and format specifiers ASCII-only.

This keeps existing parsing rules for format directives unchanged,
while allowing helpers such as bpf_trace_printk() to emit UTF-8
literal text.

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Suggested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 kernel/bpf/helpers.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..6319b39c92f9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -845,7 +845,13 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		data->buf = buffers->buf;
 
 	for (i = 0; i < fmt_size; i++) {
-		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
+		unsigned char c = fmt[i];
+
+		/*
+		 * Permit bytes >= 0x80 in plain text so UTF-8 literals can pass
+		 * through unchanged, while still rejecting ASCII control bytes.
+		 */
+		if (isascii(c) && !isprint(c) && !isspace(c)) {
 			err = -EINVAL;
 			goto out;
 		}
@@ -867,6 +873,14 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		 * always access fmt[i + 1], in the worst case it will be a 0
 		 */
 		i++;
+		/*
+		 * The format parser below only understands ASCII conversion
+		 * specifiers and modifiers, so reject non-ASCII after '%'.
+		 */
+		if (!isascii((unsigned char)fmt[i])) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* skip optional "[0 +-][num]" width formatting field */
 		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
-- 
2.20.1
