Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785235B645
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450940; cv=none; b=ICHQIg90A8YwhoSct6kWzsPg7uqsUCnNzInd5RP7VgncVydhC1YS5idI4gbcXMYCCre39Cg2Tgx5bVYuyKYIe8ft7xLgaZoIXUu+bQCSO+t8L+AzxMdSB6mRT6pWpexpbbCDzOViqcvRJ+Zw0HUS7su/c3x0zfDPnDMxUBqF6z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450940; c=relaxed/simple;
	bh=IRwp4ODHFREcTq2vS7ls2bzevHTpG+IUZArHJDeEdiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INiiUDN1VLF+BDJdf/Zkq0FtKMKFEFXF5oCsqHrAwB7OcwYpZVe07N+KUWN4hqQdt0s0+8DWXOmcRhmQ05W8knSMwruAOt8qmSoZdZfXKLfzUlI3V5H3VQ5UdWPffLdKYnkA2NdlTIPEtnDKQZwwrTFfG4KK7uDthLcRqFHbn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhVKjKzI; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhVKjKzI"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-4744516a312so154041f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783450937; x=1784055737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytyIpnKKpxa4qRJFmy+Ya4of1g7Ul0Mr3RS/+I2C/ds=;
        b=fhVKjKzIB5c1S8cNrRHTXBfAg9igA5fFDUgk5KBrhR6QPThh/78BR++5JFoiT9zJqW
         2vHdJnbGhtYW/XqZBKkSsuE9EgkxulHofDd56Is3s/jRXLu3F79m5uONYw4AFrL6qpxe
         uJAThb01TInBpYSbnUZmeLrdMAJsxvtKN1Usj6roo52s5V86OzK1i+wubF2WGZTMkxhT
         Ni7pFh5MykDU0Kg1rAkyIxc5e+C19n+VFhUb1fG0ksLDaFrR8mYYiqGV9+/pVM1BEiIv
         Zx92mXUXkWcc1ae34xVJ2GxqWS4mxq01c24yJmbVqi0rg7zKxbvS/t7WlJpq7aKfHjzH
         pCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783450937; x=1784055737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ytyIpnKKpxa4qRJFmy+Ya4of1g7Ul0Mr3RS/+I2C/ds=;
        b=lZuAlkTBoxuDsd7D4WRHk7xngH5RCYh7AbUbFhQLYM6FgY/Og+yY3CfWTBEGo2A7Fu
         GdUjKeYTSdjlGm77xUki6M+aQTk/lF1PDlCAb8+JAhXNP7pTqDiQzwHaRbvX8sGQdO3z
         ZcvpUckr6+9oBRyWTocy9Grg50dn3l+zKxFTUegOUrITBMKWQHxlDfVivBvWNbF1Y48Q
         FGDffVTb2eqtGccTzZL5YTTUO62GSdF1hJTHhD17Ng65+69mGIT8jJfajHqSkktN9dXb
         QOq+8iMOQiV1a6ytjBTnpISU16HmljqUhmvc+yFjsALDnuD5q9MVkpSgTdrIPP6eXW4g
         f1aw==
X-Gm-Message-State: AOJu0YzTfiFAddwKCgLZU56s/Y0mlP1z3A4FLNp9SC8PReOEZZGgO2N5
	W0SUL3nuYSs6w3zenhXQdsE2hJihmd0RXejPIw6qoyw8KJR5iJLk5TEZaOoEue7j
X-Gm-Gg: AfdE7ckUtx6yYQgftCFFh+Bvd55AfXNZC/+k95gsx+W8of61UGeQi0L8SF0yDiZR6Vl
	M/0hJcDOmPQ8tuYwHGZ7qU7zqOayPQniB4OCmzp6NCxKolDOaIe6b9yqQ49A8zF6Zjqq5kWCi1O
	B+MxUhBEq05dpmwtFhzHtGXnNSfy9bzhBuCr/hVMZcWKQMb+W4GouOCSzRB02MeIaI5e1hlP4ky
	xVCop3nNoILaFe7jq9bWzHEbtxlCqiiBU79A+3/xVE2tVvfPDJxVKzZU/Mr5GoAAxMkoRQy4l+S
	N0KScOX0nDDKjZD2XVGcekdA9D/dnwE5FCwnUFjwafDO9eq7YDUitq+Uvog2X8lV4XqSCGF9e8o
	aNv9ADAAzb5dV9bM+I4TOJlZdlJEsYMaStxovc7lJ6Nv9zGdyjcOtCyIqgbMNtA/SRcyZ4sQjRf
	ncwaYPefH/rsx/bNUL5egU5U6yoGxIXKZ3lWuA8ftbLqqsasQFw0UPncZEmF3v8uZb+gRHCpGoa
	RM4qHTfNdqydtazXq+TWv3rvcAd/3kfgLx4XvI9cJVCm425myWRnwU=
X-Received: by 2002:a05:600c:2d08:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-493e101f655mr26293765e9.16.1783450937183;
        Tue, 07 Jul 2026 12:02:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0ebf593sm80164575e9.0.2026.07.07.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:02:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Dudar <main.kalliope@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Reject writes through untrusted BTF pointers
Date: Tue,  7 Jul 2026 21:02:12 +0200
Message-ID: <20260707190214.1997705-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707190214.1997705-1-memxor@gmail.com>
References: <20260707190214.1997705-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739; i=memxor@gmail.com; h=from:subject; bh=Qm4jdWLUkCK3faugpCdP7QSW2I7AU7arqUbSvJ+2oAc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIcvXJ/9Z9dxd/R4Wdc3x+uwbeRgT5q+aKfdXg+n2+4inW 9eoOOR3lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCInJRj+50iGrvsT9zCf4znL gWuMDnLbVH51fPnzSH7OgvdJpqez7RgZLr2IXLmVt6hs4ib2a2U9n9pNy88v1XG8e8nxCcdmXcH 7nAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Nicholas Dudar <main.kalliope@gmail.com>

check_ptr_to_btf_access() lets program-type btf_struct_access callbacks
validate writes before the default BTF access path rejects non-read
accesses. That bypasses the read-only policy for untrusted BTF pointers
created by helpers such as bpf_rdonly_cast().

Reject non-read accesses through PTR_UNTRUSTED BTF pointers at the
common entry point, before the callback branch to handle all cases.

Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3193b473762b..7cf555a7026c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5813,6 +5813,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	if (atype != BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED)) {
+		verbose(env, "only read is supported\n");
+		return -EACCES;
+	}
+
 	if (env->ops->btf_struct_access && !type_is_alloc(reg->type) && atype == BPF_WRITE) {
 		if (!btf_is_kernel(reg->btf)) {
 			verifier_bug(env, "reg->btf must be kernel btf");
@@ -5825,8 +5830,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 				reg_arg_name(env, argno), tname, off, size);
 	} else {
 		/* Writes are permitted with default btf_struct_access for
-		 * program allocated objects (which always have id > 0),
-		 * but not for untrusted PTR_TO_BTF_ID | MEM_ALLOC.
+		 * program allocated objects (which always have id > 0).
 		 */
 		if (atype != BPF_READ && !type_is_ptr_alloc_obj(reg->type)) {
 			verbose(env, "only read is supported\n");
-- 
2.53.0

