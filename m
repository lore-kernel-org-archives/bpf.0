Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439967;
	b=iic6Y7laqUweo6q1y/ALhZqbBO0omEICtTVunrHAcsG+Kx8BiSxPCsSnqykUraKczD7C
	 VN+UZZ12eDn+kbncln76pu8fi3TFqVW8WFvnhW1IyEibjZ00gIyK2l3yzavQZRXzIYosq
	 rAnpY+aT0mxQelcvFGqer8TdNehOYEzdOyYa0ARhZvoQB/bF+nIFDar9WJk6fMpycz3Oo
	 I52+UDGzDyaiVnFHoyz3fGu/Dh1oig9i023hNyVwE9OPY5rDsHwQaLqcBIFX/GWsI3YY4
	 USHIpvHG0Ahbdf3m2SQcRh5f5vBXbh4H+3RGQ6FIGTw6RsSmT9InIW89eJliuIom70w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dTBafA1HBU6e1TqYuvQux9YV24HUZp1NWVg5MWo+jd8=;
	b=l7A7xqKWFBJBA7mhZ50aeskbNsHX3pYrI9c4AuVN/OKOusIaXbEeJYpsDnz+6JUwXT9p
	 lXTmM9JPJYZsbDXUTkrw4rdY6yGEH/1M3wsIHu1aeGTtZB27WHWc1jtJLynQiIfgdWwd/
	 YEy+gLWuSuyrysSorpfOkcN7vn0+F/pcI5mCGyS+ni33hMFDGaY+ji8YnDXn+pdyv96NF
	 F0JhctMLM9dG+9wll75RtCWz7ZZNXtXKWL1MwXE1tY9E+QFykcR4cNCIOm/VbfzDh1Mu4
	 3IsidgoR4Y8TwpYXUqyCfw1v9/z+8YQ+Xkj2BEQTxauB8WvO1TxQu3anbYR0YElieqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YfEkR3lZ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C9B606A31E
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 19:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C9B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YfEkR3lZ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2027366f8f.3
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 12:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792439965; x=1793044765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTBafA1HBU6e1TqYuvQux9YV24HUZp1NWVg5MWo+jd8=;
        b=YfEkR3lZ8U3Gllaj+ZiNbnRUyAKxNyhzqduUGbPQAH37lJcQId1iTnGRtbudgCuNnV
         FIC5HPiV5zE87N0ctGaKlqfaoe++UhyLF7TwDHZhn8rBzn2jtO0U/SzcCEd/JtvGQhKn
         Cd+3gsrA3O54n0pQSOjn3EAtMRJxlHedIfCbv5Lj7DZY+vU+1Xhy12JAJO8x2kgOfISf
         S0qb06JX5/xlBwdqz1Ut382V+gVFeySubvQtXAjn+/YYm1YvzD3tDRJrynx/2vawrCcf
         Cl57k5Lq5D3N1iZN8MAdJqKHKZs5ZlSNzOSYP+QBXvuKP3TTwQCq9+FwM2CBXBIbmPhp
         PSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792439965; x=1793044765;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dTBafA1HBU6e1TqYuvQux9YV24HUZp1NWVg5MWo+jd8=;
        b=zLrx/YcnuBbH5riTSprf+NWyy2/0hzLvev4IsnVhNYwjJX0EPX26ZlrzbuhNAt7YrM
         cJkU61Ounhbu6EPHKruVfVvlaZvZmvFbOuP06HKPjoAtiOIYk8q8/BxCMbYG9LWSOxTb
         3oGPK63hHDwOeHUh/5YCjdI3Vm7uNnhd0rqWbpKbjPvryOBMazNt87MswYJzVZG/HOeR
         lxWuB+me6Om8ucDRd1sr32v6YE9a4MtG6TF33qzJjLE+P+ZMSrCZZvTD6bTHoAtOPWv1
         AGULya2D9Q53vLFJJRb2CF/4qQ+aUolyYXt/IbVFcEEYzyhyq/M5rGj1dvlfEd2JVV9J
         earg==
X-Forwarded-Encrypted: i=1; AKwUvBwxKedMhPrqzips/hhlgvI+kF1uYUyHdQR+nSFBA/FruUnQUphD2ZHdHP5IR6uKetql/6w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUTtfLezOlRw/BmOXhgcRJ60V/vMXkDu7zSVBz12qWR28TLx5t
	xosF3OuoHTChH+bN0I6cOVu4DKZrTHFXIdTwA3dpffh1640tPH2+ZYSe
X-Gm-Gg: AYBFou1yLIDWWREd52PfWVT5bqn+sJl2wbDKEamJu9HTqHuztCQDet1+PkjfScvjTf4
	JTdBDzUk9lcr4TCYkrkbZ71ao9sb0rRZAUXeeeJKHlDdT6Rd3GNJ1Dw97QbchkEYzUnwRecYsm+
	KfTb4Rz1uC1+a0BnNW87BSN+/BpbL+eUbYX7JSpURUFA8//uDeQyxRqxTkqvkXqNAnBuiHGnMq2
	b0AD04ZlljsxJiFUY4Y0v33wLgyppA+QknTSdo5jlr8ZvOEegERpK/+tbnpYoEps2pRvJzySRz+
	heyST+/4OxaVBiFla/jl3F5w3Kwxtm575oiy9gTw9yqEIUeRwBozEyMMQS7OH0ImqHo1KZwnwU1
	BNtoxz2lsWJNo5S5CzlSAfXmX8sUFwHaHydaJvJ/8TbSxbS5FMJ7BtNa4J6QvCdWaY+KNMywI4C
	ZpWlqNyA8GgDsnq23blFlnGbwQW5XJXqMZurZVNpXfP6fGQ584KjMVDruaXf27mHhfBjLdLY9Gv
	RFNfiMEfxs=
X-Received: by 2002:a5d:5a48:0:b0:487:169f:d339 with SMTP id ffacd0b85a97d-48e07fb8f86mr12588654f8f.54.1792439965195;
        Mon, 19 Oct 2026 12:59:25 -0700 (PDT)
Received: from ADRIAN-PC.lan ([171.22.87.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm875448f8f.38.2026.10.19.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:59:23 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH bpf-next] bpf: Add __printf attribute to bpf_diag_source()
Date: Mon, 19 Oct 2026 21:59:16 +0200
Message-Id: <20261019195916.186225-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Building kernel/bpf/diagnostics.o with W=1 triggers the following
compiler warning:

  kernel/bpf/diagnostics.c:828:9: warning: function 'bpf_diag_source'
  might be a candidate for 'gnu_printf' format attribute
  [-Wsuggest-attribute=format]

bpf_diag_source() forwards its format string and variadic arguments to
bpf_diag_vfmt(), which is annotated with __printf(2, 0).

Add the missing __printf(4, 5) attribute to bpf_diag_source() to silence
the W=1 warning and enable compile-time format string checking for its
callers.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 kernel/bpf/diagnostics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 0abbbe177e..2421f52eec 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -794,6 +794,7 @@ static void diag_print_insn_context(struct bpf_verifier_env *env, u32 insn_idx,
 	}
 }
 
+__printf(4, 5)
 static void bpf_diag_source(struct bpf_verifier_env *env, u32 insn_idx, const char *label,
 			    const char *fmt, ...)
 {
-- 
2.39.5

