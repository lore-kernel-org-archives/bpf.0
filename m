Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB01376A1A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 03:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790565841; cv=pass; b=myNhG6jaBIQJdbitq0BD4hvH8OMP8uA3I87kNuVlv2/dBM3tM7UqQO6N2lvhJFnEd9YSkh5YjMe/Z8xixOwoMv9k6MG+nkifPvPNOh+ut3xZFv0HHeKy+SBKqAwctv4Xh8HxsO+c5sb9qhMUsQrqA6TbNdOE9ACzM5/Hy808s1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790565841; c=relaxed/simple;
	bh=t1IQEqIjCBwZZIxvdliQr/avoVNu2GRtPs5ChSnYCfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEYU0ovuaEWY/9aKCn8tUrkG40Jt2vyVJNM8BcbVrP8agF65AFf2nqqFk8DPnA33YuBuAzs7frsj4gDJdtNB/AEmZ8GC4vhJktA2kMAE7ckZsfHRnBdELvoUd4P3v48jz2a8fKxVAb81aHvO+VuagTj+bYFfGtKcH+nrSoBuvjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrxXDM8D; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrxXDM8D"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8659af7454eso27657257b3.1
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790565837; cv=none;
        d=google.com; s=arc-20260327;
        b=rlxUI9k9N58TmyKW+J4kKmN6oii7S3M2IyZSKIIL6VacL+GJiM60qQLpRO+O5U+Lpi
         JVu14oRASGnBWydbPWQu1Vn/JDtb0kx78YFZMpL4RPx6pE79BRQBF75QIOnIOx08N4F3
         GPoZdGIiaqPk24NPgRR9ZzZMlhoVnqbm4SWHW0nihuQoPX3YABAUzgKydPl8qK4NdMXB
         dc7XasndV2oj1FDMCblzLoWHL8ACSEd30dOPyFOoSwaZszvUjyAfnIKkpjSFiTZkU0Js
         79s8a23XR9sxeMi/2+M2swSjBI4BCk8K64xkPMjTWygeMP0ePdM9eOTei8XEuriRhKO1
         yt5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t1IQEqIjCBwZZIxvdliQr/avoVNu2GRtPs5ChSnYCfg=;
        fh=0777sipYr71jHz7j5N2S5U5k+x12V67R63XnvGdF8pY=;
        b=hU1XiiO2+TM80ye2yuRjQTdaoWzvv49onS/7O2w8qMhwVIPvRQ6HalBkZVdZ89cxJf
         Yl1E1f9J0krasrqiF/kff3OWov1vZZv9ZnnwVkxGUHEaNNQNq94XfCb4R76Jrd2lCfJW
         gDOZrEgWZKbr6xEYfOLxYUWCGlSoTYNFvRNcf1NU817bWFtwomZGVS/rfIlIWC3eq+fS
         AAZwZ82SkI/5aoVLU0rSL/VgzWGMIQlUJEesTBJNR66CourZZ9Kotnwu+o7gwBqnberc
         TLKXXzYhlI2w0Ll2jLSaghtuoG8FZNAwS1CjQ9NDsQ5RYIFb7B1HFR31kwGWxXcXO5Wp
         OEIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790565837; x=1791170637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1IQEqIjCBwZZIxvdliQr/avoVNu2GRtPs5ChSnYCfg=;
        b=qrxXDM8DVJbLM3aRXZ8qIGu8mwDVY6d45qU+d7J9x/Jn6S3Fli4QxLAc0VW0C6Olp7
         SM3oayTFpxisbV/PjdPpbifLlsQqNGb39LF9YfsZXGicPAlx4sZvzJ/4hvqfn+6USluK
         kkDtV706sLpAXCG8WMV460KaVjPSmL1sdl8qxRCZRigbxD0fiEvJ93q/WtdleAdi3rUy
         5qrl0nO3RW6nnof6qK/507/25yPbLtwO4tftv1L429vieHH+sg0SR47Po1nkdOoLxa+k
         RnCovbwgcnCa4/JO2fpdPh8BrIvXGl0L9QF2Ovx3Q+Ve7xwKwhWWNiWhME9aSafhlVcN
         An9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790565837; x=1791170637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1IQEqIjCBwZZIxvdliQr/avoVNu2GRtPs5ChSnYCfg=;
        b=vukQ+crRxgX4DQXFdnODiJQPTsX8qiocVbOibuVwPlob8tyW4BbMRyMgWiM6xxpYI5
         mgaigXbV3QpWIK1EJImOS3Si/ZnFKeFFhnS5iuOIO275kUt+7DKkjt3faguH2hAcCwVI
         WGN/PCN9Wn9IYbHrqxcxKSXLE5bc0LGbFkstZGftybDfLluN0Jd7b71eMNvRhjgvqyJn
         wXpVxn2oFkKyQwuTKReVxIu0iaB8knBVdekKuj5gTCoDzIBgfaJiQF2L17JByeSmS4SO
         9DDBYruA4vuziJoIdbOy5oKmSp1xCyL22Dp4OUZkdY+g80fkrhMmJJ3KktUi8oE+8i/P
         ePlg==
