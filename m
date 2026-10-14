Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665237B015
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948271; cv=pass; b=ULyDIO4ylmdlTrb1dwmmgT/rUYGPBbufYnCKuk2Z/AWUzXZUExNK6BrCmQ9N5aIDrc3JVnLWZo3pJKesZw2w00YQ6/RH+FgFxq+zZTwCIT2fVAXMv+owfsCCifs63p+dMxxHyM1+hY3E+zjX+BerDwZHBt7owiZwtElgTOjb3dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948271; c=relaxed/simple;
	bh=7WV/PgD0jc90ZfW5o6KBecMjjiz2ATBD8Ix0KIOuLqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qtc/qnfs+H7mIXfDmR7DMuEod7bMwSsex92w0VDpgcEjFmaZ/HcG8K5i12r0ojheo9QgJaBwlaD8iPFgK0nwUyPKXpIHIZg8tuVEIQMFXIfrJ3SUCOo+KW1MzMGoW0hVyTLgKN1ayhSVvZwQ9BwD701W2C9+3Tp3FyR4kETcMEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oEri3Ohl; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEri3Ohl"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6740e7ae219so2833957d50.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 20:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791948269; cv=none;
        d=google.com; s=arc-20260327;
        b=KTYSPWUwIGFNAr959677ob8Ho331GVKI/CoPCtfGTFTl4f2/FCZIw/VFPQcsXItJ+n
         c/wAuRo+eqFTkGDP9kgcmucud58T7WkMWyV14/msb1riQa7GrLh89N0/8lzWABh11tKh
         VdVTKochIWLffnoyxoeOnagT8s5RgNasPfzJ0Bupts7fK/qs9nlyVGpakpFHLF381qm6
         SL0FOE7vS6KCLidmsGt7trzzmJ270d1/LUUNgKQz+wdriPGSiQ+Bn63BWyUD7gJDIv9p
         DdVLWAJzIlKnsYOw7P30UvsmLvl9SvTn7A57kHpAaHuqgPk2oeuts8ckTnWvKLP3dw9Z
         A+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5W3Yp3oK6NosuISWrK7hbNW+ZeNBXIIyZITKoeVCL+k=;
        fh=edEn6Yiwk9FbvGiNFpfoBQNmM3iwRpHMtyJCQ7z76W8=;
        b=HMixCYboAoxPG0sb293QGlhr8afciim1P3KRKaXsCn6DwVDr6VqyXw4/YdhlrBLIL/
         5amkGq8lISzSKgJwb8bVtVJkihtdNc58iOPpcwvTPAe6MpwsAq+bAq0tdkfQNMiOESV6
         Po/29OmF394hq2wsujCs9NQiyfHa5jZYNJwYF9NsuEOgFR/j9RPh83FypA0IKtdSYbJ0
         ae/NQy6dVAsH31wo2yxAY16G/CLM2M2XJEFNqKHTmmNmaYbnthpQ76L4y04+gv5gJQg+
         VPPgHqungnbDpi6JA0qhuHWvf8I/Na5aexSSJU1fBunY+SJDQXTy7JHJe1Bwj74b6aVO
         XfjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791948269; x=1792553069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5W3Yp3oK6NosuISWrK7hbNW+ZeNBXIIyZITKoeVCL+k=;
        b=oEri3Ohl69azgqvvm+qtmq20bwVL9rDPFvQSroQ/unXcByBKp25wv8wHPbUB7o/E0P
         Xjgrg5/XhIbfTuAghG2FbNfdmOHuR5+1eyX63dAqh3kVdRanbtTyJMkCb8v/sExJkEKl
         HpaoGXUdnDEiK3QaZ6Zm11gMLVXH8uMr7IDqTIF8zCSTBKE1tm4HX7RJm72GL4i2pMMg
         Q1TtxhsbvYDtYEtUXQDlss0r86VHX7pgGRKMZ9w2WaP12e5ERUlwJjDV/smzrsJLkR3M
         dQu3i6MDGoAHPh4QRtkYvCWg7KoYJolCie6Y2P1Hzl31B5reEiBu07jiohnRwY/Ppe++
         THtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791948269; x=1792553069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5W3Yp3oK6NosuISWrK7hbNW+ZeNBXIIyZITKoeVCL+k=;
        b=gzFTNhxTc+Jms6vNyQMDnrWveC0CxMJrgDihg505K5OxhUxXLqn77GFqLgpvv7D/+D
         B5xJYAIYMUjGhLB2Yakl8+fCO3plj6bqeLXD2+6GOxb4kQa09h4t3Jg0e+0XGMPewZYh
         CoyqZift+ggg1JarZE6S+Aij1fmYjWVDbKL8R+uR6hAXIreZ7Xnn75FfFrBcTlhdhGvk
         PmHURtfSrLJU1v+X+GRy6Gb3PdW4iSl7hr3Fu1loDapCXkTtxhoTCsmQALEHB/HutSJp
         rmtFh7UmV8QSEiPm+S4TsY90+zPh7Hp4PAjoKW9oZZi6I0jzwJI9G9YdVAyL9F7Blbc6
         UKqg==
