Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAA299A90
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582697; cv=pass; b=Jp4zLL7QmlZZL0OWiUS98k3Dyhj3TZmnqNPYmS+iYrFzStkIafBjCOm8ifuagKlcWoEKsNI6b4lKYfPj+vr7PLj/zL5Du5wPqY5OiXqxbh6/GomQEcBo+b1ef47wYR/+abHelluceqvkPL9uNoaAVvPszsx3pewPgMsJioONwGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582697; c=relaxed/simple;
	bh=wOD8+nIrHfHasakbA1qyZFPZCMVaOhbykGlCmEid/NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJxeVZ2PauczthnDkkl0COvWSJenq8G1HpiVntGpLThLolADbV3rHXGmNCPrDIe7xfOYBGUgUHnKnLhocn6ltdz9Km94qIBdx8RRt2vYDdlLJ5pDevvrrU8ZgBE+6Hgt9yhNCF/OREMB7bamRxNPh4IYw5VBmPiN7svkNU76QeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0p472l7; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0p472l7"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1649613f8f.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 20:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774582694; cv=none;
        d=google.com; s=arc-20240605;
        b=RIykR9XxKOiiQTrBT2Cg8ToQ1LrhvMGvnjmY3vieKG+68ci3gxu/mmtCsRShUV2M+p
         q47UK5ULhNjgmKb2qH7+iXdcxA5uwZlilzohUWtPQqqiFanbHyNXVSGbeoh30Lvtye6w
         4pTV5BlGmLQkCZC2zyv8amh/wZLKUWvCE3pmYCFx9YZALoJ1wxNJ3+AGs64hs22nX6HX
         U4M0dMkV2n8Sqb32hbmxMV6DrUi7C2wGXKHmtsbM9ZrdSnPWzWSvVTrZks5MsVWbfjS/
         LKY79Dfa7xqczkNaAqOj5yL0aYOSoNvIfLWO4Nxg0gGrYMxsjyQj+ax/KeOo42yct0qU
         EjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UTrX9fSZtG9Vob2stZ5K+N4QO33X1TT+KC1xgNF1vxo=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=aLvcACfhQnBqNwTlxenHCd4VSsqiGODQyCGLRjK3/UfjRdd+gageU5BNmcjdomHklu
         Y0neKpOIlcHLhCvGQD/pbYI5rWcDoLckjIZg3FfjvAqU2S/U1FtGjVZxigTr2JKhyXU3
         8mClefVSREwrvH9ac7SZIcbPncEsqKztK+TBr8t7dJxiz/30EKL2vllPxirkRSlnvMd5
         rf1tVpWArC/ulRffc6W/QBosy89KdsvR/XJSXlsXSahDreiaExoYYdjR0AO2yVN/8Vod
         UCWBUXHKmNwbfKdYBbNe6/65PJEUiiFRFPKCLr832srzxLBI7lNHBUZqwAI0Pg9xDlfV
         QL5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774582694; x=1775187494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UTrX9fSZtG9Vob2stZ5K+N4QO33X1TT+KC1xgNF1vxo=;
        b=V0p472l7vo2mAW5n0BDS0hwLvZ/keenLZTrzgLXX+ZeUj+qYUxIgRxiXQXlzbkXfWO
         Fw5RbuTmcCi5Ng9fdREP0zjkNvTn9+j8x+wjx6BDXr5j3BZCioZup7qxoum171nstHc1
         WVo8WaE4Nw6kZhCspKDpPq2FBtbB99DaAw8pOEnIpQTJeFq+/YRcSR1sSfi3skaBKR8t
         zKCIs87O4CJaGsdE0/g9P9QGAhLCRH1jId98JKRPbebiQ2efUN6q74ji1JUXCRQf3izJ
         9DgyvhBk1cWnGciAHF4oM4obdpmKz7SZjrRwzsr9SYM+GPkcM+Ir8j6jjURr/bI3ykKf
         lb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774582694; x=1775187494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTrX9fSZtG9Vob2stZ5K+N4QO33X1TT+KC1xgNF1vxo=;
        b=an1/aFXuy4FXmI/18FHl/JAcnyA08Fp/29Fv273w5JFOOu3pwrwW2qynR2VXbqPGf1
         6QdXKKU6iS4EX8u1sXDO7y31ZbBzpi5zGNWdecgH7/Tu+pQZlF1FaZrYQOPKjKlzdIYQ
         PLq1sLSGWk5ipYRuLIPgHPGU6UCwW5YX9gQCARPb7bGXK8fM4MzTM2kLnlKPB6e1cQyu
         C4d4hOh7uMUkG/MWOFA8Q5GP4S7d0988eMkz2jJg62kYANLaTkMWWeYYDdWHAJhXt0wl
         cSm0iEeKt0fQXlfjxF9iMbJfVLDya4+mKZOeK7vtEPv5lNnNWNYnTQPCR0yNkrC8R3gg
         WSOQ==
