Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B54A3F08
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210167; cv=none; b=mgiU4X24giOLw56tBFSZ4k00p83qkVjGFyCTqOZSNp0mjbWvG36OGtHAdfF9skhWARfj3k1vkEGviE3SA6tlosv82JhBFaQCsSz+fITk2PUrJygNvuvAFL5xTktcO+ANxG7AaPQef4hbBZnp65kKTXJ60PaXQTD0Da06BQjeRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210167; c=relaxed/simple;
	bh=Al3Ou5xDIlDvOZsKbO404TDLybJtkzDi6cyyzqSInBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sctC0ELU5fLuWWzGy4wSesoxcgv4i+cR4tSLw2hx5+GK2l7J9GSptBc96vPS90FPBNioOZgC0VBnoNVKiYMXx/LTtDHX6fhCGFYc0lhwl3sgrjYZ+007EAzxKx0P1qv16nUp6Mj0Qz2XXZT06ik2UI/6Tt5C+znVYjfq9LIy4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOgrlhO6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOgrlhO6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso1541377f8f.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210151; x=1791814951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=USjY1SH6AnGCgxcS0SMAmMOnjMUJRvJrIX5TDxED82I=;
        b=oOgrlhO6OmJ2FIkyq+JuyZ58InA++iNOh4R1xWUoQvxdBoraPSLz4LtPE54W5EvPiD
         cALmvuDZdKLK9bMe4ygG39lMic0iDZQKfy1bOIGxMzidf+aGL6/m5HVxsfHS31YhzPLA
         3iX8J8Qg26qJu5nhMNCae/AUZcKMnWFkIbfTIEQ/7djMpYxI0ALawm2xsJArT3s3v7Q2
         RQ+LjM9T7DMiQujhz6ziQTPXYEGjkCRrUnA9v8/hT44aZSHDxTM0p0JGA5fA4dcQjczr
         YaHD9hFggF4ZMQI784CSt4ygRQ3u1NC5k+2tWbN4Srn+MXSmbQD9LRZWJdb2AhH8mNm3
         iUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210151; x=1791814951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=USjY1SH6AnGCgxcS0SMAmMOnjMUJRvJrIX5TDxED82I=;
        b=NhoRicQ77XNZufAgSFL//MBkSLIalRc5t3sO2iXTPtJ1HHFHgi2TXBI3RXwRHhwnpJ
         QvGaP207LW98C6zZU8aL1EHgrtkJf+KJQHnIQyy3F/xCf3VD0cJ3bK4HLR4zxRadFvMW
         nt0FqZ0ENX66rMjPXeUZBxa63Q4v8pPY8x3xKUpYCp1eee+1f4xe2xHG2d14nq1YXIQg
         W4nMrnKN1nta4bnZfyyuD35UA8t7hDV9J1apTpRU4Fg5in1Nloji2zej4pLf8fxLydrv
         U/KrLD6A/fGk8oN+/dLFr1h1cb28A8UbCUtziU5tg5h563JTauOtgAUP0MmPcqm0B5A1
         Mlng==
X-Gm-Message-State: AFq9FYKXyT9f8xqKs4gRNDRnSt24aO/8+38DeGdwA9f99iqzeQOkzMJs
	FR8+6/fWWNtiaHMm4i60uFo4HUsEPwqNURp5GHpoMvWOyI2OrTIHgwWqIivM0CYSKMqaZFck
X-Gm-Gg: AYBFou2dyd/QkZua1yjAMV4ZEGzeroWNP/IY5T6ZZ/KgkOMIJKvlSPw+4IYO8lFmw/q
	U7sTSlKSCG7eq/4D39KxNhDGevP0EbXnC5rvxR00T62n6bos+yr1ynNeEGctIHMMisSqu4b9TuH
	eYoLMJ26x9dvzUl/czMNb9tdh+zMYZbf+0zqMjcHIQpFquCkIWLdhfyXPHcCwI7ZD8w1wMPi6c4
	jg+m7sqsOe1K6d9AO1u3MYY1x3r2HBJFrA0Y9J80XC/xn+1mmOGbykkqyiftZ+2lAFZVcoRbYqS
	eOQwdGKnvnEmVUTZgXD6w/VfrvYZkeDJX1rlpAKNyrKvNru03wcB8qGGZ6CVvJ2BsA8hmjwi9DR
	ba8YpfdozIM5r3jXbYEsLTkwvUVd6MQ131YD2ybA+lwvAAbUXpTksEfii1ISpiC6gS//sBz5lIv
	sTytIhfAs9KEWnb6WgtdgUABP5HrIjpzCNCAi1ajOSfW3tVVdYBldtEIf4X5i4ON7bKYAWVyOfp
	bgTNygUN+88Yc39V1E4R/P1XEhk0dOcKzeDDuc/EfVH8WGjLu6QBjB9k2ABngptaWLggjvSG7gj
	EkR6e4fq/ZCFsMrYjEu4VMJaqJXWNxxqxQnrXw==
