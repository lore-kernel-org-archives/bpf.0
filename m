Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B56284690
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930821; cv=pass; b=fpmWm3dZ3+OOkvcHsiIuBXBC6Nj4NpHXgkz1teEeFWFXP7YwHvYiOylT1Gw8Y255F0wwGbfy2HaPDnXkrUOesQFzkS0vnCEd37GNHDFceRrcZy6XFTix+5xUU2lcE1rZq8NDvCobUUVbYF3gG4vvpe84ClFDpNUZSd7q3t0jy7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930821; c=relaxed/simple;
	bh=NHi5bXagq2PW7+7GUvb45PHMMKBGFsAVR5cwXQ4fOCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFHpnO6eKjqMAcllVAbgPhrGrbk4IetqPyAZqfoaxg/w1HnKLOFGqnptzwD9W//otJDsyx9Uqs8IX5ZJ7O9PiC87qUQgWIZStiO1cYhf6maUl4FI+sN/ey1TbOQNx/7Ua0wO4gdVa3lnca7xTiAikwOCtwgBj6V8YyZhA7f4htk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bqebpa1m; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bqebpa1m"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-847a483e344so673651b3a.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782930818; cv=none;
        d=google.com; s=arc-20260327;
        b=PFid5t3dSCszphT3ZzmujMt2Fn+yPjSyUr7UQ84UEN1l/p5Qs5gng5s2yDhTtykCaJ
         t39ExR3YphmmqSHG2aoxeYc9T/Qcv1Zg71NwmGniZsYDqHcLQjnhHztKiSzeSt4D3OWj
         V88JCkT3hMiYev91BxQBlq95+S0hQUioy3prruF6bIRGeUd+raSomS+kj4/3aB4iYG0u
         fE/t459X5urIwTVuabkJebPM3KJ2Q5WA7ncl2uMDNz6HOHuJGajhfZox+4YkykwKT3TN
         E5/0wre447vmpJRhw7qIcAH1T0Ue12QG/ogVG9oFFGQ7iIPfugwqkOcVi+yo+mT+WOIl
         4AwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        fh=y0DhagFnXmp/ztQgawvXkbCxcisfFGp+MK57TM8+ksk=;
        b=bGN9EgcYHyzeEoEXE7p10LDHjREZyrHBUSt5NXJafuU8kzsJFHRUtrtIesprSn+/qN
         H9bU58n32lwX9cl+JqTPzACH3Dibg5ShRyN8IH4+DsCCmpRiSaiWgRMmxtS3orj30JXM
         PSc6YNe8HiyPljZqJkZgZZG8+Q1nLy8/qKTRBwsqYykB1wegdo8gsKuVgCOnUJxofkxS
         XDcgas0WqHQbhaJngs9G4oMG7hXKKSyTCKK0/lUj6+Tfe19VKnfjheovaZzOWC+4KP5n
         VgkzeFX6YFSJu8FUHf6sRekSmXpJA7vMRZIZqBlQ33Zwei2hONJyy+zsZprUpfPmP0Dp
         Cf7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782930818; x=1783535618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        b=bqebpa1mIbXWBS5CLw+k2UQhZPv/hVZphiqKb6GAl88kUJyeljtIBDo+z/gnKEbaKm
         nEp97Pm03i2ePlNUn5AlBrpCOiafCTcx7Hs53mUV0vLTu0TfHJqBgX5rhdscrAu+UJQu
         c94AnAq8q74qmU0Gi0Cm+f/DeYUhkIXH2p3wcEJ2F5Hv9nA06Z+a6Jc9vEh15ZuHr+0B
         o7xQ+t1Mvq6NzwWKhh1PFkijeyk+V6wTnmruRTkTPHtVmxXL2IMQrYAyuK/XP0Tgxu5k
         Yt86oT6dHkTPU6TZ1s2+X8UEADvJe5ltR7zY/XdKjeLGvsZXRFA8hvRoRQAfh+mxKdUS
         Ur9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782930818; x=1783535618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnl3zqI1JA5b/M0bVVPPEG7QizZgQWNx2m7hgpcgEjI=;
        b=AVgY1BKCJlQNHSXmdzBnQGQJXWnoHzJbvObGYt+emID8Vt8TL0aCFl/faqY/0QjGYn
         3xdmuNofBeAaG5NaKp2Bbzu4WPVxyKAfwybfB3D8Dh24tNwN8hJknrhrH5MQy1gf6V78
         CuxeLlq/hS7ObjT7JmmCoMxUV1ankbwyt7gSbPHw5oqqYcW14AxBKqy53viZpkfz1wa0
         XkwQZBdzWWTElwqDooXOVQQc1wLA+vMasGtn3QRGjti/Ex9CMWXdCr3UHy/L6rBMqczJ
         jH0trqzCtpOU6kL9NGaLXQgoC36CjnisD2iKFrGV3ZdY1xdqe2o88wAdW8prFRj3tFVt
         q49w==
