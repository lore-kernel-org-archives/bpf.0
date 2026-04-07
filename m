Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6D38911C
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592177; cv=none; b=IkgmPJpD+ibJaJwVnlHTYBb970w39ELOJSSLyL0CVX6kUBBOBLh7ZzjjOdb6Ip7U8bsa42Vju4bUgiLpmJjiOCVAZ5AU9ndbZvxfahIzQFoqgxeYi69v/in0y7l0tW4CRJiGq97xdrNMah+Sxxfj/S/DjZIAiQlqaYF5iSH+c80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592177; c=relaxed/simple;
	bh=CmtKHOc332qKALJYWCWgXBnvrRYVAERnFXRVui+qI44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLPho7HlTvKGO4fQuqI00PWyRHMgYDZiG5eDcAD82pHer5oU3abxW8i1kEPbOcGVh11EFDNPFnmCVWMxS1xH4sCZFjYAhPvnRSjToqauz6ISvPgi+csBh2cPOgCnRRKkkGR1BaqR1PJ09/pdUpVnvr7CeKqDI5PciU+l+k2X+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvRx75UH; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvRx75UH"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64fc6b21789so4075047d50.3
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592175; x=1776196975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMKVwFWhx9p/bEmXNWYwd3ePZhFhwvaKwwQ8qBoxvaM=;
        b=OvRx75UHfpBZZXZyBICCoXtAnF6tUkJpi66vOk/+BVVg27EvOn7C6o/cFjxwtCV9jV
         91mNr3r8xmZns5taDG/hxzbLqACblWgu/FSx0tpVSFdGUYGZONAB4NFexRUYMFFcs12C
         TDsFZWvMD/+T+cU6wMrw9I5l7PZoeAI2zo/ReJwE4ZLBcH1pOpe7+C01CGmn104blOk7
         e/sLsPhXtGIkFFnVi3JTnrtonZ3DDke6QwPMiqZ83asCCjpvkLtKCX5WbPXYhA6zNdCS
         9A82DqkuQgRV5tgeB582j+AbwPJKRg13dDIHEM7IciVSm3oZYCcNFs2yG8+8Pfcczn0l
         9keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592175; x=1776196975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cMKVwFWhx9p/bEmXNWYwd3ePZhFhwvaKwwQ8qBoxvaM=;
        b=Mp331iJcKNC/3q5OAed1zyNedu/4XSIUkEwNvtwpVXxpb6PuPYiIXzB1Im4e2TC1Cw
         ntlnJRYCBykxu54PqbLhqJCGvam+ZgsWfdRxMHmFaCWxa1HJ+T+Aa7i55VmQYcrUGFNv
         jjQVz8Ng6VRNKPzjjwdxjSxcEW7FT5gQFjc9PSrlIK8yNvVDFRW9UkKnU70d5/37d77O
         lmQ3yS/H/FoZR6IyMkWnBEZmGkHcn9veep80Qz2WJksj+7wSJzPyhKp4enwZJMSlM897
         lYNb4qUtCnXGmQj1JxL1khQF5P1kBP3SVM9NOtVSRzhtoiaqEpVXWXYqcvhRzzEcmEyi
         6B8g==
X-Forwarded-Encrypted: i=1; AJvYcCUGF5kYTQFkdFwrbG3xBgnJa4Zruas2KtCi7P4QiaJa1XtYUiubzoS+39H1UjXsAIJBKM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7RBJofcPyRBqkC4rHnnemLrT3xKbWK/i56FnXJDdfEAKUTKj4
	kjcpn2EQuVAqh8IoVSPAy7L7bt2In5XUbRv6tMuVBVistV+YbX5yCDgs
