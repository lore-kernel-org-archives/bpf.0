Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A603839BD
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207330; cv=pass; b=VxfoB9mz0vT6coNFa7IeSEb3OF5nh+tff/UCpgOqn03wHwjf/lR/ypEORzWam9ZpX8jcMJ0//2/LAuJ65xmGI1fF6lUx2ZA7KR+KsDBNBInWBJIeIe6qWLtPlE0v9+UuM5hFP7tIvxwOAr0ybKirilgF3yeK7vxKqca3vGvIxvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207330; c=relaxed/simple;
	bh=ufZLh+kfW1UEdEikHsgtDF5Qa2HBFc1dj6ImUClbn4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drURgtiCmuGaYw5FXnrBDIq/6dAPO0NfZanDe0Ov/VwsWeAnZU6FAspsTep8ytZOCxWUJI9aX/XKaGdVvjia1IMmRf51vvzenxs6BDlJoRmHIqCK3Mc0q+42+1aTPWMlMvuW80iFDJ5+d3no2WNCKgzNKhEfn+qXUP5ykCjS7A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez5OIpyn; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez5OIpyn"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-495c49f8eccso75675b6e.3
        for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788207328; cv=none;
        d=google.com; s=arc-20260327;
        b=CfWN6zuz9gz9Co8E7FGFRQs9blf95tYafD37NdoAonEDcUxfWbtJ75zZRAESapfbjM
         WWTgGhHJR/XR2gsdi2sQugvB5ivZhnZ9nhzzR4aOZWWhamCFtpAj9BIpMjfC/2/2EfHO
         9Tay2R93ZS0YX0mSuV1imanDU+I8k8KWEfdIz7qDr4QBQH3AsWlXVjHblqjZ98aqVU02
         TXHy4zmTWrRnGcQTuYTsJXmK+92UKSwgnZx3pA4hjogB7ebqoiNysnB5E3rd/p5pEJxo
         HmmoS0PeX2c+k0EVbjkv2+jj9QwDgc5+GSnyjFuCyxMifBVTmxbET0rVOFW9ZObIn1fn
         BabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        fh=eJXe+qCba9pO4diRMh0hSqtRngLfZMS6ykEzEG80JVE=;
        b=AnZV8PocPAdRrMP7Ezz6sd3HtJXUXDqrQIjfU9KrOQgyFcypViAnakxscchxqwHghK
         jnjziNST9N/NNmxU9Q6KU5pQEkbjiaUSAbNx1Qar3fPXsTVLeZW8n1fvMKUzLQEuy8ln
         UNo1RprnxyoT0sMqXQ0N9EdXvWS0MsveWVrE97TOvoKlcNTe87RwJPld6hZF8+2s3sie
         qYXtO5AGoQ1om987ZSp5gia1tZ1oa7iGzegAkM0OaEuxW1dl11zI5c1WlSFlYyuz4zkX
         HBUCMlRJ6ZFgXW+RBnchp/ffGdIm8CkzL3gaQCKRRp/q3c9Cm9NODAZDAQ16ZuInHAG+
         JkTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788207328; x=1788812128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        b=Ez5OIpyngqpTRWdskTdFtngPLQ7P87jiNFpMebUtFH2tmLUTMLjKZQNydXmCoUvUXE
         27rd+EC8MjtOewRJ+UkY7xbaIa/y4YTxiF4EsLh3XF7LipjWxKxBso+q2jlHXGe0iHMV
         /xwxFcKL4GiRhDDMqJQZRVkIl4OeJ0OFZLlBMAztBKbUnm1hbyofM9zrt9OXhPVHPvQB
         R5zz40GMEgKwjt+aOP8e9YcFblsVPDthrGnK8vb3tmmCpABM+ofPGZsD5MW6jd00XW7B
         Y8mJyOu2BzWYc6kdvzSJwd+SLcKb//KF87Rx9r1OJhPJGiNDFR5axqhnGTYaKOX0rNid
         H1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207328; x=1788812128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ONLbdtQwNTYemip0icTWZK5Zr5wKg4+l2c1pjkTBBwE=;
        b=Zr4rf/G2I16ZTvYTR2VxOVrKnCetvhbWEtSx73mS/D8xDOPz25m6AAQPAlwFtLDCvd
         /T+N1GODTKVugJVpn6pIgGnzY7faDl4k+yL4W5OgcGKtube9QiQ+3tqbdbU/8qfg6zr/
         Rf5di575RJ59mnQBfyXQbBPTdgamoeDHgAxYDzDnF3MfT2Qo/FSIy429HKaV0LCtclon
         XEbmg8W0qH1nWWPB5Va48YOlldiYMJDjYvhh4AUeP+fQZJVM04TFnyfQfOsRy4D215Oo
         g0DW6w0RmuNHwJolbxvd0qZH8iJFHeGo78iUYCGCuXmDZD7YtzOAIcfwBvLEvvIHdSAr
         ling==
