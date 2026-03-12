Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D63F23B4
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335664; cv=pass; b=pyai7k9uZaM1xxgrTuvRZQv6ruVGDvKea6pHghFhrtxlkMgWKuAd+i1Ue+TEveGY4buSFC8uC+3JavQnUjXGLk0TKARpIiOwPW7NfKo38ZCv4bxYljhKd7Nj2AlPVf84pYuAGRNu7b/watvvqVVC9Ug667F/oeYHbS9ECGPsO6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335664; c=relaxed/simple;
	bh=TJrms3tuLQmp7pBGoNJg4nkLGXzcmtqNnFDXuwLs/so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgmmq7WWrHDs9Mc7BRcvyYJrVsaCKnk4Cj7WY4qXUcCEupF5nUIuCKBZDxezmKGnQQfrh78J3e3siUS7GT/zinV59G7XJuS/fLKKhTyO/dbCpNQwRt1pfecXgHASeExKaGi3ANtadjMbcexbkwWEYC/Krz0rF/mIoaXLQBqa8Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfXF+J96; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfXF+J96"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b790af67so1984544f8f.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 10:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773335658; cv=none;
        d=google.com; s=arc-20240605;
        b=V/1LPBMgeOLPFoZmp6VluedKpTRGz7P6XAtrwvL7WqP3PRAjIA1wbZ7XdOmdLsXO5q
         aELh/GVbgLN7EVG39WaUFMufPoMLQgpRvvnF8jIcX2vTB3gVNfhxlvblOSHUB4LItm1U
         VvmdrhVHqjK5kI9bayRkGofqfZiCZRW3tBLPjhKp2Ple3vbulYld4NGlKY8epkwO4KTd
         Y++iMqTEKuK1lWbTnkyan8dbHcvOlJfcxl7nbcGRqGOzCMmVbO01+ZC3tcr4pYM2nwrI
         w30SqqlBjYYtPKmIvB8qxNwHf95JdESTux7+Gvgc+Hv8DebNUR+8uUdIZj1Lyfe/dN5F
         LpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJrms3tuLQmp7pBGoNJg4nkLGXzcmtqNnFDXuwLs/so=;
        fh=hxrShpmaur/16Kub1ssLqCovsUzyzDxDYrPiQXcJkNI=;
        b=ih84mK85C2KkR69XZMCy4ge9wPV3AxeOnKLh1VphA4LCJqPq9OTjc5GlnTQPvnQ2+B
         5A7G28GFFb5ePalu+60/VtROnZMkN8oL+imKTubA7mXyTwb8tTFj7OPJE83mDzIMRwSz
         OR2qeIvIfMGv5uthGlxj1HI7eZjC6zz1mkYaXHAboy1Ap32Se1sabg5q2eez3b1KHsOy
         Mom/JbYg5/g5Ty/OJvvE5u9SP4OpIvlfkkg17wXtD+UZlLYPNCyshgXLkbPGosJgzpc+
         JO3h47jNJk0OPMwmPrR2Fy/Omgp35M1QcPXcpZgbonMkz0jDCPFGqq5XIOershYFtrmD
         +jCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335658; x=1773940458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJrms3tuLQmp7pBGoNJg4nkLGXzcmtqNnFDXuwLs/so=;
        b=XfXF+J96u55PUthVR0NCneGaVchdWycTkgNQllwySUtip+by+k57wVuF/u4imFwqpD
         HJIZhAuKIuSUCS8YoEzp4hFFXDS0YxbbGNdqI7xuBAHXDf70pyBx8jojtDizaeHgiK7I
         EZR2D8ydAFNpcbPUYmB16yKsJ/GvB7ZIDAfDrs1OS+jGRMAuJvpIH80EWZdCqtNEaH55
         TewK+wFwyqPn7mTMolTSFGUyrLFg5r7QYXIn1Sn7xfRZzdbPiPNk5gGRyPpX+Q9SUpsB
         1lN+2r+3vftu5tsqtGiBSTfdIdpMVt09cvsjcQhYQchcz6Wn4jX/kD5DoOhnOYSJ5us8
         SOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335658; x=1773940458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJrms3tuLQmp7pBGoNJg4nkLGXzcmtqNnFDXuwLs/so=;
        b=XRkTMwb3F/CqiHqCJ9zcpp8UWD5wX6zvPXJ9e6a5V/TFISQ6KpRIhiaqzKmfwjvRHo
         S4VOg3u6GUn45fUAXm3TBEVMmCTCttBogW7JRfmRIbMyzigIHhYcnpnq7r5jcyY4dCjq
         jogOwXR+rCKm2O4ZjA70vBfcUmKhATfAiROtwuo8L4ItQMRUviTzOKnnuxxsE65Mx5Dm
         xEcOS+hAaZnF9j9CIbVu2810LyuaidVv8JNrHDWX4xFo6n28emXm5BnYWVlKPLj28coL
         fqytZLvYr88OpMNNSXAC+Yp0hH+aZYPOEl1Yw0sIzVcRkUzQHnyuy4Si3sI6KIDuKbfZ
         Rg2A==
X-Gm-Message-State: AOJu0YxPKwwnoEZxxjzjUjWm0p0MO/zaG2PR5JRnNQ6/BW0x7ieCl0TX
	iSk7nQzSMkC8vGV/vLvX7g3Ep7BQtW9D4fmFLOE04+Hav6b7zKMVuT9kiDf380KR3bKfOqACp01
	Ct2m+au7Ag+IoN8BZ7zQBKrS0zjTGunw=
