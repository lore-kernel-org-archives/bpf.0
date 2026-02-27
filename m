Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3F346FC8
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177131; cv=pass; b=DDPjkhD+5anfTU6PlNs6JiWiWLLICyV/eBKXlBDa162xWipt+KcYYclHS4jwM4TW4aut7ijlnsEYdS1EIPgYhaml3dqzvQHWDDIDpSUfhYy/vIEXeOF096fCgK67Iian1L1nRYvA8hm7pBwnSWW4McaLuTsVpG8DUiZt2CU7Lb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177131; c=relaxed/simple;
	bh=RBAduCi5hgfs1s8csP9IAl9QKQF+tID/1StxY2X1IEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ada/3eOa0IOTBQXiCafI+CyqZQmNgcXA/3TwGwM8kma5iebfykzhzvDKAcCg9L3q+HkozkbxfhEGlY0hzr4hGp0g4V0s8SjjyxrLaSamR04y/Ck8ngtRnEt87jt6K+ADw54Uf2pPxbZ8G/Oi7nUWXZ/8Pi/rmMYX8fskXnw3jhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7gPLCFm; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7gPLCFm"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso2188789d50.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 23:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772177129; cv=none;
        d=google.com; s=arc-20240605;
        b=hAUnkHBR+BJyVMdlpTico/+3A+2Rmk/58gEoFbv0u/iRxZcIY1Czj0F/61ulwonLCi
         HaGVMHyj7P8wNvj7uQoMMvFnZe2brZu31D+5LOcmg0Fx5WQaM5X1YsGqsfz9dc/SCdkT
         adWSwsywKr2sKlFrS5AWLTxFrICEV+hdfQE5MhO/bEFFs6jUUDGTfUDWcfNnsiVh6j6/
         EX6sFwxiV8FeJXUTeLnb4/Sm8kAfYfFLBk/rHtor8hyzN/DPGdSBXvt0+1R3wGh/7k8f
         FKoetpsCIoazIKTaKaQcHWk9SUbGc2d4mQffhpwT4hwdqueIx262PjHKaoDUQzwSr/Dj
         kdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qZ5m2anTs2ZplzvttgsmSj5CLowYLY9ksG4DogvdvUE=;
        fh=TUQmpw+oD+lq6s6LhNhDCtURCjyXEHqDtaEf8V1rHB8=;
        b=TXpmxBS+TNogk8KJysn53lcaLzS2yOBeNewFuyz/wKRlmjwuQtRCDEXFVhxGQ1jVxj
         y/C61aiWGpOaOxwTSys3dgplg7IIU9pYmbqSEZv23exN6NRld12ZZTtnyoPUQd2eJRrC
         059t8rPwBL3TlTD78pQxvMq37+6uyxLdI1QxydvGsJItv+VtAmi7npLxXH2zESSaFLXZ
         ieNq4ZZTF2WUGwlp2L+HovY2QIOz8mb+DFgrlF2Hy78PkAyxxaQ2nOjPEXqqc9sbrt8p
         S2b+d4hRo23fNFlL4J6w2CeJr0wG8pouic+uOwCSStrlDL9iWDOsnYtRsmJVRG5qBDKm
         MJCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772177129; x=1772781929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZ5m2anTs2ZplzvttgsmSj5CLowYLY9ksG4DogvdvUE=;
        b=c7gPLCFmrGYD14Ura4uTkteaQJwsmEtu3+HgtLxi2KrALqzoRD0HMd5q6hR7Gi6HDT
         DHelTsoppDg3n59cZjdWn0pXrMbxtfZnCgvfVtpWRWlx9JUGve6Q6YasoiNX/JX3lblN
         1XuwVV4NC+zzkX+FPdzJY8d5fgK+hINx9iYutBQxGGT0bzpP6N7CsXgPWuEgBkMQTFpQ
         r21B2ggF/qbcUtzeTOY/2Bg6KMZ4BXzjnx5vAyqGJ2xgYse4nEOaySo3a9cKL0zUJJt3
         wY2lV7hNUOMCkqL+TcYGbfv67MTWppogfq6rQKbaukQ1bZF0g/DMGnCrAlJVfJD/ipFZ
         jInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772177129; x=1772781929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qZ5m2anTs2ZplzvttgsmSj5CLowYLY9ksG4DogvdvUE=;
        b=Cqb+5mHjSvApn6WVx1+7qnGn4QFw8pm7QBuN09qfupyFwwJ0TmPNp/VUBvQyyzW/n4
         S19UkhgT5Ug5M6V0FJ2N/cw14OyMa6K5GMFL5nIzHpptRUriLU1HbfMqhxa0DFuOCgOr
         ReahY6+6eJF74RwKkQU5Vp8+JEnLn/p0n88YeHbwT4Yrxm1LbJxTv+c5H4v2Kzp9f+Sg
         JZzecUhD9GuJUJ5LxkvjUIsSjypwsqEZ6ZYAgopL3L8J0EEbFEKenBWDJRldNuJwOf9W
         YmoECSUsn5xeizYgHb6H7TtXVU0y78qKJD3hfeAEb7b1arDIO2CLt/0SfMOt3yasI/sm
         TH/w==
