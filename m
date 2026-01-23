Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A2A313E1A
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153763; cv=none; b=NkK3KlMYEmNpErF1xuqrr7sHLq+mfITew9EhcIoidQTi8CsiNr/WPhjsxS0xN7uZPq1euZwBf0P0lEJPA+Sl1PKugnKYkQn8tnAYQv64ccRxeJSs0aX50jMKsdpRCO4/odf+jTjQM0+Q5m9jODYvan6lemWucZJkMmvSymL+L3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153763; c=relaxed/simple;
	bh=Cjpi43NnpU15TBezTUhlnb5sQ72udzYmaXV8ZdEL9BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GElZgxhE+fHSIqlwIiR3wczggjTW0vBuH5SG496WFLlrnwpl83/PYeCo7sQPBHCCPsl8HtAisJ+Bm8XQVSiG6dwwEsGvTHy1KGxM9oOxUcPSrF5TlsE7hvIWxATKnZI7MNHmK7mKXXDlxlKkE3ZF10RDXEq5roH16qZDs+rlWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOm++M0r; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOm++M0r"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34c2f335681so995103a91.1
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153761; x=1769758561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLdDM59DXRWdxzrRIwUsnUpMT5a0XQ8O1OsOpKALewc=;
        b=fOm++M0rBYRj6TyieZeUiFyPsdmWAEWHWYYPihEFAbgyuhE+PXaNV4+KjHhXnFiIrY
         58GIZXbO56K+m09PFIbZjwiWPVdJDmTC8LM66DnH5e/3DgIIB6dvNuspEOqn5lB8SQfy
         mlH+jdm83OT7M3k46vj18/kKg+I0VVpOelZOIopaMuFG/VqB8kzgqXHD0cp9HJ1eKE3N
         0HghXW294wbzhMXFDYFFhgVNtYSF4QSW5oefz+xfC3JwZXVu5VRAOvTVDJceP867CEVW
         AwoJgvaINy3SBBEZcScfAIjbxE6cjoFlGnRqQVzGo3pjd3KBF5pnjS4wIcaOLUH7X0CH
         Kedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153761; x=1769758561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLdDM59DXRWdxzrRIwUsnUpMT5a0XQ8O1OsOpKALewc=;
        b=T+WTe7xcVTEKnhmewCiMwkVF9t36KoNJipXwgt3Y0GipgKzIAwIuPKsYbh+/EshQQq
         ODw8DbLH/KhWi2e1f3PsPwjiqdnWdqqlMscpGoCBfnA5ARtGR4CIzzJfKfyQlo8jEmXW
         1Z/sn2Z+l4ygcMFLCp4stWjbBezCva9pWfaEWJGYUyzJSrUGByqpRnA7vO7KtJtkjKG5
         XKoLlKNH7taonX3Fammswg7K4EUtSQPd1xozoJfnbTO4Kg/tC2kcTIpFwpoSKDQDWOxu
         N/OSn4yWUUI/ZcY7LGYChhn75DLxRiMOJeHWKtKf69NAY+pRAzzoqVDAjgQR8McInkR6
         90Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Yo/0tn+M9ipMvRosVuMBdeYPagN07eBdBfTrZrsd6HzTjLdaMJLMSJKotCfFdIjMYIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/eN/0WGzo+Dt1jVFixja42eQQqMsLbWD2urFNAJk6CxlgpH+q
	M0iYgXz0Osa3h3NHRECIFpqDfxUa/q9ZojivL5ciuzTRrvEYRFIaUsq+
