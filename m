Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996434;
	b=n/ys9zuKGZdGkkeZuiMddq20IehqDlE7E1hR5gwaNG/apQwrHhjwZhR9smQH3HBrDKFz
	 HHnvdN1iWGW6gigCCRnModKSg5G3IRa5O32Pc0Si08RtxR466rv/Efxc+P9Tqmkhpy+4X
	 Mx6rbAT70GTYiYGGiOf/pNzM/s0IB5N2BcKjrC3TIBpkxxInqt21c2awRXctgrqO3EV0a
	 PpoIqrPvjnpTy1JqQMuE1kdKI5CXVVvtlQGuHGh8zJA2ExwzLPRcmh9/wbuNu6JneBZA8
	 C05q49G6gr2hX8YF/WT2pgtnlpCKdBPK5JOUVlDWd5T9lPCezx0gNBW7PF5gQy33G1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=YfQOM+3yZTei+Ooz1YE9OkOVcf05BkF1CaiX8rMXFmc=;
	b=SMF0wENKLJiJNDe+dfmWN8P0Qg2gty7Nm2YVGPkvcjHMdmpyWVbuSeqgXSIgyeaOxMG5
	 AwRjlPTXWosO8BKQCVqpqBRZ5EwyPs04CQcIAe9Dqb9Bb9ZsL49eX3R7YrDomsI7hcwuh
	 FheqViOfkVX+x2SmjE9oWSRji18Y3rgQc/Nz0uRMteellFgt9itM8JP1S4Av5VSiadFxD
	 zaUXbybjLPtJ6E+AtRm4C2ZGZS+ZqJjnF1Ju8V0tb2xThXiPHMqLl8N8GUIYxmoCxbZ/9
	 /J2JyCvd8Ff462bROkAv1OquXHlPt9RzOqkCMfKeY81j6wzKhPEMn5cb5WmmqqJ967w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qN9y1mA1;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B26606D810
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 20:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0B26606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qN9y1mA1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a08903566dso24719b3a.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 12:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793996417; x=1794601217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfQOM+3yZTei+Ooz1YE9OkOVcf05BkF1CaiX8rMXFmc=;
        b=qN9y1mA15Y6AtsUV5niq8H1hH3LKM0ifZb9qB6TPirQ5m7uJyyLYYYHuFaU9TRNgnp
         txjU4pw0H8iYnjCmd46LQi63lPvs5mykCWNloMB1ulQkuO3BAYLW5oh3nZAWDwAFxH/U
         4OJIN+WFbns52pRqOsP4z1An3zRVj3QkQQwkmBVDOhl0kzrrP0o+wEVbEZMl9ehuLazp
         kTPYhb691x1jUmTL6kKwBH6+ni+Uib7RVTpMgxiNeFgOUc9fhoLqLRNSUDNt2Rg4roqq
         3cfVpvLEcQ9A8MoLpP9TTFQ6qkA87pnPCvQdaVC9c8EtH2kjrrMaSGP2OuFf0Ic5QXRs
         ikQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793996417; x=1794601217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfQOM+3yZTei+Ooz1YE9OkOVcf05BkF1CaiX8rMXFmc=;
        b=VMzOtv2bNgQllt7UUWzu4xPRtrA5LfXOkEIsadB0TN6OVjkeZ3BQqHFQLU4V68jd9k
         y9xjfgN4zWOQEuznq4wjKlGEEr8mGg5pUxlqQBXC1+wY0RG/zXY+O0RdX8hfg/n7xYyQ
         fDM+Bs8+NN10WWsREgNDhq4tQUiuVaNRX9UgnEYRyojq5dEU+xTxeJfCly7UkML44fb6
         2BboZhO+fh7EoVWhVkT+5h/5cFueCDk/vXrtqkhMuV7Ajh3KU9c5SIkO/PmmcmrN4DJz
         EOm6eAjBpyX3nU+kCA7gMc12OlwhFjHsLQVWvoNTn47GLbV6+dRmQ023oIUpm4DCl+zx
         oCyA==
X-Gm-Message-State: APuU4Z9RALEH0qFCiDMbpGntrltPYd5ZKGPnLBGgoYnYEhuZfL9MaNoS
	xE43bwdkgZldCuWA7SCYGPtdOSyjEzWnv277uC154pZJm53+rhrGEYgagw7Fy7vRi171DUzTzsZ
	k06IC/BosAXL6U41MtQ==
X-Received: from pgbcq10.prod.google.com ([2002:a05:6a02:408a:b0:cc9:f7f0:57fc])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9f:b0:3e2:3584:c12c with SMTP id adf61e73a8af0-3edc1c447efmr74358637.2.1793996416538;
 Fri, 06 Nov 2026 12:20:16 -0800 (PST)
Date: Fri, 06 Nov 2026 20:19:51 +0000
In-Reply-To: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106-lskel-struct-ops-v1-0-a4486ffc79cb@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20261106-lskel-struct-ops-v1-4-a4486ffc79cb@google.com>
Subject: [PATCH RFC bpf-next 4/7] libbpf: Support BPF_PROG_TYPE_STRUCT_OPS in bpf_gen__prog_load()
From: Siddharth Nayyar <sidnayyar@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Giuliano Procida <gprocida@google.com>, 
	Neill Kapron <nkapron@google.com>, "=?utf-8?q?Thi=C3=A9baud_Weksteen?=" <tweek@google.com>, 
	Maxime Ripard <mripard@kernel.org>, Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="utf-8"

For BPF_PROG_TYPE_STRUCT_OPS programs in light skeletons, load_attr's
expected_attach_type and attach_btf_id hold data blob offsets populated
at runtime by bpf_gen__init_kern_struct_ops().

Emit instructions in bpf_gen__prog_load() to copy the resolved member
index into prog_load_attr.expected_attach_type and unpack the 64-bit
(btf_obj_fd << 32) | kern_type_id value from load_attr->attach_btf_id
into prog_load_attr.attach_btf_id and prog_load_attr.attach_btf_obj_fd.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 tools/lib/bpf/gen_loader.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 6027a2762c35..aaa491463521 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -1151,6 +1151,20 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
 		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
 				      offsetof(union bpf_attr, attach_btf_obj_fd)));
 	}
+	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+		move_blob2blob(gen, attr_field(prog_load_attr, expected_attach_type), 4,
+			       load_attr->expected_attach_type);
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, load_attr->attach_btf_id));
+		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 0));
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
+						 0, 0, 0, prog_load_attr));
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
+				      offsetof(union bpf_attr, attach_btf_id)));
+		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
+		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
+				      offsetof(union bpf_attr, attach_btf_obj_fd)));
+	}
 	emit_relos(gen, insns_off);
 	/* emit PROG_LOAD command */
 	emit_sys_bpf(gen, BPF_PROG_LOAD, prog_load_attr, attr_size);

-- 
2.56.0.455.g6c5a503b38-goog

