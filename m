Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C233EB0E3;
	Tue,  6 Oct 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294824; cv=none; b=PpafEwYSYhTd6IxIJXJT2W+wjsdLdixe8A0WPWQsQOinZGD0ZXFRimsLVRd7XtScrlUnxBuIPEQbijSyw3noELe5U/cSjQQkPr0NwwO9ukWWVquTPHw5XwTE/Z8AC8vS8CsFr3auKTOeG2tbME+XzTAsKm4lVUrSEZm7eDCFPyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294824; c=relaxed/simple;
	bh=jC+DwEjR/EP/Nc4vMhGqHlE//WvyyOKP+eiXvOuchsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DilzPUT+jfuneK5eQ0QI7TVYsUigDils0dFo6UWRTLe0b6gISK4IWYoK2XV+DhkR4TwGnRhwmUJLRtAxXgJjbqyFIzooLXLJlkrkfmQb7D5VZa4Ye8xYSenLZQJ7daO4JQkSPbm3tb3TbnQgOFfCD+GvvgDZl43zKsv2q+8s7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16751F000FF;
	Tue,  6 Oct 2026 13:53:36 +0000 (UTC)
Message-ID: <342ca584-c4ef-4d73-9017-9d21bbf9ce10@linux-m68k.org>
Date: Tue, 6 Oct 2026 23:53:22 +1000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] m68k, bpf: Add initial BPF JIT compiler support
To: bot+bpf-ci@kernel.org, visitorckw@gmail.com, corbet@lwn.net,
 skhan@linuxfoundation.org, geert@linux-m68k.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, andrii@kernel.org
Cc: rdunlap@infradead.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, jserv@ccns.ncku.edu.tw, marscheng@google.com,
 eleanor15x@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 bpf@vger.kernel.org, daniel@thingy.jp, martin.lau@kernel.org,
 mason@kernel.org
References: <20261005185251.2422114-1-visitorckw@gmail.com>
 <506b804c97aaa3a66660bb0eebd85c6041e241532c1227f1012166785d240fae@mail.kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <506b804c97aaa3a66660bb0eebd85c6041e241532c1227f1012166785d240fae@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Why thank you LLM review :-)

