Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794635923;
	b=nsk0QS4f4XKZ1hZmhaDyhmRCK3ewnneSj02ka6gRsxGZVPpkt7Ne4cmHAJbzRNDEBEsl
	 pxQUTct3nyApLOYPjubT+41jL/O5VmAC/mwszKqy8oXzcB3USwPhoCrT6ww58shwkVdj4
	 DhtnrxRKkGMx2hmzpSJGvSiKFRULP858MJUfPbz/n9eQvD4HgTmzE461N0tC1XpoUac4C
	 rkK04Ugs9ERjsgWuGzTVfaO+Dcky+TCtifBLAxLtFIlM4ONJBs67BY6qWKDxVDsDKt46f
	 M55t8C9lMYMTQOVwotRb7yCvzRhudYXylp60g8ob8R620ZRm/5sQcAy0AHjgdlFT9xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794635923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Ym/b1fWsEbJtm9qFvOFht1VdLbQA2jNfhiJxfk6+BKU=;
	b=xPz4chrmgjimbaYl0mlSbwjFuaMcBONUfbrIyG86radq2GLgRoTBGsGpi8EodGrVhQGn
	 y4eCFZthLjwxcVCxjnNpJG2ivFd3vuRNRf1qthGXUiSQZndEI5gOWTETN0yE0EOFArg0T
	 CUEtWdeBjzHMLbTJYZnwiHwNBbLrphRZQ2e/C3q97Hhpovg1kkCSJLWGAf9yOhXsPzqu/
	 RxAQ6XDOzOMMq/7v6lawTy6W4nVA0dMMSOwQfDv2+MC/2eieuYtHTTsN43dY0WcA8dv9c
	 h/9tKptLd8zwY9CJxBwBvJFnkVA257Y0bBrtNplLA5Vkm+as2PWlPSaWeotlrnwd6ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAMSHfJS;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F814606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F814606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAMSHfJS
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ee0533d249so6451735ad.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794635922; x=1795240722; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ym/b1fWsEbJtm9qFvOFht1VdLbQA2jNfhiJxfk6+BKU=;
        b=iAMSHfJSyZ9aJiv8I2N2EwOA0IagQKe+xY0cWdblJ1VkkBcu1DaDiYHnj/WX701mMs
         bNg53GAa1AuloyF0zl7ct869w7xQdvk4H2hAQJAX8sdPVO1IWF+XuuVyxqjn9BMMFntx
         gj0bbZcPyT5WfAJOh8l9Smumxzu0oj26xD5Z4or/VyPb73ZPq/JOBF0ps+/CFuHFaXE+
         YsYltkrh2t6jR7x2zLZBWD4DJWlFXzJg1mRNLniAMiDjZYjGDvhEd7HdQr/JWcltj1w8
         qUrGFD48E6ynEJDqHdi0+st27DrGP33AGQcwTVEeSDOXP3DUVcg8S+t4HAkboFW8jFMv
         qYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794635922; x=1795240722;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ym/b1fWsEbJtm9qFvOFht1VdLbQA2jNfhiJxfk6+BKU=;
        b=B3EIVuxLL24fFXUPZwmUvXP84nIyWE6XX/ZQw/TOQts9iU13s0OWnZ29rZYhbhu8zv
         LZizOkbgBakT9inTpt63xMAG/1lD/wh9eBzJlsFGOGTCggrb6msJrK0kEHlRtIgVhRBW
         48dF2TPCnXMPxnu7/RYM/JehsZdhiB4sn9TQbxEjBtk3LkODUU6NMnU5T0NrqquxAlTm
         6lhFQt5sWXS1uTrq/clMkOxwWc9YIpvakaXjYKso7OwGEMD4peGOibIrpPGcnvecAbPL
         +sOxWbS5o5Tf7ow0m4v2wXD0GKNnPnTrK3S1t0WyqvVARdNmVDnAbce/jm/mvX/fFwCG
         JGUA==
X-Forwarded-Encrypted: i=1; AL+hErFl4a0qo+E9EHEK1lVkkfv2l3S6CT5nqZemvtGjP9rWD+d3EgKApehuP6KXItlB2KhRWTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DON2+763NE3RnFdaVCXah+PrPBZEhTO7lmFPxEp4xnIR7Vu8x
	j8GN48JtpzSM8ca98myK4hT/Vjoa4SDGPHa5ITfdsi3+6KP6keY/esRmh797oQ==
