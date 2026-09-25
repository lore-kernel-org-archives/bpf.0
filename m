Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F204F30F6
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370782; cv=none; b=nyMpjNWE5piwSE9T1CBRd8UGJhuM71oiMe9VmD9ugeVqzbxyi8t3raeQw18ip4ekGHYh0kRHl4DMzXHtQczFrl92ALXZXAw1+3dqXXWMmUeD/5oMbMaEoWfBH0K4VuOVdJiThtTkUe3FI6pzdm9E9zgeN7aXxRJnPvGnIIL2uN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370782; c=relaxed/simple;
	bh=2ZwsvvB+fOxurFUiXXRm0OzMPZGMgoNWgQNM2prf3rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coimch2LoUKjdAmEYV9kPGBOzyw2rldZ2aWqkpaeQdgQMLjx9dx1+YUEySxnIFX6kYgg58dm5Sg7uQopYBJ7IDzpYqMbHhnbo35XdZBTlBrtdbcu/rqS5OvjG7pOobEASecbrdoi1VLvsV7AdsBK7k/VE9TJ0A2wYwCFAx2B55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUuOmOMV; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUuOmOMV"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-7f4f0d298caso842897a34.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370780; x=1790975580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gio/95fZZHMvIwd/MRJCmouE8c9vEOI8tHuHIes00nc=;
        b=QUuOmOMV+QVQVG36hrOAsURXfueqCyr747lA1IsubT/QcSdzoF+qFXuBX3JL1Med4F
         PHoev//StMrNbSkI80YxFKH9vjfcguZnw1XY61RqnDOb+g60HXaB/1hOFEnOcWvipr3b
         LJzICV67XAjZR93sbe+OXc5SqBnob8FuV3O2TSnwrDFZLAYT1pZ+Px5bE/ZZ8zUYqhMt
         //3ItlcGm3W3VZU5F3bH0+aJUPV/Xs2HXzQcdyPEpZjvl39aSBNg1w5lTq75xYi5YCny
         TskAMxVoX06opxOSrzfxHUjdgFB8f7LJHjJlA4CxX1qStXqpfA3PXDrdxFVsEeNjAVu6
         ldLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370780; x=1790975580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gio/95fZZHMvIwd/MRJCmouE8c9vEOI8tHuHIes00nc=;
        b=n2cYfkkl5Sr/oYFAql6lKOCo2JCw3Pzepuekgf1lFYcK4qKwrgSB7rV50Z5FZKKCKq
         gWdrhZQS2aPlWxU2IgLoEcKctPpdwHAqnmI0y8iTNniciKmaSdZMxE5WF8nbL36ABLQF
         dzyQtqWrQNIejAFX3tKSQ5uBX1Prt8Bdgo0puKR11JxNVxp4tN1I2bOqSyWKJhhR8PXq
         qkITfzZHula79l1diU4xbubMx1oYo/BGSN9FtPP7Dyfzb2CnY9BfuzComBRpl1LtFxmI
         zIaTUCYFXCyWjtHQBNGhqqlZvAUScOeEuAe+w/vpBpaEtZrE5eSuWXhDheAdBNHrsm67
         SJXw==
X-Gm-Message-State: AFuF++m17K9qulWBiRB40qCGP0SsFwHsNumhhS5+4Gp3evwcFY18wTFk
	RIzP02J4Du8Yh5VTU0QjDRnoc8GJppfKoHYQm6O8I8q8fEclcRxfopa0D9GQQg==
X-Gm-Gg: AYBFou058ajlTrcwp8rHK5vEy/s+QuC7aN+GyCJAZoze2tbIBqyr4issIDwkvEp6EJr
	X3DrDt3yK5+ws1/S2aG4JzECWpTLsHIn9ujl1rg4eP0MWPt7v/4X9VTUyUI6iXMOMb1IT2IcSnP
	0C5vH4L1jLb1tm1V4GqUC35SEUhOC/LgfyEwDbyBDSTCcEz9+1uzgX1u8/cMfK2JyGS199cnnBf
	He/+yd/7syXvifachfSx9baLPKhUH60WwQ/MkeJf1NkzQEDYUo3qc3MGR5dA8RTW26d9AAubp7k
	C1vUqWGa4YD0DVm3PmfTQ6e+Xi7zzHJ4sgaImwKrDm+5K6uleltTZrHPSxzT6hGM+RkVTTPqSzL
	4aTP2iptu/SJe08y2B+/4hCnxeQv19/6+o+y8TyGWPjr6+3TDfQIAOM4fWytslPM9j86EaHn/Kd
	CZv2ToxGUm5kduuBucjRfa4gYqr5fw2EVta0kVlgdKaLoX3yqOtzQRv5tP8qChRg==
X-Received: by 2002:a05:6830:3e01:b0:7e9:5022:3639 with SMTP id 46e09a7af769-81782989d63mr7610631a34.15.1790370779837;
        Fri, 25 Sep 2026 14:12:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:16::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-819471d2bdbsm2325402a34.13.2026.09.25.14.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:12:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/12] bpf: Fix kfunc nullability diagnostics after wide arguments
Date: Fri, 25 Sep 2026 14:12:45 -0700
Message-ID: <20260925211256.1834061-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_func_arg_nullability() indexes a kfunc BTF parameter using the ABI
slot number. The parameter and slot indexes diverge after a by-value
argument wider than one eightbyte, so a later NULL pointer is diagnosed
with an unrelated BTF type or an invalid type ID.

check_func_arg() already tracks the BTF parameter and ABI slot
separately. Pass the parameter index to check_func_arg_nullability() and
use it for the BTF lookup.

Fixes: ae6abae582b7 ("bpf: Recognize by-value struct and __int128 kfunc arguments")

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c8626215ee6..2792dcf91061 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8919,7 +8919,7 @@ __printf(6, 7) static void bpf_diag_call_arg_fmt(struct bpf_verifier_env *env, u
 }
 
 static int check_func_arg_nullability(struct bpf_verifier_env *env,
-				      struct bpf_reg_state *reg, argno_t argno,
+				      struct bpf_reg_state *reg, u32 arg, argno_t argno,
 				      enum bpf_arg_type arg_type,
 				      struct bpf_call_arg_meta *meta, int insn_idx)
 {
@@ -8932,7 +8932,7 @@ static int check_func_arg_nullability(struct bpf_verifier_env *env,
 	if (meta->btf) {
 		u32 arg_btf_id;
 
-		arg_btf_id = btf_params(meta->func_proto)[arg_idx_from_argno(argno)].type;
+		arg_btf_id = btf_params(meta->func_proto)[arg].type;
 		expected_type = bpf_diag_fmt(env, "value of type %s",
 					     bpf_diag_fmt_btf_type(env, meta->btf, arg_btf_id));
 	}
@@ -9412,7 +9412,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		return 0;
 	}
 
-	err = check_func_arg_nullability(env, reg, argno, arg_type, meta, insn_idx);
+	err = check_func_arg_nullability(env, reg, arg, argno, arg_type, meta, insn_idx);
 	if (err)
 		return err;
 
-- 
2.52.0

