Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4A73815DF
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789328502; cv=pass; b=FkMMtmYfmXMlj4XVWGlwZ8nEr0d19ywS20l6Vk5i+OZEsdXxPFkIOU7qBZvkjHrEMtoSveDaVGK2RL+a3bqsC8XDTVqWXzFiFiqJXT8ArnMp0OidLBbQEXWQTAHl0obj9ttRRYi83OlqvFl0amBz59XWEpNtt6+jVimALUx1V+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789328502; c=relaxed/simple;
	bh=o9YibIUfRxMjjHC8/Y22RaQ2wOjqg0OE/+77r3xl3ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taSBdBB0IMWZNRcplccwA8JUos+7LbefOHqR29mj8A/G+0wE+BbwJO8WNGGDruKZ7AoUUtGzJ7/Y3YnbDn4mxPG9HV3yfIHdPAzzKCP7DOsmuW/PA4ooYQmjMty8Bc0xPb24RU/IL5g0bjiFrfHsFFBcDiJvWVljs42sB5IDo3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I8sFL6Q+; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I8sFL6Q+"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so20154185ad.3
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 12:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789328500; cv=none;
        d=google.com; s=arc-20260327;
        b=qBUzZrVIbn+R3RcWtBXmqLQcKFcknUrRyUKheViTkp/PIB78FS4G48umVt/+XnlkJs
         TsnXaUtBPJlN0wsAgXFxxC3DFeNIfvAxSAcM26lFRLrYGUDchcFJbtB6GpJFjSBBX6FL
         vBqlJnqVIuPXSfbypaIpR1hj/9jGTxEc/YCh4XMDXDMMkk0+MGPMQCKf547AnI1b1EIT
         Anz0aYnjYd+FDUJs6ImJW1Lo2pOhCJiDcY3E/d5g7l+a0wF4rFO9Yd6EMNeK3r1S2gdO
         tzRmH2AdXtmuKgJ4vpS7CKJp3KDxUX019ripkd8pJtLodeKF0GKKPzliNl3QfFqhVB5H
         j57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        fh=O05ikhOKhVXmETy+Dd9C0tU/xxGQEy5avmcAXh7Sv7c=;
        b=YdLPMH9KmnIkoRCgGqGol1cCiM0NRtb46/e11I509oT6ho4Bf2rBArg0b32KMesaMP
         fMvpvS6yAiANqmjpacjOF+WPYQf8OzntFVOhHmrQ44RDdwzFyYysJwgbOzy5U1ZgqK8x
         Z8kskayuznyDwGGSEzFBR5PN3ToXwgFbdwg+43Web5Ws7Q3q3AGPYm7hzGngu1xbZTVR
         7dlmKQVQJaEd7T+CJd+gTOcnIOu2MHVliBOfL1AQPywQXcoZFpRL8XPRljf1Jv9TCwCb
         iDfMHKT71CffZSj8x++QYdCYK+mJeH95LiNEkX8R3BAgFXPiAFVZhvYffgDavdEcUK6L
         cGZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789328500; x=1789933300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        b=I8sFL6Q+DM54DS1jqLpHl8LRDH2BH3wEv2VVMVdWWX4l+pUbhvP+mXRK1LwfswtI5I
         LD7tXObHzqTooDWMioIjKrFTteqZd3F4ORV5tAOdJGwYq3OlCV8oCQWcc7SSUdXldKCq
         cqVIjuwPKnq61r2HBBrk+adoCp9DvIE0IgEBeWV1Z0ts8JRcIPrwfdWqRBPNS2unhtBm
         2NE6/mJLRJc4noJZ1zBUITBSFVMcarub7AnSWNG+1y6VkPibRKC5m5oHY2WosF58Xjtq
         7M2wPsAyaGi0jOjGYFpCj0hyCwbNtFFsTXCM2olkmAaF3EN5yIXsPR85Bq7Tv8+fDeK/
         I7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789328500; x=1789933300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oFQ8qNlHBe3RYmZfeSmFS5X2SDU60h3feX9FkdQ3Ds=;
        b=PuD6XIOjtEt32DiaiuuZJPu4qGVOdbQqHNrit4VXrr47OV02wUTcBP4q3ZEdHlhQj6
         UdkW3jWf1DwzSsWa+LDjnPx7oaql6/tXLAbuCZN8TH7Qyry5ywz3CN0UDOIAJ4+JVFYU
         3ir6pSE4sPO0NFY2d5fxXDeeoM/QCmJejTqMbopI5xJJr6zLYPrnZ1BJphIT2gbTEvHG
         Hz050HgMethQsaHdQ/BqHtnruY8sC+8RyAzWhNqRfG868llTsLz39hXm220RlzaEt8/y
         Los/GFQKM8TFJwuYgCZbs8ZUepHUd7O29dzSpjCoVu54kOREMmmc/b6pBNuA6JS6sLPf
         +J8g==
