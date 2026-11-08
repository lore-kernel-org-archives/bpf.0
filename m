Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106620;
	b=lcFSWuxKsjr/KOAMvaxLnAuFi54BnX02Rtm73bLMz1KO0FgvBMQIrTxc0+4L/2LaoiYK
	 I1cV4ovkspQQIrQCZDmnunycHjaCBQqWtkZWop+Z1+bAZgmTQ7eXqP/Hs8v4Zfv3jFMzw
	 etHhzpkzpyUJm56jX5FnCP905D8wzcrbK+bavjMwEX6r0+pgmeChF1oeFqJjoK3fGkg84
	 HawScD3tSR9Ob2rMCHFULsj4gCD74iPM1VyK21hkPBodh4f0PT/uKY5ufpOlgGaPoXpi4
	 cZLIOs5TlAGOb2WbrRjgeDZp/t6S8tCKMz+mp9ZuKY57uPJmbXyHojQmJ7rDVRbfJMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pjn5VIMCFWufAxXtNYcmmnWxYvHuss7ZMRE7XKvTOQo=;
	b=CxqenBH1jhMimJmwyH/sPZuASCS7eaZgjLpfkagUDJKpmfvkJrQ377YMcmOaWfQ11/XD
	 sZXP9uRgLgYIfQwB3NoKoXXjcq8zA8o75CFMhWEWb6OfX11flXulGIvVqrLuIvDo13NDQ
	 RuQeHiKTxYkNGqLcwt+Hyqv5bS0Sbv7tb2XgvCIprzq+a5LD+MYppctq/KfZb8Qpq7BpI
	 ocJnaYqJmngJbiWlQ+hb54cuYKLx8Mri7DfzU0i3Af0HHGSyaHoFXl7UTSE5G5jFUUI0S
	 kwOvAtNoBCVIgaKZnWSjOFSOUe0i0dM6GG4Nnu8lHpox7E4GTA/p3CWv9hqipaJhjlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ts3CtS9P;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352CF606A321
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 02:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 352CF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ts3CtS9P
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so92490eec.0
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794106619; x=1794711419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjn5VIMCFWufAxXtNYcmmnWxYvHuss7ZMRE7XKvTOQo=;
        b=ts3CtS9PlhQRfFLFBrWZ4AbDJ2+9pAmiH5jjKn9Mr9J0dyFcdq+L6NQhxNuTnHVzEG
         ijy9wccedyKDyFylAFcGuGaVoRB11AaBbzq0DbsDy/WY2Flel4h3MGiwRDpc/twLDBwP
         lpv6m9Dech9P5eMb1D4SpkwdeH3HPd3W8UFemWPEgnJ3UKF9FnhHVlxSjSEpXIBNcP11
         aj/ipWTwlq9e09AWZMj5+z4KMOHsss+nJI/tbQJuwmnNAVHXRFwW1TLPRzKkuvcSqq9A
         oaXgJnz/0ujZ1FlyqRRQrNzsVidVdnn8XqpTWm4WLd9THMavAibS2UQQi/7kltYUNEno
         WDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106619; x=1794711419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjn5VIMCFWufAxXtNYcmmnWxYvHuss7ZMRE7XKvTOQo=;
        b=GtEqB7e4i3x4AFZKMajBRJAvIeyTv7+xVdlLJa/IHF/gSyEEY0ijR2SCdIDrn3YrRC
         U1W96VkIgZhByv0o6MOYSPdf5iFEaX3wvvr8dGmZrdpXWmULXxurCu7rjTHFHGOAbKQT
         4DAtbXnPLrRSTjOa8jRQR0asruVzogxv1dfppcMdqo0EWt5GPoUhozETTXmHHGWtIS/H
         futbRlSSyXD7rzVbUJyzbDHxB/JZsHCdHq5uGzcOKwBnJ+P+jS27YWB+kT4uWOuEwaaJ
         MqMXiMlyyeawqCMW4N8nmex+IiCtlRWBkbPgEAuBpUy5wjF+kDRi0/BJB96k2yKjEY6t
         ppGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHLIPtII7yyR6Zn1n7U7dFWWCkBgoWFIZHldNxSKoKyC2Q4bagHhsmqzgo661isYJqJak=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GCURZF1ShAh5A7cdpdT2AQD6JMeeLE5CymwP0nrydQe8g9OP1
	1XiCJT9GWzqfhvRMlnQvZuMmmmaPkGYl83HTMqBpIFmAYYiyxa/vfFbP
