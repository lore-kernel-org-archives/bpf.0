Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA9D37F00F
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742060; cv=none; b=CGzs9a7vwvIwDeh/ex90RjSwDCg9pi8EQZUKIbxqPzt8TNX79SsQ4FrDdMNvbnE6J1KVaKA5N2irK3wE00BjzHXn0XeX9w2MP+sJHKTr0mek2KQfRcCMjhUNSEg98BunXNaUYBoBUVcowo6FeDuK4SoOZFN3XjjkxuvuDy7/KdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742060; c=relaxed/simple;
	bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSCxtjoDhzRpC998KJKgjr9U+Z+sK5vHdRaI+dXCaiErSpM/FcD+IqB+siRPcmPg59FPB8SxIoWShUWdh8wuXqF4nsV7SLp3+o4hPVF2mOXQJ+6RhcZLQ2jyNS6sAinYqdDy0JvHQj1+2c4Ayf25cUxVPKKD2hIUWao+zO4PwPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDK4WO/f; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDK4WO/f"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso1075387f8f.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742057; x=1786346857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=LDK4WO/f+4CH2IEGfN2OXkEOgzyevKHDmRqn3ohDyJjD40EcZUpPAPa4Sbq54olqRF
         FlYtdXm65sxelp+7NwqtH23EFWlPaNodfW7wsvLOF9bsHQGz8oZPgxBy+7tM/d4/BKi5
         s4nsS58vEJvYoF85ay8N9TNIyQVbxRy/XK2Zk42IRW79zY86nKwczAkn0pvvmaOcU9dR
         59hrYKj/iC3+qTbjYLuo75mHsjSMPGLf8/SIzlEA0RjIaU12b3lEJl66DGMbplKV8e+L
         acoOvw7RbZMtUtmS0BvvEG0+/M7qv9LCX30pysh70jtoVKCqbvcb54Cs22vLsKYFSy+J
         byyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742057; x=1786346857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ic95oExLe9ayad89sDmH7iqZRyaDDbTl0bVoXaSRyU=;
        b=oABau79f0aa/383mKGX7rHW4J4L2hC/eWqeZSHNDbxs4y+DbD1fyDEJHSCK4DJvALq
         q5UhtnsIVQRoikk9V7ZdAvLdSqsnlu8/NncvyJFITwqHup91ygjAJer8DYyU2j8Ks7+u
         vJIywF2kvH03XE7j4GOyvJJ8U9d44S0rmWztfIH1JZ3dInUmrdm2Om3HX8VrtgsgCtpH
         c2ndnUOMLk91LtwYZzP+34LnsPDZ2YJwvFbDpNCfDO8ew75VJLP/JZVWO2LYaDl3PW27
         pNkEuDnU1vQLbH1+SxOXyiaumyMpdC/luEa0tq1anEjw7rWsHHeAf3PzOgM8fyK8/oYV
         5G2w==
X-Gm-Message-State: AOJu0Yw4gx4WBprbsrM0tspT6lu/Wrr+mcFEq/6dnSihNb8gwya+SPd+
	+lVYWd92XGE+eJZyh3eS1L54abGOtG9p/Q3FNDzOg/XOAL3l0j+QEET9zcOEYz+/
X-Gm-Gg: AR+sD113ydtQeKwhzLun2f5TtzwTzMI8J06yeTYeRMsSIwTx9F4gMGLx6nMpmEWgGK0
	MSSWkL5OUN2Ry+8RoD13A5ArtPslf+MwwOfsSPIo+vLjulBo4gpijIiDHOYpOuE7T/Jf7qHnV6N
	LQ8Xv9LlGX5bU60FQa8Y5NQ8+kdi7n+pYxQLlAh24lAs+Y3AV9NHMkXgaoija3h3hYR7XRudVwk
	Xo3g710RQSQ+xRDi8X36aPBcKEfsWPHvUxp1DQm6LquPJ/RhHHeO9m3y3UAQAOlEVs8hgB8tR2V
	b/orCp3wnOOmu6AXr5a/zBSIjve1/PdQZBLoxiXdCnXkrb803AUNNpbuQazxaHCNxVKtfYtFEWi
	e7tVtUKLLKpoFDHkwN+HvIDDMV1sGMgBNeFP0YYVMO6eQgi0qk9AagWqKDhJSbA2PGWJxvXCHoV
	e8YYVw1iEnpwtdj/wHRfxbRTyDAzkHZfOZ3w2kFaIxvQWPCBRXa2bryiUvk4L8xJRMasuKn37eZ
	3uP30Jkso8znX7jYHHGm8bc2TLEpI3QIeVknjXMOXl6ejbd6m0UcQVd7B3LkYWTpVR8K594nd9C
	6X4R/HfV17Iz3u6hb2+fkCiTqObrTlwdcj0IvkU4yk3WRl/MRA==
X-Received: by 2002:a05:600c:840f:b0:495:7888:281c with SMTP id 5b1f17b1804b1-4980c6020b8mr164369335e9.0.1785742056952;
        Mon, 03 Aug 2026 00:27:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm29131012f8f.5.2026.08.03.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:27:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Adjust veristat stack depth parsing
Date: Mon,  3 Aug 2026 09:27:30 +0200
Message-ID: <20260803072733.191502-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803072733.191502-1-memxor@gmail.com>
References: <20260803072733.191502-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=memxor@gmail.com; h=from:subject; bh=SSwH62uP7FFKsLnFKVxc1vWrKwvCtDR9F12D3XwOrHc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavA6fqXN76bBFx5191bl1uaXz2Z1afW6sOe7IOJUcvvB XaI8zN2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJLQxj+18k+sH+8853S36J9 Ic9XW/688uL/dLYzW27d1rVeWXPg2RqG/xGiN7jnzxXhlJ0kqbP7r/gt8UtRuSUeC24firW2nBv 3iwkA
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

