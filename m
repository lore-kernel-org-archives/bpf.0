Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976392C08BC
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223490; cv=none; b=rzJnOpLU7YYc3q4jJypXhO+RDcI/m9zrJM3p6Y5K2Hf8R1ahtng32DiMChIcEwY1VUi2dkkVyOrRx03Piqj/GaBtomFLRDXxbsOk6vYbtd04fjF5BcXQMtN6A8M+ueMg4t6VuEvVqRZd6bdKFXZ5E3m17bMGqJcPcMlxEUGSRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223490; c=relaxed/simple;
	bh=LiD75WaDj/nNjJkDcjE9w7295/2dOZf6vbD32NlQZI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aYN8jBifS7Bgpo7enh7OJHYe+Mpq3Gnb//LGs9rRQjeO5xEvSt9D5vA0f5gB/ZGS82TM/ZmVEHg3Yy2CndfsMGRKD6M3TaLtoMbnpvKYyJfwWkUCMGgEGw2KM6Nv/D50K27hPgPcy6ybb8nGxaUViqq+qaJ986BfXiRe5YHUWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjOg5Smw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjOg5Smw"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8582b167f7so192774a12.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 17:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223489; x=1781828289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=EjOg5SmwXGlma9LSuW0WsqxNb4NPj2F1BL80dI2GDXBxJQ+dsBrZGwHvEzZAcWLTM/
         Jg2SsUa1HDSYXDeampATtnd8+49wUPNQk7Zcse4qMbMAxI9AgREG1BqGATJhbAX2rM7R
         eWg9aJNMJmoI/REkWSEx383KV/gZpcD9zk2YrOd/FTw0ZbJP952G6bOChHExD2CS7Csl
         VV3A/CKgnV28X5YT3nbk3vlVvXl0qkbnwPDNhv6Qh9Kz30og0U6UERZWbXVf9+rWjYl1
         ZIEvJflw3m74iPuy7qxHv4/Z0xOUBl62HnLnOx4Pl5Jfv+bQVxP5rXkQX+TLOh1ONT78
         +kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223489; x=1781828289;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUo9GSEHGqFt/lJLpzmBjgRQi1upn5qNvml1cjFSyZ0=;
        b=Se0khdV+Jt/G0xx56mMMvQNNXYlq8rttxeO0rjxk+tZsakmi9t5Fajszh1tSXPhE28
         JMiJxILf3lgWiSxKqifIUf4/xHVUrK2MXn+YdiWu01wmjQyXxEpBfVMFiLDcfapWVSPM
         p16vf8MPsSSDOLGdYjeAJ216s9aFf0CZoaKu7YVA464Bv50ln+tW629avPKchelZQ3co
         nq5jR0nTuG6VE2yrSvM3MecM4ySWUls5vbZAj5V8+Tlc7eUWIfb7PQdqj60d+a53ywY7
         B8TsbhG/XvW3iInQ8cFNRs6ykUALcjla9E4fmrF02h2UiB0qjUrWB7W1xQjbWJ6pRNTj
         3CMw==
X-Forwarded-Encrypted: i=1; AFNElJ9e82oRywwARGaVzGFl+JAEW7/D40NlSW6N0WPJ5Z/Afa3bk85UVaKOf60ouFAm/Akok6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5efXef8bGK/rYtpSOsC7sTx0lI48CnS0NXQ2UyzZd79IVuKnB
	izf8+m9XRQRhzYbsbx8vCxqBsIQAVixe83YaqEbYESbrRQl3vvzpakO5gd+PqoUxab6wPbuJs3S
	QEdL8+A==
X-Received: from pgbct10.prod.google.com ([2002:a05:6a02:210a:b0:c76:651e:6d72])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:210f:b0:3b3:1a00:1f4a
 with SMTP id adf61e73a8af0-3b7840857c4mr629804637.43.1781223488593; Thu, 11
 Jun 2026 17:18:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:33 +0000
In-Reply-To: <20260612001803.23341-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-3-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 2/5] bpf: Rename bpf_kfunc_set_tcp_reqsk to bpf_kfunc_set_sched_cls.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently bpf_kfunc_set_tcp_reqsk is registered for
BPF_PROG_TYPE_SCHED_CLS.

We will add more kfuncs there, but the name is too specific.

Let's rename it to bpf_kfunc_set_sched_cls.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 80439767e0ee..acdc66aa4f27 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12498,9 +12498,9 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_addr)
 BTF_ID_FLAGS(func, bpf_sock_addr_set_sun_path)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
-BTF_KFUNCS_START(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
-BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
+BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
@@ -12526,9 +12526,9 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_addr = {
 	.set = &bpf_kfunc_check_set_sock_addr,
 };
 
-static const struct btf_kfunc_id_set bpf_kfunc_set_tcp_reqsk = {
+static const struct btf_kfunc_id_set bpf_kfunc_set_sched_cls = {
 	.owner = THIS_MODULE,
-	.set = &bpf_kfunc_check_set_tcp_reqsk,
+	.set = &bpf_kfunc_check_set_sched_cls,
 };
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
@@ -12556,7 +12556,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
-	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_sched_cls);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.54.0.1136.gdb2ca164c4-goog

