Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670841A76BB
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774401766; cv=none; b=Oc49jKcsV2ztGeMj+vggCRiBKJtamWsZiGEKVy2QgqbzkGq3WNgOH3HwhW5dLk9sxkV1EOrH0m7H22Xm5bQQ/CLBO1FxtaoBuxZJHOh449D/tEcdYDvwg8+Y0QULr+yM1vEiWEpY3E4WqdQzmzi/yya0wRpF73/venBSozhA73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774401766; c=relaxed/simple;
	bh=B+dN8RZxJKzfj9LR/j91zLVjuK+Cnv0QbwsGVaZiB4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=po7jWZO1iU79xDrhlGBNRticymNUajDqqjyDVM3cv5vOjuX/0H5ebPU+++Qn9U+coE3IaaY0J1OCHSB1Sp5QbnIjv9RfsECOKaaqgt7VHLGETTV93w1GA7W7S1Q2XP4a3sE2wsfkNL4SIpVfac5YoY7D+lz3FjmNcWBmX2uYpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUJ8ORwS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUJ8ORwS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso2638819a91.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 18:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774401764; x=1775006564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EIcsPFDC3rFDzJp4RkY/pTLsnJ0uVeVwwjl8yw9hWCI=;
        b=mUJ8ORwS5SXMj0ejfb8QQJ8e4XHTYL5h0vjJOd7I7HFOUk5exmbRapxvqpwOix5iJh
         KBzzFcH+YC1E6isYSQVM7YcN/k3A5YOj645/l0Qu0sn3R6QgLppQYOHFY2EdXfukcptn
         4DC+UYsIMT5UEQ+8gsbZeTvym/MpYZvNcxMu0vC1o2seOrmbiv0CoAPGwZ3nPEWtKUcf
         h1yqksjalOOTXg2UY9BQazgHb2EbFLbVPM8Dm70JmEWXVvfXJWfnuhj5KV+kzkZwWay6
         6g6R7WTjLf1plHOqY3nmkiS8eDI/IDIjNuleSbBUcP9n6xloTbH0xB7w1FMzNDWrXu70
         RBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774401764; x=1775006564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIcsPFDC3rFDzJp4RkY/pTLsnJ0uVeVwwjl8yw9hWCI=;
        b=DT79bKpMvgl8TBwQSWUF9kU65B4Pva6eUgrO26Ww1Ncm140NlLrbD/BRCEbel8SKci
         N6w372J34WKw8fpQKD+srEELGeRZkXwz//zQ77n0rXR+nljSXElGFeOwWYRJQJf19+Kl
         HjRTIwVZYKF/IRUi7YRyTqIlto43dmgW1j/+viqXHcaeErEj9CLvJy3/riX81JnM/c29
         MPwHzOb6Fa9PmymN1O/mPIegl2TJO6+4p6jCNAFdtZtOwYynGupu4wMYEIN24bA9CJy8
         ICw598ljWqz7vPznIOGC2yRG/GiLLqvf62rIJhm3MWlIBwIqt3NBxo3Ra5RYD7OcZBAN
         GVvA==
X-Gm-Message-State: AOJu0Yz2/67SSqLGaZW8LbE9m5UQgi2Qy2ZvP8P7Rg8HmtlroIhhmtlm
	ZLPWjFG9fRVAf27BM9aMhLtPmxpqpSpj8oXNbXDf01IM2KcGAg6FbIKHH6hOXA==
X-Gm-Gg: ATEYQzyGkH+YGUJJTDGjj/m6CB4f8qmFWcs6w8dDC+LIJO0TBrG5Gin3763h2s/kfJd
	Nn5JwyCmScTNeFeG+rFjZsnkPTTpXLK6UYORcHQKF5f7tKGrHuy8iZLDC1DMzHHfXhejBsY0H31
	SRfR/1ON5+gQlEbQcENVBYlZt8GU/zE1hJRTCVuC14GU/xWflJ6dG5SlPCr8ra3HVkmm8UwI1G2
	FsoJhXCfcQ3LLaqXd1IOTET34GqJWxNUxULgTtGNZH+NxsmycI6t334iGzMQMeFk0gjKGnfM1Rh
	NhD30oyqgm5tq2rTC1MBlYZccQ5QmQn8YQjkumtjWbiTpJMPPhzP2W3AarPZpFwdcX5a/pkl242
	C0rOCRRwGVn025zAI+B4Nm+e45GZVzM76E3xDZ8AyL7NC7rIybSAhSlwPY+YE8qWUByNo+vJ9pr
	FjdzIf1hv7lcpMjE90AW201EM5DCUTEznBgTjPWmBi45/N68JP9k1yiWNPHexDnxAM9E/NiZmCj
	GtIEusOEfyIaB9Uk0SeN+szgdmYVKHk5iwuPYIUG7Tfm69OPKRZngzZ9695OQ==
X-Received: by 2002:a17:90b:4ac5:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-35c0dd6a9a1mr1406378a91.16.1774401764466;
        Tue, 24 Mar 2026 18:22:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352aea8sm206988805ad.21.2026.03.24.18.22.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 18:22:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH bpf-next] selftests/bpf: Make reg_bounds test more robust
Date: Tue, 24 Mar 2026 18:22:42 -0700
Message-ID: <20260325012242.45606-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The verifier log output may contain multiple lines that start with
18: (bf) r0 = r6
teach reg_bounds to look for lines that have ';' in them,
since reg_bounds test is looking for:
18: (bf) r0 = r6       ; R0=... R6=...

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/reg_bounds.c      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
index cb8dd2f63296..49886f1b21e5 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -1217,7 +1217,23 @@ static int parse_range_cmp_log(const char *log_buf, struct case_spec spec,
 			spec.compare_subregs ? "w0" : "r0",
 			spec.compare_subregs ? "w" : "r", specs[i].reg_idx);
 
-		q = strstr(p, buf);
+		/*
+		 * In the verifier log look for lines:
+		 *   18: (bf) r0 = r6       ; R0=... R6=...
+		 * Different verifier passes may print
+		 *   18: (bf) r0 = r6
+		 * as well, but never followed by ';'.
+		 */
+		q = p;
+		while ((q = strstr(q, buf)) != NULL) {
+			const char *s = q + strlen(buf);
+
+			while (*s == ' ' || *s == '\t')
+				s++;
+			if (*s == ';')
+				break;
+			q++;
+		}
 		if (!q) {
 			*specs[i].state = (struct reg_state){.valid = false};
 			continue;
-- 
2.52.0

