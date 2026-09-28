Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB93C109A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621637; cv=none; b=l5FnUV7OR7GxQQnOILUqHJGho3vNE3K9sR2Ashpo4CCxmqV5DhXPg3IANyuwsXw4Rhy+Sb105QXHBfJ1dkPl3YyIsAJhtk6GIdAPSYEB7wsAXiiavtEtTSeuSEwMTuJxsDpUblp3cjlP4qsCWYMCk21upnavQjS+rFxMq8VCwLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621637; c=relaxed/simple;
	bh=mrent5+NcOTDIlwaSU9SBzRJufi4Pg84l6XH9JMF15I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nqxi3CIkOWvNOEBPc6Rg4uckeqLWAMu+82rCNT05u07i96mGi3547vCHOQwHYKyqX49RVClT/SjXsb5QwofhMK1+5i4m8Ky2JJmZBVhZO83BxAiU9EdPDzSj76HO/vtUSIGrC0mrknlPwfloHOp9EMW0XeACw9NmlbNidGiyBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoT+7Zpq; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoT+7Zpq"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6d8d3336db0so410584eaf.1
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621626; x=1791226426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNMcpJ19G7b34fCj7RuPSbcDwDMkM+cRlElK0U4XRL0=;
        b=HoT+7ZpqMscI/XyXC7sH/87NUZyjEDNnheL6VxxqR5Ug7mh60R4Huhs3Wivf0P9io0
         oTwigxKjAo4f023bVQ8mTr73mVM5eSttXV1L+bsQ73VlRLFBSNr3EdfF3MJ1qUFFBrAZ
         h3wXMuPFub8cypdTu03UfZ26yzdxjuFOz69cB0Fb/LbkfDxnM9ky/1QjviXzfYoHp6+i
         H/Hpryu/0B4q0aGZJ+A/0e5/BvbczXzVaM2Uc5XQqKlGZHipHtSRML0NddOPghGCHdBO
         Ui7JWXqkqisK80GdPj5jA6KX6jmgDPiFWqLeUzmurDZ8tiALWuT3+q4SE2SHLxHGrVmF
         95Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621626; x=1791226426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNMcpJ19G7b34fCj7RuPSbcDwDMkM+cRlElK0U4XRL0=;
        b=r6bQDTqXybWbkf50NUKTkUCNXzYREEZ/ViTFkjDrYKKrvxce0nrGuY6hCgxNll2PiD
         AqIkxBcYVCdY8O4B5kvbx14icMe/7iCKF+s12fAlU0ufpaxu1BA0sOm2EtN02z/t6DGR
         2oz+jZAAb0WilifYZ8BqL9jhxcQjVC4mZ3TVfK2lQv7VvIEBSqNRgamKtMoF8IOM4WRF
         vc2kSztAhdr/GnyT24mgFkMlfZroU8DwZsLnqnwhcZ35/1qs4H6RuV/duygdvoejbHXs
         LdmowNzz/TNikk867tNbC0tyFsYBfQzapVErgnkzFN/bXNL8t5X3Hi+DCMPqjfM5QLG+
         //Og==
X-Gm-Message-State: AFuF++m/IPvl3TyenWi5lM04dFg0QkawJlMCz4mpisTuPryPOfTY4Bjh
	CMTnKj9vHBU9OZN+Hr4DE/sgBZe5eGnw8d2JYhHqo4GdrvhMw3HeZm1uYwvGEg==
X-Gm-Gg: AYBFou1ktly9kO8SI8s524QKxelp7mJme6PlURiizqT74jEuct2YqVqVEl7Pux6TCkk
	kyQu4fAX2c+421kfSNsjSjCCl346iQ5N5FZfIrlvQOrIDOLQbscqYfA42So1iSHwQk3neL2Gwkr
	YTeBt0tEkGatYSqyci8sBa+vw8rIYSYpH3Wo8Vf959FIyoZc988PUVmxpQUQr2f9X8qH/cRTO3n
	M0dPOTOYjtpwa3hXn5F3CiIZ/RpQyVjRIZ4gf3TvxfBXl8E/npA2owiXjhYg3yAcP1A6NkBPQAN
	3tTm8xdQjVVQL+M3MXRIcHDlVF9HMA6uMjjEIbWFcQH+w8Valyt/ot1uzjZ5ZsiqlN1pIGdPsdg
	DWxk56I7/nzeZM7S4gKzeBsltnZnUgaYQSM1v9Bj0W74p5BiAw8OlCgAM/KyTCEMi0IVe3X2twb
	bUqwThxL7j0S+rlhUOJP5SONQm7l1q+Jzzq7kWxfEWMvWz2AkUljd044yJUreP8g==
X-Received: by 2002:a05:6820:88f:b0:6b1:4b76:1c18 with SMTP id 006d021491bc7-6d5b869a153mr8924590eaf.24.1790621626004;
        Mon, 28 Sep 2026 11:53:46 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d88221983fsm6277579eaf.3.2026.09.28.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:45 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/11] bpf: Check subprog arena arguments in the common path
Date: Mon, 28 Sep 2026 11:53:30 -0700
Message-ID: <20260928185334.1004200-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARG_PTR_TO_ARENA accepts both arena pointers and scalars. The existing
BPF-subprogram contract includes a constant-zero scalar; it is an arena
address value rather than a conventional pointer rejected by
nullability checking.

Kfunc prototype generation already records this zero acceptance with
PTR_MAYBE_NULL for both arena suffixes; separate JIT metadata determines
whether the kernel callee receives the arena base or NULL. Apply the same
call-site representation to the temporary BPF-subprogram prototype, then
extend the guarded check_func_arg() path to cover arena arguments.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 659820a4b805..efb20e50c974 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10816,6 +10816,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			 * to protect against invalid memory access.
 			 */
 			arg_type = ARG_IGNORE;
+		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
+			arg_type |= PTR_MAYBE_NULL;
 		}
 		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
@@ -10881,7 +10883,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 		nslots = btf_arg_slots(t);
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
-		    arg_type == ARG_PTR_TO_CTX) {
+		    arg_type == ARG_PTR_TO_CTX ||
+		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
@@ -10909,19 +10912,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
-			/*
-			 * Can pass any value and the kernel won't crash, but
-			 * only PTR_TO_ARENA or SCALAR make sense. Everything
-			 * else is a bug in the bpf program. Point it out to
-			 * the user at the verification time instead of
-			 * run-time debug nightmare.
-			 */
-			if (reg->type != PTR_TO_ARENA && reg->type != SCALAR_VALUE) {
-				bpf_log(log, "%s is not a pointer to arena or scalar.\n",
-					reg_arg_name(env, argno));
-				return -EINVAL;
-			}
 		} else if (arg_type == ARG_PTR_TO_DYNPTR) {
 			ret = check_func_arg_reg_off(env, reg, argno, ARG_PTR_TO_DYNPTR);
 			if (ret)
-- 
2.52.0

