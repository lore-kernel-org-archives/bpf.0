Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694914E50AA
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593690; cv=none; b=oYY+dJ2aIQgfLq0Oi7p0Q2RbY4haLRR6xgTgk2Pql8xBRqfySFm+S2SZU0NRt+yaaf5gVUHribDER4aVPh8kOggGOX16dZBq2XOc58GsiWgFirkW9ifom0Ef9+uUGFzJZtVTpWZhzhTto2uJHYgEZpE4iR4wHEl99NxbN8r+568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593690; c=relaxed/simple;
	bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBV31ZUhXyHxJTFm0jR6J9rNWwx70XKVIwzC4Ph0g89og9IxtoaxtqEQxHuf7NxwtyoT+XQPRAqXUHWIMPGU8JqogH3BGi13VaZ31fJPyoxOMHYuK3mbBzl+uU+Tr8Al/TsWm8HnizRRKJa3oZDFWtMFQeLoyFOZcnC+6U5uJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+KcE2rs; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+KcE2rs"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-49e73611928so539765e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593668; x=1790198468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=O+KcE2rsqyVIr1mXuvpGkX5Bk9eqiaXOvMAqayOhTaVaApimXRpD+Q9/mVej55+8Fg
         GlXltPjvvoWwj78NCwT6yazeQuutn4u65lhUTBKSB8sB6m78kJzQZHoFVLOhohnIbk2F
         RVpuEl/rPtzMLWnemMNtLMwmnppR73NqxxJtbUwaFZEhASXBmxjVbeJ95rf/RTa1gNth
         32zEEc8fqT8NFIcHg9epiv8XNcj2wyE4dbtbxW2gdOjrLzKvuQDrXujPp22rPia6RHhD
         u39InzyzFIRWwRLgCZv3D71Ig9jWGxMUOcPEf7faEkjYmmO9W6f4x4GQNwOTW82kt3ZK
         pXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593668; x=1790198468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HC2tCCvpccn+pRkVO68CBG2Pf/51+9f68zCb1h69W6w=;
        b=F93X+oaFJbn5crqolN/aN89ixqSVOUjsDIObNv62EdvPg5NRInE5mNvxFeo937HLGm
         mdD01LY8ZF0AHL5jgAbeoA5mHHEjAaQvnKdbssVNF8eOjyO1LKv+fRGO4VSh6tNN+nNl
         onqZB5zPupBBqoFtm8+p9l2rRdv9kr5OuuVcmYp3cVZNKUJqHnOFrBRfl69KaKuhHrTY
         3x53U9z/kER7Bc9uQVo9U0ZCeOLvbMbC+Y1cGaKYcJs6GHAFS5cOSZdP2SGHmmInZUJn
         5fKgbsFFtUlj1wem4L4zZJO8ToER26lXh2HBYJZRmGGyKosDQNA/iqQCpfET1yA3ofuS
         TPGw==
X-Gm-Message-State: AFuF++mikbXKTnz5UJaD1LuRYcPQ/J/RvYQy7NySK1vyvLxK6m61Nupf
	CV13J8Qdz5j6dKSf4y3ey6A/4ClDSVD6AJjHdg8nDbYCkDSC+bN5DP7msVYmDKh2
X-Gm-Gg: AYBFou0tMVbn4ApDqgm6gVGjn5JpSZtTwO0z+q0ezVr6espJe3i8iWyXCko+/bRMzWl
	K1kEDmboL+XQiWrVwZdttQ8zbtNmAfuJm1WsKVyLE9CjCB0VYNpTqBjd8PvY2yyFF+m9yK9KXuK
	fU2yP8GSBUCA+y36LZFzdehTdsikVhfEZkp4Ovhc0Msx8ywbvbNFvPNU/2a7auS0FY2yKU62eHP
	LKrx9c2HTJTQb3RNjzFoO/M9Zz16pbxGM+PhT3krFiLeebT/iVvwwgoSUiuEWn8LAmhLE0d92K0
	3ahg62IRhk4Ocg1YHNHZTfTEPztW/33xYnRLPMDEThKq9vh/scxsBH+hxOwNQCZfHE1Fl08ASKG
	G2s4TVAZhlpgOgXIJ/gQhCmRpjdGPu6IKy7elFUxYV49TyBUhziU+X1yn317DVic/mF4gJelcZj
	GJE38HNOw5tirvKIldVPlXMNTSdzhzFjHyvn6H5gqe8d9n0dvJcv4QtN4UqYh0xQd7/+Nv2CM70
	7XZ5j0Pu5+UwMpluZYS/hQBZAytzQOHRXf3lyqxae/vJSYtolG5sqMjVMpAjc+JaPOXK8a4MjDk
	SPkJ1Ynmduar545OPZU9QBL5v85Swilnkm12DQ==
X-Received: by 2002:a7b:cbc7:0:b0:49e:6052:4587 with SMTP id 5b1f17b1804b1-49fbd200263mr9984555e9.19.1789593667630;
        Wed, 16 Sep 2026 14:21:07 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f7cesm9460906f8f.10.2026.09.16.14.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 02/10] bpf: Preserve packet pointer class displacement in regsafe()
Date: Wed, 16 Sep 2026 23:20:49 +0200
Message-ID: <20260916212102.597335-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=memxor@gmail.com; h=from:subject; bh=u6A1booZqff9HZn1c6UG3ORSmFh2XZq7GxUxYIULqw8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h6y7jvzk+ref+/s9z7rt+7fQsulVdckV08WKEonXl M1nfw/qKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESC0hn+ipf+Pn8w4MyxKoHP KTzf1n3Ijv513OD8+tX53p/q9ieJtDIy9C/j3p/4pipi+yER/YuH7jmzh5y7m8fYKxeUuP0Bb7k HDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

regsafe() maps packet pointer IDs between states and checks that each
current register range is a subset of the corresponding explored
register range. It does not, however, preserve the displacement between
registers that share a packet pointer ID.

This is unsound because packet range is shared by ID. A bounds check on
one class member updates every member, and a later access can consume the
range through another member. Commit 022ac0750883 ("bpf: use reg->var_off
instead of reg->off for pointers") folded the fixed pointer offset into
r64 and removed the old off equality check, so two individually narrower
registers can prune even when their displacement has changed. The
explored path can then license an out-of-bounds packet access on the
pruned path.

Require matching range bases for packet pointers with an ID. Together
with the existing ID mapping, this preserves the displacement between
members of each packet-pointer class without adding per-ID state.
Packet pointers without an ID remain unaffected.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..6c88ad95b63b 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -635,6 +635,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		/* id relations must be preserved */
 		if (!check_ids(rold->id, rcur->id, idmap))
 			return false;
+		/* Preserve displacements between pointers sharing an ID. */
+		if (rold->id && rold->r64.base != rcur->r64.base)
+			return false;
 		/* new val must satisfy old val knowledge */
 		return range_within(rold, rcur) &&
 		       tnum_in(rold->var_off, rcur->var_off);
-- 
2.53.0

