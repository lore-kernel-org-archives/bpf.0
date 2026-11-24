Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795500250;
	b=x029/FmHIBM6Mg0rQap0VaCdB7miIG278sNgroEGlb+YtLftAkZdKP/eEioVtGMcPBeZ
	 0S8FCbSQtDJgza4MoPUoI4hnnuB7rrM1+F2sgC/CZpyRrUCCf6pLIKI7gk9pVfQ7prV6k
	 QgGOIM44Y3hyMHE/nHOor2AioDdOB8txDIZVJKCQmXLG4n4WPAN/zmLHUK+vO9yufmDue
	 AmhNKmgVHZuJgwcWONCEPdrao+6BBzZPn5vPamTJIIXt3p24Th+HIT54Bn5rU+nxzSVc6
	 r7rCAtoLgYL9humWZwFIg4tk59WLyK3yFRowuAbty4EnPCyiaXkma8itFx4WipbzQzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795500250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uJQgEXnImm7M2OyyhF1mecDQmLYO1UX+kyoLrSoa4xc=;
	b=c5LCrYN2pvPKjegwC9CBxMxAjIDq82LERc7vMsowEumDFaf1f+byjfUwKbzF81mUJTHF
	 QGPpulO8RdAtYpD1zqxEh2RkR3FJPkvLUHwqWaOJF6ssqoz8orri5EeQGE2pIF5a5NvSj
	 a5jcOf6zJqWPp02AUpTnvlATy+ylFMVYjRqLL5XBoY1n/9FSZ3wkqr7F3fb/uPPEVgjBH
	 uNWRxF92MkzWWNZFDFP54aLyLFpIr4/Zem2vJ7ZsffyOurVkDqAu5RXAAjdXrLqYurgEA
	 27elk1nhNTbI7piwiVZwtkjbf/wb+QNHeDKhYXR737MrJlwNOa4zvQYPNYR/rjzMpvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=zDh6vqu9;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203F606A327
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7203F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=zDh6vqu9
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2f045b921caso22707815ad.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1795500250; x=1796105050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJQgEXnImm7M2OyyhF1mecDQmLYO1UX+kyoLrSoa4xc=;
        b=zDh6vqu9XqEwiVuvgpFc8mgZjmDaZyT0cAi9DkzbU5k2sBS8w6O9f6j/XnzjuVC1qC
         5+F8T7DvZYZ3xzIW6yXmMIeyPNkjbZ7HlZhRkychECK9IhGRwfmY99z1PF36aYJ9Ijtl
         QqfOcNnx5NHD+NdPqYUDurQHGvO5vNBxK3h4rLHUF74pN60Y7vI1vcp5rseZYhCf8jrk
         +Oju9ruMc+4RlVVFkMTOBzwqsSPNE6LawvzQwil4UGCvawvbrn4cIRuFqQ663lqNldS8
         SQBD7t5YIgEDtkwMeI2Qa1vb7xG4GqXs4Se6wvcUBNQb9ZlBFhz4roPPWBB39yU3Da5G
         aW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500250; x=1796105050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJQgEXnImm7M2OyyhF1mecDQmLYO1UX+kyoLrSoa4xc=;
        b=Vz2HQ8pX/MuaCBWAeSR3xgab1kGSvxpGM6q84VT6lFyHji+GqEiOra0IDnjP8JnYHc
         Z6rsTEt024grOS/iuUuNsSVnqMK+kZ6h0f7sigDUOuawyyoQ+OxbV3t1MAvu0kuBzFPW
         fsgJORS7Sg20VVHFhKVixe6l44v62aTjf+x/ATtJzZOiyzUme4ajANa2Y+8b+51BAvl8
         xHyDA1oDEb4nlhoGYVcsu2wlUPXhAfWltyP3Fs3y1ct6GmXK59a3sM9rtfog/b5gR7GE
         7FfZK7SC8lJOVtOFcUbOZOaNm28BwTucnriMr/9gyB3rRbMwvcNq1hGN4m/B0Fb5UCiA
         vRFA==
