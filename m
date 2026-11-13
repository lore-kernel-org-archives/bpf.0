Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611345;
	b=bzg2oOSiiIkQ/cSD1qHoCrHb+1+sgKsV97U9CT9EYPRF8seRq6nX44hrpgpmeKSCmMBR
	 q+miw62jirEsvxqNGc4m7c3ihnOXwyC+hLqE3v9vFfuxMjO/gIwklSvIi6SY06BwLFDR8
	 4O+nDWIfDL0ikr8NwvglTWMAuUUPUk9F8jJUcIJ0vAUYaiyyl0ILfudYeZHyj+kg7EGy1
	 t064A2zDlDM+SDi5vkBuAYwF4+TFU9pbcJFZovEzmpLpxg0l/Okpec2EeAS8tN35i9tWA
	 sZ5tX9q+zdFdN5vA7y0tUBmzIZ2xaiJp3EPuhGElDS2eyN6vC/RFEVdP9HkSLrl1Cdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
	b=tIm0MYy4EtBeRxWwsBg/hc1oID7VwtxTU+Z5VVuaZD4F+oizlhw8F6RjKbcearZpiXBb
	 DK2OJRd/oqcarAi9aTjKijhljGtbr6xxiZEkD1SX1leD6TRiIxyhbmDDKcLrA/kVzs3RW
	 fgYP4isIaUlfZCr3wZdncqiVLLRg+13RY/N93irLY+afySvq1NlZuyqcoClOk6tWpOxNH
	 Cs2EM9qPsrXBrOzj5l/OKHfxJ02cYQawmYADAr/SC1zl/XFSKozJoxn59v96Zqcx7i348
	 VXPXn9dkz/AOI57HRjuYnkh3kPJ1HHDXaNqbhfmXoF17PSeyr6ctwKVQbAPauuUqTkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouX3Dec+;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F67606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F67606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouX3Dec+
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b3a332105bso14582497b3.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611344; x=1795216144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
        b=ouX3Dec+8glGOM/nZPD0TCqV8ybUzlTo66bjBJ6x3t0Z+VMiGtH/fG7ZdwQeAz6Va9
         pYliHaiLlIIKaxbnNUfeXppuAiKNyoZ7YG27VZ1Gd05nnkescHbOYG2eQTxZjsC9P/sT
         g8Eg03gFg98N7oU7YMcI93PDj3YFQPwOGaHEsIJrfq6xKJyOGkP28PeEjlNCBUbg76e/
         J+vUeiINd1fJdrexbq4vdywFEjYGJTMTGf8lB8NW1/4B+nCSlQxllC/+8+XFd+TIz8eO
         ULne4lGW9XLJb118vENUfgKUBwlQYKQtWf1pODlw5eQ9lZzqL1slUh5RO3U9kMRkLyNL
         JTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611344; x=1795216144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7Gvti5fT793gkYeO3yJuCL/jO9Wj5wjqrC/pLkeFUU=;
        b=jGfjRLPu+bEzG3zdagPbc5NiZd5lpO43SX1NNPZzryXb/ebMgkYEIpDMdFYTCpjTtF
         ByUbgzQDNjQwV2XlHNPcVFd5Uz3yrvQwwhR8PaCEVqFWFCO1nDE8qgFshMpQahGdBS0x
         fDbWR5oolGE9jmZDDGPiKLIBM59IvW5EOIT8VqAek5fujfIwsubkunQ6pKfOg09dg5iw
         fPZU0uiAm3fKOPpjmLneOU6nvX/uqzF4owtfx+cPzBxa2sdsHJgpoEwTFSg35mTpdp92
         taRO0dlMX5QdZfsQYPtgdNsRN1OGbdnQFmJhQxuzYCmxRB/PlvoxlsRNEH5tyd43FyK3
         H6ZQ==
X-Gm-Message-State: APuU4Z902tOwP2SImqypHp++EmY/vRXFmH74xgKGCmkZAsednF/JkkTD
	OWEs9Rm7l/AHOZWvqKuf2uX9QC/52JiXOnm7GnnD++iBxptm7+F+HGkY
X-Gm-Gg: AYBFou0k7LaAEZrqOE34cr0JK4ruhdCT0cVqTtUSluR2YIfyGuhmWGOLjud9yE6jMM7
	j8aPRjioOzTiF72WQKkXD+aTCBbku1O3D/QQzI3UX6IbkztiVXM4y8F0D/kVLCKqcVPWy0GVg4R
	O7dnRyaweUw0ba8V5/TWbYub35eT8AGcUgu7g/M8Epk2Qr/ym/zT3Wpxu5ulIctX3KKYWTiy9B4
	Ub7/eScfD3r+thvdb47TubXf7C7Lv44vCsonyxE2J5m1JGsRzk8Uh/o5Hh2Felt+6nI1IaAMzHF
	PWTFgp3XAomlTWhtU144BYeJKdhVD26W1VTEtWgivqbn7SGHfgmm0B4Ny0Fv3NPpjanaUHxJd36
	D5+EQgcs4lP5REWpujuvMSDy3bRx4nqoaENpy61+tfCVQhwAubJ65E4az6Iuv3rNJt3UKpzg8IH
	U+UY+5jfFUApoQhoUVet9mEBI9XZyyT/LWPHwCpMunjRLiVXRr5KPX7tgN/dMEB1NKnaRJszpkc
	FVidC08db7MfKViung+NH2xhg0qk9UF5C7uqn/+RNmyWWwOz1UXvuPd/B5xOlLE+aA75yn/BSy3
	F/QIOvMr/K4P3vm1Hm4L
