Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44653EF66F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142505; cv=none; b=BHBnhN4Ozp/XMOpm87OeSkxg+hpJ/DEX/d0R7L6tos0jVdnG++o8oO/4qFbpHXbuOxP2KfsreeWI4K+ynI+X+eHbwSul4QYp0rjbeFhrycoFhr6VTdrhFcYv0e30IHSqOfng231Ai5XkKkiOP4u2LoZbrcH4dEGTxmpXZ3kxzB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142505; c=relaxed/simple;
	bh=RCw8xATC+7MD+xbauFeJo6vdKyzpH8aW7WDFwmJ91ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFPLZUky54899RAaLGWKE/Bky54z/3mhS/wixEmDvK8AKModI9suwAgGerWWyjYYNoTC+4jr73ZZgFijM3HCVdSuQtRg20FhPTRMNOPdVIbH22AzzZY6V2rAxPWvPKLNQsN5XkcH3a1KzljxlhlSqWo8s9XDHNJGy6Cfe3tBy1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7MK+Rdo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7MK+Rdo"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso2121785e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142502; x=1775747302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6VVEaQuMuplEPKGBhjVlyrQzNmvyNUy3IUy8sz1X8o=;
        b=S7MK+RdozML48AyIyL8vIbMGKyCTzoCXa4GvunSbP6qzKDhfWIPzViuciB1gMsmO7J
         fuHpjFgAvpdS0jBo31PAr0OEJXl5FZyoUKKg5FNJPd9ki6QQ0T2Xp34YgTFMiSlRiqXm
         grmWWq75dBRDt6J1jN6VRcmbRE8SKdYIDl+cOgU0Hejz12bylADZSOQ6xabDuZBKIooM
         K+MSKN5LIh+8RYisI004060ojCDjmqQHZWbUXlRo/GURPbZ4krDT1TWlrhOY3SFd/qhO
         NciTLcnD97xJq3gEvlRlJzULgfP9CA7nZMy5Ii9+Fsj61pdcORhY8wX51PhUvUcPw64+
         cELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142502; x=1775747302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6VVEaQuMuplEPKGBhjVlyrQzNmvyNUy3IUy8sz1X8o=;
        b=il+WtQRnkyqT06Pv4ISDJTQvGmB1oOM6Sz6pglk3HDiqoJPFlFI4NLKpj1vlTrwobl
         MA4KIAmA6TXzBLCTGvEMXV6nrIp92QL6LCUaORMvzBDWpZr9ET4vb/2QQn/C3ZXGuTxV
         SOWYfoVComcXdeGxowDlesvimEXXPgyO5C86tj8SPVXUjv8Qoyxcc+MaTm7U8BxmH9IX
         mrXZ+CYdsD3A8dLU/Ehzv/kGnxhBkAK1JQea6Sb0fP/Xw+Qh++W7x9JZQYptn45qajIu
         GQOLd1dAJfft7paZy06uYDuOmLi5vr9KvmtRWGlJiUrZv5sJSKZQ1RbX9JICKKsHjHgo
         /ZmQ==
X-Gm-Message-State: AOJu0YzqBbbRw1jKhLbdqyhOiBvFhlROvNe+5pxwyEh5kNshKfj4YLKG
	mOta+mLYlWDgqrHLi/QWJ7Mx5wHt/uYWQMBI5bDSKYsAATTyigI5Z8L43FehIcNp
