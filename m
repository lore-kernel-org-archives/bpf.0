Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800247;
	b=oVJVnDkUpfUPTzfnpU9eGUOPzk2oZU5mu1C6rLkiZ1AwI88UxRx0vTz0xnEzK5Wi71eO
	 aj77oMNP5s94RiMPDtpI0l/iGqlvvkLWsh0bNjJWFA6KD5LNGs+fzbiv7rezbXgnVotC1
	 uumxM4lbHGAknTOF71y1b7gQMI4OhaMLU1b7Dz+EU2TnfOwh8OhsKz4UpQE0SIaZYDbA6
	 253cZMKGmz0TG6vo+5SFtpv/aJT7s1ELGCjUKGU+i4mYxH56Z5Q/2K2n6AFllBeYfruyB
	 eVJVbAC+9F8niSMKlNUx8DsyRvmV0dUyLyemMh7tUPzb2dCe4ln9UNms+79g+RsOiCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=zW3NSS+FozOVr5gEsZP3p+5MhUDIs3oKfokoYjpawi4=;
	b=fqgsshG3OEIsvHj1VRcz92N0dEhqFQpGO+rHHRLf9JrAKpADIA2d6m/oZuiCeeoannJc
	 bcHfFAQwZ+uJS6EQPFVdTDDS0C4cSzFIGGmgLW1x3PfMz/+cejR8QU2BQox5mRZ9U30MC
	 StQct3Nt+Ar3NgqbnxBG8ZLx53OOoveY1k5DnC6fjfzD6GIJBC//SZRfheRDCt22Aj7n5
	 LCS6c59RN3AuwrWBz3EPWoa4jj8/UPQ4nBCrCuFSJGeKzZUP7h1d8PE/bY3uGS98JS19J
	 wJhPANtR8N4hZPzVwSVbpQi9ecWOn8ERfReSrTxOwkf9EatasRjgUCERpEdRU95pLsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="J49AS/iC";
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DB606A31D
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 363DB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J49AS/iC
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1052127a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800247; x=1793405047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zW3NSS+FozOVr5gEsZP3p+5MhUDIs3oKfokoYjpawi4=;
        b=J49AS/iC8MJBf6zbMU2wqp3T+tu3Gc4AYv84fSBQ2tvhG39fhYtQTrs6IMTjRoeA+7
         TyHNBd1C7C1czZywz6rad6vdOibAbJ5LLGcRrsTFK497sVXU9knXua5upp5vJ/7xY9hV
         cl6luhf/WZx1LEvbr4CD1Gj2VKn4H7YRlCB3wGxYKuVE3pDBkES8eEtrq+yLr377sBIJ
         UVnAbeL2NdOjTFuXCcsGo/NtzXeRgLe/3mwCdy3dSHPdVn+HoCbR4b9vC2N3gPuxadct
         7QPRhDH3cZ+1l0dFHVidTxGs/SV4vO7qmJN9Cs3OBp93Dnyiia5/2/CwgZ1QBPHFboQK
         RbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800247; x=1793405047;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zW3NSS+FozOVr5gEsZP3p+5MhUDIs3oKfokoYjpawi4=;
        b=Q4AjX39/JsDqjjEwRkgHG0NDehti12l4yvEs4cCUrE9FefF777InyS8VGPIMGMnXP1
         t1i6sF9kkghlkqXyqYlOTXOx6/AzLRe75XS354Z4Xl3tBeMsHqu4kDlJstzYiyrH6bjm
         bVS5Fu7mGuKoLSugNnVR6V3HIfySCovJpk8yTA2fHrvieut8J+B60VrHJWnG+a2SvonA
         SorowhtSk+kvJIYuRp/Agnk/DbNDfY2tvaXlt/1p+yRcWC5ebrx4dVrWqnkQxlqmL/fc
         3/FrqXxEPOjRGrKsc58AW+M4Ni+N0YwDxnMKPkAddZlnSpghcHsenj+0DjBWQOeuXhPq
         KjPA==
