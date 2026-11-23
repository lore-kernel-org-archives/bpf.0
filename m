Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449184;
	b=0kRw3dcSOvCJDihuj/Kr0UrtBC5R5iv+anwiyzurTGosvP4HCYoFI1DN7q11wZIsLxa6
	 Hoe6/C8xnedjKE3P+WCRWcbTjpswF5i4JL2atYnszc7MIV/iEyCdy/0fd189eV1dLmclP
	 1CIftAZ7R33Q0cr8bvTkqNx27X9IgXEctFrpH2AaOz81OvijqGgy/3edfVGmONje6AXcg
	 3O3u4wwM7kLKwprhfZQtjMcPavJM1V67msD43QtGII5l5VOJHd8JA8Kjgtf+QGEBMbPih
	 9INH3/Z8gqDS2v2nTVZfjIECxjQacT9asCKoqp4pk6lJmJW+RTzRB1RCfUE65nuoq8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449184;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PSpHWfHbUQIG3jx3ObKDcv5uRfpQODJi2pWjJnhhS0w=;
	b=2idjKq8DS71Fu/NZjpQPfGwGtaD6D4lXuKYPNSpSZQs6xjz3O7OpIPw+3T6+FhqTyjrX
	 YwaKgzTmb3ISpTriNT/SO3uPbf6BucVIzKoMKULcMJQ2TFqFvuG/zIr4VNVZPO2EFagHR
	 WD94aIVaBNMzknGaPBnzZNdqfSrqyGcgnQ7iPTBxnWJ2MbHJwiwBli+Njtp0SBc9lUs7J
	 ATBSGGhjnhrUAySa0vaWPj6nac/EzGZnEj6zixK1TE17dNWO9Lgrg96wtw/CXa73BxezF
	 dvdUqexAqXJHEBDB1dDcr8aJDH8B3x18DBgw5xnKc9wV9AYtlzT4BX5v49v43zohW4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwRs8qNn;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A8606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2A8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwRs8qNn
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b155f50c24so2764675a91.3
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795449183; x=1796053983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PSpHWfHbUQIG3jx3ObKDcv5uRfpQODJi2pWjJnhhS0w=;
        b=UwRs8qNnEt2Qjt77vZmeJR/wZ9osqFbOpX4n+bGrK97PAqtti65W73nc0kS16pVGr8
         9e5MOy8l+wGgfDsWzbTppU1CPJGe9EiHYczxZv6L4uNp3jd53zE/hcupmFL5T3qC1Wqd
         LNWpCSSLWrVgPKfI3ARkkwlGRQNeBhLePleT/5mKHt+wcRETDAZKWhuBJrfZzRq7PzVF
         DXEgUwVrFC6pszjoM3LjakxZhbou3pVlNqmLrHrz7eZRmcrjcegqWyQkvJ2q3NB7DhvV
         KLJkpnhp7zghipS0A92L+GKyndphofIZTQdYUeh4M+PlrVXLsShLKLlU4AKHfowkmasE
         BgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795449183; x=1796053983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PSpHWfHbUQIG3jx3ObKDcv5uRfpQODJi2pWjJnhhS0w=;
        b=uFVtSii6Yu7ScThHg05J6iHcIDGiWkotdgGkuiF7Wqj8SDzdmDrha8H5bPyyhY99q6
         HNvWlo2MtdJkgg5XjjwOPCkE4gRZx6e6qFurWGubpJEXquSBPnC7hxB9n6v4ZkopWG8a
         hSMW8TpQEaxRBuiMxe2njrSQbFx3aXZ9qy45N+5g5vN42BNmLTPXUQdbXFLqVNiAQyFw
         K16JC5UBd7LOJKN2JMaxy8uzX0tqeWUDbtW5GDpX2XQQN+XXZXQIIByePv6SdUASOdgV
         UdYoXePC7YmrrrJ+J+PNvgpxvAoHfgkgiQ84QIceaRdZ/H+BvlV3YnavDvbgI7MCBaf2
         9hMQ==
X-Gm-Message-State: APuU4Z82Ba6mF0+yPxVNrc225/taM4MTIX/Nr4uxf9rMj0s/8K4henaj
	QzeyUrqD5exaXpubA50mluB73hHOu2prUiyuEUn9u4WMNLsw6pCxJHnXu3tgSA==
