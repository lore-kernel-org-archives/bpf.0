Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795299251;
	b=dkTxDk/4tvw56M/s4771Dig8OKRI85pMpLGNjgNaMJrOrACOaYMgAH0H9WkK6R+6i9fn
	 Ejp9WYp8/ueTn9eL33zRFDbik3t6uYF+xQE5nKceeJrXnrVaoIBY3J4gv0sTahUYzb6tf
	 JuMcVV9Ns1rIAaeUVlWA0goiQA3B775yPIdeBgIqGs6rWF8yCmTi7V22daRCILmNChVRK
	 yZFei+sHmFM6MWGjla9uO7sKm1V0MEx41NvjEeLRU1/2eHH6ro6JZoslV2Dp9xEgIvkAn
	 hShEtPfj8N50niv7/ktllkBbIszz3A+t2bshZPx5jvcS0hVzHUoyRin1+xzbNhPiHfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795299251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LO8mJlKuOK8HS8K1pTB4Eq7jOzeyYZVFW7S/lt99Y2w=;
	b=MexIpnM1diYC6RtZ3UlIV8Xr5BQ2W4tv3TDUDkyzuwb9u6ezmMMhwFhP+kkgzigzY5Vz
	 BlJqvpYxyAnE5DhXPeeDAnGXys5j6jhqjW5d3d8V/2vEy4I9Cggf5osup21r3JWct+8AX
	 mIew6mfhDfrnu9aIDHkd0DRyvXoe5ra5K1LAQgEY9LXkN+sCrBBE4xtht6Jqn4cpKrbL0
	 YB0MsFbBF3bvLhMak59W9p5PIx8K4bsi0BElXFrgm0pgR7qnbL8t/IsAnB6T5hMsBop4e
	 Xgq77tNgJgadyZvVdZNBk2PzzvcSVgvUWJtfhKoiPspP8dobJY6jUAkN4l2AZydie3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBsgdHrO;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D8606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 22:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PBsgdHrO
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so1269881a91.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 14:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795299250; x=1795904050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LO8mJlKuOK8HS8K1pTB4Eq7jOzeyYZVFW7S/lt99Y2w=;
        b=PBsgdHrOrLfwdSFlusaXg2RlDwQmBWY0FFUKqysAwTDvQDsS5U3dkiIgnyEgakUyta
         CzAnGHCMjGVihZVlAN4dX9FrmB5nqAIG5EEjmtUtzwT1XGcOpw11SWDeCEMDRtYAHedk
         xdgEJn0/jMXnnXjK0kAD5xXMtrDAH7ZpXtQ70VRN5+XpV1Wczvkyg4H6mIV0SftQ4Egy
         3A8q2Cav0s0dRQkT1h5rNOPfhMy+nUx2eQRT2FChorv3qgV/WW+kO13PT7Lisa1sL4wf
         Kyij4obu5yqXmU7ab6sgqY7oWip7mXMFzAxswMcDmvGBhpeMXvgUWbWawgQ2QHqVe1Rb
         wBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795299250; x=1795904050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LO8mJlKuOK8HS8K1pTB4Eq7jOzeyYZVFW7S/lt99Y2w=;
        b=kPVWP1yAxXwmOk4WKlbzpYTz1xi3744++7YJ1gubNUzK7ciStk/5GeXE5ejOxg6Jl6
         R5fQrPugXkezSr1yCToGGE7bYhkPU5KZQ1jy1+vr7Z0qm5qtOms7ul/PkPYY2nOKEXT3
         Wt5u9W7XZRryI6/C0CtOMQCdgMqtxz3IyvJUE9WQ+6+58LelUiANsgDuD282UCPYpi+6
         bRYpJg76RshWy8eCmUCHsHczQBmAbQn3EBbPlDh2b4n9yau61U2+yplDh/24IpiPII/H
         AsfWlYyNfWNvH1mBkTu0OBg+Cugf2VRW3J8jkIN3ZQCxmFDp0Jq8kB1WEHfEQ6i/Xxcx
         NK2A==
X-Gm-Message-State: APuU4Z/wziSLEUo6dfouCGVq1GknlhZSl284t22Tpr0LuMH07qLOlrdL
	mdj8LWzIFBwg1d2rxPCaEQKdbqF4RMu+UzwItzYhF/shAN9tYrIGrBYxbEWJOQ==
