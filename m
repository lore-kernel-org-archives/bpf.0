Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006730;
	b=2OlFbOaKacy83Ht+IFM6VXfRhqgTaR9fNIoEJrcMxSB9VfQn33b9UOIFPO07WfCAL8B7
	 dh4tNBerg9QXSsJWYW9pNiR1ooYy2/qM2kdOPoTk6EVjeNjzjMSVGGwrew3gqAQUvAbQq
	 hso78rcEyeRKevNMRn2kWso4Q8BOgtpRnYRkA0aZvcJgjqBufyBupPVAfnhJ6JgZssetZ
	 lq/XAUAsseq3ywbQyLVzOvskcWtBLs2VywFsOct1r9UUG2krlykI/VNgglFwpJcdJMAcV
	 vQNSeL5tcnXRVAl1mkT5aEUFAL5v2S/sa3zC5IzDBCIEwXHikPG82JzhoYeGx4nVUIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006730;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UbpFueGBEvU53Vb7/q/PLhrOg44UG6dCmPzDN0HPnNM=;
	b=VPFEBEwVXiJpyzYdZjocStO9DfDFEjaoVMO6MyFmLSiXYG3vXGMet/r2o6zHRuw2N5fA
	 4MdBmWwCj7IMzh9jANG6GyJ8Bx3byQxcJbds2je4w2/+/rRrCsAbtSD/8IPFl6itB+MIV
	 iC/Kw5n+36s3mcGGBIUwTn4r0FG1yYgjNg4MVbLQegDCuimB5z/Plc9aKVuaO3NmU1PPA
	 9T3NTx9aw9nRQpLzCaFQWw+y9plSjPh/CVhJJ63HqSdt4zujGBJIIgqDTOqgPHp3CRoUj
	 jS+RGmXo/Qz8fV4AeIS2sDrX2/bNKKClv0GVwbMo0++/GeO4LzTM0/S6H1J7zh/yFDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CDuhJUnK;
	arc=none smtp.remote-ip=91.218.175.30
Received: from mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133F606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A133F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CDuhJUnK
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LNw6d4GW0mbl2KSWZ2jOylagT+FVNJ4ieKN77f/dhjY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006727; v=1; x=1794611527;
 b=CDuhJUnKzabU0b8UvRoJ2bk8PxK6ucEH6vA8nMw3Up+EgoywyZa+umT7uPAjrL2UK/4MCuye
 YTuG3LKinbahycxAmhqj7wwxhT0RPrurdBIrLg9/hb/6wCGiN4tCaHTPdZ5qzpnD56BtFt7wDBj
 TZLRYIp4ue4rufUIdiLs7Lgk=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id b8ac95d11857e0d1;
	Fri, 06 Nov 2026 23:12:07 +0000
X-Mizu-Trace-ID: b8ac95d11857e0d1
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/4] bpf: Scope callback arguments to their frame
Date: Fri,  6 Nov 2026 16:11:53 -0700
Message-ID: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
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

A callback-calling helper can pass its callback a pointer that is only
valid for the callback invocation, and the verifier has no way to
express that lifetime.

Two helpers need fixing:

  * bpf_user_ringbuf_drain() passes a CONST_PTR_TO_DYNPTR over a
    sample it releases as soon as the callback returns. Saving this
    pointer in callback_ctx leaves it pointing into reused kernel
    stack and allows arbitrary kernel read and write since v7.3.

  * bpf_for_each_map_elem() over an array or per-CPU array map passes
    the address of a u32 held in bpf_for_each_array_elem()'s own frame,
    leaking four bytes of kernel stack.

Give the callback frame an id and make it both the id and the
parent_id of such an argument, so that slices and clones descend from
it. Invalidate the id and its descendants when the frame is popped.

---

v2->v3:
  * Replace REF_TYPE_FRAME with a frame_id in bpf_func_state and drop
    the preparation and refactoring patches (Alexei)
  * Rebase on bpf, and add Fixes: tags
v2: https://lore.kernel.org/r/20261009202759.50520-1-ihor.solodrai@linux.dev

v1->v2:
  * Add the refactoring patches: release frame references in one scan,
    and fold diagnostics into the REF_TYPE_FRAME introduction
  * Replace temporary argument mask and deferred register scan with
    reference acquisition directly in the owning verifier state during
    callback setup (Eduard)
  * Reuse callback_park_dynptr() for the nested drain test
v1: https://lore.kernel.org/r/20260922010333.1226537-1-ihor.solodrai@linux.dev

---

Ihor Solodrai (4):
  bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
  selftests/bpf: Cover the user ringbuf callback dynptr lifetime
  bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
  selftests/bpf: Cover callback-frame map key lifetime

 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/arraymap.c                         |  19 ++-
 kernel/bpf/states.c                           |   3 +
 kernel/bpf/verifier.c                         |  16 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 135 ++++++++++++++++++
 .../bpf/progs/verifier_iterating_callbacks.c  |  91 ++++++++++++
 7 files changed, 266 insertions(+), 2 deletions(-)


base-commit: 475a0cfd02f14d764023e926ac01fc7597134229
-- 
2.56.0