X-Gm-Gg: AYBFou3klMYFcI4JS1cuLozDMcot4DQYvkVzxSlWGklEccqv4OeQ+yDSrmBvPwYP04R
	cc6iUSkWv8Mf54s1JblnXI7WeQrNfaYNU2tz3Odq9fxzsUnrKDeNFsofqehIG1qTyZKmU0HjA/Z
	3JKBfkL2MGQFVmizm4pPL1+AXNsl1zUygKqvJAwQee7K2G4F58EjFV2igWq5HXFZZdpX4JX9yDS
	WItxYo92pRIWdOrN51QQxYg4VGwlSlhzBsvJnHiGsSIdg3gqLmUTqHYf2FNOFTUQrEWc8+yUMZq
	YMkn7wQAKPbO1xCjY45tX0pU4a/oa4K5YCC+7hus3CRIuUjjZd7E1MMun69drZ1CYZafMNGOXtC
	RefiPaplgVK+XIPhPBDi6rx0zDQaDSirMS9hMgyXXRM25YRBCRvoUPcowGFxReT/sxv/GnpXAUK
	YWUoOcIkKgGou+KVFx0KWO99fdXRjKyBnRKZxZAgl+4OldKHRVaxezbLnsFncZ3z8gcN9K7wFMb
	5nnMmBNrG8OyKNVoer9bVCn0NEKGF08mkpYinkoqa2VKLZwAiEODP3BLH3hBaPSlOLBsHDsZa9A
	D1jwhFPeB+XbAorH4ZkkwFzgUpmebGKbFMr0gyhiYkgY9+xMhjluRDbZKOpzh01ZClUp5LRbOvQ
	zFNxKfTU9ruksnZ6qTvdMByb/pWXKiv+GG49Qr9yqZ2Y1Ia4btFdDcolL/3g=
X-Received: by 2002:a05:701b:2512:b0:156:6676:d0e2 with SMTP id a92af1059eb24-1b39fec213dmr572791c88.10.1794106619341;
        Sat, 07 Nov 2026 18:56:59 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3773ea50asm2241202c88.23.2026.11.07.18.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 18:56:59 -0800 (PST)
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
Subject: [PATCH bpf-next v5 1/3] libbpf: Normalize enum values according to signedness
Date: Sun,  8 Nov 2026 02:56:30 +0000
Message-ID: <20261108025632.10799-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108025632.10799-1-dennylin0707@gmail.com>
References: <20261108025632.10799-1-dennylin0707@gmail.com>
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

BTF_KIND_ENUM stores enumerators in a signed 32-bit field even for
unsigned enums. btf_dump_enum_data() compares unsigned data against that
signed field, so values with bit 31 set fail to match their names.
get_map_field_long() also sign-extends the field: for example,
__ulong(map_extra, 0x80000000) becomes 0xffffffff80000000 instead of the
requested arena mapping address.

Add btf_enum_value() to extend an enumerator according to kflag and use
it for data-name matching and enum-backed map fields. Return __u64,
consistent with btf_enum64_value(), while sign-extending signed values.

Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
Fixes: d147357e2e59 ("libbpf: Allow specifying 64-bit integers in map BTF.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf.h      | 6 ++++++
 tools/lib/bpf/btf_dump.c | 2 +-
 tools/lib/bpf/libbpf.c   | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 57f12630c5d1..d74c92056f0f 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -636,6 +636,12 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
 
+/* btf_enum->val is signed even for unsigned enums; kflag records the sign. */
+static inline __u64 btf_enum_value(const struct btf_type *t, const struct btf_enum *e)
+{
+	return btf_kflag(t) ? (__s64)e->val : (__u32)e->val;
+}
+
 struct btf_enum64;
 
 static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index fcd97aa90589..602664a6adef 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2378,7 +2378,7 @@ static int btf_dump_enum_data(struct btf_dump *d,
 		const struct btf_enum *e;
 
 		for (i = 0, e = btf_enum(t); i < btf_vlen(t); i++, e++) {
-			if (value != e->val)
+			if ((__u64)value != btf_enum_value(t, e))
 				continue;
 			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
 			return 0;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0e2a93a42908..44134421bd7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2650,7 +2650,7 @@ static bool get_map_field_long(const char *map_name, const struct btf *btf,
 	if (btf_is_enum(t)) {
 		const struct btf_enum *e = btf_enum(t);
 
-		*res = e->val;
+		*res = btf_enum_value(t, e);
 	} else {
 		const struct btf_enum64 *e = btf_enum64(t);
 
-- 
2.43.0

