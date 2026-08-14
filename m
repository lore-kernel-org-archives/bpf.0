Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C541A938
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695273; cv=none; b=XUQqeM3sxzJfBXfnfJVplwgF/s/sCXWx+vMYovvoyi6RJVfkwF/2PSlSlv1+58QCjR/Hb46tkaRdnQLIFOI+3b8mf7hSfBrn/ooTABkwkLmvhYv2fvO8NEDSaQhXM6jvaRww5O1TCXRZW/SZno+CkiTNnwPHZW1wDRjoGmRsUmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695273; c=relaxed/simple;
	bh=GWMIgRU7hJHE19eCMOV5fPNk6nbqQSNe9ghsyWvs5Xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LasBwv6Zl1M1OpPD5rxwmhBSz4czQwa8FVfSvxtHnJ1JgxhM+YNwWp7VQyLExNWlQwzS1LAmniaI2V8cnuOukb46NhbY3rBf77GGpLZu+NmqFsm6IHyq9NDD9BuDdqObibNRAEOgU1l+p7lkz9yzm1nOe2tT+0/0sCNMUWkUGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YDTxZYy3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YDTxZYy3"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so1087594a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1786695264; x=1787300064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LW5lsZ0VEj7q9b4aIg7tkbaMUTRMsphp7Z75hiq3gTk=;
        b=YDTxZYy3izrrDHZ8Xi+N8Sn+SWkzkON3Rb8TVMHxXzNrg4i7YVT8Jxped2AyTQABRj
         jfB7y9mNGU5HX4R2mc/+cLKV46ZYGl+W47DhqRuIys8eo5gdCTE2eEJ7HtVtvg5wrxzx
         ckeBKQ6e0YFwkxN8bmxJehqzqppOa1atLwacHDx7zj15EwN95pWeta0pS5Si9ggpxUHR
         ntaXcwpoeoamOkdguInqAJeU5VdhfR9nCEE6VfKX49AiUHzs3VZNRd84aEieVZ9jUsRW
         uOqD8SxFHqoMc+QhO12ZYDMbLA7yzu1VbOFF9YXhpcTbJBJgyKNdHgeJsdCj1IYPBxra
         P8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786695264; x=1787300064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LW5lsZ0VEj7q9b4aIg7tkbaMUTRMsphp7Z75hiq3gTk=;
        b=RkTa2+z40vj73WkrDZDlDkYTYuNaITi8vUIL00FdRvmD39oO1Wuu12JYvNBsLZjJSF
         QYpYFyTUCL7kBJWO19MlOblrXh4gYdIVYn7RGndfIQUlGwebUViKP2n2ea+I5dCA6iA5
         4qeh0dTTi9gkbU6t0g5bBQ7wLETKsKpMsBVNvTiNOI3sFxkqSK4nHDpWMlzJiFDtILeh
         CFBiQwDgUekK2NlcFTeQl2VRxlqGlIe0TnDPh64gOo1itcy4GyiF2ElMj0ofJeLzz8G6
         CAY9C0qEepvzHB9LHBY664P+2LNdKf48P4jizemsExoF2jYm94AUiZ5NkDNbynQ1/tjz
         1fyA==
X-Gm-Message-State: AOJu0Yya28VCuZzO3UX5OKgnQorbNt5+VsA4u4o7Ekx7z5ynq3yRvM6d
	VEK/jOlBsLgXRBvJTOrvhTSEURTHDQ8UzwKejsTzF3P9gLxZVLPrCsUFyTbJ2pzpODQ=
X-Gm-Gg: AR+sD11e+BXLLJO9CxqR6P94OV8ummbszF8eQXqGiBSoh/tIuud8hs+tEYkhcJUEd6H
	2spYjwJYvxb46OclxkmQo459gCIJ4v1BGnnoFnGtW4eFN1iCK0rBQ/p7FRzSBT9ofjx/L+egF2V
	nyEAu/YnrprkcCHyiIUZ4kC63GlZh3eIMKdenh5Curg9i0wEhNR5W2xHn9XVHNSGY8vpV3tQeBv
	x0ymfN8HpZ410ijtkDY6wamEt0OaULPDM92vvxDAj9rGqkjEufP73QOWOWWB3XV2c95MqS1KD9Z
	viTJhcMwvoghAViT5ZBMS3bzZr8Mjc5LGOy8DitZ1Qx6FmJFgl+K8tLM9fT8IOOWW0OpF3vrQJ3
	RG3TqXgyv5uKOuy92vdiyCGrKBRt2GqnWjxE+ExcvKvrXrw1O/33ImZPQF3VNPRRCYlyu3rZaYd
	wgF4LQNiim+cIlrymPjfUxRtbLUMrWcAk36QbNmtb36Ru84GxE5Gx4f0KkOrs0xmaatxT+GAYle
	5Vs0PwS0BtZL+u1a4ZHUkzTkPjl3NpXT5ZKLA==
X-Received: by 2002:a17:907:928c:b0:bf0:b39:dcc8 with SMTP id a640c23a62f3a-c212a1da2bamr186235466b.26.1786695264486;
        Fri, 14 Aug 2026 01:14:24 -0700 (PDT)
Received: from cloudflare.com (79.184.184.176.ipv4.supernova.orange.pl. [79.184.184.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2123787af1sm76854066b.30.2026.08.14.01.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 01:14:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 14 Aug 2026 10:14:03 +0200
Subject: [PATCH net-next 02/14] bpf: Allow access to bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-bpf-meta-inside-skb-ext-v1-2-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: b4 0.16.0

sock_ops programs receive bpf_sock_ops_kern as their kernel context, which
holds a pointer to the sk_buff being processed. Mark bpf_sock_ops_kern->skb
as BTF_TYPE_SAFE_TRUSTED_OR_NULL so that BPF programs can dereference it
and pass it to kfuncs expecting a trusted sk_buff pointer, such as
bpf_skb_storage_get().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1fab69fec478..b0ddaccf61b3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5684,6 +5684,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -5726,6 +5730,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

