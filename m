Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8B3A59BC
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784475401; cv=none; b=Efi7PvgVTo6meNgR67weyUjctvrJkt8THXqFXPq1KXBdqmCK+hrY+sNz0Vft94PJ82yON1aErZaS/N+hcxUf5TrYhTvoXCbk0XUAv+TSj9mEtCxCvLYoXAauxylVTOIzVMyQs7NkMK/LCD/S2bDozltGp6/iXqgv8/NCNsp9QKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784475401; c=relaxed/simple;
	bh=Ish/EuQZR3a7Mw00DxfIgnzTm3qzZfAPZAt8LfJMMcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWXeGfHbnXr94r0VW17RjSs72uQP6uqydu5Yhe+JHuqXxB7k0+xjNROh0uDC6JREBbmKxhxJZKNG4hH3CpOXJL72HOIONpc6tF2re8FUqJVCU9cBRuv0gvsTTt8p0p0yWhgwlmyDu1Nz5dMNeyW/F1HTm/aDUgH6Lvd1Xl6ufmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBU9ZQVp; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBU9ZQVp"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so2214290f8f.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784475398; x=1785080198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ri6iJhpXFda64L55NBkSPDL+ZknbNLf8FFlj0tsuT9k=;
        b=TBU9ZQVpF6CGEWmzZl1036w/3tRrFhOkSiA34hpl9MgunoxS/PI+0VYq2y2eeTWqeM
         FZF42+iROfPcPLzDPMc1Jo5ciDVvxzyIFjwOX589b8p8//o+bFFoLejRAHUjby0g+QSI
         2klCqVrXdXQEEQ0uOpDsmOqlWQMG0255zXOoQ+IQcjxnyrLt2Eu/927nX6kIHMG3KSoy
         6oCbpICJzLxLOl8Mo3m+Bd7mSQGl+tEWaFIwucpMb4a3sSuUhM8lQfFkmRORIwbWSCtI
         Jb3o2yZSK3/pBsTAq6EX2BFQkGe9JPviyKY1EvW8TOy7a0RTjvBS1UP8N8nK5AMfaeeb
         /Ehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784475398; x=1785080198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ri6iJhpXFda64L55NBkSPDL+ZknbNLf8FFlj0tsuT9k=;
        b=OWDTmCsZBdMeJG/8X+z6KSPb/CQyvL/aEHp8cd5r4BxrqyVrWoELHnBOqm21AyWOim
         6sPqbKZI5+I34FyiJgGt/MjWye4pjR2D6+Oy4TJlR83MRaZc05v3eFiOkb4nxZGVCe0z
         P/6DKxEo9kxJZHocK1h3b1Ujpa6bWfP1kX0dOgU/pOrzTLpAPQ32+D7dk4hiU/Xd5MFB
         bw62w79NdGsHc2rsQUDg+yL790NRjAU4+fzTWsE9JZEhqxsQGOLBUi1yfDbM9GcX65mg
         yA7zMS4I6SlLdU85ZXNaDM8uMbBQFAqDD+stj3s7VsoexATTROrjuIQujhMYoEiVbpBg
         oLcw==
X-Gm-Message-State: AOJu0Yx9kRop+kG3nabLVDkT5GycyWWpzzZNh5jUQjHydVh6Cs6KSFhm
	ppkxu2DkrqC8q9PfyrGDqgzmd9a66c7JjPQpMHPRibjDvmYtIjFVhXa2Tgs0BQr1
X-Gm-Gg: AfdE7cmPP1uODw3gqfb1t8JpOvlfNwljVXp5cIhNlu64dYw/axY0zbJxszHBXx+RoLh
	Fc8CKmD7Y4JLYLeZiEub3ZG5H4RdoZ6x8JtmKm65ApszFZ5JMFBpEgw0eqLc7IgH/N9khcYHgKp
	t+3WXfcimvZdQY+EeXpIE5u/WgVk8wpCoKPXDFwIm4jAFCSQtPPaQ34Vx903hEGfxApVdMVkJtL
	sWosFtg52pN9Ny2xXH7zp9NTeQH2LO7rNk9A1Qd3k/yhde2vFNSmtN6JkBhEStKPyJgi4JEcWIl
	hGDifMHus1Fc/Zglgu6Tw8hDLgsvVXk0aHAgqQOgkXozvCFqe6cbsZ9ENjk22Iq2KLD0/SlVXda
	gYDmI8KJL34Iaq2t0/ZHVkOIWFkGcg+lwaye87GLGpOVBsDp9TWH6UtXcl1byl0EOetCfVDZ0JU
	Wk11yyBMSrejUU3R0NB8oCCF66p/LrCW2PlzNWDmvGkFJUnG8Eio6M2yYlW4Hp5AQtpk6GrcsJQ
	kyX2hWW9slIfaqYZO8RoZmSDBjc1XHygcSF1I+UJZxgwBgujZ+Y+5s=
X-Received: by 2002:a05:6000:184c:b0:47e:4379:a4f1 with SMTP id ffacd0b85a97d-47f622f2b02mr11585925f8f.6.1784475398158;
        Sun, 19 Jul 2026 08:36:38 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ab8sm22888334f8f.5.2026.07.19.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:36:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/5] bpf: Mark bpf_refcount field as unique
Date: Sun, 19 Jul 2026 17:36:30 +0200
Message-ID: <20260719153634.2908692-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719153634.2908692-1-memxor@gmail.com>
References: <20260719153634.2908692-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=memxor@gmail.com; h=from:subject; bh=Ish/EuQZR3a7Mw00DxfIgnzTm3qzZfAPZAt8LfJMMcM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISvmlUTjwd/9CwUE206ek0/MXCReZ3ExOqZBtS0pXvSF4 aySy0EdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIjhY4b/0acOLr/Ibs+xsX7l m0RBoyPua+o/XT4S05plOmv2EkXLqQz//W0c5joYfW5KeVbnsmuf87mbAVu+9Jv3hzPny/JUJUu zAQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF_REFCOUNT is not marked as a unique field, while it should be. Fix
this oversight.

Fixes: d54730b50bae ("bpf: Introduce opaque bpf_refcount struct and add btf_record plumbing")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c577f00e9d88..4eeeaeb69790 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3669,7 +3669,7 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 		{ BPF_LIST_NODE, "bpf_list_node", false },
 		{ BPF_RB_ROOT, "bpf_rb_root", false },
 		{ BPF_RB_NODE, "bpf_rb_node", false },
-		{ BPF_REFCOUNT, "bpf_refcount", false },
+		{ BPF_REFCOUNT, "bpf_refcount", true },
 	};
 	int type = 0, i;
 	const char *name = __btf_name_by_offset(btf, var_type->name_off);
-- 
2.53.0