X-Gm-Gg: AeBDievKo+n3tVrs3V3XFInl+Iw7ooFO/G4aChvLPN/S8r+hMgccHzy/jViOO2r/EjF
	nYONU6SP5SaqJyLtrGMYp1RTv+FZrMxEZbnWiD8fZ9llDg+0eK6YM9K5DAh9f2aqRu18dmfmlF/
	RwbVKlOFnkqRYbo1DjliNvhpSs2ND1igAjJB9L6sQ4Pi2qaY4NaBqbG8m7ZYpIS43o7XjwDjosB
	ovBpjsTsLInbvf1Vbh6ZyJCJrh1UaZ85iHysI2DRkjXHlIDrYMwlAZ5lp/w+lO0sQDOlK8iLAMb
	WULkiMLLfNvJTYeYl78PNDkuWS86Qu0aEA5YHXCffucK22ycD+q9bvyDNIBweiL9NK+JJH+X+1p
	oFVvVN9Av1Z8yR3UCgr1GvRjwKfhrnxfOk8O0riqt5hDij0kSswj34DJ9JpCxgy3gCmsi3RoLzU
	Is02nDHrBLpjq9fDvNnMU+0v4FboiFtfhzkSxYOAg6eVNAIkEIgrt9i7ePH3xSWTP83p1GghPv
X-Received: by 2002:a53:c709:0:b0:650:4a4:e0fe with SMTP id 956f58d0204a3-650488904fbmr12715781d50.66.1775592174870;
        Tue, 07 Apr 2026 13:02:54 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:54 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 19/20] bpf: Document BPF_MAP_TYPE_LANDLOCK_RULESET
Date: Tue,  7 Apr 2026 16:01:41 -0400
Message-ID: <20260407200157.3874806-20-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the BPF_MAP_TYPE_LANDLOCK_RULESET map type and explain the
kfuncs it is associated with.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/bpf/map_landlock_ruleset.rst | 181 +++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 Documentation/bpf/map_landlock_ruleset.rst