X-Received: by 2002:a05:690c:386:b0:8b0:6722:6734 with SMTP id 00721157ae682-8b4aa2fe10cmr23697627b3.34.1794611343003;
        Fri, 13 Nov 2026 15:09:03 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa98b9a8sm32346257b3.26.2026.11.13.15.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:02 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:33 -0800
Subject: [PATCH RFC bpf-next 10/13] bpf: Allow BPF_F_INLINE_VALUE for local
 storage maps
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-10-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=4649;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=PgCSXxyeh0oU0dmKhIOmBKqBpwuDIlpW7iB2JIdWDzY=;
 b=TUgaGGO4k4gR/jUeFgyDKOq94k/pn/ozf+BgNPppdgm/amt5FaaluQ4cRz6OXwniPW88FHvS6
 ZVB0/SlGB/fDgfvUMUboUowcs07kL5sEM0YhyXQGKAF85t3oDwHA2Be
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A lookup of a local storage map reads the selem that holds the value.
When the owner is cold, this read can miss on each packet. Let sk, task,
inode and cgroup storage maps keep their values in the storage object
instead, so that a lookup has one dependent load less.

Map create fails with -E2BIG if the value never fits in the inline area,
with -ENOSPC if the area has no room now or the owner type has 16 inline
maps, with -EINVAL with BPF_F_CLONE or special fields, and with
-EOPNOTSUPP on 32-bit. Documentation/bpf/map_sk_storage.rst gives the
rules and costs.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_local_storage.h |  3 ---
 include/uapi/linux/bpf.h          |  7 +++++++
 kernel/bpf/bpf_local_storage.c    | 19 ++++++++++++++++++-
 tools/include/uapi/linux/bpf.h    |  7 +++++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index d482ff6a1448..4d9ae3a11b94 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -172,9 +172,6 @@ bpf_local_storage_unpin_owner(struct bpf_local_storage *local_storage)
  */
 #define BPF_LOCAL_STORAGE_INLINE_MAPS	16
 
-/* A later patch adds this flag to the UAPI and allows it */
-#define BPF_F_INLINE_VALUE		BIT(20)
-
 struct bpf_local_storage_cache {
 	spinlock_t idx_lock;
 	u64 idx_usage_counts[BPF_LOCAL_STORAGE_CACHE_SIZE];
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62de0919db72..9eac0930af95 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1513,6 +1513,13 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/*
+ * Local storage maps: keep the value in the storage object of the owner.
+ * Readers take no lock, so they can see torn values. 64-bit only. The rules
+ * and errors are in Documentation/bpf/map_sk_storage.rst.
+ */
+	BPF_F_INLINE_VALUE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 31f62a2be62b..aaeaafe60e6d 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -15,7 +15,8 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
 
-#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK \
+	(BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_INLINE_VALUE)
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
@@ -1010,15 +1011,27 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
 	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
+	    ((attr->map_flags & BPF_F_CLONE) &&
+	     (attr->map_flags & BPF_F_INLINE_VALUE)) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
 	    /* Enforce BTF for userspace sk dumping */
 	    !attr->btf_key_type_id || !attr->btf_value_type_id)
 		return -EINVAL;
 
+	/* The slot tag needs an 8 byte acquire and release */
+	if (!IS_ENABLED(CONFIG_64BIT) && (attr->map_flags & BPF_F_INLINE_VALUE))
+		return -EOPNOTSUPP;
+
 	if (attr->value_size > BPF_LOCAL_STORAGE_MAX_VALUE_SIZE)
 		return -E2BIG;
 
+	/* Never fits, also in an empty area: -ENOSPC is only for no room now */
+	if ((attr->map_flags & BPF_F_INLINE_VALUE) &&
+	    bpf_local_storage_slot_size(attr->value_size) >
+	    BPF_LOCAL_STORAGE_INLINE_MAX - BPF_LOCAL_STORAGE_INLINE_START)
+		return -E2BIG;
+
 	return 0;
 }
 
@@ -1030,6 +1043,10 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
 	if (!btf_type_is_i32(key_type))
 		return -EINVAL;
 
+	/* An inline value is copied in place and is not freed with a delete */
+	if ((map->map_flags & BPF_F_INLINE_VALUE) && !IS_ERR_OR_NULL(map->record))
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62de0919db72..9eac0930af95 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1513,6 +1513,13 @@ enum {
 
 /* Enable BPF ringbuf overwrite mode */
 	BPF_F_RB_OVERWRITE	= (1U << 19),
+
+/*
+ * Local storage maps: keep the value in the storage object of the owner.
+ * Readers take no lock, so they can see torn values. 64-bit only. The rules
+ * and errors are in Documentation/bpf/map_sk_storage.rst.
+ */
+	BPF_F_INLINE_VALUE	= (1U << 20),
 };
 
 /* Flags for BPF_PROG_QUERY. */

-- 
2.53.1-Meta

