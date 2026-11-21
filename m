Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288451;
	b=3PdaXD2Z3W7vH0dM5hHSysBgaMmZK5sydDDh1pd4eWJfmdG3pmAglRohGi35K0Ks9qZQ
	 i8g5sYa06Lojp9blnQaWS+okwPnbFIYxfT8/euYMPCYWOczCisffzr5mUujOV+Qy4l53O
	 4XqGOlBpA7SmUwG+zX6aubC5/WMoQkfMit1E/ZBWIT7wtooJ+WWbfXOH6hUVnBZplJMl8
	 4+CyZSfiEygVL14Vf58dSZqZ9QhVQy1CT7PjjqaUuUIUN3MfzXfRSGZTQCkOyMLBQQDVs
	 AAfyA94EdQb2YKO4B2CpCS/Fp9UvwgPinAE/ShtzQAUF1XbGdIjEB70DzkBPqWJ1W+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WFXWEjczlAe4YYB4bVY+SVNJ3c/9H8TshKDQ9oFSMjU=;
	b=FXYsijLugX6llTIe3moXOk0VBARZ6GV/iGYOecLn2GcgCqcp4aszgozmAZFG/3+YBJjh
	 GRde3kSc2dGib5npQur+pmmvb8BPY70coVRqvBoag40NVsuN676iUAVeREIDlGb4KpwDW
	 +Eqb8g7qOqZMso0JJkE6pUASaat/r+828f4mXpp4g5Cp338gRDio1M0qiy4zBtVMQBSGO
	 OObrK9VdPdGDVX2+AuESE7tvK/hwVzE1Bu3BisaPVtadpyJ/O18aejN6KHjV/oeSM+JCh
	 cIj78nu4Cv1mwtL3M4fo3aAhaaOie7/U4Xk8Txrw6ZJJiV/eULDoBSmYh8sNAtSp+Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6ES5lEy;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B6606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 19:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875B6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V6ES5lEy
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b40470fdd8so955521a91.1
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288451; x=1795893251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFXWEjczlAe4YYB4bVY+SVNJ3c/9H8TshKDQ9oFSMjU=;
        b=V6ES5lEyEg0kclYKHJkPRZ7BGshJ1Zk5KiDLSvJSh+aH+zWR4naWdHKLovlCrI/W6g
         jSZk8EOVIr74+pk/kOyEDDefTZM5W0GNg2MgIUENrfj38a85h7UGE9xvrJo/P4O8JlkT
         mbC7NryqQqXLmnpTAPsi6lE5vv8k5psQkSz0V9hkeZTYSva3+QUhEGmDlza2J0l/+Sx5
         FIGqLrSyTdv7EH1suDqjFBcdQa7kbs9TmWsD0J5Tw5F1tkG6a9hp7wv8E9C7hKSv8DfL
         lpf/YnxA8N8Sf/xYyF6RJ1fLAEI0TdsJUYITUBVj1Y50mD7Jfdqn9cx5Yye5xCDLDCyr
         CchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288451; x=1795893251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WFXWEjczlAe4YYB4bVY+SVNJ3c/9H8TshKDQ9oFSMjU=;
        b=hx1OIR/HTFdcAZZC7FTXSs/IDb5emViJ87/22DbW8ic5rIymCrZMN8ZjYif/lZUNxq
         /jrAdb59YHs282e8obbqDW1JiQnxVbYT2dtkPUTYYI/aITHe2ow5NaL50I0uZNZAoCIo
         szJ07XZk8nz4vWxZmo/kHg0DgZrTpquIskCXrPF07qmw7rZrN4nFGfo8aQDcmURr/x3R
         m0+2LzEpcCtoPylU3LMqnzOcA3ruwKMPIfqU5DQN1SbOYshKFptnlwm1KIcMM8eed86F
         YF2EtLtHC+5maYBkCKG7mFb3L8LTZhf8kEj9aRGOjMwH0HtqYTbI3D0yZ4XEyJbV5YP4
         WbOQ==
X-Gm-Message-State: APuU4Z+jgUq0L5iQUOJuSKwLES5S+SrY2hkZC6JON+ni6uHBYtCXeKUk
	G1KuljTtYy7CrPZ5ssZRutNfzz5IhroJfPhh6grt+NeS1+y11/P5LwXVQD2QGg==
X-Gm-Gg: AZFdTZeNduwqj3Yd7203fkRwyJ0EFFrkY99PFRTSn/FjGbO7LunzGT4BMMY8faypdYR
	fYCSYYVmCczCWhirNsh1940seE0zncYENAOFZTMP54xnyxLnE2iw9HRSkVOH91lXA6V8y/smQg+
	ujcW0ljJq3eXw+4kUlehSwld3YzPlJJbh7hUy6DI8xfGnWbWrC3nAKNuQWwH7rYIlufv8EymSrb
	aPV+qnqPVwaX6532pMmXM9uZmIE9zXPwujUMmXqIaYlCGTqeMy69M89jWnhUKYV2PQIWamldQ/W
	4D4DLyX2vCJRpgDoEPdwLNlwH73q7rRACOmoezYZRAdD9jmqnjnAk/E2SaVXFwFs3NtNEWNHbnp
	MMByL+FFjs2mCOzonbe6ZFTrhCOxa0oHeRtlH9CQz0i1iKQTueHeMSCLQjMmCPrMCqxXZb7qPIc
	B7l3lIR7xR833sl+79z01VNkegPowhTVY8VqglEdD2Fe2bGAmih3D+r3uotWEl8o/fTd+qtcTTW
	c02FuwDP3TLZ23U4gQXRCVSmkFT7OMbV/tl9xtFqLYFLhvPBM/t1yzP5ea/pw1z+mwTbF+n3CIK
	rlTNmOMkAWljoJmnroK4tz1gyEm658F9yN3Q1Rl8CDKj+/HXVO4C3eTPecp7r0YW5wioeF25YfU
	VpK+rRqZVJkUA6SDvN8rSokcXfzkA9xP3I55FTMGAyPg4P+64s0G+vayuwM/IH/WjK149nsZU/w
	==
X-Received: by 2002:a17:90b:224e:b0:3b4:22d:e066 with SMTP id 98e67ed59e1d1-3b41c7d6061mr6495656a91.5.1795288450577;
        Sat, 21 Nov 2026 11:14:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad48786sm9636719a91.9.2026.11.21.11.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:14:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 4/7] bpf: Do not lose the failing path if only an equation differs
Date: Sat, 21 Nov 2026 19:13:39 +0000
Message-ID: <20261121191343.3670609-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
References: <20261121191343.3670609-1-alexei.starovoitov@gmail.com>
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
index c7273d8800..49aad57eab 100644
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

