Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753458;
	b=5WTrKLpI4loSgP5TTQmfxUbAM8DsZ8/Qgg6eV4BydZtAoXlvxgaDrULTDBzkL/9H4AMu
	 KBVSHp2jzde1gBOEsp32Vg11R/1PUmVo4SGKOaeFLz/1PkKSpZOCS3Mg+VQNioBcorv2A
	 tYYkFRflbVcbB7krdYtPrYRCGXTYgGE4nmoRdsATkN+wDwEJFHzBRDh3jhfChFGdyj6Bz
	 Wsq/imkFI+lPdKXYKdMo0x1V9PeataPJM+7SHcu4CNWjxZkZkW0sDetQZxQS/MYvQgDEZ
	 +T8hI7QrUAdVPzy32bPVPDhptf8eOgHlz42CTvc1ILYaOKbnb1dZvGXKji33U4DgkKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TZFY0nWk89RIttQycWfHfmi3Uv3kaULeHN2GeypqrKs=;
	b=ji9n6RPx5bTn73WJe7ofm6W52YdCOrHmKqBO/yfj0FOLR4QR3OuUqVUYXI04WBPHu0rW
	 Hb2MOoEqQby/X61XcE2+5Nkj3Tu8SBUfvBJE2gdiv+kED3Zn4+IOAaKiEtfXOljhgxwYU
	 rpbcbfCf2s7AcSLqbZmZ4jXelE6Brs67F4SgV89HJDD5YvaVJFhvswt/3wqTJs6j7r84K
	 aXLE6YmElAMFIbMzYRyjyb2GGZuZpdMRrjPaQ2fIAMnRqP3nSeaWULAHo78JKPjAZpAsA
	 KQzIcyI53dkBPue/M2Runq+xyAyRazvEZbaIcrHGPtA0wO+BUtpLGdgcHtWhiWK8mdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dbIl5CZB;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B0606A31E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E0B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dbIl5CZB
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so2899374f8f.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794753456; x=1795358256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TZFY0nWk89RIttQycWfHfmi3Uv3kaULeHN2GeypqrKs=;
        b=dbIl5CZBTlZARi63kuoDghFVe2FXcO1LMdDeRqXWoj4s6usVbGU/Ee5bTMidXDwiro
         On9rPGsq6pRmeXQNPyVgPLs02pMGlubT/7jSYEKOabny1JNKW9BeiyCJEguOmM4JXSP2
         8kg3aLkDQShWXXWajzbIf4VYzaLKi1l4tkrmioKCWgUXfACFxqwrqKI3DsoqGnBPuSax
         eqm+rxN2elipMluqrHYhz69lN9MSNixobHK76TNGzZdOGQDt+67D5b1ovOQMaos9wQ9k
         vDxSvC68KdJWakHd78r9QqzG9g70S/CF3Y+ADs8XF/rczpISsEKNn3q15ntorz9eb/eq
         flAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794753456; x=1795358256;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZFY0nWk89RIttQycWfHfmi3Uv3kaULeHN2GeypqrKs=;
        b=hZ9bjK2OJcdm2n4HNW+YjQY051tQJs01bfiGTxxVugxFxhUM3B54gsSNJYouTKKToe
         NjFcn6VjRc9HI18hUl0BXdwQKmZoTpfdK7v+lwa2c4KGuiSDNSuvvFX2QleGxCb5cCrd
         ja7gTicOspK5YCfdN7W4HxGFPnYw8WMFYx/wYliW1No1RF8nNL91EW/WZRXDr9DkKv25
         /LB3UNUB0ZeXnJ/WNvhiNjeTY2whTRpbh+5y8KCIu3QVZrjs16VnutbYQq54hxNxp9UH
         7kS5Z4YL2Y51BVx8fSDZolXWmF99lRi8QROdq3f/uG3yRdLzVDpZ17sWE+gho+/lTnGY
         RtfA==
X-Forwarded-Encrypted: i=1; AL+hErGZIjMZUORrqamGoX8PmcC2+/uWCP0fcHaEZw0BavjBli3i5sQ77UT058fyJ2VCcR4vflY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cyDIsawXm49m61zjjM9k6JAVzeQJZOyYR3SV/CnxBIlzs2I6J
	frpF+nN/B/uVkYG1MYiEsx8gbo0g1bO8avSIE9aODWJUvooDeUokAqSK
X-Gm-Gg: AYBFou3hq+6ISs5Yv/FxN31C5Q3o0jY6JL7eijfhnuVVnHZa1PD+VX3WdgkkwKWzc/4
	9LO0usMgVCwBMrr1ctcDDV7HpFkvSWDAoXWhBOGUdY+bJpYA8M5c5v6Bdw2D3a2jRi4F/Hgs8Kx
	XBcp5npfjqyY23H4G+Biap0ZNgvKX52gefE/pY3ju05x5OzuR/9m6l8D4/JrdQ0r5SHFIJ6sNTX
	yT/Ef24GbjBNToqRY9G0DGg8zCiTKVetMkK1BXEVryvZ5tMRDoZnAzjz4fEM6G7sqhWTBGVcF8x
	jcWi46CsbGwD7eIG1gMrmkfg8kR9WBaXqMWVVsqQ8CoMAFWhR+orwXzxjKqopJECCL7814lD2ud
	jTXvkUTHelry3sWoynJ3Oy3iytqo9lm3wvChWjsIr0V/BHr2DO3+PqmwhmoT4T145sJtmH+dDjI
	PKjU6OKvSShm+qEqFIApnHD+Kbchg5jNZJDlxxnMbb6TJgVNQnCXZvXAztv/1yPRzBwSWh0p4e2
	axU8NVjcdwPBF3Qq/CjZJHxovlB41lF+Mrb9ex0wgKpUTlWtqnnIIyDVb3Kw/wiRc1b1bUjF1Y9
	NMY3j0uaPR//vy36fabDaG4AGbPLBFFfh4BtfrR1lWxGfzDuDrm+tVydEdzQO/fUPw==
