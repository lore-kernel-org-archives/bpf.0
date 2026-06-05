Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C13EC2EF
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690862; cv=none; b=Bz5Riv70DriXspYLqh/eshx467FM2vZlc83Jr9trqzZI9+QG7LHi4OAwgfW8NjMjMX27h4Zmy7xwnMN8i4ya2btt0IIntC5TK27u6GPbr9kuDWAa/aVYjOZQYJPw1+KqbduGoJY5bWQ+ODPsj4WYpoxLsWrB5Du4lNVJsCskzCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690862; c=relaxed/simple;
	bh=VVADNSV1X9wTkRBoKH71hQL9qSar8jZgE+dZ8EZnP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu9gSxfSZyfv+JiW+uWUs4BtpQnC/zyk5T08lEma3XHKOvd5CLEicuVmJTMiNCp7WJCnf5uOPPaqrJAbbqQW7xEHcTYG4FefOKO0B/G3jy5jnxdrl9AJeUp6R7muy6IMJ6szuAAbWPmjBbvQfnr9TT5c08i9o6BurRXC+PuNXI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWNn0obn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWNn0obn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-842288702fbso1027921b3a.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690860; x=1781295660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=AWNn0obndberHrdOLGHmbiKgn2xP4vgMxCowoBbyjvXUEm463a7j0TBRhmRFt0kC07
         b98ZgMAZhy54UWsQ5oxjlp/faDb5LUzmDMdkNYpZszFSSYOFQYeq8ESrTxebHQsoGrd+
         /7oeUaf3PmKxIKOlLkdY+Kksy5iZzyAfCDap1XST7/0DbCDYJASWqoAEMevX2DRwovVA
         BcK7BV57JOW5MBgBUV7qpbsTbf2Neg+PVklOVLBvWgQWpE8ON3UYN6nyOJ1ht7bpZOt7
         us+758cw1HPUNVKCnv5bHJaxqvLFB50iSr2iLAlwPAdOCnJoQ3OoFd8QvcyLmYrPS1vJ
         FDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690860; x=1781295660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=deM4Uwb06VdBZsZIwTvWS9pPRGg4bWNuA3Cdkf4b2DIGusRfWSFdbBFuy6EW+tLodc
         gfHBh0OEEU89oN2JqO0ZXmbM7F4lkat+QhzHDlP/moR47Ms673B6SnYXe3JTSJhMdx9e
         Gt/XmeLEBfoA9puV0z3IbgwgyacnMM45ftxOer4p39r4/mlZNnxoMDJuDvV+nyIuNNEK
         CCRsUE/Q9lLu0WkhVlQ2lOZRM6qxyFSEe+r0kClCdF/QAkwKUiRXfcAO0tBS8WJCGj4O
         2Rt/WlL71k7P7bbh0zBaOnT+7CalgQskyUqwn4iuqSLnHOs9JJWYTNftaHl8n/TC7KVq
         Shjg==
X-Gm-Message-State: AOJu0YzwOJa6bt8FoO31UJqJQUi81ZYOcf4rU+DpKZse9nKWVZC9axyu
	JjNAb9kLvll36XdYTLibwjpP3GTf8eJoQFxSSHGXux/bMtgOabvKlZLQ/M9Ppw==
X-Gm-Gg: Acq92OFTD1lxh4zoguabXvPksBgM8wa8KRhjSiEEZOLBYQYFm+INhYltPG/7ElyqbNS
	cbSMsuKu6HUspa1fTPUFP99LdBZknIJOzzf553vixssSESw5yKRuJauDDgelpEGw/IU4XApryYk
	8GGy1weRI72hchQOmdJHc7D5xbfk2+FKMXeP2Tot1NptJ3gosQKfTgrh2m+Asb8jq3WC9tmqiTz
	z8SxN1XczwOhUeSGTRqSYLBx62+07t7y3f6gw1vTY3zJxr85OUNC+y7d91DozQBSc0wrP90WJnI
	DJlECJfWDglbLrJDjwk1oEuEUhvj4+aQDUa13RL6MS2vzmLqBXjHJtTqEhu+bB8htEllHWFJ7DG
	h2TVe2cwnxl7J0bvchudkSEIqeG1ASFCQWu9wjptBhZsaM274SffoPYRFIeb3rUeBj3DGOISsra
	a9s92cmeoR9ovNEsWrD4SP39U=
X-Received: by 2002:a05:6a00:418e:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-842b10b2f2amr5312600b3a.38.1780690860191;
        Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282374300sm12345069b3a.20.2026.06.05.13.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:20:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Fri,  5 Jun 2026 13:20:54 -0700
Message-ID: <20260605202056.1780352-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

refsafe() compared each reference's id and type but not its parent_id,
so two states whose PTR references differ only in the parent object they
were derived from could be wrongly treated as equivalent and pruned. Fix
it by checking parent_id too.

Fixes: 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 5945956a7573..06d9ae24f006 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			return false;
 		switch (old->refs[i].type) {
 		case REF_TYPE_PTR:
+			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
+				return false;
+			break;
 		case REF_TYPE_IRQ:
 			break;
 		case REF_TYPE_LOCK:
-- 
2.53.0-Meta

