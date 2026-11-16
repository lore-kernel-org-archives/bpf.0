Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816134;
	b=LLM6sEP4Nyuh5RNm0wcF/kJTnxe8vMIl7LNTg+fYumxIXM7PdVAHmK9oGx5ZOJHsH2qN
	 iNOGaR52z6//TTblvR1gfCnMK2UkDprMnWRLafdVKDeRbn2DR1S38j6ksnOAy9L/tMaDI
	 NgzioJDyC3moQZRFLoZBkgf5ZAqzWy2BIcZmCV+yRtW8Ai1fzvYa1LSTYzdmArnXOyeFg
	 TNbrKgndTp+NSrrfjosEJKQrBnGmvv1FJcI3A7jHRcyHxaR1mhSUZLwY/6oYT61Nsfeku
	 tjsiZQf2+t68qGHHvv1aSnEH0W6vi0AzEtPu6SubsgN8syAejAzg9V732aTqi8geulQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xjTLfRW1vmU3uyxwz3ZMVejkouImicH1fiPgUPprDmg=;
	b=fanO8cu784Nuy0feDHwbOgepzTe4ieVJCRVU4NFdqLzAJ5aoMCDt+gAuNWZgTLFgEPYx
	 YpRTzKBclJGUtTT3Cpzn1PoTyNYQj9tIW63jMQW5uRU3yzOveL7EhM05cYSAM8lguLb6K
	 fVMnxQ+8IWVpbzYoE8JO2lchU2fXzvI7HARey+S9QkFepsJENvGspsJXqh0OZxXNL5b+w
	 X60uTKNOTQkRK+udyb59SKedFgYxt4r4MLFFYu+mjvpeg1Ou+aJmN+kTbFrnP/CyF+Jsh
	 7K1Wy6Br7nLs+WaM0LDvWngn9m2I27YQNsXUGX9eSxkT2Qi0WqFShMcX4iunLKvR6Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVXbaDc8;
	arc=none smtp.remote-ip=74.125.82.194
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F68606A329
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F68606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DVXbaDc8
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-36a315ed211so2998845eec.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 00:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794816133; x=1795420933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xjTLfRW1vmU3uyxwz3ZMVejkouImicH1fiPgUPprDmg=;
        b=DVXbaDc8XBP/JgibrQeahOuWJ8zcSrAJjHgtZ1awZIzX79BBEb56eWf6mfho34oEMl
         qfQcTFJn6Pr7LC7Ge8I23zvvcHG7ZYHrl5cVlxv/mAbmXw+ikXIB4SE+p/u9llI+TOPr
         b+/T9CRlHS3xYKHH/1nHYz5Exak+fijotsQWMOnKlbIGf9X2ZcAO8GWG52qf/nz5CRyQ
         Dn2hkK1T1bmuU8BT30nXSQXDzrLs/IpnHOvjQwjKunin8sosiWeeqe7GH8bLV91Aj/Y9
         ncCioZaIFUGRouKcgbkGwe4E58X2iQ325qb9MYyJ0EguxTC5bRorwZYrJkvqUbNgQsTu
         VZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816133; x=1795420933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xjTLfRW1vmU3uyxwz3ZMVejkouImicH1fiPgUPprDmg=;
        b=m8I8wTySpAzjGrceYlHazce0EE4Y/BFbZgr3az5yzFLT1LsWwWB46AQL6L+R1K8+TA
         8S0IzkYdGKR1narI8N/O6Oo+uElWpKJq0zBG/RQ0kjISdcCo9G/DLJoqB6eLz1jccEVV
         eZCH4B+8bQhSzkWL28KX3VuT8GEgCrLMkR6j6qBMXZSJqyX7qM2/L4x/PFfx/fbmrVZt
         MGU6NJ1385q8DyU8yhDKhIV5itMzcY4YHoyekdOKbmQUj2uvEMcE7NZQ/W4LTlpeRp15
         kzC4znYzoahkAgqAyj4AhxGb6rYszAygEnKeiLizdqMNPNUbC/7UHAEShARD9mjlKvmf
         9EIA==
