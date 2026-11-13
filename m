Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611334;
	b=ME9QC3kiXQYP3AFUE+1PHAeynhCq9RIFf4G/wOQqf2RUAXDeUzO7/RPAM+HobojcpoV4
	 u3dN+3jToyNv7eg66KTWUi2CzkFiugxDB0B1AKxqKyq7Wg8KcbuQ+x/JmuUIvWfNo400V
	 vjq26vB+yiwXZpgE2O7cP9yRX0/X0KHp4UtAwle4KikORJ6RIV+jmz5UfsnD8JhSDT+d3
	 cDZFJM1bO5B51brePjT5l9cGhdpvCJsj/6UWxpG593YfvkXFIAgt1+5mMS4n3IVo2e43D
	 4oHves0rHlp1bk0tutIn4DeHj5i0NKYk9o25YNf4o/dpnzow4wpqCeg6pz8Fy7r8RvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
	b=m62JhIUzYde8vlZ6i7iaVPBBPGEtsf5zUnWm93NDZ97umHfJtk4badrJaFXevn+xTMky
	 g4nK2YNi8cip0aHnMxooRgivORCj1Lw3ZQS1ZIMX4ioXLS9QGJqUKwkDWoxnrWN+YSiJu
	 7zIEIRpVThaVbwVUJYLl2zxqEtKX6JxrqpjbC1FRN0wTeUbbZi09RuqvZw1PWEnrY6Hch
	 8Q3kV03juC3himC+W4wMJto9fyDKeP+1axEhSasWJ3L9lGrxcZKTfY2dlR60UclWJ+eoL
	 3P6peUJaEeWwpGCVNDBfEUXZ8EhMWBYB5COkx291bo/UdIoq2hlcGV+tMYyRLjHm7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JeeJAp5O;
	arc=none smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC1C606A33F
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC1C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JeeJAp5O
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67c24619b19so1177449d50.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611331; x=1795216131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
        b=JeeJAp5OA9s7hU3mUUq3L29uh+/POhfqMRlJnB8ocZZtBf97C49Ia/EW8PcbiJFTWz
         IE0AVTsZP8bsI6tBUltj7LrY+DnrDqhaeHS/9hZg1UXg1cFET5lLE8dT1B86Y1HBfCRz
         x1KGQz/4LG5gzHuOaNruN2fln4f5va53KcfpLLsjq35Nf2VejhsBBvqje/oqaUkAsmpW
         qS4Ax68mCM+jfn3+h1KPhYChRGyVz8RHY0T4v/xLaTtp9rsgboJB2not7YFVWRgql3/w
         rLZZ0SkgDzTNiDtnS0DtoaCjbQJf4gguktO96oX317hCjqgtCHib55L/FuM17/+jz8US
         qvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611331; x=1795216131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gg4z8zGYPV+aYRQRgAT4Ld8Ry8+v6ja8hMnQq1tbnmg=;
        b=2bNN/+hquVPZAoiBGp82UUyaKxOUD6vK3spMN28VXGsOydJtvjMJg5HOOK6BPnt3O6
         GA1ulNaRA25xsDm4Ql4tWfTnenh+LSn3/pyk4OKnJlweLeZs901zU+Mr59pgs9dkJSgS
         XLMVxkdKjjv78rHWue2Bnq1VdEJxsImxg4QSzFpG5WXrHZnOyJ0tZhdCTjYysUa/qnFr
         iALT1kP+KHJwhlk+NNNrN5AKHuyjJdud26EpiE8fF5EGpg3EuMNKIvfYbLuq+ynhXoTc
         OeK4/obkb0PTOr2JCZguWfCYgpdK3Zax85A1brpaL4GHXReXfFOuOl9PrI9xKFtKDfg0
         tMQQ==
X-Gm-Message-State: APuU4Z/GsWmpUJ+hsXZJzmxXwl682x1uZoVYsUlfA5nKRIwk6B8nIFHN
	oYvt/cxix6wMFtqqSqGo0NcxXxjJKHP9S+ZgUeryfZGaU+6+ENDUC+H1QIV0gBxG
