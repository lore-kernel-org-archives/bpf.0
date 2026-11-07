Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017256;
	b=WmESMtvF4oIPfDbo/crb4xqqBT5tN6legyLAePafSN+k6BagYoSM+C/WbAzFijQH01UR
	 SkBG4Sr7xgC2W0/QWFXNDi3S0DKLf/LomdsfgXTFjfJzXXUt2NGSRbaxG19roEY04DbQ3
	 8lvnmiEwoXaX9YOr/VnTI7zyXb4AUfl/IuJLatLZ9WcL4XLYi0pNLOk7qPAdlSVzSs4+7
	 egYd5AZTG4oo/k0GfbczpI70CqAnjbVkrJd0bTluUHvgRa808oklo01mc07J82wtRMANe
	 epOxyhKq8+7xyY7yjvOvAqv0RG9Y/It6llEApkxs9ZsJUgTQytaBgbKaXq7R4tbdCew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nm1koDck7vzbeNbMewmGKmgBZQOKfI/JO390sHTU+p8=;
	b=EOIbjDZC0HKmxalOxNNJ9AZvi0IiyZX30qH/XqMxTErHtYlPwnvp9AlWHhoTJYIhzD4Q
	 mTtdOBen3uIFnDdwiRd267OMOt2Hne105+w/WtEWawprmTD/1xRPNGDw0Fcd8I/HxiET5
	 3fjGFoLcyiKVjOcWQ3VPCLFeIV0+lrYXSF0brvS6L4X/8OAKw8IHrLsiItiQXDX/VoqtZ
	 IgoTaieuYWmYJb18hrKmwlXyI5ng5p8axGlLBmZffTmx5Pd9FVCsi+3UgvqJxsc1yZ3G2
	 +qmIBOZqrfzI7EnqwyzFzNXG5IhL9yx/VOaK3dnMq9G9GCF1fbWxWctpXEGOAQj/Ksw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpfecCtS;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B30606A338
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B30606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpfecCtS
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-370ebdde89eso301517eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017255; x=1794622055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nm1koDck7vzbeNbMewmGKmgBZQOKfI/JO390sHTU+p8=;
        b=BpfecCtSDVjmiLe9zkEbkzm6VdmcxgPSse1IwEMGRMsEjQMdPYtthaX4/MyA+qKWwT
         M7tj+0bng2BwVrdRV6RpvSTupEZl+wTRhbkgG0PKEMV2QmiM0fXOMRM6QKKZJknR9CL3
         H5JumNa13GsIK5Wuhn8ZldNTmgZ54gac0w03AY3TPNH+S51EDG5u/wOmT3lDeJrdfQQp
         J6pDodqdXoCmKEcjMBM30MWe9Hi3ImDE7Ftnwj+JAfc1DbjsDpdj8TzvurU3/zIJLMiY
         Q8LdwBt1gX6RO1Usf9T3uwzz1mY7gGNzpFVS2fshDs5mGXy1vGUA0nQNjuqiUkKmUlHw
         Bmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017255; x=1794622055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nm1koDck7vzbeNbMewmGKmgBZQOKfI/JO390sHTU+p8=;
        b=a8iVjXuT+cSFCvBWaV/cJ1VAQeECec5YjH8/Kwkh7IwYznRDcbAh8QwPrjZlvFOJt3
         6sG573tM1Q8PhrBOD/1q+JnnhDjjg1apQuc6SA1+2bj5Wa4WMIVFMzqo1LLeJBxi180s
         QYveeuIQQ1KBpLM2iNXgY3n1+mxEuE1LfUVVnVAkIze3hR85fa1MxcY7X/ET35g6T2kC
         HhxPLqAG5C2a2w74xuma7w+OcSyJ5qreVz+3TtUPTWWbvFh+B6RedbGUF1+uDZkV3rg9
         EtTnztwtv817/cERw8Gn0F2dS6nr4O/zssQdg23RIvGJCvNKyHQNnv+i1qtdHqixDZ5J
         aISA==
X-Forwarded-Encrypted: i=1; AKwUvByAbjtWNZMiTf1/DPENAbK3kPUckSyvxYI4ZBmt5FCBatljfG+BsBVYM/t8IT8++cCNJPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z93zGSGhgpqUVuFYiCFeGwhQgFIzJwRt6h99wPQoR3GhX7rNNJZ
	hZwsN/IXJRBG3R+NodItgX93jT1KxFxzpmZt8CNeha8HP9AfJtULykGw
X-Gm-Gg: AYBFou1Qj58LJ5zkx+xGheOcD6qqIvvBE+o/7huT1GLUGtYgEmiB8bFqQ9/hJX2VW7s
	luQNPaWxLvxGNhN+hQFMMZNJ0xkB5Idi2EONrL4o2pc1QFGndq+j9yZUChiFtKKcxoB7mQXZFz1
	gQ84yUYX8MAIH9cNxpRNHVdqk+xyLkSwWlXCBXS+YW3Zacnd5NvbrUVH7iSh3OUyrR2b+t5Nikn
	8Sqby69vGTH980FxYaKVtIImycklKdfSuQAfsm/IVDEdBSnvEB3UKiwayp0SSAJjnUOrTC8Q95s
	1LAprx37KOSC95V09WzDLi4q1FCmPuGL+HwyqSdz3mrO6urqHiAizJBBHbzHdhuEpDRAirQB6cQ
	Zm03KBB9qBHt7QygbzDc7h3ZGips3LPi4pUwfQEyCrSYAlGuhYTW7GfyVOMBPwKwXqohvbr2NYC
	A4x5SPzNEGKgXDGP+iGET5LzyqppH3inkCMC7aMpEqAmaWciytQjBvQvtdgRtSRGUVYXxoWo5pI
	B+2D0GtTWUxYFQs0gV2Tmkk7P7S2+qWhu6dy00Yyw5ClV9CoiJp/45rWUWA4E3MYVbTH/shQMnm
	Z0gs/mFC2ejRFS6AgtdNWwzJ6Ae75Wb4tbJrFwZDzVUjiWn1/wAJ2+o7ZZG7M5EhFBTXqfwBUXk
	y9e3/HG4q1ELwvkRvzjdB0Jf7dU3+3iePX9GbQHQvpIGxOltoGdhCrNCRwIM=
X-Received: by 2002:a05:701b:270d:b0:1a5:9abb:fdd7 with SMTP id a92af1059eb24-1b25d30b02dmr5788693c88.9.1794017254824;
        Fri, 06 Nov 2026 18:07:34 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm9338497c88.7.2026.11.06.18.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:07:34 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/3] libbpf: Normalize enum values according to signedness
Date: Sat,  7 Nov 2026 02:07:23 +0000
Message-ID: <20261107020725.36675-2-dennylin0707@gmail.com>
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
Changes in v4:
- Return __u64 from the shared helper and compare normalized values.
- Drop the legacy comparison and rely on kflag, as requested by Andrii.

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

