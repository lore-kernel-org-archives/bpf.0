Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577389;
	b=vZoJjUcOBEWn1ZvHbgeXC9ye6Ru60qmE4ZzCXHaZP7up8zi7KbHXXcNYXxI15xz1mHuM
	 Jqy4L8r5OMB417V1FnkTmxSuRw2+O2jGa5CpOiii+S734eGryycyjOn5Byb8sCqb0wb7q
	 SNL7ccacgH1kaxWD9CiRiaTS1LlQ70JVun5bWEmHA6tWazLDqs3r/0EvFnnxWjXVJB7/9
	 GRkddwDhtAgt+6n3SxEQyO919Ml9oTqHPvK3kb1neiQfChuaM3VqKdxrO1EQAUyBx0NWu
	 zNMtmQI4t+GGLJ4drLvZ50MNkyqCifmVKAMmxRTh+jJKF4r21pziLjlp7Jr/LuVVWcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hCHcG6Gm6W+NNW/hNlrKgZcjNTz6p40lwTO00lEM+HI=;
	b=WcZVsGfgPwQjRVtFgqFuLCAqcEBshYLYMhMEIFXgo55Yq9q0XghcT0a9pmx4c4aoqXxf
	 djxmpiMruMsFIgcRkf1x3I6ZEmvSXueC0VIlleOP17ggvE3MgpkgzWHkBPT2foYV00eL5
	 MiJJXIsX4FMm1u5ew9d5hanG8S7/GqdD5MKy++0S8MJB6YXZyKbggSszFFlpg0OsEKnIy
	 S99K9q1aRpl16JD4XxMASIBwY2+WTt/TbdjWeYzF8Zh9cT/or1TSXtutakZ/axF+CE3vR
	 3oy3ZdtoSEzZopC0xeNCRBLEeZpFba+lo6ht8MJHw2C05x3m2qxnPhV/f3bvdq9hzqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RAhi6t1e;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CD606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24CD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RAhi6t1e
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cde4b4e936fso2730555a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577388; x=1796182188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hCHcG6Gm6W+NNW/hNlrKgZcjNTz6p40lwTO00lEM+HI=;
        b=RAhi6t1e+w/IdSWByV/KiP8Tckn8J44w0PmMZOsR697asPReAH/yfHyxhnnNygt/e2
         lLpEGlcStJU73H+Fa+qT2C2DILOT/KRJ8gGPugI49hYKnhoVWK0UyhoJadMWXWt9ZzRB
         XH5e5fm0WOhAbNGzT1vgLfBRY4DIcSEiKKYYjUB3sTv/amDOPTYjwnggKeukejCHzVdJ
         6+fsWdbb/iMCvhnyxKEIUkD7GgMFbeX1VtMq44GDMx1kv/CkOHMiFdc7ji4qkp060iG+
         znTAAHjz0lFkR9mCmJsppsns95qWuaAqZDYtUFtBKuJLUZ5gOdYQqrQinpmtRy/yk1IN
         rk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577388; x=1796182188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hCHcG6Gm6W+NNW/hNlrKgZcjNTz6p40lwTO00lEM+HI=;
        b=jlYuFwwny5FhBIaibJea22Fz2EXmJMVWSFLPV9OSYZbP2/nfZ7Rf3IYzTKRe8auj9a
         AgCAqVxdQpEasz+3hnkCSegf5pbRRz9+fluY+zkVB5ApR7AHbrEqiEyFENu7hE1x+eI7
         YFCpZTqEmSROCuY9wsi7PrzypXCvy8ifCLb8xalaMn1ZH7/j82koBc0rQYPs3sdExoOS
         B8OmYXSF6GMZVvu0ouuPz/FoO853WWaD/GM5PifRRhU5I7IHCnI1RQQhFheIgyZv/mXe
         mdNVT2bmzjAGhwYhgNBJTbJA4NVpSlT6J55Jl8CbAtVr2kK75dEEUSm8vTWwAS3AD16/
         Ja9A==
X-Gm-Message-State: APuU4Z/2dwrUlhfbpIpPP+oDpNvJU4Lc0oRhRVFny526ieZ9O0VJWlwu
	q4K0p/UZUmQNVNSxV3TdjMMPmC6avuGUetlHOP47AlqZ/f7iGCRZEwCXhqvirPU+
X-Gm-Gg: AZFdTZdOPaoodpvKJjAHgcni6XKLO08oyo4hDZjakEBsllR44vFmkzXJcAkU2jA66Ej
	uh1i8ii4Gybx1XiZH+nZ42I77UfrAi+b4zdtd9v7bTEQQV7EDUlqW9uqzar0MJw1JyxRStdY7vp
	EQY71koyQ/acZqgycTrY6OOjuXNunubig0V9O5GFV9osON+scUujktIw44YlhV9XbVLjAed1QW9
	lnNzAGbNrv+dHGoZnzLWyPtuKMC8AnhBqzrENAVz9xecKREnkKO3NZV4Pv71NCyGFQQ3KLkYvXs
	/CpHoaZglxIqLSOSFYw6ojhmEhBGl3y8pQ2SwQmDEUOBlClBFJBm5PQPEk2X8rNecckWuQUpYWI
	7HmDOpZdkUP9Fo8eNbNJCcefBcP9wTldh2kUq7177kmgjk1ttasfvxgh6rRTsLbT8fqENqSRLTD
	1oMvkRy3s8MOB43D8nFxq8NUxGcpqh2yrejxIbBOwATxVTsTkpvikv9SHSSCEFucc8FX5gTvqeS
	odOH2BnRfeue3bJt8iemCGftOFX7/EUCT4t3SxjW0qtKbqhpEXK7cUWMUGm/kOBVo6iIn+OiPv0
	cnLiq8dteJFtEUTLBMmX4KeK3ekmp6oL+EOVBHq473za1Tawi5iitxtQcsDOluY+2AF2nn3vQ5K
	HTp5HJchnOt1EoQajLvNQhkLS4gdj3YAe8f6Q/2ha3idiaf9QYg6is/FetDeyM0Y4iGyU/1evHA
	==
X-Received: by 2002:a17:90b:5407:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3b41c961ed9mr10114690a91.39.1795577387948;
        Tue, 24 Nov 2026 19:29:47 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm25879617a91.6.2026.11.24.19.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:29:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 01/47] bpf: Do not trust pointers in flexible arrays
Date: Wed, 25 Nov 2026 03:28:52 +0000
Message-ID: <20261125032938.670542-2-alexei.starovoitov@gmail.com>
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

The verifier does not know how many elements a flexible array of a
kernel object has.

Mark pointers that are loaded from one as untrusted. Ignore the __rcu
tag of such pointers.

Fixes: 9c5f8a1008a1 ("bpf: Support variable length array in tracing programs")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 49fcd32d418a..f5ecac4abff4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8127,6 +8127,10 @@ int btf_struct_access(struct bpf_verifier_log *log,
 			 */
 			*next_btf_id = id;
 			*flag = tmp_flag;
+			/* nothing tells where a flexible array ends */
+			t = btf_type_skip_modifiers(btf, reg->btf_id, NULL);
+			if (min_off + size > t->size)
+				*flag = (tmp_flag & ~MEM_RCU) | PTR_UNTRUSTED;
 			ret = PTR_TO_BTF_ID;
 			goto check_variable_offset;
 		case WALK_PTR_UNTRUSTED:
-- 
2.55.0

