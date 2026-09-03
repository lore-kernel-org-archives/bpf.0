Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39B4E3EE8
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449806; cv=none; b=BCXKhEmbzbGm6eV8ppRKj78gfF4loJ+PKbl91CYk0kvK6himrjzniz4lhv+q9ulbIDXuM+itV6E0/KMaQLyO4r+lKnGFvP73QpCi4Mqsl21ZD5p/cf2Ypl7K5xsBH5OIk2cttFdXQfircYaS2h1hMYin7Gs+WJ3NgicYrjd/92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449806; c=relaxed/simple;
	bh=EMi5f4lNBmWXu6d+fPcI1KX/wIAaZ8Vd47RfWN3nins=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=khZqFhu9BGT7C1HBPMyz1c1IeJzsTe3zDtefzFQ2O0OeVt6weckS43APE6zf5CeC8mrPe2MxZwMlYIuhtd3vg3rqztj8XbWY1AB9xTzUQXVpBVKFG+8V5E0sgl/AP3p2uLiCMq6vFSU79SbRD28Gh4Ai74jpjPSTvvp0PJLsy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ro4SPjKQ; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ro4SPjKQ"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so4775915e9.1
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788449802; x=1789054602; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d97CQnOJj0XmdozH/KAeoWsPcFgZWb7RGRKU1QNh0Po=;
        b=ro4SPjKQy/7L/qGWXGtyK/nCp/wJP5lgXoY8MIoTLUVXB1Y/K1aKyry8DaO0l//NyF
         P8OvspzFo43tU2NoqLfReUokt607BYBj7if0BprLwjHD32yYYkIKO4OOaXolr0KrZ1Rr
         MPCk0C9mo8yFL/VKTLo5Sy1q7wOu4Yesz4GQ210hzoworLY2lcHpWWEG2QE3veQbPr7x
         G9A9qh9q/pctMMmaoca6TaQoYT4glsHIM04m82W3CaKKWrnf09rR/3SxmcN4zY3h5idM
         lhr3CfONRFO/vsHiTO+dTkXghpiEG4H/kxygRqTCce6OQPNkunAQy1VcFS8rFaI7KFZ5
         u39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788449802; x=1789054602;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d97CQnOJj0XmdozH/KAeoWsPcFgZWb7RGRKU1QNh0Po=;
        b=RwPOvZZ2AWWh37GmfAzUwFC+gemEs93F701UzQCJUCUTUiF6LripjDwA1f4rfbfl4A
         tGgwslLqrB2QcyhYA3Z9QxdRfP+R4ZQdfKwC/ieCHgKkD+8wwAVQp4xJLwoBSBj5VI0N
         rJzPDSN4KPyTj4fUy5Q1XSZTG85EPnVUbaX6ihJ/v1JxTIjK7yBCbGDD1VxReSzciOu+
         E5Q4MdCs5J5D6jYXDMR2J1yJAUlfSTRBFSadNa11p2WZbb9n2nXUts/NNOGPks4Iuhmk
         Dz3tJ+sPdXq3FHDcYuoQUpnuhWdUkQpIlG10JTVLh1fPAw5rfGXtveJa6D3SgssHJ3Me
         3xQw==
X-Gm-Message-State: AFuF++mWwnOci8PRj6/FagQywM8u8nQgMWApI0vpoUKMiRqpUZfPVZ1P
	WEWoCQLPHz1lscvCYFCriceC4H8bMVUqtLuqNJky5lpkoKmYP+mAdgwu
