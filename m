Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B650642E41E
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787827328; cv=pass; b=ZtjPIWXmC4VqNfGZmBlnSvQq62hFcQV19iShhUl7xaUlwouyRpQWdBK19G0fRkA7jz7zBOMZ9z1ahl7Bhki6WI9wxRN9lVYzBJHAcQZHx1xlRuGGseXcggHxHG84nK18KoW6kmGCxWnYo809QJsK0Oo9bEtNS2OjiaVLWRr+vsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787827328; c=relaxed/simple;
	bh=jDDNSeL3p69BtSLhg+WaA8iRlZDcoKpu7R79daNaadk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhKM+3wmjLvKGZjwiFICdECEukZUV4YokYhyrtZduATT0Cn/vb4gvRh0OzBALyL0twQHEPlLnMKSswA5M3A0Z1cJx7RpAD0Kh8jet5PQ4T6m5TCJy7hPkuecF4nUHQUnMca/orRkk3Rwi4E8+BEjOqsDDizfYFXir/YKANCuehA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIoscuDS; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIoscuDS"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b2ff8ca537so1636769b6e.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:42:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787827325; cv=none;
        d=google.com; s=arc-20260327;
        b=Lc2F3geA5P7LtuGvB+TMx7gbRBca/7L9riJvS5IgCXfLWTrZC4B1erHzFDa2sThvNd
         0oV8hni3NKTmb5wjfMpikajDSgtXRM/e9zll7JMy8R/w9JODLQDjtcDn7rmSDSaQlAxB
         ejE8D7tDgXr/FbDA1oq+XrzSh1CO1js9kopc82oT7Gz2CmV7huX3pnBr2lZKF4SazsDJ
         Yu6Zrw8mfm/I8OSCpgvtDIyJQvy3bq+8ChNV95lXJ50EEZew1tGfiU6uwG7csLcFNo05
         DiQNQ4b2GsKH+buKoPl+ankFOEO/fL9XqgpOsNK7aKdQEWzRWwFQVBMA0UK83vVOFqDG
         KqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        fh=saetIXE7knDfk0JSjCFEb4MLfso4JdWCfqVBZPFB0Ww=;
        b=YeoQPd6W6BWkASy7QQttc3BtiXAPu2G3jI8QzjUlNamSgCLhk8kTwH0UpGADgjZIrE
         Ni7blnLBLJXP3lm1rDdEAU8JKmcdyvh6WNMvSS5oQJ7PjexDU7726/DqCKQRZOM3pmcT
         lb+q1mQeGDYopdUxhx94b12lTaF1l/3Ihh9NhxE09RfU0GrVw9g8eNs3AC76NMawJ9o/
         FXXpmdy3rnaSTPXhN8fxJUDQfgBK2k+Cj5Kh3ezOqJxvLo9ZGCwlBHqY/afXG1cnv2Ff
         Fi837Y+CFl5NAc7y0DUEmlMIS7W3SVVczSAA7egUsXyRdrCuJbQPVfOSm3VRS+95WtBQ
         KSMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787827325; x=1788432125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        b=hIoscuDSaxJg+VFZqS/l2b+JNhKXL/OVF25XVpKMArgBdrop4SZ1gypl9wcAteGzRd
         EkE+eJHjRA3lKbiKUGSIkP5+HO5KUO5UHNxvpcjtPhVS0X7+TdgXwSgNq/K5LWIaaZtc
         4furVILxpOCh1vcsz9g0yO2/39YsGdeD3A9xDLs/YJ8U158M3SFt5XdcNAtr8d8WWTHx
         kZ4hfZQmoKQAYejMKvr/F2SHyZ7U/vQuhqvx81YixCINznTD1thCjgxhybuA2yDQWMPo
         cdPOlYZ5CZbhKqK+EKKp4Znz460txVJc6tLaWT+JLoOYwy+vIJW3YoyV61qz3jl6UfNF
         EhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787827325; x=1788432125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SW3eZUWQgcNcoxpUig7bTY5Pye+NgQJZFhS+SMbV1ak=;
        b=ECN9ygKIvx9olWUYBdezlCDmHFxetcFkqhWM5TsCYHXUOxdIP5swoD2/rWmaIl18D9
         4LHGyU6xOJ5d6P80gCaJ3iEx2PiEPu1Oi9fwJTkBZCvxNi0fbPOyO+hVEZwatIICNCbl
         kk6t4vcG05chj8kUGHlTBKDePqdM6SFvoRsZN6DWHPk+oHDhrPppvwhg5U0p55Y+ihHK
         aVjbjjhYsh0h2K0D0v/E4zvvbelttjUMe4R+7A5MN6wm4Vlwow12TimAcoaWxqrfSeqS
         TWb8ArW6v9m3qiRwiQUDIjUgeqmqzn75mYAivR0TIuwaWhwX1BK4eXQdKTSzfOk54dLw
         vX9A==
