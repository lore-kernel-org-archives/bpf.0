Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426093783C8
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200406; cv=none; b=ikMIxL/hRKZafdjhjJy//EFLeNKfLVsMBlp3ylkLYwl7sXXhhIHkgnzptaMuGs744WCZfZ9tHpEMtM6TWRirigjnejVyktsANjaxE2ShK6KmuB/Lsk9a2GUUsQycDmgK8odEwMPLVUx4LD0x9XzuasrrcqHhsadOOvjDmHFLbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200406; c=relaxed/simple;
	bh=USaL95hk+3EiXq7mhgdzzEOgrpG4vIF6DsEexRYU090=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4xiR8fsi8eWEcQjLGqCkU55ApGHlVYSObQcpAE14DaGFcJswD7j3En2/dF3Nd5x4PIPW5oqECG1C01qMh5VMfjsdqVV8rJsF4jLwjmQ5OCGdBIoHQmcnfvWCVFMyubAYfox4akFbBQcsGEvAys27MPNeZgCcqJPOaSErZtC0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQAEDQgu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQAEDQgu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e940d5d2beso1461435ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200404; x=1792805204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=EQAEDQgui+sBIAqX5qF0pL/FIxEM49hRFDbV4pE/T/gbaxSZd/KgJE8rwyVgpG4sMz
         Ybv0VD5W5B4BVNtgLRccpp5l/gg8skUeoDuFPH0s2kJ+EWO41HG7hUpuqKKDcmyXJhMW
         fAmw6obikaXQ4hwAPv3B3WTjnFecPkT6A3wnul+ux9uiQ8jrWT1dihhh8e6y2E2VH9kW
         IaOqc+x+YChyWxbJRDsMPWtQDwd3uzgARWQA8UEFYN4zGJF9H/+/VTm5hAH7Q03DVSAh
         pTfGVFoxJ700C63mlQq40mL/+LJcMAI8BhJ4pXOo854OnmXDWNMRLuC1sLKe6po335iY
         1SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200404; x=1792805204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XhSztm+6IxvHUKooWB8xZKABcaXbWAp2R1NWdjNwj7Q=;
        b=eO89BIl+y4uL9R2+sWoyJmMRpdnT5HFJWJYXrBaOSNnU587JwyEHgm7PH72sGfBk0o
         slk0qv3R2rlNUfFZpfYBMywz+hhNF/SJGFL9l91kLpFKC7BKu4tjAviZAe4E5j6JnoB7
         eiA3ZaXkkAznjp5l5oM6QZLcdPfCML0wthle/VdAlszcNCFi3D+0ke10Hu0gTBHJFBbB
         mryZjdfhsdfm0NwcIPOvu8+/tX02ogHa4/JpujNN08HuD6FpN3mUnyW4H+WSxQPeW4ZE
         7DgluCTtZ3Eq/7CjvFF/hOHP2S5C0BoMJYKpeHIS20qXZH/KVTJrgrReLHdXuf7TTjGk
         CxyA==
X-Gm-Message-State: AFq9FYJvSJKyyFFxb8nu5fZp0SoS9cEiVA/xHYrf7RK2hsKetrW3DzAV
	Z7XQAL+is1+zQJ6rg8UEi5P53g2FsbYWNW/hnGVEyVaJgCZIj76XM5wbqPXDTQUU
X-Gm-Gg: AYBFou2zO3sEk8F07op1CQJ79v4Qbc1uflOOa4mnQMo3Z/e0FemYm4ZXa74V/HHd0/r
	F37FM2/xTNSzDxcfNLK9QK7Fyiu9NAAlg/0z1Rqd/b2IL0y38ZlGGxlYupIudQgtUcH2DX1npAN
	wEZN1EPdsdNX3TbCF9lf2zezKggxhxnBsPkiGgddev8EGADRccClosYV3NjbdU7Q+KI9lLev0hw
	PuAZLiuL/ju8fKLXyVfwSTDiVNhLeNFRphV5+BzMx5A6XVgRUVHkGjUjg8NB3p/CXBE29rJdYQX
	uF+cCAm2OkXt0IWj43pnduUOjUa/dBc68RXfQe5LmjQ+kwxogPYtTTdUknnKSue5Tem8xwdkfpy
	rU8nBQQA12hxl3aZeY2YR/ogeHdDgg+VBOv9vuVv3oJv+FFxx4Za9cVDfPNC+FdFNkX3h2jY/UJ
	6fxp+OjNqfTKvXDIkLdU+ya6fiqLCaa57XRR/IN8PfK5/U7u6Z4Rf0/pXu737FPCGLfha8StCbC
	DU+9rknMSs6i35Xn+rh9qt0bSwKMj5FxaGl0taAea3lT6HvPJvwbdMP3KmMnjBd3o4Sv32c7ZeZ
	1l00mwVZRMdyfgYWXfX+gBJP8cT9bj9aJykdekOYJXQAdR8iuF64JQ==
X-Received: by 2002:a17:903:19c6:b0:2e9:723a:cf30 with SMTP id d9443c01a7336-2e9a682d710mr13777485ad.2.1792200404475;
        Fri, 16 Oct 2026 18:26:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e833f1asm17242335ad.43.2026.10.16.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:26:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 14/38] bpf: Clear sk_refcnt of a clone before its storage is linked
Date: Sat, 17 Oct 2026 01:24:27 +0000
Message-ID: <20261017012451.364800-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

sk_clone() sets sk_refcnt of the new socket some lines behind
bpf_sk_storage_clone(). But the elements which that function copies are
linked to their maps at once, and an element leads to its owner: the
iterator over a sk_storage map hands the owner to its program.
bpf_sk_storage_get() with BPF_SK_STORAGE_GET_F_CREATE and
bpf_sk_storage_delete() rely on refcount_inc_not_zero() to tell whether
they may touch the socket.

sk_refcnt is in the part of struct sock which sock_copy() leaves out, and
sk_prot_alloc() does not clear a clone unless init_on_alloc is on. It is
zero in an object which has been a socket before, and anything in one
which has not. If it is not zero, a helper gets a reference which
refcount_set() wipes out, and the helper's sock_put() then drops one of
the two references of the new socket, which is freed too early:

  IPv4: Attempt to release TCP socket in state 1
  BUG: KASAN: slab-use-after-free in __raw_spin_lock_init+0x47/0x90

In the meantime the helper changes a storage which bpf_sk_storage_clone()
fills without taking its lock.

Nothing else can find the clone at this point. Say that it is not alive
yet, before the first element is linked. Sockets whose parent has no
storage are left alone.

Fixes: a50a85e40c59 ("bpf: Expose bpf_sk_storage_* to iterator programs")
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 1d295a8769fa..b5349bec5695 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -164,6 +164,13 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	if (!sk_storage || hlist_empty(&sk_storage->list))
 		goto out;
 
+	/*
+	 * The maps lead to newsk as soon as an element is linked, but
+	 * sk_clone() sets sk_refcnt only later.  Until then it holds whatever
+	 * the slab object held before: no reference can be had yet.
+	 */
+	refcount_set(&newsk->sk_refcnt, 0);
+
 	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
 		struct bpf_local_storage_elem *copy_selem;
 		struct bpf_local_storage_map *smap;
-- 
2.55.0

