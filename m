Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2444779A8
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140398; cv=none; b=iNpkrHiu7+XiHtqCyV5kvxSE7RLOmeKoa9ym2zEasYWV/DnoLmwOfuQ/x6gRm+Qo0U+R45v2K6UcN4Z7Yf/D793EWkWESTKoGoNaOZAA/r3zLWokkPDoOj4tI9dZdL2zlq5qUPpy/Ur/CVH9JqN/mc+xWdcibO3+ol9ojegw580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140398; c=relaxed/simple;
	bh=XbEkPZmmxMM06mfa4GbanySLFtWRautszz5kowh13Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuKRcDatTGB+XR3n8Ya7a8n4oijnGnpnD/ZDn2pMievq5Dj6ct2ogyCLZfMRJ4xpA5KZdFWrrYVkypc0UwAey5UqP9zMuDiA3vsDjGSVaer5nJyyRGqTe4nrOqI3uecMCJilTFSoqFhMpAwXKPyTqUdvtYEedSkuu9oVDElm0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=f7KXdzwo; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="f7KXdzwo"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so1408893e87.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1772140393; x=1772745193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk5pjyiEM/wfnw6Yz5Eo6aG1OQbiuhAmToZFA1Fwx+M=;
        b=f7KXdzwoCYhxb4HBSfhQxzFSa/vMdq3Jwk8fHKtDvwiQcKcfW9B8OeqKmh5PU9YBhj
         LTv2kBRJFiMkLm3c3p0hmaUcDe4Sf4HJw2vy6QHvzEUl/QWp71Bup2ubPvaYA9jJwlNj
         qWq13Ay2L3XdnaLJHWTriF0pPEitefwV61PlHvIDM23nKbNhhMT0GEPk2TL/iSvFAJDR
         tlecEaLNtzyuRa6shIy1y364TJ5USV5uktybRf9Caxeu5COPR25mF6F//HYE8qtGqdCh
         S4F0u1Cwfy/V3fLmqjCoVLYMvH++k9dzq1EXR9THsNOIH4w8Apn/T6iqgbYxIyumNanV
         wDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772140393; x=1772745193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vk5pjyiEM/wfnw6Yz5Eo6aG1OQbiuhAmToZFA1Fwx+M=;
        b=v8u7xi97vY6keBbzKw0Zrp801C68/1gZ8nqL9kGKtH+n+9+vHhLC6Pw7u62+W3gXkQ
         zSP2T0tOPyCNWbx3bACcCXzfM2V7odDA/nN9aOS9xXOPV9aw6sMkppBPAT5QUkCKct+N
         mUUuavbeqnHmB0RM+AQ4b9SYioQfSwv02z0p37+noSveY4j3JRJ/q9mvzVmULdrtFXFu
         sb+RqkQeC9qOqD/radBYmEPkh8+rERBNQSS2LRCeml7ZoS2M8dOmIjjq9gnXtvURppoW
         sAbl/2URh3Ma6UY2m9LyinYYwFGxCWw+pJhfJbfwC83H7Z5Y19h4Vq+W3YTbaCuSbpv9
         alog==
X-Gm-Message-State: AOJu0YxXXhn0e0enqpCxAr6aqK6jQnLnXeZJ/uNHlD0yKmS3ZZnQfkfo
	TpT8dVE4jgnRTjrSY1ePOuV7w4WP9nQFK0FtgPYqJS9OzWOtXNSbqJ/bOn+zD+man5Y=
X-Gm-Gg: ATEYQzwVw8rYKdzjzQxLsUYAsZE54O2CQYdXVSdxIZ1wDOIRUI5sQuhEsr5s8FaQ6My
	W/5mJFFsvz6Sg/vUN7mZ1SLo8xLzHGY86QABdSQJ71zwPZi6uVcEicswGX9WvwzW0874HUAdx87
	30tzZzPQ9NrvI2mCqGXsqWzk7NR9OIgPdIsvL3mwrzdKAu1nRdrKEVQuvCBWottdE2IHxPIM66b
	YG3BZiAqDf3ghAd4018xIhNvc+GJdxc49ovP+/Z+096Pi4rvUMl3/1ccBMYw4wLOVvh8Chg7tb/
	a0P2bRfMDGnUQ7Wa4bSjixfGDrifSAZLhJOeuoBFdqOYQBH34JFLW0FEyTkP2tI9aVmFHlhHMqf
	+Ne3kco20WQf4VKJfenGq/wDOz6FjV1Ycz6AvSfzNFO5v/VOflZswCQfBMKxhkpSG38K1qICVx3
	lHRnxv4uNM07VrLhAswu/hz9ZrPNJv6JqqoIadDsXPtcspAQJkZ/+AoqZehoSt+p9rNs2f
X-Received: by 2002:a05:6512:230a:b0:59f:8546:203c with SMTP id 2adb3069b0e04-5a10ff991f4mr161708e87.12.1772140392639;
        Thu, 26 Feb 2026 13:13:12 -0800 (PST)
Received: from cloudflare.com (79.184.124.63.ipv4.supernova.orange.pl. [79.184.124.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a10f937896sm283750e87.11.2026.02.26.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:13:11 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 26 Feb 2026 22:12:54 +0100
Subject: [PATCH RFC bpf-next 3/5] bpf: Allow access to
 bpf_sock_ops_kern->skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-skb-local-storage-v1-3-4ca44f0dd9d1@cloudflare.com>
References: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
In-Reply-To: <20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

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
index 017071197466..378ff9dd450f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7257,6 +7257,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
 	struct file *vm_file;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern) {
+	struct sk_buff *skb;
+};
+
 static bool type_is_rcu(struct bpf_verifier_env *env,
 			struct bpf_reg_state *reg,
 			const char *field_name, u32 btf_id)
@@ -7299,6 +7303,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct bpf_sock_ops_kern));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
 					  "__safe_trusted_or_null");

-- 
2.43.0

