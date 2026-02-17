Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B41D88D7
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771318893; cv=none; b=K53uzutemsx45da/cRBGnPtD0YBNd/nAn3K40oc09l8IY0ogNEhp4axuQxRLhPjwttSeGuiKwO5jwZ0xMlANP2NqP83ke2Juo2Iz0qoD9tfThSI5hB5Uo3fSP13ZWEvaCYtS/oBLtPXVXXK0EiX28C99sQqWpab79ay/8537zZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771318893; c=relaxed/simple;
	bh=wNpxLq5TToUCJCI1zyLLmsndqmKlu5Jbc04A4vQl/8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmecmeRDcYYexznkYS/8/3DN5m5ppnZ/PkIzdNzAXV8y4Ng1iQ/R+0BnhDVmPJe6Fq/HxoZoKpFRKXE84e3MZ3vWiJBa8mTaJJw6WNpj4A8NGXgFuz0AKoJK8y979QUiU980NGS4ZTVEcOjIUxEJyWAdHb3B+1iKRJgfNczxXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4QKVnuG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4QKVnuG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837907f535so26632475e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 01:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771318890; x=1771923690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rATUChrL2C51MIAP+1X/mTHr+Yw8Roy6AAbulUy/O6M=;
        b=Z4QKVnuGO6cCFumiPxOQPhPoM4V0q3/mHpD0iVD0/GAR1rTzQWsuKdtvPCn9DcGMOE
         YYCvsxdGQ2ThFqXHXZX51ERz1AXbnAkqhGxGU4Ai4Zz1gYPv46Qc65Cp+Y3zsXaYoW7w
         S9rvxhxP/JSUuaJL/2DOiY98pmuKL31F9RgX1swxOpWJZCITpjuse4M6MoBVcC5umKQ7
         aOIunufkmc13sOE5FfDeE6kzNnDmoG9H3zp09W1kqQpGVQiqSwQ95GEt4mjgndE65wIb
         R+tYtY4Z13r1LVX7rXcTFuHcw5cITUghzY1R6WtQsDUGiCt1pze+cliPxYdEkAOT0+cX
         90Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771318890; x=1771923690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rATUChrL2C51MIAP+1X/mTHr+Yw8Roy6AAbulUy/O6M=;
        b=ijU0wAFJbbj1z6DQgcdhFR5w8vaiaxohzEg0S5SSYbrxrBao+3zoozmwrYjAI9U/Pn
         ypnYEH3VZqn3vIAgLKRQsO6XMuBgknbPRUEt+MjfPBhcC4Z1Of/T75FPd+4i2j9rZsPr
         2yMIF9PVECjD7DyaOLWFSRRpNaI2NMHzqutmday/N01uc6Fd2umHeiC1bdsChG7NFA7I
         8GMeUqeYhYy5StU371RzbfxbGYkHUKrxREIIrvlJvR3RKvPp4Gx9NSCkVtegoV6NSFFT
         i/inenjOKUJqJh6qTAFQrL7O/gPh5I2AWMJ3RL4NBqNsUTXDP8+yW/tzzAJjs0V0RxGP
         YJ0A==
X-Gm-Message-State: AOJu0YzMLXrVWrmIGPw+eYbvfFQyBbR+wMosJxg0SYjsv3H7aAAPWqz9
	Z2u/TuNyQBH1H7qW+9hw8jllaoSFjhVb/F8VXmxrC0B81AeOqWQoakslCMc4kg==
