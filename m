Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC553C872A
	for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783788535; cv=none; b=B/yb9f5fpBniPNapIQSnaQLAEX6HRpr+oiITKvHwyuOidMNKSqegh+aV53mKSyQlf4NqrMTRmL5OrdWP2n+SrkjqdcsIVl8ENk8mmw3h12K0w8sCJy30z25erPQtTiBzEiBb5q3zJG2F8QFUoFmccmw6kkkMvTrJbWQcbX/XZB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783788535; c=relaxed/simple;
	bh=24uKcEbRiLXkOSDaAHcVMUxocIKrofai7kNsXWCt6BI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAQtj0vhv3KPE2/QEk6W8VioBFQy7YCK3aFHk8UgKpSSdK5ETCAgvDXDxRZsD1RXHcKmz/J6TOkeLhnVXw7gWK5Gllkc55fJIYVNQUPgdnc3g3ZJAm2P5oN2LnuCA5n+oKg4KnGheGtS5+FiiT3TL0gJBl3S0DapcvA/R0n+3LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com; spf=pass smtp.mailfrom=digiscrypt.com; dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b=H6WJV10j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digiscrypt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digiscrypt.com header.i=@digiscrypt.com header.b="H6WJV10j"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cae1a3a744so12706305ad.3
        for <bpf@vger.kernel.org>; Sat, 11 Jul 2026 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digiscrypt.com; s=google; t=1783788533; x=1784393333; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mbXDJqJwiKQA6mUPx6M1aSZ8Ggxk4RJkkJw3J9T18UE=;
        b=H6WJV10jRWCz9gW22KGBSNcIpZwnTHsaleVJHg2JYKHKfCFYxKxi0naTWRzvP2RoK3
         hSqOSNRytelwnDMNNv9TlZHqSmhCLEUsn4tV5gI6WvvPgyayXHM7jO35UjBdrW8zErqt
         RkTn+5zCEnzfQY5H+DFnOAumPoz+8Vzf3PM3ULBo0LuzjwZYI2UZMQDm+m7vF9lE/hxB
         QC9wJq8xi066XJc2zOEBPFFYsCKFWGAJfDNAK/cwxGGE6fC5Z2/8jmKebdzhKS+9LiAm
         rWFY+FSo0sGj4DpdzH4xKNb6T2e2oEnGd7l4GYvokXn/tl1EQ+vTCnfliCaVGzR9Q5dj
         LNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783788533; x=1784393333;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mbXDJqJwiKQA6mUPx6M1aSZ8Ggxk4RJkkJw3J9T18UE=;
        b=L5o1d+0IKq/9hSIOc0mr4wPRs6eRB+3TWZC9PZf70KkBnGbCt4d45lVMJKBy6hcq5+
         3e7WPqWLkKZDKWzv4azfEhR2LeEUyu7yLpBH5wMFoGOgdnY5BDaQunafYvdZkIKIVJb8
         pOult6Ut+4ZZISOOH3YPs1/76z8YPqyVW9Jc2rGAbY1L9mArUGV6ONbloBpQQztU67cI
         0A/IW3m6zg62dZuiajW2KendEebyNarqLCcaQ/ddAYE/CNaiFUF75+DrUzAkU3dRJf6l
         T6SVYCnoFHIdikvRHazkwjIx9RmOZzSv4z3koIYGU4Fu1RnIMp+KcETTF/livLjcV1Iv
         Ku9Q==
X-Gm-Message-State: AOJu0Yxp0j7Yl/OWc9u164Dbr9ejc9GbASBErnX+g5iIlMcdtfBlCbNO
	lKN+89XvJtNtx8pcUxyMFXxdxXejaa3ygLQYdo3XYT00Kw+2rRglZLS2fLje0Q88os6bKS5Do5h
	V6is0jAIHh+k=
