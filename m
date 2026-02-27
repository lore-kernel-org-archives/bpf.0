Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28BE345743
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772177198; cv=pass; b=bIYA31ZP8xkdTk6bIBvCqdBtmeYqqQSBSzhRq+NxzWjw/Sot+lSy5txKJgFln0EpGBIKPtKcqZ0K4TTCTP653WD8lpZ6YTWhnoXhPAZWCiqoRduFH07tiHyo6x/cDzfdF82tWbcVB5Hqo1B9lcTYloZLpSaDT4K80hwJUXfztEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772177198; c=relaxed/simple;
	bh=JSuey2RYmqcWR01mmcUayh8OmY/bylkTOr7ClqB2WiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CelXml006jh/vgbiEuItrQTI5tvyvnKhXkAXil+pAtvxmkSSj16YpB74U/02L/fXf+L3Co7Xlt6hwLK+FgGd3j9TSgB9RvASJ3irw0410F2Raf5SomWir/Ux0zp+LfvzP8L0OWJPR9NLaEYMw19DItwZbfOiQrLW+/DMxHPzHC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vac+p48i; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vac+p48i"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ae222d978so1499940d50.1
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 23:26:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772177196; cv=none;
        d=google.com; s=arc-20240605;
        b=VJpdLJmI5A/ptE5WpPkWyjWE2+aPrvYkv+WhBxYbqAs0juzCyDQvxhAA/skgRWb/5o
         vE/iDoU5NIvfg354GbmIjXtqgKSP1YCREEc/EE2sOeEY6gIZj9t2Mt4Xbv3j4zmT99P2
         QrPtV1mk1sYEOnhEnNzzEPNwtXb9UDAV4X1ZG0xpAAxCyJfDOp3GI9TK5nCcyqeWfrHz
         Y9QisDR1uHYTpIcvKhKaK8HYYo8TnYTpf1l8Cj1fF28WCQnNTfbnaJuaScWDhFYTuBvq
         BdRqXv0khALhEISYs02zwc3NK8QE+Fyh/WqRtbbyYuPOYeiIKGH3/piKezWfGqLlGBI1
         L4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0ZGXplqQqIH18k55Wy1dEqry0gemUDpUIbudkAcjhlo=;
        fh=vo0PVRlTFRdyipIk1BtI/XAW1vHByX8hbpOyu9HFgyg=;
        b=gWfwfv2Uo7JD6Rm2pCvH5zz1XmBIlYaMQdfrszjuex89jEwTLboo8MXMofhNmjM087
         OxzO20c7hvJX+fwM2rvwWKhU93Rn0Nt+qxfTjyqOMXxBp6+nxAloK3qLWnAwzE1gwGql
         NG0ABuBoXjTE6Z3/RhT6axlJZX5QPVhw/vUb/NCAsrpzHfEje3fl7wTeWC6fwUaWufug
         rDinLCd+pxm3C86TIUAs0p1s/khzgSSpWFScrufuZOrj3PklmNZEAnSVV0Da4FigfQPu
         sjGdFSxpqFXtzC5bpo1etz3PGkz9zrkl2XbGPVEiWX4KV7bQzU+MeEO0XeCDKtstyebp
         miuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772177196; x=1772781996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZGXplqQqIH18k55Wy1dEqry0gemUDpUIbudkAcjhlo=;
        b=Vac+p48i8r2i7pIC5PI3JOhK2QT02mJ9s0UndPOKyIEK+SAddjrFaohvsvunH42pr+
         fexG0Vv1d8gRWG4RvTftF8CcuQt6/iktKTy6hCEycGAFBl4YwgAn1JDdB/dbyoUk4sr3
         gpeGE/YUaheId88HYMvTmBiwN4YcLBpBuTpwiPTcXlGKAyUaAHkal+mI+HfvODc0bIzj
         asmRY9FxuqvSL886E4q1o/yCrImH2l8HjhhL7M9fk/7ZKtC4jmfyAYg1is7qNsZ4c2CE
         nEg7OnYnutSnuO7hoDz/bymHOohgd7vJ6jouhyM3R5NKZmmsE3ZkZZf1Bc/jo+JTn1yk
         41mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772177196; x=1772781996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZGXplqQqIH18k55Wy1dEqry0gemUDpUIbudkAcjhlo=;
        b=tEuEbWO3iccP5oaygaT1WbxQvNXMKYnB6c7rLsyrneqErReAbsNMaGyW+eHUQ5jfDk
         YlBvOgyHfE58mCoZdy9Eapnx9bbTWGEfnhe6cKVlLqb78ba6PJTpiEm8le2zSTl7n/Fh
         9Y5cNYqxjhJTC6fm9Kw5vwUhwT4Ut93MS6LC9JA6rkae/m9aPaeTf1O9uATAMLoSWp8b
         alV1aA4WbnXfaStIE5UjsSD4xNWh2O1jsx9TZHGLtNPqkSW3prcjrLEm5wEmigOBRZIR
         azKJwPVKfjEYklB1RTh1aClwH8fCRc3MBf2NRJQT1qBU7pxgGf/p+5t4i2+hqoQOw99N
         /pLA==
