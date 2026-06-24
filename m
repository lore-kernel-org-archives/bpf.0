Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229BF2C326F
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295830; cv=none; b=QQ7/o/5rgO6pX/UteR8Z1fKdU214Q7YG2WLRuuBJEYXwHMo0+Otj9iNboweVax6FjUGiaJCVm1ROJZcsOzreEDW2B6nv10oCv33cPRlhg0JLjdMks5jNn9X3GnadLxHUF3ummLsxy5GvSgwmbFa4KmLWvgHm2E70M+eYOC8Ti80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295830; c=relaxed/simple;
	bh=C0i48AJFrx+9TBAxMDQaJVK5K3MQB4k0YKGqp3WD3J0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f/1id0v2Y6uJxD+Utjby7g7InHLALTbW5FvobcGGVxSp+JuM9ogMnl/wjdiKN4xUzffBpNu3TWxvSHWXYvmrGP2+pyKg1G9rFjY+Otrxdh3eh6TKWki5EcGX+y+VRfi6isbTrKqkWPxaGI61xNRkt9AwOK4KRSVRaN5IokeL26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=cdeaZNDA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="cdeaZNDA"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso758187b3a.2
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1782295828; x=1782900628; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ir2SNXp5/iAagbNPrxSe2VQPiGf6nlMkMiTLXPxTDhI=;
        b=cdeaZNDA2f22JYNibTgnqOrU7+r+ksqJPBn1n1ugjLkU4190FPMdsL0nh0GdV+shw8
         j8vwxs1ePjLenoTvDRW8f+3Zb/IuQyItxe7jU5M7R9F9VNoHfRzy04EeKvCM5s43VPlN
         i+Z8unZYJWNOstQJ3wXz4wQygf/YjN2ZgmJOpRLBRri+LsiI1sBzpJXb4t03X0IaPNrS
         GObuP3CcscXywfQgdw+pIn3kbH67M8pEhRhCfku+46ZEsi8sV/7SJGBEtOSymiuor8B+
         a7Fi56Nrkfx3EUmDmzZur9ZnH5snePlRQ7ExmLlmqBGA3mU89xo6QT6/uJ8FGAsaMp9Y
         0CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782295828; x=1782900628;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ir2SNXp5/iAagbNPrxSe2VQPiGf6nlMkMiTLXPxTDhI=;
        b=GkCaVJVBwJWYTXqMN1HUlT32X7Yajc7/gjdWJ+u+uM46Lc8Xdte+DgLIPSwTKZGrGW
         Pk9dZjbiLqsjQDmYnt9TmUu5i4OgGm91dmrmhoUa1/0t2xeiUjNMJagdsq8KMcuLUHra
         VwG8PIionowA2PjtBuJLyd/93U9Mjxq4AiMFTuB+qJWnYlAntPM52uehTlxxZlagUj/f
         aQ0zc+CsRNjAaqVx2Iyq5C/xFOAmcXBYbYb2D+ckt+8lQGPErK3E9LuAjecnkdEIv6GU
         M+UcDdbppltwjMGCSe/NNiplD+DWrpyvuToS/NLQjv7hDZOELIM3Rtua5yZnEzNl0Lqk
         1PnQ==
X-Gm-Message-State: AOJu0YyVgIGk+SV3UM+tjIvOkg8RBWqSA64/sop3lDr1kMdK4W9uI5EV
	KUG9ix7znvgotuClVmyvuQqvrt1vXsOIHtvP6mDrXCmqI+a0SNBG8+Wx77C/4mPRS3uuYZlCPf7
	15vSH0muhZzY=
X-Gm-Gg: AfdE7cmebaaUjed5254OnPhd5Ya4rYVsqRRMiHykDNVICVGmYQ8l6hL2DBLYDIpKdEa
	SXxaz0ySy0hdoMOgtZdiC0Cph89PxrvOUr5o/I4WLMEFDo4gRkoTk2d1yaPVxnEg4qnlQXTNag7
	g1QKvlW4+11seGxijRkSxmqEc2PVW8lTRmL7PeN2L5PBnFt3NihpnyaS+WsAZ5sVhB7tfRYpf1d
	aVVZFn655JzC6d0p7MZrfdy4Ig8pbtRRxJXkOq1cDGOIf0x0kzuvHdE20iUz4/0WO4+/l6w3nUr
	BkCELThInkVJOEfh2LGt4oqthkRXcN1rIMn7jauBKqVAE25q2Oy3BBLP0oc8Y7bJLURY6aEd5qf
	Xh54OXz/zIHkEM4kNCjPOPjVAJYF84glykBjVL052404BBtb0WkervByWns9Jd2axuL9hx1QYdH
	1PzT2XHcIGDJeAC4ouOvIcczu8Q3haoTSBqi/PQ8gKjrKUzNpBSOFzkkGEQ9A+cxEixQYL3NGY1
	K0U88jvdKYhEw3QB1VQb5MfKKhmYFePZ2wWYydEM+vGMxI/a2SeFXjPtB7fZ3xdXXT/8eHZuEa5
	HFVgeMxRrC0eJmDdK79nqpeNxCCMzTA=
