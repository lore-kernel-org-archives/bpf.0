Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85F2C11EE
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791939977; cv=none; b=IU4hjYUqIwxjWNy2XRr0Hv1P0OJ/lNpaoB1/wheSQ7V/Y0aRJefolhU/UkWsoQu7qlRQ9X515a+yY3ljWV8z2Qw/H3g5DUDEDOgvfA486BWcLJPiUHbGE8mrGdekM1tF9L4aNB5AejPkbChsbirQY2AXq8ZlWVuAeUpvm0xA/RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791939977; c=relaxed/simple;
	bh=71/PvvAb7WSmpjfyFsK5RUK37uILXm+z52T/Z/Dn6Dc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pB6bBduzjwVGlpZiCB4bE6WB7PTzsswY9EFLe1llAUzoUcWfEhmtryxV/mPXJKrRkqnp055WWkHO18o8wQF0UYle/ajPQ/NqEjRyiEXP3zjBh/byBC5tjj/+tTo1I9dKWTHilzRqbjjmKO30ldyvGwn84PWyJJMELthKloz+/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnTSesYZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnTSesYZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so1629326a91.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791939975; x=1792544775; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a017O8OGvPiZ3PtcPvdafG3s+KiqjGCu5jaYmz2r3MI=;
        b=YnTSesYZmUPxDL3ZOX7iQEscaZgAns5xYVIi6KODVK3mDQmXAAZNCeot9rcy5jlQNy
         CG5JDtBbAGwzKqIdraaQ6a1yAG4JTNQ2EDqxo7cBOvUdlvDPtvQZoPe8P7TzjNBjs3qA
         TWglIuNKC0aEXYerTn2Lu9ixmjiUXjWwIsRGF58tEbAX5Na/aBALqsdcWX/Xabm93JbK
         xjEn/h5kxbuAUJ1bS8J+ey40o5KJ+BgrHDtmTd1W0OOo35JcZOWGkl2WYw/D0735g4Ho
         mziLdmtVML8klkHigrOAa1Q+OC4umQGXf8qysFzVG2zBHQvrsklmapZbVNizW/lKpldL
         jtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791939975; x=1792544775;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a017O8OGvPiZ3PtcPvdafG3s+KiqjGCu5jaYmz2r3MI=;
        b=IUg2A/Oq963BQuxhhKNUEZicY0BaBWtEi0F2nPeBX41/hoZTEwKKSWs+eKkj+7dKrX
         c0hboUEuzkw59Qu4byx+OW0jGn/Zxv3uROJrMme8PxNW3GDGw93rFhfH8yr4ML2RuV/2
         QH24AZl3Frv8Zo767/SSgkoyBajy0IljxWyQP1T4X8T2OdU0eBR6EVNnxX9jbjHSy7ZL
         3SZLTmafoprOtxkoGuVqwDRAp7ZUIjfOzzQdVASWnxoO0OdGzuj/qNZ8JedXl5JMECE9
         JUYcdSYICBJHZtT7Yr6tTT5oAMRgog4h/LbcVAOowJTzhcWmlvrqa7ekTWvbWJXvOYvc
         pwfg==
X-Forwarded-Encrypted: i=1; AKwUvBzEuLwOAi8NG4tGS7+tDavLwg7unpay1Mn2giJOxsWNIOlxHmwagZYUVxrey7mRdq1SDcs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeSR/yENMQb8wwy2kIYnNBnl1BmnRcZEWVy4HTwegOYGTkp+HZ
	3cZjIPScXvSrQ3l6MLNcaqIgO8dI5/NjHZRzvczzGMtzoEGzWMU+8+pMLBDmPA==
