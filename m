Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529161;
	b=4/rSmWHRyjGQvxiH7Tg3u5/AD7z2MWO6BgyBCBexKp0ZimJJHH+eJMjloX8mftqAKo1P
	 ymz5AkoBTOoCdHabSoKQIT6XFjENpk014k10EJgeH12DEPbcpUWMgeGcKZRiqmvJ/33q0
	 Ocu4scEfgs3ubbdbXwfVrGv4OswJ5YZkXw5kSaotYFknPUbSCzck+VoVH3mKLMUY8n3D3
	 iwQjwUb9tXAA7uV/GvIiY/iUdAbdThBQw4FjVaMHuAGZi/0TfjTeAZPKnmxYHUlDrwsBi
	 JcIawTAiJ04WP7aRCMaWAFHi0wvUPtzI1+kbk3CPxBO8g1+URW9a0RnNd5cQgk0YfAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7kAjnp/vmDsZxQUJrdxKe9E85NB+pqCNBKSp0Z5xRdI=;
	b=wZd6w1ZwsnrnE6b3O1XNfFHfyHfxbz7dBuvJ5VSVTD4S5Jh+s4d3txzXSBCATxwjf0DT
	 IAQtESbLrZ1BmZgYXvUb8FcJ2iFecgdsvTa+tvqN6OhIi8RLzMEjdsrBjOgVSLKrPVgHU
	 Sm4sVuxnya7rxy+kmuDHtcSxx5srW+u2lolFjVj6CRahnrnZ1OPfAjuWtAn9cZOAAhz0h
	 tu27sJdsNVnUcNpWnbjwNgmNk7NuvTOIGC7fXEfLCxScejVS8lTK8jKggROyCGBMWEYKt
	 LeZXQ1UULK/b8d93Cs/UrNElK+dMGhfYarrJEUBlCDKoU5CY35XKZ/isOCWcekPNx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlK5FzPs;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF10606A327
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 10:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF10606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IlK5FzPs
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a24f47293so1359350eec.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 02:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793529160; x=1794133960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kAjnp/vmDsZxQUJrdxKe9E85NB+pqCNBKSp0Z5xRdI=;
        b=IlK5FzPsixSL1Byca9cU74Jo7bZ13QHBvu94n4troRBKOi+zd6mAy1WvG91PIHtTY1
         853qGyjb1FedxyVqC2CEBq+iVTKO6mcT0QfNScXTKVs1G49DUhcHmxXaydmGyCoJFEr7
         XwQ8deS7fCd/zKD+pJCgnzOnFrsjf98Z9BVoNJ1yrIGcjhudMuvWFqBTDK7Vn5WNU583
         bZyPxwVqZI9t9Z0nMmQzzj2lPVdUOV/crbyOLuVw9g0n5SAGiVwQEVUr42Ws4HHYiZb1
         XGe85GajBmbSO7/aMwzj3tQvMvbXNAGLI/IpfNqtr4IX+fVtqAFcNtBCtOFnNpfoiWSw
         c1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793529160; x=1794133960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kAjnp/vmDsZxQUJrdxKe9E85NB+pqCNBKSp0Z5xRdI=;
        b=EPWSCOiZGBTbPfaaKG+Qejd/ots93Dfwclnf+Yfk9a7hy5tESfDzNeXJW7/7D0Z3DF
         XhjHIRQhQ4Cg20RLyWrd8VQCv5TbYVF6UZrILUgQG7UiRsEWM6EHBoDpHUeOOqJfFN/v
         0PloiqwLs2DA7/LHm7sLEkHLN+cu6mB++1s0xtJreOYmnRfTrI+LV+WM5CGRh4mg4n/J
         VHdYIF6nw648hRrtRcgV6vD4VNxUs+1liUC3aXA/k1FrmpdveQKHTHnFEbzgc04shfZO
         WZlz5F1hZoIkJg6wsszKJvvgOZ+w/kXQfb+DT/1OYpy2O9rRoj/5GLn3lVeyCl/39XC7
         DlNA==
X-Forwarded-Encrypted: i=1; AKwUvBwAaNskTXWoChRTvWnWkWXwZWbXRs9crXs5sRNznXBm4r+QcfHFO0MBctORKhFPpZF3AVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qZwkkXzazKpnRUOUaMTdLi3bG2xGvzsVuqNCvb4AqFn1h4jaw
	7vCV17aNqwKtFL2pX2Wl4u2U5tGHbi45ziDjwBdvCuc1CCuQmX1q+ggs
