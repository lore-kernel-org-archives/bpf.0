Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655555;
	b=ahfLEONiMCiM/THSjCLsMV3DwK4iVfVk+8b9tMKsLKFjTwOp3IOOftl7IQ0D+SS+oRWC
	 AG5XKPleWywLi9bbFXQUqZjJ0hJqtKEB7xA3EOFaQSocopLsdMa0D9FbhDQbYia6VcRXj
	 U79XiPXOWmJt8n3AKG8H1JOagWegGr0wtBXClPefSMW9LaTelCgvACavlmHymbwAEJ4Uz
	 1nticaOfrG3SssDt0nnK3sSiHWf2gw4PbTOu6Hvu9cVtovOngNbR3iMZqUfKI9SiaHTZA
	 64Ml3DWT9Zsub3B4m7H46WxORpJsb8CpnLNHrESsaJYmklGSxHO1oKLaG3sh3FlKy7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
	b=m5ynsgYh15+l1VtL3c4k9xo0AQvhtWuAuG3JQt4YLgFM752kGA2/CFKCMoKtpSGT/rYo
	 KLIYcNPYHV8bZhbW9pQd/cLk2l0leof0ICyqATUNKPkcsGGBKdt1OkjnOzmDCcza75S4o
	 u3P19XQo534YqcXTGmH8OqDxAOfduPhZDbJfD9WiYpj96E9TXKmCKLLCXFV5pvanQjqDw
	 uJKJldGyvvnALNZyIe6zgtlvD4UEomvAjsj8di6y2lRTkmJwbEOY135wnXq1sBA9KPjYD
	 InlfqrkO//i6TK1AdPYUDd1w90O5ZR0YfUUhhgKcMi4GcHuDI+kKhcnaA2gznouFDog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="N85n/KuQ";
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D0606A6B4
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4D0606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N85n/KuQ
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso5048904eec.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655555; x=1796260355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=N85n/KuQnifDRI2YkEYLejB87Z6k0qrWRhF4Qz7XgmIhZmvTmF807YZe1yov5bGwX6
         oIuulHIcrWCbGQ6/eyb/Vzt/nwfyp3oUydZ7PicwMkebJ6fZ/NgjsT6o834ErBvgOLKw
         c3uBQ5LXY6wCtzI7tt8holDAgEgJnb1Ym51nQJSjVvE6PLd05GkVF6HEANYtob3adR0y
         j/pP3R2BXI3qaq20JTLFs/hnLz34BLgyS9FO+QrvK2HQxunyh2fL/lDkBfSjtXCCPfkf
         PaIg5qX29ViD1s12M2im5pamIDXPqgfju4bagGTlb6ugkUUwojOOokOECcnxhnkOeN3h
         4SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655555; x=1796260355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=P7Qbv0ThOCf1gj/ypOB3C1xOPrl/AX2Kvd6JC2Do95cvSgFxKmrfLDoYasQ4VUjjS6
         B/ZGBOLhsZlk+DJWy+ELgG/IN8EMOKupH0niIP1SP1bJMWDgKxkFK9Te0KQeMmUDKu/S
         pssAvR34GnQaBfpurP5HiYObREX4iDLG58qlb0QaPBxpmPlMGErsPsMycbufaoS9+0XX
         TvZxNO/GKoBrZnSrIw7KaFa6zhqC+MSEH1Dwpi60ICqC8Ei+KR3WU4IMdffnejifSGy0
         GzZYY4piP+f+2+cC92bWFMESHnhlyrE+j1CV+oVh2jONxFAkKffAXVa/qzh6QkNyZ1rJ
         +1+Q==
X-Forwarded-Encrypted: i=1; AL+hErEnTpYnOc+LxTzdnpIjvLzgQX5w8QeFTQkE0Qdv3QAcuk0W4IHsiIVxw/F9bUoOGGp30DY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7ocwLqv0berFk4L5yfnZdhCV1Bxkbq98OIRNRTJiiLtPPtt6D
	CDniX5BU7z6jK2bOveZ7TnWiDyg/cXJj1Wzhus01CFve0wAwF/3tqtBgyx81vGuXUYCDyw==
X-Gm-Gg: AZFdTZfR8LILA0/mCXcfAvpioxcAW+4xpS56FpYbsbsKR05Pd9iASbh2XvOTANcCeNv
	otD4Qrf0ksFZ5zBPPcZNNXxWvxbeQskLhmDpFC61eq+8gHCv2dferBTOi4+NGLTRCDYHUWiFLSG
	edCTQIBNdD6zyBMtKvC5no57qkjX3ga32o5+H+giJqCTfshGgT451+SP8tP/o105wAfHMWNTax+
	mgvszgFblizwLYkyIIshG5pSBt9GbSooCiT2lMl0tToy6J5Q67FG5RJ5HwV7KIiGFjhoUGBY6VY
	Y4v2BQ7IAqNRKnMlONz6arn48di4gUhhI+S57ogglrOfMv1uURPcbFtgaJaqPGh+XSei3VqsB+r
	anKVmALBIzT38IWUlznxi9pT3l4zBXP7mJx2mGSrnyCHusGzBbxT0elUsKWGK3mBX51t0Q/ywxt
	MlOCZCK/Pd2nvjKTvnDoNX4s0JgvQp55N084ixv8Ao76XYzJMQwqcY3tPHiwDZzWEJJUiK1p1j3
	vM5NI94LeoHjoG2K7tIH+dnwTKFKRhHSqBnjfgqLWW11EW3vFzyeg5bVBGC0KUluYmnO8z8e1pn
	toU7JLwnU6+WaT2aMv5ZBDi4fNP7+j9czESvoU3FRNtmy3BEzJY9VdFZ9yFAjJYT+aoulygV1RL
	PnRsxJiAFv1TXvuS5tiACVXSxtq6nclNiUAodNvG2Tc+/vhyuirxT68k4S/3USw==
X-Received: by 2002:a05:7300:fe4c:b0:386:9b1e:dcd2 with SMTP id 5a478bee46e88-3869b1edd57mr17277852eec.20.1795655554634;
        Wed, 25 Nov 2026 17:12:34 -0800 (PST)
Received: from localhost.localdomain ([76.33.234.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm55717751eec.15.2026.11.25.17.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:12:34 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: andrii@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	alan.maguire@oracle.com,
	shuah@kernel.org,
	alexis.lothore@bootlin.com,
	luisflavieira@gmail.com,
	ameryhung@gmail.com,
	david.laight.linux@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Dump unaligned enums and a zeroed fs_context
Date: Thu, 26 Nov 2026 01:12:22 +0000
Message-ID: <20261126011222.92180-4-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126011222.92180-1-dennylin0707@gmail.com>
References: <20261126011222.92180-1-dennylin0707@gmail.com>
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

Dump the signed enum value from an unaligned address in the enum data
test. Also dump a zeroed struct fs_context without emit_zeroes in the
struct data test, which covers phase, an enum bitfield 3 bytes before
the end of the struct.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index b5c90f729339..d6fd9933ff25 100644
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
-- 
2.43.0

