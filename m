Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0232D73A6
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255168; cv=none; b=Y4Y3+13HLOVf3Vzg0trFm7BlDZ/OCsDQ/Bm69OnekuKLsbcYCW1I1bYZWRUxqgaLENAukIMegaS18W65Ednn2PTTjcWo34b1Qk0OwRYHaTzhqRgHFHbrtSW8vcX5cfodDAbNsZ84c7VbxnB7tm/E9oL6O/WcWVVobBLxublZzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255168; c=relaxed/simple;
	bh=ONRSxOv0WIrGtolvtQu6QhHo0/j3DkO3AplhmnSjVaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImAYnRWU4PsZm4ijK0k71dmUQ+3V/fT2A9gx1hIH1DoxGAPJODYVwa4tEuZHN+M+lslyMWTZ2E4GpfTr9U58LProZTliBNMoDiVP7frG0QpfGdx+Ns4YSkHvsE1L6mC7NlOjhoM39Pp/ycl9LKyoJMWMXNMsimFREicZNCllOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amYb7yBy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amYb7yBy"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso561615a12.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255166; x=1792859966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V4vQJUQQucPpz0qllVj00ZgJScSPlEDGHaCFRbM3iA4=;
        b=amYb7yByQ20vyz2zGeyWLnbL5uz2DhRfIb9EO7eu8u+2fOoorQMhNA30gwYVZZpV9G
         ZOkBPUJJnMumuK9+4kEWFjWB1awEdFdNpUfSsx7pcX94POtwwD4gM/2KWRRb9gDOQPqn
         NdFh5qNmGnIYphJe1SSnqWckO6lwNj+MD0R90gvv/APLIYZa0Hw7eDNsicyunwy3PwyL
         y7si+V5B4R90ZrL6gU0Q5UixY/lqh879jeZeJPJDLqOBzX/7F11C/rbd1o2drTnSNob0
         44rJB82QMJ0di32Ie6ptxlHIn3+Qkv07kxfA8zyFLy2UmLtYZwvXRPHy3hqeY6oYMr6j
         gXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255166; x=1792859966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V4vQJUQQucPpz0qllVj00ZgJScSPlEDGHaCFRbM3iA4=;
        b=e2g82vHMGou5aD2obdbIfsmrF5kl1Gw3l8HwfhIx7ep+drc4diCvRvlsUMJCnd1KLS
         Sgsp4KMyWOi0tZ7TDuRFjbKjubh8RlCy/YvM+hiHe6r5qyHMhlHK0/yMoqVtMqrncrAz
         EzSsEBbIxINt8vhN+oEEtWDNMvQr7GmqfLccvYx7xtOJ8qMI36+vvK/GMorkoHhiX6c8
         J6OLpRyDo/s0KrQZZk41CfFgQRwjSOLgGWMM31QuIHHqtRFx2iN2u2GfuESrlvycs6x3
         uWd3ewCyvONZFL2Z4u29UYdlHo/E+3z/Op4kXw4DzgHdVZdZ8W0fSMXqrHjLMMtwm5+l
         z3Zw==
X-Gm-Message-State: AFq9FYLqYhDwz6hs839S6CfM4Sd+vjO+DFM88ZiKA9Z//JeRQhsFTrgD
	RoTc0mkssp0JykC1aIihiaIgYoh0YL5S7iw66zBoq4FhA1HXXX7JuWzkl/SsWg==
X-Gm-Gg: AYBFou11YAALXQ9KhE7bgRbqWozjvjzRVyY6Yn588bfs0pl/9qqJUgAqiMsQYdvt3ES
	S9f/tR2TOyjhaNp/UYt0XJI6CSErAiywHUzZIKLYbkDmOhAJE2UK65sVFpXCWPOddxEaLMwgwhA
	h+WfQ5WtSqiE/EJK0v8mUcHHs1at3LC6EosWlHTb2N8J1a28G69LXRD5pkXRQHFOhcr8R5iyLh+
	SIJNzyTK0aGSfkgleGkDNZz/T5UMY9O2w2+Sqlsa8xo2goc9YvqQqjABMVZVzpjluFmlaEXzodH
	G9t8iM5SrUrU21nxkph/X5MiPYpsW+Glh4iKkwZbW1Un5OiwEvvRWlJaNGCPA0jp/7/AnvQ4T8p
	RVevtqVAr0YebNWKp9D6JSTz9yjQ+geFBDWMcCiRED7wNvzbvroPrwDAptJTHd8RUxpmLJMkE7w
	NDRK2I1q0Wq4xL3hKNhRx6wK2KbmEb3HJeQo6+ORo3KY74C8sOZl8X15+/VRmP37l21Gkfe2l5j
	LSQ2Svgl8EGBAKJz48NBArnG11JpvHrzGQloxCmE0uYhqW2QbHEnYXFJDIk2B8mCAaYB+tbnMQx
	Yl0uDjDSuy2muE36ZXzbAmNXz6yG1arX7VeV9C+8pFE=
X-Received: by 2002:a05:6a21:4514:b0:3dd:a007:cb2d with SMTP id adf61e73a8af0-3e22607836emr2260481637.41.1792255166073;
        Sat, 17 Oct 2026 09:39:26 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e508sm2401682b3a.28.2026.10.17.09.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:25 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 16/43] bpf: Link the first element after its storage is published
Date: Sat, 17 Oct 2026 16:37:18 +0000
Message-ID: <20261017163745.3341787-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_local_storage_alloc() links the first element of a new storage to the
bucket of its map, and then publishes the storage in the owner with
cmpxchg().  If another cpu has been faster, the element is taken out of
the bucket again and is freed together with the storage.

In between the iterator over a sk_storage map can find the element.  It
stays linked to a storage that points to the socket, but the socket knows
nothing of that storage: bpf_sk_storage_free() neither unlinks the element
nor waits for anybody who uses the storage.  So nothing tells the iterator
that the socket has gone away.

Three cpus that create the first storage of a new AF_UNIX socket at the
same time, and a fourth that reads the iterator, are enough: in 20 seconds
its program was shown some 4000 elements of storages that had lost.  If the
socket is closed in time, the program is handed a freed socket.

Link the element once the storage is published.  Both happens under the
lock of the bucket, which holds off whoever finds the element through the
owner and wants to unlink it.

Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/bpf_local_storage.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 7721834e4bff..c08afb33d038 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -509,8 +509,6 @@ int bpf_local_storage_alloc(void *owner,
 	if (err)
 		goto uncharge;
 
-	bpf_selem_link_map_nolock(b, first_selem);
-
 	owner_storage_ptr =
 		(struct bpf_local_storage **)owner_storage(smap, owner);
 	/* Publish storage to the owner.
@@ -525,11 +523,17 @@ int bpf_local_storage_alloc(void *owner,
 	 */
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
-		bpf_selem_unlink_map_nolock(first_selem);
 		raw_res_spin_unlock_irqrestore(&b->lock, flags);
 		err = -EAGAIN;
 		goto uncharge;
 	}
+	/*
+	 * Not before the storage is published: the owner does not wait for
+	 * users of a storage that it knows nothing of, so that nobody may find
+	 * such a storage through the map. b->lock holds off those who find
+	 * first_selem through the owner and want to unlink it.
+	 */
+	bpf_selem_link_map_nolock(b, first_selem);
 	raw_res_spin_unlock_irqrestore(&b->lock, flags);
 
 	return 0;
-- 
2.55.0

