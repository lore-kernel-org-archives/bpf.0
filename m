Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA90259C9C
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228109; cv=none; b=AXHlR9lQHtyU4pwURb13WYe6tiCnuadTKJWI3r6nxk8SUINECvz8O+Zckt8RlpHzn9KnR9rJ7eYiHkBWr7aWwSz7ZGXjZpxT3D5wkv/VycMhqARKz8NIRJMVK+ClWA5BEXfrx7XGbXFyJMY20n5mCAx/qC2XhLxBs551L0Ni5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228109; c=relaxed/simple;
	bh=MvGCKOv/8+9+Qz9q1rQAJ0DFJNYiPijxPpsv/oUXsn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rS7Y23pORSitq3kodJyQCJlgCQg09L1qymzqZwjNa0eNFTKeUWzriRHghhZ1oIrxvriFrmmxNv2JgWW4kO9TEvZKu0QnG6PggLrDRiJqxm6aI1plztdt1rTste4TwiLPD9nVV5LQ5pQ/4hy/wSWvBvxIbQIg67hOVN+elWsOU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pms5TBU2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pms5TBU2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436317c80f7so2329076f8f.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228106; x=1772832906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqVQRtppE84Bvt0DrK/v0Urr5hcdbkAsVk7WAUtYU3A=;
        b=Pms5TBU29zpub+MIwt88P27FgSQA/rDph+NxGVoJrSjNW5+ouFmSAhD8xoaTL/Hhv4
         vHtnf2hN3W5eVl+4WUEa67k3L75+i5Ardt9ZlD83MeUjOs0KyxhVYSN7LoFt5A76OSSd
         h5061UNm1+9FT3m83lJlhej607Wf1EayD+W3NpFgKe/yMa5RycHCcDhG+aE0ANIspY+J
         R1JWq+huazB/qbplMZl8Y0U7loD4b+6gC9GlpADtK3vdNxEHKdZOyTI3/95M+s7kYMVa
         sWnFOvbB3/egwDWcYtJMM2LGscsmGbLOCDhmey69a/I/4uudUIgucY1LgofBaIwWkIDy
         uveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228106; x=1772832906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqVQRtppE84Bvt0DrK/v0Urr5hcdbkAsVk7WAUtYU3A=;
        b=EgJm+z3HdS8JqLzL9mEwbOE9vOMTyq9hlMluWchEzIo/sDxuLshBSQDXsHB5M5ebEb
         7+0k0/eiYyqwi3HaG17Y07i/65Z9UWZwhZOtzufC3P8rjGEmVda9aj+I5YQG1YKZ2r3E
         U7RNGYmjhaJlVkFyjbf44nnwXtLnnyrnIjDmH9FXMm76MqOyiensUoHMxLFHfcQWxo9J
         fe+HHVd6R1LVggxwiWJWZYK1cJSXYVmf9Ud9GI/NW167AXiT2dLThx7yxOdiYORex3j5
         7gFpkY2uqcSW6sXWPdJ0A4hNwJ5/5H0Ie5lGtDduHtWaq7IhEP9sSX3BZrEhBPybEd3c
         pWmw==
X-Gm-Message-State: AOJu0Ywf8w4G9rXmAnk4A0Gm64OxIyhnhONLAfLgpXMk+wpB3W72ah+k
	VmXMh18jvLBPftkJwYyqSaqs0+jKYESowZxtifLZ5WU4kMveggAlriQA762vYF/T3+A=
X-Gm-Gg: ATEYQzzp4YAzy8a1zGFZc8XVfbiyV/erRPg7SYEDlSiQxk2ZWG7cdUhqcCQN/qH0YKQ
	DqhSF3440T23rZbqd4mwlSuHWZLDQVk+V3BbTa/pCKMRInRfxlcch3sDUujn0x1e2hpodGWItAH
	ABMgN6Ukla57eTNER/UxCqNE71XKfGeb/Z/TVLm3D/wJ7GHi70V2rD4yqiFev1iTE2wNhIxLS9G
	sREOb/IE4p5KNzukv1p0tZhUerM6h1W89eBBOXnfHWa9t9DqExLoxwh3wIEJL6y2+4AK+De0qaT
	h9kRIX/YiNeQi2WJDJ9BWZp86hGhgI1LzckQ4hjWSE7ZI7hVtD1wABryP+mahbtyudhl3Y4Pne+
	jqtLz7z2V2sZxlKMKjj2VQOnViteBQ7+2sQXIMU2HNxnGVFvOdKbyHW2ib9Tq238yc2pG4tqOE4
	wEcW7v7FEPYtnBAxLHlsJOAnqKgIa5k67eEn46maCGYDb78CShQVf5ioTn7KRAyxA5++uwkr6Ri
	YNJTYxxqNfnif9Y2tLYlH80NrpmWVOROqJCde99dR/CT2Q5aWM9m7XUYrbB6SCoYFPp8ntFwTz8
X-Received: by 2002:a05:6000:40e0:b0:435:bdc2:461 with SMTP id ffacd0b85a97d-439971fc90bmr14905775f8f.21.1772228105635;
        Fri, 27 Feb 2026 13:35:05 -0800 (PST)
Received: from Tunnel (2a01cb06901b353b20ebf6654db8a566.ipv6.abo.wanadoo.fr. [2a01:cb06:901b:353b:20eb:f665:4db8:a566])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b327sm10300669f8f.20.2026.02.27.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:35:05 -0800 (PST)
Date: Fri, 27 Feb 2026 22:35:02 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v3 bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
Message-ID: <ef254c4f68be19bd393d450188946821c588565d.1772225741.git.paul.chaignon@gmail.com>
References: <cover.1772225741.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772225741.git.paul.chaignon@gmail.com>