X-Forwarded-Encrypted: i=1; AL+hErFhExtrc/xvM5aUikCkoId4EU4qWwOsrizME++w/IKJulD7GqtxnJavYt66SQaAJb9PUQk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+C7XDAIHu0yBhaD2seD8zKf9kaZOCHBv0b5+5JLdDaq0IkPrtd
	ZEr3Pmfg/IJYMbXYDQrJph1K8lWxW/PJkdtBYZSVhkXu3unc9+vMKDom
X-Gm-Gg: AYBFou3pxstiT5qNzcCCF9vJQFFYLektRDcp82j3d0JhC75yN0VK6PFqc2z/dbL+/8T
	eIGPde0aD7/Uns6JPuScPjx8fYDOy17hqKgvbVw7xJ5IO9O10Vc57ytCM17qexbA7BP1VN6UXxY
	euNc9A8/L+QjOkRIdSGOR0BASbejq282lWMsd6ZeBw/FK+6et11CWUQ0El6uIO5yvLIFU3YFV25
	/eFRQnQ5hWeytIaUg2VgsBmQiiBq8N6aUGXfloaRV8yrN8UUAwj6haA/XKEQkKOhF/RoVKsMy0o
	8qxvTl78aIWvg932lpNrq2vCsFP5+EoBoevqZ+u9GYMhYNya3whRF+ihHZKYNFKfsdCdASbhN39
	Dg3zR4mze3E3HpOaWyX7EbA4rA+uemfOUngRUIqBUg9HM8uCTLz1lwXp+VsfCJwA8J7chumkSzE
	Cw92V6PR9zGG+utgrJwoqXv0su1qfogX3MSA6DUaT84R5JgzPrUWkTFeiEGxOAoGJTEkcLBrxS1
	Perub5Yy6x5cALemodPmqG/tH3olMYiscNmaGzPVGenanY76LQ4Ky4MhE689VpB53WbNYuAvW/Y
	kL+UUJpOQXNWTdrVXT20OEhkoRC/jtJta7T8zAI+KGaawE1u1gE45JqeRcBojVmX2k3kF7WOpOI
	GuCUxfNI4hfoiiPynUz0OdAS35+TSiFhCpPjlvQ==
X-Received: by 2002:a05:7301:182e:b0:367:a092:3c73 with SMTP id 5a478bee46e88-377e1016111mr11133410eec.12.1794816132853;
        Mon, 16 Nov 2026 00:02:12 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm31128558eec.17.2026.11.16.00.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:02:12 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/2] Fix unaligned enum values in btf_dump
Date: Mon, 16 Nov 2026 08:01:49 +0000
Message-ID: <20261116080151.44860-1-dennylin0707@gmail.com>
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

btf_dump_get_enum_value() reads unaligned enum values through
btf_dump_get_bitfield_value() with a zero bit size, which shifts a
__u64 by 64. Patch 1 copies unaligned enum data into an aligned buffer
instead, as btf_dump_int_data() does. Patch 2 adds the tests Alexei
posted in the v1 review.

Changes in v3:
- Do the alignment check before the size check (David).

Changes in v2:
- Describe the undefined shift in the commit log.
- Drop the data_end check, which broke the dump of struct fs_context
  without emit_zeroes.
- Add the selftests from the v1 review.

v2: https://lore.kernel.org/bpf/20261115084923.53182-1-dennylin0707@gmail.com/
v1: https://lore.kernel.org/bpf/20261113223449.97604-1-dennylin0707@gmail.com/

Hungyu Lin (2):
  libbpf: Fix sign extension of unaligned enums in
    btf_dump_get_enum_value()
  selftests/bpf: Dump unaligned enums and a zeroed fs_context

 tools/lib/bpf/btf_dump.c                          | 13 ++++---------
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)


base-commit: 8835113107b2cf75df33a71e265cdeec5d5d13e0
-- 
2.43.0

