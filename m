Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205C37417F
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773185781; cv=pass; b=byScnWZ+UJQHo3ap0nhL/cgBNS3rPujE57sdU059z/+PLkLzcfir95I5MoE6iT4Ih49wnq6GnUcvf7LtvSpblXi3/S4Olp+jVD9InDrN2/vnU+sFFRsod4B/F4PV3r/UwybIIofVx/KLcDlDAlXqOe6JuK7y5Can2idbsViiO9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773185781; c=relaxed/simple;
	bh=cpb8mqDFRmpYKIKskCTUA9C/d3pmkM1kzqMJVqC2AJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLV344LibuHbA2LJADxEvrydP4HRF/VYwZhpzQmlxxo+jXMh1ZR7La/x8+zNnkb7W0AzfeZnl2MnWYAIMM+jKRikzKoS19l/lKwmIRdokN91ZId2MQKi4KuRqKDWvyc1sSL9I2fDfzw6DAT1ojm66GJKTNLI4bjLT88K/2GsTRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+7BXY5B; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+7BXY5B"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-439b2965d4bso8006755f8f.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 16:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773185778; cv=none;
        d=google.com; s=arc-20240605;
        b=kSj23ohaiI9vUWsynalYKqP4iCprJtVB98cSTsGm3eFFJJcOgpqiIBzuu6RsyuXipK
         7QSI5kE4kXhRmu+xYipvuT5NgQRS33xxfMwOGAKkZgYoYXexF+JYV0oM+5nTN7HjiiQK
         Wb3kEhoVAMbdqlA8I+18C+V1YcQpDIwlFHeEuH/euRpccZ57TAGBzZH4M08gwOQiWli7
         kqLSMngYx+RPCSu7gVsNiAui8L5cG32gmSpLwr+9inUAAFLauzQwZNhSHc3mk/8jqPl+
         nRwUEqpjKZ8XZK0RMRFOW7mLqXFIx8w57xPuEGe6X7owYHaSmrdxpq6rshWh6lvDtKBF
         Uv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CTGMIsGZ8su7MVyph2nmo0XJvo8QDGO7hgQ8hialg1E=;
        fh=K+anEkhOE7wov71f1ntexiAs5bkQWpdDKo5k6zEv4fg=;
        b=LuPUUytnslcHB6ZOM62eBn5aVlMU6b8/VhNZ3qx6zC1voTmFEWlQ+I9hErefiXbtGz
         N1mfiXaYM1YeqriORxth8TFd6jEkz2qMZ+RUp0B6gvwty2SiMpD+zlpxDgPWXN2chBMP
         964lgoeY8DmuYVBOYZv/6BarnHCSHmEMqiM4egb9tifpXMP+Pw7SOTkHoCYGOBa3FxGZ
         bnSi2FvfiA7Dkkp+Spvg8sLuNYnm/t5PZtMFxZU2ZjyRHuyW64jCHAAoeUj5z4qJMczR
         cbXUTKlJ1V8mQDaow5OE98NuoeyRoKvVlb3Em/gb2IkCUOmtvWcteAYJkAk8dM8fumxL
         R9JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773185778; x=1773790578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTGMIsGZ8su7MVyph2nmo0XJvo8QDGO7hgQ8hialg1E=;
        b=C+7BXY5Bc+KglkFWulMnatrb7GK4kyDxicVz4T91gjfekAT7f458Q+s5F6F8Soo7gC
         aKNP/OLgirNInVR0ljg0N0IC7jLkelfMWy9zR1oMU4mRRnKxJo0EfZLirVBUvQpK0IWV
         PTYKGsEYGlOxiKXlDvh4yWqNgIqs6j8VhE2Bppx23ArMMM4Tay4mFUOCm0yel0zW8xvu
         /d+KQv4g8UDtgWbZ/MIRW1YfpAmpSVOOVuxSxsuynb8744nAeeIdUBxOyteCTvjTvZYV
         5q9mmPy2AkAaBFBiojmo+rfFp2LqSRKYCA0H9ojisyl+5ISxU9B2I0JBUD9Rsf4FAEci
         MrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773185778; x=1773790578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTGMIsGZ8su7MVyph2nmo0XJvo8QDGO7hgQ8hialg1E=;
        b=AilB3BUstd/j43aFXqS5XOkvaXrx7xy06V0q7bUV2WlrNCjGqmHIZ9fT9J5Dd38wSB
         s14Z6NRpOFEDh5namU7/vejncZP/Poa3/74QB+sZFMdGkgG6/g7H1T0cTXYdE6E0rson
         BSeQeKu9YXZataMY3tuRMPJyRiQFZbwvvijtohAugLVEbDxnzrx9C2mSkAUeRliWMVCP
         cYghOns/65TSa1ztP7o+W14cmVqy+BHvteQ9weoRex47qJuziwK2neAzfcyg8ovmexTj
         1IilGXkrPV66EmXSvRfV7wfqwEsiXMDTp1mYvrqB8/PeRYpeTBzFZ+nRFgri2VUlO8PS
         1o8A==
