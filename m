Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4893845D9;
	Thu, 16 Apr 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341104; cv=none; b=DhlhmUbfrBWbxk67uz7LenGisUIahOa597GSwQdOrye3kpEGlF/mtiZGFgmeVzKHcBGSpvKsPXRXtH9xbf4iMT0DwNEHuy8JDenYIcviWImNhAvTyCWyqwoRRunpN7UZSsueUQuImMIbdf2ivFP//vvrs4OqHAV90MJWLTGAigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341104; c=relaxed/simple;
	bh=H430vWjWAvf4Ag3QNKOR1u06qEqaJ+Xj6lZ/rFlnbOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qjyJ1t6KBHm3naaiNyJzvSyWNkiXySPgnYKSM6ZC2485Sa0zQNWgwGfxxnj4GPeNuNNiUG3WBrnEx+9K62BYtU061o7f/eoetLUW9rHsjk/ROym/7r6hu/5BEjnIhgbXm7YWJLRP2Pa32YljZIhrjXdzubwTf7TvMAs0kYB0Kio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=jfUuVbOJ; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="jfUuVbOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776341098;
	bh=5HOwmbaDA/J8hYTOgZip5HkA0zaO7CmZ3rRrbLHj3e4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=jfUuVbOJaFTMih/vW7edaXDWsdmRK+Saw24j6CA3ce4w3ASllmNWRpvWikSQbudvr
	 aQJQWJT9Ll+4fAVPWiYLbvo6ZjvZfJvQll7VjgHaSbqCNqNBTN5PjmYawdcxkXLNz4
	 KOkrnwdD08ZIGfjAS/2CBo7hOOurwKlByPbnru9g=
X-QQ-mid: zesmtpip3t1776340958t3c23c2c5
X-QQ-Originating-IP: dlTyD/VH2KbXh+3uhbcZvulXvtVs/W2VqQFnVeAiJq8=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Apr 2026 20:02:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9829649568359731250
EX-QQ-RecipientCnt: 9
From: Yihan Ding <dingyihan@uniontech.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	alan.maguire@oracle.com,
	paul.chaignon@gmail.com,
	linux-kernel@vger.kernel.org,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH bpf v3 1/2] bpf: allow UTF-8 literals in bpf_bprintf_prepare()
Date: Thu, 16 Apr 2026 20:01:41 +0800
Message-Id: <20260416120142.1420646-2-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260416120142.1420646-1-dingyihan@uniontech.com>
References: <20260416120142.1420646-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NeiWbSP+6EVLLr3p+rr4xVHvaSuAeCvIg8+5d20a8MRe1wBpBuWChN8b
	Dj9GVPWqzoSuqBQvDz8aWG6+zcj4NnNeeZ0oL/DriIjOqC1Nm9zd9ZONLV6yK2mf9q42zme
	6SJ/Z4R5FGD/KkzHbeDl+2Q3zvUzzKRO9U9LpA/Zu/3sMmy41oAzvKZSy3uVxI9h9BV/bGx
	RPvVyH5ccdkao75cZzUx+KypOwxZqCg/pdQJFgVUnvklMS1RFaq0vAXdey8sSA18B5lyVzS
	n3yxmATBPB7vcP0lfbIG1gKxZL6dBqj2IbuFNDZld1u8PYsRwflpd8r2JN3Wya7WS59gMzI
	rHYhjJdsGoyqDdSconi6NV6gBmShck+u94rB7TWbbJZHzAK+pUPZKCoKA5WevAwPH2f8kM6
	b697JuqF3A+UbXzhJkY0ED5BPlqeObtwP2dsC1wMnEpftpKf+Fotk9Av8bRx3vqMWQu3usw
	4PYWxOL5EYqHWW/qBmOiDC5HZCMVJsnFi/5QRuntJwqEkDPFN0uaTs4dXJ99NpSJccS14M3
	Z1cDEkMe/LRO1YF/x+mQIhlwKOilIZJTHaHkfvznhClRGWmoTLeBMc6W3NHWf3Ol0ATTuJQ
	Y0IK4kD55cBNAnKHPQ5OIEQOIijzYDbnJ9zv3xqR5sj5xuaBxzuuTD/q5PotM8sgG08nqT4
	3FzwDW3r/DR0Ju1Ih9AskG2iYmyHoR3sV2MqQrdE0IRxxaK23V4KF0Z/Tv7/qq4EVSEeefG
	hw9rHuNrEUoJX91IvQDrMB2r0W+VsGG35AlWrqXsjmyoiQoyLbFiqSNQ8nqsr4IFa1T5nQT
	g9x8dHDpzywUnOC5Mpoesukap9wigaV+yLAYYatmLt60hgcy3CS6orLIj4XwgIX9LDTFS4d
	oVvJVxwXr1VVmYoT1AmanFfK4TSHCfA/qeDsVG6HlztMH9/a0+toANqlRze97aQVm2Ufi77
	r8sRt7/S8tE+cBHuF5qL4Bp1Qnu2w6N0qBUN58ibXj+07q+XJV5XhZqyh++mDdawrgcW0Vg
	M4440GSAuorgoghn0qYyLxZz1XHnpXMxaZVnxappD7cHCwNZcmGq18Lxpmp7w=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

bpf_bprintf_prepare() only needs ASCII parsing for conversion
specifiers. Plain text can safely carry bytes >= 0x80, so allow
UTF-8 literals outside '%' sequences while keeping ASCII control
bytes rejected and format specifiers ASCII-only.

This keeps existing parsing rules for format directives unchanged,
while allowing helpers such as bpf_trace_printk() to emit UTF-8
literal text.

Update test_snprintf_negative() in the same commit so selftests keep
matching the new plain-text vs format-specifier split during bisection.

Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
 kernel/bpf/helpers.c                            | 17 ++++++++++++++++-
 .../testing/selftests/bpf/prog_tests/snprintf.c |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6eb6c82ed2ee..d51f1b612f1d 100644
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
@@ -867,6 +873,15 @@ int bpf_bprintf_prepare(const char *fmt, u32 fmt_size, const u64 *raw_args,
 		 * always access fmt[i + 1], in the worst case it will be a 0
 		 */
 		i++;
+		c = fmt[i];
+		/*
+		 * The format parser below only understands ASCII conversion
+		 * specifiers and modifiers, so reject non-ASCII after '%'.
+		 */
+		if (!isascii(c)) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		/* skip optional "[0 +-][num]" width formatting field */
 		while (fmt[i] == '0' || fmt[i] == '+'  || fmt[i] == '-' ||
diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
index 594441acb707..4e4a82d54f79 100644
--- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
+++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
@@ -114,7 +114,8 @@ static void test_snprintf_negative(void)
 	ASSERT_ERR(load_single_snprintf("%--------"), "invalid specifier 5");
 	ASSERT_ERR(load_single_snprintf("%lc"), "invalid specifier 6");
 	ASSERT_ERR(load_single_snprintf("%llc"), "invalid specifier 7");
-	ASSERT_ERR(load_single_snprintf("\x80"), "non ascii character");
+	ASSERT_OK(load_single_snprintf("\x80"), "non ascii plain text");
+	ASSERT_ERR(load_single_snprintf("%\x80"), "non ascii in specifier");
 	ASSERT_ERR(load_single_snprintf("\x1"), "non printable character");
 	ASSERT_ERR(load_single_snprintf("%p%"), "invalid specifier 8");
 	ASSERT_ERR(load_single_snprintf("%s%"), "invalid specifier 9");
-- 
2.20.1

