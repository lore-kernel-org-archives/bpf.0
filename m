Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794732575;
	b=tmxLtE2WLe04Fv4NMgEXLkT9OqFe+Rc8miwWebcPdLZskfKjEtkcpTsHYw2Rb3lXJRcR
	 fxlACNPVcPbxNn1ZhOoOJZVTzbd9TpRwmv05CrN19dSwBYn7armpHA3G0UXtP8EEggJSK
	 ah3OozQbB3ndM833BuZjJOZF7Wigb0zUfBsX7sjq5ARsYPSoLegG1irBXHOaVLOfUmRWL
	 61qo86YRTm+oqjuyYcXi6MpLC8lDacLIctPJBtQiG7itncEUKJCWQ9mWyM4kES6Ud/svI
	 9chn4gJQeTp1348fDUwo5ysD9CkwYDYAZ55Mo3d91WacER7Jj7sx03BJM2WHzsh7CKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794732575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Chzegh18gcBEAWx7UANv0tSlVU5fQl0smulwKtfc82U=;
	b=mNfx7qUKzIqBuU1B6uuqbb9lBP7eXpT+A7asSKby/U1yPsXAN0xx8GPjLYyuyiA36VAi
	 iDwHo3eELj9EAhWmZsmLhKp8cu3gH3Bve5YD4o9CY9bK92SM6SBsTByWslURqvHJlF4AE
	 dRRe5HxDYSvpq5STE+wNHdvg74pPZFPdEz4rwO/PEGuzw7kYnOH9wxRvEKBsbGYOgJ7Xa
	 LHuThNbCxU1e43vgqWSoPmfPs+fSzSW7Vdhe1prp+qEHSW3M1dhttx+JwTbQzysB2AOI4
	 GY1dMp1D+7xXZbVt91kCyPunpu/dsyPNC+VZPWS07OI7m9vjD5Yh5c/RcW3CD4zCcvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHwPy5KX;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A143606A330
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 08:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A143606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eHwPy5KX
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so2811397eec.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 00:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794732575; x=1795337375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Chzegh18gcBEAWx7UANv0tSlVU5fQl0smulwKtfc82U=;
        b=eHwPy5KXIJ1E8/MpMkjWHRKMvhAF+WXNBHxnXqSKwiDN5jRtxyNGHhTcQdwOk5tidq
         woW9rzegoNdwLAJTfHKwGWXkRE4WIoY/2wCQ6/xX064ijcLk5hr7hQ0lDJSE26kTArP+
         /ICq2uyzuUSgcJ55fa56HhIwbVs5OX3yrepB2x/J5cIuP17qo9i1tdDitdRcVEIec8/9
         7YHF5fv8Q5UYIwfgARDw0MJQZrZZwPkUqi419Q+Um2Y7wPCZD7CT7Aq6nFIVo5Eowy8m
         1K7gs+ArGuDqpw9IuU8KmzkUIplGSnS4fnukIv3foYRkJIGUmvP6TZaSadekHuQwy+q0
         kwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794732575; x=1795337375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Chzegh18gcBEAWx7UANv0tSlVU5fQl0smulwKtfc82U=;
        b=EXwXEcBfSzSVAz+8H41t0qGw51jzkk59eapGX8OgwmEbdr2+XqV6vF/4KPiIbCeyLt
         9iUJzAE4mGPAzJFhUhVC0lCJ2BfLPYvtGvS2DgCSgHzJWLevh2gJM20KTiwth6PJnsRJ
         uSyLtY2VjLHlsEt+VvBAldHrlwu2D7wC/yoRnNNR4dZup4e7zs6edqT/CeIQfARMbmGD
         Q8bu8dS6yCngJt3omjKdlL6u7boqRsB483kSsZ9A1lJiq8P2bm4+mPjrhmMX2r+Ho+vD
         Zle5NRkG3obwdSn490BKO9hvj0aYX/1zhV6Mg1cYaZD116DhvUgC9sEsWJvYIJmGgXxM
         TQCg==