X-Forwarded-Encrypted: i=1; AJvYcCUx8Y3mZBTHMRJFkSg4ShmSjrVrlA/Xd7BVVeh3x4ibehgLN56iq/Zsj8UfiwmxfVk6ye4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4R4Mwi9r6hHhTvBnO2HwAh9NiY3QDK6f46tmtzJz/6fV8QAo
	O4GPJ37ELwyL+zPhQM0vHmjeBXkh48WtEigxiW/dgfhT7pRYPQFZf7TEmRmGxm+pSKroIJFPvs6
	NTWj7eJl4e6nflDwVtRmO3nD2CMFpgsXkaPkv0a8=
X-Gm-Gg: ATEYQzyLs2vIOJkbUfU0iiR/9EiueCNhbSpBeoBM7aqMe2sr56o26CtwftKx3vtqEbl
	2ioiJQG2Qb67PVscHBu/sJLZFeXB3h+jNewb5FZJep6Bn6b5616KZHavGQPnIxQ3k4x3RoOVy/t
	TlpFnfFUAEvI9NGu7/54QIlxxn8E9/Lerf4r54Roka88YaZrM/veJmiJ0KXdu1DATLbiMMLcSRQ
	CimkwjUk9uZYfRBArXP3CHRCBag1ekqZ6E2CF2OlAMoaA07umhcXBDKkoJ6CtNQCPlGEd+V+WOg
	szI6PLN2NcKLaTy4BNpHeqeLU9cMsXKJhllMLHRpI2LV/cEu4wb8KEd+Scrg
X-Received: by 2002:a05:6000:2911:b0:439:b506:e423 with SMTP id
 ffacd0b85a97d-439f81bd88bmr1344394f8f.6.1773185778101; Tue, 10 Mar 2026
 16:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
 <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
 <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com> <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
