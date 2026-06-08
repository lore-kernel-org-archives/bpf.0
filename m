Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B23DEFFC
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930126; cv=none; b=Y7nRxUrX+hnjxY8lboM3L7EQNRxDGoP8TpE9VYU2RneqOTYJbCin2UreLcQ6mxlIPe+PYn/7znyGZ8HeWjd8XQ+YKX/KeIRD27Jh2jGrJaTs2fAX0u6hXjReSFM5F6FNbxbMHYFXIZnbbEEn0ZyauZoTzHM34mZX5JjlG6vWGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930126; c=relaxed/simple;
	bh=3eRX0Bg0knjPlMkY96paeUYSCsSzeBTRyWTibDIM1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBTwzEiCc7c1HpCElGFfl59uvKmlJ48bgvZscMDvEjmaG4XHdW7k89WBf/FbG3ZAB86rwHlT/sqayl4VjrerdCj2+8ldgO5CgjRY3ehRGzEzK0DAULEEC+FMUd3f4FAVqnOwvyIFOx3X3GtViCeEBTEPooovbfG1pV4tPhCU2zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9EnsTmz; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9EnsTmz"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so48870165e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780930123; x=1781534923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtqKYm3KQT1a1ZPlvfea35PV4eJ27Zv9NK/UFrHfRGQ=;
        b=U9EnsTmzxXRmF6IEFMN+dd8uwX8UljXwK/F3iawmlSB9dvHZIjYn0sPkPRWdf/QWLX
         cjIYOVpgySjxVLFT2wVqtGGvndUq678F/upmOBbmp2NmZHebOu+NHtqpjoKDsftZsK83
         F/WXXzFCV8nPfzxttqsrTzfa6ovvGQWsquYzbxOR2GAu8xwgQj78Uk26yioTUA7HTTX8
         jeMws9PNC+wNY9IABQVwFrhgLImeVPw8BobVA3HPRELMcBD7tKSUqd3Zo4ALh3YsktA0
         Uz3f9o+ef5sdSJv5mE7LB389regHYoHyY7EtoHKlGly846NDh3IamEmVFFjOupm+T68p
         EveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930123; x=1781534923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtqKYm3KQT1a1ZPlvfea35PV4eJ27Zv9NK/UFrHfRGQ=;
        b=bEdrP8qfF0vF59cBsA0MbXAs0FFMrjIR7N1pNPUtNrV3KJgiQznCLQRuDRzT5eOG9n
         IRSYqF+KTUf9sQdiWzNHnEsdf7+5rddCx2h1TqWQg4I6i4MMDcpuVdeAtduL66NoQs44
         pQn2gMLPwzmoGuXrpRoHxJxoY2CJcoq7K/yWQeLrv1MUSuI7eJoY2NyQ3WFTrjE61+BZ
         ZMvTnRgR62BNbJc79AQbvK7pvr6WUt+ukuYzJtVoOtEYNCXCIdTkprzrjezoqnXURING
         1hjFdDXrlXhc2mdBnEPXLSl8ixRoAYM+pnmws6bVMsKl+YJlsOA74l7L52P3N6Nrw1xP
         LI5g==
X-Gm-Message-State: AOJu0YxD7QYdJw7cNtpKwk5qEktJSH+shMYs0A3hbF081DBnSyhbDvLQ
	4tHHWHlA5oCvBEN1qWbfTG7COzCfZmM+Z4/R5SRig9izIhJKqpg9hu187ZYe9XsD
X-Gm-Gg: Acq92OGXdMqeCFCrwLokQt8Jc1n+YrlidsA6+2aDztezZizOouN096jm1TiTnzrn0sG
	maFl4tv9SqSUmez2jQu25+tH2XNRfptzvmZX+Wh21EEHJJC+lerMeg8h9B0Mamr6ASF5n6g9pU3
	bc1flPaFYCGmFc+S4AekY4otNldPxvdrm4Gij4EiLcecaZ/2EQB7F8GmNN1PrXlNOCGrP8Ey5qL
	YdLmVY+NBv7xvEOahBQKfkCbeAJFc4U1cTm8BHsXrQDkWLDltPCN7cr0M0C1nP/Ffd487hlYp7h
	6HXOKEgcnAj+3ZwoiuJRWEtod5nqF5uPQuDe9s53meSRU0ByAa06Rk1eAF9IsEgonI81JfalfIf
	CdN9Ja51wbZFIuHhXPLYdwKd6anruOxFXNMI4zNnegrk5VM2CvRbTuMQ3dZfJ0TnmSQGH3ZvkRq
	zWtTg7Rw6XzXEbDiwVQS/SDSxM9gfoGAs55dVMiuVCTrlBCIJFEdW/glL+iMOacNxHLiFw/bfVQ
	qWfYxZkaUx2E/dsyXOJLGP2UteWWM9rANffH86GrH3EFHqWGv1DdkKnMbANM6QhyGXp9ny0ij4N
