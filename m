Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793529159;
	b=XB5cVBFR321EpgZOBUGMvHB+NYtlEQWahhKnQUlILIuVtbKzhCdPmp2T7rM5NEH24SBQ
	 0a5GYuv8riccKLrpt7Q/rLBJDa+srS1qM56Ttd7bZEzgxWSumlnRpWh6V8gcX23VnRFdp
	 9fB35FOrp1uaswvUyk5RmW6RkX7ICCeZknGO4E70kREr7lq9XabjOJqaKFVYncK7Crusu
	 CL5Dj9u+uGC4TkkPQ3x1zOye8F6ORzA48omGfPBQHYD6l7Y8WBB9ADZw0Ue/pFjh6nmP1
	 LZTU/G7NqRwqY7+4yZDO5EdFJMviJ+D54qtNTRmKKjXRHuNqzBARkHaVPsT+VOdzNnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793529159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7idC5jXJA5zuKx9XSKl0bY7AYg4yh09bXWbxriqp4fs=;
	b=E/J6aDmAkN3BN0ZhVmvKbk3w4pR+p099AnvNtZ103QF15CyBDrxW6hOUWg1pJcxxjG0+
	 oqIiLK6eqRWG0KGJYCSSaIORzBsqGA8389gbdTYAhpU2r694cp6/jiy3h5h9brUI/VgeK
	 S1JJaP8cnIFk9OmKMvjqfwmvvynXbCKEwPM4NKYDyhq/rdxUFJhkrOC/pEF8bbSAyzSsg
	 3XZnF0gIhlFiPwfT2dBSW6+evf8QbkBeXIwITN8+Q2NTE1C+MSynziZo2C2bvu/l4A0o8
	 f9M/LbGA8jFDwwNOLPE57Rd13ywedG9NOCdZ3nXzkaCDUB131FnEE0D1sKjSWGdm2ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNVbTM2W;
	arc=none smtp.remote-ip=74.125.229.6
