Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9764CCDE5
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788707526; cv=pass; b=X2agdihLUhUlQE3zFe7NVpngQDtzuyMw/KxBKmQr7GZhYUUR7LC5xkcxrh3NbWF1XZBQiM1O3dmt/L5/yzIhWEJ8ZA2zGW5SGdF9TAD9MPSsjlVm3OUbEQt8iKOFCQ3a1OVLvZOD80lIdZVcY1cFiy+k4fEjaZLV/bUGY1gfKRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788707526; c=relaxed/simple;
	bh=463+vp4PKtBsf0Ll4ogmxgkIdgKLr3skgogvEFcESw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeXpQGQKtfoCQHu674jSm2ASpw83DunuV3jWgi0ZOQJLfoXuHp0W3byXSZzLY8WTx6eFf3gGFhV1LmzozXce+7c0Ee+IH732zuah+vTCGssIsfj3+OzwhVbZ6XyTqrLBJjVN22zd89vwxQfHEi4RxZnyMqNQcc7iHvTSmnvfUTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzr+kI/y; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzr+kI/y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d7195706f1so29073745ad.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 08:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788707524; cv=none;
        d=google.com; s=arc-20260327;
        b=eNs5pcOvQ28eIWQ3P5cb8DYg0FSJzBiLYA1jcGoiKnI7Mg/zaaIlNOzmrV9jP+hYkl
         PiwUfiR3RCMYRL+p2k6FLY+DtA7MTiN1+fSgkaSM7UTSyvLfduNBX/N102brVbDsoEcK
         9VCJR+yscL2VDWGl/za3UMRY94whBQqrd/+oZCcrEFqhb5F6C34aGYgZHxUiIdEX4fHu
         blmqv0wj6UHAd2F51jmjbutcpHweDkRuVg25d9b6D5LRE9E9t7vFsEYEYZlfub76o/Hp
         ssvY6KcWQn6DemyHDwuaYokMpe0s55aw9Vvi6onBLZXuu0kAw20hzgiErh8AtUkUAdaR
         zT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RqR2M0n5SBJNDb4iT9jEG605+etS6KOO9mNxEgnl5Iw=;
        fh=ycx4pW/v8Ov0dVSQYMTibBq3zvvSyYwBezdiv4wgDiM=;
        b=O4j8UHAYeuEc0oi2du3OMYgZvJVbKfYwuoyA9tiJXDrJQUOMfG+FeC9jZ8Sz/mBFBM
         ah6Iq+hrWxkNsnx1LrrSZSTfzZ13ETnfRvW6kuiRJNxwhA+7O6pX7c1CCr5ww8uP0Egf
         i8Izx7IEC9Hhu3JfyHA5tRWfLVT6vIYDbLy6OO9A+rR+xSrtlRlktS3VG1Zvkfun4unl
         EiXt4Br0zRMKaK1vcRajf/9B3wR6SixtNliWpc8gBs9L7sw3UXM5+9H14zMyCg9yoQv7
         b4KKVcmlvdqrF/k9j11CrDgdz4/KYiXwznSlUAAKuooUjbvMsivIDpIwcdG1aP7pFYqb
         gXFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788707524; x=1789312324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RqR2M0n5SBJNDb4iT9jEG605+etS6KOO9mNxEgnl5Iw=;
        b=Bzr+kI/yeje7Pbk8q1K5qaGkKKn+RPLQ55JvEQJ5DVHY8i9JYMvZAYLria40b3X+mm
         l/X10zondtwne/76UwYw7RPU3deak3RIhHAEziREYvqYqvTnnD9jZwItd9LU95gn80oG
         25gJB/e9QAxEg7NFwF4QIt9Od1wyk8NcH390h4q+b40yvzti0UgrYHJrlCuEm27WY/K7
         1jZQ6vACJqwyiaYLMiDWB2qYkSaRzW23MZmrFIxyqbXDhxJIS63c1K24FvqRCv8ZRh/r
         nZrHiQ5DZtMKA5Nqi0HsNEDIFZjjEEl/G2ByiLALDWF5t4X25EHICFZ+GPlpvWsADgR0
         mWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788707524; x=1789312324;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RqR2M0n5SBJNDb4iT9jEG605+etS6KOO9mNxEgnl5Iw=;
        b=DeZEtVtJFMg+XVGD2nB4ZtXuZE+u/9W7kI6/oIqTTG31NOKTYegleWoQj0RkNm3pOw
         U2PEQvxiqWbXcfzW5nn1Ey80BkBcpVqmQ8e++KEO6FUkwb9yTkd329CQJJln1DacUw5E
         KLn1M/aayfmluPu8pM1ABVy6wv5+n462lESaRj5QFDq9mkl274cR6oEdkkyc2gl7/KXW
         wTvFMaCoM8vcOQcCGx1dIBiB0OGAtBfNZ6emJDhgLpGRuRkxBiTIcUyMV4APYfBFJ0bb
         crw5bFp3TTQ9USIwPTGqk9u7EJ4qvU2qRq6oNUeJQIb+NhB/vVyJqksScYRpdfdWlvgx
         rPkQ==
