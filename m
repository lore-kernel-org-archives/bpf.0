Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749490;
	b=rSjgM0DtCzYRQTnLgD4FrKpX6FXZ/vgj8n7VrgVVbMMFTt6wJQD/443uhVQA1V/N6sHf
	 YERadONKA6nFd6VssAhci6KJTlahThpL09CkViMFQV7vwPLpspzJiZ0bTVXGQkjXbpH+P
	 FpOxSAdcHbnv7jy7NZbWvw4AvL/9UBae4nv4dxnd3dLu8P7VpgJDgj7RPtrY/VPR6IQoM
	 LI6GZaC5vNdE+wg8XGHRO/Cs1/nvA5EZRTZd5AvabTfwKnZVlQdeLrHMBiJhwuOSVWZ0O
	 lZP1e0STIgRABTjnLgDTPaYWCDMSJUI7jWp2tYCpZOtCbgkI7YlfQ0qrc9l9CukLgiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
	b=WdKRqdeUb4rfOBRpu5z0+qSe5Tq74qMwNWcR3d17nDnzQJkOgxup7JQUElpZpH+vqW4u
	 wwsIAYFBubBtMJ45IHJj0DtDFAEChz71hYrn9o++/XFGOfX7TMYWtC+1QALSSFjnUyR0N
	 9orTjQYc5kjU/o+aQNK0uKDvj8OaAi2m2egHsGK6vnUFs6vrHOrvIwAwsK/W/OAamd0oT
	 3VRb9bprCTXttXL9CZQ7Hk90RggzQeWKm/cKsmXZrcFNCC2s61tJHYe/ldHSfx3lyb72Z
	 lStkE3bUHUNfNtKwRj1XGMKmz3N3w1gGG3UfQJm40Qg0M95N7UYk9u3AbltzHe1LszQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Dj/DjIjI";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B628606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B628606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dj/DjIjI
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e7e742a2c7so302065ad.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749489; x=1794354289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
        b=Dj/DjIjIMzlfUSrPCDKfNdBgNAIanD6Q4MhhGlBG7WylLJNQR7tXrI8/tThrAS5/le
         XasMMXP5R4ox1wBANP7kL+CWYlzXvEk3bbrzylpaK60OL0yvXP6VfasTT3YFwYsr+LOS
         r9cM0UrgXKQ1Vb98C7nXshZz4dmWx3sjx1WCrUGC3P1CCeQ/KXvTXbmlAGJv8Qu0ah6d
         DjnFM+eJkzS/surk27HWWr5N3BNbwZhfC7Xi9AK3Sj7bf/Z39JI6s6b0lqMTgLBpnAin
         bcowh0mswiR0IKIGP/Ssv5dsAbtioOUyDMvvZ6AdWaK9AG1JsJN7BudCHTes0X5P+6cv
         iWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749489; x=1794354289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
        b=Lx+4F+D+wRliZhEJI/FZCAY0cHm7XP+BONexbYCofLNwMN5SuSnu9AtjqPcEsT7aqF
         e62VWzwXgJpP23s6PAFtE6xn596ksrxkd4LXV0kPp/YlwrHbw76uXRSWQ+1HZ+NgIP11
         C7kJ5avR2YghVmW0GcdpiOjIacHl4qIkERGN1wlz/VO+30NWZjr1u3fKlThJe23dY6q+
         gBRO131w/MMLd3naE2uu4zPE5EV55a+B+fTKE+BC2OJx43qWyGhMa3+4FxZfz5k9YhRC
         pZLJXVTPDLLqL0zrZkRJNfaA068QXvOSR+0L0THYLAXrvNloHwYmIiSxgrKOYdKQl//3
         KXPw==
X-Gm-Message-State: APuU4Z/qP6S7U5SyL0HDrMZerw5vs39EPNPOgJz7GQVHDvbEMQCdXBph
	iXtfQ/kqa3RTcoTTeoZ0IpiVYFXnHHggFeM5zCLjDVlyTuDh6IF6qq4C+y6LpA==
X-Gm-Gg: AYBFou0fhBBlTfLdnzTdIyKUsO3ueIPRqI6NwwbeQv1JvyWenKLbVFZ/l/nAw8gryaO
	2PlW7tCcQQxGzUsAMrHvuTHGr2ZhR/P9BDX9v5LIWRgKDG/IDZvtaCreH2UpQQUG6+oGxeRCySA
	9JKMmSUOp8KZQIiXcI63yDuwYIZgyjzAKef20W6ZU1Dnx9RFd1gscENySTQ7VDJmPKU8COPT/j4
	iIp/mzhRJUFygVob6plUbfQ7/7/Rwq3Zf5lvUUhIvpqEhTuARRmienetXlocHJBPu4DR6Fui8Ae
	cNd01XkBvg6Nq8hg13qAOQPCL+Gn63woNIympvJ3jrSQR1bKsLqmq/CWJOWp9K3lUbBFJM3Ib+c
	P9+TRWVMovTTQZYdDSJGgKLEHPV8b+noJI4PZgkfAOwPPp8MDYQVHvawhmoJkLKynqpSiGQ7MX/
	8UgrqeAU0ZSPDGFjHEzCsduMkuTBJXU2os6TC4aQ659nQ2OHZYD/8g+6lXWNhoe49JGdn3IO6eh
	+B0ljkSbW+UixwTUDX5g7yu5TycsaGPtlNJWjBoqaxNrL8U/UK9KWzAfClbGPjRYelu+9w0F/C5
	/S890dnalnYCfcBPlLz9r4YkrC0RAAUkyH1nla/aw+RotPeSmoYy93Tv+aUK/NvYrBVvS219Nsi
	zxUI8QYnAUEG8ObppFYQ/H6nLSNQnpYJxu8a/hhoxF7Byna+5Kuuc2bl2XesdYkYyj+shbFRqbQ
	==
X-Received: by 2002:a17:903:1ac6:b0:2e9:5313:8f7a with SMTP id d9443c01a7336-2eb1abd06f0mr123543725ad.6.1793749489272;
        Tue, 03 Nov 2026 15:44:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091ce09fsm403995ad.68.2026.11.03.15.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:44:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 37/37] selftests/bpf: Make room in veristat for the stats of 1024 subprogs
Date: Tue,  3 Nov 2026 23:41:02 +0000
Message-ID: <20261103234104.208239-38-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

veristat reads the statistics at the end of the verifier log. They have one
line for each subprog. Two sizes in veristat are too small now that a prog
can have 1024 subprogs.

  size                    old   new    problem with the old size
  ----------------------  ----  -----  ----------------------------------
  log buffer              64K   1M     777 subprogs make 82K of stats.
                                       The load fails with ENOSPC.
  lines that veristat     300   1100   With more than 296 subprogs it
  parses, from the end                 does not find 'verification time'.
                                       The duration is 0.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9cfc9b4b41c1..6b295e7d6f32 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1013,10 +1013,11 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 	free(stats);
 }
 
-static char verif_log_buf[64 * 1024];
+/* the stats have a line for every subprog, with its name */
+static char verif_log_buf[1024 * 1024];
 
-/* Keep room for all 256 subprogram records and trailing statistics. */
-#define MAX_PARSED_LOG_LINES 300
+/* Keep room for all 1024 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 1100
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
-- 
2.55.0

