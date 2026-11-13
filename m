Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611351;
	b=HuOyJYb6eziV8/qZcA1faqfVozrdhia1i0UPyceRBkVYNEhM8cv4nF48czUx/PzFYKv7
	 NXwZslCv+PNk/WMi5j/uc0Koh6OxAV9flf87VkDX+oqdWCWOLQaVi3FDJmAEqlqReyxBJ
	 1ttypILyVYGxMrGwdAQVBsVIRIrDprQw6bbvNTeEZzg220qmY6U3rHJkfurj27rAjmlEJ
	 coyc2Wnqjz0PNtVdzSdONslDRRGKzBsa5Fek08heL4Gmq8BAwYxUXvYxR7BWHN3MJi8sc
	 27Typc5QBBfFuoK+NIFCmNOBHSSPM36D9jtFP0UK8GiGycU8j8XMtt4aNFJVSErjMSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
	b=GbOD1xD2aYivsv3MYKvFkU+YgJRgze9rbRANbIhTRchZO/BPcQaCZrhTl/atVoTsvDOh
	 r6cGHNYkn+d1Xf6jCOGNe2KciCtJ4ioxYB+KmUWDHg3BkdYdILm1zEM+H0txFVCUO7XDE
	 usXyDicMMkXpLQynmdQ0kjGSX2j/NHLMy5mHEW/pt+trlzv3MCLibHymiFniJ5YMOgcMg
	 R7OKHTWVLpthuCwMMvn4doB5vySYZcSvyaOU1BtwMq1fCdDX2QvGKo2INJRt9b9RQiWko
	 qQkoz/PDl4va7j7ymHpsYfjcvBmnKEW0bTKZu4MBbPb+q5nQVjPjjTlEwxWKt0ioyuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlpK2GJ4;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00B606A32E
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B00B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nlpK2GJ4
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67bec5dc8d4so1025998d50.0
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611350; x=1795216150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
        b=nlpK2GJ4UE908YmoENRFHhQArPVEnSUbUDSGUtuYYqQlbUCPaCIYAYsqG6STPuFiv4
         aPTcbO4qxX9dVrfvpkCfMxZ9xPXkIu9CI2IdVlTaHWw9yDu3GgEmuk97TyNWbaI0hpwR
         Rnmr+C8XJQ1ahWKi2IkiMe3VhP5q09aQTrc9ZMydveM7pOlsKvHxAVd45iiinmeKomgY
         0k1OkkecfSOsStUKrcwkRcxMHOBNar7iaXzEJuZUW+3JQUc2t5vBGWDzTadSfjtqJthU
         fMcFMQKbPjz1ogVMKfWUDHMT9kEg6oUrjs4tjgdilTI3DhfsuBG6xzrTMO5d4gFp9b+5
         7rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611350; x=1795216150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
        b=SK9t+ji8rYTvs3/z84ek7CXV8ROxN1wobT1gip5ky09J2c9CQEpYDYd0PAUa0V42DL
         6jfaznZ392elAMtWMwm6EUEibz2WHygdz5+WFQyuJGoTGfGWfmbIGHWvLMWdfkP19EWd
         dHpv4yI8K9M4vPmVkzBFkyA/r6DwbTcXfYwY721KDGYrVoq9ne7AKKUgEYaCEH0ul+Vu
         uY1YpYlpwB9CRiPeAuzhq/2yo5YHSep0Bi+lFnBZUt4y37UGGJzWInqxn1RlPylkyfWM
         jB1t1SWNPXaaMvrt6VgLfUUI7ll3h3u6+Qotzf1uDf9mbCuiITi8OuXlK4RBF7bAmsO0
         lqvw==
X-Gm-Message-State: APuU4Z/bb3WtLybWZtxkwa/9y/GxO6WL2N0n9SjynxLb0DZjjjLDbpGo
	aZuA0H+BntJ3UwL++PL0pXxlklVfahWT4JzzrqABHudfe3/2jrL1W9m8
X-Gm-Gg: AYBFou1T2AmTRzk4lnQbMVBOmxRr86Avxl5GW+2UfV7aK+ofcM/deug3vjeA38AnPdR
	LEVZL+68/lwTZ3lacgYRlpPttIWZnKFlAAYb0A6XL7WKNVoXvxlgkloQpriOpY+2JU37Ww0epqS
	rOSLvwmOnf/mKlPIVwkBC++P7NmZswYn/O1mbI7JjzqQcF8xgMsVo96LOZCbajs6Dq6w57V6Nyy
	oc0ETqzPHRhAYc4K19MI8tSKmNVmyRp51+A11MygFqA2RD/oIGpY+/JjKu6UMVmCMQRFFRRztcc
	HjErCV3RsDo+TZuTh/hmJ0mJe19gmLwqnUONn+qCJ3YR+sJb0QscAQ/Fr8jaFJfSAc5h+rJZJjz
	Drlgd6zCQ9YlyZWz6Ucag9TAMau+RyIITU6V45ziiznzV5JTFg4zjAC42E3OzoykeAap473OYlO
	w1+QIWcG3WTnDJNjglZeMzrJECQKBK/lMg488djZtb4/Q1x3Nl0PgPWfkzmv4fxt+SZijxeAz57
	Gt04uE2gPH8Mc7Cn3TPysWuOHHh23jhoAAYqXoerOCFIZbIoeOYvad+4UIhu0fyUnX0jhBjgIdb
	vXRfyBElkSSXpuRzyllz