X-Gm-Gg: AYBFou2NhHFCtT5+8Wre5/G3yNKVvQXD1CgAWQRG6ZBot+cH0oqzj6jm3wFCGRC6Ljb
	hZhZZY3HUP+FQJz/fDQ+R6XqgsfBGOTXuw2EUO/VPY1GEPW6JcjQVAO0XlOYvyx1VubtTkzCYCK
	mCEgDDjA2UTvVtM2jybX+TcQH86wPGWDYdNUDvLZuLow3e1dPO8ZIIqRhM+Gjky8Vs0DkEfo9Pk
	YP/9mWfk+vbRnIJ1VaOZhhpItvmXMXiC/+86FMSeFcwLaCYh8aBoVcsaeOxhp/Es82/QQB4yxX1
	jGWG4gVLV4DBgMpI4ebMXdyQ7xxXAXnWYTeXyUmirhFGqb6FY+et8EW/OJuGzr12zUf34lF0X4G
	wWtDv0+E/efBW9iAJ2QgO2qqf3jSbMecB7gm/YqtwIxlmlD0fH8tAaQe4bKgGAP1SDFsUbtYQnj
	n2OCZz4Y23omkrhCaLuzegW/S0AUcjw99HC2u9vo9sCZBnKyspJ4o8ertk44951XCzkTp9uClj2
	Czos3BLv1ucxa8Whnbl9F6H7g==
X-Received: by 2002:a17:90b:1d4f:b0:3a4:a592:4cfa with SMTP id 98e67ed59e1d1-3ab3a79d9f8mr11670070a91.45.1791939975320;
        Tue, 13 Oct 2026 18:06:15 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac60e83ccdsm1867436a91.15.2026.10.13.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 18:06:14 -0700 (PDT)
Message-ID: <e55e3220b1dc438bf3ba3363730bb1d927c2a27a.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix state pruning regression in bpf_loop()
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	yunwei356@gmail.com
Date: Tue, 13 Oct 2026 18:06:12 -0700
In-Reply-To: <20261008233623.4011127-1-dwindsor@gmail.com>
References: <20261008233623.4011127-1-dwindsor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-08 at 19:36 -0400, David Windsor wrote:
> Commit f597664454bd ("bpf: bpf_scc_visit instance and backedges
> accumulation for bpf_loop()") left dead stack slots in cached callback
> states while SCC backedges were pending, defeating state pruning and
> causing previously valid programs to hit the verifier instruction limit. =
On
> affected kernels, ActPlane fails to load with -E2BIG.
>=20
> Removing the incomplete_read_marks() check from clean_live_states() is
> safe because zero-branch states have already had their stack read/write
> effects propagated into the liveness masks consumed by
> clean_verifier_state(). Pending SCC backedges only defer verifier-state
> precision propagation and cannot add stack-liveness requirements after
> cleanup.

The patch does not apply, clean_live_states() no longer exists.
Also, before submitting v2, please re-read the series [1] in order to
understand the motivation for the change. States w/o branches can
still contribute their precision marks to their parent states,
in case if these states form a loop on a state graph.
The loops are formed on e.g. iterator or callback-based loops convergence.

[1] https://lore.kernel.org/bpf/20251229-scc-for-callbacks-v1-0-ceadfe67990=
0@gmail.com/

pw-bot: cr.

>=20
> Fixes: f597664454bd ("bpf: bpf_scc_visit instance and backedges accumulat=
ion for bpf_loop()")
>=20
> Signed-off-by: David Windsor <dwindsor@gmail.com>
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e3814152b52f8139a5565b2e4ac1b80d82d1ea65..1e300ca71a8a833eb4c2a340b=
4f94342f54af5f2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19791,8 +19791,6 @@ static void clean_live_states(struct bpf_verifier=
_env *env, int insn,
> =C2=A0		if (sl->state.cleaned)
> =C2=A0			/* all regs in this state in all frames were already marked */
> =C2=A0			continue;
> -		if (incomplete_read_marks(env, &sl->state))
> -			continue;
> =C2=A0		clean_verifier_state(env, &sl->state);
> =C2=A0	}
> =C2=A0}