X-Gm-Gg: ATEYQzywWS6BZQL7/QhznK9Ua4CPwssjePmcNGaKAWICLzUuypbsqj43fJGrojL5IdH
	u96ZDG5O+xoSQcGd4OpbxmG0LgDmkcDBfro2KxAAUq6HuMjLZCFjcu23IJ4MUWcLmsQflakQsnM
	ddLzQG9bGhRGv0gj1VUlNFqqrt6ui5PI8NA0WoA/8KS2Yfzfe9CmhTtnRYrp30cP/BX9jOChsf/
	gCug8ocQ7jQjeXnPuL+wXpTjy8znZW518k/yJfhUK8U6f0vOfGIuiv4Vy5QaXWRjFSJ/dsxsR0f
	vBmBo4bCtiEEWBU0a99FHeaZ7XfLzbJTsMLG3wKFsiFpSUbz30gLRGTQbc6C833eoUWlutaqA1F
	OP86+Ib20qO0pJj68cDfvc/aiW3xBOOUTHVK3WSA+mNqvth9rxPkzhnZyMX66JzSlbUM6iDg79P
	a8jUVHig6ON3jHfbR96ECn2wXzQQtIUn0oyReikNyDgLYMYSGpSL0vEPakys76n4xxRH0M/NJkW
	wDTFYbII+mRguzAQXCmZoIK4E8kAa1j/v8BxkZLgtBPNpS/BBcPmFGbphyy4IBNrM6IRNuHy8UO
	7vzVfTKyEVKGuYVecBrGciEjA6BHtBCasmPg939FCuM=
X-Received: by 2002:a05:600c:46d3:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-4888355e820mr138138595e9.6.1775142501932;
        Thu, 02 Apr 2026 08:08:21 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm226069165e9.4.2026.04.02.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:08:21 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:08:19 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 1/6] bpf: Refactor reg_bounds_sanity_check
Message-ID: <198ec3e69343e2c46dc9cbe2b1bc9be9ae2df5bd.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775142354.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This commit refactors reg_bounds_sanity_check to factor out the logic
that performs the sanity check from the logic that does the reporting.

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 64 +++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..760cd137bf3f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2804,39 +2804,55 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	__update_reg_bounds(reg);
 }
 
+static bool range_bounds_violation(struct bpf_reg_state *reg)
+{
+	return (reg->umin_value > reg->umax_value || reg->smin_value > reg->smax_value ||
+		reg->u32_min_value > reg->u32_max_value ||
+		reg->s32_min_value > reg->s32_max_value);
+}
+
+static bool const_tnum_range_mismatch(struct bpf_reg_state *reg)
+{
+	u64 uval = reg->var_off.value;
+	s64 sval = (s64)uval;
+
+	if (!tnum_is_const(reg->var_off))
+		return false;
+
+	return reg->umin_value != uval || reg->umax_value != uval ||
+	       reg->smin_value != sval || reg->smax_value != sval;
+}
+
+static bool const_tnum_range_mismatch_32(struct bpf_reg_state *reg)
+{
+	u32 uval32 = tnum_subreg(reg->var_off).value;
+	s32 sval32 = (s32)uval32;
+
+	if (!tnum_subreg_is_const(reg->var_off))
+		return false;
+
+	return reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
+	       reg->s32_min_value != sval32 || reg->s32_max_value != sval32;
+}
+
 static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *reg, const char *ctx)
 {
 	const char *msg;
 
-	if (reg->umin_value > reg->umax_value ||
-	    reg->smin_value > reg->smax_value ||
-	    reg->u32_min_value > reg->u32_max_value ||
-	    reg->s32_min_value > reg->s32_max_value) {
-		    msg = "range bounds violation";
-		    goto out;
+	if (range_bounds_violation(reg)) {
+		msg = "range bounds violation";
+		goto out;
 	}
 
-	if (tnum_is_const(reg->var_off)) {
-		u64 uval = reg->var_off.value;
-		s64 sval = (s64)uval;
-
-		if (reg->umin_value != uval || reg->umax_value != uval ||
-		    reg->smin_value != sval || reg->smax_value != sval) {
-			msg = "const tnum out of sync with range bounds";
-			goto out;
-		}
+	if (const_tnum_range_mismatch(reg)) {
+		msg = "const tnum out of sync with range bounds";
+		goto out;
 	}
 
-	if (tnum_subreg_is_const(reg->var_off)) {
-		u32 uval32 = tnum_subreg(reg->var_off).value;
-		s32 sval32 = (s32)uval32;
-
-		if (reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
-		    reg->s32_min_value != sval32 || reg->s32_max_value != sval32) {
-			msg = "const subreg tnum out of sync with range bounds";
-			goto out;
-		}
+	if (const_tnum_range_mismatch_32(reg)) {
+		msg = "const subreg tnum out of sync with range bounds";
+		goto out;
 	}
 
 	return 0;
-- 
2.43.0

