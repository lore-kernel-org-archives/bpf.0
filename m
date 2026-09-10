Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39D48EC98
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048971; cv=none; b=h9akJivos5/CQXeCqBd/jpaqk9eWveOLX2GToZPSAXd7UV2Dkd7znLClUhLmriP8IO63XpJph0ZamjPDGenoo55LrqZMDaGGnEAfEHAQo0a/nXUk0PjYNgFBC46qEE01EsS0S2kxpu+ppWz0MQhY5NePmVmbeB/e0UrOY/TZalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048971; c=relaxed/simple;
	bh=VA+xo5HMXF3HI9AKxX9bXj3LlEqiK7o4hHddPGM/sGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CG1K7VXbKP9736ky5laPywJg2hEv2id9ZyJoHKV8vLLsbL9huMqU1695GSOXOA45uNJehghuRVObS9f6S1OivYLwdyfsiyfUCD9YYLzfQMHefXoJ7F8CjofML5didzkDUPJ2XfLXObRxGMqrL5tu/qRm4RMjT2J2yaluomS0XTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Sgjs40qM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Sgjs40qM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1c52d920b8so981824666b.2
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789048966; x=1789653766; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/ZJed2cQMd+5E9NqQcTt4Hj2yvngFWqtR3bx7uOQMuU=;
        b=Sgjs40qMQr64tX4L8pMdMNEd7YbvURccgMvYArjH5C705RM4f3GC7fZP2DwxVeXZja
         LgsSOlLOJ5RH3gJPeOZfRb5N/Q+dG5IqaoJruHN0CM4q4J65qZTPpIkVA2BZ59c977+s
         gZIqGCIz6Ky8TlL1ocqPtUX4BS50gBzjPqVFXveOlhAk2a3r72iwnpdv1563ybrwwyd1
         QT6O16uKzjTZwiy98L2dGFGg3fzTm/ZZkD+G750l4JD0xImOqYkbvGZiUCaPDwX1ZeII
         Gptd2FxgnufM3Yrw0CnXyEN7LBpB0G/lEyc7CKGUuZpYjBdY0BTs66f7fULb0zPcJ2CG
         e0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048966; x=1789653766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZJed2cQMd+5E9NqQcTt4Hj2yvngFWqtR3bx7uOQMuU=;
        b=DgkdeRowMyeEzTL9Gu9WLg3cFZyA10ZS34MrJWeij37a4e5mAxvrhGvM0+II2lVQIl
         5cP0fz3LF/fonGkzcGdOoEZtDBOB4RKAX/oowawLo3sblYiRL+7gxo+e4dI5Z5nAPRje
         p6V7OzWioO/OrWJRzti+uotupR52fnr288b6r/EX675vN2RIKQzpF9p1UwAewDncuWlN
         0iaRShkNGSj+rHxiaG49torBoyJ+sIB9vkxWpf7UBhpGmMdElCkaYVxjSrprSUj0rkxl
         5vHOCUjGmYMzYsg6BCMbr+EE7lfKZQs7AK+CE//iMPpBhsKIFmbKFDO0mAbT4PTm0mnK
         ewQw==
X-Gm-Message-State: AFuF++mLZ1Dro+9f0j/hgIKECHz2U1MUCSZj9CKnNR6wJJzgi5XSsftY
	Wy7q8okbT6OKUEYJCpfanu6S1hTczF/U5sCA61ZRA3xpJ27w6lH3P5Lg1DwMNJq2NcA=
X-Gm-Gg: AYBFou1r+CTmn/i0BkAXIJ3nP8Beee2RbYXRdIpNoR3Hq8QorzjqZclA5OvNPxb79h/
	e87H6DR8g6UWtJP1xN/aCnf39dlOy4Fr7G5V4JY8Bcx0gL9i8u2Y6QJCmx/A4BQoUe0qM9+TNR+
	sjqGzIhMZDZvKYYRwVvgFo7UKuKptWkwSxvrrYuhPfo2Pz1IcS9sJWRkoCMUnn1KLGLgIZNHMak
	UYffwwu/Zt5oYjn7lx3QtrR/V8YvpatP5DZmucL6sGB4I2+3R8LLJKWQoCxBVTyByya1l1nIGIF
	iVLui2Qgs/Uwq3eu3WWTqKZ/wfBpL4Ze/WYp2C0tpFWYfzb8z3+I3mtuM28C+I2MmHhg8UxRTUR
	ZRVboaxiQXhs2/uHFh6aJm8XXTS9ycApoqaoH6zdrsUzwpiojHyyHq5wNIIIDRQMmSyDMYYdI8Z
	+K1bikSWAHPlsIyr/v9lkU1asvgCVrPU3cBQwUghkUNP7gJ4DhuIDzSl5vVD9vorWZf3aZwwtat
	bnzP7/F3V+V6ueVY9nh4EEoUicGNqlpjj/iunZtTiL1htaeibmUI62X/jE=
X-Received: by 2002:a17:907:3e20:b0:c26:19de:9aea with SMTP id a640c23a62f3a-c2619dea888mr1621678866b.41.1789048965884;
        Thu, 10 Sep 2026 07:02:45 -0700 (PDT)
Received: from cloudflare.com (79.184.140.212.ipv4.supernova.orange.pl. [79.184.140.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4aa0b9sm927429266b.11.2026.09.10.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 10 Sep 2026 16:02:37 +0200
Subject: [PATCH net-next v2 02/14] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-bpf-meta-inside-skb-ext-v2-2-0b21e42180b0@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
X-Mailer: b4 0.16.0

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_dynptr_from_skb_ext().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9029cb56128f..e82e0b4dd2ce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5891,6 +5891,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5933,6 +5937,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

