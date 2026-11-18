Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997081;
	b=ytsdqrfnTN5Eyx1OEl72I7tdSj6UdoStsAqCDM9pJO3zZ/wqefAN6bR0nrxRe+lPlque
	 3FJUZXuiWdfTUFyi510VqnEbQ03zW8OgFWXFiRjxidXVLWMlJxiTVXZjWF0XKD790b119
	 bP4s5lCAw02tMkFtYNbdDiFXXWHM2cGC/mQcoq6XOHvxcgPxhzSq5OmgAy5qHsHbekv/g
	 0wCHXUp8YhRvcr1j2OAX2OO+gkyyysmTs6zi1iGF0pdyhVy77kTUvTMCncIADta9Og/vv
	 tkcZhnAgJGkxNMBS1aoY6+x3on8X3UynQiSPP8a8fP+4v+nYW1Fm9IdBx/LdBvei4uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997081;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
	b=Jf6WeZ1kBL+AigXPpmC7zx8tdsbDL+CGGWmMVqH9/zzSaTXQQbK4F34RlXWmQkHGjw2X
	 sBE+u5TtHVA99a4GPa6BVGLzYN1ibl77ralZ9N9Bxub/kMbiV80W3V5g04lHo4MzwBCKW
	 2MeuUrvfNTELlEuj0lfZ+DfvOoNkxKZNeeJFp8OfemVEtp80Hlte7Xb5Aj88j3bAkiRTH
	 C9oC8wdsP9lGMNDU3Rfl/NWRRcxgnbHkZopYw5AQbMmowcOGghmuVD3ZiRTyMFKi3cJth
	 JCW8SFFbtWZSBjblN//D/XxMHMH6PuCHSTmoBhjDFVQwTPZbxsPRbOOldaYG0uKaqWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ob97kGp5;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34E606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 10:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C34E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ob97kGp5
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ae5389c00so541612eaf.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 02:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997080; x=1795601880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
        b=ob97kGp5SBgiDnJ3pS1DBEfZvQ7EMm+NKaQK7Kq65fETrLQz2J/d/L2Oe0iz8lWAjV
         JoWUp5mVskJ6KtyWFqGhevJjN8Lz+WDioQwWZt/QLQnjUv2WSjDx8Pk3Q33mdoyTTn4Q
         PEq2dLl1xR33OfscDqznt7CY3ijlNUxEavNB8x2lyN4chZ+hbIq29Jn3lSpS3Zm0Av/5
         kGajT0l/vOCbw9KsnRu+1nwq7NbXSYgvAgTc2Hm32GhDnhNYXD7qwtA94Dxc9M4pDnbN
         4szFO4DhKs9aehLR82LkT0wdw+MCDqwKdPubc0vu933kJ9nOMCpOuO+/8IWsEZf0Nflr
         lM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997080; x=1795601880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m9nxtzxZNBF3WBJsdKrWnkE6fbrAAwaEK/yK704NFP4=;
        b=XXCyoV8F0b136TS4NvhvBPA3C4K0xcyrRoM+fMjb7iaTFjF9VyKr1KW+uOe3TzWU8Q
         kqoL2qT7XZ5aOl2A2ro28PA1W+Y4jiISaCA8GWBdGF5e9k/ZiJHM8K7+FaEATX0L3kA6
         16qJwd+HKpN0g7T49QpzutqjR8AOJMbd534xUN4e2/S+ARXbrJSXhbk6ppvI53QkD2+/
         tIqIDHdvspD/A17WO/edXlzneLWQHtXKl6bU6LAXAXPJkHdNLb4j9oeAcrH70/lweAsl
         Es4WsE0qWyEteo9c4/TkxnV3aAnfq68qxTQGqubQmeJ4xGB7YN5S1p3XY2tzmpRpdLEy
         wYJQ==
X-Gm-Message-State: APuU4Z8/7DImghHk3uEJG3sBt2lq26cberct4enbpROGYLVbL5gyd/j3
	dpcRbBmJ1UbRRPxgaAbXQEpV5v7f8+oiHCTA7f/AqeOqw9eBNkGXhc9o
