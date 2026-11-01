Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560005;
	b=BReL7VKmPVBme9x2w9xCmGy3mmXYn4RIagxDk2Rr2GeXq2U+UfPG1PsS3d7VpALirmxy
	 cNtL0xdmqjESBZIV3uTFiiYRXiVjAAHLTEeqMdwX5XPel7b0R/kZOs8QLnk49sGWXdHLd
	 kEwcw7rhlhoueZExqj2r4cynxzWWNZg9x0YPDEsNHM9zAESgdtgJBiHM2TFmvuNNaqr/G
	 nX4wu6qZ4FqIdiW0tfl+EIQSYfrdFCs3NHla2WH7gpU7PTMQjkKhjoTGNbq7uu3nP0/zi
	 owV5CV2E0b4ixJTjcS1Gs7G8o3V2yec3zlSooi5UwCvf9eIDqbrp0PEYrC7U2eqjFcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GGVF8NPVYvpdU6BCTsMYlQNnPnKditwSLi3K4JDjxlg=;
	b=jG494sJ6k0OTiKhB1NS5uZ4wSXXwVwx4FqNDkk81rLig2KFKgOMtB0xEcEdl8RPCoen8
	 JZWU0YKaG4O2zloxffM5ugJxtq0TFs8bR2I6UJ9sY4jM7o9mIMqvXcxf03zne9Pume2nQ
	 siwToeoVkLmIjTgRwDBaXNDuQwLqFhB8yA8+62OP300KbRcsMCX4gczAXtWuEKgvh8+Y2
	 iZQpWq877Y1Rnmah8A/Zkohy3kiD1NCzVQudFP7RHOr+xmA8sfrdgI9vaZdH1xxebNBp6
	 JhGRoN7zMF8H4ETnmmuy77sJDVFGd9PTMtC27iyexNQOtibMFNsq731J8RhpwQoDclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amDvMArE;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3521606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3521606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=amDvMArE
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e9e53d011eso18316035ad.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560004; x=1794164804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GGVF8NPVYvpdU6BCTsMYlQNnPnKditwSLi3K4JDjxlg=;
        b=amDvMArEFjFrtGw0ZIxA/Rlkueks8VgZRdEKIBl8I+8OMvXvlJBZDqBnnJq6sH1Ngn
         X2a7kLxj1hPx/kyN6Td2A91xtr+HvzvMvLcTdu/h+YZPnpsxbtdlhQ1pV4r6qrJ+DP0T
         seaP/bg+TKIrVqLwEtlRr0JrCPgmzobJFWOdIJdI0epqKwb+FZDzAX9EBW28e9zMgnRo
         hXnGG5g9jcA4jCWxnKolpncwgIJDXmzBgCX1b54sB/m/BCo/8Ydu4tlFWSF2RFcmFynT
         bULDz/f/Vqv5Ak+9ND9kp5PRuL4Lzp/iYCkCWABi5yB1o/us1oOjGEBRrsxNdbdkiZ6x
         K62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560004; x=1794164804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GGVF8NPVYvpdU6BCTsMYlQNnPnKditwSLi3K4JDjxlg=;
        b=wLxO98UF+PxLF2Nwy+2lhN9ids8GpWElPj6aR5zPX9gSwz+SyfcElFzLn469Hqzbse
         XWsq9uoWjN/ammP7Pb48/EMuSHsrfkTTbG60l1xG2PlrDzpOnwy0lGhg42ov97HXsUGE
         jwMz+O1L88yw12DVJu3JKAKb4S+NrOKBiaQ5KAgeU252qrMlbV2pZB23BjjvawQG5IUd
         hEZKh3OsfJPm1yW2MzUdxa3MswaRqC8Ord+uPvo/jK9heKG74B5KWkNaNblwJQ0e9k7B
         A1pUf37BzEws3XBelOAJs0BzKahs6Y34A4tjPlDa2je0fl0/sT8HaV9A8k4ReBjqhkix
         gryQ==
X-Gm-Message-State: APuU4Z8jh108VhWTFPNPgpIzyUrPZBWAjbVqtI78ZJLEpSAF1/VuYdnR
	N7cYJVrI2K8knVFidw0P/1R4FmZe+svRCKaGbC6vkvUNOta2NVlvXQZbIif3zQ==