X-Forwarded-Encrypted: i=1; AHgh+RoZwZqGf3us3ZHY8CyhKw9Ag/C/mbViOXV74Wth0ep/K4oPnxUZacAeCftqjPJ8gyO7LkM=@vger.kernel.org
X-Gm-Message-State: AFuF++k8RlAZv9mTgQWGxrd9xe6RF0dqZErbJhm2cjscrxSiwrZtKs6o
	rBkWrlYBDLdnBn/ekspYRdVqdmc17/jQOHsr8yg1wZGEpXYf9XIjVjgeZnbocRQCxKps3QJi5gq
	DO8xwRApaMunXHzGPInVSS8speYo4AlE=
X-Gm-Gg: AR+sD10vpMVTxpAFNqYkMykUQq4WlJbkGk80pwOe0qrb3jlwo2sbiQRzoZKgP/iHH8y
	dHRPAg7yDF4RsZ3cGf7GQRkwCSaK+yJ99MjMdBNhZQOpyxyEBUfqqqpIQGZZPAxCOHray0LWuK5
	8fWjbKD5rZYdUrG7443J/w5lH6YR49XUT0YDEDyPTjr3XswPUYxQJ64dO9klKvsFOi8hB5X+f6p
	lOpq0v7zq6K7gZCBAppcI5aWcTYzH+TQmEravTdhXYpC3VWF0W7RJOgYvTLxEq+vUHWxnhLfz2V
	JIRfBwFfwrv7QtGVMVdeyDB0BSQf8MplVydzEFlaJTmStlTAEdFdvDdg/QY=
X-Received: by 2002:a05:6808:1926:b0:4a4:866:c395 with SMTP id
 5614622812f47-4b3981be305mr28057591b6e.13.1788207327565; Mon, 31 Aug 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831001552.3223196-1-xyx2021@mail.ustc.edu.cn>
 <2026083135-hammock-bagel-3147@gregkh> <20260831155815.70167-1-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260831155815.70167-1-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 31 Aug 2026 13:15:13 -0700
X-Gm-Features: AcwNN1XcvPJ3Lcft98Uo-XEUwiY2jq19J4JKDFgADciBwgFZGA6iPM4vM5_26tA
Message-ID: <CAMB2axP4dbiTLNStUZ=6D2p-MtjW2Wg4Sfbp3KSuv+DByAC8xw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v4 0/3] bpf: fix dynptr release handling
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, joannelkoong@gmail.com, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:58=E2=80=AFAM Xu Yunxiang <xyx2021@mail.ustc.edu.=
cn> wrote:
>
> Hi Greg,
>
> Thanks. I understand that I should drop the three stable-specific
> implementations, preserve Amery's original authorship, changelog, and
> trailer chain, and cover 6.6.y, 6.12.y, 6.18.y, and 7.1.y.
>
> Before rerolling, could I confirm how the prerequisite chain should be
> handled?
>
> Commit 308c7a0ae885 ("bpf: Refactor object relationship tracking and
> fix dynptr UAF bug") is patch 5 of its upstream series and relies on
> these preceding commits:
>
>   bab08d1f70438 ("bpf: Simplify mark_stack_slot_obj_read() and callers")
>   b5c0a07eb2c23 ("bpf: Unify dynptr handling in the verifier")
>   94ac7553361f3 ("bpf: Assign reg->id when getting referenced kptr from c=
tx")
>   06d518a5583fa ("bpf: Preserve reg->id of pointer objects after null-che=
ck")

This patchset is too complex to backport properly, so let's not do
this. This is also not a security issue as dynptr is gated by CAP_BPF.



>
> I do not find these commits in any of the four target stable branches.
> In particular, the latter commits establish the reg->id semantics used
> by 308c7a0ae885, so applying that commit alone would not be semantically
> complete.
>
> My plan is to prepare a five-patch backport series for each stable
> branch, preserving the original authorship, changelog, and trailer chain
> of every commit, and adding only branch-specific conflict notes and my
> final Signed-off-by.
>
> Is that what you had in mind?
>
> Thanks,
> Xu
>
