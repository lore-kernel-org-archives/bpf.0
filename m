Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675728;
	b=3YFU+sZNW1FYxuMHV7UKkQSuRCDFBhZQvxlT0AsT8AfVb4pZ8UkGnz2wzCXEAHsIXW+Y
	 Yfca5ff4bSyalaKc3RhP/QKw+HFRf8QDG1pfPv4IK5WcXNLuEl4HYUFMzTWRzzPI/HzOi
	 2sRC95YYS49lUu+GVQN/XuXW9kMSxK+CpKGQc2McTHgN6C72nJGojjZ6Pj4F9XXcetnF+
	 f9se63bRG4w/QFeDPxSOB3xCRyP8P7zO/m/8P1aZFBf4wmI5e1L41tgbkM9TE/MP87/Ic
	 /LcBm5JF0IQ5cVvRoqXBS31MvwtZDAqjy+bEkyZXTCeIEFleqlWyYyr9cpNx2Px0Cww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7lteccHgNdb7iF/PneQaqv3cHOSbhu4Ba6wZTOqh8l4=;
	b=ZfsIrPwcW/QDXg51/3btm4ky8P2P+rjmutt0lHWeHdBmijpJ+2vwF+v5jLCgCXOvNfBm
	 dJ7k69AEM3QJpdzZtAl9IsFgEp54/gIc+d0onto3r6FNbI4FRMwLvIxrIXc9+c9BKd/ML
	 nsCLBSR+uh+55Iqs7N0rW1YXdTXnoZjie3bLttNgWYUZEvWprAan3guQ1yDIapvqEDc7T
	 2AIN19xRijJfBDwZsM7VnRuhgjpQjirsG2/djaJgAT442+Dna8NpGzVMWZVz1TFDQOlEx
	 hxZx/IgNd7oh7jR2s3mzF5+/pyQx/mMLtB122MYBaPq7Ybh1b8MEGB8Rvob8CgpUuHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a731FAUO;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71F606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 17:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F71F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a731FAUO
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3704d30b84fso2611799eec.1
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 09:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675728; x=1795280528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lteccHgNdb7iF/PneQaqv3cHOSbhu4Ba6wZTOqh8l4=;
        b=a731FAUOVbF8xcz+oaxXiOx9THsHRJJh5il0thnoiSbXATfuGLRXsJWTZS6HI85n/k
         xiVfPqt3X0LSaxglxL5LayYrWdJqjv7QGPDg3tzUDtqVAZ/+9hMtyKnvXg0hDcmc5l5x
         /UrgMs6MEE0aEFMH4/NJsrgk41JSYhHkDoO3OyJ7y/CKgWqrDRFYacGT8WgaQCa3t46I
         hgCmCX8YtVk5gJjWfsxTyxSoLNIribcZA4rM9iUgT4Q6tXd9hLQW6KOqdDxGP46O2fE5
         sjQnT8w5dOnEPbth7SgRvYfwF0iJUC7J2rRwxiUM7hUYtP0Gd678g9JZd0FAqNP5RZ4l
         xmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675728; x=1795280528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7lteccHgNdb7iF/PneQaqv3cHOSbhu4Ba6wZTOqh8l4=;
        b=g+YAZYvJbMrTt5rjqUlxCd0vXpxXL5+iNcKDbnUpCfm8D3HwUA3A6Rl8LRrV7aWyQq
         1Yv4QWPAb9UyBhO9ZIwX0H+jOQW9Xnw9zt/EI4VW/1oy7qrGNwZBDQF1oRRmEfDrJjpb
         jAegXZxowyqavQnTS0pCLVVYhIW39tExnxxhpbdzLJsVm9Z4ugVbtBdC32sE4ss4QX2b
         Pix3dQYcY7skIDWKvjS7WSsJA46u5+8kux81cIzl79F+tcBuzdWrRvSAQlrm+nhof9NX
         yfP+qGT/IwMefbwfj/P/VyW6CZlHHoGkHJPxmcwOU/WVjBKcVSpw5fuT/p4meypJbAX8
         rooA==
X-Gm-Message-State: APuU4Z+s7ZS00NRNc+CMETe6wgSewOvOb5lx52dyKaC7ZMaOFP5JJQfb
	JVjIpQnC1iFXHoeANnUZAM+MTuecgNNkyD3YIUADXd7VOytGDhYocyPAw1Qsmw==
X-Gm-Gg: AYBFou2ZMYGysBATWNFgFMJs3dKSCKLxZgo1mb/wWwN9OWKvdaieQZ06ps1Sz8TqLg0
	2Yx7Oz0AGiun9EimhEqB5XTN7WWA7WVFiErQAnBy+qKeogueXKaPEY3oBRkrI93qv4PvK083u06
	eLEROuIHMarITFV2d9eRsXqJ9YW+JmzvZVUMSuxcHjX37gwb+pvtoABHD4P1FwEUpzc9BZMmVhw
	iEb7s/gCLCi9CbRAwMQ98lSAIWUuyouFBBE+LvevUmUQg8Sr5HwKhKNkzQZWf4l4+/jp86GZchi
	9ZuCXBVtRvsf/gCWLitxKR06Bi9Ki9aPsie3mUTidcweU/FGsNEEKFEF/GXFwNIrQbwz5k9BEWW
	pdLSlBL8IdahkUI/Lc3nI8HgOuB1U4k5JsS0ICqLxACUL2BYnG30HRaXddYOUoZCPqYxDCkUMno
	1dVvxo7GVZXJBco0rXO+B/NFNgU0KIi6B5H9fDdiT2PH0Dh+ZhBd9wTUF753mq6UgatwSdE6jxK
	uZl1GUT150ryXpowUBcsa+ovsXxkH7gQZlFlZAKd+3jXrZ7AKeNNGf5q66iFdG5NLABhQKjhMps
	PwTBCD8tuHWAGoKoz56iVxBB7zRmxgkywHvklmZBh6s=
X-Received: by 2002:a05:7301:f87:b0:36e:c108:90e9 with SMTP id 5a478bee46e88-37968d8add2mr4900495eec.39.1794675727682;
        Sat, 14 Nov 2026 09:02:07 -0800 (PST)
Received: from LAPTOP-G6J9COQB.lan ([182.253.124.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm31586761eec.21.2026.11.14.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:02:07 -0800 (PST)
From: Ahmad Wicaksono <supersonix03@gmail.com>
To: bpf@vger.kernel.org
Cc: rhkrqnwk98@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Ahmad Wicaksono <supersonix03@gmail.com>
Subject: [PATCH bpf-next 2/2] Documentation/bpf: Fix stale selftests file references
Date: Sun, 15 Nov 2026 00:01:17 +0700
Message-ID: <20261114170117.196552-3-supersonix03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114170117.196552-1-supersonix03@gmail.com>
References: <20261114170117.196552-1-supersonix03@gmail.com>
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
---
 Documentation/bpf/btf.rst          | 2 +-
 Documentation/bpf/map_lpm_trie.rst | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index b618812390e..94a81a9e99b 100644
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
index f9cd579496c..37ef39d0b39 100644
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