X-Gm-Message-State: APuU4Z9cGSy/CYjyNUtDEvnxhmAq5MW/aatu0bZt8ijlzaMTOrWd4sLg
	Ml8Antip5yGXm1YVM9OYvCUnZfAO9yV7H5WNKTAb4XtspSk0iKDxmyby8a4jkeqs2dA1MYNgloR
	dey9BJME=
X-Gm-Gg: AZFdTZeeF1Sam3lBHoJXN/gK/l0EtUUmukiFO6tmo9WZ/fN+QdnmzZsQi8rXjq7Y58A
	6lMtzzvQ116Xz8j+p//J0+Q9YF8j7E2g2J8+oPZ3KKE58Vny1VngpoQK5yeR6fupHzPteda/80y
	Blcl9GC5UzW7y+/LmPLclupES9ecqooag/w/J6bjvt3EzdDUYLvoEYZPrP6bXBHqFJyM2WDHUai
	F6gCOiCoCJjAzkQtmETb/bQz9y5syt8isC3q8aKaSBOjvuxvRwZChDYdf31yuJ147A/inLm6ACJ
	segpAYoVQbpvfanI59rF1zTMp8vSvSNS9+0l66QLGTjCwHHnKzMcZmx6OwECnh5IpYxP04M1wRf
	iQT/5jBgFpVu8SvCo1nnLp2HHlra7gKnfaAC+hRmL6M8A92iW0Z0J+t7q0yPqO1qjOTpd5Bv1ho
	+j5hF/eAB0sYiVDoNYx6oylhjHPfo/htOh9JSOy6dOisIP4+NlefXxCnzwlBe/dlm063auVWrSS
	UmtgEWaaijE+7H1XSAWpoZzoBr/d9N+k3XCeOGvNkInbFw6WNdvG/lU0cQrMl6wirHmNhJCIm18
	xsUckJBgRa0JBNn6urgwJvfhOcLuOFMXYVRFOxgq858acwJl+EQ4Kp/lgccy+XmPnqRwe+3E5rd
	VsJdhkD3GG4vCb7mDh6vsjkLgz8g=
X-Received: by 2002:a17:902:fc4b:b0:2ef:d82e:87ba with SMTP id d9443c01a7336-2f03ef870e9mr134426455ad.3.1795500249831;
        Mon, 23 Nov 2026 22:04:09 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42a6sm64215985ad.23.2026.11.23.22.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:04:09 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v1 3/4] bpf: Add sleepable local storage
Date: Tue, 24 Nov 2026 06:03:56 +0000
Message-ID: <20261124060357.11700-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124060357.11700-1-emil@etsalapatis.com>
References: <20261124060357.11700-1-emil@etsalapatis.com>
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

Sleepable BPF programs still create local storage with kmalloc_maylock.
Use the program aux metadata from the expanded helper to allocate
storage with a sleepable call when available.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h            | 5 +++++
 kernel/bpf/bpf_local_storage.c | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5565a735ae7ce..52eee026d0685 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2094,6 +2094,11 @@ static inline bool bpf_prog_runs_sleepable(const struct bpf_prog *prog)
 	return prog->sleepable || prog->aux->sleepable_async_cb;
 }
 
+static inline bool bpf_prog_can_sleep(const struct bpf_prog *prog)
+{
+	return prog->sleepable && preemptible() && !rcu_preempt_depth();
+}
+
 struct bpf_array_aux {
 	/* Programs with direct jumps into programs part of this array. */
 	struct list_head poke_progs;
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 28eaee5c66ce8..74dfebf180970 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -69,6 +69,10 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 static void *bpf_local_storage_alloc_mem(struct bpf_local_storage_map *smap,
 					size_t size, bool sleepable)
 {
+	if (sleepable)
+		return bpf_map_kzalloc(&smap->map, size,
+				       GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+
 	return bpf_map_kmalloc_maylock(&smap->map, size, __GFP_ZERO);
 }
 
@@ -598,7 +602,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
-	bool sleepable = false;
+	bool sleepable = aux && bpf_prog_can_sleep(aux->prog);
 	struct bpf_local_storage *local_storage;
 	struct bpf_local_storage_map_bucket *b;
 	HLIST_HEAD(old_selem_free_list);
-- 
2.52.1

