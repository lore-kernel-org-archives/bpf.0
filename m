Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985365;
	b=sok1jsAd3/D0d8OpstUrJ4QChqfRqVwQOl95shh+GQLzcUElb4Jk4uuWEBu+CoH8RyS/
	 rV2MsFE2QuFOGDRFwZZe+2II7pzseYALi+ZUcgHco1O4nDSfeFuYaKLli0HKIO1vf4lYD
	 /j3Az7qff6Ti+55tgg/muQDU8mzlyyQtLQ2ZZ97ifYe2HPs/9hQChbdnc1WsqNBmF64Qz
	 zpXct3JdLGdeNSmMzYOCDjHHpkM1rRdep88rn1r69BoBCXdnMcvSwKhbkzFv/GitFfx4H
	 Ouas5GrSt7ZAe7roZc2t3HVbnPkTWE2Aokg2hzk/KPDXIFvWEoGUhfC+C6nlvpPGOfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=TLSVoBrjAlUm9GGFZ1hIs9R7bmqFtf8dX/hseVS3uj4=;
	b=ctFX8H1j5iZe6WN39/26+gJbeiTFgzGGlmvJ82Xle8xt9+tEHPyVdLvCfCr9p7HqSwGz
	 DkGZ6IN9EnyE327qlk9ttsUlii8D4ZpHMYGmvVclIgrkE0miGA0Ixpt1gNWSWKqY89eCL
	 2RjKZbG16hDorVC9wbfR+nPFT+IJoQyG7qXbbVBu8+IZEb4i1GtZl9nxTBhbXOdLZDiud
	 WTnKqJY8/CB5R/Zh2WbwtvvIVeG2ZPzXgTqgxuvrWmsa/AZIaC+oJ3SwoN/DrIHa56UWq
	 jSjfxZelE9ys6sS6cAzALGDwcf9G8zp67vw7lNg1AFttfBz8PKIxFoLHJmDpHEM1xKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="EJe9/3BO";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BC606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 17:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F5BC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EJe9/3BO
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e987b4a710so10253395ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985364; x=1794590164; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLSVoBrjAlUm9GGFZ1hIs9R7bmqFtf8dX/hseVS3uj4=;
        b=EJe9/3BOapdd3l5lRP+X95hCK+mkLvXUvmRA7lEEKJ3/K0ifGTS0I9pAloN9PbxIJp
         YpAyGz4xMXZU+dpJEzqd9F9HBRq1UIyDwD3EcBM6kULEVq3M2+C5++1EyYDBMk/XMfnX
         J+FBPWWBZnp1VkgTygaukvtZj9PK+NM22BZagU8BKNqUvS+J+eDJyooQPxzCz3tkK7EB
         HCWcAYCN9r0lJJRXx8AHumEHfCthRaBii2+lgZBCi+JUcBQzcfVST7GyuP3d5y1n7bI2
         NN4k4yzLe9lQKb2KAm6l2gn+cnVvy3GYObGgx+v164UqisBVl8xSsoSR1yOsA9eGuYrq
         3kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985364; x=1794590164;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLSVoBrjAlUm9GGFZ1hIs9R7bmqFtf8dX/hseVS3uj4=;
        b=z1y2MPYxVCPBUqRlUKdoQO9NyDyF75zB89wf2NsGvUE4k11ySJvkgHNOJfSEJtqA60
         HKqDtdqjjKAR4i6p9sowWHCsCinjKoEvTlwNRJrcDD0JWKduyn73dCmdhs3bqEfsBKkd
         WRpqUtqbYIQhnWowVl+HhtFKEfI7YcwTmoFB7j4d5cBhfW3C/sDbNhe3XZlqjz7ZT1bo
         xPQXsdUnqEdpM7OUH2anmV6WEjGQeCF/I5wltPx3Rx34QtUTbmSEJhQP08zBUV+YWLkl
         WPr+osFDGTzy2jNKqDVMROrHqwAq6haSx6P0iGt6UBOVV1HlGEmQ8pYBUoUEVsKhKxby
         44kA==
X-Forwarded-Encrypted: i=1; AL+hErFO2+BiwtNxcaov+Bs+GUSSQxLRr6RwbOKz8V0BrmOzTFbRPr05zQxw3Mm3gqjO6kyElg4=@vger.kernel.org
X-Gm-Message-State: APuU4Z90U+suXrK71Pco2h6fekMCUFUzNLQXXD9aBxd5TVrXTK2dhL3j
	EPylSIBfe0j992hfCCavy3AyrpejXXTpeOAYGZdyq+6+mPjeMQ+T+WJO0uvavQ==
