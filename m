Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513193;
	b=1+VZfxszgse0DAPVrWwunI2XuoT4gEUtjKR6c6WyBe92/w/m+Rnkccb21+3+mWTFBMeg
	 fEyCJyLhB8ZUrQAjrAOvfxYSSC193YWWl0w+TJ/gi3DJRzC6E3PPfNuhmFlFLHf5dmixT
	 WcIJxVNPRwiwYFyNC1SjKG/EQbduWgem+HZKZO0aNji5YsK8A7abMoYr0c/vnm6scNiPI
	 WtQx6a2i/FZcL/mT35MoR2fC5nSTYb9+9l4F6yTvJ7T+kDQH8aJBpWRdIybNxhjgpzkL1
	 kuInMEwmdnh0ABMpWSqEE0yQhEw1WthV9MJ9GhHzhQZfpqQV6cpBrX0o+EX1IarG2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
	b=o/Lk3gL8fcl91nXx29b8LqzMKMSEwws6zQkfp7J9g/kqOLCP+6XKzouFco7/NNb34cSZ
	 DJj61osmyvaV+oojGNo/2k0jg8YMzC/bRjt3nlqSsb9sg3E4ehHdcO7X8xFwzarTiiM1Q
	 2oqTvti7OwLBoNX8ehbb7OkjpItYTjk3Hm1t62GUbmGcicNqO2vR33oiefHlymYJCFUOo
	 heJYDlhkzWiRqtEJv+N5RPNjYCal5iupYqTRRfnriVvXmxb9V+ilWPrkiYkDCWPsRuOhe
	 2zz0kbfgD5lbZeTpa5IZoBvM4KD404PHevxEvKnPaVXKTPPUtkI2yMIPgpbEhc4LBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOvykWdZ;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2226606A8A4
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 19:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2226606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XOvykWdZ
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed0e2015aaso1007305ad.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513192; x=1795117992; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
        b=XOvykWdZa8akqe46XxXcrhPdSdqBzB7qNT4fuFywibfxQufgbTNScOQjj91AfQqUZw
         wmbVWY6cyWAogeH+okdshWEXjy++ULfcj4DQ9nRE1p5Q07j61mwgC5xiXku5NX3VeaJf
         jzGj5QgklpL2p6GeZi5PywWO0zN8hv5iG3w2BfhW/grvky+gs6T8hwl7wD0GeIw+r4Y7
         tbwRpUv+wXlFY11ybqJtpnPlvWZyMvMFNlu79mVZ3Nw3NAnT7oYMN1jJZ13VwHKWsX9f
         nLAZ8PU3gD+zm7kHmsHmshoT2Bb+y8BOMpYkjVVhGXHOpsv6kRL+zhP/btDwUKU1OFGz
         TxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513192; x=1795117992;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slMJ/jl0C3PRYQL80eM6Rik84HUmAPDqG/+JqwCg8f0=;
        b=fCXt0k1yR0Bs+op6E4QsbXxM71SdNdD0myccySlZf+lkSGuFAPRxoM3SU23GtOU4j4
         3LZv9a5w7FqzjN5cdnq/WbHk2PmMtryp2DcgC/q62f/288hOZNUeE7+fAoB5W3vuRmRB
         fhNz9F5heDD3Q7f3HsXh4ssgVpH91LhdxCR53E2IrqBilLh3yJysgO3aPlDOsa6WB/Jz
         zE3FXgwuDYwr06ddJeUUFNFksXC5Yk04vIi+XuJ9fPPdz+MMWFRhguaYzDtQPLaluVsN
         IM+sf6EPFqG3cDnL4/j+D/xq+VGjH+xlnxnHoXNmJtBKg+60OWGzSrlNJxu5oHTAN1h1
         Q3wA==
X-Forwarded-Encrypted: i=1; AL+hErEZnzJ/WBk1zstn2clOBnkceaTVmm1GpnllxQOV5vYHgxWY0GeIP8vEfVcxqShzLzWHoNQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kcCMNoyMJB6k50nsA+zpL+aZag2hQTrXK0R2pYYBO6leQVW47
	DaeIgP1Kcw71iVQcZ0hoWd4k6x0nhNEGFWt9F5cf6ZXTdMMgoR8xivHP
X-Gm-Gg: AYBFou15sKoE8NU3jmgZbmHnnSDTD7QmOOJqZetj/nJjWQNw0UUNdd8uvALvxmRhk2y
	Kt7kIEtGjkb1mUe0hk96ye3Vj8IG884xcu5NTGlbT9kk8ZcdaXkmGrAXysVGuVItLEzY9PTRXF7
	0tRcDwzrnq43VAl2WI+Wkd0/TQGQ8s5WiL8PSaYiH11YH8XbhyGLnR4pq/fC8lWGQFVppt1lVYy
	EOS8PbZmF+7PDGyFu5fZK3W3nFw8MiFj9MsyBc1h+PhRleRUvQNP0ENs26TrL6KZ3jfrooQuAZB
	TWI7fLw46OEcjMTbqkvY2BnUyHfs2SboE0NrKzBUbh9XB1HEGtZDl/D2qOd5sg0GQSWGxaMRk9S
	Ae/8VFnGAvluAa4QdBazrcYx2WPbfUQj03kDFikj8YK0krgAQioGeNVFKa8+t/YUJXzFwQowMRX
	YUS2EbfKQRVdiXMr6VG5jynki7Kz1wUvpS8tLeVCwv1i4HLFJxQ7U70VqXUUgUkNEFvbAzjBtMr
	TXVH8WtHGjbtDMW9D4q8g4HODMyFDtlgfJNfmENaGPkAzKSUXc9I0yHA63vvgLW/a+Pg3yKsjec
	uWSrZLlc6wsU9/1l8ahYmFyKbyO8wrTnfvvu61HhEh2Cmrpj/e+7WFWQHwtVUfcYhgPES1TjrH1
	z97YVA3LL8RsPML/b8UC9Ro1NrrosE/r0JS8=