X-Gm-Gg: ATEYQzxMGXNZ1m3+SRPX3T5HqtHYKB3aSl7hpahrf2Wp8UIXEPVy1msDXIDw5lvRC3p
	zQcG6zhtipJbQFfxYyR6s6PKN2FtEDfdJm30Sfe3AkLK+eV2HW5nf85JP9afjfs5dGAOCZ/liLT
	Y6F+rhWJHqmijilaHWflvzceuoYzNP5eYiVRESxiS/IxmJJ03IN70dBwigWnzdXdIxvlvMcFlj1
	nHM1+Z7oXvmXuwpZZM0axbGh52KcpsvifY1qTBNosIv/zrJ5Oe/B3d0APqVsskPQv+YdfeBqzPm
	vyUQZR+KXI72m8jg2CPp/oZWLmjcLxJzTbbM95IarCXBokjPRLggXpX+6/s2
X-Received: by 2002:a05:6000:26c2:b0:439:a95b:3c34 with SMTP id
 ffacd0b85a97d-439fdf34571mr8163706f8f.4.1773335658046; Thu, 12 Mar 2026
 10:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312002025.2495953-1-memxor@gmail.com> <CAEf4Bzb0mJsdP7vRwXiHYmqv5NogxPfOR1bFgFme9aKcQDvswA@mail.gmail.com>
 <CAP01T75aH9W8w3F7JP7yjtOFQsy+dc_2MMMSxSdQ-bM8aC2O7g@mail.gmail.com> <CAEf4BzZhV+vqXVBOLorkfwYiydHr+nNpe1Jso2UtVX8mTk+gzA@mail.gmail.com>
In-Reply-To: <CAEf4BzZhV+vqXVBOLorkfwYiydHr+nNpe1Jso2UtVX8mTk+gzA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Mar 2026 18:13:41 +0100
X-Gm-Features: AaiRm52BHQsdGFGdm-Ig8VYE-DetyXhsKTIOcL9N_8UX7kHhZc_JG0B32LWO-48
Message-ID: <CAP01T75DwR9uexgBE3b7DAKFFudjwEZmhuA6CHCQ8-ZwwM4_rA@mail.gmail.com>
Subject: Re: [PATCH bpf v1] bpf: Release module BTF IDR before module unload
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>, 
	Gregory Bell <grbell@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Mar 2026 at 17:52, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> On Thu, Mar 12, 2026 at 9:39=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 12 Mar 2026 at 17:22, Andrii Nakryiko <andrii.nakryiko@gmail.co=
m> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 5:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > Gregory reported in [0] that the global_map_resize test when run in
> > > > repeatedly ends up failing during program load. This stems from the=
 fact
> > > > that BTF reference has not dropped to zero after the previous run's
> > > > module is unloaded, and the older module's BTF is still discoverabl=
e and
> > > > visible. Later, in libbpf, load_module_btfs() will find the ID for =
this
> > > > stale BTF, open its fd, and then it will be used during program loa=
d
> > > > where later steps taking module reference using btf_try_get_module(=
)
> > > > fail since the underlying module for the BTF is gone.
> > > >
> > > > Logically, once a module is unloaded, it's associated BTF artifacts
> > > > should become hidden. The BTF object inside the kernel may still re=
main
> > > > alive as long its reference counts are alive, but it should no long=
er be
> > > > discoverable.
> > > >
> > > > To fix this, let us call btf_free_id() from the MODULE_STATE_GOING =
case
> > > > for the module unload to free the BTF associated IDR entry, and dis=
able
> > > > its discovery once module unload returns to user space. If a race
> > > > happens during unload, the outcome is non-deterministic anyway. How=
ever,
> > > > user space should be able to rely on the guarantee that once it has
> > > > synchronously established a successful module unload, no more stale
> > > > artifacts associated with this module can be obtained subsequently.
> > > >
> > > > Note that we must be careful to not invoke btf_free_id() in btf_put=
()
> > > > when btf_is_module() is true now. There could be a window where the
> > > > module unload drops a non-terminal reference, frees the IDR, but th=
e
> > > > same ID gets reused and the second unconditional btf_free_id() ends=
 up
> > > > releasing an unrelated entry.
> > >
> > > what if we just check module_is_live() state for module BTFs during
> > > GET_FD_BY_ID() operation and return -ENOENT? We already have
> > > refcount_inc_not_zero(&btf->refcnt), it's just another "it's still
> > > there, but not valid to be taken ahold by user space" condition
> >
> > We will need the module pointer to be able to do module_is_live(), but
> > in this case the module is already gone.
> > I was achieving the same thing in my first proposal, I didn't share
> > the diff, but TL;DR was setting a bool in btf->module_unloaded and
> > checking for it after refcount_inc_not_zero.
> > Set btf->module_unloaded from MODULE_STATE_GOING.
> >
> > I don't have much of a preference for the above or the current diff.
>
> The part I don't particularly like is that we have two different cases
> when ID is removed, based on whether BTF is module BTF or not. What if
> we add `btf->id =3D 0;` after idr_remove within spinlock area in
> btf_free_id() and then call btf_Free_id() unconditionally both on
> module unload and in normal btf_put path?
>

Yeah, that should work too. id =3D 0 should make the function idempotent
since 0 is not a valid IDR. Let me give it a spin and resend.

> > [...]
