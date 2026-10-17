Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1849BB6E
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278662; cv=none; b=Q5vA9iv+tquXtKAVNvfBpdXjSpocmkTl6Zbh28ezDWDD2ojz6+nQL7OPjKZiaviVBTRUsnmdi9CncZ0VftNJFVlhVTbX19U/bdP7jH0JHSGzTJiPLx9JwEMP0AJiz4GnJi7dBPc4j8YOPGhn9ELnwJxf9so3oQXH3zGOR4jmtuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278662; c=relaxed/simple;
	bh=QRlDF3G8BWhstaC5jvn3fWOzgVFNecIYkbq9WBKM1pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7O9RIp9/FNFLtaLA2UqDUXYJwDSEaYIskwEBh86+dGTBMjuiro0pYES4hh6R7keaMfujRCwSu5uLBfUFiZC09NDhuQHi6ynfmWNXYNIf1QMWngEUlHH+XRjx6myt3nNg/uCjmWTybpu/aSWtRCRRIU+jrG+/r7i6nvq758tgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBJjSsi1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBJjSsi1"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-881269371acso887806b3a.0
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278659; x=1792883459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+j2EZenLnyUUO4IwlLM4WoKgLGnyNBLTQLp4V3bkv4=;
        b=bBJjSsi1roHL7BiFgb44TsFEJLHpZl3IXwH5ZWZH39nRvL4b3YlY5VgiDvpMbz0Ttk
         Q/NN51XYlhAxOB45bWpfSn+TyO88KvF3WpOaXOFZMa9luKhWJ/spSFMsrvC3RzOaLrm5
         7Z4vWnq1+abOyFfozDIdyKfok0QPBZak94my5pqboX1kvzbhhNTBQA1o3u6REbAXiUSb
         ItFTjZeXEwr34l3V7Y6eZczUN3N9c28VnjwWTVhCfzqPPUuJLoOLukTFZ9n6TY61ZBc9
         ZbQmtRfqiPhup5z58ziSrxvdC9HGWUc6Ne4W0kr8a0asurRCCCQiD/nZQXqki1efG20B
         1tMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278659; x=1792883459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+j2EZenLnyUUO4IwlLM4WoKgLGnyNBLTQLp4V3bkv4=;
        b=tYfVVDaML7Rgt9MyTlIrnen1nEL8k2kHYnnf9EvthBo5ixXdvU6AciWbsH5ajGyVJo
         /BhulibdJ/86jWuLqtQOuP6EB8fDE135E7vuEZw59e5+YguNKYZ5LHVd7UZr4SlZUcM8
         nUCvV+nwc2dGE9+q1zNtCnuDVcNm7Pg442vj0HwZQikZRCiGmcd1jNHNywsio3Sw2j+e
         PaLEfzOO4Vie6tROSfLo0J6dPSOZDsxkjYhjABSQWYHjS8OPZoPmM0CGVKMtLDPBeoH4
         NnImcWzlGO9RWVOOm89cmdxrfPR/u2omMTq4Q2o660IcXRIR/NqijWxTS+52yJWJ7fzI
         97Nw==
X-Gm-Message-State: AFq9FYJvmdbabAmLylrEHauNjwWOBGeIak4X8HuYp3p4XGNneUjyx2ip
	Xu4X+dZw5GltekY7u4oPOtjKk+wCAtZ3vykNk72UyDRscWVC8YGeXt928bNu5A==
