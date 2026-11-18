Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018880;
	b=aVQ6OVWPakfHvPKl+JcXnmLUb+stFCxbFl7N/ihXsUO3PcrmtjqQkl90gTnC2vAxBuHy
	 tHb/NHAf6UrIMZzwyzAq4xYcFP0riwi0Kq0ZX1b9UJpN44+5L2641afrJU4ddAeDOrHIS
	 odnHGrugOW7P2mR/FEfwwee/9PutinTDKCEACy+jFKQKyLTON/SI9RFNSZwmMdeikWJQe
	 fbxDPEevu7tQOcxWJp84yWpzP8V9ae9DZ0N0Cgk52AFCtfsC9AiHh7psvPlx0qcQEI6Oo
	 HJXGut1gW2ryDgdZGLFE2aPD3cqHSqO6r8+v/QZC1gdU/XLDskVsNyzOsMb5Al0iy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Y8VdWExV2s5qhyyjyIKU7zN98yjprl+AvhFl87ZyxE=;
	b=j/rSshKEEiSr4H57WSYW9+q2FowVyueWMeWkIl2agkAEvw1QCDdrSJfFBjsEaXXcGhjC
	 9wwoWvYiYnnILBCJzAJ23nKYn5tPo1IZC133CcKZyi9/Y7CAPkqXinh7xFBwbU2MvrYN2
	 fRDdgQiatE7yEe95quLYQp7yj+LjBXpxIHnjz9ZBBL03i+rmd/8cunBGc7mSOvUqNkJjL
	 sDo0fu+/3399bLCQKnj4J+jAStR2z/J8Y3G0VvWKPvwce1lAvX8SMNliBnbBS6wCjrlg1
	 WTqu7fZQVFEuzkOMsVd6rO7+c/6m0JVGnupDflNvCyD+bozgukG31Y9ek4wGvCwE4ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jfq63qoG;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6C606A32C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4A6C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jfq63qoG
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e93d9c7973so7036575ad.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 08:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795018879; x=1795623679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Y8VdWExV2s5qhyyjyIKU7zN98yjprl+AvhFl87ZyxE=;
        b=Jfq63qoGEId37G82E6uYvzHf8pdskudj9McZuaFxc1FZcxCN+RjMvdu3cYp6bbb3qU
         m10nUwMkKlBa/uxYKDm1H989OVqOq1QZmVxzR4SAQxP4w5HDDGa+Iq/2F5fQJOf2C7hz
         Fd4OkBaw362R8a77eJs7wi8cZI2xI/F6H4J68iItnNWShWrqCoG30Hpuz47hgXV3i+LH
         QtPdM0b/AkU88ykJrj9VSuWQOMGig+qFC9MC2GLtyyWNwDolFTGQqOs5lAaIEz27MVLj
         6YEKTldPU+GoWXXyvVx4Jwp8Jp3Q2fnQmSpWTfDrvjONIlF9g0MQrZ8roi0S0xiNNrcb
         Ndww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018879; x=1795623679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Y8VdWExV2s5qhyyjyIKU7zN98yjprl+AvhFl87ZyxE=;
        b=STRd1Kdg0X7UF7dyN41ugS8l0RJ4k+0dcNWSqpOHAJy1ctJ73s5ZFI6TWrMXp7x1tW
         RXnTsJ+MDEhlz8+/6y1ui25veBB6bZN4utudUotiIlOCcwzTlCZ8/R8RMLm5Uvo+hOk4
         PEKDQbO0fM5vum23eIUj3cKiwZEe+6mpYivWS1KUn7Tja1afrVFgFoMczJYORu4rFFyt
         vz3WH+lfF7M15Q818N5JqGLPtx3fZ7qHkeFxCje61rmaEhhnZuCeTGLWc0xjZNlEMhFz
         m8mYamL3qz2Xl6tB0D7pqecypdehUmk+F5lnnZHt6rNDgVsEQtFGUZ9ZXn+6xf+STH9a
         EMZQ==
X-Forwarded-Encrypted: i=1; AL+hErHSZZqTdA/EpLYDvtmTj7lLCql7cYVT736ShIM50ML4URuYXne8B7cwES/kxaq9oVhpcic=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UyV3rT39nGWgjfkr3ABrQ9NCJ/AtdGjiXHTB5m9aCaHaGHue7
	OFH+l50EIeeQ9+DU1om60TeGDHkx73YK+bFWcmDWkDPVuumzCnOqpdOEZHEamDEIbqPNXg==
