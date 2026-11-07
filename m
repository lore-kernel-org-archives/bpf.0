Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017257;
	b=h2EdLVMgNO1XB6P0lFcBr+C1VnDeHG4KCvBKlhlehBpfn9tU86kZyWdxY/BD+HwaIc6M
	 PlQXOA/WqKIZqyjcC9tk/2xei3fKq9as7hq8xnMY1skx0nbFT2oTzj3DbiHPXoYXUWJqR
	 SuMtmuv4dhgGhFEA+TkYegsYaRzRCNfaO5TfnyoNBjHDvOOyW9t9Up+hYDtAHnUOT6DxX
	 cPw1jiIdRXhlmrbGX5fHodEaWH9MIcLHUKHfZxaFDPRuynxzT1SQsFi/BZS+B2G+sIuCY
	 P03QmGDrisrrdFhJQTvK4UlfGbzKkqvRN5pYKH7tQ6wSMgZGNxMMjm8PKWa1plGo9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mvQm2BwFx3voJ/6Hs8R+Bsn0Le0ol9eYlfwfURLYyx0=;
	b=RgSGQFRT7wAKNJU5T7LUFdzrSMWxQFxWBeq3JajyQV1nooJJFZ0oycGv9zka4YsqLlms
	 IPuV9WWwq2ENPpzdM98KbP/H5CFG/E6ch/LVsq+yxWwyU9eIyW6iiHSInnwkh1IVn9XuF
	 IBhb0PS5lYzaTplB7CUuR9rsy6BeYvUNIx8QmbedGdctwcPnMpYPj0HtVBt1cDtw54bYh
	 bi/OypRxnO0aQzGWAsAu6vwc+C+tD4Xr0cZ10rpacUAevf1qTwzccLDzhcEhqBLeIRLEk
	 JCqqhkDOCuLzyZeufKmM50F4T8PAzY/sYEyfWVZXa/F1Sh8vCzErscXbGHO5RYj/dCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbLGNDZt;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B4606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977B4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TbLGNDZt
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-33e5ae86ff2so561379eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017256; x=1794622056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvQm2BwFx3voJ/6Hs8R+Bsn0Le0ol9eYlfwfURLYyx0=;
        b=TbLGNDZtVU7LVHrq4j6stu29IcLKbMv+plX08ZPQ3InY1/vq7m6W/HaWNtJoZMDZzU
         G6HLIx7nQ/gyTiGA6sg2z925N+pN2qC1zLm1cJOJB77igLw77VQHotNrmCBawfbBDI4W
         vAVm27rT/VoDieT20VKetRT6NYXz7GBWgSAqb3zcdxwmZnaQ+619h+19JyIe794n0Uvu
         Is/l0Wr7vPV6bmP42WIi0L0WKXnEOvhe+vhl6e1wT/BbXjn9VttFqjQDVnyBQNk8fcT2
         a9sYoacznRQLQmIYJjwuzP4T3/tu90CUQ4aR4Sm8kvgQFJoKjOMLTALHQuHEf61M72e2
         rnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017256; x=1794622056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvQm2BwFx3voJ/6Hs8R+Bsn0Le0ol9eYlfwfURLYyx0=;
        b=a2K4uDJ6Y88Sgz9OlGEigDy+Atiq7fEeXdJEl5vLk23EBOYlKGISsNxlE3I1s4c5TJ
         raxMLolo1peawp3j4GcNZ0ONXlhKVXCge/cKzHZl6F/GR3p0I0hWKmdktC+hQQOc6qeA
         LNrq9Ye3VXQ2MNEm/eyyOm2V6hv4r3tKEvBf/ZdU6TXhoxOv0knQWyvZBc04tpD6zlRT
         VnI9TghQQe1rbQ+kw9MAwRZTyVPB30ghHr5qD/bpL8O1EZ7oLOTXIF0L485qBUXBVXaZ
         yYqFdmgS4wqsD15bzSymh3h7EVkEOP6HWb6j1EHMWV7xeoZrcCsLomk3ALS5X5LMS9A6
         7+qw==
X-Forwarded-Encrypted: i=1; AKwUvBxiE3U/TY8++9hNewmWyQ+gi5xYI39tLHjuB0H3AASNtPh/O3Tesf/6lThikK0xzADJ2fQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5vVmXYG4oHv5zTdMHLlvaZ+BZdVXHp0HwRnIz9/GblgXuaGgr
	COvGzv/cao5VvRLI2tAAtXehZhW7480MflODKLSWaQq9BFw1t0Q6tJtw
