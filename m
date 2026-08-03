Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD072622
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785715890; cv=none; b=ROEfxf0koxT1ZAGUUax5gBrcleb6m8Qqftsv8GDeHbBEqoD3+w8VE1pxfvmac+f6XWA8B2M9eXPgx3ZWQ5zsgfYgDWeiEoJlldM87YGK3ApfluwT/TrtkwRLaIDdiTAtsv2owOrMEIdlv4b1IYbIlV4dVMg28i7umr1bDm6p6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785715890; c=relaxed/simple;
	bh=xcUY+DKs3+Y9ZAYeOnWRihdxrBbcA1wZogaWMdKPBCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Mr81bZnDtMfGsZ1LikBv6O+FpBFcLbLrTh2kQhGBRqfeWTYIWApJvpy/fMYXWxUjaL9g+t72KHBQCNSHU+MX3dE3s5AH3YB/2rbi5f0pMKVSAFwROEV5bCuZNe0yJBEAivrlJjiZLoQok5YudH83C+RIB5HkpbIE8EtqKwaHyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6yga2LS; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6yga2LS"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso1238465f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785715887; x=1786320687; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5VBkp/M/Sk63PysxIV8aeQsYqqYmeyIXI2LyKXT+PEs=;
        b=T6yga2LSGOZNG0MN+R5eghd0n39Sl/HAmLATrllGbbg5mMWMsbUx9uwV7Wgmhhk5be
         hvFPZxjouM6Om1olmWAESiS+wUyvGTbmCzwE3kM6Qkl3qaUh244IDfEnJJxDT34HeSvU
         S5d5X+eW27sM2tI+Mu8IMdY6SBV4VFwIxRehupfqACDNcCoN94mHASQUixtIAEijPgDz
         Fh7JbJHzeSp6Ug/IBnkN0XCH2k8nWhVhUMcFjDRM6QbN2mDUwUg9zCKzxnBqQnGcC5mt
         IqmBZghoCjIrA/wKroQSmxsOXmN3hx6ofU9woctQ965Fc/vA5SuEg3I8y7UOfe63oio+
         t4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785715887; x=1786320687;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5VBkp/M/Sk63PysxIV8aeQsYqqYmeyIXI2LyKXT+PEs=;
        b=bKAmiAyuTwfzYRkNLSluqlzy8dhQyWJvwmMlq2s6n2FKOzSGRrfcqRkfQ2BTxW51wF
         9kLNtSGetQ62wrb112sscl6a15fh/n7jlPQLTXHDZjLLaDCH5s21LpHv6BGlz2Q9oaK+
         1dnr9kW5pZYVOQmWcLw8qcNQ+1XWQu0MnzPev8h0aPkxidIpsyASMUjqW+xUWnljot2T
         Dqo/tL2qNtC84tTMa/3coKCrhafLcKgUPa/bwB9fanYrBHrgXOKJj09FbJ9GuTNmZmi3
         9R67C40yeanwJFBXV/kMGMJYvMAUhrOG7K9QnOmixGJe1CVprzTcsD6p1L1gmLXR+9eL
         eaUA==
X-Forwarded-Encrypted: i=1; AHgh+RoDY139B06RIT7T9UPjuLRrGefFGTKU6H0exG1+eGr8d6aamKjwIFN2vnh8lGp+twd7Ymc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy16pU8OeP/F5av/u5TLuFe8lBxtKnG4cMFNfO0qGsVmqwFCrCH
	BaeYW8kWOaqlb5GLhhsxOCOkbNtkvFyJxR6BL6L4rgwax/dX4/Wp5DOL
X-Gm-Gg: AR+sD13m7kK/fMIyJ3AX0n3QKA9z35eO3qHmDw7b0Z+QQ0SXQPJDCPJ39VtmQ59tSkc
	37MHei1IaLDEMGLGZqM1vx3YGN0aUpLRchu9Bc/c4iei88cvsWsMd8wlONeMbtAm8p+EJK+67y5
	apDeZTWDWUcRrljZNn6gb7Un4Ck6/c7jVfosi8HEAI4SoJvAFj1fzy80XK4KVza2dDw6F7UsAcO
	UVMfg/WMRxI5L4fOPl0wyZDl2h/ZPXoLVQbatuixaI/xTKg7Nt4yDzJatGJxN9IHCZPls2/PM4j
	2Y4fzws/w3Cy8P+hzgGAK5U/tBHEJREs3pEqJ1j+NO7fojUxR5dSRa74btcCphKPirGI2iLL02I
	p9/YcAwz93sov/70hvaer/ELkGsSk+fxgzkuYBHeLLEWW7gO24QcTciZUih1fGiuh6W946wCVT3
	+rwo45AwgUP16d0XMtL5CuUxq4nrO6L54W7I9AawFJaYlT7bKKUf5+15BgAsvUgVwyevSC60AnI
	dN6CRrIwL617T+y1kd4wzNEXad4OxMhSCWVc12pkl1cOxBFpLmHytlSFHcyVdxbbD/9/MAFht2F
	OwiqkdRmbn3AY5inKPd36zLI8a47PmAd0QXsqw==