diff --git a/Documentation/bpf/map_landlock_ruleset.rst b/Documentation/bpf/map_landlock_ruleset.rst
new file mode 100644
index 000000000000..90f3141a829b
--- /dev/null
+++ b/Documentation/bpf/map_landlock_ruleset.rst
@@ -0,0 +1,181 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+==============================
+BPF_MAP_TYPE_LANDLOCK_RULESET
+==============================
+
+``BPF_MAP_TYPE_LANDLOCK_RULESET`` is a specialized, array-backed map for
+holding references to Landlock rulesets that were created from userspace.
+It is meant to bridge BPF LSM policy selection with Landlock policy
+enforcement: userspace creates a normal Landlock ruleset, inserts its file
+descriptor into the map, and a BPF LSM program later looks up that ruleset and
+applies it with a Landlock kfunc during ``execve()`` preparation.
+
+BPF programs cannot create, inspect, or modify Landlock policy through this
+map.  The looked-up object is exposed only as an opaque
+``struct bpf_landlock_ruleset`` reference.
+
+The map uses ``__u32`` keys as array indexes and stores one ruleset reference
+per slot.  Like other array maps, its size is fixed at creation time and its
+elements are preallocated.
+
+Usage
+=====
+
+Kernel BPF
+----------
+
+.. note::
+   This map type is only supported for BPF LSM programs.  In practice, it is
+   useful for sleepable BPF LSM programs attached to
+   ``bprm_creds_for_exec`` or ``bprm_creds_from_file``, because those are the
+   hooks where the associated Landlock kfuncs are available.
+
+bpf_map_lookup_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   void *bpf_map_lookup_elem(struct bpf_map *map, const void *key)
+
+Lookup returns a trusted pointer to an opaque ``struct bpf_landlock_ruleset``.
+The verifier treats the result as a referenced BTF object, not as a pointer to
+the raw ``__u32`` map value declared in the map definition.
+
+Each successful lookup acquires a ruleset reference.  The BPF program must
+release that reference with ``bpf_landlock_put_ruleset()`` on all paths after
+the lookup succeeds.
+
+The returned pointer is intended to be passed to
+``bpf_landlock_restrict_binprm()``.  It is opaque and cannot be dereferenced
+or inspected from BPF.
+
+bpf_map_delete_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   long bpf_map_delete_elem(struct bpf_map *map, const void *key)
+
+Delete removes the ruleset reference stored in the selected slot and drops the
+map's own reference to that ruleset.
+
+Landlock kfuncs
+---------------
+
+The map contains objects designed to work with the following Landlock kfuncs:
+
+.. code-block:: c
+
+   void bpf_landlock_put_ruleset(const struct bpf_landlock_ruleset *ruleset)
+
+.. code-block:: c
+
+   int bpf_landlock_restrict_binprm(struct linux_binprm *bprm,
+                                    const struct bpf_landlock_ruleset *ruleset,
+                                    __u32 flags)
+
+``bpf_landlock_restrict_binprm()`` applies the looked-up ruleset to the new
+program credentials that are being prepared for ``execve()``.  The ``flags``
+argument uses the same Landlock restriction flags as
+``landlock_restrict_self()``, including ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS``.
+When this flag is used from BPF, ``no_new_privs`` is staged through the exec
+context and committed only after exec reaches point-of-no-return.  This avoids
+side effects on failed executions or ``AT_EXECVE_CHECK`` while ensuring that
+the resulting task cannot gain more privileges through later exec transitions.
+
+Userspace
+---------
+
+bpf_map_update_elem()
+~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: c
+
+   int bpf_map_update_elem(int fd, const void *key, const void *value, __u64 flags)
+
+Userspace populates the map by writing a Landlock ruleset file descriptor into
+the selected slot.  The map uses FD-array update semantics:
+
+- ``key`` points to a ``__u32`` array index.
+- ``value`` points to a ``__u32`` containing the ruleset file descriptor.
+- ``flags`` must be ``BPF_ANY``.
+
+The supplied file descriptor must refer to a valid Landlock ruleset.
+
+Userspace lookup of map contents is not supported for this map type.
+
+Example
+=======
+
+Kernel BPF
+----------
+
+The following snippet shows a sleepable BPF LSM program that looks up a
+ruleset, applies it during exec credential preparation, and releases the
+lookup reference.
+
+.. code-block:: c
+
+   struct {
+           __uint(type, BPF_MAP_TYPE_LANDLOCK_RULESET);
+           __uint(max_entries, 1);
+           __type(key, __u32);
+           __type(value, __u32);
+   } ruleset_map SEC(".maps");
+
+   SEC("lsm.s/bprm_creds_for_exec")
+   int BPF_PROG(apply_ruleset, struct linux_binprm *bprm)
+   {
+           const struct bpf_landlock_ruleset *ruleset;
+           __u32 key = 0;
+
+           ruleset = bpf_map_lookup_elem(&ruleset_map, &key);
+           if (!ruleset)
+                   return 0;
+
+           bpf_landlock_restrict_binprm(
+                   bprm, ruleset, LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS);
+           bpf_landlock_put_ruleset(ruleset);
+           return 0;
+   }
+
+Userspace
+---------
+
+The following snippet shows how to insert a previously created Landlock
+ruleset into the map.
+
+.. code-block:: c
+
+   int populate_ruleset_map(int map_fd, int ruleset_fd)
+   {
+           __u32 key = 0;
+           __u32 value = ruleset_fd;
+
+           return bpf_map_update_elem(map_fd, &key, &value, BPF_ANY);
+   }
+
+Semantics
+=========
+
+- Map creation requires ``CONFIG_SECURITY_LANDLOCK``.  Otherwise,
+  ``BPF_MAP_CREATE`` for this type fails with ``-EOPNOTSUPP``.
+- Map definitions use ``sizeof(__u32)`` for both keys and values because
+  userspace writes ruleset file descriptors into the map.
+- From BPF, only ``bpf_map_lookup_elem()`` and ``bpf_map_delete_elem()`` are
+  supported for this map type.
+- From userspace, insertion is done with ``bpf_map_update_elem()`` using a
+  Landlock ruleset FD.
+- The looked-up value is an opaque, trusted BTF object reference, so BPF must
+  treat it as a handle and release it with ``bpf_landlock_put_ruleset()``.
+- ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` on the BPF path pins the resulting
+   task with ``no_new_privs`` after exec is committed.  When used from
+   ``bprm_creds_from_file``, this does not retroactively suppress privilege gain
+   for the current exec transition itself.
+- If Landlock support is disabled in the running kernel, programs using the
+  associated Landlock kfuncs may still load, but the kfunc call returns
+  ``-EOPNOTSUPP`` at runtime.
+
+See ``tools/testing/selftests/bpf/progs/landlock_kfuncs.c`` for a complete
+example.
-- 
2.53.0