X-Gm-Gg: AYBFou3zTMOM7ubpTCDz+2Nxw+WpxeH+GQ1KomxAy8mUcTAy7tVaGPlvy4FagqBU1w6
	+9058FNAtGL+a2/ngD3prh0GDSXNDtzyodU+fP/fspfhNubIxKj7RWzd3RLEMij46WZYqtCklP3
	hWTOetJY8MkI6aQLBTuHO0xFnXNo/AyEwIiEy+i+K134I3Tn3q417PQCg7MNtu+mBvx/t5V89zy
	mvdVdIpnquSgJyUW7WyH5WvexA4gZWHbsQoaZfPinr0hUyk5NpEGxpq6V+xn9qsyivlYEXCJTcq
	SqimUz9iTSX8+mWiJZutLVvRVjNjHb5wrUMUIK1I9g6UIFnPn8gLwwvXiHQU3s3u64MqQ7TsGzZ
	AwNFOKrjOJGUDdo4ZXETesRVpKBED26beJGoVTW0w5nXqNI5w7usH6P/Ke3w3HzTd9cJ5pimb9m
	UJtBiEs69nyw5aDjM4Kuv7BTmgJ74u7inq0b6YRgQNhUq/Wba0zoNNTDRRel6rfLw3z7N1mFAiZ
	JnXEHa1qDw1SuTHnuJWwWW+ff14A6n7JSlXuxmOosr6CVyk/xGT4+8hEpgDDXU1EELdmsofrnom
	rQ1gTrrwVFSTIeZckEgsC9+s2btTcED9c/yrIx/p2rJHmTjeOt0f8G686cOlP18Ge8sufSCIAXF
	eSRT/Mh6Gh5ASf7iroILEMllKHpSUlPXorMxVu4JQLtlnAzVdnf7rLs8tod28vgOH1wTqEGhXsj
	s=
X-Received: by 2002:a17:903:3804:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2eb36405304mr83269135ad.5.1793560004026;
        Sun, 01 Nov 2026 11:06:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052effsm19108775ad.3.2026.11.01.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:06:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 11/27] bpf: Compare the arguments of an extension with those of its target
Date: Sun,  1 Nov 2026 19:05:19 +0000
Message-ID: <20261101190535.1454146-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

An extension replaces its target, a global function of another prog. From
BTF, btf_prepare_func_args() derives the kind of each argument, such as the
context, memory of a given size or a kernel object. The verifier checks the
callers with the BTF of the target and the extension with its own BTF.

Only btf_check_func_type_match() compares the two prototypes. For a pointer
to a struct, it compares only the struct names and assumes that the pointer
is the context. That was true until the commit below added pointers to
memory. Later the __arg_* tags added more kinds. Thus an extension can rely
on more than the callers guarantee (size, not NULL, kind). Then what the
verifier proved for it is false at run time.

Keep the result of btf_prepare_func_args() in bpf_func_info_aux and compare
the two results at load and on attach to another target. Return -EINVAL
unless the kind and the BTF id are the same and the memory is not larger.
The extension can also accept NULL where the callers never pass it. An
extension with the prototype and the tags of its target loads as before. An
argument that is the context only because of __arg_ctx needs the tag in the
extension too. The tag __arg_untrusted or __arg_arena on the extension only
is safe, but it is rejected because the kind differs.

Fixes: e5069b9c23b3 ("bpf: Support pointers in global func args")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          | 10 +++++++++
 include/linux/bpf_verifier.h |  8 -------
 kernel/bpf/btf.c             | 10 ++++++---
 kernel/bpf/verifier.c        | 43 +++++++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1a8c3e514284..0b44bcb4f56e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1752,12 +1752,22 @@ enum bpf_func_context {
 	BPF_FUNC_CTX_CNT,
 };
 