X-Forwarded-Encrypted: i=1; AFNElJ+V+gey5Wcer4UdGo5a/EXg7pX62rvc8p/Sj+mRxnJyNo2cw8w8VLsPbaWHtx6hrMIx15Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8FpQpODMTtfSDWtRhWZAUGiD0GQe7TANBGqGPaFJiiQDcNczd
	Av+jJZajPQfgj5L6IiKKdtphmdTyXiz1K3vfvwGquI3vHV2wGH5EjDA44M5EzMVCR5Jvsa8VmH4
	3twCTXFtIHnVvwcQKhqq+/o0YwcmQYByqYpUYgvCN
X-Gm-Gg: AfdE7ckF1xoFimdI6i41v5V3bJJE3xOBFSnUD9Lr+Yl0nI8c8XPsCeUT6LLxo1xkoab
	6VMvLcwcg4GYN61nQyzO8aQE1koBLY+nI3SKVudldc4Ma1cZPuvr7cSkLk7s00DXDlYGI6PJiO+
	lTuFelBBKk4IaIkmLmnqvDPluBM3JxXghxq0YNwfPd1wTbUTAWOvdhsipc4f9FVLvyBL+8xCPuP
	maxJm4cYeFwohi5eaehhQTfv+o6wktEWbm9NTVH/PncidQLPdXLoqV3uownDGmrxVHmsIqJ
X-Received: by 2002:a05:6a00:22c9:b0:845:3608:90be with SMTP id
 d2e1a72fcca58-847a82d93d0mr6309487b3a.17.1782930818301; Wed, 01 Jul 2026
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <akVbLGYyafZq_93v@zenbox>
In-Reply-To: <akVbLGYyafZq_93v@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 14:33:26 -0400
X-Gm-Features: AVVi8CcSSANgttFtvXFj_mSXCnTrfkayt9zsVvnF80WzPHPaIUdOPirjWkOrJQ8
Message-ID: <CAHC9VhRp6pvQXskNU0FXBkDw=MAF8Ht1Mk7BbUeU8JnEkSk52g@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:29=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > Create 2 kfuncs exposing control over Landlock functionality to=
 BPF
> > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventin=
g callers
> > > > > > from accessing unstable internal Landlock fields.
> > > >
> > > > Generally speaking we don't want to provide APIs, either in-kernel =
or
> > > > at the userspace/kernel boundary, that are specific to a single LSM=
,
> > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > function as examples.
> > >
> > > I would raise bpf_ima_file_hash, bpf_ima_inode_hash, as examples of
> > > clear precedence for this. (BPF calling into specific LSM)
> >
> > The BPF IMA helpers were merged back in the v5.18 timeframe when IMA
> > was still standalone, it wasn't until v6.9 that IMA and EVM became
> > proper LSMs.
> >
> > > Kfuncs are explicitly marked as not being an ABI, and are more
> > > flexible for later changes / deprecation etc. [1]
> >
> > The issue isn't so much the kfunc itself, it is what the kfunc
> > *calls*.  From what I saw in the proposed patch, the kfunc calls
> > directly into Landlock instead of passing through the LSM framework,
> > e.g. a function wrapper in security/security.c.
> >
> > > LSM framework API can mean a lot of things. I assume you are meaning
> > > like a pseudo-filesystem mounted interface that controls LSM?
> > > Correct me if I'm wrong.
> >
> > My apologies, I should have been more clear.  When I speak about the
> > "LSM framework", I'm talking about the abstraction layer that provides
> > the interface that the kernel and userspace uses to talk to individual
> > LSMs.  The LSM framework is analogous to the VFS layer/framework in
> > that it provides a single API for a variety of underlying subsystems.
> > While not 100% correct, you can think of it the LSM framework as being
> > the functions/hooks defined in security/security.c.
> >
> > Does that help?
>
> That does. security/security.c seems like a good place to enumerate the e=
nabled
> LSMs and to check to make sure that Landlock is actually enabled both in =
the kernel
> build and that the Landlock LSM is up and running.

Yep.

> The above patch only checked if Landlock was compiled, when it should
> actually be checking if Landlock is actively enabled.
>
> So I will probably make a shim for it there that gates calls to
> Landlock.

Please keep in mind that the LSM framework API needs to be reasonably
generic.  We've got some general guidance on adding new LSM hooks at
the link below:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-h=
ooks

--=20
paul-moore.com