X-Forwarded-Encrypted: i=1; AKwUvBwNWPxSMt+zw94AlAkMumpi6mQwJjCpjD85DhrbA1ZFiL7FxbNz3LDSTYc2El9CY9XTqoE=@vger.kernel.org
X-Gm-Message-State: AFuF++m6Xo7wxhD2meufYBDustqK1LHlxvftTJqxJWlOAGpaboS+KnCo
	ADYt5JkG4eIouI4BxjPWeBfq0G6chGGR2O8i8SndcDVcq1UVGSuNdpM7PQ/4nrKmrpTn+5fFfSP
	SCsD+ONwzcV7oFrHIP+oRvqYqLFbtZf0XIpSIo21S
X-Gm-Gg: AYBFou0nazj4xVXt/Mk4j6S/hksCikYp9l2Xwi9di5KANOyis3DYjujAM03Bv6ehD2b
	uDdXbso3LTNVtCy6HFkzT4VvSdgqvSuy23nXGhK14p/w2yiz0KKIU743mvGKr5+LAIV08QOSyvA
	s1MDqTtTunu4anALF0nzvH8kiODtSnAFrjQwZOHXygHPxTXGSoOeavMK6ag7n770ZXbaTiDuv9Q
	TiXY8SRRxyS5v+1Bv0wDuTybsaIO7fWqOr17BQdt+8TkebNUiSWmKC5EApOXD1AcK3HvcJ1nSX0
	khq0ae3c5EKN93QflHgeioCGHtxd7w5W9LJGx4o2vElZveuCV0MFQsqenvQ4SipoFDb/rYYAwCN
	Im0XnKQNQQEhr8dow64fefw==
X-Received: by 2002:a17:902:f691:b0:2dd:4168:7bd3 with SMTP id
 d9443c01a7336-2dd41687cc9mr192016495ad.12.1789328500077; Sun, 13 Sep 2026
 12:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox> <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
In-Reply-To: <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 13 Sep 2026 15:41:27 -0400
X-Gm-Features: AcwNN1VcrFQxF6bGTrpFFvwHMnFPs9vUMnDUrZbPiYQYi52EcDs3N2117Jy3gRM
Message-ID: <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	casey@schaufler-ca.com, gnoack@google.com, jack@suse.cz, song@kernel.org, 
	yonghong.song@linux.dev, martin.lau@linux.dev, eddyz87@gmail.com, 
	memxor@gmail.com, jolsa@kernel.org, m@maowtm.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> >
> > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then why not
> > security/? kfuncs.rst doesn't seem to forbid this.
>
> because fs, mm, net see the value in bpf. bpf helps these subsytems
> to focus on their core technologies and moves policy decisions out of
> kernel and into bpf.
> while lsm people treat bpf as arch-enemy.

It's amusing to read this when just this week we merged a patchset
into the LSM tree for the benefit of those writing BPF LSMs.  If you
look at the discussion around patch 2/2 you will even see a reasonable
exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
the patch.  Alexei is obviously welcome to his own opinion, but I
would encourage those reading this thread to look beyond his comments.

https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idmaps-v3-=
0-920a1963675d@amutable.com/

> kfuncs are not stable. we keep refactoring them.
> while lsm folks treat anything within *lsm* and *security* as stable apis=
.

Most everyone involved in LSM development knows that statement is
simply incorrect.  A quick glance at the git log, our process
guidelines on modifying LSM hooks (look in the MAINTAINERS file for a
pointer), or even just the patch I referenced above should provide
quick confirmation.

--=20
paul-moore.com
