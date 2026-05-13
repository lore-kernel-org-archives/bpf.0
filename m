Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640A4C9574
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689810; cv=none; b=JzFQ010VIJ8j+CYV4UZGzSB/re8in6Li3quMUMaACqGNEGHdFW1c6bBejETMXdALQkXBFHhM4sVKKDcng/A9wWx1JrNFDcOJwbw2QcS6QkKO0h8AV+p+qM+PfSD2DOwzfQio7ng96JQ9ZX8kLzNPlzMXBwbeBr0vxMcvMq1uq2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689810; c=relaxed/simple;
	bh=QCUoednEPPjJ24Z5CLcTzNVzUImFgRkiDHscy7ikWU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3bhu1JSvJMRhGM4qsrBlKrQxvwf2KX0kgBby0taH0dnleaIC/EGm9z5a7qGUPt7jsTqMeGjbaeSMyguDyR7KL40Pb1O0BRE0b9f5Y+Ojwo1Wot04yeZHVKlfkjhee3W33peX+Reh6eHAiXtsUYixjI9bnl3xesou2oayvjlvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0tN3863; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0tN3863"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d146705b4so84313575e9.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689807; x=1779294607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L822Kn6T1eRUp12x962YWI3y/VW5euMfJx1qzcfQ35c=;
        b=n0tN3863yIPBXdyCbJQhn3ROp7g0wpv8N/yb+Jkc7Pw/kq/bz4zda1rAaSRgNkpDuF
         S+/qknNuhvbkQBJgog3TgFQ3u5yKNwWpr5O0i37roQl1UEs713a2Om0bLoYjd1oOpLtk
         fPa2BYcqnfgm4SRsNm4QYl0nhqDq410jlx8Vfwpos065H17UEOX5SBPu56P1uSGgGtkE
         0QU6EAGrVBPSQRq0VSK3lLnbUx1jC2nZT0mpO3zk+i4rZMomfqsMKOYZGsvg7vJXtq1R
         NsX1Sxu4LjurcRj/unpgPD6ZOy7lPuxVhxoMuCMSbIfgtqcWZtKP0lgKtBLG5c72IWLo
         VM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689807; x=1779294607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L822Kn6T1eRUp12x962YWI3y/VW5euMfJx1qzcfQ35c=;
        b=SsHaPIq0vUeYhl/MtM+dxu2648aObdm8QBTViKN59fUCOvqPwwv6dRzNE77FEX0Ubt
         4PRgPS73dqLg+xDuMwjP8aKRcX+P55KNl/1v6iSlzpr9BSM9k77vp+BehrHlMxohtnc3
         56Cccvf9b5Ny4gTPRNkReVVNBraLL0hhsHBp1IJ17sLQCV0yufJ9HdJo3wVKil4h9b0T
         wJJUGBwlgk5blLUEu+MttSR6LBpHtrbPbKuJ22REH2BZ/PIZx+/5dV5/FlmmJ4Xz1kE0
         38M3I0HnaPW6Z43NCBYLhFpVahF1L9S8/oz4J309dUBoWJ6mw+GYuMWPIdteGMSt0Ee1
         Gf8A==
X-Gm-Message-State: AOJu0YxzcLPuyaQu9ZK3zAla+U+etfgJQabEZyBc4OwN30R4uuLpGWKt
	zt5pnAHpyaHpYjd0FGbfDiiBz0itPOR1KST/6YEefyibtT+xFFpQM1ZbEgbWpw==