X-Gm-Gg: AZuq6aKsfmJtd+FCm+2/bsn2OP8PO30WGgNTO2StBjEX0Tn9B6HA4hh/2G+70zz2xRK
	wI48wFb8s4QTSpro7/T8dCYM5E+Ng3BuJMYhZhtJhST/3WucD2zBx7o27dPq07Hg2AEiTivu4Th
	Htf9sIWwXrTVFHzL+XqUBL74L9KZ//Beb3+SFcDX/Zbm2ex4ieIJLRMnyOi/lcneO/64aydWIm8
	6ovFZFBqxtn0eM5avtS+kxdrLL1J+H4m4V30z6sRPZqq91MNHQiY6MSlzgqXnBxghWduMmTv1Di
	EyW3kKnhbtIG9+tP3IizFomSWLgAGb78l8OLx+mnnPTfg8kKAYr4Y4yOjYIggxK/Aik1kU3j2zh
	PY8Gc8k1z7+AiK2LPflIEDRG5wsoe33lzl0f15ukF5M7w384lBFWT78FBNK6GWYlNnXxRAyLSWU
	4tEXprOLuUpoJnp326JbcQzaVfWwGrLTWHRx6/eDJwu9vzvrHX3SqRu0EktXF+9FJuC8Pps8Bxi
	QUW+b4ejZq14RiAaKxQRikOqPp+Zu6SKqSznaQH2e5QQk6vUkQJs6/RG/0Vatx69WVscScNs8w1
	pAIIUTuYi/o=
X-Received: by 2002:a05:600c:3496:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-48379bd72a9mr157647965e9.23.1771318889791;
        Tue, 17 Feb 2026 01:01:29 -0800 (PST)
Received: from mail.gmail.com (2a01cb0889497e003025d1eb71f3ff18.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:3025:d1eb:71f3:ff18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abe3b3sm38439491f8f.18.2026.02.17.01.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 01:01:29 -0800 (PST)
Date: Tue, 17 Feb 2026 10:01:27 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf 2/4] bpf: Improve bounds when tnum has a single possible
 value
Message-ID: <5299e75f8807c7c49ec048e821f25a6dfef2c6cc.1771316309.git.paul.chaignon@gmail.com>
References: <cover.1771316309.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771316309.git.paul.chaignon@gmail.com>

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

3. The u64 range and the tnum only overlap
   u64:  ---[xxxxxx]-----
   tnum: xx----x-------x-

To detect these three cases, we call tnum_step(tnum, umin), which
returns the largest member of the tnum greater than umin, called
tnum_next here. We're in case (1) if umin uis part of the tnum and
tnum_next is greater than umax. We're in case (2) if umin is not part of
the tnum and tnum_next is equal to tmax. Finally, we're in case (3) if
tnum_next is inferior or equal to umax AND calling tnum_step a second
time gives us a value past umax.

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
Link: https://pastebin.com/raw/9BJAi6Rw [4]
Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 kernel/bpf/verifier.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dbaafb64d3bd..c4478c874616 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2379,6 +2379,8 @@ static void __update_reg32_bounds(struct bpf_reg_state *reg)
 
 static void __update_reg64_bounds(struct bpf_reg_state *reg)
 {
+	u64 tnum_next;
+
 	/* min signed is max(sign bit) | min(other bits) */
 	reg->smin_value = max_t(s64, reg->smin_value,
 				reg->var_off.value | (reg->var_off.mask & S64_MIN));
@@ -2388,6 +2390,20 @@ static void __update_reg64_bounds(struct bpf_reg_state *reg)
 	reg->umin_value = max(reg->umin_value, reg->var_off.value);
 	reg->umax_value = min(reg->umax_value,
 			      reg->var_off.value | reg->var_off.mask);
+
+	/* Check if u64 and tnum overlap in a single value */
+	tnum_next = tnum_step(reg->var_off, reg->umin_value);
+	if ((reg->umin_value & ~reg->var_off.mask) == reg->var_off.value) {
+		/* The only overlap is umin */
+		if (tnum_next > reg->umax_value)
+			___mark_reg_known(reg, reg->umin_value);
+	} else if (tnum_next == (reg->var_off.value | reg->var_off.mask)) {
+		/* The only overlap is tmax */
+		___mark_reg_known(reg, tnum_next);
+	} else if (tnum_next <= reg->umax_value &&
+		   tnum_step(reg->var_off, tnum_next) > reg->umax_value) {
+		___mark_reg_known(reg, tnum_next);
+	}
 }
 
 static void __update_reg_bounds(struct bpf_reg_state *reg)
-- 
2.43.0

