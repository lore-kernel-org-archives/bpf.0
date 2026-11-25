Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577658;
	b=JYG5wh8uUxwqiltQkyJBVRsg2gNbUg9+RuXlMNPUikaslDJWXv9l0rfC2Sym21EQl5fs
	 QN5j7cbR3z2CrpxBF//d9JoXmZfT6gysWkyYWHgUVU4kn5WDQJSp/P5rSm/oAdTFFBazp
	 2aUdYt4mPvO9C9HHlgS8x768FuTDZZ5H7zyIn0JQ63crsWabP/PWsfU/EyBMbK2FGQsyO
	 ByCc+54syeiMk4zU0ogwgIXZMngzA5l4bLgE07FOctpWv+kcadDv/lvIHhhIwW3Ggrqts
	 4i+Y0mom8xAsc6hgOIiPHj7ulpVqHE6MP7WLrqbpf3FT05LFePqNZq18gdioEgQJ2Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tl3ysfSawWkwlpJKiGVKXEwozKN06r4sJBLhVNMlULw=;
	b=ovPjETvXDAMs3qADDFHgb2GdDOBXLNBux1lIv0SgX+oV6xMG4cD+saM7Xw19UzK45MGp
	 jMozRLSNP77aQMQqwSqE3mGB5MKm7K3UpHwEkZbW8+Ee4DRy8W8dthBswHsbKE/I6+NuM
	 sC0OsK4qWDqOFNV9Ff4iSC2LzESuW2xATnQu3/8DyZFlpSfV6PcQtbB5AQA+q6jlrnp8C
	 XMddldwpFJEwnmoQTQK9ateEc0dP+K39WvlcRxG6QO+xa8RuBKG3VjqIgvu6mXsI/a9D1
	 HAKhUAYezPSB6JxO2tkW5wJkkKMII2PzbQ/OdsHokRInM+oTfFQVY29hMBBbzBXqOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvFUn8t5;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA3606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDA3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IvFUn8t5
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b413d04c93so3066887a91.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577657; x=1796182457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tl3ysfSawWkwlpJKiGVKXEwozKN06r4sJBLhVNMlULw=;
        b=IvFUn8t5m/DP65tkOK3fZYw26WwJcykexsZVqmOGtQTNZWTAaML5noMQppaNfUvfTr
         pcQNwcl9GCK6SR3MClh35TQUEi2+Y1HCYB727/hsuYLPfq+tNPnx/cRHB5ugnmU88Wdf
         4bPexv+VUZpuVeL+q0SjmuunYNGPqE0/tLXom4fwRxo5giEmcHdISKRuXGuKBzogJrvQ
         qkIsv5xkzKVR9xrkZ49j/5I9VFR/j6sIhupGn5ZggplbpcDWhy9IZrkLqFQLeemVi6bG
         rTZPtGwp9CQ6nldA/WlXOrDUVaCgTojQWX+532g2RReYtZ1RDJecDItSBFrSJ4zRK+HZ
         5/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577657; x=1796182457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tl3ysfSawWkwlpJKiGVKXEwozKN06r4sJBLhVNMlULw=;
        b=vpIOZ5JH4FYfWR65Z761mMKIJLYMn8j4N6/8eSJ53osiuEVRoVj0ypa75nQug2j9gH
         LbPfpDOrxAEeY8ChEVbOAVReHJ3jeNXmhgqh5hIzJDxeE1M9DHaurW0XwGz759OlamxH
         u5OezJkAr5YFoPiaRDLHj02xIYOyvruASz9iQHpYzxg28voBfEWYUDFCPXIChIfA5JKZ
         FXBQmfeSmD7O9v7m5Jlw574kMjjAV82M8FTh37lvvyl685pgWyv+zo/Ub0LT1KvPBgUH
         LASr3kmU/w5orPvV4ls5c3Hr81ZVewy+PqlhffeXYiBiz+wWoGdS2rBfnuDRihsHgaaZ
         mUgA==
X-Gm-Message-State: APuU4Z9t6cUsoMT67cq6ePybDBhB68E+dL660GaRlHrWCjAtpVCz+V05
	46QHY7eyUEg7Y4B4QsFdRG0neaExrAX7/kJeVPeR8ZVWvTiOUS/jAlkX4GKFuFNz
X-Gm-Gg: AZFdTZcVPBoHXE6D0fsxKbQ8q/PlKLpUN32hUInJVrFewN5evHJBly6YA5/tWYCDmyD
	kusxak50Leh7zHCSPQ23sHzhyI/WMfWtSnVtjgQ9tx1sWbLk1QsFUXXuOXK4DWi2v96YQ/L7wab
	rMlRebdN3hqKV46a4WsB8zW2hPdi2eD3DMrqFoJG2bw3gwzvs1JxT9q+6hL73jQnMsdN3BC7osE
	EFEA1+74rxO5ffum9aGGxvpRAz8oM1Mrb1jG+w5StEPShhptG1XJ8OB2mmJJbogoaT/9kueE3uu
	+ktaDgRnpk12syDNFDOjmTeNSCwUXUI/m8iEqYOq0rofGopcgtvgqGVf5VuvH8bOTf9dl99qAhj
	LAmQLcYCKTrCqcaihSTt/b9e45m0SdrcMP1WGWYBeJMucDB1xTu2XL0kQJ9/1IKtEVQYG551+La
	SeIP5z0gtXlCqv7le6V133iIMJ+EsAEjQfCkalY5HUMEla3r+lJbS2uQMv5COWv4lK9mP/Ckhjc
	kmh4neNOmQPRxu7/lxqwC81Ob/1VGSap+WBW1I+j73dx1aOURewMKrCIugxi9732aXWJN6gzkFr
	NsvNZVU9t532J2YLCnFG9qCsivyBYe+RlVOMqQ3LSvCU2a2XOgAEmos0u7qEiOR1P5rwqamJgbm
	mZ8vJ8qwKRCBwgDWgjFWNQrvry1nifYTyUxoeo9N8Wj2w4CGuPFG0iyd3lFZzVYV9qWOcElx/mg
	==
X-Received: by 2002:a17:90b:5543:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3b41caeca54mr15460506a91.36.1795577656740;
        Tue, 24 Nov 2026 19:34:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b792474sm11613390a91.3.2026.11.24.19.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:34:16 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 47/47] bpf: Check the type of R0 at the exit of a struct_ops program
Date: Wed, 25 Nov 2026 03:29:38 +0000
Message-ID: <20261125032938.670542-48-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

check_return_code() takes reg->btf for valid when it is not NULL. The
field is in a union, so for other types of registers it holds something
else, and the verifier follows that as a struct btf.

Look at it only when the register is PTR_TO_BTF_ID.

Fixes: 8d9f547f74c7 ("bpf: Allow struct_ops prog to return referenced kptr")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 554d99c1c943..d4b31990fcb9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19608,7 +19608,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 		 * matches the operator's return type and is in its unmodified
 		 * form. A scalar zero (i.e., a null pointer) is also allowed.
 		 */
-		reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+		reg_type = base_type(reg->type) == PTR_TO_BTF_ID ?
+			   btf_type_by_id(reg->btf, reg->btf_id) : NULL;
 		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
 						prog->aux->attach_func_proto->type,
 						NULL);
-- 
2.55.0

