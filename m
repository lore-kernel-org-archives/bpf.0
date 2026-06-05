Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C3D3DC4A9
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690864; cv=none; b=J0DLovXszd00OFCevZXfJbMMME1tt2Xlr7xhXmI85lz+MM55ih2/Hwh+aVjbLk5rHz0q8nOBV2IPMacHerPrLTa8vLlVrE+u1ef6Pj7AkvPM8jQ81vkFJ2K5G4Ktsq5ZMoOKaUmk/alUrojdu5cDTqM2hzzUnZvcYxw2IcKBY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690864; c=relaxed/simple;
	bh=qV4hSRgYCAlZ/cX5eOLisIxPMgz7Jx59zHgWJ0fU8Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKpqYooXpqbt5TS4X1FGlDaU7m5i/kTVTR0TNTr3jeUe33v4wXqhOrwdT1KoIJDWOkAvn8X2yJd1j0z9epHxdetmZUt55NCkv0IteRB79NVtVFakgMm6b4+MQEU2ZYCeGy35wgf8+d0uB1/gUP9twaDW5SQDNlgO83FPl1srDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSIyFONo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSIyFONo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423f52af13so1677060b3a.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690862; x=1781295662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=KSIyFONoRb+UzlHqW8MAo5dip9D7hJjp5Uldbwj2dLhLf3nCFW87iOY7/efKAMANSl
         OgM5ZIIbMfps6zbb+Nwc2BtXc2Zm8xgvAH54eHwfaEbxyQpPpTDyXBzaWiJSF2aCracW
         xR6XmR+DKoAWiYdfOOyzqd6SZVWPA4R4a9OC5sERNCMqeEfh+Oaa3W7YVCt8TI8DBMAD
         YIGzz/nhUJP6PAyABOHU+lyEIUHxcHlDh5GgscdytAchgapMvmOCyog3GBfecRw7LcLq
         S+GdAEU7pjkgMedV5OcCcgxv8HYwZWjpoNKtbtM3id7Ih2Lu5u4rChtXsT7Njct4EnI9
         ptrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690862; x=1781295662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd7mNB6n7oWwOEumxuPNE7buAh5DJvMLtPzxh9rFWLE=;
        b=p1bn+jxTfav3tCj5J4qp+DjSpul+JwZpS06am4mDXTHd3JSQCjXu5lpdE/CMjZOfkh
         o/iHu+9ihDvrX8FL86df9u/pXD/qCQWiDzSGqnHTTLmB8eSG9UGEDPajmMOYonSJnAKE
         pp7ZP3XzXV51/PMakBm3yJMhxYENhIfCJ+2jQwzS7x9XNR7L/d0ti77MJKIUZCC8acxk
         dZdDnvCvLRHh7OpP/DeF/4OfVH1rai90cgKb48tN84Lqo3v3rx+ZOT2/fBK199axT2On
         PP+jiFWxmJnlXL8xEHnvEFgymgLMzvwBtoisYsreGRio5n48kijRvGNKcYudzPHcFDhA
         IDFQ==
X-Gm-Message-State: AOJu0Yw+HH+j+5FXIZgxpDObMgPbVi598wxmIO7H8zs/a9LJiNyHZn9y
	2CWi8eMRwioMrbjhO+KO+c7KVK4Ci1SJsO0r87TDntxIdw8Ie3fWAYsNEvXW7Q==
X-Gm-Gg: Acq92OG96yj5VKO6p51pxIsoGGtY+S4qibQ8k2iKMpuj5q+VK7Ntnn72rSDR7k1j5a3
	/raD1N+KfIOCTeD695qcyX6qg4dmrWpWQDaOIKx7DJWbQvGlxO16g7bB2oBxIIt004n5c2qTLMe
	msA1BMEsIJeBimCQ19/e+R1G4HTiZjbzsMu8PEl4GbJvzrUsXR7oKgrreEjcoD678AwJDy80237
	mie3bftE292HBHnKTcagN2EB6V2kk63aUYcYKbJPQ2z3JKv7uzLccK+c+jGuNwCzhWuVZMmmaYm
	H5HC+OeQTx5ZpunvduA55cqYoqevyARrjJFnA8kCOVMdFoNXWVFhxVuCqzwTpVPrZh8OYc0qlzK
	p9xrIwn8V/ibcHZDBTTtH5LYtYffbSZNTKMQ3Onb66ci389ktlC6DmXLEwRrX5FvYhGeA9aD8zr
	8L+x2Htd2JJWglG7Bx31usi0k=
X-Received: by 2002:a05:6a00:ab83:b0:842:2280:538f with SMTP id d2e1a72fcca58-842b0e74b30mr5280524b3a.16.1780690861026;
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828821d0sm9956779b3a.28.2026.06.05.13.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:21:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/5] bpf: Remove WARN_ON_ONCE in check_ids()
Date: Fri,  5 Jun 2026 13:20:55 -0700
Message-ID: <20260605202056.1780352-5-ameryhung@gmail.com>
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

check_ids() warned when it ran out of idmap slots, assuming this was
impossible because the slots are bounded by the number of registers and
stack slots. That assumption no longer holds: referenced dynptrs acquire
an intermediate reference that lives in refs[] but is not backed by any
register or stack slot [0], so a program can accumulate more reference
ids than the idmap can hold and exhaust it.

Exhaustion is fine for verification correctness. check_ids() already
returns false, which makes the states compare as not equivalent and
prevents unsound pruning. The only effect of the WARN_ON_ONCE() is log
noise, or a panic under panic_on_warn. Drop the warning and keep
returning false.

[0] 308c7a0ae885 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/states.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 06d9ae24f006..32f346ce3ffc 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -343,8 +343,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
 		return true;
 	}
 
-	/* We ran out of idmap slots, which should be impossible */
-	WARN_ON_ONCE(1);
+	/*
+	 * idmap slots are bounded by the number of registers and stack slots.
+	 * Since referenced dynptrs acquire intermediate references that do
+	 * not live in either, so the map can be exhausted. Since it is unlikely,
+	 * fail the verification by treating the states as not equivalent.
+	 */
 	return false;
 }
 
-- 
2.53.0-Meta

