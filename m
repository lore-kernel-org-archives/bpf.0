Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983956;
	b=utwYAsmSLot9Z1l24Qou7Zar/6oze7f8U0qD40L+6HqqHzLRSeinlTSberqE6W6Vw8yv
	 t4TVAuzUWWsdgOUyL8NSDGlCxibbvxOe6XZXgTGJxKNhcmeoRhHzdiGBExq0OrYfklRAl
	 SkPrB+3LtAPsPYWWzTve6SYmHQumI/4T56Iz/L1wMmiofReh25+D2a9aqvDWueFKbifqm
	 ruhvryeCRW2atV3epCRL2HZrNZxTZ3akFQkI9psL2OJxvDe3M74WUzRKlrDU8T5dQXdcl
	 npPVVo5r51dpAYVwPtKs8IPbYdIZXOR58ng0zIHf4qfiK0QXrJLCz2YRVsvBYV5hhxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J2c3bJFh675GOEGEQjKu2jvgrRWteRPZAPo8Kdj2QdA=;
	b=Qx97Uz8xW3yQkx/WsHJUQdg5Sm2zssNNzxLqU7m2RQl2+2tVwh4Ys+gXPKZRrngGeCUs
	 RwxWPV2kNGcRR/4kXyOGTQh6rrnybFZHtfIIVvJhzbEJsylVwB8o7XU8BYIb8Ri4ZpAJU
	 1kKjnzWibyVvLTSaK+o8OGCgCfaTThPnVBK5cb7HUtDn8v5aoJTPzb4n6rZM43ljxR6Ln
	 0tPcd//QLlyDxdxTDtNcNwKDIcGuIBtWYf5u9aiHvP4QBJ6YrqUCIpjlOqOLkk8SfpO2Z
	 V0eDA3glRvq1XSoN2NzBMbh8ZLHDk4h2DK/8zj9oX7PR9Brg8GFTM3EZwZhtMCPBYGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MtUSoADJ;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC1606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CCC1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MtUSoADJ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e987a2ba0cso15848465ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983955; x=1793588755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J2c3bJFh675GOEGEQjKu2jvgrRWteRPZAPo8Kdj2QdA=;
        b=MtUSoADJnZUSQZDcNpeaaBUEOpZjBD+ArTdwUpZlT4W9fsYTl/TFny3UgpxvYZxF27
         vLoaTkDwfxTaYlkG+IotxAVz46aqrvC1vyMIGMgZtB/Bnhf270F5VsyS4O6RrpK4TW0k
         aDCzqP0Taha3CiztffYWMTIiCMi8qRrU4RTe4oWiNmDERHbOF1XTKEcacSrLbmuw+lvq
         N9c1qwlOo+ZGReg+IwN9fGuReRVsX5dY38m0hFp8VCM2UgmKx97yrIPqQ/uwvjCTplFI
         wOimFNwvjRfEDOFKkNfRxqnNFLwVWJ4KrmucC0vozXTYgN2r/Z2s4kXJHO3Rw8Gm8pef
         mKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983955; x=1793588755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J2c3bJFh675GOEGEQjKu2jvgrRWteRPZAPo8Kdj2QdA=;
        b=LlKzNwGKZ87xIdTqB8pNOAb86C1Z5NXFSYMX8ZN4oS+QIku6txw1Xz2RR7PPUVhHfh
         LZ2w1lmCgBGfOZ5BSEhRQJNidTVy9YirR6WEaW48VQ4wZDY6Lpue0OMfFn1WcdnhyENN
         ia9FGTmuKxAoEfXCx2C3umW6hgnDM3IGA2ZK8kyO373n1D0dXCn+B4+gTe6uVAmEmNoR
         19LpzK33+pmiiQyyoW3OopYEr/PxPkPKZ1eMgyS4m26jsqVb6fv7s+ky+cy4mlaEc2EZ
         8xflx93RbMYgscZYIuLgKOiWLrcG/bzi8vBRhQ40f7gV0Gayr4Qtauu4yIxcihEFWNNc
         uwNA==
