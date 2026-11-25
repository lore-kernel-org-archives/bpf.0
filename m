Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577652;
	b=ku7O3nCDAWGGoLf3SeZuTlK3eGRyfcK4TaSArz2gS6YODz0sMvRJOaSGquCjnvN0uVvA
	 ozoilvuKCVKMGv2bbI+myr1ZBmB7H4isqFQ+/7T3fhGqy4MaMik/IsQVqzKChuH3bttkS
	 FsdUQP/6AKmsRAAcF4A4S5ZiOwgk680NewBuCYVPjEhvlQK2Z6Cd0kE9fB9lbjNEmXyUm
	 mHGCorbyhWSOyRG7QqR0Ei6k4s95P+oar8LNAeNxsQXvc7fZpo6jyx979T9xbUC8ShLMv
	 bIFMJSKWdPhQqNAqvPBC8t0UNYj2cW9XXnqCJVfaxyxPpGyqgkHj3+Se8dW/5NZdOhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q/kEhJQzYdmzgSi2iTVgyzPl48puBIV8d2TdKpOuGa8=;
	b=xf4hQunJgQoZMg7nIclY1T5eSYRfjOlzf+mKrxKg6nNhFn+G8QFSFX/pTjLIQu+pfcJ/
	 INIinWtvSV721JhlzifvW6j+Xrc7upLhwktKx80YUUWBsJkbGzN0sLG5pO8DhtCGajKcH
	 9fwjRbFwINk5yHIVfQraEqZP5BRYGbPtIt07TqU9R0d25qLawTgWLMp1mu6NKtyHosayL
	 xI0Hl+BNdmsrc0l+AdrFDTer37GaEJKWWfOfSoCJCewF5h9SC91j0YhG3Mwj7tP/75iiu
	 GECV+k+PJygEN3roNEmdwVwhx3Zj1JamlBMsyeHBnI9p83qiDe2dGbFAhHoXRAVFF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9vM4wy6;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AE606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C45AE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u9vM4wy6
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f046b0adc0so28951495ad.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577651; x=1796182451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/kEhJQzYdmzgSi2iTVgyzPl48puBIV8d2TdKpOuGa8=;
        b=u9vM4wy6JIvD/feTR6IziQZZzDoVwIY+ncSAf4u55g2kU41KoxZub/g/QP1fnEWyCF
         AABek/Ks39B4prQnZw9npne+0noJHCIqUqEH3cwYFskE5AfoLI5VVsR4AmwZ8gG0SscP
         74nUQB8u60sPV8u8zvyfpRTChz3togTKjUDAumnVhtBcxUfiMONKeBRPBeUJ7H0wmIlD
         ShX6lvhlHhxcprGNKdxorBVE9/W6/pcg5ZtL5ZNpBYHOJ46q5IyipCalpR9RRkb7Bnge
         JFtwgKLxsJfJEQCUGwgH8S/qB4rkn6BoNKfJ0GAFLENSO/RfnnQv1W/Vzc0cCctU7hY8
         vh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577651; x=1796182451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q/kEhJQzYdmzgSi2iTVgyzPl48puBIV8d2TdKpOuGa8=;
        b=MUt6CHnZ59sUDntKGw+3uTgVYtNgCZts3dDmeuX8NfbO6uKaGYT6BT5swqwD3ahHvY
         5EeEn1bfZUbGysdEogWD6Q28dqUAH7XQGpZS+dESKaRtI9bZHILFOcvVp4/P8HNKFzI3
         WZzRSLsBlLYqkTs1v9T5ByWlI+JYHlE+dArwdlXT1qe5FZBLfS3yMFjWjKjo2xEWDnLr
         M3LrFE9phgRcDEHd8UfHOBOp6DWkSqgAHxwPRpm00JCYLdy+MW0TfDT5xuB8JzIv9T/a
         NKBuViajuy3HSZ5EBFO4eGF0/yq5ZQITfbIjf9gGnyO9tTXCPgdtdsgftYARPX8TmEZE
         Mr2g==
X-Gm-Message-State: APuU4Z8Aq9Rsig8C59NNYqfv+sA2ETkH1scZwrhTyrSpMuCXlh2diSeD
	JE+Pt0FGd8C6OhPja/ruKCXdNy73Fg1UYus5+gWGWRIGc/hjVywcGjzDLklVdyV5
