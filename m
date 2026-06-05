Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD15DDDA9
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620427; cv=none; b=XAHjZyj9PAsfxQP0/ppkf+yI6hd6Wlm3vz32Q3tUskVIPB8e96E6Kvyb4hWitX8pn9jritykSLhhSrbTbXasDDlBZBSSj+8nh6rUnHK9VPrOzWKSa9Tz0f4wcX4ByfpnkpHL860lU0ht0Flv5F5EtGd+4unCEkB6yjJerITYN54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620427; c=relaxed/simple;
	bh=3BdVln+T3EDpyTq5L0Pq9ZIQxqQoASZdjBx6RbFf9nQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kaJ+sBdU1bdNFQJk5/igRVTD2IbVCTBksAmDc/pAgst4Jr/Ii25RSJ+zN59g8p1axmCDua8qANucxmXHf9x5LGyDiorXRYxi4hImkNmz0DZRUxoo1Ic+x2ifS3Mu8Xayj15QLO8TL07Aroz5QlwvI8C0xabDd1AEUdeiTFbFybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OMYSBrOH; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OMYSBrOH"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-137dd51129bso2627453c88.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 17:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780620425; x=1781225225; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6Be14XMqwAYE4G+CQyuwu1qJ/P0hxNaVBkoYLzxPfQ=;
        b=OMYSBrOHEtywSTK+NnR5rn8pLJCH2vOlTd2bofw4PMAsBJ60gIEEOcSpczvPEIYrVo
         wCCFVmorLoj0SwPBph/9gKfiXRFnGHHvjL+PvQJu+KlJfF2sjN0GafYQ7McS+YV47HLs
         sbgAD4lv7GKQlR119p9pXngjXv/5qOTvIBXEROqW1TzZ+VsBTKX8OC5NZYJy7Aw3LWWA
         DZEaXrw9k3HpC7YrDUJXDMNFVe5OgdKZIiIqJz5flbp84CZFicEbLfyA8/18Zy4EtnEH
         4KV5FbUTghwL/ya15u2A5yUuzqTI+X/bK/0BuRZKNjCPWD7F0fYC/jtCAX6wV3iVJs0D
         UJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780620425; x=1781225225;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6Be14XMqwAYE4G+CQyuwu1qJ/P0hxNaVBkoYLzxPfQ=;
        b=fe9yMMN+GY+lWIrCaPw1lW9ROR06bzHTY9SJnMzGwLsipBAoafUs746rot+13DKawL
         r/s4ZO42iGHX433SfCVAHzcRoVNIN+O5CtMH07+bMCesP/qD1nZlP5P2DXhPizODq7R6
         j4oY2J0X8Kao8oqZG3jxlV0b7o3dhbXL+8qhXZBROQaMRLKRwc6yLUDP7ERi+lrCdsiB
         g2+WnJcOi9nx5q3vFmGHEJubnlD6Tt/TRNQox8uocmoqDlobSpswpKy1oefrG2wEqpiB
         PvaqvS1OJjE5voIkXMYKGzmP3oO/AOLOAnV+EJXo2jckZDMix6bo6szyxS8NXjZsSqTa
         0OgA==
X-Forwarded-Encrypted: i=1; AFNElJ9ORR6DTIaWf611yq2hVQSrrmph17uZQDM2hl49kalKkkjC2vHTiY5CaCn+6/56LeCf/ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfY2Hsz2gy3Iy6JpQma2FjN7+rrToTmgSNeq1T29acsHRzVJHG
	XCKZi/l/VNsVAWWORfALowMBjbWxU3qqfGQ81jeY/5tQLorJkvlzhYb1KuKuJ3qOzFU=
