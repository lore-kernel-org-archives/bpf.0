Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B443A3D45F7
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511418; cv=none; b=tUL1zN5m4V2VADTb7SrN64XPjQDuEGtnbcrjqcx/sFvIv2PL9XeYULrmhptEn/D+47QVCoI1DGa1xj41yHxHlrKLOnuP8CmD+9xOD9vGrU4MZfL75/1HlQ49xdRynQIZfA7S9xqLV3QA6mpvPhRDI0H2U0SJ3hqppUCXv9Wmkj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511418; c=relaxed/simple;
	bh=M65fsxuD7Lc2fLO3nfwBKUtkmwBloqkj3MabatFgS+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SN6YinptsmamUB5PYs5iJIYiceTY6DWPCzungGl1wMsKrCeTXDssmFMEkS9ynYDLaBoeCBcho2b+CSNGGjMQpUH2sok/omP3lJxoDkxEv2XyTkOaAPrKnQk/MjMF/FlJLQ9/hU6s2BZTFP4ghGwbIyNk26PQqNM8rIxYRyifC1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCmXgOaX; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCmXgOaX"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48431ba6e38so26676f8f.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511411; x=1789116211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ajuXQR6OKL8Ja3tHHR9W1yqPi+TG/WkwkKThBQ8BgCg=;
        b=WCmXgOaXr3fcc6XE+EL3FXlVcA+g+baJqEoxLtI2qAiq9cUIHN3hTICTQ07qw2U4pD
         jla4RlfAmgVH08LS7qbWa8N+PWWN7Zh8Xzy7VMCuCvSs9ydXgJyZy4j3TSHSFdsSOFaf
         zrdCUeFfaikppl2qDhFv+v1LwIRYZekfnvKodLdzphzQAFPFdODNjYyZ2Fs/0oa6npdD
         avA7onUGOWQVpxtGbPEDnSOn0gBWyGfN3B6wcUB3Ymq8aM54Xrlyp8eNLC7FSmbQOXl3
         9WjaxpQ4SV/328jqlJZICHF5oWr1iliSt/C7paNtUgFb4y4r6Yiq+S77Z6K9zKIVXDed
         LkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511411; x=1789116211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ajuXQR6OKL8Ja3tHHR9W1yqPi+TG/WkwkKThBQ8BgCg=;
        b=BYH7ZxBtUmWfiijkxRJwnA9HmLKgKkDvQHCYvr1XuSzJADjfl0UzyIGOacpsA3BuIV
         twZ/rLpv3PFnZOcleVkB0x07r77YAeLCJU1vYbUoCt7kpQr/p9Uzkm8rfoRkTbAiLiaL
         gxjqqKX333FqsILelHV/yq0XBPsOsxe7pPkV2xKpx1g0DuYG/QjJgYYN/CHSR4KH6afp
         VkwGSeWxSEYiH1KCvW/YlTKkBZzLqoo52XdYKht4VE6jna7hDsd4yG8G5fgmRDGt4qTk
         lWAEfQKM1Yq891GkASg/Sh9SEDhSfmUITBL+gQFiVqLmtscIkyo/r5ymKaQ53UYRDCNn
         d/FQ==
X-Gm-Message-State: AFuF++mZgIBY9U4H8BOdYwrqrzBpnhX3kQVFfIq6FIIwGGy9KQN78S2V
	lekYFLgEYu3UM5iW1m0ET6OpLgsMkbqnVh3dKI7KZayf2SZ3Jd1o5WPRp8RJh17i
X-Gm-Gg: AYBFou3L3GQsQgrLCkXUjGMRVJA/7Utyb22QuQ2JojX6buUXJ2nB8TIliP7PAdYJtEr
	sytKjCz0Cip478mw8/ZbIt4Yuetr4KMe6Tqc4ovai9i+yXamwRISQNetDZOnygkyLdpEi4CkEi5
	C3jz8O8KeCZ2ZBNljv2uAQQXHZlwrhbaLsC28OAtPACOseRdtz17XfXWn3yVC+Oqw5D7Aa16Qz7
	g29svFSGPYlV9PmEeFu0hHm0CcIsQ1Di9b7IdNqmtvnSDHCoAHrOo1Kh8w3HPPVu/qe+2IPgXco
	syDYflwjgEm02SNFJnV8TZB7N4P4SJR+pNRK31zRn617mxEvSFZBFlEjLv6b/Bcohp5PT5OhFxt
	Xfm8hRiG+AC4FZdahikOO/+WG/P3Rz/KiCSPBlt3WqlG4WhBFIykkEfNngfzmy8WsCFUlM65RSq
	OXFusGBlBKkUSGaJlF6q3zfFVxC8qneX3V8AFUkgZdCgQjd3H4B08nYEYTRhQt/YvA3AMG4Ffco
	EgWsly7smWAfSgn924Znj5TudzZRqSi9oHlH4jaNOnedqIylMUTuZ9H2OdveQ4EmJHedBSghBCl
	UF+9ON51kL4n8s4pHwVybQKRdU0=
X-Received: by 2002:a05:600c:1388:b0:49c:eded:44e with SMTP id 5b1f17b1804b1-49cf82e5589mr29089635e9.7.1788511411293;
        Fri, 04 Sep 2026 01:43:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee3b0af8sm139982395e9.0.2026.09.04.01.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:30 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 3/8] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Fri,  4 Sep 2026 10:43:16 +0200
Message-ID: <20260904084325.52250-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904084325.52250-1-memxor@gmail.com>
References: <20260904084325.52250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=memxor@gmail.com; h=from:subject; bh=7RhG7L0a4oe2YJfh5bn+keIfNEAvNHw8cgMWxI6KGVA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWy8RU5ovnJBasDXnM9MsvWqHd9di3FFU98WKDVz8YF kZM5YzoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwER+6TD8FcjJabi8+Pz/hpf1 E+2utEyIzL7x5mTYpWMzu4wVhOMOL2T4H/6AceH0NQLbjJNt1J5kVb6tn2m37JWKYf5M1caulUo dHAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Ning Ding <dingning04@gmail.com>

bpf_refcount_acquire() is fallible for a borrowed reference because the
object may have reached a zero refcount. The verifier therefore keeps
KF_RET_NULL on the return value unless the argument is an owning reference.

An RCU-protected load of a local kptr is marked MEM_ALLOC, but it only
receives NON_OWN_REF when the pointee contains a graph node. A refcounted
object without a graph node consequently looks like an owning reference
even though the loaded register has no acquired reference state. If the
program drops the last real reference while remaining in the RCU critical
section, refcount_inc_not_zero() returns NULL while the verifier treats the
result as non-NULL.

Only classify the argument as owning when it is backed by a verifier-tracked
reference. This retains the non-NULL return for pointers from bpf_obj_new(),
bpf_kptr_xchg(), or an earlier successful acquisition, while requiring a
NULL check for borrowed RCU kptrs.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Ning Ding <dingning04@gmail.com>
[ kkd: Rewrote commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 68353aa61fa1..bc0abf96cc89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13178,7 +13178,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 						      bpf_diag_reg_type_plain(env, reg->type));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
-- 
2.53.0

