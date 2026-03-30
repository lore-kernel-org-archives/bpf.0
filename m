Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3E23C3437
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873081; cv=none; b=otgk8PBddUvufKLgk5ewq0xfwGS2Djp1lW5kKQxM6dcoc7aVcKmltSv+BMP/5C/bSU3/jrFBQcWBMDulSLPJclE2HKOk491CsBzJlAkZzU+1dJuSFcbFjlcT2sidbQNd7qoVNT8yirN6nFAz9VKJWke/uqla4QmuEUynmLATDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873081; c=relaxed/simple;
	bh=HKP1+unkmlsUXuZbvqKdy3bzckwvgDpC2yh+SeHXOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feyFc69vi2u72qxaY0N4aKTnO29o2ro+22X+5xfPiEg6I1YfRDmRROfXBJWYkPKg4HOyDgf/yuc7/cbAPaE+5zMAIFgJGWyJEQ3MAYAmGAOyiy0Gu10Ud/LI+DDfC8mtq5wp61zY63nJwXXyMW8AHCPQgd//fUnnHRO0n8v5RU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2ztSMxF; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2ztSMxF"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12776bebe9fso412008c88.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774873079; x=1775477879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jZtJUBFKT2xiUVosjATVKuQj4x9H6qJm82elkbbuJNI=;
        b=T2ztSMxFOpGv/B4Nm1G4qzLsqLWpLfiWpu7Gq6CVACS+oPWt8gKYC8vt+O1bVZuLki
         DmyZvru3mEJDVLEgIvNiF2TsVLg8xEZobhdHpHzmTOxagRuqiVqxbuwMpdn2u8cjAwgo
         WfAfHLxgS4Rd6axbM13Ju9Ceo+8TBBOwB7vaSdAZUZiXL32oo34Egx/xTDl4IHhBKEqL
         yMracCYeUI4OJg3mNqQ6qq6drRbausxWiKPWkgFN2k5J+3y4JiIXqPDvQ1S/1FNqgBXI
         0iIhsTP8wTyRJBmyki5iSDLk0d3KvMvWxTVR3+23A9GruOITjJAlY67TDxSUeV95sRu5
         RrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774873079; x=1775477879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZtJUBFKT2xiUVosjATVKuQj4x9H6qJm82elkbbuJNI=;
        b=hw3mDfftytshA+uyUdmwwiHBNmtB4UAi79vXgsCWRB7ixDHGeaVy/XeonOthvgSRYC
         Lac2gFcUGX0R8k3V3dyH4Bkl2xyTINAT1lAUPtYMAlLs0n2Ww1s/MMLTBDNGlphBk8i0
         JW7hnG0JP0sg3sJnsW4OmY+3sQlWJ83XF9XYXeM1W09Y49g7U1f+NsDCzbpgVLbIf/aB
         x6WicVOTnmP0lRLsmiyV4BmURv8D1zjAF2nz+6fxBBwTuoZSZpY2/UuWst/i8YuQLk0n
         MVNBh0YBtvajJCWHkE1T1TGky6THa+Lq2WbQa2cn/2KwDBgpF96nJi4jJ4DsxLC4lgRb
         /T9w==
X-Gm-Message-State: AOJu0YxpMDsGE805bvEQVVRvrg10ENl4VMd4cSCygkKvLcxux1GQOxJE
	SIf0IN8nSBXG9+qrW+cSkfknlLZd89av+Ajt2pha2SdooodY2LE+MA3X
X-Gm-Gg: ATEYQzxOx6lnBnbU/K0CZMGbYpAze9bBa0t4iGUEl3224sp6lhZ2I77xA0vhDAHRfHz
	uZ2YUW2bCNaD/Ny5KOTmpnQ7kfiwD61PnedrrCpo0yT3U5p3u7PCSoH4AfyFVTChudazkGrd0o+
	gMAJohbLaF7JcO3tvQXejCRGjImBrNbyRtLsGuodEjUcZhvdP9hswrczVJd2OJfgE8kmBFGGrd5
	bMjtFHMnTDBkGtHCpzVxI1Q9ms+pkfsc0BkmrGj8bq/161Hlg4uA3Zad/MbRNhhArs2bOXSKbQD
	VRi+Zmi6nyIpVKiFPRyBPxsXPusiI2HQwpwChStJiQ7XKIB3W9ThjOzhQYeGXP/+BA7+rjPPJl6
	lp0CBXOXaeiJyNOau9tfFBI7OfXhGBhc3kECR8VlIzXm1V+UAK7KTTSFKp/26F0W+iFqx15yVVp
	PT5w7QEtj1ef6rXoPU91k=
X-Received: by 2002:a05:7022:ea30:b0:128:d7a7:5261 with SMTP id a92af1059eb24-12ab28eba7bmr7986482c88.30.1774873079115;
        Mon, 30 Mar 2026 05:17:59 -0700 (PDT)
Received: from animal.. ([104.35.26.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm7623128c88.0.2026.03.30.05.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:17:58 -0700 (PDT)
From: Eyal Birger <eyal.birger@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	paul.chaignon@gmail.com,
	chen.dylane@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	tklauser@distanz.ch,
	shmulik.ladkani@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH bpf-next] bpf: warn against BPF_RB_NO_WAKEUP in bpf_ringbuf_discard()
Date: Mon, 30 Mar 2026 05:17:32 -0700
Message-ID: <20260330121732.1601352-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that BPF_RB_NO_WAKEUP is not recommended for
bpf_ringbuf_discard().

A discard done with BPF_RB_NO_WAKEUP can suppress a later adaptive
wakeup from a valid record, leaving an epoll-based userspace consumer
asleep even though data is available in the ring buffer.

Scenario:

epoll_wait(rb_fd);                     // blocks

rec = bpf_ringbuf_reserve(&rb, ...);
bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);

rec = bpf_ringbuf_reserve(&rb, ...);
bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup

This behavior is surprising in the context of bpf_ringbuf_discard()
as it seems natural not to want to wake userspace.

Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
 include/uapi/linux/bpf.h       | 3 ++-
 tools/include/uapi/linux/bpf.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..c46b06d45904 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4645,7 +4645,8 @@ union bpf_attr {
  * 	Description
  * 		Discard reserved ring buffer sample, pointed to by *data*.
  * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
- * 		of new data availability is sent.
+ * 		of new data availability is sent, which is not recommended as
+ * 		it can suppress a later adaptive wakeup from a subsequent submit.
  * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
  * 		of new data availability is sent unconditionally.
  * 		If **0** is specified in *flags*, an adaptive notification
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..96de37c3b896 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4645,7 +4645,8 @@ union bpf_attr {
  * 	Description
  * 		Discard reserved ring buffer sample, pointed to by *data*.
  * 		If **BPF_RB_NO_WAKEUP** is specified in *flags*, no notification
- * 		of new data availability is sent.
+ * 		of new data availability is sent, which is not recommended as
+ * 		it can suppress a later adaptive wakeup from a subsequent submit.
  * 		If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, notification
  * 		of new data availability is sent unconditionally.
  * 		If **0** is specified in *flags*, an adaptive notification
-- 
2.43.0