X-Forwarded-Encrypted: i=1; AL+hErE3Nn+1CsCzmHjCr+LQgz/XXRyFk69yOndnTUvAw10OZi5ia/qf9kGAkiADBmtko0hV0sQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9osPlF3O6IBdTrr+UZVlLD8Jk/iYtJQKkD/SKpFggWnTP2LA4+
	R6+Ulilh+ZxZ9mT/x42rnJ/zsSf2hRyWnNIJS1JIUYWnqiRYZJBWQu6C
X-Gm-Gg: AYBFou1H3d8dSuGRRAVcizlnAnR30wZwfrgccq1Q8F29EdOTrD/0cm7boty4FGa7OdD
	5xIJK/P2fSFB9YmaWQ9Yp/ib9U6ATRVPWdqPrR22ZUNAoALvpzK4tqCqVkQi4mbYFy+1XPwTVDW
	9zrVVfVEkC86DULHZyKPilgoiaTYypDjL0Nq/6wz6zZ0I2hz76P5iNteTIo0eCuFAI/2l7nXut0
	hmvM1aGEYL77rS/U2JC2M5cxWRg3xVkI5XrPIKicEyt9DEXCgxqCC9taOcCYpW42Pgu7p0rsq1j
	QQ2I0Fxr5IvJla+qMvJazsZPp3ntc1BVmtxTkm7A/P1iFtNR2D36TcAqPTglEW4lq3uMTFZnvOG
	SddxVxIRbbH6mX98jsTmhDUKr11TabNiFbbgqxTsTXsaVH0IS3wEa1wLooSQpDBshfBOkBAbJpT
	8Y9TQOuLzwVymKoL4BLYPR2lPbVYblTsm4rWbbXG17D9LspJur30P9xdjVLzzJ9E+0wstFUF8Uq
	4NLi9PXxf8WsXkP7VmWHlvCfq2RP8KvDs0KmBVvSTyPwpQPO+/1rxZYWGzYrzIFUNkkWMW7CR0V
	F8mziFgh+Qfge9zx9O3sIRuGBMzLYsL7FbmGJetdm+xyL2aFksDr06KI2nQsHK+EIXspATGBy9+
	Ez6dhpZpi5uz6f5PdOGknJuNDgT8zQTnK/W0gBg==
X-Received: by 2002:a05:7301:5086:b0:36a:5042:85b1 with SMTP id 5a478bee46e88-37963376ef2mr7610050eec.2.1794732574664;
        Sun, 15 Nov 2026 00:49:34 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm25221051eec.23.2026.11.15.00.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 00:49:34 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/2] libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()
Date: Sun, 15 Nov 2026 08:49:22 +0000
Message-ID: <20261115084923.53182-2-dennylin0707@gmail.com>
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

btf_dump_get_enum_value() reads unaligned enum values through
btf_dump_get_bitfield_value() with a zero bit size. That makes
right_shift_bits 64 in

	*value = (num << left_shift_bits) >> right_shift_bits;

which is undefined behavior for a __u64 on both endians. The path also
bypasses the signed loads used for aligned data, so a negative value of
a signed enum can lose its enumerator name when the data is unaligned.

Fix this by copying unaligned enum data into an aligned buffer, as
btf_dump_int_data() does, and reading it with the same loads as aligned
data.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bbe86928b3ec..a80762a70cd0 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -2329,16 +2329,11 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
 				   __s64 *value)
 {
 	bool is_signed = btf_kflag(t);
+	char buf[8] __attribute__((aligned(8)));
 
-	if (!ptr_is_aligned(d->btf, id, data)) {
-		__u64 val;
-		int err;
-
-		err = btf_dump_get_bitfield_value(d, t, data, 0, 0, &val);
-		if (err)
-			return err;
-		*value = (__s64)val;
-		return 0;
+	if (t->size <= sizeof(buf) && !ptr_is_aligned(d->btf, id, data)) {
+		memcpy(buf, data, t->size);
+		data = buf;
 	}
 
 	switch (t->size) {
-- 
2.43.0

