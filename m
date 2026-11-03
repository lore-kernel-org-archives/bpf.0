Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749280;
	b=A1hP9LUAOOIr9zzkgsPOQl5jZIfFFqWmeK3AfGJiwV49qOxeQ9QqEjkBgrFhUZIwmGHV
	 CNkYdCK5u0ix+P2EQX91HM9E3caZSL6fUQxYyIcTl+PcjrUGdjv/rO7zrbrZYfKg59Ugo
	 sFxFobCrysWgDtEgIeMfcvC9MQXai2lUrHlyZmhqHVeIiOC2aDID4xjrM1fqc/oW3H51I
	 UE8QkpYmBIrJORyzntBhOEo69s2Fg2HdfYphaJbHVGtR03RIeun0eESkfqkWL+TOFjI72
	 gd2zXt+y2FGFVnawh11cLAQ/NIqE3gxEjQQIaUbmST6U5E759saBSRMv+jwFG03hoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DG252wxWFY4VFP7NQq4EPNRF6QYNWw5dgS/1j2l70qQ=;
	b=0ZFS/UWEAaJTIEBqYh+f16stfQYyqryVYnWuL+pj60S7jqeSimNOXEB4gqOkZzq9QvbP
	 /b+LxDNDHbrWzo1Cc3aPrh1IP39kOCFBEQUG4EOsW0yjydjUhDe9YOrpOsFHXzg/0oWNE
	 h1XTnmXy4Ruqo+xBhfFxwnh+HAy5seIiaMiFmwIwExlEPnW7Fh/Q1f2yA++xeZk6/1JMc
	 1O5LONMY3rHcAYL3EqjNh1eK+gzHqk3uC2xsq62P8LO5gMWxy1C9vzZA6nre5+Kw7EO23
	 qb3RzPK1fOG/gDKKFCq55iXKYTAZcGccJ75oOFge4nDIyaDuo96Ob9kfSrxwBCqRCew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwtCpn7y;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4F606A31B
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D4F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lwtCpn7y
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso60121a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793749279; x=1794354079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DG252wxWFY4VFP7NQq4EPNRF6QYNWw5dgS/1j2l70qQ=;
        b=lwtCpn7yhaeQ0LVKvaAE/IJoB8IlQa/Xk0GYVgruD9QftfpR4wQswR6H2Tg8NZOKNf
         YhE8k/E+XgonvdmkMNuDnshK9mQKa01UgoTav6cNfqatgEzlZ4uCRHstzYci6mBhnXe8
         p53QiWYAuBOeGkJTqxGFTQMbu2oqWitBdtQH8XlAMgYWrGhBKlRP+6OiH9iLo8gRXobM
         QsLTnkYxMFtyTabfFV1bj5hzDszu+HhbJhwkOezyeZuqpIEBhqyW7lYqC4crob1/kpjd
         JM7iBbQ9OrcjeJ/ATtV5N/pZN3El5VDFrbKG9o5tfOXIJK+P3+8BVyUGlQDORAB50DwT
         +o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749279; x=1794354079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DG252wxWFY4VFP7NQq4EPNRF6QYNWw5dgS/1j2l70qQ=;
        b=THoRDZZbbSBE1ssAKhs3/csjFahDE4k+I1Pt+OIzsmJSNy6Fc0/DY+ljiQG17dI2Hc
         7pqSu7di1exjM1yEV9UCWtg2fNLTvZXiidVoEpXCG+lPBKco91FrprGvu8I6pr28ervY
         GZJKDpXMZnngarsIlXTBZl6iXQw6ciSzwV8+/j4HoIgOLVwJ4FyVeVaKQYX/77AB1aza
         tTa2W2eK0wxemx07iNRR3a8TZ45yY6Ehhxv9orL8AHfkSCPIISMAYXstmyqiq81PAfe9
         qBaGE0jLn+PZ1u8HjN2gthhodfQLQUe3v4gb6JbJklvXoK5U9SJxce4vwt2jBqB5uvDC
         S0+g==
