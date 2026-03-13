Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEF3C3C1D
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442476; cv=none; b=lh4QpPpj0QgrNMQS8byTqUz9+psbHX2A4WG8XgeaXlUJdkA8JRArMVCRTxyzOKVN/WbFxyI3D521eEE3WBzvLS42y0Nn0eWYoPqt/E3f8+z+Ndj9EhyE1Hb+5Jq0U2celp118Zbz9sb0R5eXecup7iwXE6YBYXsLvHssi0jJJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442476; c=relaxed/simple;
	bh=nxjDQ0m1sS5TWNfbSTXWs9A0hdSulvyroBCkJW86rII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQUEv+dQ97m74rIxliBcbc3V+FWnBhZYbg3pa+dt2hfzJ4WladM98RxXD2HrF5ADzHTVLYrdDHRvDaSWKgKi7AeWa/6O7fhRRqb+dmV3hZq14frOGx4d6RdMtxYIuApgOBxPnOC146H6onPQppyYUR6oRXXDDnZp5PpeCEJipEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFAWr9i0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFAWr9i0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48540355459so23863735e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442473; x=1774047273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y21EwQ+fvODC2ellwZavyelMqod8Zg41vsOyUK7dkHM=;
        b=MFAWr9i0LT8trEmi1osuwQGA43m6ZhUS7X2RWSoJev3/JzI0X0ET3D7d90Zb0h2a5m
         vgaWj04M/JAMHTcCIhgJUBP7dNftYlyO7HYpRwY+OAz3UOuAtVN0ypdQKJc3pACl17nQ
         cUSXgZdw2bD8CZtHd73yYndrF13O5JrSQnWWn2Oy7RyKoAfRPH2Lyu/ABXw9I1sf4TUx
         c/v/u/D/7ihGaNzPw88fxhoXSDPTUMiPwrWWfu1fdkBsOjWW2qM+jgEPP/OprcazqENL
         VV/5+ZuIqwSkIn7MH8uUzncOKRODF+NO6hO69woJxtmx2+jGn1FD7QBILT8lNBZJttoS
         UDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442473; x=1774047273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y21EwQ+fvODC2ellwZavyelMqod8Zg41vsOyUK7dkHM=;
        b=Uyrpwlz/935WhWlaP52Waq27d0LCVDOx68ywiGhfMNDyyrPgCiO0UY+10gg5CgE0c9
         k+ddfr7fw2IiEnifhXOTsBoHMXaKMc4EvjlI/+1xko/0DzyoWrvs7JAVAbxRhyAU651F
         yQy/7orWzHXoFHIAjlUXt7xoUmmiTeplFSFK7gqcH/fVHrJWw9MmS78m6qS1/MtzMHaV
         uGoupCkBBuX92gK+JTAkExIgbezAtATLyrtM2wFLghC7ULIxiV+T/r0uWsSqs8QlnwT9
         vo4C6SlA20oQQgRHefYKiQYrem/R4MttyIFsLsvMM3/pCVLXCXMiHUJnN5OVA4rsKYDX
         rCaw==
X-Gm-Message-State: AOJu0Yz8r92qUw9iLvCKQaomUO6m8bPLa3asU8e668Ay90FBVlJz1+fA
	g8nQVYuBTE63xwrpP7y40aal1DrnlaiuAAXibAxpAzM0S2SBKv8LKYXxg137oA==
