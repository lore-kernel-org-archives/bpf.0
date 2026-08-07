Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24235C188
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072857; cv=none; b=IXz38wNu8juVJoLZFUXO881A7Sijj5nrKIuow2sPX+tYNmxMioVrwOjqR0bKp2TpAmhcJu4DaznLw1B2XRB4/Yn6HCnxgknsSm7sUC/InPK2TC+zprH6NIbHcj+gkGkyurjH6Z3+Y8EGjzEHhOMKAQXhZTKX2JaOxDd1cXC9Ldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072857; c=relaxed/simple;
	bh=FxnVfWjMMvj4hPtSznxHh5/5D3G4KF6bTqpkx/EMV60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTAxEWuX5ykqsijhigJriwXd+O57cSga28z9s+3scrFKvMcqY5cOEojOtW8UbYsZrrOVxyxXIPK5F+c27s8tZyEJ3ba/baQfrQ6y9F2NEUJiouJA44QZCxVxEjUPqDrf8MNi9l11fdmSKgMkkZ7IyKOMFtzQjgJfe16jO4Szny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CoLR7aRJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CoLR7aRJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+quTBJgUdun2q2biLIrDfhaFBVEXWE02Z1A7z9BYzI=;
	b=CoLR7aRJsQQEetp75smhnN4RdEpgpCSx2ifjeIb+fU85b59YRXqjknQ6LK7ZSA36T6Z3w0
	9/KVVaeKU8CUcwpAxp2r/rEJ+cKNociBWVFs49+ruYsbbMuU/FS7UGoEs4VUHmw0s2/wwF
	/mnEgmxtJjI8HO53mcpHzPhfbdG/ils=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/6] resolve_btfids: Deduplicate BTF after btf2btf transformations
Date: Thu,  6 Aug 2026 20:20:24 -0700
Message-ID: <20260807032029.78092-2-ihor.solodrai@linux.dev>
In-Reply-To: <20260807032029.78092-1-ihor.solodrai@linux.dev>
References: <20260807032029.78092-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

btf2btf() adds new types to the BTF: the KF_IMPLICIT_ARGS transform
synthesizes an _impl FUNC together with its FUNC_PROTO and copies of the
kfunc's decl tags. Nothing deduplicates them afterwards. pahole runs
btf__dedup() on its own output, but that happens before resolve_btfids
sees the BTF, so any type the tool itself creates is emitted as-is, even
when a structurally identical type is already present.

Call btf__dedup() at the start of finalize_btf(), so that base
distillation and the by-name sort both operate on the canonical set of
types.

On an x86_64 build with the BPF selftests config this removes 17
duplicate FUNC_PROTOs from vmlinux BTF.

The dedup call increases runtime of resolve_btfids on vmlinux by 30-40%.
The performance hit is an acceptable cost to keep kernel BTF deduped [1].

[1] https://lore.kernel.org/bpf/986e6f4e-4b51-4440-a37c-9624906d7370@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 85488935909d..5d168c2a5ff5 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -1379,6 +1379,12 @@ static int finalize_btf(struct object *obj)
 	struct btf *base_btf = obj->base_btf, *btf = obj->btf;
 	int err;
 
+	err = btf__dedup(obj->btf, NULL);
+	if (err) {
+		pr_err("FAILED to dedup BTF: %s\n", strerror(errno));
+		goto out_err;
+	}
+
 	if (obj->base_btf && obj->distill_base) {
 		err = btf__distill_base(obj->btf, &base_btf, &btf);
 		if (err) {
-- 
2.55.0

