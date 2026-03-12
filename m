Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB9381B0C
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332527; cv=pass; b=bnA4VWszZB+x/6Onhwtr8jdlcFAXm4BvD6lkflVyBmcOK3m3XpJCIbOqHwgNei36FDtYYOlv69WWkI9jsZYflWNvs2w2Jr7Uur7UsTKB91jmlPFpsxWeaOkPsrudKz5k1FUx6aRP9MNzw83oryAhnG/yumyj7yk25E25+oor/zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332527; c=relaxed/simple;
	bh=WNSg/9nZhA0DjnBaUl2bBAbP7gxVP2vBVqH6M2aUbVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIXnvKtxwt60DHbJXd+R9MKWQYP4s1pQ8iTFagH6BrDEN3cKYKIhv2bsiQXwqPY4+fJ5ZoqjEP0BLxAH/vQGFGfcwUYlEvHwyyzcMVxp0btRIbESUJNKpMAQw1d/qDRtncHj2Ye9MfM7S8XkFnkU4j+QkAHeVWjrT7XtM8Y23aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbLv/7m1; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbLv/7m1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a13374cf6so536352b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 09:22:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773332525; cv=none;
        d=google.com; s=arc-20240605;
        b=NE0GyIyMTYMTLyhesjF6u7FmmrrqSnYSUp7to7gByz3zlhcN/JmjFrwNOfQTlmtzso
         8Xa4cYElRomC+MZI9KgF3dgG7qHBV8nknaVphfbKaEGl+0AZffxTc+TsW7oLoAoDHr8e
         nCovO2gCk7MA0888xUxaUFwBAb+D6yFC3TrqCPSAAWeTFcZZK1wQk9HrS2MWwc0nX5zm
         v7fpwSQ4n0vt6ESzfr/pVSuzLr1dzSllPa6ZNS9t9N9Nzn7UFYD4uLU7OOfY8Rsm0kbY
         uePS0n0wfjtTrMwugTunFAkJ/wpA5bmRc7W/AqQUwGButW1pUYBmHpMyl2ojhD/zBbac
         52hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I0wtimR8VBTCiTxhuUlg0wPM+Cgso0a3zZ0TqpfNyEw=;
        fh=Vz3UGfnQjOUcPWlMqShElwOuZFQr6OfoX0HOBASPaI4=;
        b=F7XTCdWRjeJTxiSwD6JfeXihvU657C/UjkMLC3WrsfIwZ7R918iURyohK8hAar7+Ux
         6WzZj4mAIeRJg7J9axtVujEKqVS5IArNf3qsIlJVHPbOsDYZykSGe06a4hEaqr4iDmY+
         BdqpfgCjUPA6AZ6t8XPsaehvoi7s7QPH18gKaXesUDBHApM/LFg9Cam5BhZ3ugmhNTkr
         qFmayLTY87Eo5bq/JLQywFPNwy0fm4WvshsQrFD/2n+Os6MwjtiNLB0LW0x9hSCamybh
         ZDqfNaJyJIJOFC/Yewp+6Jb0m+vVun7tIuB3oxjfWOdytUfb0S5Fb2GrO9jx7XSx32Kr
         f/kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773332525; x=1773937325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0wtimR8VBTCiTxhuUlg0wPM+Cgso0a3zZ0TqpfNyEw=;
        b=QbLv/7m1krBLfzeRTuL41Yj2mY73refroBTb2tEu87LrDdnPby2CQpJGqchRI9C6uc
         DZbrkwxQoZB3AoYoi+cgFH6nXM70WfcP6d3El5fTw10FpAhBcgo4nkXwcCERWmnYrWqc
         zQyK6lluWkB4Q35u9bUX5vibsDEYcVjEv1Am9ofZ7EAhB8Z6Zg+qwuovm56qKwh/sgbG
         UYJyy6W88LzZClS5sGqek6uSV9q69MivaoI5cecafpkzyoZuSmjhx298q66aKnntn2Ce
         6i6Ng23Bm8+37zLMBIv3dKhlSEvGN5Or3Ba3tHhuUNUxaEorf8XIsIm2pMOsrwnn6t7M
         3bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773332525; x=1773937325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0wtimR8VBTCiTxhuUlg0wPM+Cgso0a3zZ0TqpfNyEw=;
        b=L/Ya+km6fSo20PXQQWzWwqTeh81E8/VqNOZ10H8KU+QoMDq96uo+9f+mtLRRFb3sYs
         8Y5Yh3z8QXGb0/t8OtAK/EVbiLl1AFm8QINyfpLLbReopd8N4gHbUZ8sH2TOhi3jMT1+
         tzqda62GFQ9GyQzkK/JkYPp7wjavKtZJZiJqJHqGB7M9+bDqGu7Ft0mncZLVrS6gZC1X
         jbguM6IB4yYa210+H6cmD0qXmTqexeLxzIFSTt4hz3yCN/notHGLTBJ76TSMoC4pSdDc
         nQVcopeGa5S6IQ5uFEzMf5Fq+FZ0LXv9ut+ij5XPuqGZ2G3puF7PcFcUpTN4YifRZVpR
         S7cw==
