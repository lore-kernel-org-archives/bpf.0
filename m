Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943341;
	b=So31rX75wsF0WXa0VEBn5Z6HazmrsinYW+WTqfY0rlZYpapA74te36szoMJa+K/Wfi8K
	 roQcyqxxheB4O+mfD6Ehk0IZm9vxSOBBmuLW2+2jewDHqQ9f7fZH52iLW28GQgxGiys8j
	 2Pz0QZlNwp6BkKDd+8NzV9zB4iGXIhj/N76isE+zItKdLhWAfgwaznaNVyMJjK/HZXO8L
	 /DYb2bMdAJSWCf2biJEMYb2lUCf+luKMx61fdS2IuydWNGmni3qusLYMFkcvbW3SsfuTu
	 oI5BGDv82xqZanUUSjUz6k9TP6bDexzWBmXEeFKXN/PBl3WDZI0M/GhXgq1UPENmkWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943341;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=na58Fm3qQJWxjZpHDb+T2K0Z8/nj9eqBuy4fDu3CYcg=;
	b=B0WMpqiacFR/CiRI3fAcuYxaMap/5KaHc+SheynHBMwuS2eTuiFxXbN7MGfKBWZ30lBW
	 FX3ezG6w9JsvKZ/rswuNWRYWzlmXdPg7S1Qx+q7eK1JEuARknJ6ayoahJaknxUZYaIPxO
	 n8fq/3Q1iTzJLsjdCKpXjZHtGk1gE3q4ny+q0KRIgB8EQwLry7uu4J8tHLeT5zh0r6+uO
	 ZA0Qg8gfDwaULxVwXTJ/1OW833wbhYVw9G5W388UpY5c0sDgKsB+BgGhStSzuKRqMgD1f
	 FeKWfSYPU3isNI0Kw698tg3UZqcz9zhDmegE7tLCPjTLS+05hx7KLrDBgcOlU+tKyMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ig5nhA1g;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A73A606A8AF
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 19:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A73A606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ig5nhA1g
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y87R5DnrFIh3i6HvyMFMZq0wFUiBP8SOTAQOEjOaBb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794943339; v=1; x=1795548139;
 b=ig5nhA1gMCSvwK/QNQIEZWbB0R3kZzzfa1Elypb2KkMIMIZG1t95gJmuPue0lxYBfiGKvMnM
 kYdbHM6FnEyvty18ce80fqXxZjTT/zL69q/wRwgyLsObt5EGFdbBH2EjR8X56g4HVbBhIMxFBfH
 u5CcSopFm7xTSr8+6TNhkLzw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id c424a9e1da33b619;
	Tue, 17 Nov 2026 19:22:19 +0000
X-Mizu-Trace-ID: c424a9e1da33b619
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v1 4/4] docs/bpf: Describe how to change a kfunc's prototype
Date: Tue, 17 Nov 2026 12:21:53 -0700
Message-ID: <20261117192153.3384031-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
References: <20261117192153.3384031-1-ihor.solodrai@linux.dev>
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

Add a section on changing a kfunc's prototype to the kfunc lifecycle
expectations. libbpf now falls back to ___-suffixed kfuncs and
resolve_btfids rejects kfuncs that libbpf can't tell apart, so kernel
developers can keep BPF programs built against an old prototype
loading, provided they follow the rules this section describes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/kfuncs.rst | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index c7da603cab77..17043ef15da3 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -800,6 +800,89 @@ procedure is followed for removal:
 3. After the deprecation period the kfunc will be removed. At this point, BPF
    programs calling the kfunc will be rejected by the verifier.
 
+3.2 Changing a kfunc's prototype
+--------------------------------
+
+libbpf binds a kfunc by name, ignoring any ``___suffix`` in the BPF program's
+declaration, if the declared prototype is compatible with the kernel's.
+Otherwise, it looks for a kfunc named ``<name>___<anything>`` with a compatible
+prototype.
+
+Prototypes are compatible if they have the same number of parameters and the
+same kind (integer, enum, pointer, struct, union, ...) of each parameter and of
+the return value. A pointer's kind includes the kind it points to: ``int *``
+and ``struct task_struct *`` differ, ``struct file *`` and
+``struct task_struct *`` don't. Integer sizes and signedness don't matter, nor
+do the names and members of structs, unions and enums. Typedefs, ``const`` and
+``volatile`` are looked through.
+
+A change that keeps the prototype compatible, e.g. widening an integer or adding
+``const``, is done in place. Otherwise the new prototype keeps the name, and the
+old one stays available as ``<name>___v1`` (``___v2`` for the next change, and
+so on) for a deprecation period, usually as a thin wrapper registered with the
+same flags:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_foo(struct task_struct *p, u64 flags)
+	{
+		...
+	}
+
+	/* bpf_foo() before flags was added */
+	__bpf_kfunc int bpf_foo___v1(struct task_struct *p)
+	{
+		return bpf_foo(p, 0);
+	}
+
+	BTF_ID_FLAGS(func, bpf_foo, KF_RCU)
+	BTF_ID_FLAGS(func, bpf_foo___v1, KF_RCU)
+
+BPF programs built against either prototype then load:
+
+.. code-block:: c
+
+	/* built against the old prototype: binds bpf_foo___v1 */
+	extern int bpf_foo(struct task_struct *p) __ksym;
+
+	/* built against the new prototype: binds bpf_foo */
+	extern int bpf_foo(struct task_struct *p, u64 flags) __ksym;
+
+Only libbpf 1.9 and later look for ``bpf_foo___v1``. Older libbpf and light
+skeletons see only ``bpf_foo``, as after an in-place change.
+
+Two kfuncs whose names differ only in the ``___`` suffix must not have
+compatible prototypes: libbpf couldn't tell them apart, and ``resolve_btfids``
+fails the build. The one exception is an alias of ``<name>``: a kfunc with the
+identical prototype, parameter names included (BTF dedup compares them).
+
+For example, this widens an offset to 64 bits and keeps the old prototype as
+``bpf_bar___v1``:
+
+.. code-block:: c
+
+	__bpf_kfunc int bpf_bar(const struct bpf_dynptr *p, u64 offset);
+
+	/* bpf_bar() before offset was widened */
+	__bpf_kfunc int bpf_bar___v1(const struct bpf_dynptr *p, u32 offset);
+
+``resolve_btfids`` rejects it::
+
+	ERROR: resolve_btfids: kfuncs bpf_bar and bpf_bar___v1 have compatible prototypes, libbpf cannot tell them apart
+
+Widening keeps the prototype compatible, so it is done in place instead: drop
+``bpf_bar___v1``, and programs built against the old prototype bind
+``bpf_bar``.
+
+Give the new prototype a new name that doesn't start with ``<name>___`` if
+programs loaded by older libbpf or light skeletons must keep working, or if the
+prototypes are compatible but the change breaks callers, e.g. two integer
+parameters swap places.
+
+Don't rename a ``<name>___vN`` kfunc in place: BPF programs may call it by that
+name. To give its prototype to ``<name>``, keep it as an alias for a
+deprecation period.
+
 4. Core kfuncs
 ==============
 
-- 
2.56.1

