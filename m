Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446991;
	b=X0bA8Z+rtD1rZMKSRu8jRBR//HZRY2GPlqhipFDNeNrusi8kLafL0dt2wMEc+bZghW7K
	 6kXQJR5e9imU5fmrULY6dxxOxkRa4Nb2pwJlofly8CrTBrEz8daP1APcAA/9GkPdLGmH4
	 shf0yowPp76NtVDMATmPvigKh20ydojq7Vezq/9lMSD0mEWJSwtGSxlBn7EPVmQSFcc+q
	 pgGcjI6K+k3RudHk/74zW3Ik+wasxWxLFiLfWY2zvW/55GNlIWYt7ckjzDCF32iI6J1Rf
	 +RUJsg2962S5WC4CbJOX9WvkZAFt4B5sIkhofnde0OX0OxX2ZlGiBUdx4G2dd2y9bUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
	b=nC+TKSqNRpq17zODVua04YM3sGqhyjHt5e1u1/cOBsIYkC0L0DuxDDaduN6CJzBLe41x
	 Ce8dbPO3rcfB4snzjr1KX0hai6AlSb4I2ZGITlI4fGTNS/BJPc9d5XHjBJQH4chrd08Ka
	 wQ9wLlC5z0pFOKARsB9Cx6imnxZV6f2iRarTS6DTGv+lgzlMqP8VQ4q5Leu9SczvtsTZ+
	 KX0ytATZMPaQeaLBQIYl2GwQ44JxzR4Ofca0yQPMH7HTTtKcnea3zdL7XruJA+uHueLQD
	 vDW5fFD/FTKU0s6NZAEHY0QHWIeX0vWYBOw8vO//aOplBRYZYftqMFj4u3VQDwgiF5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFF+PYtm;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A099606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 15:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A099606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFF+PYtm
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1afdf5196so1251198eaf.2
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446989; x=1796051789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
        b=GFF+PYtmeFgQERVwRkTrjmmqYLnFV1lsQ/UeUOlLj+5Xuua3CzZfdgLuAh9LQqH/qu
         hMwR3P+nZTxBfs0Z420SDZUGTLgxd4x2dauNsEnwvJQiIyIHNFsyNCT4maY+ttLHP3FU
         R8s5OsqQTb5dDAAoYYYiSvxkJku4ssRH1PAlc9IxjOgeU1MJ5lo0jCxV1UFtTgJ36Ex6
         XU3jzw8+X27eOvRLGEVS9h6SWqiri4mDC40mRbf9vJk5bigjh9xiEjPvXR/kHrbaWIgu
         4uYnc3cwGiCNdRilwkS/ATPPKH32fG8/cvFMl2Pec/G+c05IP/CJiLXvWuBtK2OAo3RH
         OWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446989; x=1796051789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56OGEMmWAQlOQmTQkSij9JFGx49LhnAlCJdvjWWcr6M=;
        b=p98uJ/WP9YvwZ6BRoceTu68w5XOeibjV9QZTvM0EFgvTXoAkZR0biZGqgoy+8iOreE
         ibQqpEbaqmj026a9APCdi0/4AeYv3beyhKa7N/jCkLpR4EB8ebJ01AHQHSSrZ51XePc2
         /hrg7RonoBPUsRb0SQ5EEU6wXqaQuACf8V8nul3N3c5+CMuP3x3WCbQfyhOa7YDyOaMx
         XbLxyb35ZtTEAr11H9MMjeTUVd04bkM9yHYLswbElxI/n7asfyeKWDEVn88li7CheJ12
         t3727wOG4BRaaigYwijic9woMnu7snLfcVGCJu+GplfZl4VCz3y2WEdZX95kjTRnv7DL
         +FuA==
X-Gm-Message-State: APuU4Z/lSCLLEFaUMdoWjMqrJvAeVlZOyJyFJdKQ6YXCr1u9C6thRUAn
	HX4+C3kOwP1/o4PMwI+1VArNK0aTg2LSgIQ//nYD08Oj/UH7nu4sM0SM
X-Gm-Gg: AZFdTZdtqHhB+y1G7j9zXC7LNsS5JAM0YiJsfCiXVBjS0Cwj5hBz9mmEuhUYLyleJjE
	9K62JTXwysXZiwS8Jfn88xL7WkL96esAE2XxSu9HWf4snk68LxQVbwz7hS4oGHLzC++AgOLulAn
	Mw/woHFAE+o+LzE9taOqZa48v8lGBSzi2+HyJKisg1V7JcqLOKHmoI/x2nwfv33DBgJf0fkO6V0
	t6AjKw4srsJV9p71xs2GD1JnEz4oCr0vDtHHRzW9uzmy9TRjnsbthPD7zTnDNWr/ovRy+TtR/Xo
	X59aaJy83QUbv/qLGrw6+UXT2dxryBwy2feQv5f85DzUXxav+7c1rjJ3VxwG09vZJy15PhKZFWl
	JqQUAXfTe5HwdIYPFGigKCju4DHEIVLLXNrZcMTVN/JvMkOZQvAKwoo2MN1rLmQAcxBZjRt2lYv
	YlLsq+tnzd5j2HqJNPnp1uDSnPdwj6Ir7mGVf1gFc0gEozJRf7RKRSDzbWLM0V5cLAzHrsHuV4O
	g4VSA9GBHJfNGJ4nG6Lr1C7ES0oVOwHUtO5qJZVO/LWZgEL+3cWzFseXHKLZpLBqa1cv2VgElcm
	w5pPpRaz0/98IzKkNEsZFYGGTObepg==
X-Received: by 2002:a05:6808:bd4:b0:572:f8ec:533a with SMTP id 5614622812f47-57a0ba5db4fmr11848615b6e.48.1795446989465;
        Mon, 23 Nov 2026 07:16:29 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm9685210b6e.17.2026.11.23.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:16:29 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 23 Nov 2026 07:15:53 -0800
Subject: [PATCH bpf-next v2 13/13] bpf, docs: Document BPF_F_INLINE_VALUE
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
Message-Id: <20261123-sls_f1-v2-13-76474de9b052@meta.com>
References: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
In-Reply-To: <20261123-sls_f1-v2-0-76474de9b052@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795446955; l=8109;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=P06RF/RpaawtQbkge8KA7DSbH3GyTwWE+ihZk+ABnM0=;
 b=D5s1JbTPmeIvgAwtqtsMcCqyz4yLU3aKRj18wmNeWdCWEZ8O6HNFncjWoFuO8P4c3140aTKxi
 M9lEbh212ctAELmcqSEpPpm37WHPx7PdDxaHwPowmayToQsQQ5OF8g7
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