Received: from mail-dy2-f6.google.com (mail-dy2-f6.google.com [74.125.229.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD8606A337
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 10:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BD8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNVbTM2W
Received: by mail-dy2-f6.google.com with SMTP id 5a478bee46e88-33e48934fa8so737918eec.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 02:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793529158; x=1794133958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7idC5jXJA5zuKx9XSKl0bY7AYg4yh09bXWbxriqp4fs=;
        b=GNVbTM2W0Z86IBRKkWpp3WDWlg0YOyfeAgw/vDuz7Vfq+z//0hwbeedgRq+KWK3gm4
         JH6c4K1ukoDGWc6UjU+oCSuHV26bkFE+8Ko27MnrCNWzBWEFj1L6Hj17+vp6hQQeglc2
         wf7xgLrGnuWinTIQSkpbGx3cVTtkOlBd0NvfEX7yrc2vlDgG5jCcRCcLwhIYDFE2joaH
         MWfXK1frK6V/1XuEDYbfUlC/ZkQweTtvsBBslxXC6qq54A3e3CzqcuHStMg3DQd+Xo4a
         EArfJsEiWF+jwqvc4U5pYkLWtCt4qW+D5mpm4NXDHRzzZxVvtaNYzdJpXhlm+p5kHA1H
         Wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793529158; x=1794133958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7idC5jXJA5zuKx9XSKl0bY7AYg4yh09bXWbxriqp4fs=;
        b=epninO/J3tHA5ke6xB/90KSgqJW5YMt4xlk2FCssUbEbwhgOvTuSWTCMxyj5iMU9aZ
         WNdIRV0drKh9hzhiJTEzw3t1HpKStsKMUTs5gSDpodFMaBzXAZjFaYNUiLcRgLUAL/eS
         T8lBNc9jmj5VlRWdOdYt1rrMTNbx3hsJsytEHJjfcvRjlBfp1BkeFi7Eq1SfEbYx/D2a
         aS7hGZDROJ2id1l3UoCL9sMpdstCA8tcEhN2mWzqwwOSw0p1WJDkpiPGURaa1b0wPJAI
         IFkC2sLq9EDFl9FrHj+War2asU04f8g1uhvVQFvlUZr4S2LkYmmNgFqcbwCi6KXMWw5K
         saxw==
X-Forwarded-Encrypted: i=1; AKwUvBzzcolnSdXF8VtgTBF5Iq0XpCJ/nxAt4/Ho+fffDv0QNaJpL3Q8S5xhgv2C6NhGbRJC2h0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIf/Vo3aDiO/Y0Q80Sl7BUbhPe0f0/PPW2BFwnH4zmpQ7fMZRCj
	rQVgNQFFogLY+zBGUXrflCAsgsswrDwIvIJdJOeV+iHMeLRx70R2DQgR
X-Gm-Gg: AYBFou1+bjZkyW9BcwOSSud+atRVMZ2Dgjqu7kJ/cCigynHXTQMvjgi1Vyq5r9/F908
	34EXQ8qARCw0L8vLu3MFCjGmA7AnuDyQQhb7b94o0PuD0kph2ls+2M2NttXnU/QQF9kgqO9D8O3
	jgU6/cC6GoRb3z7UwCM2LMV3fFYta2XcaUTdmo3eHq2EQnVaFGKJr88Y7UtT/svF8/B788DvBEA
	zzzWVOXB7AI0jZgpzqA/AXJREGOOvk20uqy2PXCOOUK5JI6D90wSCySO8fvFuytmgiIH2eXddnR
	8WnyAqZ9tzhmtIO1ISZOZGwv0JjUYg0/bfC6EA5t0vb3DjrxpP9tIpGQKi9BoNhcnjuiO1+F3eG
	vlbqj/UoRRdxS9ls3KFR03M0Xt7uwWL0t1Xwi73rt3mj7CP5kZD2Vbxc0qwLqeKO81mEP0wVWqO
	KdFhH++qT+AO46arnRW0DB0ep0oPS+E4gx8nzBPDtGbYYWjHoIkQU8mYCvBrZn/JZ1o3DE0v+kG
	GuSgm8LSmVG6UkCRwl7DwIem0x3UB5ctnSVZJ9RyVtJ5BH4ZrDqcGB93R/fHLFLCO4fNHtzAgWI
	hjJtDbmszYVO+kmBNWQuXt7vfrNUtatwtg7cz/A019wmkrcks6v5HVxQ
X-Received: by 2002:a05:7301:52ca:b0:369:fc38:6821 with SMTP id 5a478bee46e88-36a423938f2mr10214355eec.12.1793529157617;
        Sun, 01 Nov 2026 02:32:37 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm25242506eec.6.2026.11.01.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 02:32:35 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/3] libbpf: Normalize enum values according to signedness
Date: Sun,  1 Nov 2026 10:32:19 +0000
Message-ID: <20261101103221.51534-2-dennylin0707@gmail.com>
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

BTF_KIND_ENUM stores enumerators in a signed 32-bit field even for
unsigned enums. btf_dump_enum_data() compares unsigned data against that
signed field, so values with bit 31 set fail to match their names.
get_map_field_long() also sign-extends the field: for example,
__ulong(map_extra, 0x80000000) becomes 0xffffffff80000000 instead of the
requested arena mapping address.

Add btf_enum_value() to extend an enumerator according to kflag and use
it in both places.

For data dumps, keep the original comparison as well. Older BTF producers
did not record enum signedness; an eight-byte BTF_KIND_ENUM can contain
signed data such as -1 with kflag clear. Using only the helper would lose
an existing name match. This compatibility comparison does not truncate
the data value or change the numeric fallback.

For an eight-byte BTF_KIND_ENUM with kflag clear, a negative stored
enumerator can therefore match both its sign- and zero-extended values.
The record cannot distinguish legacy signed metadata from unsigned
metadata with the same bits.

Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
Fixes: d147357e2e59 ("libbpf: Allow specifying 64-bit integers in map BTF.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DMJG1R2YIJRK.16CZLV9S5U7Z7@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf.h      | 6 ++++++
 tools/lib/bpf/btf_dump.c | 3 ++-
 tools/lib/bpf/libbpf.c   | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 57f12630c5d1..eeb4984d6c57 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -636,6 +636,12 @@ static inline struct btf_enum *btf_enum(const struct btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
 
+/* btf_enum->val is signed even for unsigned enums; kflag records the sign. */
+static inline __s64 btf_enum_value(const struct btf_type *t, const struct btf_enum *e)
+{
+	return btf_kflag(t) ? (__s64)e->val : (__u32)e->val;
+}
+
 struct btf_enum64;
 
 static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ea9a34db4c00..b636dc4185a0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2373,7 +2373,8 @@ static int btf_dump_enum_data(struct btf_dump *d,
 		const struct btf_enum *e;
 
 		for (i = 0, e = btf_enum(t); i < btf_vlen(t); i++, e++) {
-			if (value != e->val)
+			/* Keep names from legacy signed enums without kflag. */
+			if (value != e->val && value != btf_enum_value(t, e))
 				continue;
 			btf_dump_type_values(d, "%s", btf_name_of(d, e->name_off));
 			return 0;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 02e75b183ed0..cecd6b5f27de 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2627,7 +2627,7 @@ static bool get_map_field_long(const char *map_name, const struct btf *btf,
 	if (btf_is_enum(t)) {
 		const struct btf_enum *e = btf_enum(t);
 
-		*res = e->val;
+		*res = btf_enum_value(t, e);
 	} else {
 		const struct btf_enum64 *e = btf_enum64(t);
 
-- 
2.43.0

