Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D637FF7B
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402055; cv=none; b=ifz1VE0m/6XMGPha4ZBQ7V7EDqqhfOKL9JVbb0ggFt328aPDZNkMT4ug81QpC5cFBUMeOa+Q7zYLcVV+D2Fmsba3Tn7APcHxEUZefUBJvNogwP+8EvNk5BKxZkE90B4c45h0pDSrf+wVu1EO+hmX5iP1ElcHSLmV3ivAEAoJLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402055; c=relaxed/simple;
	bh=tWYxBVmt7uIUcLdAu7+FUd0nXB0ImxLcR6S1CX+FSjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGWSGUL1PpNydHqcmOLEkWQemDs06GebLuojPXuse6NU5GcyXl/ADLB2k5M1Xm0C80DCq9iKRla7YQhwGLXivX7wRc6TKMSMCMQYmXR/89u2GnPNMIiiHf4/B4f53e+kL03VfTxSvDVnwX0NyFKhyCJ52dVaCTItaaoBfxGeKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z23IcSHv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z23IcSHv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso18521795e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773402052; x=1774006852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a434r2mRNzR+I4ONB+VDwldgDYLMkwKVMwLv5ig/aSI=;
        b=Z23IcSHvmABfVD3VlNXCgR74AkyYvYtFoWpXNPnNSifnvK2YlER15+/leTXtnt0f7l
         bjA6bjHVzEPGLN0Aj8fsOb9RFPilJUcPhMJHlAxdj76x4q0J3KqrIHEisXzet7ttI+XJ
         mtB9b90NQZI+kSwp2FNr7t/y89xx/Si7bIvgcjw5+Yo7rUAvapX5gNzrkzoTTyM6Q86Q
         OARpaBk9AkIvXb3wHZaLfmgILprBmlaaTxoDGlxSoraoGRm6k2ERQ3+eeP1lzoRrvLJt
         auGjt6QsFYqxFnR/LEQy1N3J/gcoLwodnmwMBiuxlcCIPkGzaDaVjH0AXn7SLBDl0rM9
         bXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402052; x=1774006852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a434r2mRNzR+I4ONB+VDwldgDYLMkwKVMwLv5ig/aSI=;
        b=aANSkYKhsmWyO2N5Wjn4v62xJj9CEPWphAG0tpXHaI9iVuj0CcCXWhS+Bb05swn5mf
         X/jh58gLGKkji7g8/swk6zzP74mOEunHVToG9R3xuyqcX1QYa/x/6Udx4yCfWTUBod6X
         XdoBS1Ua/uvPOGgCM/SXGW5WGFp8MRYG902atK8Kr1RhrU6XP/5oApPxsrY3Z6DIpxEP
         BsdrbXyWzfme+UXY38FcgBfRtxFh//1pqDh2eP2mbxpDS52wTTg2ui6DbC6NLUHgg2p1
         xTkD2fOr3hSRNm4Ko15U4U0CgrpX9ABBkODBbk6M/bUOIyGXsBIOqfEw/WJPMexT+r+B
         qoCw==
X-Gm-Message-State: AOJu0YzomPX7tiW5t9JOQDu0uRDbtOsC5PFwqO14f0jkPhmnxzwM/lZA
	vpjhtHdxhigBz9SXiGIHRhAUjxaZvjdZZx1ulV+/+ttk2e8LqciwFfS1tJTF4gyO
