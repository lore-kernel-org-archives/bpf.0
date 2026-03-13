Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174179CD
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773402192; cv=none; b=oBOP7lNMQTYwkAq/OvK/mpTaimqgldkZpDTJckd8NNk7EZ0nyA/j6XP5gvavhSLV/DL9RIGASsSQs9EX2uZ0KSmTkuZTHT2YWqHd9RXuOgF4NTgVpVZCOSJu0zvgdPxiOwzraBN1xZQvPN7++n9e/GsfvZTxSmkndMfgeouyZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773402192; c=relaxed/simple;
	bh=cTLzwqLuce6s/KaEYrNF72CIARjRevIOt5nVP4quDQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL0M0GznaYvnnQ6kbgev5CTY05YqGz3RBZXexHld9hkuooDZbSjOW4FZLZmJDtxZsnkS+IHJlIQy3DlUbOjiefXE7dcNeIZ273T1HaivOr6I0OEWHa3oyM66+aCN798zFqO/BMQ7oRhL87vokGBzDk/t2FTpUz4Rt8UtjP2AOvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz4ekrpG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gz4ekrpG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so20205995e9.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773402189; x=1774006989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGGeg1/sH0c5V5ArF91KXy/Lv7DSS3m8tyfjlPavfXY=;
        b=gz4ekrpGeAuRBdmVKUUkN85YeCA1PQerujWFztgtd1gQHRoSsmJ7tL0pxvnNYOPfVc
         xdsJuXGZcOmTc9POBuXuLaxfW2S11NDI9gkxHKFBWlKvS6SjUIueMiddjAJi/tkeQaWH
         W2KZIxO/il5BsfGgt2T8L+XQArU/Jl0XWqx3DCwpoviiyAMJ1L3aRP3DNJaAAnyKvBn6
         DJEWZzpMcBJdvhEtM518REAwk9FtvPZfnVHhebN2fxv8l09iMKymRrnFLGZXLKWB7SAw
         XDHP+4rXt5U/xWKShOwJFcOjZ84FRwT3JXK08ofODbiIOfIMwyERk442MrBtvBh4StOD
         sgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773402189; x=1774006989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGGeg1/sH0c5V5ArF91KXy/Lv7DSS3m8tyfjlPavfXY=;
        b=khtQcb2jd1uBUp+Dt8sQCGjxz/19x02w5WjWGyDbv343bLxuWDdkEdyWe+SQFh8O3/
         eIRvBnIAt3WtwJ/Si65zt5b/c9T+or/QZe8VPY+UzyI/V823REJ1KqjUfGfGw7ahq2wt
         ziQr2DpXCtgGFtJxWHjwNft9kW9kzBZU7+aUqrx0hjDJPKoeNxumVPyrMJlyaXwsl9Tl
         ZUk5WvnCrwzMk9yazhVcEA/I7LhZ0X+3vxGq0kXalsO8k7hEmWQ1g7fz6sGCQPj+vU+n
         ykyE+ONue0zs3Xtu4eGVaV6gsNvFCK97VIp24oIqamUPwB5nGcTU98Y11DQIMWfD3qxK
         hIKQ==
X-Gm-Message-State: AOJu0YyGM5uNKXn6ticydA/YCbE/K/OYw9xE7ynMudqQsFAmCkplHUno
	tHVyVX2P11MVTHnuLW0yQfeuLz8O31UeFQnVO4rNH6PDyVz/7uXmkRcSMdkD201U
X-Gm-Gg: ATEYQzxPcpls8RVevEZF4zSCGBEmA5EfxMktd+cewc1E4smvrgGEjMnN6TCADqCrTH1
	6mOZ2pgA4XUxfzOwHcNUMz0RlNrqEllN7dlAdoyftcXkAzaxubGHQey3wupcVH4gnTM9FSsAtMm
	eAQVMjnIhC0DWoLMUpaRDaD5f5xDdb9mWZCH0zxHGf802wXrSMPW77kQse31rOTtocOApzyxZVx
	oeO5WAPndbQ/jJg3gvXQbhTzPIeTd/up3Kgn9knkLwX9PTUze3Bl3Vm52mLHo+ZlNkPXDh7iJaE
	bxXvNkNkRhxi7lSEsaQaJ2KEaGUcCVGLFgz8P09z+x66aqYY7UbvHFA2RWx0v568UyrFAja5PK5
	TTpY0pJcsKiMFtVS6fcgOGcc6uTvZ782gcDR3nItMNF4BpPobOAg+lCBPV2B0wqRxXQ5Gv+4lEm
	QfMZuYuZBHztDmNR73Ta73aaah0rMY2djr3Nt+X9UTyPFHolPtqCxNrGXXb6GO/HrVVBxB4Vf2U
	VQx/SSS3rIJhzS0u0RaOLOdgg0av+jSz9cD1U0UXLzOhFHoKgOcqtIOdTS0bfgQwmuH550pLgBH
	V0vl7eIwSsA=