+struct bpf_subprog_arg_info {
+	enum bpf_arg_type arg_type;
+	union {
+		u32 mem_size;
+		u32 btf_id;
+	};
+};
+
 struct bpf_func_info_aux {
 	u16 linkage;
 	bool unreliable;
 	bool called[BPF_FUNC_CTX_CNT];
 	bool verified[BPF_FUNC_CTX_CNT];
 	bool called_with_pkt_ptrs;
+	/* what the callers of a global function are checked against */
+	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
 };
 
 enum bpf_jit_poke_reason {
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7baeb831281f..3cb91c4787c9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -923,14 +923,6 @@ struct bpf_func_ptr {
 /* the subprog that a bpf_func_ptr pointed to was removed as dead code */
 #define BPF_FUNC_PTR_DELETED ((u32)-1)
 
-struct bpf_subprog_arg_info {
-	enum bpf_arg_type arg_type;
-	union {
-		u32 mem_size;
-		u32 btf_id;
-	};
-};
-
 enum priv_stack_mode {
 	PRIV_STACK_UNKNOWN,
 	NO_PRIV_STACK,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fe24e459c1b1..8bf39098ba97 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8492,9 +8492,8 @@ static int btf_check_func_type_match(struct bpf_verifier_log *log,
 		}
 		/* This is an optional check to make program writing easier.
 		 * Compare names of structs and report an error to the user.
-		 * btf_prepare_func_args() already checked that t2 struct
-		 * is a context type. btf_prepare_func_args() will check
-		 * later that t1 struct is a context type as well.
+		 * check_ext_args() compares what btf_prepare_func_args()
+		 * derives for the two arguments.
 		 */
 		s1 = btf_name_by_offset(btf1, t1->name_off);
 		s2 = btf_name_by_offset(btf2, t2->name_off);
@@ -9028,6 +9027,11 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return err;
 	sub->arg_slot_cnt = slots_used;
 
+	/* check_ext_args() needs them after env is freed */
+	if (is_global)
+		memcpy(subprog_aux(env, subprog)->args, sub->args,
+		       sizeof(subprog_aux(env, subprog)->args));
+
 	sub->args_cached = true;
 
 	return 0;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a456adaa459b..1f19fbd627d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22514,6 +22514,37 @@ static bool func_has_rcu_read_lock(const struct bpf_prog *prog, int subprog)
 	       !sub_aux->called[BPF_FUNC_CTX_NO_RCU_LOCK];
 }
 
+/*
+ * The callers of a global function are checked against the arguments that its
+ * BTF describes, and an extension is verified with those of its own BTF. It
+ * must not expect more than the callers of the function provide.
+ *
+ * While an extension is loaded, bpf_check_attach_target() runs before its
+ * arguments are known. check_attach_btf_id() does the check when they are.
+ */
+static int check_ext_args(struct bpf_verifier_log *log, const struct bpf_prog *prog,
+			  const struct bpf_prog *tgt_prog, int subprog)
+{
+	const struct bpf_subprog_arg_info *tgt = tgt_prog->aux->func_info_aux[subprog].args;
+	const struct bpf_subprog_arg_info *ext = prog->aux->func_info_aux[0].args;
+	int i;
+
+	for (i = 0; i < MAX_BPF_FUNC_REG_ARGS && ext[i].arg_type != ARG_UNUSED; i++) {
+		/* An extension may accept NULL where the callers never pass it. */
+		if ((ext[i].arg_type == tgt[i].arg_type ||
+		     ext[i].arg_type == (tgt[i].arg_type | PTR_MAYBE_NULL)) &&
+		    (base_type(ext[i].arg_type) == ARG_PTR_TO_MEM ?
+		     ext[i].mem_size <= tgt[i].mem_size : ext[i].btf_id == tgt[i].btf_id))
+			continue;
+
+		bpf_log(log, "Extension program's argument in R%d is incompatible with original\n",
+			i + 1);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -22801,7 +22832,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			return -EINVAL;
 		}
 		if (prog_extension &&
-		    btf_check_type_match(log, prog, btf, t))
+		    (btf_check_type_match(log, prog, btf, t) ||
+		     check_ext_args(log, prog, tgt_prog, subprog)))
 			return -EINVAL;
 		t = btf_attach_func_proto(log, btf, btf_id);
 		if (!t || !btf_type_is_func_proto(t))
@@ -23021,6 +23053,15 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 		 */
 		env->ops = bpf_verifier_ops[tgt_prog->type];
 		prog->expected_attach_type = tgt_prog->expected_attach_type;
+
+		/* only now it is known what the arguments of prog stand for */
+		ret = btf_prepare_func_args(env, 0);
+		if (ret)
+			return ret;
+		ret = check_ext_args(&env->log, prog, tgt_prog,
+				     find_tgt_subprog(tgt_prog, btf_id));
+		if (ret)
+			return ret;
 	}
 
 	/* store info about the attachment target that will be used later */
-- 
2.55.0

