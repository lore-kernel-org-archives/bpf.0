Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410D3F788F
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777060280; cv=none; b=efcXh8o3opnXebAVvlkBVFmZF6QEi7kSiPkSirVT7cGc6bQOS/PdBaGimTe+MTSX2AmhdeWLQGEf8JUq+Kw6nr2OEpClN3HD2gdY4sL5ooveBPTVIt2SV7/b29krtGAfI8/yd4CV3h/vBJlbdvbi1eFS98HFxtAXw8WLmOpbYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777060280; c=relaxed/simple;
	bh=U1v3lA0a4gGXVnOXma5j/AJhK3S8sYp3KpE8I6vzJrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXGeSXn2moz3awYo7+lePlo5vNE0djAP/YuEXcAB/tpeQ3kMkVmpa9Xk3tpjaLIG+m5PFEBXMHSIixKMeJqck3HoR3TbPjNxEMn8hmPl+FlFaSdqn8sNIeAjVeYoLHWBJYu5TYLAkP8jqABKs6jFWo7zG9klCt9hQq11KKBoO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOu/dUH8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOu/dUH8"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a3cee3a271so8267921e87.3
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777060267; x=1777665067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQJIiSNvodxfa3p2Bd0temZlrMPduM/pZIs2jSnIbOg=;
        b=MOu/dUH8iiYFrwW3U4NvmsrcNq6i/GMROKczput8HcbO+ZOhWU2pIpGtq1bIy98qj0
         XOfO0UBp/3oTG1t159Fp7Ocl2LnhCXPidiIIOkUo0SremcMGxTa92trmPy+Y4CzGzEDS
         vaDyJcPRFjA1avYcoODo1H1rZNxu1yJozUc2LAR8xNUc4ck9desHtrqLa9vNpisYduj+
         VFEYrZSeyDwFG6zN2v4Ct2h56bVTSfCYEJF56Wj/stglI2gYwzhKSAJ5J0jCRQHN5hTy
         jG8u8u5Chi1vGD3BwyPyUvbK+uhvStaH1pl9NRpd+T75QBCjmbVS8H4RNUbWzi46XRML
         0jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777060267; x=1777665067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iQJIiSNvodxfa3p2Bd0temZlrMPduM/pZIs2jSnIbOg=;
        b=KUExSgJ9zHeTQMuOWcN8VJM/huNw969ag3F4/Ro449gct/E6zv5dr+ZCP6u/ItEedC
         iokEU2MF/O/XAsnxl6nVOmlH5nSJLSOGqc0tYjzW/jS3B2Sw0uGw6S48ok/oRolDmTbI
         vJs53o9FVDtNYTTpIjxB9nfSdyFF2cVZiY9EcANsAvb4etWaBhu+4RwoQNNwjdqKtFI8
         h4Cb7yWddw3yMV+Ftc5OwOy0vf1F6a8V9a9nK0Mfe8cTa3uIsgAPjDBy4Cnm1dTtzGzM
         fphwzF3Hf4DaTS5YiGiKkuriZzdwoUZCHcMDs6a/N+96bu3DelJPhByZt1nDKjtZ16Xa
         WBHA==
X-Gm-Message-State: AOJu0YyKylZI5daiN8MuIqugjVB19Y4ARgzOfj7KIbpRHd1nUpl9mjNy
	JhTVKQBUi3C3YNJ2xmheug6ROPHnH56IfQfIfQU/Koym3C4kXweu+u8j
X-Gm-Gg: AeBDiet3s5ZcahmxPMcIu/fA4dqDC4dEAx949xLWGOCuTAaqZC+67nrBbfcUeh8zRAT
	kgyz6bO7D4BUq4Q2J15vV5e7ACA7PH8bnrViUDHQJlK5fu3WYk7Y4sMIj6AvSo+fuuWMBdVL9C8
	Iql0ioif+x2KLSmSJ1MSqb8skreHYM0OTKyU6ZgtgEUEByW719m08CNkCUnM+xM6simYyVHUkPN
	tyTS9b+BjIkEN0QLq+Gvr890OS53foOPkN8eHYCCFO8fBP1ceIU97EzujEJC+SZbomSs69jkVVA
	7YEMoE+1tq7/iondbvSRuSOYUg7q6bmD2nqAR+bmU2GxtXWXPaSthf8i3Z0QA1D1WdJYZEX3Zw5
	wSunBkT/BIJCPT7bya0bo0lFLQ0i42NK0To3A4nzeXrMxlWa2OAdABtm/qrnksNe3SwBBiSE+mB
	V0eWsWdmKrIKwO1h6UnIb0
X-Received: by 2002:a05:6512:2248:b0:5a4:992:e8b2 with SMTP id 2adb3069b0e04-5a4172e1c8bmr12578372e87.21.1777060267174;
        Fri, 24 Apr 2026 12:51:07 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc1f6sm6115972e87.20.2026.04.24.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:51:05 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 24 Apr 2026 12:50:45 -0700
Subject: [PATCH bpf-next v3 03/10] bpf: Implement get_next_key() resizable
 hashtab
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-rhash-v3-3-d0fa0ce4379b@meta.com>
References: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
In-Reply-To: <20260424-rhash-v3-0-d0fa0ce4379b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777060253; l=2077;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=oWKflP+3EMNnYhPaeM1Y3Qi7Qeu2b3fhkY5i3pmk2co=;
 b=VstBuowceQq9OgPLbXmgb+3/JUlm3rS63pgv72/ogdcKcd6QFX5oqLAjvtg/ET7x8upXD4b51
 rm7FvH3Z4IVANOGpYdCtdXQ+HB/Sd4utzNUFr+jWx1pvHSff8w3VBXH
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Implement rhtab_map_get_next_key() for the BPF resizable hashtable.
Called from syscall, so it's safe to use rhashtable walk API that
uses spinlocks internally.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/hashtab.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a37bd2a7b30f..d37f3d548d36 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3014,13 +3014,54 @@ static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	return insn - insn_buf;
 }
 
+/* Helper to get next element, handling -EAGAIN during resize */
+static struct rhtab_elem *rhtab_iter_next(struct rhashtable_iter *iter)
+{
+	struct rhtab_elem *elem;
+
+	while ((elem = rhashtable_walk_next(iter))) {
+		if (IS_ERR(elem)) {
+			if (PTR_ERR(elem) == -EAGAIN)
+				continue;
+			return NULL;
+		}
+		return elem;
+	}
+
+	return NULL;
+}
+
 static void rhtab_map_free_internal_structs(struct bpf_map *map)
 {
 }
 
 static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
-	return -EOPNOTSUPP;
+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
+	struct rhashtable_iter iter;
+	struct rhtab_elem *elem;
+	int ret = -ENOENT;
+
+	/*
+	 * Hold RCU across enter_from + walk_start to prevent the
+	 * element cached by enter_from from being freed before
+	 * walk_start re-acquires RCU.
+	 */
+	guard(rcu)();
+	/* If key is not found, places iterator at the beginning */
+	rhashtable_walk_enter_from(&rhtab->ht, &iter, key, rhtab->params);
+	rhashtable_walk_start(&iter);
+
+	elem = rhtab_iter_next(&iter);
+	if (elem) {
+		memcpy(next_key, elem->data, map->key_size);
+		ret = 0;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
+
+	return ret;
 }
 
 static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)

-- 
2.52.0