X-Gm-Gg: Acq92OEVSvrBw+feDyMuJ9LXYfaJuv9j8zWbkpQ9YcD5PJMMMcZvk+wz3+3SdSzd+uK
	rr96W1IDPB9I7K5Q+kJpqM5L/GeB9ZAovE7m6pfpePfYAWgC6OnGSZJIdvi9qVdTV7riMW2FEie
	4jgcBdDSzD7QG3sFmgY7WlWp8Xal2hiAx0C+eEkhe+XuQ+oEQFUihALwh0R/leDiVoVZ+pJ0f5J
	8zHE+z9vcPLIm74eUmaD9OLPSenUrjL+3KFAfg4sooCK8NeCV4qo22ysp2g6LhTEAf2k9qlNazM
	sckaas61QTar1PqbywwXV939cs3QNqBWw1fhqgV89u5LIOXd4p8z5U2tB22VHu3jhd7NYe4S6pP
	6KZvhAAcuJ3WSkh9Uv1oivENCrVQVEYOOtUnZQoc5TDcgdTbMkp5iAIYHy9PMikdlGxxBt+ua5s
	+2rEwXq58IMcHBaLaPfIEs795BcBorGLdT0gksCGFnrfQWlLlZ/Wi5U2e2iJc0dpHZWjV3moKar
	yXmfAIBpXSHZiFhW5+lspjQ2x5vllPHthbRSGjW79t5Zdbs4jTKitwwwOj3whfY5WM94rLDkr3n
	YCJMmo2Mf8/ITvOj+JFgI5rOPL9BHeENkG+TIHE2mfA=
X-Received: by 2002:a05:600c:1d04:b0:48e:707f:cdfd with SMTP id 5b1f17b1804b1-48fc9a02239mr61900335e9.2.1778689807401;
        Wed, 13 May 2026 09:30:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e767cb9sm43227f8f.2.2026.05.13.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:30:06 -0700 (PDT)
Date: Wed, 13 May 2026 18:30:05 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v2 3/3] veristat: Report max stack depth
Message-ID: <b3459e61c408daef30d82272f1eacc6399844896.1778689025.git.paul.chaignon@gmail.com>
References: <cover.1778689025.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778689025.git.paul.chaignon@gmail.com>

This patch adds a new "Max stack depth" field to the set of gathered
statistics. This field reports the maximum combined stack depth compared
to the 512 bytes limit. It is null for rejected programs.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 5c82950e6978..9a2275d19ee1 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -48,6 +48,7 @@ enum stat_id {
 	SIZE,
 	JITED_SIZE,
 	STACK,
+	MAX_STACK,
 	PROG_TYPE,
 	ATTACH_TYPE,
 	MEMORY_PEAK,
@@ -795,7 +796,7 @@ static const struct stat_specs default_csv_output_spec = {
 		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
 		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
 		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
-		STACK, MEMORY_PEAK,
+		STACK, MAX_STACK, MEMORY_PEAK,
 	},
 };
 
@@ -834,6 +835,7 @@ static struct stat_def {
 	[SIZE] = { "Program size", {"prog_size"}, },
 	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
 	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
+	[MAX_STACK] = {"Max stack depth", {"max_stack_depth"}, },
 	[PROG_TYPE] = { "Program type", {"prog_type"}, },
 	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
 	[MEMORY_PEAK] = { "Peak memory (MiB)", {"mem_peak", }, },
@@ -1023,7 +1025,7 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
-		if (1 == sscanf(cur, "stack depth %511s", stack))
+		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
@@ -2278,6 +2280,7 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
 	case SIZE:
 	case JITED_SIZE:
 	case STACK:
+	case MAX_STACK:
 	case VERDICT:
 	case DURATION:
 	case TOTAL_INSNS:
@@ -2512,6 +2515,7 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 	case MAX_STATES_PER_INSN:
 	case MARK_READ_MAX_LEN:
 	case STACK:
+	case MAX_STACK:
 	case SIZE:
 	case JITED_SIZE:
 	case MEMORY_PEAK:
@@ -2602,7 +2606,8 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 	case SIZE:
 	case JITED_SIZE:
 	case MEMORY_PEAK:
-	case STACK: {
+	case STACK:
+	case MAX_STACK: {
 		long val;
 		int err, n;
 
-- 
2.43.0

