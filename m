Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793979719;
	b=PCuG4tf/WlaI1cVAyGBXn3a36dm/X/jgrX2B8zrErjRLvhzbG/RL/csRJRlrLUy1ROg9
	 EI/sxHwZ4CqaMKXINnWq1QvDQUetR6ki7nt6LJUwkz1LcZVCI59PWQufhvHsM7oCl1rQ7
	 tMZaWOqS602GkN7VIldY6fWiQVzqr9Y75r5KJ5HpFkoNiIU5K7FbHrlQ4+nmancDWZDyp
	 86kCR70zCrsUUdUiCIOgZyBa8VaNgkxIF1wMeydIYVbBWl5bjYTMZPm92egeyt2qomECO
	 yvIcL1R4PCJ0HWCC1cYOQzsy0eK1UeaQrrLH5kz2cLvsVh+LsLU5yctlk2DIwYy6AbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
	b=wl0AjsVJR7ZZP135J57yyQxqlPYdLwQxo+r6wnkN6QSy0l4S09s76/CKfBvMirluxuoy
	 hs5u5x3hYbg+EUe5pVgR2vR3HN/xYXTwQLzUamFDrp/JJ9MngJNwyJnuZe5L/8zV7hXEu
	 JhTA5Cwa08TfFQ9nh/O6U+3+HMICrktoGalJdhpqXJ+cHNP/uJC+4I3f91Dzwa9HuJWBH
	 yggz+dFJUyJAMRRL7tMM2dfWxJeTBE6tXVpMyB7zWtKBOXZnGl1wjBytsBdoZDuEiLlC3
	 n+Zr2ib0A2QCOzfDo9TIluPcG4jULXa+OkoRQ8bJ4MuujfFtbpkOeqGGZ+g23jBwH4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YzzkId+7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1728606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 15:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1728606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=YzzkId+7
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso521513a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 07:41:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793979713; cv=none;
        d=google.com; s=arc-20260327;
        b=WgJ6/CP9S5EnVeYvaqzNKfMtTjleyue4YUlobD1PuoXYI/ZtO29pi7ZQRYbpQ5H4qF
         McD1RNLDK6YfOwhi7rEEl49DAdM59HgkP42XI3QajCQyf7HfveeT/K0H2IT8HLiDJzLB
         8DoAIIXVPmwEAzhSe5e8RGJo2LKEAFtTw1KHQ29kBrGCx1dcJQ8FdjWj/iGAUW7VTLms
         mp3kbaVZ/ZOZuQWXB3+ovsWL7Qkq3v+Ow+i7q3lbCZxvgli1WMSRo6lEhkyUQ++SnHzJ
         vTMTT7BTBt5EluvtTE1vZcNV/tIag7KMqZj0g3N2dMGvFxTGGVixAexcggukZe789gfF
         Fszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        fh=s19fgl0DEGAS2Uiq01VvAYklSSe2eVjZo7oWJKaB4KA=;
        b=C47oVPo5BFVmc2/54KR2i9/RxKTThl560CgtoysrEdO7Up5Utl3w6VXqfMizxTI9fo
         HGXyE7QlTJnauUBmQI6a5HJEUwz4j8BId5DibhMEAs92zibzKn4DekEdDtzK/R3rGQ2q
         4H36vrHtbsYpChZJ3HJs1EhDAR750AAItn+VpHQdHRhaRM2TjYoR/7ensinnb5xZlYZv
         CFHQr2oBc2cVpXETnGo0ceXv+HomZ0/Hz03TaPJ6KS8Is7Dbk9/XHniEv0pKtKFoohyQ
         jcRWELgiYc0yt/PwsjRNMvWCtob4hsbXAHmOMPbmXtYjtY6YIXKYQ/j39K/2AQkqqCQ0
         nD1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793979713; x=1794584513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        b=YzzkId+7qJWBrdgBc3KwfkNFPjAIr2flDfLUmoyshQtncc+Ndvd9sON1MwFGvz3rBp
         VhUf+70b8rH9KxwVnJgIiQ/o3uPTubnnQg4/6C9PTyoSOFCHY23cuoI6OZcK+UoSUnVD
         XtPEQzgxzHkAgFXXLZHstTRu7Q0W5sZ4WrnTsJlkN+k76PtkLxv2iUv4JboT/5HiggmU
         cd0o63pDvyV1UoBwxLbT3ijZr2Dxspu/UqNmNP0P8Bx1TbBSh4+hMra38mZz1yWkEPNG
         X05TDXL5cHFzv6snJstidZle4eSSYbEyRHSCA/H/ky8GhV+s8vXINgjx3rQ0Y0F3UC0T
         BY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793979713; x=1794584513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f5zCwiaGTsbGPs9eRvMEIe8q2LEwYAAZXAgxvtWlbgM=;
        b=HFcALrtCVjVZbvchT+vsscx1ea5ABk4PUuoM7kK+H0qCOrukW91E+01T9oD4P5uTt2
         3ZCQbBIt961oQNqrCNiCLMRmPSGwWpTLEFX2YOmTklqPScDoghu8YzyDwB3M1QXLu2oj
         +pju77ncLgA4Z7iXCXY4M0XOE1NRXB0ik3qL/gjHuRLWoVX10w73X8gVMUUjaGdVSbQ8
         PGJiYkB/W+dJIxU9VfBOjlgqGa0yFFdlubWLr3hJLjjyeXNNFj0tRIdyGwY+PEj2J/Td
         ksgK6BZItBfrbSv06JB3ufrlsckj7UgV05DtI9EUUyeGoFJ2FCeS4isQEkzSFESTPkq+
         EINw==