X-Received: by 2002:a05:6000:200e:b0:488:8411:1d08 with SMTP id ffacd0b85a97d-48c4801c7f9mr11471589f8f.48.1791210151219;
        Mon, 05 Oct 2026 07:22:31 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:30 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 7/7] Documentation/bpf: Describe inline kfuncs
Date: Mon,  5 Oct 2026 07:22:19 -0700
Message-ID: <20261005142219.33451-8-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section on kfuncs with a body to kfuncs.rst: how the verifier
handles their calls, where their native code comes from, and how a
kfunc set gives a kfunc a body.

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 53 ++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 73578a4c3b1fb..432e61a82aa9d 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -695,6 +695,59 @@ verified inline, so an unassigned R2 is simply passed back to the caller as
 uninitialized and only a caller that reads it fails. A stack pointer left in
 R2 is still rejected there, just as one in R0 is.
 
+2.10 Inline kfuncs
+------------------
+
+A kfunc can come with a body: a few BPF instructions that compute it from its
+arguments in R1-R5 into R0. The verifier then checks each call of the kfunc as
+its body, so it knows as much about the result as if the program had computed
+it in BPF, and the JIT puts native code in place of the call. Where the JIT has
+no native code, the body runs in place of the call. BPF programs call such
+kfuncs like any other, and arguments whose names end in ``__k`` must be known
+constants (see section 2.3.2). ``CONFIG_BPF_INSN_KFUNCS`` provides
+``bpf_rol64()``, ``bpf_select64()``, ``bpf_extract64()``, ``bpf_load_be64()``,
+``bpf_prefetch()``, ``bpf_copy16()`` and ``bpf_lea64()``.
+
+The verifier replaces each call with the body before it analyzes the program.
+Only the arguments are readable at the entry of the body, and R1-R5 are not
+readable after it, as after a call. After the analysis, a call goes back into
+the program if the JIT has native code for it, with its operands bound to the
+registers that the moves around the call copied them from or to. The body stays
+when the verifier rewrites it later, for example with speculation barriers,
+when it accesses memory other than the stack, map values, memory and packets,
+and when constant blinding is on.
+
+The native code comes from the kfunc set: an ``emit`` callback writes it for
+the architecture, such as ``rol $13`` or ``movbe 8(%rdi)`` on x86-64. Without
+``emit``, or when it has no code for the CPU, the x86-64 JIT copies the
+compiled kfunc with its registers renamed. It copies only straight-line moves,
+ALU instructions and address computations on the registers of a call, without
+division or rip-relative addressing. Native code is trusted like the rest of
+the JIT: it has to compute what the body computes, with the same memory
+accesses.
+
+A kfunc set gives bodies to some of its kfuncs::
+
+        static const struct bpf_insn rol64_body[] = { ... };
+
+        static const struct bpf_kfunc_body bodies[] = {
+                { &body_ids[0], rol64_body, ARRAY_SIZE(rol64_body), rol64_emit },
+        };
+
+        static const struct btf_kfunc_id_set kfunc_set = {
+                .set      = &kfunc_ids,
+                .bodies   = bodies,
+                .body_cnt = ARRAY_SIZE(bodies),
+        };
+
+Registration checks each body: it may use R0-R5, ALU instructions, loads and
+stores, and forward jumps that land within it, so that it ends by falling
+through its last instruction, but not the sign extension, signed division and
+byte swap of cpu v4, which not every JIT has. Each argument and the result must
+fit in one register, and the kfunc may have no kfunc flags. ``emit`` writes at
+most ``BPF_KFUNC_INLINE_MAX`` bytes. Modules give their kfuncs bodies and
+native code in the same way.
+
 .. _BPF_kfunc_lifecycle_expectations:
 
 3. kfunc lifecycle expectations
-- 
2.51.1