X-Gm-Message-State: AOJu0YyIEONUwr/BNLgMJjViveysGCpVicdHwVWMe/aMBsZFMaoQdWVN
	uN4qKBQfjl11uJGEEdCd3/jvQFLlMAqvp9k7D71XzCkk8C18HN32Mg/0ixZU1CiPn9sX3s5/3y6
	ZXG5zzRCDMF/Ie3zZf6RclFrLQJwmqR0=
X-Gm-Gg: ATEYQzzCR28IeQJZBICX5L1NOXETA+zUMebOpJDoXu0O5IV5Cmi8k3lyjc0esqRzCAU
	VblSgiiY4QTT5jv//gKtVmptPPuG8F4jO4x1vvgKTpgqYdEFAO0cbt143Gj8UuW58zKizP0QLRY
	oX9xbIgpdGsZ+TtWFBxhIryZgOiccrdMY2Q7JnkzTBxa+Ad8VHyyU3x/AYvSF2boH9cp7kU1svd
	rRbR1jQyXSzrQdRV3+de8mX60rRfy7MWgFD0UFFmtyJwdDCzGCg5EUgPOlWMyAeR1AJBKXNGAM5
	EvW+vfY=
X-Received: by 2002:a05:690e:150b:b0:64c:c616:c351 with SMTP id
 956f58d0204a3-64cc616cc04mr296327d50.40.1772177195917; Thu, 26 Feb 2026
 23:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227052031.3988575-1-memxor@gmail.com> <20260227052031.3988575-5-memxor@gmail.com>
In-Reply-To: <20260227052031.3988575-5-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 26 Feb 2026 23:26:25 -0800
X-Gm-Features: AaiRm52XZ5ufUTy0g1hONJ-wRLkCF1NfNLSt_h3cGr3-tjXc6g0cZfCGQPuobF4
Message-ID: <CAMB2axPbDpzmDgOteFkCMw55ss=0gTi+_mw4Em_f63G5CxTHVw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/5] bpf: Retire rcu_trace_implies_rcu_gp() from
 local storage
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:20=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This assumption will always hold going forward, hence just remove the
> various checks and assume it is true with a comment for the uninformed
> reader.
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/bpf_local_storage.c | 37 +++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Amery Hung <ameryhung@gmail.com>

>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 5cd874f911da..974bbc90fb5f 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -107,14 +107,12 @@ static void __bpf_local_storage_free_trace_rcu(stru=
ct rcu_head *rcu)
>  {
>         struct bpf_local_storage *local_storage;
>
> -       /* If RCU Tasks Trace grace period implies RCU grace period, do
> -        * kfree(), else do kfree_rcu().
> +       /*
> +        * RCU Tasks Trace grace period implies RCU grace period, do
> +        * kfree() directly.
>          */
>         local_storage =3D container_of(rcu, struct bpf_local_storage, rcu=
);
> -       if (rcu_trace_implies_rcu_gp())
> -               kfree(local_storage);
> -       else
> -               kfree_rcu(local_storage, rcu);
> +       kfree(local_storage);
>  }
>
>  /* Handle use_kmalloc_nolock =3D=3D false */
> @@ -138,10 +136,11 @@ static void bpf_local_storage_free_rcu(struct rcu_h=
ead *rcu)
>
>  static void bpf_local_storage_free_trace_rcu(struct rcu_head *rcu)
>  {
> -       if (rcu_trace_implies_rcu_gp())
> -               bpf_local_storage_free_rcu(rcu);
> -       else
> -               call_rcu(rcu, bpf_local_storage_free_rcu);
> +       /*
> +        * RCU Tasks Trace grace period implies RCU grace period, do
> +        * kfree() directly.
> +        */
> +       bpf_local_storage_free_rcu(rcu);
>  }
>
>  static void bpf_local_storage_free(struct bpf_local_storage *local_stora=
ge,
> @@ -179,10 +178,11 @@ static void __bpf_selem_free_rcu(struct rcu_head *r=
cu)
>  /* rcu tasks trace callback for use_kmalloc_nolock =3D=3D false */
>  static void __bpf_selem_free_trace_rcu(struct rcu_head *rcu)
>  {
> -       if (rcu_trace_implies_rcu_gp())
> -               __bpf_selem_free_rcu(rcu);
> -       else
> -               call_rcu(rcu, __bpf_selem_free_rcu);
> +       /*
> +        * RCU Tasks Trace grace period implies RCU grace period, do
> +        * kfree() directly.
> +        */
> +       __bpf_selem_free_rcu(rcu);
>  }
>
>  /* Handle use_kmalloc_nolock =3D=3D false */
> @@ -214,10 +214,11 @@ static void bpf_selem_free_rcu(struct rcu_head *rcu=
)
>
>  static void bpf_selem_free_trace_rcu(struct rcu_head *rcu)
>  {
> -       if (rcu_trace_implies_rcu_gp())
> -               bpf_selem_free_rcu(rcu);
> -       else
> -               call_rcu(rcu, bpf_selem_free_rcu);
> +       /*
> +        * RCU Tasks Trace grace period implies RCU grace period, do
> +        * kfree() directly.
> +        */
> +       bpf_selem_free_rcu(rcu);
>  }
>
>  void bpf_selem_free(struct bpf_local_storage_elem *selem,
> --
> 2.47.3
>
>