On 6/10/26 05:48, bot+bpf-ci@kernel.org wrote:
>> m68k, bpf: Add initial BPF JIT compiler support
> 
> TL;DR: Nit only, not a bug: the ColdFire byte-swap instruction sequences are
> open-coded repeatedly in emit_to_le16/32/64() in the m68k JIT; suggests small
> shared helpers, as arm's bpf_jit_32.c does.
> 
>> diff --git a/arch/m68k/net/bpf_jit_comp.c b/arch/m68k/net/bpf_jit_comp.c
>> new file mode 100644
>> index 000000000000..6c40d358acd4
>> --- /dev/null
>> +++ b/arch/m68k/net/bpf_jit_comp.c
>> @@ -0,0 +1,1840 @@
> [ ... ]
>> +static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
> [ ... ]
>> +static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
>> +		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
>> +		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
> [ ... ]
>> +static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
>> +{
>> +	if (CPU_IS_COLDFIRE) {
>> +		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
>> +		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
>> +
>> +		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
>> +		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
>> +		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
>> +		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
>> +		emit_16(ctx, 0x0004);
>> +		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
>> +		emit_16(ctx, 0x0004);
>> +		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
>> +		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
>> +		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
> [ ... ]
> 
> This isn't a bug, but the ColdFire byte-swap sequence (mvz.w / mvz.b /
> lsr.l #8 / lsl.l #8 / or.l) is open-coded once in emit_to_le16(), twice in
> emit_to_le32() and four times in emit_to_le64(), differing only in which
> register receives the result. 

I did consider using helpers for these during coding, but ultimately decided
against it. The open coded versions allow for a handful of extra instruction
optimizations - due to that flexibility of producing the 16bit swap sequence
result in different registers. For example I could combine a stack pop with
the or'ing of the result, and more efficiently store an intermediate result
into the temporary stack storage.

The patch below gives an example of an implementation using helpers. I am not tied
to the open coded version: Kuan-Wei if you prefer the code with helpers feel free
to use this instead.

FWIW, the to_le32 coded sequence is 1 instruction longer (17 instructions to 18).
The to_le64 coded sequence is 5 instructions longer (34 instructions to 39).
Total byte count differs less, due to use of offsets in the open coded versions.

Regards
Greg



--- arch/m68k/net/bpf_jit_comp.c.org	2026-10-06 23:08:25.924094287 +1000
+++ arch/m68k/net/bpf_jit_comp.c	2026-10-06 22:51:13.099505355 +1000
@@ -640,14 +640,19 @@
 	bpf_put_reg32(dst[0], d_hi, ctx);
 }
 
+static inline void emit_cf_swap16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);			/* mvz.w d_lo, d_lo */
+	emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);			/* mvz.b d_lo, d_hi */
+	emit_16(ctx, 0xe088 | d_lo);					/* lsr.l #8, d_lo */
+	emit_16(ctx, 0xe188 | d_hi);					/* lsl.l #8, d_hi */
+	emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);			/* or.l d_hi, d_lo */
+}
+
 static inline void emit_to_le16(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
 {
 	if (CPU_IS_COLDFIRE) {
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
+		emit_cf_swap16(ctx, d_lo, d_hi);
 	} else {
 		emit_16(ctx, 0x0280 | d_lo);				/* andi.l #0xffff, d_lo */
 		emit_32(ctx, 0xffff);
@@ -657,25 +662,23 @@
 	emit_16(ctx, 0x7000 | (d_hi << 9));				/* moveq #0, d_hi */
 }
 
+static inline void emit_cf_swap32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
+{
+	emit_16(ctx, 0x2f00 | d_lo);					/* move.l d_lo, -(%sp) */
+	emit_16(ctx, 0x4840 | d_lo);					/* swap d_lo */
+	emit_cf_swap16(ctx, d_lo, d_hi);
+	emit_16(ctx, 0x2000 | (d_lo << 9) | d_hi);			/* move.l d_lo, d_hi */
+	emit_16(ctx, 0x2017 | (d_lo << 9));				/* move.l (%sp), d_lo */
+	emit_16(ctx, 0x2e80 | d_hi);					/* move.l d_hi, (%sp) */
+	emit_cf_swap16(ctx, d_lo, d_hi);
+	emit_16(ctx, 0x4840 | d_lo);					/* swap d_lo */
+	emit_16(ctx, 0x809f | (d_lo << 9));				/* or.l (%sp)+, d_lo */
+}
+
 static inline void emit_to_le32(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
 {
 	if (CPU_IS_COLDFIRE) {
-		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
-		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
-		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
+		emit_cf_swap32(ctx, d_lo, d_hi);
 	} else {
 		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */
 		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
@@ -688,45 +691,12 @@
 static inline void emit_to_le64(struct jit_ctx *ctx, s8 d_lo, s8 d_hi)
 {
 	if (CPU_IS_COLDFIRE) {
-		emit_16(ctx, 0x2f00 | d_lo);				/* move.l d_lo, -(%sp) */
 		emit_16(ctx, 0x2f00 | d_hi);				/* move.l d_hi, -(%sp) */
-
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
-		emit_16(ctx, 0x202f | (d_lo << 9));			/* move.l 4(%sp), d_lo */
-		emit_16(ctx, 0x0004);
-		emit_16(ctx, 0x2f40 | d_hi);				/* move.l d_hi, 4(%sp) */
-		emit_16(ctx, 0x0004);
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x81af | (d_lo << 9));			/* or.l d_lo, 4(%sp) */
-		emit_16(ctx, 0x0004);
-
-		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_hi << 9) | d_lo);		/* or.l d_lo, d_hi */
+		emit_cf_swap32(ctx, d_lo, d_hi);
+		emit_16(ctx, 0x2000 | (d_lo << 9) | d_hi);		/* move.l d_lo, d_hi */
 		emit_16(ctx, 0x2017 | (d_lo << 9));			/* move.l (%sp), d_lo */
 		emit_16(ctx, 0x2e80 | d_hi);				/* move.l d_hi, (%sp) */
-		emit_16(ctx, 0x71c0 | (d_lo << 9) | d_lo);		/* mvz.w d_lo, d_lo */
-		emit_16(ctx, 0x7180 | (d_hi << 9) | d_lo);		/* mvz.b d_lo, d_hi */
-		emit_16(ctx, 0xe088 | d_lo);				/* lsr.l #8, d_lo */
-		emit_16(ctx, 0xe188 | d_hi);				/* lsl.l #8, d_hi */
-		emit_16(ctx, 0x8080 | (d_lo << 9) | d_hi);		/* or.l d_hi, d_lo */
-		emit_16(ctx, 0x4840 | d_lo);				/* swap d_lo */
-		emit_16(ctx, 0x809f | (d_lo << 9));			/* or.l (%sp)+, d_lo */
-
+		emit_cf_swap32(ctx, d_lo, d_hi);
 		emit_16(ctx, 0x201f | (d_hi << 9));			/* move.l (%sp)+, d_hi */
 	} else {
 		emit_16(ctx, 0xe058 | d_lo);				/* ror.w #8, d_lo */




