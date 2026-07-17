Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE3175A60
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784323792; cv=none; b=uS7powyF2fU+PuWLFYMBdPZhdlb0ZpmfMYXS7ULihwpWlptTADn9kAwNastgdCPoZxHuQcoDgEbDbhSciR0xcVsyDx5e0G9UM+erJUWyZOaQN1cLgopeIDqLtsDaajxT4mBmFuKgxC2MtjBygyyhQDPWyTMHXRi6S1gdZOJ0q7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784323792; c=relaxed/simple;
	bh=RRLtR05HNO2eA17V+2WFivh4U+/1LOnvCIY75vZfKTw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=dH5YWYVXwcQxfqGT/dlVlqKQCXL6Sgmg6pNex5IKiSx3EZZKRs/JSNxytHk7xmzp/2nZCAoloKL6QwoCWhV0JvF5gTj0KGZbJ7CNyJ0k9wMuJsqXG8h4adN+o1mJnFQgMTVZyEi72M2P7tCF/G6Bda6G6uLiI0/yYfIjPjUXd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ZckQouxQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ZckQouxQ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so4835509a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784323785; x=1784928585; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQDBUUIw0bVYgL4afo7WU2+Ju65SJHJpkDkSaUZ9qZY=;
        b=ZckQouxQCFJMAhrHhX1SI8d2PnWUtgtR5zCiNzubnwKQg427u++0fUmpQO3uAIM5su
         26NIBwaawn0tHhRz8WF1Wkcbi4bWqrEft6UJtTUDUayPOxP3ug1purxOGL5b4E7bZTk3
         LjYjvJ2qU9fsf0HazDoPeScmssRKkA2V4w8p9f3VhIuwRSlReBRVKAAZCDxDbv1Q9MHR
         13RT82vyctWfjsm6HN+QaHFCN3huK3juu7jUQ4C8a2Stzy2qw1CabP+Y5eoOFcJR5UVT
         wdb/mtjyaAU7TGIbP9y01P6UBTHqzWdw9Zlt3dQiP7DrXp3NyQHyvRJjhXfwGf+hVl6i
         8eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784323785; x=1784928585;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQDBUUIw0bVYgL4afo7WU2+Ju65SJHJpkDkSaUZ9qZY=;
        b=XQOND1bAuEkfmXu3RtRI2fobQhqKYi567nFye6hSkxSoZtt+OROc+pQlkRDBTTb5c0
         jwIxNwwG5hlqwnVyu45ibKeL90eAo8V5TgpLhpjP7bJ6tt7+1+9/ncLdAqEgQlws/P+8
         AvaqA6d5rjxFY5N5Ai4epqY0aWlKFguWJoIhVBd06s/RI3B1+7JjGr9zgszxKZrQDUWo
         B0wMc/8rhktOb0rAHuqJq0yElYmO8YCnmaCVmG2WcwmDbYBCjDOkK38mgMY/nmzb3P6Z
         wIYGUpCOuOEVQuRdRxe3kkJBtqlP6nqyyQOhJp8itmtRK67TVUskT5TXyH2dkQGzE/H7
         8Z1w==
X-Forwarded-Encrypted: i=1; AHgh+Rr3mGmtDPWUARfWFGvn31NVU6wIj8ok1SF0LBzPAUvFCTm6IDoH+bltlQUEfUCIZx8PX8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyx7o40DHI5Gb8LGYQouufLqNUbQkvlJtep6eqvLkQ2HcSZx3G
	yEdKzt/czp4wSn9f/p466inxDtCmhrGfuPp02+MtE4qqbPBDOHfw2qJAqs999caVHrw=