X-Gm-Gg: AZFdTZeXP6DGXwchnYV6XRbjbl49MHpH5puu0MpRrW/FFTpsUp20WBmDtPV0CXPsBFe
	qaevi9Em7Gzyg6SXvByVecZ/4DVaFlC8NhRHJ6OAHVgH8eCoaB3XpF5LJf29Z+KvuTtB2itE+KV
	zcAuCidFaXf2BMzh2WMAikudBUbm1doXKMWyc2mwwrDnuMLsN9aT9mRPY5zk4qy3iz4pYyEImmQ
	140m2nWwPv1hDFe7x1KT7xYl2sombaoTrMCWkNHBC5P8nQVJXpf/CsNT/zOf3Y5eL4AniMlxsP9
	/Og14KMEn+ZxLPQ8eWqduBCBmTDHctXAJaqhCFoP9i/e8aYyA0wXw3wEe6HdMEOmkvB9y/5Edh8
	1OLSNRavMIgkM6KCeiFn4zjDpYFbmFhosxsdnmUb2shRIvoslMLe2Y/2Q/CahMhsCIwnJz2vLLR
	iG7Kb3Q/YFtvtRlalGNpeFD5pPCfeK/Kj8/hIMxuEN8wl9yCD44NVpkTdBsqLg216nOye8P1xp1
	qOJmEfD/Do24scGuNLxWciU/5BLXFQE5BXgCSJWdC5z2t34tLEWafE9ZWkzESAriGhBjezKd+Jo
	Z4qXPoRePkuKhNz3eteVXV7eYuXBTATm0DWNIFAEyBxDyco=
X-Received: by 2002:a17:903:18b:b0:2ed:130f:869d with SMTP id d9443c01a7336-2eff753bb92mr32182765ad.43.1795018878947;
        Wed, 18 Nov 2026 08:21:18 -0800 (PST)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6183f8csm16251145ad.31.2026.11.18.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:21:18 -0800 (PST)
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	bpf@vger.kernel.org,
	Shihuang Liu <shlomojune6@gmail.com>
Subject: [PATCH bpf-next v4] bpf: Check variable-offset accesses against special fields
Date: Thu, 19 Nov 2026 00:21:08 +0800
Message-ID: <20261118162108.178069-1-shlomojune6@gmail.com>
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

btf_struct_access() rejects direct access to special fields (kptr, ...)
of program allocated objects, but for a variable offset it only checks
the access at min_off.  This is enough for compiler generated BTF where
members don't overlap, but btf_struct_check_meta() allows overlapping
members in hand-written BTF:

  struct node {
          int arr[4];             /* offset 0, size 16 */
          struct foo __kptr *p;   /* offset 8 */
  };

A 4-byte store to arr[i] passes the check at offset 0 and overwrites
p at run time for i == 2 or 3; bpf_obj_free_fields() then frees the
corrupted pointer.

btf_record_first_field() returns the first field that ends after
min_off: it is where the check has to start, not where it can end:
every field up to max_off + size can be reached.  Check the offsets the
register can really take, min_off + k * step.  No separate constant
offset path is needed: reg->step is never 0 (___mark_reg_known() sets
it to 1), so a constant offset is k == 0.

Verified with hand-written BTF: a variable-offset store to arr[i] is
now rejected with "direct access to kptr is disallowed".

Fixes: 89e72f81a455 ("bpf: Varying offset access support for PTR_TO_BTF_ID pointers")
Link: https://lore.kernel.org/bpf/20261109094723.14614-1-shlomojune6@gmail.com/
Link: https://lore.kernel.org/all/avzIz70qnJIA2t3x@sirena.org.uk/
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

---
Changes since v3:
- Rebased on bpf-next to resolve the merge conflict with ca4395aade31a
  ("bpf: Walk each type once when looking for special fields").
---
 kernel/bpf/btf.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e95ca39f990c6e..ffdf12db1f87cd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8126,11 +8126,19 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		if (!meta)
 			break;
 		rec = meta->record;
-		i = btf_record_first_field(rec, off);
-		if (i < rec->cnt && rec->fields[i].offset < off + size) {
-			bpf_log(log, "direct access to %s is disallowed\n",
-				btf_field_type_name(rec->fields[i].type));
-			return -EACCES;
+		for (i = btf_record_first_field(rec, min_off);
+		     i < rec->cnt && rec->fields[i].offset < max_off + size; i++) {
+			struct btf_field *field = &rec->fields[i];
+			/* An access at 'lo' or above ends after the start of the field. */
+			s64 lo = max(min_off, (s64)field->offset - size + 1);
+
+			/* Round up to min_off + k * step. The step is never 0. */
+			lo += imod(min_off - lo, reg->step);
+			if (lo <= max_off && lo < field->offset + field->size) {
+				bpf_log(log, "direct access to %s is disallowed\n",
+					btf_field_type_name(field->type));
+				return -EACCES;
+			}
 		}
 		break;
 	}
-- 
2.43.0