X-Gm-Gg: AYBFou2zHsoIUawinERx7Jv+H9ZbECba5M9/4z/s1zMBWjILDaNdkOsngwVf7roUAoo
	m424uAjZ62MaAFuFMo5iJ41ExyQdvisitcLt5V1ajL7QwC1kshn99jqR9K8HgI91A5sTs30X2J1
	xitPk601aHRDmrRAvGTA/BtuTrsaJXJDrPoxymUfE9bch00M9L4FMoEmkza8ClEYfIx5b4gGspn
	4FUnrubKFWB3cbdmFUOLOvKQU/ic+bn9Mn5tSLoYYFkh2DEq5fkpzd+Xtv02IlLa0BNUzOiEruX
	pC8U8K1+PMZ7YjWjgyxXqxbq927embnoCDkAzJDCCLy/NNQ5TxPW4Me3ETm5b8AWp716I1Gd4n7
	JwrCQHOZ14hE5JG90JCXGb0z3pLUBZJoSkspb3Kxr2GxqWKPCzbj9voI0XFsKW5VmSbbFTTsi3H
	giuBrt8cqIdt6KhsSal9vGWRde9DCkA4QB2ds2gBd6f8AdDL4GoXy3FaDM9HnQH9sePLVC71ryB
	js0JVX/wp/Ue5w+Tl6vwmmDPbN9sr9TD6o8dKUWbqE/GqjtZPeey1W5eK3mOsLT5pnMqlVOE5Ce
	fBUlk11fJo2DcAKIviA5Rjt4r1kfMo3Ku9rlZAyzYPek4O03ncKrlw1n13gdsFcPMFckA79e7ic
	IGtOTgL+Jk14GD1NBC6OoU0gVHRtTSGW99A==
X-Received: by 2002:a17:903:184:b0:2eb:201c:91a8 with SMTP id d9443c01a7336-2ee0de4fa67mr48849665ad.29.1794635922261;
        Fri, 13 Nov 2026 21:58:42 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f862744sm17702925ad.44.2026.11.13.21.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 21:58:41 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Nov 2026 05:58:41 +0000
Message-Id: <DMUPC8KHIGGC.1GSNJVGA8XC98@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <andrii@kernel.org>,
 <bpf@vger.kernel.org>
Cc: <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <alan.maguire@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Fix sign extension of unaligned enums
 in btf_dump_get_enum_value()
In-Reply-To: <20261113223449.97604-1-dennylin0707@gmail.com>
References: <20261113223449.97604-1-dennylin0707@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 13, 2026 at 02:34 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
> btf_dump_get_enum_value() reads unaligned enum values through
> btf_dump_get_bitfield_value() with a zero bit size. That path
> zero-extends the value instead of using the signed loads that are used

Not quite. bit_sz == 0 makes right_shift_bits == 64 in
  *value = (num << left_shift_bits) >> right_shift_bits;
That's undefined behavior for __u64 on both endians.
Pls say it in the commit log.

> +	if (t->size <= sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {
> +		if (data + t->size > d->typed_dump->data_end)
> +			return -E2BIG;

This breaks the dump of struct fs_context when emit_zeroes is not set.
'phase' is an enum bitfield of 8 bits, 3 bytes before the end of the
struct. btf_dump_type_data_check_zero() ignores bit_sz of an enum:

  btf_dump_struct_data()
    btf_dump_dump_type_data(data = end - 3, bit_sz = 8)
      btf_dump_type_data_check_overflow()    1 byte, ok
      btf_dump_type_data_check_zero()
        btf_dump_get_enum_value()            t->size == 4, unaligned
          end - 3 + 4 > data_end             -E2BIG

Today it reads 1 byte past data_end and the dump succeeds.
The over-read is an old bug of enum bitfields. It needs its own fix.
The fs_context test in test_btf_dump_struct_data() sets emit_zeroes,
so it doesn't notice.

Drop the check. btf_dump_int_data() copies without it.
The check against data_end belongs in one place for all types.

The first case below fails on bpf-next today.
The second case fails with this patch.
I didn't build it and didn't run it:

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index b5c90f7..d6fd993 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -945,7 +945,7 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
 				    char *str)
 {
 	__u32 high = 0x80000000;
-	__s32 neg = -1;
+	__s32 neg[2] = { -1, -1 };

 	/* enum where enum value does (and does not) exist */
 	TEST_BTF_DUMP_DATA_C(btf, d, "enum", str, enum bpf_cmd, BTF_F_COMPACT,
@@ -994,6 +994,8 @@ static void test_btf_dump_enum_data(struct btf *btf, struct btf_dump *d,
 				"(enum test_enum_u32)TEST_ENUM_HIGH"), "dump unsigned enum");
 	ASSERT_OK(btf_dump_data(btf, d, "test_enum_s32", NULL, 0, &neg, 4, str,
 				"(enum test_enum_s32)TEST_ENUM_NEG"), "dump signed enum");
+	ASSERT_OK(btf_dump_data(btf, d, "test_enum_s32", NULL, 0, (void *)neg + 1, 4, str,
+				"(enum test_enum_s32)TEST_ENUM_NEG"), "dump unaligned enum");
 	btf_dump__free(d);
 }

@@ -1182,6 +1184,12 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 		type_sz = btf__resolve_size(btf, type_id);
 		str[0] = '\0';

+		/* 'phase' is an enum bitfield 3 bytes before the end */
+		ret = btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts);
+		ASSERT_EQ(ret, type_sz,
+			  "unexpected return value dumping zeroed fs_context");
+
+		str[0] = '\0';
 		opts.emit_zeroes = true;
 		ret = btf_dump__dump_type_data(d, type_id, zero_data, type_sz, &opts);
 		ASSERT_EQ(ret, type_sz,

pw-bot: cr