X-Received: by 2002:a05:6000:2990:20b0:48e:3d2:44b1 with SMTP id ffacd0b85a97d-49c7353c8aamr12310750f8f.52.1794753455945;
        Sun, 15 Nov 2026 06:37:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60f8d615sm16954821f8f.56.2026.11.15.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:37:35 -0800 (PST)
Date: Sun, 15 Nov 2026 14:37:34 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Hungyu Lin" <dennylin0707@gmail.com>, <andrii@kernel.org>,
 <bpf@vger.kernel.org>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
 <daniel@iogearbox.net>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <emil@etsalapatis.com>, <alan.maguire@oracle.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Fix sign extension of unaligned enums
 in btf_dump_get_enum_value()
Message-ID: <20261115143734.4addeb28@pumpkin>
In-Reply-To: <DMUPC8KHIGGC.1GSNJVGA8XC98@gmail.com>
References: <20261113223449.97604-1-dennylin0707@gmail.com>
	<DMUPC8KHIGGC.1GSNJVGA8XC98@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 05:58:41 +0000
"Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:

> On Fri, Nov 13, 2026 at 02:34 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
> > btf_dump_get_enum_value() reads unaligned enum values through
> > btf_dump_get_bitfield_value() with a zero bit size. That path
> > zero-extends the value instead of using the signed loads that are used  
> 
> Not quite. bit_sz == 0 makes right_shift_bits == 64 in
>   *value = (num << left_shift_bits) >> right_shift_bits;
> That's undefined behavior for __u64 on both endians.
> Pls say it in the commit log.

Isn't a size of 0 just wrong?
The code is likely also wrong for a size of 64 - which is valid.
I also remember there being a helper somewhere to sign extend
a 'narrow' integer.

David

> 
> > +	if (t->size <= sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {
> > +		if (data + t->size > d->typed_dump->data_end)
> > +			return -E2BIG;  
> 
> This breaks the dump of struct fs_context when emit_zeroes is not set.
> 'phase' is an enum bitfield of 8 bits, 3 bytes before the end of the
> struct. btf_dump_type_data_check_zero() ignores bit_sz of an enum:
> 
>   btf_dump_struct_data()
>     btf_dump_dump_type_data(data = end - 3, bit_sz = 8)
>       btf_dump_type_data_check_overflow()    1 byte, ok
>       btf_dump_type_data_check_zero()
>         btf_dump_get_enum_value()            t->size == 4, unaligned
>           end - 3 + 4 > data_end             -E2BIG
> 
> Today it reads 1 byte past data_end and the dump succeeds.
> The over-read is an old bug of enum bitfields. It needs its own fix.
> The fs_context test in test_btf_dump_struct_data() sets emit_zeroes,
> so it doesn't notice.
> 
> Drop the check. btf_dump_int_data() copies without it.
> The check against data_end belongs in one place for all types.
> 
> The first case below fails on bpf-next today.
> The second case fails with this patch.
> I didn't build it and didn't run it:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index b5c90f7..d6fd993 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -945,7 +945,7 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
>  				    char *str)
>  {
>  	__u32 high = 0x80000000;
> -	__s32 neg = -1;
> +	__s32 neg[2] = { -1, -1 };
> 
>  	/* enum where enum value does (and does not) exist */
>  	TEST_BTF_DUMP_DATA_C(btf, d, "enum", str, enum bpf_cmd, BTF_F_COMPACT,
> @@ -994,6 +994,8 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
>  				"(enum test_enum_u32)TEST_ENUM_HIGH"), "dump unsigned enum");
>  	ASSERT_OK(btf_dump_data(btf, d, "test_enum_s32", NULL, 0, &neg, 4, str,
>  				"(enum test_enum_s32)TEST_ENUM_NEG"), "dump signed enum");
> +	ASSERT_OK(btf_dump_data(btf, d, "test_enum_s32", NULL, 0, (void *)neg + 1, 4, str,
> +				"(enum test_enum_s32)TEST_ENUM_NEG"), "dump unaligned enum");
>  	btf_dump__free(d);
>  }
> 
> @@ -1182,6 +1184,12 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>  		type_sz = btf__resolve_size(btf, type_id);
>  		str[0] = '\0';
> 
> +		/* 'phase' is an enum bitfield 3 bytes before the end */
> +		ret = btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts);
> +		ASSERT_EQ(ret, type_sz,
> +			  "unexpected return value dumping zeroed fs_context");
> +
> +		str[0] = '\0';
>  		opts.emit_zeroes = true;
>  		ret = btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts);
>  		ASSERT_EQ(ret, type_sz,
> 
> pw-bot: cr
> 

