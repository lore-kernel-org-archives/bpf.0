Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED13385AA
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330572; cv=none; b=bw2JAF4KbRMnq2dp4vJllphlf1Yf13iGlyhkJ2FxfV8PnwluE1Ew5xoF1cjMNQiSN8Nomnk7+LrXWdacTYERDRYBa7VbGQmphsleFMb3RQ5WgWbJxRbk9HdwdYEIJQVyVyyxlFrMdI60QI0Bs94htXh5UP68FzcgwWH5z84K/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330572; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUkwgotL4CVFzHGqoxDhCwlPLEWHyBl6YphI0Phk/9pgQBYW3fd2w7BEP1HQlfzhJuDPKSNwH+DqbyBRqo8FgsANCQH9OI7VcFfeLeUCAGDjxrmpZVOE5LMOyU67yfk5lvvMWAkem5OHW7HUpenUX4dn+Q1cKLqQJcYdNuecQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJGxtCyW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJGxtCyW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8230c2d3128so683488b3a.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 14:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330571; x=1770935371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=MJGxtCyW6xnguzTcqQ3culzDnGyItZdscqdGzseaB5kr5eN4EUv6sdTmKkkV/vBLDQ
         NKLecIAX+eGFMWrHEj+kErNUOpSbN1f17paMW/rzSK/R9Y5HKcB50gnqmwVoy3KXUd7A
         G069neyaaKa/+TqLnLK/M2M+fBT66TqmeZwOC3i4dvNYUIxJkkJNLYEHimZny0Mw2YF1
         AQPrnB02LP8iYUg/6NFT5u4O5byTH3a9oICSQBHQIyauNURSxkem/BE+2lCWzQ0+6UQ0
         bEqYb6CA3yqrBiFUHHmzgU8BVRn14a3V9Uxa1Wja0boaRrMRkfiYjJWRlOqLygxzSdoK
         92Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330571; x=1770935371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=Jgg6pWEahJP9VWVYzL8jlp0fgyrBfIPezTD7wojr0J53SCToxUHIwuvMzZ5pnCrx46
         FjjxdvPz/W6MhB1thPGymT5s4u9K5gSGG5v/XEfkgKCZfCO8BMJGRWufAGHkGrnv3ASQ
         ZumOvRD/RLH4Pd0Tsv/ke/IqEmvtozFq0bVlBeHHBqyt17dIa1UUDVQHf3UjAlisRcpl
         V18syakhgxe0mQN6dCrXhhJg/mFN6ZqgBccyLuJSUlgyxb8DN+PJZjQbfMVRAxwXISq9
         1bxXS2vST9dZR4/MnMVCVmQTUyaiErYrcF/kcpFhGNGiJqjB8usbH29ToQfOlFzjtfVP
         E0ww==
X-Gm-Message-State: AOJu0YzzymrFiwX27JHFTXmm36/hMfYYCPE+deybZHReZKyUpU5txRtH
	a/qWObnl5ZYeliWzkUgozNYI0FVyD4O+EqZkjx15l03/MBRmcROrJ5e1QEioTw==
X-Gm-Gg: AZuq6aLfcDnSCpBnK73yEeFTZ+auBeBHlB+J4YvHuofc9PHYl0BYG+uH4xUhjobLqUP
	/mu0QgT4D3/A77pszkmUPF892KA+oONTQS+PHPnRORjKdO25sm6AuYuklVH8dJvC21T6u/kWgoW
	0eJ1L0vXAOkMHNhqB+gPcEYkKiAytuTI0+2bYt70tAZEl+rDgdLjXpesUMXTGikpxdGjTXtJQIa
	e/miFrJdHRVID+IvwKAsjjfyJNzHtUgGe/y6MysBta9z0dRvYenRgxg9RXFXFOoi4sPu0/ciHHd
	XWvs0nwKIznKwkC7i0xKdofExx8Xe5BbILDyKoWxIRMS1eujzl6S/k0yBUFrdK/LIr4zIYQnW3l
	M8/RA81SuErgsylftwFviTNyx3YzyyTzeLlAV7/RUTDgQP//NFH9QUPpWLJ/IpFlS+mzJaxFY/p
	63Jqg/ZQl6bKrK
X-Received: by 2002:a05:6a21:4a98:b0:366:584c:62ea with SMTP id adf61e73a8af0-393acff8861mr726161637.20.1770330571143;
        Thu, 05 Feb 2026 14:29:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:21::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb3cb742sm427513a12.0.2026.02.05.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:30 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 12/17] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Thu,  5 Feb 2026 14:29:10 -0800
Message-ID: <20260205222916.1788211-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3