X-Gm-Gg: Acq92OHlLVcbA6LR2pH8ovtypDBj/n6hBBYrGyS7ITpkQRP4tOnvS1s4Y8Kr+mMeoTU
	BFDZu+RM/UK72go6FhDEWkxj8Ga8pD4e5Nr99TB4nFhoGgoyD0GT5mJBQnUUYJ8ernjzpXP5NTX
	itx2DvmYdki4H9lh+9bbil7prFOu0nSf9DBoOmqmgrtiLLVbFn+kF65+sBeGiXE5C9Tu6l7501k
	thRe59P2+nKx/QMGrW4HScBoSJQe+az/U2S3rFU4K+770bgmgz/0mFvnHUaiBW24Aw4ryKjntZD
	u0EYAGjuI2jNZXhaT/1PryM71W/G/J6KOnwjEpBYyR2zJW4LZc7pSVBDM+1ZCO7sjnkr0AfGztx
	wXtXp3P2FL8VTAWlOX8naOYG07bpnvtUC6HjFfaWmaV2s2AihjR1KOEzxHXtm/48Ujjbs98QuXd
	9emaRV46gDrSL9Y0DpXumGCmxkWA==
X-Received: by 2002:a05:7022:1a83:b0:12d:d972:b96e with SMTP id a92af1059eb24-1380670f684mr619504c88.20.1780620424873;
        Thu, 04 Jun 2026 17:47:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::39a8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm4671674c88.1.2026.06.04.17.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 17:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jun 2026 20:47:02 -0400
Message-Id: <DJ0P9DHVB5ZZ.2HEQNEZGMXUD8@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/3] selftests/bpf: libarena: Add rbtree
 data structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604235016.20856-2-emil@etsalapatis.com>
 <0a64b83a809357ae1367cd92c06ba52a92fe472d00571fdee4b7313ffb309160@mail.kernel.org>
In-Reply-To: <0a64b83a809357ae1367cd92c06ba52a92fe472d00571fdee4b7313ffb309160@mail.kernel.org>

On Thu Jun 4, 2026 at 8:38 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> new file mode 100644
>> index 000000000000..000000000000
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>
> [ ... ]
>
>> +__weak
>> +int rb_destroy(struct rbtree __arena *rbtree)
>> +{
>> +	int ret =3D 0;
>> +
>> +	arena_subprog_init();
>> +
>> +	if (rbtree->alloc =3D=3D RB_NOALLOC) {
>
> Should this check rbtree for NULL before reading rbtree->alloc?  The
> other exported entry points open with:
>
> 	if (unlikely(!rbtree))
> 		return -EINVAL;
>
> so the missing guard here looks unintentional.  The same question
> applies to rb_least() below.
>
> [ ... ]
>
>> +	while (rbtree->root && can_loop) {
>> +		ret =3D rb_remove(rbtree, rbtree->root->key);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +out:
>> +	arena_free(rbtree);
>> +	return ret;
>> +}
>
> When rb_remove() returns an error the loop breaks and falls through to
> 'out:', where arena_free(rbtree) runs unconditionally and the non-zero
> ret is returned to the caller.
>
> Can this leave the caller holding a freed rbtree?  The caller sees an
> error suggesting the destroy did not finish, but the handle is already
> freed, so any follow-up access (for example a retry of rb_destroy())
> would be a use-after-free.  The nodes still in the tree are also leaked
> on this path.
>
> Would freeing the handle only on the success path, or returning 0 once
> the handle is freed, make the contract consistent?
>
> [ ... ]
>
>> +__weak int rb_least(struct rbtree __arena *rbtree, u64 *key, u64 *value=
)
>> +{
>> +	struct rbnode __arena *least;
>> +	if (!rbtree->root)
>> +		return -ENOENT;
>
> Same NULL question as rb_destroy(): this reads rbtree->root without
> first checking rbtree, unlike the other APIs.  Should rb_least() also
> do:
>
> 	if (unlikely(!rbtree))
> 		return -EINVAL;
>
> [ ... ]
>
>> +		if (rbtree->root) {
>> +			arena_stderr("WARNING: Trying to destroy RB_NOALLOC tree "
>> +					"without removing all nodes");
>> +			return -EBUSY;
>> +		}
>
> This isn't a bug, but in review of an earlier version it was suggested
> not to split string literals across lines since it makes them harder to
> grep for, and that going over 80 or 100 columns is fine.  Could this
> warning string be kept on a single line?
>

Ack to the bot feedback (including the other two patches), the parallel
selftest is also failing on s390.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/269872=
00618