X-Received: by 2002:a05:600c:1d1a:b0:485:2ce2:4c8a with SMTP id 5b1f17b1804b1-485566cfb00mr43880585e9.1.1773402189110;
        Fri, 13 Mar 2026 04:43:09 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm547117595e9.2.2026.03.13.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:43:08 -0700 (PDT)
Date: Fri, 13 Mar 2026 12:43:07 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Test case for refinement
 improvement using 64b bounds
Message-ID: <622dc51c581cd4d652fff362188b2a5f73c1fe99.1773401138.git.paul.chaignon@gmail.com>
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

This new selftest demonstrates the improvement of bounds refinement from
the previous patch. It is inspired from a set of reg_bounds_sync inputs
generated using CBMC [1] by Shung-Hsi:

  reg.smin_value=0x8000000000000002
  reg.smax_value=2
  reg.umin_value=2
  reg.umax_value=19
  reg.s32_min_value=2
  reg.s32_max_value=3
  reg.u32_min_value=2
  reg.u32_max_value=3

reg_bounds_sync returns R=[2; 3] without the previous patch, and R=2
with it. __reg64_deduce_bounds is able to derive that u64=2, but before
the previous patch, those bounds are overwritten in
__reg_deduce_mixed_bounds using the 32bits bounds.

To arrive to these reg_bounds_sync inputs, we bound the 32bits value
first to [2; 3]. We can then upper-bound s64 without impacting u64. At
that point, the refinement to u64=2 doesn't happen because the ranges
still overlap in two points:

  0  umin=2                             umax=0xff..ff00..03   U64_MAX
  |  [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]      |
  |----------------------------|------------------------------|
  |xx]                           [xxxxxxxxxxxxxxxxxxxxxxxxxxxx|
  0  smax=2                      smin=0x800..02               -1

With an upper-bound check at value 19, we can reach the above inputs for
reg_bounds_sync. At that point, the refinement to u64=2 happens and
because it isn't overwritten by __reg_deduce_mixed_bounds anymore,
reg_bounds_sync returns with reg=2.

The test validates this result by including an illegal instruction in
the (dead) branch reg != 2.

Link: https://github.com/shunghsiyu/reg_bounds_sync-review/ [1]
Co-developed-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index ce09379130aa..3724d5e5bcb3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2037,4 +2037,37 @@ __naked void signed_unsigned_intersection32_case2(void *ctx)
 	: __clobber_all);
 }
 
+/* After instruction 3, the u64 and s64 ranges look as follows:
+ * 0  umin=2                             umax=0xff..ff00..03   U64_MAX
+ * |  [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]      |
+ * |----------------------------|------------------------------|
+ * |xx]                           [xxxxxxxxxxxxxxxxxxxxxxxxxxxx|
+ * 0  smax=2                      smin=0x800..02               -1
+ *
+ * The two ranges can't be refined because they overlap in two places. Once we
+ * add an upper-bound to u64 at instruction 4, the refinement can happen. This
+ * test validates that this refinement does happen and is not overwritten by
+ * the less-precise 32bits ranges.
+ */
+SEC("socket")
+__description("bounds refinement: 64bits ranges not overwritten by 32bits ranges")
+__msg("3: (65) if r0 s> 0x2 {{.*}} R0=scalar(smin=0x8000000000000002,smax=2,umin=smin32=umin32=2,umax=0xffffffff00000003,smax32=umax32=3")
+__msg("4: (25) if r0 > 0x13 {{.*}} R0=2")
+__success __log_level(2)
+__naked void refinement_32bounds_not_overwriting_64bounds(void *ctx)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	if w0 < 2 goto +5;		\
+	if w0 > 3 goto +4;		\
+	if r0 s> 2 goto +3;		\
+	if r0 > 19 goto +2;		\
+	if r0 == 2 goto +1;		\
+	r10 = 0;			\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