X-Forwarded-Encrypted: i=1; AKwUvByPx2cRm64O+EcQABO99ixXNe9UyfJJaNG25wUSRh0h4WHBkpiVWrGBzZBy/d+hhsQFyXY=@vger.kernel.org
X-Gm-Message-State: AFuF++k3exrMZb5ur5koL6WnNskAmIBh7otoQzN9XgTwHszTEluNlNmH
	YnxdaCX9gseSmudA3p+83mRkPW3F85QluPBomIPtjHpiFofDfJ8jT2hWvN2xFhZrCyQdxui5U9I
	+i63gZ8Ee19hu2PJepVijDY/XNV2QHlJ04lAE
X-Gm-Gg: AYBFou0MMv5JQQ91M1fYlTGiM++XlHMcXyqfqjkZhlv6Fs1TVPSd9ERatFiS2bu6qRD
	d6TCzUVSrA9ualBmtrDOVIAKzD8H6lAFJxDOyK/wlETA7D3uF7Y2A0q1480GA9WbicOVV3b8g8e
	ud00UjgUCeuZ/RUWwS+sePDrrKCB47rf/6JrchUcwNksnJTG9gHCwMXtbkogtCgZVtRpsO0ubI/
	2ihmvN5w0IcxZd6SDNsahkoaMYeXdsXQobdgZXjsfknhsXT9RylfPM0vKjltkNM+kJM7KtwG/Ss
	7eGNTDIPWX4lD+3h/Ua5QxEOCnCeXuU0XJJ4Clj1d9Dk+DHYMdUX2kH37WXDuWAbd4Id473pizT
	Va4BSJa6AgSdIg+PzTIiHGWcyl7zN
X-Received: by 2002:a17:903:1b4e:b0:2db:18fe:bb08 with SMTP id
 d9443c01a7336-2db18fec95amr265377935ad.10.1788707523687; Sun, 06 Sep 2026
 08:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905083418.3723623-1-memxor@gmail.com> <20260905083418.3723623-3-memxor@gmail.com>
 <83e2ad1e23774de204372c7e3d3bddc8f570c099.camel@gmail.com> <55dca8a81004eba0d5ba92006e4953fc12c5d1fc.camel@gmail.com>
In-Reply-To: <55dca8a81004eba0d5ba92006e4953fc12c5d1fc.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 6 Sep 2026 08:11:51 -0700
X-Gm-Features: AcwNN1VfrNLuhZaoUPF4QHqyyP_v8Ux9b4h2qlyATV7Qtubj3ZMK1l_1ZIikpvc
Message-ID: <CAADnVQKvXPqcOcWquPzCrqR0qD8VH6jPo2K+Su34-DRsw=xFAA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/7] bpf: Preserve packet pointer class
 displacement in regsafe()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 12:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2026-09-05 at 23:40 -0700, Eduard Zingerman wrote:
> > On Sat, 2026-09-05 at 10:34 +0200, Kumar Kartikeya Dwivedi wrote:
> > > regsafe() maps packet pointer IDs between states and checks that each
> > > current register range is a subset of the corresponding explored
> > > register range. It does not, however, preserve the displacement betwe=
en
> > > registers that share a packet pointer ID.
> > >
> > > This is unsound because packet range is shared by ID. A bounds check =
on
> > > one class member updates every member, and a later access can consume=
 the
> > > range through another member. Commit 022ac0750883 ("bpf: use reg->var=
_off
> > > instead of reg->off for pointers") folded the fixed pointer offset in=
to
> > > r64 and removed the old off equality check, so two individually narro=
wer
> > > registers can prune even when their displacement has changed. The
> > > explored path can then license an out-of-bounds packet access on the
> > > pruned path.
> > >
> > > Requiring equal r64 bases would prevent the bug, but would also rejec=
t a
> > > safe uniform translation of the whole class. Instead, record the base
> > > translation seen for the first packet pointer in each ID mapping and
> > > require every subsequent member to have the same translation. This ke=
eps
> > > the relative displacement invariant while retaining pruning for unifo=
rmly
> > > translated classes. Packet pointers without an ID remain unaffected.
> > >
> > > Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for p=
ointers")
> > > Reported-by: Nicholas Carlini <npc@anthropic.com>
> > > Suggested-by: Nicholas Carlini <npc@anthropic.com>
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >
> > So, essentially this is the same problem as `id + ADD_CONST` tracking
> > for scalar values, where the actual difference is stored in `delta` fie=
ld.
> > In other words, that would be an undo of 022ac0750883 for packet pointe=
rs.
> >
> > What about the original suggested fix:
> >
> >             /* id relations must be preserved */
> >             if (!check_ids(rold->id, rcur->id, idmap))
> >                     return false;
> >     +       if (rold->id && rold->r64.base !=3D rcur->r64.base)
> >     +               return false;
> >             /* new val must satisfy old val knowledge */
> >             return range_within(rold, rcur) &&
> >                    tnum_in(rold->var_off, rcur->var_off);
> >
> > Is it that bad?
> > Given this logic in adjust_ptr_min_max_vals:
> >
> >     case BPF_ADD:
> >         ...
> >               if (reg_is_pkt_pointer(ptr_reg))
> >                       if (!known)
> >                               dst_reg->id =3D ++env->id_gen;
> >
> > I'd expect it to be okay.
> >
> > ...
>
> In case there are veristat regressions, it seems the following should
> be on-par with pre 022ac0750883 state (untested, llm):

Yeah. let's check veristat.
If it's in the noise I'd go with the simplest
rold->r64.base !=3D rcur->r64.base
