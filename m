Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83E31A56D
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097663; cv=none; b=sUlkGFN9f/4nFtoIOrlgWYck0PYW0zTHC6KLyFKk4o2EaeI9i8qgkFryQy9rQH8yvCRAPpViW/lVq9542uCgO8PvSrn/mwjKrbqt++MSPIPdex9v/02udcCFeQikVGD3RIYR8HUGXjLDvI+KEUMiubYJ9bZoxXu8ianOcQRAj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097663; c=relaxed/simple;
	bh=cEaAEuSAGNj1fxKYcJwFURTmxJ9v0QxCyf2y/blU6wA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW1j6Nygs/Tp3DOD2rATAmfGq5WBnlIrA//SVel7C4yIVZcgUDZYQ3cglzaUZU1ngLWeiY10DEtyKFfkqyeNeGfGZehVQXAn4X8+d4NXCvFX2h6Wz9CTE2yp+M3FOT8KO4xf6F0bvgPPyCSg6F0GDLX0zezH+TknwZeafNO+hjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFOKZkiF; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFOKZkiF"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a376ad8fc0so1720241eaf.0
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097660; x=1784702460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgdxwtswujcD1lbnDGYKOuZgqeLk3KdEHvY3Ljl53As=;
        b=cFOKZkiFXK4nAvvv1qgp7InICa12r40e/9dYkzdPJFzcOvJnbB9u2mfO/2R3AhEhie
         TCX4t0K/l4FQcPKmNpgeDBzjSnolectFRkc8mkgo7do8Bmy2CI3PNJwdFrQtlvOGzwyr
         cXy1vbAfbZt4hGfTF38DY7XSE/+39gvP6bKmCy69ufJPjV5mVlc3gGeV6XX0dvQHWim2
         8TZ9MUIVhBCjVG8LO54XksLE6N4+3+jE2T8K5X8/gLPG+S4JjQvQQ3QqpT6J21m5yWXP
         HfxIWVFFNnmiEoyOl3iIzrbfGYDnXtf3rtpz8XoQVc6yQSM7WtvAcFILHbv/qLuMl023
         arMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097660; x=1784702460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CgdxwtswujcD1lbnDGYKOuZgqeLk3KdEHvY3Ljl53As=;
        b=o1gaS+sfX1pJ+UNefTkbSyIs7vh/f1hDYgfY+sd8zduP7QRD2Tp2/CA8hRqX4F1K/j
         f3JPdIJFzHbRwUYjCrAdECnFRYWcp+HlpVFbr74Tl4J3DJdFD53HXCF9hWpn7jeTLTrI
         hD9PgDz7Yi+AWjluvOc/bM/Jl96MDCUInOE6LA84Y2K4IiHM7tyq/0alLQwff0MUKKOy
         a/2EwTywVzhRnEibUMUsUAlyRbsGhRnw47Qo1DIO3zszyw5wV0e4EiEiMZBN8R8FXIQ0
         leZDTxt1QiXZimSK2PwRLxzL9jL5Rqw38MGJL35m/JEdNy1tRqEO8HEiWvnj4hwaSNaM
         +UNA==
X-Gm-Message-State: AOJu0YyvC0/fjK7wQ3qhUJXgo1bKtafcPkdNpI8/M3xC3+RttP0mAUT4
	lPYzRyCfoboqBpxKIUeBjDun1ABZLEJrREaoOKxPA0+/JonRV7WqNJwN5GiLKA==
X-Gm-Gg: AfdE7cm0k7NafcAdn2ybMIYK5V2umYBQ1kBnchG5YREesgBKcqMPNuQrud+T3xYsEdL
	+eX7tjFcd+t3AUgF/pcAQjjK5iIrni6HBu1lMMUwkEfyqADZMpI/jtkhPhrsDDsyQAUTRhyWKW2
	nLLLTLAlb0QrElP+ggB26qNCuAzyH2xW9Bcc7nPTrsOVVqPmzFgGCgHb9GC2C3JairXyD/NP3hA
	mRqWJcVBbK3FCFSpeYkfRQouTGcnNHnfRN1Azg+/ObXe4tsPO5cRdG5SMYI/k+ekMgEOwc+iXsk
	Uy6DNGeUdn5FjExueKyv847ZUKFZVoMQmCtIMo/3qZJP4OcGmCA2h6oLl5H1uqzO1Mw5LGA19ti
	j4C/LRE8PWNumhHLHtTsVO7jiPk+nbrCEZ8bdYx0vigAFtdSFWthA5fhejnhzTf0cAXmsVSZrJ9
	I=
X-Received: by 2002:a05:6820:1c94:b0:6a1:8125:fee with SMTP id 006d021491bc7-6a3d9e708b6mr1050292eaf.14.1784097660448;
        Tue, 14 Jul 2026 23:41:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4546f12a6casm10944119fac.8.2026.07.14.23.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:41:00 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 6/7] bpf: Drop redundant pkt_access from bpf_call_arg_meta
Date: Tue, 14 Jul 2026 23:40:46 -0700
Message-ID: <20260715064047.1793790-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

meta->pkt_access is only ever a copy of fn->pkt_access, assigned once in
check_helper_call() and read back in may_access_direct_pkt_data(). Have
may_access_direct_pkt_data() take the bpf_func_proto and read
fn->pkt_access directly, and drop the meta field along with its
assignment.

The only non-NULL caller, check_func_arg(), already has fn in scope; the
remaining callers pass NULL and are unaffected.

No functional change intended.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 463b49df4ff9..37127ae1ff28 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -258,7 +258,6 @@ struct bpf_call_arg_meta {
 	struct ref_obj_desc ref_obj;
 	struct arg_raw_mem_desc arg_raw_mem;
 	struct ret_mem_desc ret_mem;
-	bool pkt_access;
 	u8 release_regno;
 	u64 msize_max_value;
 	int func_id;
@@ -4673,7 +4672,7 @@ static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg_state *
 }
 
 static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
-			       const struct bpf_call_arg_meta *meta,
+			       const struct bpf_func_proto *fn,
 			       enum bpf_access_type t)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -4697,8 +4696,8 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 	case BPF_PROG_TYPE_LWT_XMIT:
 	case BPF_PROG_TYPE_SK_SKB:
 	case BPF_PROG_TYPE_SK_MSG:
-		if (meta)
-			return meta->pkt_access;
+		if (fn)
+			return fn->pkt_access;
 
 		env->seen_direct_write = true;
 		return true;
@@ -8332,7 +8331,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	}
 
 	if (type_is_pkt_pointer(type) &&
-	    !may_access_direct_pkt_data(env, meta, BPF_READ)) {
+	    !may_access_direct_pkt_data(env, fn, BPF_READ)) {
 		verbose(env, "helper access to the packet is not allowed\n");
 		return -EACCES;
 	}
@@ -10285,7 +10284,6 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	memset(&meta, 0, sizeof(meta));
-	meta.pkt_access = fn->pkt_access;
 
 	err = check_func_proto(fn, &meta);
 	if (err) {
-- 
2.52.0

