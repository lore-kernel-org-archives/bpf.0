Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816136;
	b=cUSFHQngR9N43mbR1W3CwtzI3LBnFU5f9nRSHhI81ZM70t8lZ9c0ZcrGzQ7O77Rg2zc0
	 9VPFqOY3ONRx3hcwiEK0TFSyN9IB1bYnCsNTB2X2JhEwcEyc4A1tQUjHSWoKptdGrBHhr
	 NP/it5ePSeIPIiLORJaa6tfGxeZ7q6r5E1UOFXUSH3Flws6DdvzMDs/6uapKZdEvoRArg
	 Xn+4hJ3OlVIiXfQvJpsg9nI6bus8lJqervT4glfF9v/mD7J1bpu9O3PuRpc7681ytOfWr
	 CmPMZpQ2uLNJDQysgD0lSEdF/lCq8mgOUsDKetIwgmfRaT8PhObXmfnl5hdVOS2vvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VVmP8n1fZ6dTUrYQ1pJb8BUanjFDIC8PD4fAF71ivjU=;
	b=atp1rIccLidUwIZu1dnxfR1Zii1L01zZB2St/24KZjyogWDMamFNKhJ04a76URzPvEpY
	 sYOlede1/c4qj3xU5VW2BO/qoheuqZabkCdVK7T6fgZjMVMYSltiAA6S3gcUDuMJjFqo3
	 EzO8w2yQZ5pqnlFaAGEjYDf1q6NSIliwNTCJ9PkzNbfB+HySuWW9yXXwtoa/Rve5FmSm8
	 AYFvd7Tey9fb5p74xDCoepza+vzOEIlpFElfzx3hqNPM/VJin9+4Daxj1TI4BiRoQEVaa
	 KoDopb+gILQrv12oe1TeGgN/TgyWgFtVDw3EhHS+k3WPVLIqDFZ4YwuUvzZsV/CbTGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="KMhx/y2T";
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBAB606A33B
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBAB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KMhx/y2T
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-36a6ce64b95so1356906eec.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816134; x=1795420934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVmP8n1fZ6dTUrYQ1pJb8BUanjFDIC8PD4fAF71ivjU=;
        b=KMhx/y2TI08m7/WuX0zvsxpuIz/n1FVNmqxo1m/44QouDZU/7IkYgeXP2aa1ro7XWB
         NYVpjzOjvF098jJAtQY+j4GtoPeD1EgRv1KP5Lay7r5qdoECqTHXoBEozVxkPzECneWs
         qiSmAWfbu+v8DH08l4uRZG0X7wHui6pFv1/1XhoKMiierI9vDRXZsEhZSTJ1kshLPWn0
         9g2QgsZbpBVV9PV561ux77z08sQYxIz0lglL8+ZPvOyfTpHpRK6cAWfeOAEk3Pnbjq0t
         6X8C173C6uCyjOB3ULUGYZGlSUK3EYOqgeA/NADr/jdoWMJHwLobgU3ysoS721QbfL6h
         GtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816134; x=1795420934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVmP8n1fZ6dTUrYQ1pJb8BUanjFDIC8PD4fAF71ivjU=;
        b=ahyZj3sGh6d0ha+0QnT1PggaYCgWbF6Z1oG95RWKXBhbe4Ys0N/TWyLyvn06vrgHzk
         iah1fSUZ3ahLd6p4S61hEZrBvliY8/N4uxFr0683uFK6DYKzskm77uPFeoN23Pbdsyq0
         0aIpBzmLLkaSpr3nwBS9QQsFz+emq+v1LLPzR2N2k85CxoF7a8Fd6nu62zck9GnNqTTA
         hZdAnNsYw3bZns6MOw8bt+ORRNXclbfdTjks3cRwNV0DOArwig8uxeF+IOoJjBWI4noQ
         8lfisZqg6oF6EOTAFiiuIUg30n3M53044ywXtoyhOpdfPRsAYYnrDcWKg8Uo1yeOaDLY
         Q6JA==
X-Forwarded-Encrypted: i=1; AL+hErENbD5e6KlTipaZyU+IN0o2fuv3fOuCbodQZwOOwvgMQjUDyxQJ06fyig5dJzliyVaswMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8O+CO6x4P4VOWz2sr5UrLh3cnoF+CSorJkHUUWaGJcqvulOyAu
	RPbJLL0ETmzsKjqSdvX1mX86a6iyS+2CcMhMYjqGcBLY4vm8V04+rl3c
X-Gm-Gg: AYBFou1JdvIY/f56Y82o4XDkmERpqCsA6S76FSBfxmKRAdxuE4gJuTALOiK5Zgd+oUD
	D4IjLzSIbIeq73jvTgxTUBsU5tbsUxiVhRPQePBRi1nLXnebwnJlqYHn6b0yiFceN8bBsm7oZae
	mioBRkDsamoGWzhwnN9WNexWLpjemgD6VgBB5zVNnBZQpqGZC8d2BuCPg7Tvr8Hc/i/AXq/TtW0
	7/lOscbWJinqxez7fjnJitxkGRkjnDCcmBxeCcEf56q7B1wi2rEygwyVDJi6JXsZcRw/2nHDiWW
	ORq2angY6+nsQ1Al79IbbElJBj9EZz+VygL69WhxRkp+YBVFqE4sOO/HWY3oRxqilbegDsSP5lb
	csCc/9qWsP/k8bFkx36fJ2LNuJO2uT4k2DoxZiiY6QyujDqhtSCIYe4+p+H0Wg3o7ieqBAGyzV6
	rWCx7ZztZXyua0XwnSQLhXPtpyCrxU2qbt+RAseNqPgxZTnjJuHi/Ts2eUDaHolszyKblJmLfE9
	OI8EydTLNaRLy2aHyJSdyc/dkiG0mLCebRWcc0cnAbY9/P/dqW+NX3sououARPMfV5kKfsKdbJT
	iN/syOTXtg7HgKaZ+i9fYTmsnN3mSnEWMQxO2WCUitNxHSf7jXjhErHSrzIABu+R8ul13FYaj1x
	Lj9ewnrADPNpQyWTz06WAhQsnNBALqWT99tlIoQ==
X-Received: by 2002:a05:7300:6148:b0:36a:270:ce76 with SMTP id 5a478bee46e88-379681c69afmr15104220eec.33.1794816134232;
        Mon, 16 Nov 2026 00:02:14 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm31128558eec.17.2026.11.16.00.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:02:13 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/2] libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()
Date: Mon, 16 Nov 2026 08:01:50 +0000
Message-ID: <20261116080151.44860-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116080151.44860-1-dennylin0707@gmail.com>
References: <20261116080151.44860-1-dennylin0707@gmail.com>
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
index bbe86928b3ec..050a5fbb9533 100644
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
+	if (!ptr_is_aligned(d->btf, id, data) && t->size <= sizeof(buf)) {
+		memcpy(buf, data, t->size);
+		data = buf;
 	}
 
 	switch (t->size) {
-- 
2.43.0

