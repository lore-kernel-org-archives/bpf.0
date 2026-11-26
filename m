Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655555;
	b=aKiWgaqIz60BMVKChM6P+C+9uM005zCFrF5DwYA5it5WMkbeyxCz+mMmvJ90rRjkkoU8
	 1TYu9ltRxm1R05KxBQ1w9BVjxk7Zwxt/glGcKZatHjeaM1lR5s6H06/jqiOQeSai5Q30c
	 bky1aqhgbLz629wxf5DIMkXtURICPbBbTHenqnm2BkDWSPZg4AKOQbUhXbr2FENiQsNUL
	 SFCu0cORRfbxwaZVdgXs4prfAJsRny22/W9F1yc1EQPYldn2CiharJbqPk3cR6C1DqbI9
	 w9XfTwY1DcOWVythy997iiTZ3yfDqY8rjc5f34Gjk51Tr0LBD59RENzPpjpRY9K+1Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oWWt+JRsU8dIht0Xx5BJG7ychdP34VOm0uiu+1YVjSI=;
	b=tTUutc+9e3X61gZmtdDvWD1C8W7XkMUSo3rF+iMTlo4vRmUhx/Aot7BIXfAh3cFc1n6O
	 /fp7DLcO639uewSfC9UpBdlkhynr0FuwnSqZ4UbgLugCvJx2QVDC3W/wo72Uk7pGjkI2x
	 CT9rHwRrD97hqEVVCkt6S5pICOHA3rZXmgXi/Xg/9BqPs/3Nif+dsdwJxqvaw52LHaF5+
	 T+SVxQGahWWHm4BewQdn0rwnV0ri1ARs8AczxIanXJCoK9gNUkLC6EtWeyGu/oiwaY4Sw
	 paf13X7nuxrAYKeMsmWWYsuUuQBA55YB47C58AuvjW1NyloebCQ91KmVSzR7T5YChig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JR9cGXSW;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B6606A68F
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1B6606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JR9cGXSW
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3862cc30b3aso1500231eec.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655554; x=1796260354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWWt+JRsU8dIht0Xx5BJG7ychdP34VOm0uiu+1YVjSI=;
        b=JR9cGXSW7EleW+6lAnwBcid8RuQrYByV3CQDb8a/cQ5vpMt2C9Zl723R/aKN6sgAy3
         pxC/ikjBiy30XemW31DZzjCRCZhc96TZ57kDXPjgGPVUVYSgPUvvrqTDcaBIzBpoyoVr
         EmbrTdV0n2D7y7H3bLD+7qK9yZGvpSFpf1InLS7Yie2krGW/3f2ma8l0iZU7QMi2qk+B
         Jr70eYTW6auu5NytO7a5+dyxSFtbwMdci2VgDqzty/6In3/pyBEVLzOIM/VhYro0y430
         DMWrCX/oH1Yg1w4QZDkN/goJyzRjO7clrnIgaWgGgXSqWmEilm3c2m1+EtF+scZxj/mv
         OoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655554; x=1796260354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oWWt+JRsU8dIht0Xx5BJG7ychdP34VOm0uiu+1YVjSI=;
        b=nJhDLvxKYRY8WN164146pu9J41xhjBuzoNPeX/NrI2E3Bbn52QTk/6Lrx3+52Vjn6K
         ANzzlgbD6FhkePQo5gWuM3HYo5xue64DB+uYQXX0suKPd3r6spb7Dp0Tik3ZFLvqEvc3
         Gh/pnmR3TRRI76OzPfaveogfPLPLV2BMNFKLo5tUAz5MRJX5hhYmOxl1CH2vzok06IqL
         rex6XV/k7gLIMiI0ZMwJgAu/ai1fDBXI5rXqlbKMRxVbRz81zPhYB4aFWV+ogHx4lOWW
         FHnvJ57Gbv2hU2ukHIAeTZIiu3yuvBkUv8do8+BNK3+K5rwWO3A1a2YpBbzOGifqjnhY
         rcAQ==
X-Forwarded-Encrypted: i=1; AL+hErGDu4o/I5nnXa+r9NhYBPLxuchc/JQ19XlF0gpEFrmkt+sABCTYGGSiSGghdgXa8lpFoBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RjpyhTZv2MCs7maV8BYciBRMP8KepmK/5Z0xGEBXbNJJQIMko
	8YVH402LuV6w+nIESLCWQNbnkDuOnczR3tlVZZ82MV15a822bKqFCXOY