X-Gm-Gg: AZFdTZcGMyjH1bh6CHkluCtmFOHnhlgqbWSWSUUzf7FmsVPT8RUuSnLG4qqAz1rPBZ/
	MrfQ7MmWtIEIfuxgV7PSGj3IFn2GnAWeygWxLdscGw6h3T/DPirUQTPL4awX4ZWWtR36WHVQFzY
	kCyY3dY9mFRj4Tkt7rF5lXYLugkP4g2lidiCs7XOCEYi9V4D3j/4fa49G2gMCSAt6mX7hRDuSd7
	B4Gg7BJNijowAEpjKWjhpC5XLb1RGMDccBl1Z8s6k4ty8PaGzPttNlaCnepXv8EiA6fniriz67J
	4ME/ZaeCHF29IpzZVFLxLwpUubsdGJI+1JBRMVmZRzaSj/rFEJbWNmJqj6WN/3EG7zJJJ7X7FZo
	BcNiwiGrAlNAYf7y3zM9R2Y/pWgWsUqBgjeUfiHbHCUr+E0o0AHfL3AGGHueGdkuV63G0/0wmnp
	4jWjQqDKWTxrPnd2f5EXxkfVvt1I5PHGRisUNZf36ue10uo1ckmalZorDJ359BeRRPG5qkDr9P5
	CFk2/VPRqEJdSqsL9lCBDVS7A7/3m5/bl2JM/fFBzeW5Az9GqcJSt+Vc5aEsPdEJjAWfN3HzB90
	ENMAQDybheC8uVMWglqgNBv3kzbhpCzIUSwFMiJQuprb1Z5KyA1+pUm6RlmZbVpl6Nqw0sY8R7q
	Tp4ouFXvOM3SYWma7bfnzYMhs+Fz/sxaQSy0A7e6kKvZOs9GapO3NenWm8PFv4OhPgbDK5YB4bQ
	==
X-Received: by 2002:a17:902:f603:b0:2ef:e9df:2432 with SMTP id d9443c01a7336-2f03f1b4279mr156425755ad.68.1795577650984;
        Tue, 24 Nov 2026 19:34:10 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14fc8csm76223545ad.74.2026.11.24.19.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:34:10 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 46/47] libbpf: Fix struct_ops members 59-61 and optional struct_ops maps
Date: Wed, 25 Nov 2026 03:29:37 +0000
Message-ID: <20261125032938.670542-47-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

expected_attach_type of a struct_ops program is the index of the member.
For members 59, 60 and 61 it is equal to an attach type of tracing
multi, and attach_btf_obj_fd is overwritten. The load fails when the
struct is in a module. Look at the type of the program too.

Only the first map of SEC("?.struct_ops") or SEC("?.struct_ops.link") is
not created by default. The '?' is skipped in the loop over the
variables, so the next ones do not see it. They are created, and their
programs are loaded. Look at it once.

Fixes: f2aa370dfe57 ("libbpf: Add support to create tracing multi link")
Fixes: 5ad0ecbe056a ("libbpf: Struct_ops in SEC("?.struct_ops") / SEC("?.struct_ops.link")")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/libbpf.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fb8a1f07c5b6..5f54a8e6f46f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1454,6 +1454,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 	__s32 type_id, datasec_id;
 	const struct btf *btf;
 	struct bpf_map *map;
+	bool optional;
 	__u32 i;
 
 	if (shndx == -1)
@@ -1468,6 +1469,14 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		return -EINVAL;
 	}
 
+	/*
+	 * Follow same convention as for programs autoload:
+	 * SEC("?.struct_ops") means map is not created by default.
+	 */
+	optional = sec_name[0] == '?';
+	/* from now on forget there was ? in section name */
+	sec_name += optional;
+
 	datasec = btf__type_by_id(btf, datasec_id);
 	vsi = btf_var_secinfos(datasec);
 	for (i = 0; i < btf_vlen(datasec); i++, vsi++) {
@@ -1503,14 +1512,8 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 			return -ENOMEM;
 		map->btf_value_type_id = type_id;
 
-		/* Follow same convention as for programs autoload:
-		 * SEC("?.struct_ops") means map is not created by default.
-		 */
-		if (sec_name[0] == '?') {
+		if (optional)
 			map->autocreate = false;
-			/* from now on forget there was ? in section name */
-			sec_name++;
-		}
 
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
@@ -8407,7 +8410,7 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
 		opts->attach_btf_id = btf_type_id;
 	}
 
-	if (is_tracing_multi(prog->expected_attach_type)) {
+	if (prog->type == BPF_PROG_TYPE_TRACING && is_tracing_multi(prog->expected_attach_type)) {
 		int err, btf_obj_fd = 0;
 
 		err = tracing_multi_mod_fd(prog, &btf_obj_fd);
-- 
2.55.0

