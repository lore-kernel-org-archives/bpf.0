Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816137;
	b=qSIUXKLxbe4luc8jxo2vvKuTylLaLcdAKTh9B0+yIByVVX5uTn9mDcAbaF9t738S5gRY
	 vCSZb3qPfb6BigzUds7gHTnZMdRDl0A6UIHcVuA8KKrgS7/vNQSMJCuE2Vd5BYrB0aPAc
	 SI60vRxZjxC6a8ZTn8Ywj0fgLFbzH2z5zJ1dK0No1Sca+zJXwirB8BRFn2j6jxdoY1guj
	 Uu5fiyn0r/2x3eSizJQhtTM0TLa1dCizxnpoHyjBtqffkjPyhC95ibPeAToOYWsk+ykUI
	 yH72u8hc26TE2HbliIkYjg5Rgt5+hqi4pDXKHlg7CcRLsedCj6sEeXahvsbQTNX/F6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
	b=IVIkvVg7fHPu2vZNZHoONzPZITMTnajnSMd8cs1SV5AMDmwu9X9DU/n6fhKjyXo3dHZY
	 rfksacvhMVDeqOYSsJQtO9GV2I2DvDQB2QVfpYYMlDkFP3RZ2ERedHwzpJ8yvh+ZmqT0Q
	 beE4Wqfj5jdUPgoepiyB0cYLOun3Ek+1bnlB2oL8W/WegiWsbraYnclCYBZ6anp8zpmM9
	 dZmSIH3kngDH3n/t6Yt9eZZ8eUICF7AaKUmBBJnG5R1CbAeKc8MIJ5zb5eNtzzQ2UDMaV
	 iiTrryoOKk0K0TFSjfn8+xY8neXowoKWqiZEXWI7+GlBDgMXgW6MMOh/EehprcPrM9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljwpme0L;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF693606A88A
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF693606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ljwpme0L
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso1253457c88.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816136; x=1795420936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=ljwpme0LQVKXeV3vl8q5H9ZscOlG+KxJ5e9vY8+nkJB4ivdBNlbTM366T9nOWo9/42
         jUi+q32tUIp5/HrR9lLe/28SOQe2SO+p8LWgPaELukXX2MA5lX3iyqrlJ9oQACY4E0Zl
         3dAOy/Ylb2i8HGGfAhQ3dkbj3Rz/oXni8NHExqvw+kLXHzVsEhJRwuucg/v9Xg9fTszx
         isGemQmELXHtTCtVazPEaLTowh7pzAxR7HIT3WRkrTIst7c79EaRRPSzKyPAcD4KHW5m
         ZY9GaowWCwFz4bBQpcirowYM1TzwIPHeG7FjvkLKi8O7y3b8GUmtTYc0tsmuFTcdLd5a
         gt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816136; x=1795420936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=IbCFqsAJ+RISx6eybaMRbE80d9m2VsZA8vUPS4yUuI8bQadRJAGeUcHr07OoIE41CZ
         8hF0n4I5+03UvzuKgjDzazcwO1UM+bgYJJ0ulw5s3FxkGvVONtQ/DkBgIVHmZo+Q1PLe
         4aeCR81eNI4adorGmHfAjXjR4Q7VJb35/Um1lDAHff0QqQsmuHPlLFSJmvitUqHWZonA
         UpOs0PiQuUJG3gy5ZPdM8Sueev/j5RJNsYc4KzE+Sk4w3im95YY2Xm8wWNc24vKqE0XG
         DKYxIu0RXasTUAc3z85to6NdW1kriBITMfbiCIu9Iv+isNTPFhlg/xWNERc+MJ9QVJJn
         xTfw==
X-Forwarded-Encrypted: i=1; AL+hErF0xK7rBPggYAz7tUrrD4Gy3zD/y0Nwjtyh71XQ2lNMMdID2Lbek1w6RkxrLpnu4L3C9yI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+whExSmCFzEGL2r0nOtRWcJsZisC7hf5zsQ0GPQQOK8mPi0THK
	c+YBXVwfAUiRNZMu6m4dpuGfK9Y8mpa1yeLVTX9JzItFGZPNY7rh6wcS
X-Gm-Gg: AYBFou2Ta2uKdOgDeAOrMx/zfqbTKVx6Ip103PcUIx0LkSU/vAjz4UVcbX9hTKy+CDp
	ZCZpcVktM/OJSkueGlp2sBlUvocN3wnZOkCCwHYFak/boPgWkbvxdJl1A6nVjpFUoc0a/6sL3t4
	9z3oBoXrWBf4NEzifiIEG211yXUYp/gwucbB1N87Qt2+3lmbeF1GRxGtAhd0FRDmVpQDxu+Yp9d
	F1yq03QYu5Q8DKq5BuM2gd1AbGCqF/sKBOaqGWCsW3PgXqdQOB3MBQUxivalEtcJiRo8oYbBipj
	QOQlRZdnw8zQgdLjbzFobGeztVLjd6Ua7B2neb8OkC+78aeVu6R+lOg+D5QXWOpDd9rsopRG0NS
	D796kr6rI5B4Ybdi//F8h9TaVzNQsuhya4eTA/q578f+KE8gaOCqKFFWHL9EWqNCmPwqA+WEv15
	DUAUiIomw1ZYGYUJ08rkmpFC4JV/0C2r65BB5p11wHu3JKLdQSgVMV36vf6eymxJtURU4wN9/nb
	wfMMNs2k28wcwDoC75w4m6a/r/ZYdmc2613TDuJPjz06yOfYWmm1TjKtpjG0uNKr0ikyeJY3ePi
	/VDEPIhjx0Tad4aO7PiZYJ3u7YorBxpl6rTyOSMmthvxcMm1s1jf/GnAW9No5y1yuQqjw4uasRl
	ZRMR6sfbgUh2fvVcfYTFvgpG5VHiaSHfIlgmppQ==
X-Received: by 2002:a05:693c:6383:20b0:379:8df3:d2c9 with SMTP id 5a478bee46e88-3798df3d361mr9286131eec.13.1794816135593;
        Mon, 16 Nov 2026 00:02:15 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm31128558eec.17.2026.11.16.00.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:02:15 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Dump unaligned enums and a zeroed fs_context
Date: Mon, 16 Nov 2026 08:01:51 +0000
Message-ID: <20261116080151.44860-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116080151.44860-1-dennylin0707@gmail.com>
References: <20261116080151.44860-1-dennylin0707@gmail.com>
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