X-Received: by 2002:a05:690e:168d:b0:67d:99fc:2e40 with SMTP id 956f58d0204a3-67d99fc3946mr658987d50.88.1794611349974;
        Fri, 13 Nov 2026 15:09:09 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a4339c3sm3295234d50.3.2026.11.13.15.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:36 -0800
Subject: [PATCH RFC bpf-next 13/13] bpf, docs: Document BPF_F_INLINE_VALUE
 for local storage maps
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
Message-Id: <20261113-sls_f1-v1-13-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=8109;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=P06RF/RpaawtQbkge8KA7DSbH3GyTwWE+ihZk+ABnM0=;
 b=k2+LE4G5B7r7p0nXiQ9B2vnuLFbM7SS7JHVHA2RJtUg+yyCNHha48d2DbWR93pCKC2jgpQ5go
 +K0v0RIFlm/C7rmClng7i1ATSqlzkhA3kpZrkIFNO79lOfJ0Ndicqrr
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Users need the rules of the new flag, its costs and the -ENOSPC
fallback. Task and inode storage have no docs, so the sk storage doc
gives the rules for all owner types.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 Documentation/bpf/map_cgrp_storage.rst |   3 +
 Documentation/bpf/map_sk_storage.rst   | 103 ++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
index 5d3f603efffa..a636f2635cd7 100644
--- a/Documentation/bpf/map_cgrp_storage.rst
+++ b/Documentation/bpf/map_cgrp_storage.rst
@@ -31,6 +31,9 @@ The local storage can be removed with ``bpf_cgrp_storage_delete``::
 
 The map is available to all program types.
 
+A map created with ``BPF_F_INLINE_VALUE`` keeps its value in the storage object
+of the cgroup. Documentation/bpf/map_sk_storage.rst gives the rules.
+
 Examples
 ========
 
diff --git a/Documentation/bpf/map_sk_storage.rst b/Documentation/bpf/map_sk_storage.rst
index 4e9d23ab9ecd..a1e06f987a5c 100644
--- a/Documentation/bpf/map_sk_storage.rst
+++ b/Documentation/bpf/map_sk_storage.rst
@@ -14,7 +14,9 @@ to be provided and acts as the handle for accessing the socket-local
 storage. The values for maps of type ``BPF_MAP_TYPE_SK_STORAGE`` are stored
 locally with each socket instead of with the map. The kernel is responsible for
 allocating storage for a socket when requested and for freeing the storage when
-either the map or the socket is deleted.
+either the map or the socket is deleted. Values of a ``BPF_F_INLINE_VALUE`` map
+that are in the inline area are freed only with the socket. A value in a normal
+element is freed as for other maps (see `Inline values`_).
 
 .. note::
   - The key type must be ``int`` and ``max_entries`` must be set to ``0``.
@@ -108,6 +110,105 @@ Socket-local storage for map ``map_fd`` can be deleted from a socket using the
 socket identified by a `socket` ``fd`` stored in the pointer ``key``. Returns
 ``0`` on success, or negative error in case of failure.
 