X-Gm-Gg: AfdE7cn6+9yrUHHaaA9a5Dlye9br+kYuDYt2ZMaBi9+qNSK6fAkl/ifIu6gevMDvLkt
	ZaOipagkjMARKPZA9hNEmzwehTA+BM2QL4xsJepf+2jDay4o+44wTN4y99/1SRz+oBGNatzxgK3
	usys6L5bPik2qg6FiBcfeSp0yL4gc2F4j0ZIPpzh4Xp+RNQ5a+UAJyj+pOxki0toSDhtVttaRbO
	6wsemhsDWJ7Dx8AniS0ryuFJj8ZDThEnRY3GkenDhMW3vbI4mDaYC2YuhVwOQzNnmqpBF0pCsU0
	XZvswnhtTOdqk+cThSuyplDQ5LWERJHd3jjmk8rnUE6o0z6PXZOpIywvqOD1vq/C/pJiQ+en1TN
	pIZXk2qGJbTGOQSpmhE1znMPiHPNkzkhetl3gaGpljT/7j4JKUmBoU6wkIHPd67maP7SW+A==
X-Received: by 2002:a17:90b:2f85:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-38e4b3e0fdfmr4516542a91.7.1784323785486;
        Fri, 17 Jul 2026 14:29:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbab9sm12249333eec.15.2026.07.17.14.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 14:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 17:29:42 -0400
Message-Id: <DK15ZPPHBWGS.12AEC4957Q8NL@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "longlong yan" <yanlonglong@kylinos.cn>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libarena: use ARRAY_SIZE macro in test_rbtree.bpf.c
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260717073237.1048-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260717073237.1048-1-yanlonglong@kylinos.cn>

On Fri Jul 17, 2026 at 3:32 AM EDT, longlong yan wrote:
> The ARRAY_SIZE macro is more compact and more formal in linux source.
>
> Fixes: 6c3e8a4d4765 ("selftests/bpf: libarena: Add rbtree data structure"=
)
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

NACK, please see the exact same comment I made on the other thread
that made the same change for the ASAN buddy selftests.

pw-bot: cr

> ---
>  .../bpf/libarena/selftests/test_rbtree.bpf.c        | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.b=
pf.c b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> index 856c484a009a..2b4f519d6c4b 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_rbtree.bpf.c
> @@ -4,6 +4,9 @@
> =20
>  #include <libarena/asan.h>
>  #include <libarena/rbtree.h>
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> +#endif
> =20
>  typedef struct node_ctx __arena *node_ctx;
> =20
> @@ -275,7 +278,7 @@ clean_up_noalloc_tree(struct rbtree __arena *rbtree)
> =20
>  int insert_many(enum rbtree_alloc alloc, enum rbtree_insert_mode insert)
>  {
> -	const size_t numkeys =3D sizeof(keys) / sizeof(keys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(keys);
>  	node_ctx nodec;
>  	u64 key, value;
>  	int ret;
> @@ -373,7 +376,7 @@ __weak int test_rbtree_remove_one(void)
> =20
>  static __always_inline int remove_many_verify_all_present(struct rbtree =
__arena *rbtree)
>  {
> -	const size_t numkeys =3D sizeof(morekeys) / sizeof(morekeys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(morekeys);
>  	u64 value;
>  	int ret;
>  	int i;
> @@ -394,7 +397,7 @@ static __always_inline int remove_many_verify_all_pre=
sent(struct rbtree __arena
> =20
>  static __always_inline int remove_many_verify_remaining(struct rbtree __=
arena *rbtree)
>  {
> -	const size_t numkeys =3D sizeof(morekeys) / sizeof(morekeys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(morekeys);
>  	u64 value;
>  	int ret;
>  	int i;
> @@ -434,7 +437,7 @@ static __always_inline int remove_many_verify_remaini=
ng(struct rbtree __arena *r
> =20
>  static __noinline int remove_many_alloc(struct rbtree __arena *rbtree)
>  {
> -	const size_t numkeys =3D sizeof(morekeys) / sizeof(morekeys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(morekeys);
>  	u64 value;
>  	int ret;
>  	int i;
> @@ -482,7 +485,7 @@ static __noinline int remove_many_alloc(struct rbtree=
 __arena *rbtree)
> =20
>  static __noinline int remove_many_noalloc(struct rbtree __arena *rbtree)
>  {
> -	const size_t numkeys =3D sizeof(morekeys) / sizeof(morekeys[0]);
> +	const size_t numkeys =3D ARRAY_SIZE(morekeys);
>  	node_ctx first =3D NULL, last =3D NULL;
>  	u64 value;
>  	int ret;

