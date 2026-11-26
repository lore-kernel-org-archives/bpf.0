Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655553;
	b=SO7hpE1mGCDx6iS9J3o064yLHCqK0NCUf+kYmU/A+XgMAB4XYcL+VpZQ7e6aKCr2nKhi
	 JfSpWRgvbtj5zHwHOiPTBZiTouFPSj1QFZqUPrYdip/pXZ1Me9yT0TDo8IoQ1tnsf+rzu
	 wcOw2/R9P3vGVVaSVS0l+7aDo/2usgj8UVhyVYt9A6oCcz8B5nD/iHLnyQhOkn5+KQwKX
	 B1oHrvjX7Eb+6TKGa/kK4dDME3zwplQDAD32je+UbYgJ6DKH+2pJRADf94fWGBrqivxiS
	 O9pGsip2HW5F0O/UCI9IP/FCR1oAPcPf0Zb6hkx5ZaUsvHavN+DsSFie3nwAWwD87ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c7j3FwDOAI6nNbfO+ghW/xE23uGn+Fjwx2xqRw4fD6k=;
	b=BJb77+z2Bk3onXL73L6uEdq2NZPfKy4/dikRs8pyrb+lmlEqOdW1nCM2khVWrJr6AsIV
	 ApaQCrq/olJjAQodHFOBxdZLsE6fw2xOfYAxjdk7C740AsYs/CB7AuO9dV4WnG1gmuZ/0
	 lG7CL9Nby5a5PosW6UjWNoSilGWOtq0LQTshwX9bleZ9oywO/ZKb09ZOPWH4sWYMlxsBm
	 R0qOA1l6PDUOhiKXiDvWscZjKVa3Ca7E+stw0IbCnJXez3rSAR5kEIuUoFNlYRZQe7HEP
	 xrfvzmPYaDkxjGbcwwJHTtaZtuUumSMcef2GKE4YuyroJ9ovTvcV3zZrfGe6e/vPD0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MK3QUops;
	arc=none smtp.remote-ip=74.125.229.2
Received: from mail-dy2-f2.google.com (mail-dy2-f2.google.com [74.125.229.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A40606A334
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 01:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A40606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MK3QUops
Received: by mail-dy2-f2.google.com with SMTP id 5a478bee46e88-327b1d5824fso5048882eec.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655552; x=1796260352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7j3FwDOAI6nNbfO+ghW/xE23uGn+Fjwx2xqRw4fD6k=;
        b=MK3QUopsaaw6CcNV6fOtRW68+gQVBX78U/spdYzSoF0aQrffCDrjeSSKbBtIpNHmlH
         rM+ioH8/FugzkwxZeuBQQ9xetS0XqKY1zNaOBi3f97vvJLQAIP+Rp3Aye/r0N/YIdeQ8
         ksnEQ7cLMaHnDQKcG8IsaYlLRJ/Hr6FCtOcjQTCumfrmSHEOTWk3pidV+BYHpMBITefP
         PNkuafPAr2uhVPNwe/gPfyStEo1OGA7h6KPpEJD8Lu64AZOLnsg/gPG0So5yA+INcRdd
         H+dXaOubw/dNOdkSVtQcPfVbMi1pP853ddL8GHu0KdZPbrxFt4dkSZzZWAP5NgxkwOTO
         6RTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655552; x=1796260352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c7j3FwDOAI6nNbfO+ghW/xE23uGn+Fjwx2xqRw4fD6k=;
        b=CoxJTk9hHD85Onou9e49jYyVEgj/4l/n3Btsbtk/OI8bOLQznZMHwiO7b4obF+viJL
         aoqvE1uSBNFmV4bgItK2w2ylRR2ypRAIsxz8jRSVrmJtsxQlEvmJkcWDskAolsvieuHw
         jZqnaytziX7Iu95WGPJNVQprMVgjyTGiIzLOhLwtAKUKetIsKiOBeAR2tO7dIpy5XQQM
         Nj9SrPnEmjDkX6JmttP1OTurWluwzSBbbIzzd/AW3KwzI5HkiHeSA8MUBBlhRyds+F6T
         xJuKUlnxnl82N1xpUDmUYkHkSD+R1KDGF6XLwHDtkNxhkAqUEj7E80i6yvCDN1hx94FZ
         pkCg==
X-Forwarded-Encrypted: i=1; AL+hErF8RQ4fJJ5AYW83X0UBnpXfHLD4Zv3Gr3a/eUs9LKDZAgEX/uRW/xBlKpE2nTrfbeYTd5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BRGx9YrNkqj0THCFZ3pt0mSdjgtzkfETozbsqYZ5kdpDt10SL
	lkv7bnH1PcDMie08ft2A5htHvU59wwAZ91cqH1bSiRU0/74wftNCYzM8
X-Gm-Gg: AZFdTZfwZwDxvc/5HHrXynsYmsdb2KBuj6t+12pBRwzxiNf0BLwtKIEzJ87YFPqHJL2
	2S7Q5hNQ2tUXkLi3Ev6vO4bv+RVBRoNaWGQwEbiqbi2n9UaE9rAnM/erVa42gFtdz201luROiHF
	L1t0fYCqEnoS3T3IFpJe9NszC4UyklzJBsP31x1DqOVXQbY5LEofCttwrIOME5o92y9V+tvLxzq
	cvAZCJy6JBxnI2kvoQqnj/mYxEgg6BixarFFOVXYfG+WqBeOIjMh7Bi8EfBLbJWr1cXWwjuTzOF
	G6aOiqEGlMgddZadxG1c6Ulnce/vItJcCcRTC1LvVhYjOfz1qrkZvMnqhHElK9CL0e8QQqAsECI
	ONdM7hCPgVdkj+r3lkTihr6HtNgih3rNokkYmoWk6uQOEb6oyZHleeUG0LQ5YApaY1spyLWO04B
	WZYpiRPQ8IGABXqsjZinbF+OP2P+2AOFF8SEtGbal/ybV4nc4w2vigL6uKImQcW6nvaOy2uceKG
	w+RF+lhtxvPidosDVccuIcAMSaZKALJi6biIldmJksckXcUrFQhJFH3wekVRlGJdJq0PRa/QwyW
	2qG4FRklAyQG22ffNT9zaXxIrMwzuf71IbaKUajFoQuY1L6ZOIISiF3JtoVK/yoP8YFB1AJXLxk
	vk6Np1MOS0keJuKp4qIh7obV2QyMKLi3cWEMeSTAl
X-Received: by 2002:a05:7300:26a2:b0:386:b0ea:3263 with SMTP id 5a478bee46e88-386b0ea340cmr10834543eec.40.1795655552534;
        Wed, 25 Nov 2026 17:12:32 -0800 (PST)
Received: from localhost.localdomain ([76.33.234.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm55717751eec.15.2026.11.25.17.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 17:12:32 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/3] libbpf: Fix sign extension of unaligned enums in btf_dump_get_enum_value()
Date: Thu, 26 Nov 2026 01:12:20 +0000
Message-ID: <20261126011222.92180-2-dennylin0707@gmail.com>
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
index 08a4bbbf4ffd..85a30b373788 100644
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