X-Received: by 2002:a05:600c:8b17:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4980c66c926mr166756395e9.3.1785715886664;
        Sun, 02 Aug 2026 17:11:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b6093fsm103199905e9.1.2026.08.02.17.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 17:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 02:11:25 +0200
Message-Id: <DKEVG8ZVJDDQ.2G40FTOIZKU57@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Mykyta Yatsenko" <yatsenko@meta.com>, "Shuah
 Khan" <shuah@kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Cancel RHash special fields on value
 recycle
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn> <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-1-6e5e1131d885@mails.tsinghua.edu.cn>

On Sun Jul 26, 2026 at 5:51 PM CEST, Nuoqi Gui wrote:
> Commit 6905f8601298 ("bpf: Allow special fields in resizable hashtab") sa=
ys
> that "kptr semantics under in-place updates are identical to array map."
> However, after copy_map_value() preserves special fields,
> rhtab_map_update_existing() calls bpf_obj_free_fields() and drops retaine=
d
> kptrs. BPF_EXIST can therefore unexpectedly clear a kptr.
>
> Use bpf_obj_cancel_fields() in the update and deferred deletion paths, as
> hash and array maps do. It cancels timer, workqueue, and task-work state
> while the allocator destructor releases kptrs at final reclamation.
>
> Fixes: 6905f8601298 ("bpf: Allow special fields in resizable hashtab")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

I don't think this is enough. Upon reading the code, I am suspicious about =
the
check_and_init_map_value() in rhtab_map_update_elem() (post this change). I=
t
will likely end up zeroing non-zero kptrs and leaking them, since recycled
elements will retain the value. Dtor path is fine but that only covers the =
case
where freed element is never reused and only freed on map destruction.

It might amount to simply remove that function call from the function. The =
other
user in delete path looks fine since it operates on output buffer.

Please make sure to also add tests for such behavior, having a map of at mo=
st
one element should allow for its reuse, you might have to reinvoke the prog=
ram,
once doing update, then another doing delete, then another doing update to =
be
able to rellocate the same element. I am sure it can be figured out (with A=
I's
help), but please validate it using tests.

pw-bot: cr

>  kernel/bpf/hashtab.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..54ea111daa8b 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2865,14 +2865,14 @@ static int rhtab_map_alloc_check(union bpf_attr *=
attr)
>  	return htab_map_alloc_check(attr);
>  }
>
> -static void rhtab_check_and_free_fields(struct bpf_rhtab *rhtab,
> -					struct rhtab_elem *elem)
> +static void rhtab_check_and_cancel_fields(struct bpf_rhtab *rhtab,
> +					  struct rhtab_elem *elem)
>  {
>  	if (IS_ERR_OR_NULL(rhtab->map.record))
>  		return;
>
> -	bpf_obj_free_fields(rhtab->map.record,
> -			    rhtab_elem_value(elem, rhtab->map.key_size));
> +	bpf_obj_cancel_fields(&rhtab->map,
> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>  }
>
>  static void rhtab_mem_dtor(void *obj, void *ctx)
> @@ -2964,8 +2964,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rhta=
b, struct rhtab_elem *elem, v
>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>  		check_and_init_map_value(&rhtab->map, copy);
>  	}
> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	/* Cancel reusable internal structs: bpf_timer, task_work, wq */
> +	rhtab_check_and_cancel_fields(rhtab, elem);
>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>  	return 0;
>  }
> @@ -3027,7 +3027,7 @@ static long rhtab_map_update_existing(struct bpf_ma=
p *map, struct rhtab_elem *el
>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>  	 * to match arraymap's update semantics.
>  	 */
> -	rhtab_check_and_free_fields(rhtab, elem);
> +	rhtab_check_and_cancel_fields(rhtab, elem);
>  	return 0;
>  }
>

