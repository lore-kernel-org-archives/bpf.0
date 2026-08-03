Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F03382C7
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785726903; cv=none; b=KzvxFeaXkqo3811q3CMe8KluDM8zRgI3GrGI2QHmDy4p4LgB+BsLJq8e8RGI2oUkhKuxKGvCAeJN7OAn9Z2eSR6orQT3txNKmDSrY8muY5PzRmpZFYZqU5gz499MoKckEO+G5ufoqE7H/ikyZ/588wCZHKzUV5H5pL5pHWC9A9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785726903; c=relaxed/simple;
	bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6TM8xr7ZdYRD3lAkw4gRuc9j6M5N3fRaoQ07ZuWRY36KHKJ4MH6vqrg3gsSOTnJBfXKaJGIV61GbXcfBzgi51mqUs4l9WDjMQPXNoaEy28GvtVxCaiaXTAFBVx0H/uhxQx+rcxja6SKyRmhzqYCT8Pb3s3CeCP3rfsRwU8FJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AS67/Ykh; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AS67/Ykh"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fcb9d4b33so1460484f8f.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785726900; x=1786331700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=AS67/YkhhZEvh08yYjt0aFLe1+dBqHyaHe7E4s2j799dndkG83ovKLemLttr1rx0n+
         LhIlxwseA/+lMVvCtnDK5MUeL2yLcY5G6ugb9l8aVqbaROccupigJ9px7dRFzrrHtkIY
         ImmwNXw5+QjC8kEbLIaoJhMJw2WHRq9HNRNMoxpsxAbEzKVBl6F+U7iz4m2zcIqO7zDO
         Fo8I6VsqkjKFHAyu9C+G0+/kt7cYhs9HV+wvvRPfdgyEfZjOY5DZWGC58mX/IAhEr0ca
         E0vRyBrE3mjkR0LGlCVgQszoGg6dNqccKlPxa4QIb4BmTH5QHVZhUdXXlbbBN7If2iTm
         EgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785726900; x=1786331700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=GQgBUdH5tjEYKCmTJfAh624SomScEZ23JZ9tkHUZLJIduadmhHkPpGhSQRbhqxbbNd
         LFZc0QmIbjy55CqoBK9z+/y9gfXZQZoVTrM4FKa+BPVSBCdsGNx4X9GCItJvEnIjHPJ4
         mVcKuwdVtTHBoGEM+67hluYC6ttuisoRxKn9nRwSFgG3tz/f7PqQ2wHI7k/mbZPnh/Ir
         0nSZ6ohkOAZoUvfyfzo+mZaLER2Zh8PzMUti12OHEx0NAK/qsWwmMJshuf2EFNVF/QFm
         lr7Pp+4ZVS9yCvZEoIz1oziO3Hq2QGaeMdlVx6JdINb9xwBkzH/0hBptDeu2JFhjPSd4
         ihtg==
X-Gm-Message-State: AOJu0Yw1DPOlE0zfDnqCLp+eu3Tcxcdfc2CtiFsMBaehLif5/seHubzk
	NWhXPALCSnRbofwUXwU31OCvye4x00KrVi5jr8zU/AkJDRgrPlbGZ7fOYd1aB6KP
X-Gm-Gg: AR+sD12kSxDyMoWGaOcSaET6oj7o+/mkknR9afGwRMHXt+fFmzD0i92SKP1wW3xqua6
	zXl74DQFscr1te4QVYedx9G5QUG3zgfDvIXEmf49TOoc76L1EbWU4OO4IU8LjG5aGaB9s2n3hbh
	U3wh+0Hhma6iHX0wSFfGBCooGLlIBUMxm64pfDh6FFUktCu8BHSDgymL/+7t2gOEdhjqIIbns8v
	p/LOX1btgjx02LuDWWtTSZherM8caRThb1VoJdI6Q6Na4gzeYcaD+WMgtYfO3oA98bh7DNzwtOI
	O9tj9rc+UKhaExHc+Pr3eB1QmbFt8rUgMfTbZQI1hFeDCiqqMHSjEegMuAu7QvJywEh0zcKiiOP
	KTv4SA8OUcBDiqj09Vh9tRm3wO1bBQAKEimhyQZv7ZlR1MGN70Rq/TF4Nu6ElZdDvjd/QzJMvQe
	DY/H/s/ccsWAEQ281OWYhD67tQLbR5x5uHX5+h2MjkHUsx5/wq4rKv+qrqF1/mPkTXrI1QXLXZY
	zsoC7qCGSWqsHTlg+v8UdXi70GB4qQ2BG68g91Wj+tCG5ycW67+vbrWJBZkcfhwS7h5q1+zY+Ri
	XQaxHIEznwy0FRVQehxzjTA3cms=
X-Received: by 2002:a05:600c:3b1f:b0:495:64c6:84e9 with SMTP id 5b1f17b1804b1-4980c5e0e47mr151465505e9.0.1785726900107;
        Sun, 02 Aug 2026 20:15:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dbaesm319706675e9.12.2026.08.02.20.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:14:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: Adjust veristat stack depth parsing
Date: Mon,  3 Aug 2026 05:14:54 +0200
Message-ID: <20260803031457.3115812-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803031457.3115812-1-memxor@gmail.com>
References: <20260803031457.3115812-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=memxor@gmail.com; h=from:subject; bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauAfdaXN76bBFx5191bl1uaXz2Z1afW6sOe7IOJUcvvB XaI8zN2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLnfzP8M/Z8/ipfP0NRnbM6 77bYIq03M9/kzn7Zo7Rv9ueYae5PmxkZms4uO73nLf+5WN2fvnUO/+54mnGu3BfxVsL4vf/6D7e ieQE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier now reports stack depth statistics using one record per line.
Teach veristat to parse the new maximum and per-subprogram records while
retaining support for the legacy one-line format used by older kernels.

Increase the bounded backward scan so it can include all 256 per-subprogram
records.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..97397b97745d 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -993,13 +993,15 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 
 static char verif_log_buf[64 * 1024];
 
-#define MAX_PARSED_LOG_LINES 100
+/* Keep room for all 256 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 300
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
 	const char *cur;
-	int pos, lines, sub_stack, cnt = 0;
-	char *state = NULL, *token, stack[512];
+	long sub_stack;
+	int pos, lines, cnt = 0;
+	char *state = NULL, *token, stack[512] = {};
 
 	buf[buf_sz - 1] = '\0';
 
@@ -1025,11 +1027,17 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
+		if (1 == sscanf(cur, "stack depth max %ld", &s->stats[MAX_STACK]))
+			continue;
+		if (1 == sscanf(cur, "stack depth subprog %*d %*s %ld", &sub_stack)) {
+			s->stats[STACK] += sub_stack;
+			continue;
+		}
 		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
-		if (sscanf(token, "%d", &sub_stack) == 0)
+		if (sscanf(token, "%ld", &sub_stack) == 0)
 			break;
 		s->stats[STACK] += sub_stack;
 	}
-- 
2.53.0

