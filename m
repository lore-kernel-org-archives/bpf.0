Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C13537F8
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785727595; cv=none; b=i0YludzjfbH+tC83xNq5V/BQmfjsI93g+Jmn2v7iPBhrcrxt80JdcLBJX8MslQeGMhQPBHW/wbESUh60FVlMrHYH3IHpTeZWONMyL/cN6J7ZTaq3ZEiR5l2Ro/BSHagPDbK9Z4MrxNEGgF0YjTVH4y+9ZVhstDBzXqJcLo9XxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785727595; c=relaxed/simple;
	bh=q0Iq6ZtSP2Bo6Kr/xjePCnb4yWA7JsFK+cxdHKTVT1c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=m3jccJcBs+G+IYwAJrzwjxACekQkozUG1SHfDHZI3C8KM+2vgamEIgHerzsdO+TWqGaHh1exckVEbHjSng8zCIJgH3g4GuFAeVgcdBlVQubkQclCG1A3Uq3/O06TFr9eLo+e4cC9tWNfT7Va9R28UIB/F6borzZZxvNrxZiP2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjhLtax5; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjhLtax5"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso6551315e9.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 20:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785727592; x=1786332392; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rW2m4UfJFTFczcwxnDcti6pYYCW920pNNinJvPy7q7A=;
        b=LjhLtax5AaA4c1bBb4namimn762R7jAK7CAGgejlmA68oQFADOuniBHNjWZJAtzKUr
         A+HXrP1pkfYfawcmps5wDkibEksc+OmA5uYyzhxTjgbZiaujjsbuexgtLNasSjtRVzEY
         0jeuMjlJPxJnBHK2MogYYROF2kEH/1LsyYMI4WU+VTs5JjCKyQ0yvxrpjhvsGcf8fVuQ
         az0hLvGwdT6VU3hX3g0duZODuumaN8dL6elnuvPpwIYP0E1QUFmphH/YwbawF+XMdM/E
         yOVYio4hIYbNqJ55FiiaD1m/i8nH15eqNF80GCfML1m9WOiVIBpDu5tC+ANJMZm1qHIf
         I0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785727592; x=1786332392;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rW2m4UfJFTFczcwxnDcti6pYYCW920pNNinJvPy7q7A=;
        b=aJVT/yeGb2ZwkMC798M5dfIdEAftqjh643D2pVYiYH6P+pDwPSdwWp7VACt8BjBk+1
         xWxGN5abTtsW8tn/s8jECFpJt+WvVLUXAb877Boz3eAMSK7l/rjePrAXVpyY29crpe4W
         e2EW6YtSID1nxoSa587bF7U2iG6ffVJW/Cw774TPCpnq95LL6ObIuBwS00G37yXX+S3n
         GjFmlabIC4YMeBmoox0okkNQSmLIxl4MoPojlWN1NnySynfxj4rtMfyL/C+8CBwZWBlz
         8kzxPQvAQt8UPy8hj0FH+aqKKtqCPzKNmyOj5RUWTgCLHjQblzlPiU8dcWC/g2Zj5ZuD
         fvtw==
X-Gm-Message-State: AOJu0YyQIxjuXBqxlXoL7V/Zy6U4iVxayfeYy5gYYYPlKROv8QcLF95p
	G2EyBio6jXjdjM2E82Wl9/NQslK+XxqNVIDDd/536hFWHQ6Rh4rxB9x0
