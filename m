Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD833EB07
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595841; cv=none; b=Sg1laGGMuX9Q22w5asFht3O58KGRZwXrMCfE6fS42z8sAiRs6Ha/TRR7tiNIn6cYQ3DtF7rUueVcUEr+w/igM+aU6h+BwTFw39Olg7512OagIvR6+1gclN2ush00oyBGSIpze6O0GIKH+XzlChpWx5sGlH5p9XyES6uyixUnth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595841; c=relaxed/simple;
	bh=x7qBooprF5SzStK+yVfsMi7AcgJb+EU1deIgh5LIPmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqBYJDYDiy2vfDPIvHDh1pPL9lrTceAvv5pRzapRgGSaakx7nGxjoQdEoDWZu4aXw0mBdfPHQ7yi6SxLoOsKMwj5UXxJ0tJ0E/xtiy7gq/9I+cuIIkW5YB621eAtGJ7os9WM9g9kzHtLI/GUIwtGLSGANGj/MLKK+Cezm2VuHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeIkFyKV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeIkFyKV"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48375f1defeso15024205e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 05:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771595838; x=1772200638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+t//HF3ahDzp4tphypKA0WpedxlXn4Q/UiCT6kbuFU=;
        b=PeIkFyKVdGP0VL4LPPIBSR9pV6TzxF6I219s2BeJ7qYmOAooxP75sfsHlKdAkYIBJm
         /hR7dnjrdoOfTCLUJyQlcPXiHly3HV2VZfqRB1fIHu6a9GLS0/jmxb2MXuAWGtVpkKk5
         1K1h0vlx7yZWWIH14zAPanNX7tieH9q1fYL0ftw14XhgvYHs3y5t6hAKBVPSYZd6xhIe
         kCiuygn9hD+2xQxXAdmS62Re1TCeZHS+LsLw2m9wVgvgRzLs1h593dvqg8ZfCKM22TvZ
         VP5wvDA+Enjv5/UxsL/5JgMZWF50/1d9frgmtQF257ar2Xj6BbOmBYoHDUXtdILhfOrh
         Akzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771595838; x=1772200638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+t//HF3ahDzp4tphypKA0WpedxlXn4Q/UiCT6kbuFU=;
        b=cJ7e1HLkPzGZ5knXuJgvfKpY0SouiOmvjlEa++MTr4JqI+P9MTK7Wc4tcsW092+Mkb
         lUqMAVTrrffxYjNDWBM/Kre14Ql90ga5AbzwrEzPUtkIvqGuoJt4GPBToyuh0Ab8iSzq
         4SspwqM5UwEhr0sJx9kZy8jgfQgFa4sZ+4Z+nwtODVa1kNoUVshV7XPM8z97lji8brw6
         9T0hEhkMrw8dh8OsJNHow0jANzkHEAXUDtxdN5D40iI7DlRY168zB3rEWe6TWP2BG2Eh
         9qapjzMqA8JgFeJjrYkNWjhDNRE4Cc1XezcbbkJkOaQ39O1MxNDuMzkqzqZfy8/1RK2y
         +ZHg==
X-Gm-Message-State: AOJu0YzT5TVbK4CYL/1PM2zAq9NvByT5S9w+4mTaGVaOiWmff0+bftSx
	7+hZghie2J7LrLRsCjVQjjociCLjq9ROdfZVx/ZUnW12XCVX0IOtzPOihbDH/A==
X-Gm-Gg: AZuq6aLjPWC33/X+TJ/50/8Wy5/GeWLMiB3+EbL+/wKsUeWkn2QYQ/V6ft1dAIio9RQ
	s3y2HiHLVmwGuwc8RRtnMQgx+LmOzQUFIbgvJ0ewJp+EoPDUGnx1ZkCbuLtd20EupkrwwIpwZj5
	zKmYKIQ5XzZRuNfMpR3Vc0tfmCB0CZuT+v9+0k9auZb6moBVGdWb6LVTyoscaI5+qlE3LO51tTD
	FiJDxzGeVWXFfv8uQrdqWvROQc3AnnCv1FuWWPcF/1xOrQTxbMmgV25EOwM2gyTAtTk6pHufK4Q
	onTabXZ5qRn5Ig87qrI3ubSXypFBlGLM7qzal2vnP3/A7PyH1w+bXwKWpy1e/ECunKyRKzo8BCX
	7ubN53OI12ePRpIUHnxL1fVaGFaNTfluQ9mfhxmzYcZq1dVJxARMMVqNJoJufHIRGBreRlT0n3O
	J0Ea+EjatfDaEmdVjhxxRyi7+p/iD/WTI3FFp9wc7DbfxeneDWg0CQU6Q4+k4OKEnNJOGK5rQPS
	pTx9VFf+nEDurBqxkt2MGZCtBf6U0IW4BchavgsEnh4ksZShYb1zHe3vf6IbIyONWMNKoOJxu5W
	ziO5q118dA==
X-Received: by 2002:a05:600c:c0c6:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483a2cef4b8mr53143325e9.4.1771595838114;
        Fri, 20 Feb 2026 05:57:18 -0800 (PST)
Received: from Tunnel (2a01cb09b01c9b546fd5ffb86f392ee0.ipv6.abo.wanadoo.fr. [2a01:cb09:b01c:9b54:6fd5:ffb8:6f39:2ee0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c51ddsm76334365e9.8.2026.02.20.05.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 05:57:16 -0800 (PST)
Date: Fri, 20 Feb 2026 14:57:01 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v2 bpf 2/4] bpf: Improve bounds when tnum has a single
 possible value
Message-ID: <ff1f2d06609189ce93bbf8702031069b986ddd99.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771594636.git.paul.chaignon@gmail.com>

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
returns the largest member of the tnum greater than umin, called
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
Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbaafb64d3bd..7eb6b94dfa11 100644
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