X-Gm-Gg: AYBFou3nRfx6LsX4i2M4xsjFpCKaUPqHkQ8j8RfhcxXKhxmaZ8k41nBcu0Gx8YUVP+f
	qmYKcNPKuaeawTf+W22Ei99GP3NyWVl8Y7yy2wZMCS17XTDXFXktoCN0hI5M7Ms9v4ESeKc4CND
	CAJBaKfVdxbiZbOS4KYXlK/XI34zgSlCMea138q79OxNGmlrFcIGhRUZFWdcd+diKgK2TvJayiq
	8qg88fdwsYmZn/Dtfy5KVJrSyLsgtTCZOEBNX/F8qVEPKo7SPYLSAmpMVWQOhy/1fHzDjxBdq5U
	bno4IHh9TzDfWDPv+YC3o48p9+mylIHEHhSK1vOTjxxEPhKV2AmYzPy6fhtf7lMVs32ZJ11pf34
	XMpuw+YqsSFOnVJCOFWRYl1fOtmcMa2RIY455GyEHprU1oFq501INcXli5Se+u9sKvxMvWxaHJf
	MAc7kUvSiKoKIcC6cr+Jt2YeIjGtT1YRlu6D41KQ5yLVZ2apUgea6BFFAFwJpIiiZKQLBnkjK83
	ABi76ZAESQcxxwG9JXSL3PnTQuwSQhNtX/dMVAxUEnglq/I+6+UinY4gVN+6JmDiwxPHHxiXItb
	c9Ern0OpI0p66fU03D0KK1DYZFU=
X-Received: by 2002:a05:600c:470d:b0:499:9240:9a1c with SMTP id 5b1f17b1804b1-49ce58363f8mr200509115e9.15.1788449801763;
        Thu, 03 Sep 2026 08:36:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5d476esm87903355e9.1.2026.09.03.08.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 17:36:40 +0200
Message-Id: <DL5SJK7Q489U.1HFUM2S4I4G71@gmail.com>
Subject: Re: [PATCH bpf v1 05/10] bpf: Reject resilient lock operations in
 rbtree callbacks
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-6-memxor@gmail.com>
 <20260903153146.2C3A81F00A3A@smtp.kernel.org>
In-Reply-To: <20260903153146.2C3A81F00A3A@smtp.kernel.org>

On Thu Sep 3, 2026 at 5:31 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The restriction against calling lock operations inside rbtree ca=
llbacks can be bypassed by nesting callbacks or calling subprograms, becaus=
e in_rbtree_lock_required_cb() only checks the immediate top frame.
> --
>
> commit c5914f67e15078bc12af13429620d2a2a4de2b11
> Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> bpf: Reject resilient lock operations in rbtree callbacks
>
> This patch attempts to enforce the root's lock requirement for resilient
> locks in rbtree callbacks. It aims to prevent use-after-free conditions
> when nodes are removed and freed by other CPUs during the in-progress tre=
e
> walk.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f540279ff4abb..32d31fa67036b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13241,6 +13241,11 @@ static int check_kfunc_args(struct bpf_verifier=
_env *env, struct bpf_call_arg_me
>>  		{
>>  			int flags =3D PROCESS_RES_LOCK;
>>
>> +			if (in_rbtree_lock_required_cb(env)) {
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does
> in_rbtree_lock_required_cb() fully protect against this bypass?
>
> Looking at in_rbtree_lock_required_cb(), it only checks the immediate top
> frame:
>
> kernel/bpf/verifier.c:in_rbtree_lock_required_cb() {
>     ...
> 	callee =3D state->frame[state->curframe];
>
> 	if (!callee->in_callback_fn)
> 		return false;
>
> 	kfunc_btf_id =3D insn[callee->callsite].imm;
> 	return is_rbtree_lock_required_kfunc(kfunc_btf_id);
> }
>
> If a BPF program calls a custom rbtree comparison callback, and inside th=
at
> callback it calls a static subprogram (or a nested callback like bpf_loop=
()),
> would state->curframe's in_callback_fn be false (or its kfunc_btf_id not
> match the rbtree add kfunc)?
>
> Could a program use this nested frame to successfully unlock the resilien=
t
> lock via a global map value (BPF_PSEUDO_MAP_VALUE), temporarily dropping =
the
> lock and allowing another CPU to concurrently remove and free the nodes b=
eing
> traversed by bpf_rbtree_add(), leading to a Use-After-Free?
>

Separate bug, will be separate fix. Let's still add this one.

>> +				verbose(env, "can't res_spin_{lock,unlock} in rbtree cb\n");
>> +				return -EACCES;
>> +			}
>> +
>>  			if (reg->type !=3D PTR_TO_MAP_VALUE && reg->type !=3D (PTR_TO_BTF_ID=
 | MEM_ALLOC)) {
>>  				verbose(env, "%s doesn't point to map value or allocated object\n",
>>  					reg_arg_name(env, argno));