X-Gm-Gg: AR+sD13WzvrEf079CJ7jd7AlLKPbeLkvaOJCM+WTssLaU8bRcXtfAyrMRiKGEWDmcKu
	tpVmizfslmFN6RD7eVHEHDds+BXby0h3qX/TfwQG14YBuyhdcMKceAKb8evOvhYnhOtfiz5ZEjx
	zqYaAZEdg02E2psv9lcy5yC6in6bcneAqLln+Gq3YXsiRPkQY2QbiEp6ZPaVWR7uUOa5nOrcdTX
	RW/nZ+RmK8siE43XqrGatnciXXg9qEjHpFSUCJnvQhRwXMU0Gc7QGaz0M5XeuhyYRPKVQgmwKJe
	UMgyz0XTAaOwipoAQdjZb9hdhVUgYpifE6sUkTjWPh5NCRr56TyHwv63TO+nOBYjRjHgg1plf1D
	8F3riqn0LK8yKY9JNzRwGT/QqHCC9jul0//M66PKBxyl1RdUDklpByjO+nPHX/vXEP8AhNtS1rl
	hsGZyguoSYpRFbDsEQZhqgwTiwnosAbplc8G+OLEj1nM8wSEltX6Vw67BSFh5M7m5iwl703gBLh
	edLYOTaog4lSf0Ps6yLVh9W4yVSckVwaPZzCLgW3iXz8cMm9Tbjp0Hx2JOnLSC2n9cmUctdEETT
	xluvCYkrqcyFDCqqnef6DaxzXM0=
X-Received: by 2002:a05:600c:e548:10b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-4980c649c63mr132917915e9.6.1785727591863;
        Sun, 02 Aug 2026 20:26:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807ba8032sm156577785e9.15.2026.08.02.20.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 05:26:31 +0200
Message-Id: <DKEZLMC43IZL.3IE6NNLQWJI0V@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <shuah@kernel.org>,
 <danieltimlee@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Reject writes through untrusted allocated
 pointers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726021304.97ED91F000E9@smtp.kernel.org>
 <20260728033837.1466123-1-dingning04@gmail.com>
 <DKEUME1DRKOR.2R2XVNQDZKVSR@gmail.com>
 <CAJP4iuumoLdD62rXf=3HexiKVoKbXHJka7tm9+Cw-LaKmuvC+A@mail.gmail.com>
 <DKEYIUKP4IPQ.M7KVG0KIIU1E@gmail.com>
 <CAJP4iusjn58Uo7uE8NzicZQmKoips9fu8+bV0jEJFUNmXz8K_g@mail.gmail.com>
In-Reply-To: <CAJP4iusjn58Uo7uE8NzicZQmKoips9fu8+bV0jEJFUNmXz8K_g@mail.gmail.com>

On Mon Aug 3, 2026 at 5:21 AM CEST, Ning Ding wrote:
>> Second, I don't understand your explanation. WDYM by "after the access
>> permission check"? It gets invoked for BPF_WRITE, so should be rejecting
>> res->key =3D 42 if 'res' is a pointer with PTR_UNTRUSTED flag set. What =
am I
>> missing?
>
> The direct write will pass this earlier permission check since
> type_is_ptr_alloc_obj does not check PTR_UNTRUSTED:
> if (atype !=3D BPF_READ && !type_is_ptr_alloc_obj(reg->type))
>          return -EACCES;
>
> The later PTR_UNTRUSTED branch is not a rejection check. It means when
> accessing a pointer field through an untrusted parent pointer,
> propagate PTR_UNTRUSTED to the child pointer.
>
> if (ret !=3D PTR_TO_BTF_ID) {
> /* just mark; */
>
> } else if (type_flag(reg->type) & PTR_UNTRUSTED) {
> /* If this is an untrusted pointer, all pointers formed by walking it
> * also inherit the untrusted flag.
> */
> flag =3D PTR_UNTRUSTED;
>
> }
>
> For res->key =3D 42, key is a scalar, so ret !=3D PTR_TO_BTF_ID. Therefor=
e
> the second branch is skipped and has no effect.

I am talking about this bit before all of that logic:

         if (atype !=3D BPF_READ && (type_flag(reg->type) & PTR_UNTRUSTED))=
 {
                 verbose(env, "only read is supported\n");
                 return -EACCES;
         }

Why is this not enough? 'key' is scalar, but 'res' which is being written t=
o is
still a PTR_TO_BTF_ID with PTR_UNTRUSTED.