X-Gm-Gg: AYBFou39VU+B1q69PWx2W+fLfflM7Rdh1waulaLca1vuLQl4/3icgy36Lc9iOs10U/l
	G6u0gYoZhts5a819WylYdyR9B0JhOGr9ow2vVX9VH0wRS18GrIH8NG4O3udYFii41WYk9HoW21B
	q90FZ3qIwM5mGSR4BfRDBjlKgqSp9U3ZSsmj3PPvK3XPeE6JIAfZwuIbjK0AfyX9Fs8zit2GuIs
	gNlDVIfgCaV9NowFyky8MJCvL6tZ+Oxc3ED/+YxVbSiW3IvMdyuU2TKDPZTTCCSKJGFot8iyDwi
	F4xkkA8i5UbQg/gsbd1mowvXchG94PA/7nv3p4iqvgbRU7Mi57mSmSLS+3zjxzrVzp6aRufcIV3
	G2CwrIVxqg4BNNZFkHxQdLap9OyER7c7O3NVZtOa8v6dW7vsK9R/4L8HstGKPZc9mQnZ61e2ja+
	qXwI9v/C/NvTDA5Isyzaio3CxJx1Ln7U/8JhtIvLhJffYbp8CvN+mMA9KT4cY8guffxmNkzeuBR
	MTBZs2iBF6QbywmaNt0EDLDcoNLG4EcqU2zHQsyr6MZkzTZ798housUyLVgpncw0cCvx45dB2qz
	5BGQW0djncLlnIldaRdHIKeo+47A+SEJMf6RmmETnNS45VAdTqZ/YyMQ
X-Received: by 2002:a05:7300:cd90:b0:34b:4b99:24ab with SMTP id 5a478bee46e88-36a42454b8emr16281293eec.22.1793529159911;
        Sun, 01 Nov 2026 02:32:39 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm25242506eec.6.2026.11.01.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:32:38 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: ast@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH bpf-next v3 2/3] bpftool: Preserve unsigned enum values in data dumps
Date: Sun,  1 Nov 2026 10:32:20 +0000
Message-ID: <20261101103221.51534-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101103221.51534-1-dennylin0707@gmail.com>
References: <20261101103221.51534-1-dennylin0707@gmail.com>
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

btf_dumper_enum() loads ordinary enum data as signed and uses signed
numeric output. Unsigned values with the high bit set can therefore be
printed as negative numbers. Narrow unsigned values also fail to match
their enumerators: an eight-bit 0xff is loaded as -1, while its named
value is stored as 255.

btf_dumper_enum64() likewise uses signed numeric output for unmatched
values. For example, 0x8000000000000001 is printed as
-9223372036854775807 instead of 9223372036854775809.

Load the data according to the enum's signedness, use btf_enum_value()
for name matching, and select the numeric writer according to kflag.

Retain the original signed-width comparison and give it priority over
new matches. This preserves names from older BTF without signedness,
including eight-byte ordinary enums, and keeps the selected name when
multiple enumerators could match. Remember the first normalized match
while looking for an original match so only one scan is needed.

For an eight-byte BTF_KIND_ENUM with kflag clear, a negative stored
enumerator can therefore match both its sign- and zero-extended values.
The record cannot distinguish legacy signed metadata from unsigned
metadata with the same bits.

Unmatched values are printed as unsigned when kflag is clear. This
includes BTF read back from kernels without enum64 support, where libbpf
clears kflag before loading. The original signedness cannot be recovered
from that flag.

Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/bpf/bpftool/btf_dumper.c | 42 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163119dc..792e210cb503 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -148,37 +148,50 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 			    const struct btf_type *t,
 			    const void *data)
 {
-	const struct btf_enum *enums = btf_enum(t);
-	__s64 value;
+	const struct btf_enum *enums = btf_enum(t), *match = NULL;
+	bool is_signed = btf_kflag(t);
+	__s64 value, legacy_value;
 	__u32 i;
 
 	switch (t->size) {
 	case 8:
-		value = *(__s64 *)data;
+		legacy_value = *(__s64 *)data;
+		value = legacy_value;
 		break;
 	case 4:
-		value = *(__s32 *)data;
+		legacy_value = *(__s32 *)data;
+		value = is_signed ? legacy_value : *(__u32 *)data;
 		break;
 	case 2:
-		value = *(__s16 *)data;
+		legacy_value = *(__s16 *)data;
+		value = is_signed ? legacy_value : *(__u16 *)data;
 		break;
 	case 1:
-		value = *(__s8 *)data;
+		legacy_value = *(__s8 *)data;
+		value = is_signed ? legacy_value : *(__u8 *)data;
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	/* Prefer existing name matches, including signed enums without kflag. */
 	for (i = 0; i < btf_vlen(t); i++) {
-		if (value == enums[i].val) {
-			jsonw_string(d->jw,
-				     btf__name_by_offset(d->btf,
-							 enums[i].name_off));
-			return 0;
+		if (legacy_value == enums[i].val) {
+			match = &enums[i];
+			break;
 		}
+		if (!match && value == btf_enum_value(t, &enums[i]))
+			match = &enums[i];
+	}
+	if (match) {
+		jsonw_string(d->jw, btf__name_by_offset(d->btf, match->name_off));
+		return 0;
 	}
 
-	jsonw_int(d->jw, value);
+	if (is_signed)
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
@@ -204,7 +217,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
-- 
2.43.0

