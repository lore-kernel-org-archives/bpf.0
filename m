Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E6277026
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779522464; cv=none; b=DH3VLHU0CtESF92EyBUpJQMw19c5VjdhVh/I0gxqIyZByWTxqa9vX7sfmflOku2BlRDF68DnwfXpIvqT9vgMX6zyy2pSgQmdLbJF9IpOkuSbQ5G3TFbe6Y/Qd1nxMgiWElmi10O3i3pml9Z4RJuEC+U838VOpRanFy0BLv/1vE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779522464; c=relaxed/simple;
	bh=PfOZOqf/Waxp0fKjVOuhbKDiF6dKL6Sj8HRebM4Q1V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7NSSkMOGJn0+dr1/xJHl7Ot8oRJKIsgORKbCy6bpWMpLiVVS+ggtGOw7YiXf51atocJMY1gx1OjMSQkroRN1WLp6ij6j/R+FhRgJ/iO7jxP1ssPCpBK6jmTdfrK1b459ehzQ0uiGns8IfRV2FXr5W+QFrOWiDWACrVS0chLyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8vswjWY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8vswjWY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so25124575e9.2
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779522460; x=1780127260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=886s+5LC/+p5MSUDP6l54CeyLMiGkzDEGBKqbzvyzIg=;
        b=C8vswjWYTSTgt0ItAXi+dBNod4df/o7FqIaU8FKVnpt3Dh14uc9NfZbOiNn0Eyxgcr
         DBLaa7T9VjInc/efs2Vf0NhOmxfWRPeY0TkIz8VBXrW2TpyCC8sgoLM/G/zb2HLoWG8B
         18+qDpXIDbBpcN9IQAbNWTHD/MqQLJE7sfJCgtp08AVo6YiyAgBtCOvphqkK15yVUes4
         +mh/z12rFI/vPb5onYYfFRhjpIXE5HUNZJTCeClaR2j2113oQKzFHmd4Qd3ju8FcV3RG
         7xrAM1KkQO5Wmnvd+qUYeaBaKk+Fc/T8aFXIip7mQWcjk8fG9wR58BqZK4PG+ybB0Y36
         SJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779522460; x=1780127260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=886s+5LC/+p5MSUDP6l54CeyLMiGkzDEGBKqbzvyzIg=;
        b=AyRIypHPmMumtkTijF8PCGB4TCm0SYxkvJVAhKsOC+j70/lI6A2XOdX8MgNMkcnLkg
         q9Xo5/rP3rwsQtMZ6W5r/bGKLHgJ+Itq+tj+9My5W7GpGdzaYhMB2lnF9FniNyaH/GDg
         2X/2hmOXhRdqT0aZoo7eIGDO6Wzlcqz3ZPn9HUkq8QNSGCYshu2QR0U6pPYsDnrMDgin
         jxygYbVUk6+oWvuzCxfbSjc73rZICVDzGTdRtClB/lmobNfqb3GTEG1v4cp2rzshCEms
         Dyi5RJEkDuTWVymeT0WX57u+WWvG5C8pv7zc3s3awLNmT8twoRcxgOdC4FExa0NHYtaW
         639g==
X-Gm-Message-State: AOJu0YzSZW6zZjN2+vopCdUT6dVKbZ6+o9AKZqUT4DYGVAyZE32QB33b
	z+x/42Or2IMZca6gn/ayz9lCDARZvbD7G4x9PcPZV+TTzFXdDIACGeNU
X-Gm-Gg: Acq92OGmp2k4wEJ0gMmpwLF0xNUXhkdBx+3kMtjbHfyvI+XZejX+liRqJkfaTqtXkxW
	WGl/j9R6D/CFgtXwJo73m/8zykeN4Ipon5PR/wLYiyAu/93b73GOhBTDc3Pn87EVp4vjEEdzPku
	UTifRj/bH7Bas6EXoTjIJTkz3DvCQorBpaU2Gc/dEZnUnRKm8+fZunmAFhIcI3U9ekGhFybSqae
	o5vj0w85cvU5H7fJsPkbZr9EpurZghDmnRQOlPKoRDx9X7LXCZBGmfqgKWvAvj7TyL8L6lewr0r
	sAdsfr8jHnvkJFD105BlJverupci8reBGK2ZWvJ4LsTECB9AoGM2r/2p+O1UYS2CQxlbYiB91Lo
	KexHNNmgEUnHH8j67PnwfPHTzXbYHghxTyifd5g6PaqPOttCfhln8EMLNdfHCRlo+V56T2FHFyH
	9H9SxmEnrhVAiDd7HUnBrpKda4o0I5sCynFVRfwpyrzelfmzNiEgO4nbXiY2jBOApNGiHIJs2Gu
	QPiNoZTSPfTwuTTXzTvWBZsREYTmqQ4sOTLOLXaA8ZbU8IM79i6O1NlU6viR4othXcliortqFoE
	lzyOx118RQQq+g==
X-Received: by 2002:a05:600c:5298:b0:48f:e230:c3fb with SMTP id 5b1f17b1804b1-490428ddd40mr103713885e9.33.1779522460245;
        Sat, 23 May 2026 00:47:40 -0700 (PDT)
Received: from localhost.localdomain ([149.22.234.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424974a8sm49822375e9.4.2026.05.23.00.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:47:39 -0700 (PDT)
From: Himanshu Anand <anand.himanshu17@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Himanshu Anand <anand.himanshu17@gmail.com>
Subject: [PATCH bpf v2] bpf: Add nelems overflow check in btf_find_field_one()
Date: Sat, 23 May 2026 08:47:36 +0100
Message-Id: <20260523074736.222994-1-anand.himanshu17@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_find_field_one() multiplies a u32 nelems accumulator by each
nested array level's element count without checking for overflow.
The sibling function __btf_resolve_size() already guards against
the same overflow pattern (btf.c line 2110).

Currently the BTF array verifier (btf_array_resolve) rejects BTF
blobs whose total array size would overflow u32, so this code path
is not reachable with crafted BTF input on kernels that include
that check.  Add check_mul_overflow() anyway to keep
btf_find_field_one() self-consistent with __btf_resolve_size()
and to guard against future changes in the validation ordering.

Fixes: 994796c0256c ("bpf: create repeated fields for arrays.")
Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>
---
 kernel/bpf/btf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a62d78581207..b767a9fcf095 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3765,7 +3765,8 @@ static int btf_find_field_one(const struct btf *btf,
 	 */
 	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
 		array = btf_array(var_type);
-		nelems *= array->nelems;
+		if (check_mul_overflow(nelems, array->nelems, &nelems))
+			return -E2BIG;
 		var_type = btf_type_by_id(btf, array->type);
 	}
 	if (i == MAX_RESOLVE_DEPTH)
-- 
2.34.1

