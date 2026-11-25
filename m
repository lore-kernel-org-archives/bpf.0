Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625936;
	b=kntp5v6bN9ai2uIZIIGsZ0l/4/unX4984E8YBCTwKaqnhIyctw9vJc3lL+1EBERZuPdS
	 FnMAQTWhGd0HGDakvlagP14vXNl+S2Aa+8ruiw34FMUYeQjcEapid11N7rUFU7kCel/Iq
	 wkm56UrOSSQAzoshR2f4hS85mT7x6hSmB4IGZdXIv6PK4r6Hbf1WHSaLPGlfLTbjRY4PC
	 L2gy6Sg2Uf5RliUdU3QiVsbl7QPnNprvf7N/tYSd5eDcEaFxfxn6HS9LQ/9Py3U0N07XF
	 o2VmL/7eDrm3B7N9mjASyypPzuTeBl9nJXpZEV4dFmihlR3+BaPiL1TBhYNFqxivsDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625936;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DMELuuEYrlac3+mNiw5IS0PSIMfIwxXQsuVmu/DgyLc=;
	b=yXWR9bxDSvdCFKMBldI0IYy3T9bbnh6X+aMWTk6cy28TfBttB1HVk6bGOjqbynZyw9zo
	 f6zavhd/tSOwudl5z3xy+3aswSBrI+XcBVsmDVLHC4Bruc8mpAZ56v3tF6gPUI5BDoduH
	 iU0Jxw6iLher2sBRI/YKFHRZB2irgvH3COFhX4iVb1ddD/IUBDjpM9HF+DY0DdvlNTiDM
	 PW/4eoVpbP+lem7KkI8n07PBJVkAmiB/tzEpm4czu3WvdGGcuDN4bI6DIXb8vuV68zTF8
	 DDZDyxus9GppBncMwKuhTbrmFbvFkur199EpczJpVQqdGFofHW86Mqg4ZUF8aDER4bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+Wt1LC8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB76606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+Wt1LC8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4879E1F000C6;
	Wed, 25 Nov 2026 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625935;
	bh=DMELuuEYrlac3+mNiw5IS0PSIMfIwxXQsuVmu/DgyLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+Wt1LC8wjizbeCFk/Mb8QtA3sUcg7pE2ov32u/z7XtWCZYeTXy+Ovm3NtYx0Rjbp
	 a76sxzCG76bEONSnraYiOe7iA1VRK7WNNu/D2orfUfoGaI4UH2n34sMCtFzZ+NcNHW
	 1yrPVLpC//tPFpffLuqRzxeYwbc27zRtSJG5SB7YHDTmH/UjmSbf0MvPbLR0MmsZWC
	 UjOkRBnHHbtahI42D3s42T2UDZOBZ14aYGQPsdSIPJGSAA3GpU+WB8KvpbJCYP2F1b
	 eE5lKq9//ak/DiZAnlNUHRJymUZYJpXBPmb7h1pmI7N5/KTNRZcwaMbhgcYL/uaHMJ
	 1MyKkMHRx40+w==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	mason@kernel.org,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH v2 bpf-next 1/5] bpf: Allow loads of the low-order bytes of context slots on big-endian
Date: Wed, 25 Nov 2026 16:58:41 +0000
Message-ID: <20261125165845.45806-2-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125165845.45806-1-almagui@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org>
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

The context of LSM, struct_ops and tracing programs other than iterators
is an array of u64 slots, and arguments and return values smaller than
8 bytes are in the low-order bytes of theirs. btf_ctx_access() only
allows loads at the start of a slot: on little-endian, a load of fewer
than 8 bytes there reads the argument (truncated to the size of the
load), but on big-endian, it reads the high-order bytes instead, and the
argument can't be loaded on its own.

On big-endian, also allow loads of part of a slot that end at its end,
i.e. that read its low-order bytes. Such a load reads the same bytes as
a load of the same size at the start of the slot does on little-endian,
so the bounds the verifier assumes for it, such as the range of the
return value of LSM programs, which is kept in the 32-bit bounds of
4-byte loads, hold. Loads at other offsets within a slot stay rejected,
as these bounds wouldn't hold for them, and pointers can still only be
loaded as a whole.

Loads at the start of a slot stay allowed, so that no program that loads
today is rejected, and little-endian is unaffected. Iterators are
excluded: their context is a struct whose fields, such as the uid of
struct bpf_iter__tcp, are at the start of their 8 bytes, followed by
padding. As struct_ops programs keep the index of their member in
expected_attach_type, the program type is checked too.

This lets programs that describe their context with a struct, such as
struct bpf_func_args___<flavor>, which places such arguments at the end
of their slot on big-endian, read them there.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 kernel/bpf/btf.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c4386a9a1ad4..04f12225ec08 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7503,10 +7503,22 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	u32 nr_args, arg;
 	int i, ret;
 
+	/*
+	 * Loads start at an 8-byte boundary: the start of a u64 slot, or of a
+	 * field of an iterator's context struct. Arguments and return values
+	 * smaller than 8 bytes are in the low-order bytes of their slot, which
+	 * on big-endian are at its end, so loads ending there are allowed too,
+	 * except for iterators, whose fields are followed by padding.
+	 */
 	if (off % 8) {
-		bpf_log(log, "func '%s' offset %d is not multiple of 8\n",
-			tname, off);
-		return false;
+		bool iter = prog->type == BPF_PROG_TYPE_TRACING &&
+			    prog->expected_attach_type == BPF_TRACE_ITER;
+
+		if (!IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) || iter || off % 8 != 8 - size) {
+			bpf_log(log, "func '%s' offset %d is not multiple of 8\n",
+				tname, off);
+			return false;
+		}
 	}
 	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
-- 
2.56.0