X-Gm-Gg: AYBFou0IEDxCWPb2tjpoZE1E5QnSKu+0g1DZj8aXJLd8abWDHySu1uxgvUbjwz2yRjy
	hRp9UOb5cw4EXj62fZyUEVA16UnhKbBy8H0VZG0DOeE2556yljEB8ynCZqB2QboHpZnUBRLNKum
	Rf9RUGR7Hjd4P2x9xAYRGP8LbKBgzJxWjMbSGlyg/H9Uo17WczUqSmQZUIXmIgt+HKn18JdZr+j
	9bHr3WEW0ZfsueadoTm0zaEJa6cefGZCuhS0r/I4LdVFyJ4Qqh+Tn+jihoGqiDptv3FGZLyFdCW
	smFYxk7a5iifSw/V5bFTr62UZfKofmDw/N9XpRpkdTT7xXfFdGcN2VQWi4HkYNlOO/+MfTb0cnC
	Dg4sRgT/4QYO2qtGcsHXYeZYf2kKujKRFOisZOO13k+j3959PAUmNGxqKlDeKuz2yUHNYLzC32j
	7PT3uosJktnRMFmtIL9CuaVgPCKnh2EtS1NMefAnmiyr+Ozj605q98I7IcFNuIikHhIGkoyY4bf
	ysm4qk1/QyZXZSZcW/ZSDAy0Zv87q+vZMCqU9+h50wSuAbT1sxIesk3B4tsInFThkwKfjq1kdHN
	KRjrIg0lBBvTZPPR8suTcJrW4nzBv1nV1ysB0ocYdkgF
X-Received: by 2002:a05:6a00:2355:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8a04b80bd93mr1838057b3a.8.1792278659297;
        Sat, 17 Oct 2026 16:10:59 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89febdc2209sm1998663b3a.33.2026.10.17.16.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 11/16] bpf: Refuse the prologue for an extension that cannot take it
Date: Sat, 17 Oct 2026 23:09:45 +0000
Message-ID: <20261017230950.802052-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A tc, lwt_xmit or sk_skb program that writes to packet data starts with
bpf_unclone_prologue().  It takes the skb from R1, and if the skb is cloned
it calls bpf_skb_pull_data() and restores R1 only.

That suits the main function of a program.  An extension gets the prologue
too, but it starts with the arguments of the function that it replaces.
If the first one is not the context, something else is taken for an skb:

  BUG: KASAN: stack-out-of-bounds in skb_ensure_writable+0x84/0x1a0
  Read of size 8 at addr ffffc90000270ad0 by task uncl/105
   skb_ensure_writable+0x84/0x1a0
   bpf_skb_pull_data+0x32/0xf0
   bpf_prog_853eb1991d35e093_ext_slice+0x4f/0x321
   bpf_prog_9eb18752b5d0959a_t_glob+0x2ac/0x2de
  BUG: unable to handle page fault for address: 0000000082298821

And whatever R2-R5 held is lost, while the verifier goes on trusting
pointers in them.

Refuse an extension that needs a prologue unless it gets the context as
its first argument and scalars beside it.  A scalar is still clobbered if
the skb is cloned, which the verifier can cope with.  Extensions of XDP,
sk_msg and sockopt programs get no prologue and load as before.

Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index fe59e3114d82..a8739fbd0349 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -858,6 +858,25 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * The prologue takes the context from R1, and it can clobber R2-R5. An
+ * extension gets the arguments of the function that it replaces.
+ */
+static bool ext_prog_takes_prologue(const struct bpf_verifier_env *env)
+{
+	const struct bpf_subprog_info *sub = &env->subprog_info[0];
+	int i, cnt = min_t(int, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
+
+	if (!cnt || sub->args[0].arg_type != ARG_PTR_TO_CTX)
+		return false;
+
+	for (i = 1; i < cnt; i++)
+		if (sub->args[i].arg_type != ARG_SCALAR)
+			return false;
+
+	return true;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -915,6 +934,12 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "prologue is too long");
 			return -EFAULT;
 		} else if (cnt) {
+			if (env->prog->type == BPF_PROG_TYPE_EXT &&
+			    !ext_prog_takes_prologue(env)) {
+				verbose(env,
+					"Extension writing packet data must take ctx and scalars only\n");
+				return -EINVAL;
+			}
 			new_prog = __bpf_patch_insn_data(env, 0, insn_buf, cnt,
 							 BPF_PATCH_MOVE_TARGET);
 			if (!new_prog)
-- 
2.55.0