X-Gm-Message-State: AOJu0YzdAxxCskkr6INKbi239SQ8EYqFSjVlzF3dxX8xKmsDhiK28Qyu
	P5nMtvgiqhiwfunO9w3W6Q1LVR9EPgyLDP9bz8FPyPDDUrsllQGALopTNUmBd3golcj/maRnQPv
	C30ga3HmvDj6ZEojrapEfQlHkZ6UCTYE=
X-Gm-Gg: ATEYQzwdr+zI1U4CeGaClTwk7JlCF8SmFUJqxZ/SxsGMBdpPqO5z1ZWjZ1ITo3cCSKR
	rNsJfMMXM0JqWBKlXpALIONJm7c3p8QEY/dbXtvJVHUt3cuMbnl1OtgO7CKCu9aESf+qJlzZ1gk
	R0IU+RgNTOGwntDM42JYTudovIbQShrCYjNE2ZGakV1wtz9shWWwf6KJD6wtgvBie0T6xsIP0A8
	s24+x7qNbwGa8D7uCDhy+Hgg7Iq6tXrmZHdg3Dn3bVB823+Rp01ab4AEg57u0zqzFGrxKBf7y4j
	jDxiPPcOYq4oEuXQRCcgI3CVsHfUQYxdNFgaW8hDOfQwSjvsAnb+z1p9phoD
X-Received: by 2002:a05:6000:2c10:b0:43b:45d1:f449 with SMTP id
 ffacd0b85a97d-43b9ea775dcmr1023947f8f.51.1774582693927; Thu, 26 Mar 2026
 20:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com> <20260325-kmalloc_special-v1-2-269666afb1ea@meta.com>
In-Reply-To: <20260325-kmalloc_special-v1-2-269666afb1ea@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 27 Mar 2026 04:37:37 +0100
X-Gm-Features: AQROBzB91tSX7HP--cmiL6xTN2ddBXL0gH0NMksvoEJ8AWIbRWRwUJII_snSfeI
Message-ID: <CAP01T74SDG+yAp5y3J7u_3=TtBporsykcnUCDnFsxKBVGTXeBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: Migrate dynptr file to kmalloc_nolock
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 22:12, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_rcu for
> bpf_dynptr_file_impl, continuing the migration away from bpf_mem_alloc
> now that kmalloc can be used from NMI context.
>
> freader_cleanup() runs before kfree_rcu() while the dynptr still holds
> exclusive access. kfree_rcu() then defers the actual free until after
> a grace period.
>
> Add struct rcu_head to bpf_dynptr_file_impl for kfree_rcu().
> ---
>  kernel/bpf/helpers.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b197b6978f1a..b349c8a34e50 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1736,7 +1736,10 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
>  };
>
>  struct bpf_dynptr_file_impl {
> -       struct freader freader;
> +       union {
> +               struct freader freader;
> +               struct rcu_head rcu;
> +       };

Sorry, this is confusing to me. Why do we need RCU gp wait before freeing here?
bpf_mem_free() didn't do any RCU gp before.

>         /* 64 bit offset and size overriding 32 bit ones in bpf_dynptr_kern */
>         u64 offset;
>         u64 size;
> @@ -4427,7 +4430,7 @@ static int make_file_dynptr(struct file *file, u32 flags, bool may_sleep,
>                 return -EINVAL;
>         }
>
> -       state = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_dynptr_file_impl));
> +       state = kmalloc_nolock(sizeof(*state), 0, NUMA_NO_NODE);
>         if (!state) {
>                 bpf_dynptr_set_null(ptr);
>                 return -ENOMEM;
> @@ -4459,7 +4462,7 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
>                 return 0;
>
>         freader_cleanup(&df->freader);
> -       bpf_mem_free(&bpf_global_ma, df);
> +       kfree_rcu(df, rcu);
>         bpf_dynptr_set_null(ptr);
>         return 0;
>  }
>
> --
> 2.52.0
>
