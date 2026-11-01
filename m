Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793491859;
	b=amH6v8nVnLsbqB9urmRoiPr/lrIXa1gD7gHvPMeuUu4TlsdTf3ffG8RveUl6sUFl03y4
	 VMvvXMnsffNBfpBKE0YuJQJxO05wmcfr0kP3B+6QSIkV3FNkaBFyz1STEQd0N1exEgO2B
	 uSZh4XitGR9fCkuiE5zDUS6kY5FpyvDNBuiRjLFiWI2JNeXPxX0LEtXeuntKShWEqvm2U
	 vmDaBMRN8uWzSv5o6Elp3p0jjAp7kjIiyMP6YKHYrSUTfMfnwxIC6kseXaQ4pDpUCkWxQ
	 4i079s5JqX40qTanAbvTrLkbctQTr1tJT/f9g9mi1lWwlJ4IjGCpKS2JH1Mi7U4UVtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793491859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=onQ2T2Et4gZdcv3wTOM5R4NU3ERMzCKIhrlLawaSYE4=;
	b=ISDAO3ede1kzo8CRdGnmpdOXtgIJUcrv04RmCl61cHU27MeYlrwoCeiNLvGk8IaQsPL4
	 xyWJuoj7rVqjrDvZ7DEiWakogHXFSFMsre/rZAUPFZBKlbLZhCzNxLQVQMoNP48o+1lvR
	 j+SjzF5oulkzWkH4BqAiNh/IHss/9DGQHKzGXMuPJ4jZEZABO9FhcioKpYQv7VPOYRJmX
	 oWn8xo6BNj3sq5e0FEgz5U9O2Rp/CHLVXxGyPWVqOiRJ3prnfvyCDSlD+Troh+P1Cbp0O
	 eecagWo7Ibyprr4Zks6Kq9WhmCJVEz1Kwvv+OhGbhtAV8oTS54BpZwGf36DvF+S6CjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nv24we0S;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57784606A31A
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57784606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nv24we0S
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-35eaf84cc66so1880786eec.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793491857; x=1794096657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=onQ2T2Et4gZdcv3wTOM5R4NU3ERMzCKIhrlLawaSYE4=;
        b=nv24we0S4qdFZ9EFpZBpIMVq4ISXOZs3uSIB/EqLLd5ew0qL2pICufP7osqeJf6be8
         XE9qLD8vOVQrgjeDCfOUZK6gS1KtLwfliA6XYE9FijQ8C+XlOniJbCpoxXqnHFhrHjkI
         hYn6AvJUSshnMbqRyxEt5dBvxBueUz9dySS0l5hnydmu28e5v1gf1wkQ1o38GZ3rJZFh
         +YytmPzdDIut36WCzGt+nwjOD9Zxy3d7G3c56TGrbnRn5Bvc86bJyunALl9Vj7wJNhsu
         2o5y7/ic1jaQaG5u1U4oX+ZXKP6GX6f4wTTAb+9ExhGvgbSeex8VAK6cjdloLeWxSF9N
         cXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793491857; x=1794096657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onQ2T2Et4gZdcv3wTOM5R4NU3ERMzCKIhrlLawaSYE4=;
        b=uH8JjAAQ+zosmZ6SruLJTEuQfYCZL8wT8l4wOiR5HPgY9WF7ENnYCuZOO63lJ9tSzc
         3V7H/CAiTki1/IhWISroiKLKGa/ge7sx3IXc1WrdCn9Er052rUguEK4QN0eJ53Ktcok4
         9zUZ6QyN4Q2tYqNSpboGXr57pqrxR5vLrJEotRycIur6vbFOjaIZcFp/zFAFE+gVHzY1
         l3FOwkshwHf8L2ZOteqjHVI3vU+BIt2cvalvTxAomLfvoZTQFTZroEKdlGHhtikPm+Tb
         Ps6o3mNX3z06nEgt7Z4zHociLZE+e5EZAHEdP4ChL3r1h+9jgfrpQCoI0zQZSobK85zd
         kUxw==
X-Forwarded-Encrypted: i=1; AKwUvBwtiaNOBiRa4bIAYZhmx/+7VjJJlIDJqgNus2Eo8XqrK+xfM5GI+zI+i2ZtyfvyNYyhhfs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1jgTAxSEEQXcWnrTzVBHENWfdrN6gVz3JdsE51v6yX6VMK5KU
	MHVTnTxybaiFPyg7f43cy7vsHNRXsAC5PCaIrNw4Hd4avPj6h0JOnrwYLidJovX9NuM=