X-Gm-Gg: AYBFou15BuDlPJQY/qVVI3ef/j32tvU2/XIaq2U0joWIaPpz8GUm4ah+1C1YQ+rJCQD
	ETrDhY/30cosPOpGcM0MgD+nPR7bR+PKPB6DDFEJI7txoE27WkhTFLqXH4rhExXC9u1M41BepPn
	u298AH0R8gYw6AleKQv5Z6FQnQ3uy/waBG4MVnj2nGi1MhFjI7kipuLm1/E2Q9M9/MuWS/9f620
	6lTWZW/HsokGAGuafFHI2kgzvIskwMiPAiEs3A6++WphbXbrVMwXgjO2gdnLM1TjoWNt8AO7CBq
	VpAsGWANOZuHBA89JopBuI3WWIxnqbODfAn53k4mo+NycEwtAiA2DT6tAY8nq/DZu8OtqQfLITM
	kWYUK6rGtgiE3EYPnuk4eToYTvqpJAVv/987flYQO11TBVLMvYpwWjSsP8TPZehsrS1BDEcvW2h
	v2+EIO9mAFT57q6mIpMGf9wtWSHUbSWpybSFYEG1gW2pT7s40DvvOoSU89ZUXkxII3mYotSZl79
	YI2+S4OuPX9KqB6Gl+nCp8LgXr9OcWr7sKuHnP7u+iDRCCEIKpjmHZq+2OScO44KzMx0rIAitRA
	zUhE6A5EivxDzaZOn04=
X-Received: by 2002:a05:690e:1443:b0:67c:1b09:b8a3 with SMTP id 956f58d0204a3-67d895a8132mr2652246d50.28.1794611331311;
        Fri, 13 Nov 2026 15:08:51 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a5d99c4sm3364553d50.15.2026.11.13.15.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:50 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:28 -0800
Subject: [PATCH RFC bpf-next 05/13] bpf: Size new local storage objects for
 the inline area
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-5-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=1686;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=e+UdwIy4/JW7xaJWoLm2jz7ASvFB3oEou2YdnUjxn70=;
 b=d1tlmkszdh8E2CEbJpcLUCD6dTZiUxAbvGKEGjpRmyXJgnt0Kc9eq+/UEZS33THVo5MawXGBR
 DevDi+a1AygCyDj4zQ+67fySvemG+3AOPbEmV1eF1QpGXm2FGGU1Mxt
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A storage object must have room for the slots of the inline maps of its
owner type. Make a new object as big as the end of the last used slot.
The size of an object does not change after that, so the slots that an
object holds stay at fixed places.

No map can have a slot yet, so all objects keep the size of the struct.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/bpf_local_storage.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index eed6f18bf52a..072807a1245f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -525,6 +525,17 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
+/*
+ * Once an inline map exists, a new object gets an inline area up to the end
+ * of the last slot, also for other maps. Its size does not change.
+ */
+static u32 bpf_local_storage_obj_size(struct bpf_local_storage_map *smap)
+{
+	u32 end = max(READ_ONCE(smap->cache->inline_end), smap->inline_end);
+
+	return end ? kmalloc_size_roundup(end) : sizeof(struct bpf_local_storage);
+}
+
 int bpf_local_storage_alloc(void *owner,
 			    struct bpf_local_storage_map *smap,
 			    struct bpf_local_storage_elem *first_selem)
@@ -532,7 +543,7 @@ int bpf_local_storage_alloc(void *owner,
 	struct bpf_local_storage *prev_storage, *storage;
 	struct bpf_local_storage **owner_storage_ptr;
 	struct bpf_local_storage_map_bucket *b;
-	u32 size = sizeof(*storage);
+	u32 size = bpf_local_storage_obj_size(smap);
 	unsigned long flags;
 	int err;
 

-- 
2.53.1-Meta