X-Gm-Gg: AZFdTZcHr5SuBv555bZEe1aLmPalevC7hhHtsLRKiRGUgz/LEZOl+VLTb6fZgRrUYZU
	Qm1mcdNQfIZ2SCteaW7RDyJGUlLwdZoyvyoocuaSMPE0ihRMzsgoPcXAiUDBCjR4O2aLrnDGKnY
	DFOiKxi9n/8SG9Mw3LpS80bDC4UaqxwIhxqYx7GV5ddqbRfG8TL4WGa7mqLyNh2YQPlreINpcGk
	ubCYhhx+Smxx48BdK6yzKVHvOaItt+Ows6gHK4aT2eTLgmVcMixv0xDUSszkjXS4VsyCwvWR/YW
	iZcH5O/eVF4VKbXq1KGgI0wHVJd0YRAJTBhxa3UJ08hDt5PGOwWSBvx3hSk4FzZR8qDxd5ljPll
	OV6W9gP+nd0YEcYUT4r0XN72LBlIFGqA9gEHZeESMLnYGuuhgSGhICJhXGtVb32uMVzr3AgGklm
	A67AChvIqsoBPNIWnJjV8oKBYGvammQGwYcjBBmGedOiRv/zJf9vbYgcocevHZP2HvrLkZDLDP7
	sJuWR5Kv3kb4pf+7mQbMNB/ISutweo28hHj4S/vC9TpiJXph2SwdqVwcwr3p05bIk1XTMZpVTe7
	w9jN34v0DJbd9lg8c7xHEcRGXRfZXaT8dvibY5YD2Ok=
X-Received: by 2002:a17:90b:4483:b0:3b0:9deb:d991 with SMTP id 98e67ed59e1d1-3b41c92cbb8mr11195881a91.35.1795449183417;
        Mon, 23 Nov 2026 07:53:03 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([113.11.180.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d96bd3sm21596601a91.12.2026.11.23.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:53:03 -0800 (PST)
From: Ahmad Wicaksono <supersonix03@gmail.com>
To: bpf@vger.kernel.org
Cc: jakub@cloudflare.com,
	mhal@rbox.co,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Ahmad Wicaksono <supersonix03@gmail.com>
Subject: [PATCH bpf-next v2 2/2] Documentation/bpf: Fix stale selftests file references
Date: Mon, 23 Nov 2026 22:52:00 +0700
Message-ID: <20261123155200.16676-3-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123155200.16676-1-supersonix03@gmail.com>
References: <20261123155200.16676-1-supersonix03@gmail.com>
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

Two selftests paths in the BPF docs no longer exist:

map_lpm_trie.rst points at tools/testing/selftests/bpf/test_lpm_map.c,
which was moved by commit 3e18f5f1e5a1 ("selftests/bpf: Move
test_lpm_map.c to map_tests") and now lives at
tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c.

btf.rst points at tools/testing/selftests/bpf/test_xdp_noinline.c, which
is now tools/testing/selftests/bpf/progs/test_xdp_noinline.c.

Update both so readers can find the code.

Signed-off-by: Ahmad Wicaksono <supersonix03@gmail.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
---
v2: No change.

 Documentation/bpf/btf.rst          | 2 +-
 Documentation/bpf/map_lpm_trie.rst | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index b61881239..94a81a9e9 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1148,7 +1148,7 @@ information.::
 The following is an example of how line_info can help debugging verification
 failure.::
 
-       /* The code at tools/testing/selftests/bpf/test_xdp_noinline.c
+       /* The code at tools/testing/selftests/bpf/progs/test_xdp_noinline.c
         * is modified as below.
         */
        data = (void *)(long)xdp->data;
diff --git a/Documentation/bpf/map_lpm_trie.rst b/Documentation/bpf/map_lpm_trie.rst
index f9cd57949..37ef39d0b 100644
--- a/Documentation/bpf/map_lpm_trie.rst
+++ b/Documentation/bpf/map_lpm_trie.rst
@@ -108,9 +108,9 @@ specific keys before less specific ones.
 Examples
 ========
 
-Please see ``tools/testing/selftests/bpf/test_lpm_map.c`` for examples
-of LPM trie usage from userspace. The code snippets below demonstrate
-API usage.
+Please see ``tools/testing/selftests/bpf/map_tests/lpm_trie_map_basic_ops.c``
+for examples of LPM trie usage from userspace. The code snippets below
+demonstrate API usage.
 
 Kernel BPF
 ----------
-- 
2.43.0