X-Gm-Gg: AYBFou3aqBbtzGBdEdiOALTY1xNiazn4QlESV6IcPpj8SJi46MV/nrI3GwAVpoFMwDh
	RTkP/u+65+zWxFGJKnVXH6QPPbtnybUq61iLLKDtiQyBheu/clkOZMV/0hXVHyrw107u4MW98B5
	aUXw+8dIykVBuVcYrRAl5XWZWNQTB3L73MiURtvAM0gtSiBo59Q222TG8fiAO6lMJ1JAR1RrUIP
	0/1docmRanb/H90NvfMtyoqjazqUS1RwhFCZxmjz1zaShsoAymEhG4uxLl8cvmXO6Ptu3B+SSqk
	+A+80SgoHWulezgEm1oQ8WK96WA12G285P+NZ5hByJPLgTbhB/i5iwlbcJl1Og6P3CsqPMcQYsP
	7ekZeb6+asr+FWICmABBH1tJSb3OHelbfXR4UZUOG/xRCWtQwAFCrywWUTLT2l4r8Prv5XIJDlm
	rlpOzv0nM6lS7aVYrCDebMk1j8JVrm9urk4Nt0y2DV70J+64jrG1C/LviT34UF/MCP0nECjoNIz
	Uib9PEjxp3eivzAfdY1PjXBNGxlpzAIdDDNpcYq3nro6+1+ZcDULN2nUSvS5WruJR7Ye/bWi8o7
	0hvWDYx54Jo3lBNcFpmOaIcw6IlvutBTzEg+bE5vRVe134TJ4yH79UGy
X-Received: by 2002:a05:701b:2706:b0:194:3a84:e67d with SMTP id a92af1059eb24-1ac5cfe50dbmr9172106c88.44.1793491857357;
        Sat, 31 Oct 2026 17:10:57 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm18881921c88.8.2026.10.31.17.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 17:10:56 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v2] bpftool: Preserve unsigned enum values in data dumps
Date: Sun,  1 Nov 2026 00:10:24 +0000
Message-ID: <20261101001024.9994-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

btf_dumper_enum() always loads enum data as signed, compares it with
the signed enumerator field, and uses signed numeric output. Unsigned
values with the high bit set can therefore be printed as negative
numbers. Narrow unsigned values also fail to match their named
enumerators: an 8-bit value of 0xff is loaded as -1, while its
enumerator is stored as 255.

btf_dumper_enum64() likewise uses signed numeric output when no named
enumerator matches. For example, 0x8000000000000001 is printed as
-9223372036854775807 instead of 9223372036854775809.

Respect the enum's signedness when loading ordinary enum data,
comparing it with enumerators, and choosing the numeric writer for
both enum kinds. Keep the signed arm of the 32-bit conversions at
64 bits to avoid unsigned promotion of negative values.

Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DMJE4YGAEGPX.2PIN4TJJ0AV0N@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v2:
- Handle ordinary enum signedness in data loads, name matching and numeric
  output, as suggested by Alexei.
- Add the Fixes tag for the ordinary enum name lookup.

For legacy BTF that predates enum signedness, kflag is always 0,
including for signed enums. A one-byte enum with NEG = -1 holding
0xff now prints 255 instead of "NEG", while U255 = 255 now prints
"U255" instead of -1. This change follows the current BTF kflag
semantics, consistent with libbpf's data dumper.

 tools/bpf/bpftool/btf_dumper.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163119dc..09dd428aa12d 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -149,7 +149,8 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 			    const void *data)
 {
 	const struct btf_enum *enums = btf_enum(t);
-	__s64 value;
+	bool is_signed = btf_kflag(t);
+	__s64 value, val;
 	__u32 i;
 
 	switch (t->size) {
@@ -157,20 +158,21 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		value = *(__s64 *)data;
 		break;
 	case 4:
-		value = *(__s32 *)data;
+		value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
 		break;
 	case 2:
-		value = *(__s16 *)data;
+		value = is_signed ? *(__s16 *)data : *(__u16 *)data;
 		break;
 	case 1:
-		value = *(__s8 *)data;
+		value = is_signed ? *(__s8 *)data : *(__u8 *)data;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	for (i = 0; i < btf_vlen(t); i++) {
-		if (value == enums[i].val) {
+		val = is_signed ? (__s64)enums[i].val : (__u32)enums[i].val;
+		if (value == val) {
 			jsonw_string(d->jw,
 				     btf__name_by_offset(d->btf,
 							 enums[i].name_off));
@@ -178,7 +180,10 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (is_signed)
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
@@ -204,7 +209,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 

base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.43.0