In-Reply-To: <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 11 Mar 2026 00:35:41 +0100
X-Gm-Features: AaiRm52zxyA-hFmXiwHjxu1H-yknhiWzQ_2CJS1rvQyR9nAe45bTF3_pMdoX6_8
Message-ID: <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Tue, Mar 10, 2026 at 3:48=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrot=
e:
> > > > >
> > > > > When running BPF struct_ops tests consecutively, the second test =
fails
> > > > > because BTF object references take longer to be released while th=
eir
> > > > > associated module is removed from btf_modules list immediately
> > > > > during module unload. This creates a race condition where the sec=
ond
> > > > > test retrieves the cached BTF object but cannot find valid module
> > > > > information, causing btf_try_get_module() to return NULL.
> > > > >
> > > > > Fix this by modifying MODULE_STATE_GOING handling to wait for
> > > > > active BTF references to be released before completing module
> > > > > cleanup. This ensures BTF objects are properly cleaned up from th=
e
> > > > > cache before their module metadata is removed, eliminating the ti=
ming
> > > > > window that caused the race condition.
> > > > >
> > > > > Signed-off-by: Gregory Bell <grbell@redhat.com>
> > > > > ---
> > > > >  kernel/bpf/btf.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > index 09fcbb125155..81c9f46a7bb7 100644
> > > > > --- a/kernel/bpf/btf.c
> > > > > +++ b/kernel/bpf/btf.c
> > > > > @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifi=
er_block *nb, unsigned long op,
> > > > >                 list_for_each_entry_safe(btf_mod, tmp, &btf_modul=
es, list) {
> > > > >                         if (btf_mod->module !=3D module)
> > > > >                                 continue;
> > > > > -
> > > > > +                       unsigned int timeout =3D 1000;
> > > > > +                       while (refcount_read(&btf_mod->btf->refcn=
t) > 1
> > > > > +                       && timeout > 0 ) {
> > > > > +                               msleep(1);
> > > > > +                               timeout--;
> > > > > +                       }
> > > >
> > > > This isn't the right way to address such issues. Your diagnosis is
> > > > correct but fix is just papering over real problems.
> > >
> > > Second that the fix is not right.
> > >
> > > >
> > > > The better way would be to block the discovery of such BTFs once th=
e
> > > > module is unloaded.
> > > > I.e. once we return to userspace after module unload, subsequent ca=
lls
> > > > to obtain an fd for such BTFs should not succeed.
> > > > If someone is racing to look it up while the unload happens, so be =
it,
> > > > they will fail anyway.
> > > >
> > > > I would use a bool flag in struct btf, set it inside the critical
> > > > section at this point with WRITE_ONCE, then test it early in
> > > > bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> > > > condition.
> > > > Using READ_ONCE of course.
> > > > Also, we need to add it to btf_get_fd_by_id, so that once conversio=
ns
> > > > from stale IDs to FDs don't succeed.
> > > > Looking at load_module_btfs(), it already handles the ENOENT case w=
hen
> > > > id lookup succeeds, but fd lookup fails.
> > > > So for stale ids it should just skip over their errors if we return
> > > > the same ENOENT as the refcount_inc_not_zero case.
> > > > We will still report stale ids, but not allow their conversion.
> > > > We could filter id lookup too but it will penalize the common code =
and
> > > > we need extra radix tree lookup just for BTF case.
> > > >
> > > > For me locally, these changes seem to address the problem. I could
> > > > send the fix, but if you would like to take a stab at the above
> > > > change, please go ahead.
> > > >
> > >
> > > I guess this is worth a fix because it makes btf_get_fd_by_id() less
> > > likely to return to stale id. However, there is still a small window
> > > between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
> > > creation can still fail.
> >
> > That's fine, it means that module unload is happening in parallel, so
> > it's racy and non-deterministic anyway.
> > When the user controls the module unload though, they should not be
> > getting stale BTF fds once module unload has returned to user space.
> > At that point all associated artifacts shouldn't be discoverable.
> >
> > >
> > > As for the solution, there already is btf_mod->flags. So maybe instea=
d
> > > of adding a bool, just test the flag?
> >
> > You mean struct btf instead of btf_mod? I don't see the flags field the=
re.
> > The btf_mod->flags won't work, it's already deleted and freed by this
> > time, and requires us to go first from the BTF to the btf_mod.
> > So it has to be in struct btf.
> >
>
> I was thinking about updating btf_module->flags when handling
> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
> btf_try_get_module() to check flags if it's module BTF. If the module
> is already freed then it returns -ENOENT.

Hmm, interesting thought.
I guess the only downside is that it's O(n) lookup under mutex, which
can be costly with lots of modules, and always penalizes
get_fd_by_id() for handling race.
We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
where we may repeat it multiple times in the loop, so the cost is
amplified.

Let's see what other maintainers think.


>
> >
> > >
> > > >
> > > >
> > > > >                         list_del(&btf_mod->list);
> > > > >                         if (btf_mod->sysfs_attr)
> > > > >                                 sysfs_remove_bin_file(btf_kobj, b=
tf_mod->sysfs_attr);
> > > > > --
> > > > > 2.52.0
> > > > >
> > > > >
> > > >