X-Gm-Message-State: APuU4Z/9AYlnsOY8q5I1/DlKyLBVIyLUDBRsArRJdgWRl/BthqOpMEPX
	euU/4kJmaMjqnISRsomW+0LDZqQ4lpYHdJp4TMZG37DRE/bifMkfcRnZikAhCA==
X-Gm-Gg: AYBFou2r285elBwruKiy4ty2uaKXU7Y5HEPjkkbBPq48uvLFFIA9P6YPaVkxheeZ31J
	FcCOktVRjfoJZDJnLgqqpkuUluQEzc9BIzUqsc9RokrPs0FSbwvIdoAjkdhOE82/IYCGT6bj57e
	PNvEIwyU5vJ3ViVIxM0geC9QLKBUf9VotXaxm7Ra3aqxo5YBO+IJFDtdw8al7yF70ymfG0Zh5Uk
	PEPbKqmvnZnuDMPIKUU8dEa0niglPz5ZC+GU+SvINuL7pUWBhyVlLFqebVxP+JrGggIUdvb/bmj
	jgT2GtwwDLdR29M5z099HS7PzybKWsK1Q87gOf4n1eDcoKSV6L0b7z6YKk/dli+4fA4ZO5InT8M
	uk6gmC4F7s0o6WtxUIhcZk9bfBvncTwzDTa9V3LkQbYkp8HCo//HsqMi+zUpvcOK7ThvTf3TEzr
	2uSdDyIRfBOPmuOU9BIPHPLj+sATtFMYm5AV5EdRbV2AyoyoQAdnfSBSDahTvd1tYLB9FwlpkxG
	I4s0WzsGwkVRVbjHAjrAHvu3Eg3gUN4AdL8EV7MKnE6nxZdmaXA0Xb8IjP0Ga8FcEEZX29l4+zr
	mLKQDqWYEOAAtSRbNfHmI/A1p6d0WWFojkczxSI5FFazXrny5KGC1u8F1H5mf7rAzrM75BS6Gv1
	YU5DQgsPDDMbZ2O4gQcKSloTCg8naDYNS0osa3cAz6/VF+dMGktAeqgjS81a3dF6vO/Zf0dd2uA
	4=
X-Received: by 2002:a17:90a:e397:b0:3b0:96ce:104f with SMTP id 98e67ed59e1d1-3b096ce1144mr283855a91.5.1793749278672;
        Tue, 03 Nov 2026 15:41:18 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm6230631a91.5.2026.11.03.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:41:18 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 02/37] selftests/bpf: Test range of a packet pointer after a number is added
Date: Tue,  3 Nov 2026 23:40:27 +0000
Message-ID: <20261103234104.208239-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
References: <20261103234104.208239-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

In each test the prog checks 54 bytes of the packet. Then it adds a number
that is not a constant to the pointer:

 - [0, 38]: the range stays, 16 bytes after the sum can be read.
 - [-4, 4], or [1, 54] that can get to the range: the range is cleared.
 - The sum has a new id. A comparison of 'sum + 100' with pkt_end must not
   give 107 bytes to the old pointer.
 - var_off makes umax of a sum smaller by 2. The range must follow, or the
   prog reads 2 bytes after the packet.
 - 'pkt + 4' plus a loop counter 4, 12 .. 36 is a multiple of 8. Only the
   step of the counter shows that. The prog loads with
   BPF_F_STRICT_ALIGNMENT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_direct_packet_access.c | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index 139ff019d87d..6c1d2014b95b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -1032,6 +1032,106 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/* r2 = pkt, r3 = pkt_end, r4 = unknown. 54 bytes from r2 are in the packet. */