X-Gm-Gg: AYBFou1Y4EFEBLxagTfq67hJLroJahJQmzRcdrCXTpUjIdQDAdpj4Wj1kSqBgO5OAVG
	YWupUMyxTUiwdMDeFwXi4uLDt9yQtVrvL1857BKYvSdUtPFblFWVA+6zSvYVndg0eeZVWqg6yKu
	D2oidBdgHJzY+yiji0k8LUBwl1eySwgW9eM/Iol0LGBF9QZBIBblQDKRceqxtBvBUeayOsdhgPr
	MRObz7YUqm7F/7rBgo0dPDtjaLciw8Fef+eJHcF+cblXz8JenHZgon0A6sbjEO3CjlT2XQH6p2F
	gOT7sLlyuCuO7CrkMgCnxkyzzwg/+6z0LlQMbA1jZJ4U/EYFtauXEWGZFcmuKq3YURU/GRGrhvT
	1Dx67kT54W5oYuO3wGuoZYwYePqW0HD6P7RK8ZhRXaxmHzNQ+ba1wuRzcgPzANtPzOKy/poFzbG
	UskCUhBzo1PBK3TNFEFtTiX3pcEByVjKGYyX+bTCnGjguHnVM+c1QFkKPwqZkntt9wxEWrztput
	XSALVMdAN8QzlOvvkRh4ItEDMwKL1ScOqJLjf9Q6CxWoX3vXLp6bVltlu4rdo9KYHlJ4Tvk8TiL
	Z7qFK+QAkhpH9srBdS5KVabtcNVHqNtmA8bPIbTwWuz24pZg8A0LDTe6o9jpFFrfaFc/Z0PCY5l
	DKzmzrQAlnw4WF1rQrtOpvdG1QFA+NQWt9WMPhQ==
X-Received: by 2002:a05:701b:2318:b0:15b:afce:62c2 with SMTP id a92af1059eb24-1b25d359e6cmr6341135c88.41.1794017255593;
        Fri, 06 Nov 2026 18:07:35 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm9338497c88.7.2026.11.06.18.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:07:35 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/3] bpftool: Preserve unsigned enum values in data dumps
Date: Sat,  7 Nov 2026 02:07:24 +0000
Message-ID: <20261107020725.36675-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107020725.36675-1-dennylin0707@gmail.com>
References: <20261107020725.36675-1-dennylin0707@gmail.com>
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

Load ordinary enum data according to kflag and use btf_enum_value() for
name matching. Select the numeric writer according to kflag for both
enum kinds, casting the value to __s64 for signed output.

Fixes: ca7e6e45d108 ("bpftool: Print the enum's name instead of value")
Fixes: 58a53978fdf6 ("bpftool: Add btf enum64 support")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v4:
- Keep the normalized value unsigned; cast explicitly for signed output.
- Remove the signed-width compatibility comparison and match-priority
  logic, as requested by Andrii.

 tools/bpf/bpftool/btf_dumper.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 3267163119dc..a7171622ce57 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -149,28 +149,29 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 			    const void *data)
 {
 	const struct btf_enum *enums = btf_enum(t);
-	__s64 value;
+	bool is_signed = btf_kflag(t);
+	__u64 value;
 	__u32 i;
 
 	switch (t->size) {
 	case 8:
-		value = *(__s64 *)data;
+		value = *(__u64 *)data;
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
+		if (value == btf_enum_value(t, &enums[i])) {
 			jsonw_string(d->jw,
 				     btf__name_by_offset(d->btf,
 							 enums[i].name_off));
@@ -178,7 +179,10 @@ static int btf_dumper_enum(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (is_signed)
+		jsonw_int(d->jw, (__s64)value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
@@ -204,7 +208,10 @@ static int btf_dumper_enum64(const struct btf_dumper *d,
 		}
 	}
 
-	jsonw_int(d->jw, value);
+	if (btf_kflag(t))
+		jsonw_int(d->jw, (__s64)value);
+	else
+		jsonw_uint(d->jw, value);
 	return 0;
 }
 
-- 
2.43.0