X-Gm-Gg: ATEYQzyrtdGJkuVuG9131LJfidFDJCUrPMK4Fr9Fs2irLDmFDxh+sCOdMGqYQmRqaun
	JuyPYsQxrMCcnD6qJYu5zhCRAdzVcc85xydCzZ+n3yeuOWzx+aABZmH7el0e6+n4c6e8KRCzVAy
	9o9a96zt5+DgDznbZIqMuh75bslrMJtcdGajiexzmyBanrPrvWbL3fH5oXBWanXbPD8+O3LVwl9
	iejNghirw30LEUbXbcxZThnY6jV1l+KDgLScIvEyTwOAg3KZbcc6Kv1NPdPQQggyYbwAhH439ND
	WeVYj/6mGU4opIdUNt0b1XZ3/jdJp1hjD5UnwNZYV0ZfI1cVu/RgEup5QrimKZ9FmTivsBGPjiB
	at+1eImkpK8prcxsepHFpJj1pYm6Vautkpj6CH/74umbdXkbUSAVTomLkEzXhiqb1usrpWCKgvG
	nVgR7ck6J/0vhKYbXA2xkyTJgi//DuGy41zwYvXJlKF+PwcUdleunGVGD+b1VaEPsO+uGyb9LbB
	E3fpja3T5t1CFjPy1J76mDKr9r+yZe6jwZ4UkC+j/zf3MRlYEt+cxQ8B+CQoJJ8HEvqPkBb71YS
	byyzbu7bIkQ9CBtUwnB/sQ==
X-Received: by 2002:a05:600c:6912:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-485566fcb3cmr41060825e9.20.1773402051924;
        Fri, 13 Mar 2026 04:40:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aac28bsm285712385e9.1.2026.03.13.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:40:51 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:40:49 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 2/3] bpf: Avoid one round of bounds deduction
Message-ID: <1b00d2749ec4c774c3ada84e265ac7fda72cfe56.1773401138.git.paul.chaignon@gmail.com>
References: <cover.1773401138.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773401138.git.paul.chaignon@gmail.com>

In commit 5dbb19b16ac49 ("bpf: Add third round of bounds deduction"), I
added a new round of bounds deduction because two rounds were not enough
to converge to a fixed point. This commit slightly refactor the bounds
deduction logic such that two rounds are enough.

In [1], Eduard noticed that after we improved the refinement logic, a
third call to the bounds deduction (__reg_deduce_bounds) was needed to
converge to a fixed point. More specifically, we needed this third call
to improve the s64 range using the s32 range. We added the third call
and postponed a more detailed analysis of the refinement logic.

I've been looking into this more recently. The register refinement
consists of the following calls.

    __update_reg_bounds();
    3 x __reg_deduce_bounds() {
        deduce_bounds_32_from_64();
        deduce_bounds_32_from_32();
        deduce_bounds_64_from_64();
        deduce_bounds_64_from_32();
    };
    __reg_bound_offset();
    __update_reg_bounds();

From this, we can observe that we first improve the 32bit ranges from
the 64bit ranges in deduce_bounds_32_from_64, then improve the 64bit
ranges on their own in deduce_bounds_64_from_64. Intuitively, if we
were to improve the 64bit ranges on their own *before* we use them to
improve the 32bit ranges, we may reach a fixed point earlier.

In a similar manner, using CBMC, Eduard found that it's best to improve
the 32bit ranges on their own *after* we've improve them using the 64bit
ranges. That is, running deduce_bounds_32_from_32 after
deduce_bounds_32_from_64.

These changes allow us to lose one call to __reg_deduce_bounds. Without
this reordering, the test "verifier_bounds/bounds deduction cross sign
boundary, negative overlap" fails when removing one call to
__reg_deduce_bounds. In some cases, this change can even improve
precision a little bit, as illustrated in the new selftest in the next
patch.

As expected, this change didn't have any impact on the number of
instructions processed when running it through the Cilium complexity
test suite [2].

Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 189e951886ed..e29f15419fcb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2767,9 +2767,9 @@ static void deduce_bounds_64_from_32(struct bpf_reg_state *reg)
 
 static void __reg_deduce_bounds(struct bpf_reg_state *reg)
 {
+	deduce_bounds_64_from_64(reg);
 	deduce_bounds_32_from_64(reg);
 	deduce_bounds_32_from_32(reg);
-	deduce_bounds_64_from_64(reg);
 	deduce_bounds_64_from_32(reg);
 }
 
@@ -2793,7 +2793,6 @@ static void reg_bounds_sync(struct bpf_reg_state *reg)
 	/* We might have learned something about the sign bit. */
 	__reg_deduce_bounds(reg);
 	__reg_deduce_bounds(reg);
-	__reg_deduce_bounds(reg);
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(reg);
 	/* Intersecting with the old var_off might have improved our bounds
-- 
2.43.0

