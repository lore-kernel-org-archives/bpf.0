Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93F3FBEC3
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684557; cv=none; b=EIOz8e5EfoQlE233AprNy6kkd+Z+yN8BQMAiK1mwKvid3mqUBZ3vASi/CPob97IOtp6U9oixZd7lLHzQwNzY/tAi/CUd0sxh4XSGpIJ9TS82q1LAMCXKILbH9fEKIEP4nRbvVqUApgK/9ov0ixjs9+uivOHd5pn7l8F8BlrYsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684557; c=relaxed/simple;
	bh=VVADNSV1X9wTkRBoKH71hQL9qSar8jZgE+dZ8EZnP3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei/fYC0r05E2AZdLwuEDT+iDuyl/uCxHgA2cjQSoCX98c6vlZi5fa5j+G8UXdFzQ5DAFdvwlQcuSLcFKP49pDXEwgUoWJpu0g3kxVANqeQrCMBNKxAOEiGU1UkIJzn0am4T3RsKdyu8a2CCqrnqKqHgxW/vN9UVmHAJm3+9e0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlboEMWO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlboEMWO"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so2287683a91.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684555; x=1781289355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=BlboEMWOWKmYDDGiMzxNk0pjbSJCeaXVg3A9oFzpsXNlcWLqRKc8yAcrLV1y6+VJxc
         lEc2KNS5+vrMvWfLq5yve6doTy1lQL3gD/3F3XSUooQ+Xopc5N0iAOQjCVmmRZN0VZ8p
         jyRM9PlPQa54a5F0Qp0ELsizlOLy5H9WXiDO+1MJuLgEMt4/QbWjVEz5b+OipUwiWYgS
         LEx+PT/as8EA3iYBEqEnqzu5zgpEAxbl5mt+LSyYay2Iw5uTpK5YzJ+GtPzJSfCYxFOY
         shdMvLEeQyffZZZ4Bg7BA5uMUnOKj/UcxvLPfHfpxLd9h6YrWaH3TTToIBP+XK8DYhUQ
         e1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684555; x=1781289355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uLIAaKlmgt4AiSXDWFcEgvbqEgZu5tWx4v+R7w02MlU=;
        b=m/wZaTcviW4XxBuhezcKYZbIt4jAAEFoJJ13CAqJh4kmZIfTWRPv1fy2ZfboPMiDjo
         nOIL89yCV5otO+8ICfsw97BrHh+wNPw9JDqWKGEGrojqDkMzqyJT+XxYpC9bGh3fGtFP
         5ZTwjU+n1IhAYlryyP87fsubdWpHHdeIyijfFxTBOoZVp68qAq4itP4jmPW7fXF/iU15
         HM7l4t9XyABWkLcep8tC3Uno9CSxsBp9bT9eNXwOsF3dO/2H7uKV9sGlJioqepG4BUeX
         ELAq+s/SqIpYtr5tgr8eR5yDO1rSESrkbmvP8FYNYPPhXuI5+6w6w+C9Q8V39iXf8FdD
         /Qfg==
X-Gm-Message-State: AOJu0YxbXHgSFm73rj9RSvW1b9gMEgx/A4Pjy/vyTI717E7Fq5/QqjWn
	gS+kySVYxcAySTwcApT6u8eTs34lhGVc+BzUn6pXX9baablNKAnzKD+Kwf01Bw==
X-Gm-Gg: Acq92OEB6l3Z4Zb7D3Fy8hz+vPlIepDVLZeDTaldGXWB5SCIBMkQNVA3MHSXa2br4YP
	GvcGR8UhjO4+rNLTPU8tTh3n5vy1tr+oAxQR5nYUS+q3ebTO7NUr9jfOlTUJLZ8Tusvs8KEQAPT
	EvSozWu8XAabvIAgrYoWoqhn/NSShOjxEXPpdyigjcglyLTRSXWQV3W3hc2fxFLqQlwpQgb96aS
	ORwaVPHYmxBeYtCMAxG1H0i01bZFcu9+tdvvBl4N6xUBt+Dvsz0y32EGZZ5LIpzmfIA8FWcZmFr
	KZ3d5zITILrY/4iXJosbSttP25pVQ6PHzzGN+uuzyBYEiBXgq3WUGK8cq2Zb8op1Jl0KzVwd+zp
	/5YlWsHi6Yz/5GoHbaU+SnKrMKXMyr+cJxDbc1VZnN57vGr9V+DUO5jv1y4uSyM6P3rLV5A/lFG
	qwmsg2rLovcmNiMcg3wXKbByI=
X-Received: by 2002:a17:90b:57c4:b0:36b:75:6387 with SMTP id 98e67ed59e1d1-370eea202f0mr5225778a91.8.1780684555542;
        Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668f9bsm7340861a91.7.2026.06.05.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
Date: Fri,  5 Jun 2026 11:35:49 -0700
Message-ID: <20260605183551.969144-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605183551.969144-1-ameryhung@gmail.com>
References: <20260605183551.969144-1-ameryhung@gmail.com>
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