X-Forwarded-Encrypted: i=1; AKwUvBwMcw909zBHKZP8PEFfeqrZ+gXtAZDMCzwaX2xbwYGzftWrPDlXD+PETbB+kVDa71rAzLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtqNRu+HIYogleF++1bNlWSeMIwRXoTkMk82kWLqI3IPVOf1/3
	TaeCNO+nLtirHsScBn5KDSDo+LeWUOt3adsLPlJPpORp6kur01uZWUXkGTXRRm/9MPWHg+NaAk+
	/EhP45Hk4ifQWxEOJh0+KmKSxe4emKMw=
X-Gm-Gg: AYBFou39vjttoHDr3qLNcK01EiqbWwAqdZsJrQturWdcBbXdc2NIxioyI5fDB22vd6p
	2b+6L2WvhnzWGu5Pix3VfycK3lNC8pPAiB2l1w2uA/SE2oEv4SaGCh6Bc2Wq4M3IfeWGLYWwdiR
	2ELqHiGL+nfzejXMw6/O7VVauX5H3UAdNqf2fN5J4F8BY8ZV1XahSg3GZQ8GyLIbplmHCe5kGkX
	W3dMGvijI4YJu2W1wg4PUQ+lN3nOQ2FsUSjuzg3DG7QoDY8kmUt2uPoW1TbRSqiQedPKBKp/q+J
	wdvvm3wMQaS9xmeZTUiw0OHedVqcUls7s9tLx8Ohthu1zOcSr5gVCr96fW0o5oK/wlJ6q2g0ncP
	OVzSqs5SvpQ==
X-Received: by 2002:a53:d017:0:b0:675:74c6:79d with SMTP id
 956f58d0204a3-679362ac182mr3741120d50.122.1791948268949; Tue, 13 Oct 2026
 20:24:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012120438.52849-1-laoar.shao@gmail.com> <d9a3367a1852158f60cc2e89677fb12f@kernel.org>
 <CALOAHbBE_1ssK_26c-UY7N6WxhkVNpB6v9WACVGaOiWZ5zchCA@mail.gmail.com> <3eda489898ebf7c848ce61760af745d9@kernel.org>
In-Reply-To: <3eda489898ebf7c848ce61760af745d9@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 14 Oct 2026 11:23:45 +0800
X-Gm-Features: AclHuK8rh2AW6bZVG8ZqRjg04D-kUz_OaCPBeR9yqJbXuPX4vDKYFO4Wi9z6gLo
Message-ID: <CALOAHbB58xLBdBOZCwJ=4yeKyvGvSsX1wfeAXehD2SGHSmB1+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] BPF-based per-cgroup NUMA balancing mode selection
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	david@kernel.org, gourry@gourry.net, hannes@cmpxchg.org, mkoutny@suse.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, yu.c.chen@intel.com, 
	zhao1.liu@intel.com, bpf@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:02=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Oct 13, 2026 at 10:16:32AM +0800, Yafang Shao wrote:
> > Part of the consults are keyed on struct folio rather than struct
> > task_struct: the folio surface answers from the folio's memcg, the
> > owner's request, not the touching task's.
>
> Right, and I take the prctl() point too. It's stable uAPI and too rigid
> a bar for this.
>
> My suggestion is to start smaller. The op doesn't compute anything
> from its inputs. It returns a fixed mode per cgroup, and you don't
> need struct_ops for that.
>
> A kfunc that takes a cgid and a value would do: -1 for the system
> setting, otherwise the existing NUMA_BALANCING_* bitmask stored per
> cgroup. Task callsites read it through the task's cgroup, folio
> callsites through folio_memcg(). Same capability for the use case in
> the cover letter, a per-cgroup field and minimal plumbing, and the
> kfunc can grow later if a real decision-time policy shows up.

That's a good suggestion.

I believe that will be a good start for other per-cgroup memory
management features as well, such as per-cgroup THP.  Also, it is
much easier to backport to older kernels and rapidly deploy them.

I will draft it soon.

--=20
Regards
Yafang