X-Gm-Message-State: AOJu0YypEiA1FjMCJxCvRvE4VYThXNWGqwhyU/ufSZPp5hYQo9KYWdb/
	hkK2S5sCv7mI8Q7ahUBxyMbAsT+0eEv6a20R4DMqqdhjphzRMuBYMlV1V+0vGIP+d4HehXH7Z/y
	1xWTCvqsaONe976IYWBJ302QzAwwi8Hc=
X-Gm-Gg: ATEYQzzuq6CPf2ZcUK1fNGrJM7Pb4CkIzLYoMqOla1sfWme8zOFs6Nwm2917IazEZ7B
	T8J5EnecKSSzZbNJWWXfqnZskDojL82RgCB6WCJKq3V0c/zyixcJRi4FZPfyAiU2ooDHXQNbcar
	hH7pO/FDcAQrvUue/YAopiCsAjIt7TqYDqhQerpdnJxFx1YFjqHQU6M/gQuI6bnwwcc8yP3fgnL
	5pPA3Wn9bO9O7jNS5lJhbfQuvWaM1Lcf8U0F2mjtMHZGcXUDMYZBHGFwBZTBFsitZVyQx5eaIsw
	jh2j7sfFrcTrAhpDwkeaX0/VLOgGDqKk6g==
X-Received: by 2002:a05:6a20:2447:b0:398:6b9a:6765 with SMTP id
 adf61e73a8af0-398c615d5dcmr6602951637.58.1773332524828; Thu, 12 Mar 2026
 09:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312002025.2495953-1-memxor@gmail.com>
In-Reply-To: <20260312002025.2495953-1-memxor@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 09:21:50 -0700
X-Gm-Features: AaiRm51mAa7qap3-OeAT1n9GVyJlejxMOqIuGyIQl95MGR1xI4yLX-dLUi9SO9U
Message-ID: <CAEf4Bzb0mJsdP7vRwXiHYmqv5NogxPfOR1bFgFme9aKcQDvswA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Gregory Bell <grbell@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:20=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Gregory reported in [0] that the global_map_resize test when run in
> repeatedly ends up failing during program load. This stems from the fact
> that BTF reference has not dropped to zero after the previous run's
> module is unloaded, and the older module's BTF is still discoverable and
> visible. Later, in libbpf, load_module_btfs() will find the ID for this
> stale BTF, open its fd, and then it will be used during program load
> where later steps taking module reference using btf_try_get_module()
> fail since the underlying module for the BTF is gone.
>
> Logically, once a module is unloaded, it's associated BTF artifacts
> should become hidden. The BTF object inside the kernel may still remain
> alive as long its reference counts are alive, but it should no longer be
> discoverable.
>
> To fix this, let us call btf_free_id() from the MODULE_STATE_GOING case
> for the module unload to free the BTF associated IDR entry, and disable
> its discovery once module unload returns to user space. If a race
> happens during unload, the outcome is non-deterministic anyway. However,
> user space should be able to rely on the guarantee that once it has
> synchronously established a successful module unload, no more stale
> artifacts associated with this module can be obtained subsequently.
>
> Note that we must be careful to not invoke btf_free_id() in btf_put()
> when btf_is_module() is true now. There could be a window where the
> module unload drops a non-terminal reference, frees the IDR, but the
> same ID gets reused and the second unconditional btf_free_id() ends up
> releasing an unrelated entry.

what if we just check module_is_live() state for module BTFs during
GET_FD_BY_ID() operation and return -ENOENT? We already have
refcount_inc_not_zero(&btf->refcnt), it's just another "it's still
there, but not valid to be taken ahold by user space" condition

>
> We can be sure that by the time we reach final btf_put() for
> btf_is_module() case, the btf_free_id() is already done, since the
> module itself holds the BTF reference, and it will call this function
> for the BTF before dropping its own reference.
>
>   [0]: https://lore.kernel.org/bpf/cover.1773170190.git.grbell@redhat.com
>
> Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reported-by: Gregory Bell <grbell@redhat.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 4872d2a6c42d..c44fb9c9386f 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1883,10 +1883,17 @@ void btf_get(struct btf *btf)
>         refcount_inc(&btf->refcnt);
>  }
>
> +bool btf_is_module(const struct btf *btf);
> +
>  void btf_put(struct btf *btf)
>  {
>         if (btf && refcount_dec_and_test(&btf->refcnt)) {
> -               btf_free_id(btf);
> +               /*
> +                * IDR for module BTFs is freed when module's BTF referen=
ce is
> +                * dropped, which _will_ happen before the final put.
> +                */
> +               if (!btf_is_module(btf))
> +                       btf_free_id(btf);
>                 call_rcu(&btf->rcu, btf_free_rcu);
>         }
>  }
> @@ -8382,6 +8389,12 @@ static int btf_module_notify(struct notifier_block=
 *nb, unsigned long op,
>                         if (btf_mod->module !=3D module)
>                                 continue;
>
> +                       /*
> +                        * For modules, we do the freeing of BTF IDR as s=
oon as
> +                        * module goes away to disable BTF discovery, sin=
ce the
> +                        * btf_try_get_module() on such BTFs will fail.
> +                        */
> +                       btf_free_id(btf_mod->btf);
>                         list_del(&btf_mod->list);
>                         if (btf_mod->sysfs_attr)
>                                 sysfs_remove_bin_file(btf_kobj, btf_mod->=
sysfs_attr);
> --
> 2.52.0
>
