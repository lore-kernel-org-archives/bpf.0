Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732577;
	b=L05J9B7XEzzGnge3HYJqgpmWUb+SMYK8Yqba3CunkP6i+l5rkOI139p91oj0geTfGE3P
	 /S9VEj+qQEn8TsF2QDBK83wDiOzefAOrbmnQHDLWRbccexkH83GBjvzjlhdPYTwXIgTnA
	 VX9bilBPxNCHStQZcdyHtmdAUFoXzO5uiXFi0S4MOMevrLN2pj2bjwCxiNyubqhfjFFvu
	 zu/nG0Y/tFeJeSey26vh1PFMTGDFM2YUJeQb2I9XuOSIGTrvhaIZupIjogv2tK16nTB5z
	 j6D1KHnZa6u4KViQ8B2Szmw8Gw/kf3HcYUQ1/geROneT5zGXvfdRn241fo4nS3HdLkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
	b=s8QG6Wph1zKoq+rk7Zy4bPNpEwqhx/M1PExiMXEggSRsyoeKYuPFPIpm1wWGeJCUFN0+
	 kkQqh+673GdOUtYn4T2zZzXTT6uF08yk/8ENGheQLq9UcCyzMIDYBU9S4eWNONpgV0mxQ
	 +loGjVb90wq0Y4oGmPH2o9ElIH7WJkd+vJdeYY3wM4DJti48XvFQrCehKpU1t2G090mVo
	 oVfWd9n8/yeyQia8xxccbQaMLRjy7owD3e4vGscAHeM724BsPOeyZ2zI33zc0BE3RxpW4
	 w08hIw3fDIboPhD7zO9G+p9+dvb3t5V80S22kHHQaq36J1BvKOtGmLletmZUB3biOJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VupFcbpI;
	arc=none smtp.remote-ip=74.125.229.133
Received: from mail-dl2-f5.google.com (mail-dl2-f5.google.com [74.125.229.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A5606A88B
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 08:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B02A5606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VupFcbpI
Received: by mail-dl2-f5.google.com with SMTP id a92af1059eb24-1ac216daf7dso984617c88.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 00:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794732576; x=1795337376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=VupFcbpIug+OPHMYtzxL6kyFSS9B6l9i8X8oidvMJyU3vNpzJC3sMrqmykRqHR8Gbj
         WR60m58rvUM6RNaNwyiJ3IspyOizxODUadi9ud6Q+LPhPcd+pgQMiogHZ4xR9P8PC0KJ
         KKklGkdZbdb1HgXY70f9+etFWcSFfwNaV//8ncdXdvvEl8+Xj9xY5PZtqzq05CIEDNab
         Kd5PGh9Cb7YowEf476VyU4XRcdNLyAPMTt7wJQwR85SkcGM6tv9apDlaAATOYFPp0J88
         H+UJbystko3F3sSqoS3jRcbortHYzKHYJjwTJxvE9ca2WF1Nyb8UCa+IVyb8ezGFO9F5
         +Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732576; x=1795337376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdN/GENABW5fwEr+WhhCPVo7gKVgeXJgjWEeJkwASG8=;
        b=HNtOnoFssy/LMHLSodsvIrp4WdBsxvC4cQWLAR9/RhwlrJ1CcWwuFniRrX7PWpKXcb
         m4tU3VD3SE4BGkl7AayQNiXdrRXtuI7WVn9pR5yX8NlY6ZERygMGwUtAoEZInQbet/eu
         5h5XKNqa1wlk1pMwpItwsEUrG8Htf2y2vsDQL/Kfu8hz6ze7A6b/qFnm66jwVCgMU+g9
         XokJT776RNdlGb/PN0erSOLNqiMDdjouXEnjBYhXsA92IAA3YKnqWrSmcSPBPbCP2oK+
         nXuqeVC6T6G3CQEFKaPkTqKjIwNdcOLlfL/gZEx/Cs6s97LI4SMaY2dtMh0w9Eve1q/W
         b+yA==
X-Forwarded-Encrypted: i=1; AL+hErGUUBKp8lGdTB4KN/uF28BJCWQ3ZxMYigRGsW/YJ10BKkOuSIWI+MU1dH8NJD3sBIIU/ZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DkGI2S4T/LCiw0WZ2Vq8SlxBGmA/5NY7Mgw0S53iV4I21G9F+
	L2jDUGGJsI7xOg3J3HDYt619U0DzEEkNEDxDteZUbO387R3DcsvtbR7o
X-Gm-Gg: AYBFou2VOWRtTl/uxYSK6HcsBSxCKRJUomylkXXOGVqo0TH+Nctfd8OuNAtX3G7FfXZ
	YMML7BNdrav6Qgiw8bgULKolZnUtHRK88xAIEHfWrmCfbVEO1Mi4HoeIuIfBKIYRRgJX4EtDTw4
	S6SxtUESnciFthHJ1B/Omm7LLDCg37uvF6Oqd1IVrC/erlnlUJtq/q8gDZAQh3q+hcEwQht4U0Y
	WXCc5vCqCWzuyruHIMINljJji5Cu4O5v1rMnOZLlk+1ks4JzWhfto2MTyVgg+3v9r9eYabeSOLy
	fP9QZGhzbT0jfxFpehScj8fYwNgGw+kbXyPMxlciM4e1pOjE+sNRAQhwuhmtmB5ARtKGhuFF3Ni
	jZyDEeYKgI9STX4PSRjPkfdIPO9Ym1vmwwgcmDp7+1CARNwj0kN/M5Qb/UCAZxPM0o8Ed9IUcW/
	qfTgjfFcjBmBDGDrGxEP6TthnJ41BVAO70y9d8UqyRRIRKXaY676HiNOkXoP/n55r/Y0L8bE5if
	1JHOsGBpVCmlaObWfiQPzwHQ+gXKMgV/DJmxkq2HcwDzHxnpBlPM1oPJf45S93F+WdEKYf558rq
	J2RX6M4s4R2dT/Ij4GRe8cRWpgdp4MKIDC2h1ZXF3NRewvnBb+TiFLG6DfIcIQHW+ftOn9JcdBJ
	2BKRG+bUeYG4s4tY9MDz1sW9cvXRUF5ARuKLrZg==
X-Received: by 2002:a05:7301:7108:b0:376:b957:bfb with SMTP id 5a478bee46e88-3796628d619mr6973061eec.17.1794732575687;
        Sun, 15 Nov 2026 00:49:35 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm25221051eec.23.2026.11.15.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:49:35 -0800 (PST)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Dump unaligned enums and a zeroed fs_context
Date: Sun, 15 Nov 2026 08:49:23 +0000
Message-ID: <20261115084923.53182-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261115084923.53182-1-dennylin0707@gmail.com>
References: <20261115084923.53182-1-dennylin0707@gmail.com>
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