X-Forwarded-Encrypted: i=1; AKwUvBw54jP2NGP7t/CHDDQhkXAUWAzQDyK7Mj2AhtttlODxjGePL9hgYRTMwzLSBvQeOOE1COE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3FKx8nIXVeCCm8t+Ws0TRQNNMAqZBegu50mo0mJnTCHVpJC3E
	3x8IPxOA74s0zFTs6OdETwnU/WNNK2xbdSAD15/p8MVZJTiGskzPpwJz7Gpyb6NE38WQms20jev
	S4gXd0YDAAI7FM/3aGnPxiUCwby1gwws=
X-Gm-Gg: AYBFou0oSm8pPJmaZ/dWuWuwnx5OuuYh19bO1Rg4+rIvYx4s8Nef6qQR/IecIMdyORV
	mWvaMriP83C2uDvm2AIt20mSwS3s0+iiyFzQKXCUMJjfGIR0RzXz0kWl3lu2g14Yf1N7/xgqo0a
	kS1xrVOADtAyfJY5eMoaSms/NaiqXrTdP35/Mvr6iuaeMOCebpDjB7oetL3ssazz6ymfFLz3fBU
	U6DuJvQO020qgdDgsQSUNB6SpdxAcrWi22mMUfmyzJm464vVUNOp+jxI8PqwTMsFW1s+pIIfDD9
	dVu7cFrZLsH9r6XFDCH7eF2kFDroR2vrRLkOfZyahF8wUr7zVBFf8RHVljBO2AEG8LATLB8TJwW
	tbpFDm7foMGCmPVG+Pz0G3w==
X-Received: by 2002:a05:690c:c4e6:b0:8a8:4931:61b5 with SMTP id
 00721157ae682-8a84940aad1mr42888027b3.30.1790565837502; Sun, 27 Sep 2026
 20:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921192559.2619635-1-shakeel.butt@linux.dev>
 <CALOAHbA4EgGw_uWfbXD0Q87exP7ek=z9ENuU_ARgb+DgBgy1kQ@mail.gmail.com>
 <arPyspcEFNkqfNyr@linux.dev> <CALOAHbDKRw9cPN_GxOYbp9u50cvr7PzPyoGPsSwoPDPAwBCGbA@mail.gmail.com>
 <arWJBBOdvLsOSdCt@linux.dev>
In-Reply-To: <arWJBBOdvLsOSdCt@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 28 Sep 2026 11:23:19 +0800
X-Gm-Features: AclHuK_1E2YfKgYgZbd4tDw3yFNtrrBUY1yd8dRRWaf2ogOVKnaFSdEC5R5Nlks
Message-ID: <CALOAHbCAtEixXTvRaF0qtGMjNwMHtYBL1eQU6GMgduRaWPGOmg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] memcg_ext: memcg policy through cgroup-attached struct_ops
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <jp.kobryn@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Michal Koutny <mkoutny@suse.com>, 
	Amery Hung <ameryhung@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, hui.zhu@linux.dev, 
	Donet Tom <donettom@linux.ibm.com>, Greg Thelen <gthelen@google.com>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 4:42=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Sep 24, 2026 at 06:01:27PM +0800, Yafang Shao wrote:
> > On Wed, Sep 23, 2026 at 11:47=E2=80=AFPM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > Hi Yafang,
> > >
> > > On Wed, Sep 23, 2026 at 09:07:40PM +0800, Yafang Shao wrote:
> > > > On Tue, Sep 22, 2026 at 3:30=E2=80=AFAM Shakeel Butt <shakeel.butt@=
linux.dev> wrote:
> > > > >
> > > > Hello Shakeel,
> > > >
> > > > On the open question of how deferred debt eventually gets paid: wou=
ld
> > > > it make sense for the policy to also notify userspace (e.g. via
> > > > ringbuf) when it defers,
> > >
> > > I think the notification through bpf programs is already possible and=
 a bpf
> > > program deciding to bypass memory.high can already do notification vi=
a ringbuf.
> > >
> > > > and have a userspace reclaimer do the reclaim
> > > > through memory.reclaim?
> > > >
> > > > I understand one of the concerns for the async worker is CPU
> > > > accounting. If the concern is that the kworker's CPU usage is not
> > > > charged to the target cgroup, the userspace reclaimer could instead=
 be
> > > > spawned with clone3(CLONE_INTO_CGROUP) so it runs inside the target
> > > > cgroup, and both its CPU and memory usage get charged there.
> > > >
> > > > One caveat: intermediate cgroups with the no-internal-process
> > > > constraint cannot take processes, so this would only work for leaf
> > > > cgroups.
> > > >
> > > > What do you think?
> > >
> > > I think all of this is possible without additional code and with this=
 series.
> > > With AI, should be very easy to prototype it. Please take a stab and =
I will look
> > > into it as well (time permitting).
> >
> > An LLM helped me quickly implement a userspace async memcg reclaimer
> > based on your series, and it seems to work quite well.
>
> That's awesome. Please do take a look at the code and provide feedback an=
d if
> you don't mind, a tested-by tag would be awesome.

For this series, feel free to add:

Tested-by: Yafang Shao <laoar.shao@gmail.com>

One nit:

Since we might extend the cgroup-ops to other subsystems, or even to
the cgroup itself, could we define a more generic CGROUP_OPS instead
of CGROUP_MEMCG_OPS, and also rename `struct bpf_memcg_ops` to `struct
bpf_cgroup_ops`? This way, we attach to the `struct cgroup` itself
rather than to a specific subsystem.

--=20
Regards
Yafang
