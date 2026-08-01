Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D083C1D62
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785625447; cv=none; b=uTC2trCpu0uN6J20QZwgqvh0LaJ+6GrRhjyUdpQTcOI7A9x+a9XJpSNPiI1EKNOyXZXkRYauoQ5t2I6hvCAyJi/Lk1tLmk1Z561KOfdzV4lmsHV9KftZPO5G0dO1QMiYRWLcZhKgXe78wNTN8HaeWa/bnx8OyhHZFM8L4g1xzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785625447; c=relaxed/simple;
	bh=N0MRF8MUgrVl5CesuuEO1JJZmjmHuNKqu7I3puK/7B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx8hPwu/Qlw9wCvChdAUfpzBeAeRfcuCVwVNy6CSPfYQzlJpd0nx0JrS0TS+vT9b8F3vwryt1E0tnoNjXe2qu5/AmU1KMEIUAtAzk60wg5wbw3ULaf7g6dz6gREYWdRNpckqDp9IziaNa1INE2Y46U9NYAMfEYCOCTmr2+PHhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1Iwx+U/; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1Iwx+U/"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so3136375e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 16:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785625444; x=1786230244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3KQVwvcvCU7up9W9UldePy51opnFTLOqVZkfRpgpNo=;
        b=U1Iwx+U/33gnFPRCKKkxyuDtJqiEY1NRk12sxa3EdvYCLKZ5cz9EPSpeMlaaMDrDMT
         00M9/mdLbOzyEJOcPB43R5uDoCpEYMg5pkb1Q0GyJenLCciUCDDRLf4VKB26rtn/HeSd
         cBfEc4U3CCsxkN1xouE90wTfjip+kdplxMrZUg9ZVQyQhHaUnFAKMdpCh1MPIbPmW3eP
         a2qNhthUmH5aNMR88MtV7iTV+HcP52SslRkJQPp9MEF7h2yE6DKqr6uZra/KKJ9WPdGy
         vELUVt5qOMjTbPHObTPf/+f3ObpbKortbk3rxML/Yta1EToYbvuyDFDpUhjiVvdHkEIV
         TUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785625444; x=1786230244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3KQVwvcvCU7up9W9UldePy51opnFTLOqVZkfRpgpNo=;
        b=pmyWcdOxNsgGVpoaKvxn9QsLzyjFrk/Hi5Egt/kpl4+AE/ADHU02VFzh/ErXrPPWKL
         iQDTlANZ5Ax7DWmbOMzvjz9qeeLc4BuzLHQmy4JmyM7pUa6aKOjUya+u2rtz4EEjkc7L
         lHZer12bumZ8INf/MZ7Ka1RPkbUl3hPMw4j3JW/fXnHlT+fKEVYy8TxkibgHgYvi1MrD
         FecLDPYzADNz3FK/bxFRc7+o8VJHy1kqUr0JbjLNhZUNqngoyPbCemx3KEbX8zgTfZMR
         ak343jM1opIEQyCUbMN/u7Rg/+kshF06iGXo9ar6fvRJEstoc0NeJb3dnVi41xRQYfqI
         vBag==
X-Gm-Message-State: AOJu0Yy4h+IEM9BIRmB9aLdxbztmum2Wm6Qa7K+NFzJSrRqv2SZaIFtF
	zMXwySOmdgVY7+aUeUB73C2mhYxW5MqVSIFR7yUmPmYmPaoULRh4wgvqGR27GqHI
X-Gm-Gg: AR+sD11lDTzcyI+lPdwF85TXcSMxBGzHqkdlWokEHU2PrZT8kjKhL4IuxET0exBPOCl
	wwyl+v+0xZVdsv3qi741WcXHstmzKiylBQzfXFUIZW+364N/ml9WjtNGHsWEXsHG03qMNB/7OSF
	R3ogOvAF+VDU8LW3jRYt36ZBqdVNKVPtjirHGqQk0ouTaTIWjtXBfALIpWVb3fl/hYmyXTBDI6c
	8VSgi5OCD/oPTBf1V/S0j/YYBL49nKjb1GhlPR7btefTNyY3u0BfXgdOKA9VyjQ/6CFORthdx8j
	iB4G9E8lHtuIccjQXqLRGSRta+B236Qu2rRvAyZw2PtC1rzEry52y8EQJt5ic0OALqKLlG5XLdp
	dnVdLtv/WmlnH8dZj9hrcRFj1HxZ/3YaBXXT654vYVH9uOTyFnJTeK2/UQq60OWP6VmXiiIa8to
	zQ/lQ1+wtxQS+TQHf8nB6AsPx5ZytYJIRPeZR+y1qWVOV1T38Oa043+MOWvaMFCqr7bCwGiNV5G
	qURchJdAs+bJSuuIJYGEYylfiRRwGMvqUUEasLs/OjUtuK3Oyd5Gc39/JXo3AIJbh894KD0XOXv
	hKXJw+zr5DVM4RtFTqTOtxgFZLA=
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4980eb4e952mr85290855e9.6.1785625443788;
        Sat, 01 Aug 2026 16:04:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808690ffbsm108418095e9.10.2026.08.01.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 16:04:03 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Adjust veristat stack depth parsing
Date: Sun,  2 Aug 2026 01:03:57 +0200
Message-ID: <20260801230400.850271-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801230400.850271-1-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=memxor@gmail.com; h=from:subject; bh=N0MRF8MUgrVl5CesuuEO1JJZmjmHuNKqu7I3puK/7B0=; b=kA0DAAoWRy03e2NUL4MByyZiAGpueojI5I0k/sMXJ9BpvOnu2DCNu/MhNXpeMswF4tpv5hnmR Ih1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmpueogACgkQRy03e2NUL4NdbQD9E1ZP WBNFzEhLoKqb/qkjll9HE7E7nch/VBZfdgXM3ScBAMDNL81Xs1OjWTCzUwpSSDImSI4EOcb0652 TDDjsMbsE
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The verifier changed the output format for stack depth verification
statistics. Adjust the parsing code.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index c9c257784ee3..f470e63df440 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -997,9 +997,10 @@ static char verif_log_buf[64 * 1024];
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
-	const char *cur;
-	int pos, lines, sub_stack, cnt = 0;
-	char *state = NULL, *token, stack[512];
+	long stack_total, sub_stack;
+	const char *cur, *p;
+	int pos, lines;
+	char *end;
 
 	buf[buf_sz - 1] = '\0';
 
@@ -1025,13 +1026,19 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
-		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
+		if (strncmp(cur, "stack depth ", sizeof("stack depth ") - 1))
 			continue;
-	}
-	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
-		if (sscanf(token, "%d", &sub_stack) == 0)
-			break;
-		s->stats[STACK] += sub_stack;
+
+		stack_total = 0;
+		for (p = cur + sizeof("stack depth ") - 1; (p = strchr(p, '=')); p = end) {
+			sub_stack = strtol(p + 1, &end, 10);
+			if (*end == '\n') {
+				s->stats[STACK] = stack_total;
+				s->stats[MAX_STACK] = sub_stack;
+				break;
+			}
+			stack_total += sub_stack;
+		}
 	}
 	return 0;
 }
-- 
2.53.0