X-Gm-Gg: AZFdTZcI0n6xbyqcYdElJVZjflwSsL3xYfD4sWpCd7nFo8XvIP56M8OSxG+Npmm25yS
	W/c9uKj0PERPDbPY959PbvWV+4m5SdRhzu81fl3jFd5gnhKyPmknjvo4iy7nLvKB4jQmXoIMU4V
	8YCbCfhggvbS2sGruJrPl/ISMvdwwBFKxVz4EVoGs+dEtSyzF1ADkh2l66NhJ7WfGHTkAVr3Q58
	e2vjVKT+V/RRPGhvmAsDcHsIDQJOE04+pH7dJ4rTqa5YVvmPEt6OiE7UNeryBOlyvyjrcwq2ljH
	G6YdrjNNekXVdU0RizUdrO3QzUM6nWSuJ2O9+YA4v1jjewtTwg7BxSUZxHDFIlkxmqrpCiTWDik
	W/2Rqf7Twkl8R6ozKLvYgWGx8QbAiepkN8m+eKe4RsJL13IbmFhek0OmEryH25KaW4iixBpqSWm
	AlUY2aE0XcjhXspRsN2H+SUQvadgwu6XHLKGTSqVZhrvJiAUE7k1QH/cmiJKTckSYPGeZmu2/vI
	WRKeC/MDxemZ0lfWpRY4O8reA2R9D/wkOEh1DDCNLSrGmd+TIs3FBtDu4QvFnT5bKMnthPYoePZ
	vjWG0ky56bcLjsMl4+e5HSRTHaOqqtyEjmEE2WQlyHYT8RmWIsCCofxiQqRYnw09jTGI+bGyeso
	nxRicFADzrJ8YBSvlqyv1P//zpkn3quMwHEWVPKPYPQ7JcB0EzZUP5W7JPQp6ql0l2ya9i6R0Iw
	==
X-Received: by 2002:a17:90b:4d89:b0:3b4:3c33:3e5d with SMTP id 98e67ed59e1d1-3b43c334caemr2322526a91.67.1795299250008;
        Sat, 21 Nov 2026 14:14:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b704cfesm2313137a91.1.2026.11.21.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 14:14:09 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 4/7] bpf: Do not lose the failing path if only an equation differs
Date: Sat, 21 Nov 2026 22:13:41 +0000
Message-ID: <20261121221344.3958866-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
References: <20261121221344.3958866-1-alexei.starovoitov@gmail.com>
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

This fixes the log of a rejected program. It is not a safety bug: only
the path-sensitive run uses bpf_equations_hash(), and that run accepts
nothing.

After a pass with an error, the run looks for one path to the error and
puts it in the log. It drops a state if a state with the same hash was
at the insn. The hash has the xregs that share a sym, but not their
relation:

  r1 = unknown; r6 = r1;
  if (rnd) r6 += 1;
  if (r6 != r1) bad access;

r6 == r1 and r6 == r1 + 1 have the same bounds and the same hash. The
first state does not get to the bad access. The second one is dropped,
so the run finds no failing path. The program is still rejected, but
the log has only the last basic block.

Hash the relation too: both coefs, and the offset between the xreg and
the first xreg of its sym. Now the log has the path from insn 0 through
'r6 += 1' to the bad access.

Fixes: a46de5d64e18 ("bpf: Reproduce an error on one path, with no joins")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/equation_join.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/equation_join.c b/kernel/bpf/equation_join.c
index fd145c17e5..d7ad7fb52e 100644
--- a/kernel/bpf/equation_join.c
+++ b/kernel/bpf/equation_join.c
@@ -622,12 +622,13 @@ bool bpf_equations_join_forgets(struct bpf_verifier_env *env, const struct bpf_v
 	return false;
 }
 
-/* Which xregs of @xregs in frame @fr have one sym? */
+/* Which xregs of @xregs in frame @fr have one sym, and how does one give the other? */
 u32 bpf_equations_hash(struct bpf_verifier_env *env, const struct bpf_verifier_state *st, u32 fr,
 		       const unsigned long *xregs, u32 bits)
 {
-	const struct bpf_xreg_equation *xreg_eq;
-	u32 i, hash = 0, *first;
+	const struct bpf_xreg_equation *xreg_eq, *first;
+	u32 i, hash = 0, *first_pos;
+	u64 key[5];
 
 	for (i = 0; i < st->equations.sym_cnt; i++)
 		env->eq_env->scratch[i].new_symno = U32_MAX;
@@ -635,10 +636,18 @@ u32 bpf_equations_hash(struct bpf_verifier_env *env, const struct bpf_verifier_s
 		if (xreg_eq->xreg >> 32 != fr || (u32)xreg_eq->xreg >= bits ||
 		    !test_bit((u32)xreg_eq->xreg, xregs))
 			continue;
-		first = &env->eq_env->scratch[xreg_eq->sym].new_symno;
-		if (*first != U32_MAX)
-			hash = jhash_2words(*first, xreg_eq->xreg, hash);
-		*first = min_t(u32, *first, xreg_eq->xreg);
+		first_pos = &env->eq_env->scratch[xreg_eq->sym].new_symno;
+		if (*first_pos == U32_MAX) {
+			*first_pos = xreg_eq - st->equations.xreg_equations;
+			continue;
+		}
+		first = &st->equations.xreg_equations[*first_pos];
+		key[0] = first->xreg;
+		key[1] = xreg_eq->xreg;
+		key[2] = first->coef;
+		key[3] = xreg_eq->coef;
+		key[4] = first->coef * xreg_eq->off - xreg_eq->coef * first->off;
+		hash = jhash(key, sizeof(key), hash);
 	}
 	return hash;
 }
-- 
2.55.0