X-Gm-Message-State: AFq9FYJjB+wGlPTkmfRrdmkRQSz7dVL2TXZjSPvTwQYVS5bsEyW3usZs
	/GdQ2w04KNGzgG5ZAJ7X5O1+Sm4DVESp1d+QjwJcoeb7ZphsMu/7gFo/1sJeFI5R
X-Gm-Gg: AYBFou36OYQGnpWvcr8SgFbF6V8wtJoo5TpVTQVfzRJVEA0oNvPqHIzSPjizk1I0QAl
	3Af1fx02p2XtndVy+4Haz2IyPzUe2jwoEH4KB3R9I2p5CvGr8Y723BVuqMtPc9u99vkKCKn/vf8
	7p3s1rMkmR8tlp1oblKZFMd33GoA8RhqzdZv3Y9AXFqbVr0KOzowfa8yD54HudHuYXZE4YJvWRf
	FVLLwL/PidojMnqDlH+P8MCgTm/O0C/T2Jh7M13ixXFTPfRGA+vPnbC56i0rGAoP0jmcmrJlaBp
	pF2M3vL56BhwN/kddv46ANUYYxtstQUoBPtwRKBf35GHP96H8QVNsry02Vih8Jh1KxgK3XvcHDQ
	AB3KhIYG1Jwn9SM03cTj84LG2oNHPZ3Dy9yZ2exiA9Kd9F7VngU8CDkP6MyP8rIIIswOMmU43r0
	qjOnw75/uF/fw+HKa+Chl0g6sERkGJcBVSeGb9+AfL+q3XIUrM/dbi0yBs+XzXevQValxKvgqm7
	9vfGfr2Z/U7+dkR7+maxQYtuRcnMgyCuF7dfDI66JODrL/M2gEZf2gmxsPFjvsp/DWpz3sirQ==
X-Received: by 2002:a17:90b:588d:b0:3ac:4e18:2390 with SMTP id 98e67ed59e1d1-3adea1ad729mr668140a91.7.1792800246656;
        Fri, 23 Oct 2026 17:04:06 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 03/11] bpf: look for current loop in upper frames in states_equal()
Date: Fri, 23 Oct 2026 17:03:45 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-3-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When checking if current loop exploration terminates, look for active
loops in upper frames as well. E.g. for the following program:

  int main(...) {
    for (int i = 0; i < 10; i++) {
      ...
      foo(...);
      ...
    }
  }

  void foo(...) {
    ...
  }

Checkpoints created inside foo() now count as loop checkpoints,
plus states.c:bpf_is_state_visited() does skip_inf_loop_check
for states inside foo().

Doing skip_inf_loop_check is necessary after the previous patch:
- Clamping now reproduces the widened range at every back edge.
- Meaning that induction variable ranges no longer vary between
  iterations.
- So a loop calling a subprogram can reach a callee state identical
  to the one from a previous iteration.
- Hence for states inside a callee an infinite loop check in
  states.c:bpf_is_state_visited() might report:

    infinite loop detected at insn 12

See selftest clamp_callee_state_pruning introduced later in this
series.

Fixes: 6ccf49f79327 ("bpf: Use SCEV to widen bounded loops")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/states.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index d7df6632a5c4..306ad208a8e4 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1361,10 +1361,14 @@ static bool need_loop_checkpoint(struct bpf_verifier_env *env, int insn_idx)
 static struct loop_stack_entry *current_loop(struct bpf_verifier_state *st)
 {
 	struct bpf_func_state *frame = st->frame[st->curframe];
+	int fr;
 
-	if (frame->loop_stack_cnt == 0)
-		return NULL;
-	return &frame->loop_stack[frame->loop_stack_cnt - 1];
+	for (fr = st->curframe; fr >= 0; fr--) {
+		frame = st->frame[fr];
+		if (frame->loop_stack_cnt)
+			return &frame->loop_stack[frame->loop_stack_cnt - 1];
+	}
+	return NULL;
 }
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx)

-- 
2.53.0