X-Gm-Gg: AfdE7clWVijc/K6I8K7mP38fyASG5ncZGIqlxIxq+HZczbOuiyDTG4K3MdSaxvP+44J
	Z+5KF9VQCrLvIAGTCze2V4VyDYJNFFYLY43vAhut7XJqal39d0QmyLMfsqbXWAoUl+5Pdom2yYF
	ojzBn+vqQdxBv8+dvTHW8EXfi7cLzhYz6V7nd9GymTSX5rYkufPTcmwk5QZ6WLjlyc33GGw9B6O
	3K9Q32GKCYmxcKgysVCUGbe0uF3mnreMqotdF7tXlasbmlL3Wq+r62YJYYihV5Dap98iFW3qVCr
	xNRn6GHBq1TyV4p1CDNOiEnBK/O1BMSLK5fKJPZn0so0X9cR5t1OyVyWc5NN45cPaJqysFHhmwb
	OocYnQPQQD/loPIY9BTAu4PyHA+thL9HT6JqBKk3Y92vKshyU858jiW3nYae/RiiIOQlXxSHnbO
	Kp2sHf8iOk78/f2ESwgZTSX7qJwY/4VXW0uySVOh7HP7EfB5VNrtggFihNcT3vLRVpzpt4RPsP2
	34Xq9B7RJyoXAft2WbFESWuHliR75ZRbXzUyVMJ9zEF
X-Received: by 2002:a05:6a20:4322:b0:398:9379:d04d with SMTP id adf61e73a8af0-3c110a6e39fmr3531148637.24.1783788533413;
        Sat, 11 Jul 2026 09:48:53 -0700 (PDT)
Received: from 18.1.168.192.in-addr.arpa ([2401:4900:1c06:5ddd:dcdc:3320:dec4:7a0f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm14331035c88.1.2026.07.11.09.48.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:48:53 -0700 (PDT)
From: Naveed Khan <naveed@digiscrypt.com>
To: bpf@vger.kernel.org
Subject:
 [PATCH v2] libbpf: initialize btf_ext out-parameter early in btf_parse_elf()
Date: Sat, 11 Jul 2026 22:18:50 +0530
Message-ID: <178378853022.49961.12254894397759137901@digiscrypt.com>
In-Reply-To:
 <CAEf4BzbBqysGiHFuEW0b+tg6uA-gv4s8gGCeF_QZ-L3nhDc8yA@mail.gmail.com>
References:
 <CAEf4BzbBqysGiHFuEW0b+tg6uA-gv4s8gGCeF_QZ-L3nhDc8yA@mail.gmail.com>
X-CodeOps-Marker: 01cc49d9f092497abd2e8c2590984de7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

btf_parse_elf() only stores to *btf_ext once it reaches the .BTF.ext
parsing step.  If the function fails before that point (open() aside,
e.g. elf_begin() failure, missing .BTF section, or a malformed .BTF /
.BTF.base section), the cleanup path still runs

	if (btf_ext)
		btf_ext__free(*btf_ext);

and reads a value that was never written.  A caller that passes an
uninitialized pointer, e.g.

	struct btf_ext *ext;
	btf = btf__parse_elf(path, &ext);

ends up with btf_ext__free() operating on stack garbage, which can
crash or corrupt the heap.  Current in-tree callers happen to
NULL-initialize their pointer, but the API contract should not rely
on that.

Initialize *btf_ext to NULL on entry so every exit path leaves the
out-parameter in a defined state.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
>From 4dc7d1c8a2a2ec4c00ec038a94a86e26ab6cf75a Mon Sep 17 00:00:00 2001
From: Naveed Khan <naveed@digiscrypt.com>
Date: Sat, 11 Jul 2026 16:19:36 +0530
Subject: [PATCH] libbpf: initialize btf_ext out-parameter early in
 btf_parse_elf()

btf_parse_elf() only stores to *btf_ext once it reaches the .BTF.ext
parsing step.  If the function fails before that point (open() aside,
e.g. elf_begin() failure, missing .BTF section, or a malformed .BTF /
.BTF.base section), the cleanup path still runs

	if (btf_ext)
		btf_ext__free(*btf_ext);

and reads a value that was never written.  A caller that passes an
uninitialized pointer, e.g.

	struct btf_ext *ext;
	btf = btf__parse_elf(path, &ext);

ends up with btf_ext__free() operating on stack garbage, which can
crash or corrupt the heap.  Current in-tree callers happen to
NULL-initialize their pointer, but the API contract should not rely
on that.

Initialize *btf_ext to NULL on entry so every exit path leaves the
out-parameter in a defined state.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
---
 tools/lib/bpf/btf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 823bce8951..cabe8286f0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1453,6 +1453,9 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 	int err = 0, fd = -1;
 	Elf *elf = NULL;
 
+	if (btf_ext)
+		*btf_ext = NULL;
+
 	if (elf_version(EV_CURRENT) == EV_NONE) {
 		pr_warn("failed to init libelf for %s\n", path);
 		return ERR_PTR(-LIBBPF_ERRNO__LIBELF);
-- 
2.52.0
