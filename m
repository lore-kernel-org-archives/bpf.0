Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06102224FA
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772841828; cv=none; b=sK3mCiAcA9YfMEwWUkvtWDesTY4k3bOmdFI7bRgJ1+MrQjj3duyLeWjnpJZwSRvIIObEkcDu9Iva3is67WfCXP50B2xltkNIHfxjIW6ww4I3KIqLCS+yb0NlBLgu9AybiiC1+1tnMOQF2sJVcBL+PqhG9ACMOUT4VDRjsxE8ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772841828; c=relaxed/simple;
	bh=KtrJoBUgPNyiStfFdIGXUaVOLLSm3ELi3RF86SVkilo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgGP64qE4vC24Od0N0fqXLaNttTZRT6u9yH7ylBUasxEcX7OnUSYHmzZe8iPV1JUOlnEPj9P/QyjLu9PeMKZmTBwmH02atIa6KDrR/M541tY4mfr6C1/RiXm798cg/Y3HEKM2IaAb3RmYBs1eizdvv4TDt7mh4y9uMrpDCpJIgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/9TEsSl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/9TEsSl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso106603915e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772841825; x=1773446625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/9vPG3hNBCc8KEQdYyYCc76P/tB4TEQT2/8UdfLXHI=;
        b=N/9TEsSlcueVaJAhb8AcD7cRXopQ44Angw2YdVfSYLuOBnlFnZx8L+AUHYeNT0BGaZ
         EA43YUJj4/rjseohITDC4KrlsJnE3vBV0c53Idhg0MlWd4Z8CXJwdvaguPthIj4g55Zr
         qlJH+uUFKKfdjp6wynlkTFxeQ5rXn52DFmFff6RyUwJ/Suof1ibAtIjxXLtPK4OS7FOc
         farbrfvnowskQEhVA12KySuTA0GHlQSkfcOm0IBFK6cXD1rW0GiSfetHdoim8oNolrb2
         pLfVyq4Lw3DVnQ1CVf2psCfPU9tBGujqcleaPG+B6Oa1T71B9dJ7JrCrqeGBqpgvAlUj
         ssXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772841825; x=1773446625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/9vPG3hNBCc8KEQdYyYCc76P/tB4TEQT2/8UdfLXHI=;
        b=URmWonsZJBJE9NPgj8F+LfxndlA8CK0CPz0Onp2uasHsbamM6hcwuLhziAydSg1Hhx
         SZh4e1AeGP6f8gE2gJudFwck7iiOW6lmbFvtUAQ+BSiw9NdZsuSLICYnps9aua5ImSqG
         Lmson7AkU/BchkK/CwV04hdYWyMOl1wtWRqX0+PXWfAxEuoEXCFmxnScGv4DXdOS6NGu
         ke2f2yCacMlWYovwvbio+KesD3ESTA8O/mAygl9TcUq5Kafhc58PtD4qBVEvpYDsDZnx
         QUP+rUHVgdrY46Ente4V/YY+Ua/TF2jDNKFm2Z4Xd3bBUMcORy6zdOORw9zJ/iYyxBWL
         gJqw==
X-Gm-Message-State: AOJu0YzvLiRLDR6U//o5uz2wxHRiTlu5eOpwbFzxE5cLkV2/4nDgO9Jg
	ckSIM9pv951XDZVgmpqjB+zsVNOrvzPpEg4UdaBcWHYZ56gSbuaz0fLo42xSVRej
X-Gm-Gg: ATEYQzyxrPJkUIV0XI8kmlKTdcyI2SqbxczZx5hmZwsgg4KAwwocwdE9defvjJocQil
	BbXY+nnKuJoU4nOv0O4TKKUhzUzLaNERZYNNdm/3Z9KXP5wVY2KKNHHH84Smh0Rg4+/A3j4ZDIx
	HS2/nNcxYgKWykZJ9739lZd2QatXvNlbbVdLFcN/g5EQQzY9LojV018MfSWez9nTSjlgXhaIN3s
	vGs5bQxTs8dHsVC/X+n8CBGC2BKBfEYzehg7Ze3CuDQ+vU52zhnOhxm3KY3kHW9qFbwtTcNQ0Oc
	19Nc+P///2iNSoOMNdLta2oFwEn9tmdtdXT0/aXOrx1iHSOdvPFy8XRdGEq0BFZu+BkWd0pRn2t
	RGI154XWKPEN7HFN3mtogfuGkYurtnmXqrxmQRGD465Kvhk6Pgtb+5xQ6pU2ym2K5oN/xvT/zwW
	bmlTNw6FI0daDt+UAro5swZlaK0HH1+o83oYRs3aA5gvtHrsWZTgGVgDmmKEKF2URDroGubDzqd
	7PYvx56DWHHDaN4KrEP+SKx+RupKiU3/rSFaTCDYcRe+9kWWSJ02fSMnQkuJ7pHZHwnaWqUeDdh
X-Received: by 2002:a05:600c:8b01:b0:477:5ad9:6df1 with SMTP id 5b1f17b1804b1-4852691989bmr63278885e9.3.1772841824951;
        Fri, 06 Mar 2026 16:03:44 -0800 (PST)
Received: from Tunnel (2a01cb089436c000a341eb7e94b4f969.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:a341:eb7e:94b4:f969])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852767dd5fsm66994035e9.1.2026.03.06.16.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:03:44 -0800 (PST)
Date: Sat, 7 Mar 2026 01:03:42 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH v2 bpf-next 2/2] selftests/bpf: Test case for refinement
 improvement using 64b bounds
Message-ID: <263797e1f32f3ce986a1ff7c4f38aee2440d6338.1772840030.git.paul.chaignon@gmail.com>
References: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>

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
index 4588e5b55b41..fd377d3a27d4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2000,4 +2000,37 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
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
+__naked void tmp(void *ctx)
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

