Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664312;
	b=qZPXnrxi3xIdf0ZoP3VQ9A10Zh3wU107/DJ+OBjjWelyJHzduLE126vuDnE882zUVstb
	 VuOMTzYlDBspmELK2lPBCiwzp1gsJJyGUkhnewaL/xWxS9nG4EOZzzxpXg6SDAeAlm6mH
	 vNsnrr06fRgS/2JAI32sw1lPXU8ZrY4BY3FkBoDmS8hgMao9eR3RnnmCfQS3EcdHTxlYt
	 /6fpHww+QZQ1em7I25UErPxdcGAR4DanMJFcU9bku8ynFGFly0EFHiAoRUINGG0IYSzyL
	 5Mrhj8pSsFHc3BOHSKoMI/rRmXJ72BIZFu9NzTuM3w1xYFkXMtjTQiXnkhCBh9wI3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vz0bZtnMYlistXeve8bJV/h9wNRvP0lQWHmoiz3+37M=;
	b=i08w3MPhddFro8b8Yv3y95Ms3e/npdx+oiBy+XGW5Dt1r9jCE0fZj/IdMZXv0iAIgf10
	 7O/30lfyV5jAF0VGatb6hPJWu8UPhdcR56eQahR8ass5ycE+cYOrlBGe5sc+NvEola9cL
	 FXwss1667/6kzrVqZUuIpzBn+V/8Xfr9gM/iLGKNe+HnODNyWsHohUhvWLaALB8stSDRn
	 X09xcs9YDc1ntqOR9S6rTVJt3JHXiMNR7mnWsJVHL47iSKIwICede05CgJKWnNCWexGFg
	 5S/xT8s11PVMfrdal132HqEG/VcIGifCkQCNFDoj/yleg7tV2vwu3vzaN8N9DIuB0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwEKgs12;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99F606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A99F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwEKgs12
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b41e5a1719so2768058a91.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664312; x=1796269112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vz0bZtnMYlistXeve8bJV/h9wNRvP0lQWHmoiz3+37M=;
        b=iwEKgs12bE7VNvIpHVMMGV3yWaZQ5qAfx/5QEgXOTw9ZS5vnSGHkN8N+LcSylYCO9y
         soSuZpFhjoygGwi6y98eXE4+3R8GIJcX5KGVvMlZuhQ+m6/qkQxEKPXmXdWjHGmmXmm/
         KdtLQnxRbM7bJsvozSbJ3euS48b9S/uzejo0WSdtn8WhiPtGDv5cCnF0Jo7XgXAs7Jlp
         qTZ5RcnCWrIhnDSzC2tlwbQ9ZF0xgoS+2ueEF+9+xCNel6HqmA650HAnFQWikuhTJOxF
         KBE/eB66VTPX0GyrV4e89aztc/EK1sNwjZ0uU2w3d84Tpx74WSvcNvPAJAUl98k3tfcw
         15CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664312; x=1796269112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vz0bZtnMYlistXeve8bJV/h9wNRvP0lQWHmoiz3+37M=;
        b=IBe8tehVS3OC1Kf79XZHDbnSghmpjX9/GgaVLlUBNwY70XF8HaQYNogrDFaTeQjb78
         rLXcyueA/WfalBxoNwlnepm7oR3fMdGbnbfefarAgQ4+GT+XXs9Vt+OXFagLox2gjBgL
         aIAlePewdgPQJbOyhTcBItfjCHtX3ZDdpH9CcKVVDGu3qiYKSqukUfo8iWqieQA219XI
         xv5cig5WxbND4OAgJgw22GWRSfSqi0Y9HvR387oWadeFi+JkezCl6RRBz3c3yY6qbQQ2
         PHnfb1Y3hXvmv6vRkFyQlbHUC2De9G2iqcm2NKhpzfV9AJRdGAMc4kbJqryON/GrzenZ
         eJPQ==
X-Gm-Message-State: APuU4Z/WQykCSiHGr1WRaB6WENflIhCk+jDnVD95WDX4frPHBelQlqtu
	nLIg8bGFRFF5Vb8UCDp4WH5wzh2PiEPDXHEWz3CdWfn3UW/mFMqnw3D2XkqGZg==
X-Gm-Gg: AZFdTZcoHOeKwPI/gGMlAocUqu6PwMLM0y+ivYSWLOkoJZBpUGc54CXXUC+Bpq/Zgca
	4XCVM3ho4DzP399VPlBnsTHV8nTh0sBvZzcTw7un4QZGk1iYSWWXggHTfNvFxr0SMZf+a5Jr7qq
	vpI0kmsEhu73LiMZ9VL2DIdxUTTBCj6JtPMekirzeyRYvsxhYtKDqPe5KKGr/XFbhwP5YC/meW3
	k6RNu2TEL/iV5bnbamKFFB07luWvLoQpQRqwdktMDre/7ldS1wwAU9/WrPQKsrK7sGKSunQ7DvL
	mq0pRUu/lvGrYAGKY+oX7r+vAU45OVx5s0aLmenxoaOrv2gOk+fPqezCV24asUn/wUBbc9/RDZf
	lETt+jApH9zmQ8iN65tysTg7Q6n5NVYWWLfQw8re7s//AYC+Sqb4Kqbci9ERnHRvi95fiAiOnQj
	eJVWyMS+sHVP7UyXUVcHIIt63DtFB4jtu8UpRNraaAcZwJOZDvZ29PHJZtCzRb4wLtLwBpTJfDf
	+P4SC0HVv4AzhQdwJF2IxbPGj8BwvqQf3/pFcbgJ8g6DYnhCPizMJd4JZoYTn/UBRFpjajRWdI6
	0q5a/QEHjTFcded4NWZfBPYwVWI5JDcpGp5cQEW6k21nr1f9Bmm/xsQrw2jXO05piayP+ykvHdi
	oxlBGYwMR0xB87tEZR9dckzebuWBZXSkD823SzOn9quyW7fWnqoN95EGh8/PyPnDK50em7LKBKw
	==
X-Received: by 2002:a17:90b:164a:b0:3b5:a3:442f with SMTP id 98e67ed59e1d1-3b500a34654mr3027551a91.41.1795664311648;
        Wed, 25 Nov 2026 19:38:31 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ec698dsm32917674a91.14.2026.11.25.19.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:38:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	luis.gerhorst@fau.de
Subject: [PATCH bpf v2 2/4] bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
Date: Thu, 26 Nov 2026 03:38:14 +0000
Message-ID: <20261126033816.4124847-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
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

The blamed commit made __is_pointer_value() use is_pointer_regtype(),
which is false for NOT_INIT. mark_reg_invalid() can set a spilled
register to NOT_INIT, and check_stack_read_fixed_off() must not handle
such a spill like a spilled scalar.

Go back to the check for SCALAR_VALUE.

Fixes: 1f737e46ca6a ("bpf: Remove artificial limitations on pointer types eligible for spilling")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c553e1533ace..5929478787d3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3825,7 +3825,7 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	if (allow_ptr_leaks)
 		return false;
 
-	return is_pointer_regtype(reg->type);
+	return reg->type != SCALAR_VALUE;
 }
 
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
-- 
2.55.0