X-Forwarded-Encrypted: i=1; AL+hErEWURqKvExDQdWWNZk/hgtiTNoqH4byqvV78lB8F5LRd0g3Rmb5dNbD5BHGSAZAODzQTAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GzK7aOKLplLcT+M75pk0DHsbivi5rIce04kbVsIP/YE6pqG1Z
	LY/KSXdRZQRG4iHgQ9CYzAPTLR7XZO4CuyEcr0UxUA0i34lM3rUJ8cv8sWYyhPdaC25iUiz8qCV
	zg/Uu19Id7m380D+RbFYT/yG/4Z0nwZVMumOBoNA5
X-Gm-Gg: AYBFou0lg4Hmc9Ry4+zwmNkeuym8RcGWaZVZAsIJLvITsWj1DoQpSRJKjTmKf3YgVCG
	C7fDhk4DaTUEFUNxpl0MtkK//t1gMwvMWA8DfkC1P884y6Sm2ahObTUjjZ7+Rn0ZQ2JCcURgyQp
	iU7Xr6DAnqj7Hg2fS/uVaW6qpsxh1a+gQoA9NFMboziWnyzKoCGbOy9wzwQU9325MWuQQx4qDQ8
	Dl5nkFhLGcorxelx2va9+CZh+HqK4HWdnGVVVjaTwOQdjMtUhF3P19j0jB8C7xtZ3FQe6plHISt
	IOrwOukw8Zkdk82p353SZgsCD512rb1qejoEeeZ/pn44uF/dYkc1MwhkyKiBffq+98TaEIHuXkC
	XoO+t4JyX1uf1itTkWkv7ij5BVm6kbJq8WR7oo6GIKM2Z0QFnNKx4j7Fk0fJJq3HiyODU
X-Received: by 2002:a17:90a:e7cb:b0:3a8:bd51:205b with SMTP id
 98e67ed59e1d1-3b0db6dc4d1mr3040927a91.37.1793979713085; Fri, 06 Nov 2026
 07:41:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com> <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
In-Reply-To: <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Nov 2026 10:41:40 -0500
X-Gm-Features: AclHuK_vNxeGvLMu2q-_O9-3vD4QrJi4Z55I0p-SIXPf7gkTSj9ZotO9tBGrYyA
Message-ID: <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: roblabla <linux@roblab.la>
Cc: Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 8:39=E2=80=AFAM roblabla <linux@roblab.la> wrote:
>
> Hello,
> First of all, I'm sorry if I'm sending this email to the wrong mailing li=
sts, it's my first time reporting a linux issue ^^'.

Hi,

It looks like you sent this email to the right people/lists, well done
on the first hurdle :)

> In commit 16959c469f232f5c76cfb628297cafbf6dbdba79 (lsm: expose mount idm=
aps to inode hooks), merged in 7.4-rc1, a new argument was added in positio=
n 0 of various inode-related `security_` functions. Specifically, it added =
this argument to inode_create, inode_link, inode_symlink, inode_mkdir, inod=
e_mknod and inode_permission.
>
> This has the immediate effect of breaking eBPF LSM programs relying on th=
ese hooks that were compiled with BPF CO-RE and using BPF_CORE_READ.

...

> Now, I'm not sure how the Linux Kernel treats eBPF LSM hooks - if they're=
 considered part of the userspace that shouldn't be broken. My understandin=
g is that kprobes are not part of the Linux Kernel stability guarantees, fo=
r rather obvious reasons (they allow watching the internals of the kernel) =
- but I'm not sure if this extends to the LSM Hooks. I assume not. Still, t=
his kind of breakage is really painful for us, and I hope we can find a sol=
ution.

Like kprobes, the LSM hooks are intentionally not part of any stable
API promise.  While we try not to needlessly churn the LSM hooks, we
reserve the right to modify parameters, the LSM callbacks associated
with a hook, and even the basic hook semantics from one kernel release
to another.  The reasoning is very similar to that of kprobes: the LSM
hooks are linked to kernel internals and thus need the ability to
change as the kernel changes.

LSMs that need to provide a stable API must provide an abstraction
layer between the LSM hook callbacks and their stable API.  The LSM
framework is not responsible for the stability of individual LSM APIs.

> Could we fix this type of breakage by making sure new arguments are only =
added at the _end_ of the LSM hooks signatures,

I'm sorry, but I can't make that promise at the LSM framework layer.
It is impossible to predict how the kernel internals will continue to
evolve and thus I can't promise how the LSM hooks and callbacks will
need to change as a result.

Regarding the specifics of how the BPF LSM has dealt with this in the
past, and any plans for the future, I'll let others speak to that;
hopefully they will have some tricks you can use to make these
transitions easier.

--
paul-moore.com