X-Gm-Gg: ATEYQzyC1pgozGpKo7TmHF04wU7+av1hmkfpSQS5wYi3bQtiacjp8S4OjVcNn7+sVJQ
	92cBiVM6JyK+DncQGzFV1tCSIMq0unt+Urn8jJRdjsTsybfuxiakAw6qiyQLfauDPUyDx74g9/w
	2yGZqPFPY6NCVLT+3Gcpruci5cM+QxsE42DTtF2P0pz82WVhbuF+GtkhRgXQetBP6CGfByt0Q+H
	y3/yK5d5PQLZuoMPDEHdQMbD9d742YMNtysgwIbNHV+1U5rC4QAQkc1ijZlqTjfbJLuystsBT9B
	jQM5/Wq+DNHXGGBc0oLLx450pMIoOhkAwWeI0A2XjH5B9IrEFLMEruEa+et7Hmkzk/cjrjjXr+p
	FdrAN4ktRzZEQiHHSVy6FcpgcPdbY/XFW7RdvViQrwH2fHRcPC2E7Ag+oAP280kSXJDl6+Y3HAW
	4VnQGZ2IHMWqd/umWQkWP+zk5vd3YXgNL+pCTJ0v29h1/ScUbmrCJUgu3shyBVfSWsSUeuP2Axq
	a8msg3UQk8imH/KhrIcVIjN4Ys23yDdSb6a8L8uKb7WBkUT8t1407RyUxZi/LvoNbWj5ZI12hqv
	EjoE9wFxYB8=
X-Received: by 2002:a05:600c:1f16:b0:485:3471:cffb with SMTP id 5b1f17b1804b1-485566e2401mr82975565e9.15.1773442472943;
        Fri, 13 Mar 2026 15:54:32 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b65fd3dsm237867215e9.10.2026.03.13.15.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:54:32 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:54:30 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 1/4] bpf: Refactor reg_bounds_sanity_check
Message-ID: <14685719219430e8d82b95f5f929428032f0c08e.1773441432.git.paul.chaignon@gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773441432.git.paul.chaignon@gmail.com>

From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>

This commit refactors reg_bounds_sanity_check to factor out the logic
that performs the sanity check from the logic that does the reporting.

Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
---
 kernel/bpf/verifier.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fbacd2149cd..974305ef3210 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2798,40 +2798,60 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	__update_reg_bounds(reg);
 }
 
-static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
-				   struct bpf_reg_state *reg, const char *ctx)
+static bool range_bounds_violation(struct bpf_reg_state *reg)
 {
-	const char *msg;
-
-	if (reg->umin_value > reg->umax_value ||
-	    reg->smin_value > reg->smax_value ||
-	    reg->u32_min_value > reg->u32_max_value ||
-	    reg->s32_min_value > reg->s32_max_value) {
-		    msg = "range bounds violation";
-		    goto out;
-	}
+	return (reg->umin_value > reg->umax_value || reg->smin_value > reg->smax_value ||
+		reg->u32_min_value > reg->u32_max_value ||
+		reg->s32_min_value > reg->s32_max_value);
+}
 
+static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
+{
 	if (tnum_is_const(reg->var_off)) {
 		u64 uval = reg->var_off.value;
 		s64 sval = (s64)uval;
 
 		if (reg->umin_value != uval || reg->umax_value != uval ||
 		    reg->smin_value != sval || reg->smax_value != sval) {
-			msg = "const tnum out of sync with range bounds";
-			goto out;
+			return true;
 		}
 	}
+	return false;
+}
 
+static bool const_subreg_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state *reg)
+{
 	if (tnum_subreg_is_const(reg->var_off)) {
 		u32 uval32 = tnum_subreg(reg->var_off).value;
 		s32 sval32 = (s32)uval32;
 
 		if (reg->u32_min_value != uval32 || reg->u32_max_value != uval32 ||
 		    reg->s32_min_value != sval32 || reg->s32_max_value != sval32) {
-			msg = "const subreg tnum out of sync with range bounds";
-			goto out;
+			return true;
 		}
 	}
+	return false;
+}
+
+static int reg_bounds_sanity_check(struct bpf_verifier_env *env,
+				   struct bpf_reg_state *reg, const char *ctx)
+{
+	const char *msg;
+
+	if (range_bounds_violation(reg)) {
+		msg = "range bounds violation";
+		goto out;
+	}
+
+	if (const_tnum_out_of_sync_with_range_bounds(reg)) {
+		msg = "const tnum out of sync with range bounds";
+		goto out;
+	}
+
+	if (const_subreg_tnum_out_of_sync_with_range_bounds(reg)) {
+		msg = "const subreg tnum out of sync with range bounds";
+		goto out;
+	}
 
 	return 0;
 out:
-- 
2.43.0