+Inline values
+=============
+
+A map created with ``BPF_F_INLINE_VALUE`` keeps its value in the storage object
+of the socket, not in a separate element, so a lookup has one dependent load
+less. The flag also works for ``BPF_MAP_TYPE_TASK_STORAGE``,
+``BPF_MAP_TYPE_INODE_STORAGE`` and ``BPF_MAP_TYPE_CGRP_STORAGE``. Inline maps
+work only on 64-bit kernels.
+
+All inline maps of one owner type share an inline area at the end of each
+storage object. A storage object with an inline area is at most 1 KB, including
+``struct bpf_local_storage``. On x86-64, the inline area is 840 bytes and the
+largest inline value is 832 bytes, because each value has an 8 byte tag. An
+owner type can have at most 16 inline maps. These limits can change between
+kernel versions.
+
+- Map create fails with ``-EOPNOTSUPP`` on a 32-bit kernel.
+- Map create fails with ``-E2BIG`` if the value does not fit even in an empty
+  area. It fails with ``-ENOSPC`` only if the area has no room for the value
+  now, or if the owner type has 16 inline maps. The application can then
+  create the map without the flag.
+- The kernel takes the slot early in map create. So ``-ENOSPC`` can come
+  before ``-EINVAL`` for special fields or bad BTF, and before the LSM check.
+  A create that fails after that holds a slot for a short time.
+- Map create fails with ``-EINVAL`` with ``BPF_F_CLONE``, or if the value has
+  a spin lock, a kptr, a refcount or an uptr (task storage). Other special
+  fields are refused for all local storage maps. An update with ``BPF_F_LOCK``
+  fails with ``-EINVAL``.
+- An inline map needs ``CAP_BPF``, as other local storage maps do. A BPF token
+  can give it inside a user namespace. The area and the limit of 16 maps are
+  shared by the whole host, also with users of a BPF token. One such user can
+  take the full area or all 16 maps, and make new storage objects of the owner
+  type bigger for all users.
+- A syscall update copies the value in place, under the storage lock. A reader
+  that takes no lock can see a torn value, as in array maps. Without the flag,
+  an update makes a new element, so readers see the whole old or new value.
+  ``BPF_F_LOCK`` is not available (see above).
+- A delete keeps the value bytes. A value pointer that a program keeps after an
+  update or a delete stays valid and points to the same slot. It sees, and can
+  change, the next value of the same map. Without the flag, it sees the old
+  value.
+- After map free, old objects keep the tag and value bytes. Each new inline map
+  gets a new 8 byte tag, so an accidental match with old bytes is unlikely.
+- The tag is predictable. A user that can create inline maps can make another
+  map see bytes that it never wrote, in objects made before that map. Tags
+  come back after 2^32 inline maps of the owner type: a new map can then see
+  old values of a freed map. Both cases are memory safe.
+- Only the size of an object decides if it holds the slot of a map. The size is
+  set when the object is made. An object without room keeps the value in a
+  normal element. Programs must not depend on which one applies.
+- The slot of a map comes back after the map is freed, which can be later than
+  ``close()``. For a short time, a new map create can then fail with
+  ``-ENOSPC``.
+- In map-in-map, inline and normal inner maps are not interchangeable: the map
+  flags must match. The kernel's copy of the inner map template holds no
+  slot, but the map given as ``inner_map_fd`` holds one until it is freed.
+  This is also true for the template map that libbpf makes.
+- The sk storage map iterator fails with ``-EOPNOTSUPP`` for an inline map.
+  sk diag shows inline values, also in a dump of all maps.
+- As for all local storage maps, a delete in NMI context fails with
+  ``-EOPNOTSUPP``. In tracing programs, the sk storage helpers refuse hard IRQ
+  and NMI context: ``bpf_sk_storage_get()`` returns NULL and
+  ``bpf_sk_storage_delete()`` returns ``-EPERM``.
+
+Inline maps also change things for users of normal maps:
+
+- A lookup of a normal map costs a little more, also when no inline map
+  exists: it tests if the map has an inline slot.
+- While an inline map exists, every new storage object of that owner type gets
+  the inline area, also for owners that use only normal maps. The memcg of the
+  map that makes an object pays for all of it. For sockets, the object counts
+  in ``sk_omem_alloc``, so ``optmem_max`` is reached sooner.
+- An object with an inline area is freed only when its owner goes away (the
+  socket is closed and freed, the task struct is freed, the cgroup is freed or
+  the inode is evicted), after an RCU tasks trace grace period. Until then it
+  stays charged, also after all its values are deleted and all inline maps are
+  freed.
+
+A new version of an inline map that is created while the old one exists gets a
+different slot. It can be after the old one, and then new objects become bigger.
+To keep one slot across restarts of an application, pin the map and reuse it
+with ``bpf_map__reuse_fd()``.
+
+A libbpf skeleton cannot run ``bpf_object__load()`` again after a failure. To
+fall back:
+
+1. Open the skeleton, add ``BPF_F_INLINE_VALUE`` to the map flags, and load
+   it. ``bpf_map__set_map_flags()`` replaces all flags, so keep the others::
+
+     bpf_map__set_map_flags(map, bpf_map__map_flags(map) | BPF_F_INLINE_VALUE);
+
+2. If the load fails with ``-ENOSPC``, ``-E2BIG``, ``-EOPNOTSUPP``, or
+   ``-EINVAL`` (a kernel without the flag), destroy the skeleton, open it
+   again, and load it without the flag. A kernel with the flag also gives
+   ``-EINVAL`` for the cases above that inline maps do not allow.
+
+A map with ``LIBBPF_PIN_BY_NAME`` does not mix with this fallback: libbpf
+reuses a pinned map only if its ``map_flags`` match the map definition.
+
 Examples
 ========
 

-- 
2.53.1-Meta