X-Gm-Gg: AZuq6aIWxVzNgFhycGk9LCrn6QYhcNvPvR+TAvR6OvbJqZYQOaSK5OqUcvkX05ZeVNF
	3a+XFMTtC7G04swWN+EbhK0BCq68Ubp5H6bjsYmaSMuqKkwFr9I5AXavEmWynlufPkU5SSEmjY2
	S7OLL6pTxn08t5aZLkDEr664YSoBzWDQ9hL1dwQFs9sKj3+exE5EWZgje2/8ymES43dMN24K4pf
	vgkICbGC4xffw7jF5rQRiARRsskdCQOPsCKVlJqRkbFfYtZYg8ueNZcXOYr12NntJlueQV1BzOW
	oTwuBzdvu+MllYHCBamLIf8NWD64YUDVL1XxoObdt2Wz18T96R84bCaThr13/JNfbnf7F0/wCxw
	q/Xal9oozwj5Heb8xCA5MgrPr9Cg2tQNri4mG2C0UuVVpzd+e0MbfsnVXpEC8ipHKTDZX2pXKTz
	Tkq8qUhX1v
X-Received: by 2002:a17:90b:3911:b0:341:2141:df76 with SMTP id 98e67ed59e1d1-35367028e9dmr1880255a91.13.1769153761295;
        Thu, 22 Jan 2026 23:36:01 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:00 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 02/12] bpf: use the least significant byte for the nr_args in trampoline
Date: Fri, 23 Jan 2026 15:35:22 +0800
Message-ID: <20260123073532.238985-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, ((u64 *)ctx)[-1] is used to store the nr_args in the trampoline.
However, 1 byte is enough to store such information. Therefore, we use
only the least significant byte of ((u64 *)ctx)[-1] to store the nr_args,
and reserve the rest for other usages.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v11:
- fix the rebase conflict

v10:
- some adjustment to the subject and commit log to make the description
  more precise.

v8:
- fix the missed get_func_arg_cnt
---
 kernel/bpf/verifier.c    | 38 ++++++++++++++++++++++----------------
 kernel/trace/bpf_trace.c |  6 +++---
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 41bbed6418b5..b3f912ad18ba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23747,19 +23747,21 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
 			} else {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
 			}
-			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
-			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
-			insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
-			insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-			insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
-			insn_buf[7] = BPF_JMP_A(1);
-			insn_buf[8] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
-			cnt = 9;
+			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
+			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
+			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
+			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[cnt++] = BPF_JMP_A(1);
+			insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -EINVAL);
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -23779,12 +23781,13 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
-				insn_buf[1] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
-				insn_buf[2] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
-				insn_buf[3] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
-				insn_buf[4] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
-				insn_buf[5] = BPF_MOV64_IMM(BPF_REG_0, 0);
-				cnt = 6;
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+				insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+				insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);
+				insn_buf[5] = BPF_STX_MEM(BPF_DW, BPF_REG_2, BPF_REG_3, 0);
+				insn_buf[6] = BPF_MOV64_IMM(BPF_REG_0, 0);
+				cnt = 7;
 			} else {
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, -EOPNOTSUPP);
 				cnt = 1;
@@ -23808,12 +23811,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 
 				/* skip 'void *__data' in btf_trace_##name() and save to reg0 */
 				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args - 1);
+				cnt = 1;
 			} else {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+				insn_buf[1] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xFF);
+				cnt = 2;
 			}
 
-			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0e9635bcd783..d466a1503da3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1194,7 +1194,7 @@ const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 BPF_CALL_3(get_func_arg, void *, ctx, u32, n, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	if ((u64) n >= nr_args)
 		return -EINVAL;
@@ -1214,7 +1214,7 @@ static const struct bpf_func_proto bpf_get_func_arg_proto = {
 BPF_CALL_2(get_func_ret, void *, ctx, u64 *, value)
 {
 	/* This helper call is inlined by verifier. */
-	u64 nr_args = ((u64 *)ctx)[-1];
+	u64 nr_args = ((u64 *)ctx)[-1] & 0xFF;
 
 	*value = ((u64 *)ctx)[nr_args];
 	return 0;
@@ -1231,7 +1231,7 @@ static const struct bpf_func_proto bpf_get_func_ret_proto = {
 BPF_CALL_1(get_func_arg_cnt, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-1];
+	return ((u64 *)ctx)[-1] & 0xFF;
 }
 
 static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
-- 
2.52.0