X-Forwarded-Encrypted: i=1; AJvYcCXoCBGCvh/GuYutuAUkaCaDsWFEC3BbuQZFTbrkuN4Hd82JRze6Kc4XkrL9ttVnUrwsjtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WzDv0Wi8zK0MaiGw9s/lq38HCU5d64FPWcrlyOZ0/kOM0jOl
	OtAjlFuYdSlLh7w8AC+T7yWnsln7DS8qOqr/jchIH3w3dK/IL8mysH2L/JtdwrvylL9qw6qxGuh
	Bk9FrU5p3VcRJvfFHpKRbH/qJcnPxABc=
X-Gm-Gg: ATEYQzxhudZUN66Ibw2anUvWgxQKb+NTwBQWzzrsAbk1d5COkPo0M7nFyhvgk+/DYLd
	sSMmYKPvC1vV22KlXbPGtONS5nz1S9jslIEi73mMlhg3NCFgxxjtW/AF7S1nONMd3XiXG0I7VE/
	9Wo1Wr3kvY7T+a2yuB1M8G1AnEiJfX0OLVb7BUnmf67E4+CVRt4+qV0kf4yLuQagc/z4q/X8bFx
	NG3qzwyFwQS9B+WGFiXVAjkzFN0nzVoJCyWnET1h5NYu40XzT+rM7LOva8Trk2t0v8YOvEuD7aS
	HDAXz4EekPm6KEW/Kw==
X-Received: by 2002:a05:690e:128c:b0:64c:a41a:3a65 with SMTP id
 956f58d0204a3-64cc2ec0b28mr1369573d50.13.1772177129283; Thu, 26 Feb 2026
 23:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227052031.3988575-4-memxor@gmail.com> <b723f5e88ced0c432994c551869d190173f9549849f347039aadd1d405150aa2@mail.kernel.org>
In-Reply-To: <b723f5e88ced0c432994c551869d190173f9549849f347039aadd1d405150aa2@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 26 Feb 2026 23:25:18 -0800
X-Gm-Features: AaiRm500S1ZpwCeHR6Rgm-IWAx5yKkTpZy5k-0_ubtaZl3pBTqosMuvmQz2f0JI
Message-ID: <CAMB2axNsEOgV-G2AviV7nwzp2H__8iXcmdKPsgZHxWspk2QKkA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/5] bpf: Delay freeing fields in local storage
To: bot+bpf-ci@kernel.org
Cc: memxor@gmail.com, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	yatsenko@meta.com, kkd@meta.com, kernel-team@meta.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 10:00=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_stor=
age.c
> > --- a/kernel/bpf/bpf_local_storage.c
> > +++ b/kernel/bpf/bpf_local_storage.c
> > @@ -164,16 +164,25 @@ static void bpf_local_storage_free(struct bpf_loc=
al_storage *local_storage,
>
> [ ... ]
>
> > +/* rcu callback for use_kmalloc_nolock =3D=3D false */
> > +static void __bpf_selem_free_rcu(struct rcu_head *rcu)
> > +{
> > +     struct bpf_local_storage_elem *selem;
> > +
> > +     selem =3D container_of(rcu, struct bpf_local_storage_elem, rcu);
> > +     /* bpf_selem_unlink_nofail may have already cleared smap and free=
d fields. */
> > +     if (SDATA(selem)->smap)
> > +             bpf_obj_free_fields(SDATA(selem)->smap->map.record, SDATA=
(selem)->data);
> > +     kfree(selem);
> > +}
>
> The smap field is declared as __rcu in struct bpf_local_storage_data:
>
>     struct bpf_local_storage_map __rcu *smap;
>
> Here it is read directly twice without rcu_dereference_check,
> once for the NULL check and once for the ->map.record access.
>
> The sibling function bpf_selem_free_rcu() in the same file
> handles this with a local variable and the proper accessor:
>
>     smap =3D rcu_dereference_check(SDATA(selem)->smap, 1);
>     if (smap) {
>             ...
>             bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
>             ...
>     }
>
> Should __bpf_selem_free_rcu() follow the same pattern for
> consistency and to avoid sparse warnings?
>

AI is right, but the rest looks good to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/224742=
16888
>
> AI-authorship-score: low
> AI-authorship-explanation: Deep domain-specific BPF local storage and RCU=
 chaining knowledge, tightly integrated with existing subsystem patterns, c=
haracteristic of a domain expert.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Inconsistent access of __rcu-annotated pointe=
r without rcu_dereference_check and double read instead of local variable, =
will trigger sparse warnings but is not a correctness bug.