We're hitting an invariant violation in Cilium that sometimes leads to
BPF programs being rejected and Cilium failing to start [1]. The
following extract from verifier logs shows what's happening:

  from 201 to 236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  ; if (magic == MARK_MAGIC_HOST || magic == MARK_MAGIC_OVERLAY || magic == MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
  236: (16) if w9 == 0xe00 goto pc+45   ; R9=scalar(smin=umin=smin32=umin32=3585,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
  237: (16) if w9 == 0xf00 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)

We reach instruction 236 with two possible values for R9, 0xe00 and
0xf00. This is perfectly reflected in the tnum, but of course the ranges
are less accurate and cover [0xe00; 0xf00]. Taking the fallthrough path
at instruction 236 allows the verifier to reduce the range to
[0xe01; 0xf00]. The tnum is however not updated.

With these ranges, at instruction 237, the verifier is not able to
deduce that R9 is always equal to 0xf00. Hence the fallthrough pass is
explored first, the verifier refines the bounds using the assumption
that R9 != 0xf00, and ends up with an invariant violation.

This pattern of impossible branch + bounds refinement is common to all
invariant violations seen so far. The long-term solution is likely to
rely on the refinement + invariant violation check to detect dead
branches, as started by Eduard. To fix the current issue, we need
something with less refactoring that we can backport.

This patch uses the tnum_step helper introduced in the previous patch to
detect the above situation. In particular, three cases are now detected
in the bounds refinement:

1. The u64 range and the tnum only overlap in umin.
   u64:  ---[xxxxxx]-----
   tnum: --xx----------x-

2. The u64 range and the tnum only overlap in the maximum value
   represented by the tnum, called tmax.
   u64:  ---[xxxxxx]-----
   tnum: xx-----x--------

3. The u64 range and the tnum only overlap in between umin (excluded)
   and umax.
   u64:  ---[xxxxxx]-----
   tnum: xx----x-------x-

To detect these three cases, we call tnum_step(tnum, umin), which
returns the smallest member of the tnum greater than umin, called
tnum_next here. We're in case (1) if umin is part of the tnum and
tnum_next is greater than umax. We're in case (2) if umin is not part of
the tnum and tnum_next is equal to tmax. Finally, we're in case (3) if
umin is not part of the tnum, tnum_next is inferior or equal to umax,
and calling tnum_step a second time gives us a value past umax.

This change implements these three cases. With it, the above bytecode
looks as follows:

  0: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
  1: (47) r0 |= 3584                    ; R0=scalar(smin=0x8000000000000e00,umin=umin32=3584,smin32=0x80000e00,var_off=(0xe00; 0xfffffffffffff1ff))
  2: (57) r0 &= 3840                    ; R0=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
  3: (15) if r0 == 0xe00 goto pc+2      ; R0=3840
  4: (15) if r0 == 0xf00 goto pc+1
  4: R0=3840
  6: (95) exit

In addition to the new selftests, this change was also verified with
Agni [3]. For the record, the raw SMT is available at [4]. The property
it verifies is that: If a concrete value x is contained in all input
abstract values, after __update_reg_bounds, it will continue to be
contained in all output abstract values.

Link: https://github.com/cilium/cilium/issues/44216 [1]
Link: https://pchaigno.github.io/test-verifier-complexity.html [2]
Link: https://github.com/bpfverif/agni [3]
Link: https://pastebin.com/raw/naCfaqNx [4]
Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb12ba020649..401d6c4960ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2379,6 +2379,9 @@ static void __update_reg32_bounds(struct bpf_reg_state *reg)
 
 static void __update_reg64_bounds(struct bpf_reg_state *reg)
 {
+	u64 tnum_next, tmax;
+	bool umin_in_tnum;
+
 	/* min signed is max(sign bit) | min(other bits) */
 	reg->smin_value = max_t(s64, reg->smin_value,
 				reg->var_off.value | (reg->var_off.mask & S64_MIN));
@@ -2388,6 +2391,33 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 	reg->umin_value = max(reg->umin_value, reg->var_off.value);
 	reg->umax_value = min(reg->umax_value,
 			      reg->var_off.value | reg->var_off.mask);
+
+	/* Check if u64 and tnum overlap in a single value */
+	tnum_next = tnum_step(reg->var_off, reg->umin_value);
+	umin_in_tnum = (reg->umin_value & ~reg->var_off.mask) == reg->var_off.value;
+	tmax = reg->var_off.value | reg->var_off.mask;
+	if (umin_in_tnum && tnum_next > reg->umax_value) {
+		/* The u64 range and the tnum only overlap in umin.
+		 * u64:  ---[xxxxxx]-----
+		 * tnum: --xx----------x-
+		 */
+		___mark_reg_known(reg, reg->umin_value);
+	} else if (!umin_in_tnum && tnum_next == tmax) {
+		/* The u64 range and the tnum only overlap in the maximum value
+		 * represented by the tnum, called tmax.
+		 * u64:  ---[xxxxxx]-----
+		 * tnum: xx-----x--------
+		 */
+		___mark_reg_known(reg, tmax);
+	} else if (!umin_in_tnum && tnum_next <= reg->umax_value &&
+		   tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
+		/* The u64 range and the tnum only overlap in between umin
+		 * (excluded) and umax.
+		 * u64:  ---[xxxxxx]-----
+		 * tnum: xx----x-------x-
+		 */
+		___mark_reg_known(reg, tnum_next);
+	}
 }
 
 static void __update_reg_bounds(struct bpf_reg_state *reg)
-- 
2.43.0