X-Gm-Gg: AZFdTZcbqpOiEwYJ9DQLA5mGiFkPH5Q3GuRt+LPZrQHi6urDug871vCmiu5f13gPXS9
	zEH4Dw44Dy8RwkpVgHeY32Bm64QglA7EZ/7vmFAyt+rZzuPcLwoS9+B4d+A/onAPQ5veZWYGG0W
	zCMnUNs3wve2hV58RAzUFSgfj3q6vrULglY/k5uAoMs8GfZExTU99Psb34qU2M3k10TAdCe/rZI
	+yUu9BvxEktX8l9nnFpM8Hj8meBOlHMzcLDN3MSOh+Y1wYJDjNgNHzgpIMhK8C9YmuZ4HPeUR5v
	WYMW04xP68Dztv7RS49EM+8TGnVdom/KufmDuqeCnwz0oxfGUc7PSGylN9kZjsf5+Wl1LJs5F4o
	hRzIDNrexSrGzJZmlqa39RXbsOsYPkgY1RZjs6+cOhGdOB3AkoEhAxG34Fs5e1/Ue7reHkjMe0g
	FLWCi7pPHrhZsrXrPDg0/zdilJz3IwVDynRNEZ4PQzl5jGP8TkFkOVzmeE6ZHeUqSwKHqgikUbG
	tRlvP2G5Ok/cL6y/e1ZIuywlJB6/RapvxeQmiA5zHXSkhaPra5puElgi3NobDIKoWCtprgTCHQk
	JxNbQh/Chz/frVeb7h/Mtl0uPZjkViaCEMPfK2moo+hrskNzhId1Ar8YjVPEOGKiGRMp5BuKZ8A
	6A2k2Fit3kyBIeEwrPHSi9WWaPYSeM+tboOS21xLkxg==
X-Received: by 2002:a05:7300:dd46:b0:385:7762:e1a3 with SMTP id 5a478bee46e88-3857762e729mr19101315eec.24.1795655553614;
        Wed, 25 Nov 2026 17:12:33 -0800 (PST)
Received: from localhost.localdomain ([76.33.234.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm55717751eec.15.2026.11.25.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:12:33 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/3] libbpf: Fix zero detection of enum bitfields in BTF dumper
Date: Thu, 26 Nov 2026 01:12:21 +0000
Message-ID: <20261126011222.92180-3-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126011222.92180-1-dennylin0707@gmail.com>
References: <20261126011222.92180-1-dennylin0707@gmail.com>
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

btf_dump_type_data_check_zero() ignores bit_sz for enums and reads the
whole enum through btf_dump_get_enum_value(). For an enum bitfield that
value includes the bitfields next to it. In struct fs_context,
purpose:8 and phase:8 are followed by need_free:1, so with need_free
set the dump prints both enums as 0 without emit_zeroes. phase starts 3
bytes before the end of the struct, so its 4-byte read also goes 1 byte
past the data.

Check enum bitfields with btf_dump_bitfield_check_zero(), as is already
done for int bitfields. btf_dump_get_bitfield_value() bounds-checks only
the bytes that hold the bitfield but then reads t->size bytes, so read
only those bytes.

Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/DN40PKFY2KUF.13KK78H8OW2J9@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 85a30b373788..3387ceb2a3d3 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1879,7 +1879,7 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 		return -E2BIG;
 
 	/* Maximum supported bitfield size is 64 bits */
-	if (t->size > 8) {
+	if (t->size > 8 || nr_bytes > 8) {
 		pr_warn("unexpected bitfield size %u\n", t->size);
 		return -EINVAL;
 	}
@@ -1888,13 +1888,13 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
 	 * stored in num, then we left/right shift num to eliminate irrelevant bits.
 	 */
 #if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
-	for (i = t->size - 1; i >= 0; i--)
+	for (i = nr_bytes - 1; i >= 0; i--)
 		num = num * 256 + bytes[i];
 	nr_copy_bits = bit_sz + bits_offset;
 #elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
-	for (i = 0; i < t->size; i++)
+	for (i = 0; i < nr_bytes; i++)
 		num = num * 256 + bytes[i];
-	nr_copy_bits = t->size * 8 - bits_offset;
+	nr_copy_bits = nr_bytes * 8 - bits_offset;
 #else
 # error "Unrecognized __BYTE_ORDER__"
 #endif
@@ -2574,6 +2574,8 @@ static int btf_dump_type_data_check_zero(struct btf_dump *d,
 	}
 	case BTF_KIND_ENUM:
 	case BTF_KIND_ENUM64:
+		if (bit_sz)
+			return btf_dump_bitfield_check_zero(d, t, data, bits_offset, bit_sz);
 		err = btf_dump_get_enum_value(d, t, data, id, &value);
 		if (err)
 			return err;
-- 
2.43.0