X-Received: by 2002:a05:600c:83c5:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-490c258f424mr265792835e9.6.1780930122851;
        Mon, 08 Jun 2026 07:48:42 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b59f0sm465447005e9.2.2026.06.08.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:48:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/5] bpf: Treat non-iterator tracing progs as tracing
Date: Mon,  8 Jun 2026 16:48:34 +0200
Message-ID: <20260608144841.1732406-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608144841.1732406-1-memxor@gmail.com>
References: <20260608144841.1732406-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4406; i=memxor@gmail.com; h=from:subject; bh=3eRX0Bg0knjPlMkY96paeUYSCsSzeBTRyWTibDIM1Q8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUvtmiRzerDXmdCZilUrfR637jfauDs3ZPZCn6zaQsbQ4 FtfX/d0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJC0xj+yu5alMvLuEqDb69c 3NnVWdMcNVdFe//ds77i3+SNZ/8/O8fIMNdkWqSV0EKNq+cmGdbETPk+/8Ev0ehThWZXDidVux5 LYQIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The is_tracing_prog_type() predicate omitted BPF_PROG_TYPE_TRACING even
though fentry, fexit, fmod_ret, raw_tp BTF and similar programs have the
same execution-context concerns as the tracing program types already
covered by the helper.

This matters for map compatibility checks that reject bpf_spin_lock,
bpf_list_head and bpf_rb_root in tracing contexts. BPF_PROG_TYPE_TRACING
programs can run from arbitrary instrumented contexts, including places
where taking these locks or manipulating graph roots is not safe.
BPF_TRACE_ITER is different: iterator programs run from task context, so
we continue to exclude them.

This can reject existing fentry/fexit-style programs that use map values
with these fields. Such programs were accepted only because the
predicate missed this program type; their use depends on semantics the
verifier already rejects for equivalent tracing hooks.

Move is_tracing_prog_type() checks from check_map_prog_compatibility()
to points where the fields are actually used to avoid preemptively
rejecting tracing programs that use maps with such fields but do not
touch these fields.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed7ba0e6a9ce..26bfb4465725 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6967,6 +6967,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state
 	u32 spin_lock_off;
 	int err;
 
+	if (is_tracing_prog_type(env->prog)) {
+		verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
+		return -EINVAL;
+	}
+
 	if (!is_const) {
 		verbose(env,
 			"%s doesn't have constant offset. %s_lock has to be at the constant offset\n",
@@ -12222,6 +12227,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_LIST_HEAD:
+			if (is_tracing_prog_type(env->prog)) {
+				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
+				return -EINVAL;
+			}
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s expected pointer to map value or allocated object\n",
@@ -12238,6 +12247,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_ROOT:
+			if (is_tracing_prog_type(env->prog)) {
+				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
+				return -EINVAL;
+			}
 			if (reg->type != PTR_TO_MAP_VALUE &&
 			    reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
 				verbose(env, "%s expected pointer to map value or allocated object\n",
@@ -17664,9 +17677,11 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	return __add_used_btf(env, btf);
 }
 
-static bool is_tracing_prog_type(enum bpf_prog_type type)
+static bool is_tracing_prog_type(const struct bpf_prog *prog)
 {
-	switch (type) {
+	switch (resolve_prog_type(prog)) {
+	case BPF_PROG_TYPE_TRACING:
+		return prog->expected_attach_type != BPF_TRACE_ITER;
 	case BPF_PROG_TYPE_KPROBE:
 	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_PERF_EVENT:
@@ -17697,24 +17712,16 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
-	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n");
-			return -EINVAL;
-		}
-	}
-
 	if (btf_record_has_field(map->record, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
 			verbose(env, "socket filter progs cannot use bpf_spin_lock yet\n");
 			return -EINVAL;
 		}
-
-		if (is_tracing_prog_type(prog_type)) {
-			verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
-			return -EINVAL;
-		}
+		/*
+		 * Rejecting tracing progs accessing maps with bpf_spin_lock in
+		 * them here would be too conservative; let's defer rejection
+		 * until seeing first use.
+		 */
 	}
 
 	if ((bpf_prog_is_offloaded(prog->aux) || bpf_map_is_offloaded(map)) &&
-- 
2.53.0