X-Gm-Gg: AYBFou0PiaRI5blFuqO6Ef+lfQ1aEaRGSRAc3ye9eXMki1p51+fDCejGV7QMqxzwFoE
	6d9Xhx4PLJ7tXOELfE1EZSUWjcRacote7lseSFESBdgs/IFZYKVvPJs0wAQJ6IoBdPZLjCFhhLi
	etIvfRnIXOMu4jIWi1CCuLfYrqJQBNC9ItXh8aHlneX1OW4mBv90v+M3oePz3avdvKLbAibxV7q
	Um82IIHvD9yqlIEoWWquOeKTQofu/Ya0Wq46cJ5awNMoa08WsBJvBvO5VfcMGW2tZTl1c+BfNd+
	kxtADVXpM5twjIZSSUjmTxQZKudAlaIs2ZSUtB8CGzZs62K0WuwmQJmst4yxnuMXBbUa4NUcjDe
	wP8QPicG2hAappppGIzCryYnhV8iC3ZyDFwSqZdRqzIxgdVfRgs7tWeKXJ+NuhghFDIe+8jGx3e
	l8rj7cX9cfJ88dgQ7SIp15khqGGT21VfiW73sfbm1FKD8EJdSTzaGVlhc7jViqkeSNzNYdzTJEY
	X3+NAOL9u+XWwTZdHc24DsAxQBYKxScbV5oY2EnNvtjyECEsiUxzHiXtiTpVobXVNxxJ9DqtCtA
	M/rYnchf/UPEE0D2bmliAcCj1dYKZbPQqVexVi4oIhibCiTaCkE9HtD2D0PczyE=
X-Received: by 2002:a05:6820:1391:b0:71a:f498:3048 with SMTP id 006d021491bc7-71b1853a5eamr1698465eaf.25.1794997080164;
        Wed, 18 Nov 2026 02:18:00 -0800 (PST)
Received: from localhost ([216.128.135.139])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b7449282c8sm1781869fac.11.2026.11.18.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:17:57 -0800 (PST)
From: asatsuyu.liu@gmail.com
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	puranjay@kernel.org,
	vadim.fedorenko@linux.dev,
	Yi Liu <asatsuyu.liu@gmail.com>
Subject: [RFC PATCH 6.18.y 1/1] bpf: Reject NULL arguments to four kfuncs
Date: Wed, 18 Nov 2026 10:17:48 +0000
Message-Id: <20261118101748.2335815-2-asatsuyu.liu@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
References: <20261118101748.2335815-1-asatsuyu.liu@gmail.com>
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

From: Yi Liu <asatsuyu.liu@gmail.com>

6.18.y only applies the kfunc NULL-argument check to functions carrying
KF_TRUSTED_ARGS or KF_RCU.  Four kfuncs dereference pointer arguments
unconditionally but do not carry either flag:

  bpf_copy_from_user_str()
  bpf_copy_from_user_task_str()
  bpf_crypto_ctx_create()
  bpf_rbtree_remove()

A BPF program can therefore pass a NULL or PTR_MAYBE_NULL argument and
trigger a kernel NULL dereference.  Mark the four kfuncs KF_TRUSTED_ARGS
so the existing verifier check rejects such calls.

Skip __ign parameters in that check.  bpf_copy_from_user_str() and
bpf_copy_from_user_task_str() intentionally accept
unsafe_ptr__ign == NULL together with BPF_F_PAD_ZEROS, which is used to
clear the destination buffer.  Without the skip, the new flag would
reject this valid use.

The patch is intended as a minimal 6.18.y stable fix; mainline has
already made KF_TRUSTED_ARGS the default in v7.0.

Fixes: 65ab5ac4df01 ("bpf: Add bpf_copy_from_user_str kfunc")
Fixes: f0f8a5b58f78 ("bpf: Add bpf_copy_from_user_task_str() kfunc")
Fixes: 3e1c6f35409f ("bpf: make common crypto API for TC/XDP programs")
Fixes: bd1279ae8a69 ("bpf: Add bpf_rbtree_{add,remove,first} kfuncs")
Signed-off-by: Yi Liu <asatsuyu.liu@gmail.com>
---
 kernel/bpf/crypto.c   | 2 +-
 kernel/bpf/helpers.c  | 6 +++---
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
index 3837d4dcf48d..d1566f76a2c1 100644
--- a/kernel/bpf/crypto.c
+++ b/kernel/bpf/crypto.c
@@ -353,7 +353,7 @@ __bpf_kfunc int bpf_crypto_encrypt(struct bpf_crypto_ctx *ctx,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(crypt_init_kfunc_btf_ids)
-BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_release, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_crypto_ctx_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_KFUNCS_END(crypt_init_kfunc_btf_ids)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 72757f7290ec..d9e0c95bce02 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4278,7 +4278,7 @@ BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_rbtree_remove, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_rbtree_add_impl)
 BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
@@ -4365,8 +4365,8 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
 BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
-BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_get_kmem_cache)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b89a5d717e42..aac687b81b84 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13494,6 +13494,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		}
 
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
+		    !is_kfunc_arg_ignore(meta->btf, &args[i]) &&
 		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
 			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
-- 
2.34.1