X-Gm-Gg: AYBFou18KQHiBLOV3Cb823IJaboe5jVcbam9FCMo8SO2tKwYbGYaP2rqKlxmW6Smb/F
	HBqO2Dx50WGbGikarswjFWer3RKP3coxez8Cabg+AozqN8/XzWQ9O0/4O8bOe8S2Mry/eFMzgah
	FNGf/Wwt4wUP2ra+NYU2jxcNVE9bKQLUnisU7EMShdydht4e//n37bAyjAEpAhlmCEhz0FrxAza
	Wb3EhItCEL0II56ePmpyQ2h8kWMetnF01zjrdu4POkQzrVVZqk9uFT8g48fc9e+kP1hSCsQzrJf
	6hhdVYQXNa3vW1UTJdWhDqJMAhsk0l9A8HP2+oHsAoSfpXgMooZ4Imqzaa2XpiIaOFtbdbI75AU
	oOcxCy433sZqVGuXftLmtVgcaXKX1sN5xQGWnslsftN9HAaXV4/q6iXsSkSivd+sLzAGXw6CyVU
	1UFYBU5LKgoulXmzwh9hqLj+3mTuImOBQuHAIdv9LU93oOInUIwJbesIoAbLtY7obJUB5KglAPP
	mp1iaYtMjdRh4KSZ5Few5ipMUVtgfYJXhWhnRUso5Pb0XfQzbvSNjuAdfs8Dz6E/oxpqrxWQ3yH
	RFeppSKNod3MeybMDPQ+81BIwHnJZEsLfmZBdHy7Ux6Z5MblMudqYiumLWhQyYPTu7TgIVqpdC4
	H3XX5bNCVKSTv1MEBVUEmE7O9W/wkfCY4e+eFADVea2yXQxrQq7Zvw9A=
X-Received: by 2002:a17:90b:530c:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b0db70d32fmr1818028a91.38.1793985363431;
        Fri, 06 Nov 2026 09:16:03 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b103472903sm25817a91.4.2026.11.06.09.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:16:02 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 17:16:02 +0000
Message-Id: <DMOAQI1S0JBS.3N3WETHD2L6KQ@gmail.com>
Cc: <yatsenko@meta.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 0/8] bpf: Fix async callback use-after-free
 on map deletion
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 01:57 AM Yun Lu <luyun_611@163.com> wrote:
> Following Alexei's suggestion [2], check whether the map lookup still
> returns the value after publishing the context. For wq and timers, check
> both init and the setter, since another CPU can configure the published
> cb before init finishes its checks.

can we do the check once, in __bpf_async_set_callback() ?
Only the setter installs cb->prog and cb->callback_fn.
bpf_timer_start() and bpf_wq_start() return -EINVAL when cb->prog is NULL.
Nothing runs on a deleted element when the setter rejects it.
The three options for the place of the check:

  check in         result
  ---------------  ----------------------------------------------------
  init             another cpu sets callback_fn before the check
  init and setter  2 lookups, bpf_async_cancel_cb() for the failed init
  setter           1 lookup, an idle cb stays in the deleted element

The idle cb is like the idle ctx of task work in patch 2.
It stays until the element is reused or freed. That's the case today too.
__bpf_async_init() doesn't change.
rhash_timer keeps its check of the reused element.

The diff replaces patches 5 and 7 and most of patch 4.
bpf_map_value_is_linked() is the one from patch 2 without guard(rcu).
The diff doesn't have the reorder of cb->map = NULL and the detach.
It also lacks the -ENOENT line in the uapi doc and the rhash_timer update.

Something like this (not even compile tested):

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1151,6 +1151,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+/* Is the element that holds this value still in the map? */
+static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
+{
+	u32 idx;
+
+	return map->ops->map_lookup_elem(map, map_key_from_value(map, value, &idx)) == value;
+}
+
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
 	BPF_ASYNC_TYPE_WQ,
@@ -1544,11 +1552,25 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 				    struct bpf_prog *prog)
 {
 	struct bpf_async_cb *cb;
+	struct bpf_map *map;
 
 	cb = READ_ONCE(async->cb);
 	if (!cb)
 		return -EINVAL;
 
+	/*
+	 * The prog can still hold a value of an element that was deleted from the map.
+	 * bpf_async_cancel_and_free() is done with it and nothing stops a new callback
+	 * when the element is freed. cb is published at this point: either the lookup
+	 * doesn't find the element or bpf_async_cancel_and_free() finds cb.
+	 * Nothing runs without callback_fn. An idle cb stays in the element until the
+	 * element is reused or freed.
+	 */
+	smp_mb();
+	map = READ_ONCE(cb->map);
+	if (!map || !bpf_map_value_is_linked(map, cb->value))
+		return -ENOENT;
+
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
 
@@ -1739,9 +1761,7 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 {
 	struct bpf_async_cb *cb;
 
-	if (!READ_ONCE(async->cb))
-		return;
-
+	/* xchg() orders the unlink of the element before the read of async->cb. */
 	cb = xchg(&async->cb, NULL);
 	if (!cb)
 		return;

[...]

>  11 files changed, 1476 insertions(+), 117 deletions(-)

Way too much for selftest.
Shrink it 10x.

pw-bot: cr