X-Received: by 2002:a05:6a00:18a2:b0:842:5712:c29e with SMTP id d2e1a72fcca58-845a26d1dfcmr3766476b3a.14.1782295827510;
        Wed, 24 Jun 2026 03:10:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2401:4900:1c07:46d8:c117:917c:ea0c:d399])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fcc65csm1777558b3a.6.2026.06.24.03.10.26
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:10:27 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject: [PATCH v2] libbpf: bounds-check float size in btf_dump_float_data()
Date: Wed, 24 Jun 2026 15:40:24 +0530
Message-ID: <178229582410.80761.16669701451820050202@digiscrypt.com>
In-Reply-To:
 <CAEf4BzaxKLJAEaZR7VBjT5N_jeWVJ=bRviP19viGaSGQ=44dRg@mail.gmail.com>
References:
 <CAEf4BzaxKLJAEaZR7VBjT5N_jeWVJ=bRviP19viGaSGQ=44dRg@mail.gmail.com>
X-CodeOps-Marker: 8b29496e426e43a1a3168cd25e04f918
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

libbpf: bounds-check float size in btf_dump_float_data()

btf_dump_float_data() copies t->size bytes from the object being dumped
into a fixed-size on-stack buffer whenever the source data is not
naturally aligned:

	union float_data fl;
	int sz = t->size;
	...
	if (!ptr_is_aligned(d->btf, type_id, data)) {
		memcpy(&fl, data, sz);
		flp = &fl;
	}

sz comes straight from the BTF type and is never bounded.
btf_validate_type() does not validate the size of a BTF_KIND_FLOAT type,
and btf_dump_type_data_check_overflow() only bounds the *source* read
against data_end, not the destination buffer. The switch on sz that
rejects unsupported sizes runs only *after* the memcpy, so a BTF blob
describing a FLOAT larger than the destination smashes the stack before
the size is ever validated.

Validate sz before the copy, mirroring btf_dump_int_data(). Use a fixed
16-byte aligned buffer as the destination rather than union float_data,
whose size is architecture-dependent (sizeof(long double) is 12 on some
32-bit ABIs), so that valid 16-byte long double floats are always
accepted.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
>From 27941d119a3e9815906e787728bac54de9737539 Mon Sep 17 00:00:00 2001
From: Naveed Khan <naveed@digiscrypt.com>
Date: Wed, 24 Jun 2026 15:23:56 +0530
Subject: [PATCH] libbpf: bounds-check float size in btf_dump_float_data()

btf_dump_float_data() copies t->size bytes from the object being dumped
into a fixed-size on-stack buffer whenever the source data is not
naturally aligned:

	union float_data fl;
	int sz = t->size;
	...
	if (!ptr_is_aligned(d->btf, type_id, data)) {
		memcpy(&fl, data, sz);
		flp = &fl;
	}

sz comes straight from the BTF type and is never bounded.
btf_validate_type() does not validate the size of a BTF_KIND_FLOAT type,
and btf_dump_type_data_check_overflow() only bounds the *source* read
against data_end, not the destination buffer. The switch on sz that
rejects unsupported sizes runs only *after* the memcpy, so a BTF blob
describing a FLOAT larger than the destination smashes the stack before
the size is ever validated.

Validate sz before the copy, mirroring btf_dump_int_data(). Use a fixed
16-byte aligned buffer as the destination rather than union float_data,
whose size is architecture-dependent (sizeof(long double) is 12 on some
32-bit ABIs), so that valid 16-byte long double floats are always
accepted.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
 tools/lib/bpf/btf_dump.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cc1ba65bb6..dc26f3a160 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1980,13 +1980,18 @@ static int btf_dump_float_data(struct btf_dump *d,
 			       const void *data)
 {
 	const union float_data *flp = data;
-	union float_data fl;
+	char buf[16] __attribute__((aligned(16)));
 	int sz = t->size;
 
-	/* handle unaligned data; copy to local union */
+	if (sz < 0 || sz > sizeof(buf)) {
+		pr_warn("unexpected size %d for id [%u]\n", sz, type_id);
+		return -EINVAL;
+	}
+
+	/* handle unaligned data; copy to local buffer */
 	if (!ptr_is_aligned(d->btf, type_id, data)) {
-		memcpy(&fl, data, sz);
-		flp = &fl;
+		memcpy(buf, data, sz);
+		flp = (void *)buf;
 	}
 
 	switch (sz) {
-- 
2.52.0