+#define PKT_54_BYTES(insns)						\
+	asm volatile ("							\
+	r2 = *(u32*)(r1 + %[__sk_buff_data]);				\
+	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);			\
+	r4 = *(u32*)(r1 + %[__sk_buff_mark]);				\
+	r5 = r2;							\
+	r5 += 54;							\
+	if r5 > r3 goto l0_%=;						\
+	" insns "							\
+l0_%=:	r0 = 0;								\
+	exit;								\
+"	:								\
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),	\
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end)), \
+	  __imm_const(__sk_buff_mark, offsetof(struct __sk_buff, mark))	\
+	: __clobber_all)
+
+SEC("tc")
+__description("direct packet access: checked pointer plus non-negative unknown keeps range")
+__success __retval(0) __flag(BPF_F_ANY_ALIGNMENT)
+__naked void pkt_add_unknown_keeps_range(void)
+{
+	PKT_54_BYTES("if r4 > 38 goto l0_%=;"
+		     "r2 += r4;"
+		     "r0 = *(u64*)(r2 + 8);");
+}
+
+SEC("tc")
+__description("direct packet access: checked pointer plus unknown that may be negative")
+__failure __msg("invalid access to packet, off=16 size=1, R2(id={{[0-9]+}},off=16,r=0)")
+__naked void pkt_add_negative_clears_range(void)
+{
+	PKT_54_BYTES("if r4 > 8 goto l0_%=;"
+		     "r4 += -4;"
+		     "r2 += 20;"
+		     "r2 += r4;"
+		     "r0 = *(u8*)(r2 + 0);");
+}
+
+/* The byte is in the packet, but a range that umax gets to is not kept */
+SEC("tc")
+__description("direct packet access: checked pointer plus unknown that can get to the range")
+__failure __msg("invalid access to packet, off=0 size=1, R2(id={{[0-9]+}},off=0,r=0)")
+__naked void pkt_add_up_to_range_clears_range(void)
+{
+	PKT_54_BYTES("if r4 < 1 goto l0_%=;"
+		     "if r4 > 54 goto l0_%=;"
+		     "r2 += r4;"
+		     "r0 = *(u8*)(r2 - 1);");
+}
+
+/* If r2 kept the id of r6, the check of r2 + 100 would give 107 bytes to r6 */
+SEC("tc")
+__description("direct packet access: sum that keeps range is checked, old pointer is used")
+__failure __msg("invalid access to packet, off=106 size=1, R6(id=0,off=106,r=54)")
+__naked void pkt_add_unknown_gets_new_id(void)
+{
+	PKT_54_BYTES("r6 = r2;"
+		     "r4 &= 7;"
+		     "r2 += r4;"
+		     "r5 = r2; r5 += 100;"
+		     "if r5 > r3 goto l0_%=;"
+		     "r0 = *(u8*)(r6 + 106);");
+}
+
+/*
+ * r4 is 0, 8 .. 48, but its umax is 50. 16 bytes from r2 = pkt + r4 are in the packet: r=66.
+ * Then 0 or 8 is added: 8 bytes are left. var_off makes umax 56, not 58, so r=64, not 66.
+ */
+SEC("tc")
+__description("direct packet access: var_off lowers umax of a sum that keeps range")
+__failure __msg("invalid access to packet, off=64 size=1, R2(id={{[0-9]+}},off=64,r=64)")
+__naked void pkt_add_unknown_var_off(void)
+{
+	PKT_54_BYTES("r4 &= 0x38;"
+		     "if r4 > 50 goto l0_%=;"
+		     "r2 += r4;"
+		     "r5 = r2; r5 += 16;"
+		     "if r5 > r3 goto l0_%=;"
+		     "r4 &= 8;"
+		     "r2 += r4;"
+		     "r0 = *(u8*)(r2 + 7);"
+		     "r0 = *(u8*)(r2 + 8);");
+}
+
+/* r4 is 4, 12 .. 36. Only its step says that pkt + 4 + r4 is a multiple of 8. */
+SEC("tc")
+__description("direct packet access: checked pointer plus loop counter, alignment")
+__success __retval(0) __flag(BPF_F_STRICT_ALIGNMENT)
+__naked void pkt_add_counter_alignment(void)
+{
+	PKT_54_BYTES("r4 = 4;"
+		     "l1_%=: r5 = r2; r5 += 4;"
+		     "r5 += r4;"
+		     "r0 = *(u64*)(r5 + 6);"
+		     "r4 += 8;"
+		     "if r4 < 40 goto l1_%=;");
+}
+
 SEC("tc")
 __description("direct packet access: no pruning of a path whose checks prove fewer bytes")
 __failure __msg("invalid access to packet, off=255 size=8")
-- 
2.55.0