X-Received: by 2002:a05:6a20:5491:b0:3e2:82d6:467f with SMTP id adf61e73a8af0-3f7a75bf032mr171001637.26.1794513191665;
        Thu, 12 Nov 2026 11:53:11 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2053d26sm90591b3a.36.2026.11.12.11.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:53:11 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 19:53:10 +0000
Message-Id: <DMTHU30GGMF2.1ISXFYKE43OM7@gmail.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Jakub Kicinski" <kuba@kernel.org>,
 "Quentin Monnet" <qmo@kernel.org>
Subject: Re: [PATCH] bpf: Reject offloaded maps as map-in-map inner maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261112105620.57520-1-shlomojune6@gmail.com>
References: <20261112105620.57520-1-shlomojune6@gmail.com>
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

On Thu, Nov 12, 2026 at 02:56 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> +	if (bpf_map_is_offloaded(inner_map))
> +		return ERR_PTR(-EOPNOTSUPP);
>  	if (!inner_map->ops->map_meta_equal)
>  		return ERR_PTR(-ENOTSUPP);

No need for a new check.
.map_meta_equal in the ops means that the map can be an inner map.
See the comment in struct bpf_map_ops.
Drop it from bpf_map_offload_ops. Then the next check rejects the map.

> -	if (inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {
> +	if (inner_map_meta->ops == inner_map->ops &&
> +	    inner_map_meta->ops->map_meta_equal(inner_map_meta, inner_map)) {

bpf_iter_attach_map() has the same problem. It checks map_type only:

  BPF_LINK_CREATE
    bpf_iter_attach_map()      accepts an offloaded ARRAY or HASH
  BPF_ITER_CREATE
    prepare_seq_file()
      __get_seq_info()         bpf_map_offload_ops.iter_seq_info is NULL
                               bpf_map_elem_reg_info.seq_info is NULL
      seq_info->seq_priv_size  <- NULL pointer dereference

Something like this (compile tested only):

diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 0fa3f2a..9ec3bbf 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -38,6 +38,7 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	if (!inner_map_meta)
 		return ERR_PTR(-ENOMEM);

+	inner_map_meta->ops = inner_map->ops;
 	inner_map_meta->map_type = inner_map->map_type;
 	inner_map_meta->key_size = inner_map->key_size;
 	inner_map_meta->value_size = inner_map->value_size;
@@ -65,7 +66,6 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 	}

 	/* Misc members not needed in bpf_map_meta_equal() check. */
-	inner_map_meta->ops = inner_map->ops;
 	if (inner_map->ops == &array_map_ops || inner_map->ops == &percpu_array_map_ops) {
 		struct bpf_array *inner_array_meta =
 			container_of(inner_map_meta, struct bpf_array, map);
@@ -88,8 +88,9 @@ void bpf_map_meta_free(struct bpf_map *map_meta)
 bool bpf_map_meta_equal(const struct bpf_map *meta0,
 			const struct bpf_map *meta1)
 {
-	/* No need to compare ops because it is covered by map_type */
-	return meta0->map_type == meta1->map_type &&
+	/* An offloaded map has the map_type of a host map and its own ops */
+	return meta0->ops == meta1->ops &&
+		meta0->map_type == meta1->map_type &&
 		meta0->key_size == meta1->key_size &&
 		meta0->value_size == meta1->value_size &&
 		meta0->map_flags == meta1->map_flags &&
diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
index a58c148..9e459a2 100644
--- a/kernel/bpf/map_iter.c
+++ b/kernel/bpf/map_iter.c
@@ -176,6 +176,10 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
 	    map->map_type != BPF_MAP_TYPE_RHASH)
 		goto put_map;

+	/* An offloaded map has the map_type of a host map and its own ops */
+	if (!map->ops->iter_seq_info)
+		goto put_map;
+
 	aux->map = map;
 	err = bpf_iter_map_check_prog(prog, aux);
 	if (err)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 04a3b3c..c8146db 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -112,7 +112,6 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr,
 }

 const struct bpf_map_ops bpf_map_offload_ops = {
-	.map_meta_equal = bpf_map_meta_equal,
 	.map_alloc = bpf_map_offload_map_alloc,
 	.map_free = bpf_map_offload_map_free,
 	.map_check_btf = map_check_no_btf,


Pls tag the respin as [PATCH bpf-next v2].

pw-bot: cr