X-Gm-Message-State: AFq9FYIWyOJyXMaxVEZlfj3kAdDmNZ+4cP16ReFvD8wVkF0eCHK8W8aN
	Uioax6QBnLy+GYjfG+Bnl3IXEU5qmj6OYxdubXGClwGOPV33wDin7pcHm7tt2Q==
X-Gm-Gg: AYBFou0mWePl05QF90JK3b3rD+rHL8+6t5xvED38kgRlpMF9dPR55ExiHHutznEfiXo
	COK/Qaedhr9j7EiO0bUwJhzEG8AdWD89h/M1VsGcUZFHJgF3R2Bs40T7C5MclzD7pi+XBvZwSyj
	YCGb8tGDiMgwyAEJugz8PHHRVwLKmj5ZNFaOVwO5xUxzCRs+ZUeH+3udvPVMUDOZIOr7AzpaCrM
	qZR5tVzlcvXhWsELm9mOrdOsHSI/LWjqF2w+/euS8dEFu81Y0H7b/1Hi7SLep7cz8/OJaPYbhgF
	epb6C8ROAnIOzoS2uif4P5+EN9BTG+34H+hHtFKVCI2GtAfNpC4YP0W0dp5UZQwvajZraXZV6Pj
	E4W5Yp1fsrTBwFv3TUDv9suEJ2ukym8QgZ/rZkF6ndc+EVm3u+++wXGi6IKK4G87hppZK0417d/
	I0pOpb0w0ENJy4B68yshojmTNfs9DyOwh1EKcT3FbWUe0uddiVhreC35fuE+qXNxQrhISe8dXoX
	BEYMv3oavcsAMU9FpvmqHcxdPHwXrhlBN5sFMo4Spdlrb7t7h0Ry6/Hef+RBMB2qRPIgvajlfjL
	im5atlETsCEy7nRvU7sbZHnmgKKtueafxIqKB+jlGaAvkFTcyebsGM2r0O6Gw8vc12q2e5x+hLG
	ziHVjnnNKy5CLQDalz/8S8+ob
X-Received: by 2002:a17:903:8c6:b0:2e9:9c65:1aff with SMTP id d9443c01a7336-2ea9c92422dmr43400415ad.45.1792983955429;
        Sun, 25 Oct 2026 20:05:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a748csm10264295ad.55.2026.10.25.20.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 63/81] bpf: Print 0 as the limit in the statistics line
Date: Mon, 26 Oct 2026 02:59:24 +0000
Message-ID: <20261026025943.404450-64-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The last line of the verifier log shows the number of processed insns and
the limit for it:

  processed %d insns (limit %d) ...

The limit was BPF_COMPLEXITY_LIMIT_INSNS. Since
"bpf: Verify programs as a fixpoint over the control flow graph" the
verifier does not limit the number of processed insns. It limits the number
of states, see BPF_FLOW_MAX_STATES. BPF_COMPLEXITY_LIMIT_INSNS is now the
maximum length of a prog. Thus the line shows a limit that does not exist.

veristat and other tools parse this line. Keep the format and print 0.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d8cd7c63f157..8cd82f506e0d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2636,6 +2636,7 @@ struct bpf_array {
  */
 int bpf_array_get_next_key(struct bpf_map *map, void *key, void *next_key);
 
+/* the longest program. There is no limit on what it takes to verify it. */
 #define BPF_COMPLEXITY_LIMIT_INSNS      1000000 /* yes. 1M insns */
 #define MAX_TAIL_CALL_CNT 33
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 864009dbac47..3bc0dcbeaa60 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22783,9 +22783,10 @@ static void print_verification_stats(struct bpf_verifier_env *env)
 				env->subprog_info[i].stack_depth);
 		}
 	}
-	verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "
+	/* user space parses this line. There is no limit. */
+	verbose(env, "processed %d insns (limit 0) max_states_per_insn %d "
 		"total_states %d peak_states %d mark_read %d\n",
-		env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
+		env->insn_processed,
 		env->max_states_per_insn, env->total_states,
 		env->peak_states, env->longest_mark_read_walk);
 }
-- 
2.55.0