X-Forwarded-Encrypted: i=1; AHgh+Rq1+lz6zc3ubjn+TU1MemiABMuA7ZNqA8IDE392D1mtXmhCZHGdt9FSUFf/imLPlGA79ps=@vger.kernel.org
X-Gm-Message-State: AFuF++m2PUxChayFFXqtz+HVdoKEkUOkGpRLkF5hc/qbFohX0ItkGYRt
	jpkEp5wrnlskfCtX3lRVOAJ7kNDDD2ud0SazjYcehbR021lWOqkz9Z4GDOd8kQS0lXvAYFdygUj
	e09QD88rJXlvDg7kr33Gt9KUIcDgKA1s=
X-Gm-Gg: AR+sD12NwFF5nENOYJNjQXiYSiHmREscTD4nIp2kt2caS7jTn1CSkD+EaWG4BLvVGlO
	6abwuaw/61gg4XGExOAWlSktIjWnTxHZNexCS2uCl4/sxS02pVGRjd7BE/QguXfwNqesAIlXq7U
	xGoi8K7bBBQguKsPsk/ZY+QbRaRbR0LoxKUQSrFqg6gh+sQN9AfgkQrUVg3W+vh2kN3xgTVvjEk
	thmT2zXZq+xadzsui3UEOv0Fp0ZzqW5kFdFnVRAy4Kvl3RNXgT+FX5kXfAFIi+bnNuO6rxjuckq
	GWpBGflnmSgTe8KrVQhjjbQPEC78piQEO81KTXcvzhdA
X-Received: by 2002:a05:6808:15a0:b0:4a4:ed9a:e7ac with SMTP id
 5614622812f47-4b3669f06a4mr14189855b6e.1.1787827325398; Thu, 27 Aug 2026
 03:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827051859.45511-1-blbllhy@gmail.com>
In-Reply-To: <20260827051859.45511-1-blbllhy@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 27 Aug 2026 03:41:54 -0700
X-Gm-Features: AcwNN1UevfzNgu75Mwt-YYuX6NdsUL3CSX5zO7op3uaz_fQCeJoL4xqHlnCj_DI
Message-ID: <CAMB2axNFOC9G2RwOCnsWDth83REMWnmPE8gxMwbLYoGusw9miA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show
To: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, wangfushuai@baidu.com, bestswngs@gmail.com, 
	mattbobrowski@google.com, kees@kernel.org, menglong8.dong@gmail.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, xmei5@asu.edu, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 10:19=E2=80=AFPM Cen Zhang (Microsoft Security FORG=
E
Labs) <blbllhy@gmail.com> wrote:
>
> Iterating a sk_storage map is two stages:
> bpf_sk_storage_map_seq_find_next()
> returns a selem, then __bpf_sk_storage_map_seq_show() uses that selem.
> __bpf_sk_storage_map_seq_show() re-reads selem->local_storage via
> rcu_dereference() with no NULL check. A concurrent close() can run
> bpf_selem_unlink_nofail() in between and set that field to NULL, causing
> a NULL dereference of sk_storage->owner.
>
> Oops: general protection fault, probably for non-canonical
>    address 0xdffffc0000000011
>   net/core/bpf_sk_storage.c:809 __bpf_sk_storage_map_seq_show()
>   bpf_seq_read+0x366/0x1120
>   vfs_read+0x174/0xa50
>   ksys_read+0xfc/0x1d0
>
> Return if the re-read yields NULL.
>
> Fixes: 5d800f87d0a5 ("bpf: Support lockless unlink when freeing map or lo=
cal storage")
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Cc: AutonomousCodeSecurity@microsoft.com
> Assisted-by: Copilot (Grok 4.6)
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.c=
om>
> ---
>  net/core/bpf_sk_storage.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..7228520aa2b6 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq,
>                 ctx.map =3D info->map;
>                 if (selem) {
>                         sk_storage =3D rcu_dereference(selem->local_stora=
ge);
> +                       if (!sk_storage)
> +                               return 0;

As pointed out by CI bot, should this be SEQ_SKIP?

On a seperate note, __cgroup_iter_seq_show() also seem to return the
wrong value.

>                         ctx.sk =3D sk_storage->owner;
>                         ctx.value =3D SDATA(selem)->data;
>                 }
> --
> 2.55.0
