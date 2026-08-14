Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA403630B0
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730426; cv=pass; b=NOjRLZhlUQMxWPfOBatmWDIRenZyDdWt+Q+AwSu9dpv/KUya0qadHIoBlarxdlB0oSJvHKfePH8JQ5ffcsT2KebXX6NAQJA4l7clZHl8N/sJFI5rO4wSIf8WKjp5HjFYd9jHECtsI9Z+i8w01zBuc6SMlJ3Bbjg6bMQOP2LdM0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730426; c=relaxed/simple;
	bh=Xb4aFB2LdZ8BWA2fVdcEuUyW3MqSc8rqf8KYywODpB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLH9xVe+pjmIR6VqiDaSgh5vc9NEM7GBXTL/jp+D4ywc/9jzaXX/feThaau5THlTYgFuVT8bSLK7IAjdt4gzHZyEIVJ9V/9VrbcJPrNwP2Ea0aOwSrUb+G5d+4auCDTAOHd2zq3ANISnwR5blSNQlRp6wPYSQ8S5RJBqNPoZ4bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKPWKCXZ; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKPWKCXZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1293520b3a.2
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 11:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786730424; cv=none;
        d=google.com; s=arc-20260327;
        b=QkUQpZVdcZmwhGtsPwp6BfacDSXGhynS2vzIhnDgQQCjRL7OKWrm3cN9neNgMrAg9a
         FAI+j8y4efGkrAhmOzl+klOdeIvhNRtNEuSbHRsgUKHkdh2atQnwvwzJDnUEcMfoycEl
         Q7hIMUSgWrs2gJadT5H9ZlMx6Yd4uC0L+0Amb5TuBoCRCoOeyT8ufBcJKSdpYY2k/oC8
         PVKNtUql6rs/1BVq8PxoySzhJicVvbCC0s0vrXA4lWShZD0i92N3IgxOej3ntf6Xev7R
         3rBfXYTw0iayzvMWnn+dWyEyJpS95+4V5H20qij7AfxF4hITezBckCARf+9vCLObhH76
         KiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g2YaHSpSFt9Tz/WkTYNw8ZXaB2J7y5iSqhGJKx3QtZE=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=H//rTdk6zLx1BoXsw4MAsEzF86Bsj4PwKG+jYaTL9BUNZDA1fFEcg95ufGyQuqKOQt
         6wUJ6NG1bNUCG0FRxslH0DVU4CWdRJXFfPgOvW3ISGFPGrWOoBNHhdxZ2GGf43vX0oJy
         pTv521EZI7RAAnWpvi+cFm1uJK2bY/E2zuG7yBU+dYIG/ae1a//Wgu+moCUryx48KsmG
         cHB8/mPewNb0YwyBGuDNZezGES21HfukdlmoxD1rZ7EYWtUfd2X7LUkSRAi67or0aoiC
         Z/JGK2f5uY/do71iHpJTZDeKsoBpQftNqBuoW/HKiIv0BkTZyOQCKk3mdSS5vlwtVEhQ
         jCxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730424; x=1787335224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g2YaHSpSFt9Tz/WkTYNw8ZXaB2J7y5iSqhGJKx3QtZE=;
        b=cKPWKCXZa64MwdsVbKK7HXQcjoydsnifDYNIMlkXH+lK5o9SsTi+rW2tChPjn6TSHS
         jO7gEE5EjgKQIJfPtP/DJA98POncYZjfdN4VMThJwk9i1EymZ10g1xE0HsIpOVcWCwgg
         ILOAf917r/uFjMAc9iCiiIUm1p+6FTd2djVhebrOUFsemM/NRMzN+HyIH9DBpMJwhQre
         IPZdsGDxBUSnJVPS4EjeWAbTvret9gM2vAF082nXWegNWDL5u2xf5ujd5x413Cia7moN
         QPb+v3GlAlkAxBgcm+99fZRCNs3Ug0EvNbzqjdM/9HHDtoYMxjaj3qGqTVZdL7Ym+WzX
         LQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730424; x=1787335224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2YaHSpSFt9Tz/WkTYNw8ZXaB2J7y5iSqhGJKx3QtZE=;
        b=h5qPu7zGkIOiE/7TumnvQ5i1+Mvt1f6etJKZPrISUjTS5Q98X8WN346QaiAh+8dK5n
         S54uPWxB7TFZmSLaBnY8pT9SBu96yt6dad1mBzAlhpUYfdN4f4IW3KbtBG9EflJT4kSL
         oqyPOgPSQjU1Np5gw7m4OKSx5L3a96iaXR1jZM6VvnzGG/l9lLbmhF99c7DyDYIwmrPS
         2mQMVN+MCBYTc45G9aviN91Pb5tqa2BWlu2iqqSwOcHqAaRBt9aOrp97RJQwJ9BedRNs
         /FutdL7eUOj+lvYpO5ZUD4JHIzeQQJpEyqOcm9yAN8te1+OpClqrDMe9sG7y2i3GDRtm
         If/Q==
X-Gm-Message-State: AOJu0Yx+lfMlQ0ehY6nHUN3DelD0TFDvxM0U+ypjRZ7jhdRGpK/HuS5t
	VdmbrleOMZGNHQzCVeTYZ3aoLKYgrWCQxK8+MiHEGjC3hFe/JuU2ZTphxg7vv/Pd5ES0x615Ojj
	GNuzGOzbqBkB3KchX14qvA7YuCZms80w=
X-Gm-Gg: AR+sD114gdTeC/Ggg4drUiPOlHkyJXZgifrT240F5m3c11mNQq/Mw9TfVAsqBfKRLK1
	B76/KjGsmKvOc3NOYGpCEDlz5nRsVmKcsjNfh0WkK0fdGer413/YvRaO9omG7ufFN62YWQbUbgr
	Nfa6JCq2WVjs0INn9dKcM0TZVap9qcW/K/IH3q/Lx3FDtLPwKjt7WOuas7Qe06rAcJegjc9OxKR
	vuUmZSXwUIVL/We8qDNx9XhT3PYYiSZrpg3SrfuoCgCn07PyZOdC5BDTq5wbdkpoaKmq1rBG5Er
	uE5fwKGig9jy7py3roUjUy+HB4qVBtspU84bVq/mNNxCI4wUBXB7lv++Yko4jpTc0ytk49JHTaQ
	z+A2PEIViCfSqmVO8LUn0YXktpA==
X-Received: by 2002:a05:6a20:6a10:b0:3c3:ac5d:b6de with SMTP id
 adf61e73a8af0-3cc71d55406mr7493598637.22.1786730423943; Fri, 14 Aug 2026
 11:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813152324.97937-1-leon.hwang@linux.dev> <20260813152324.97937-7-leon.hwang@linux.dev>
 <CAEf4BzYRqZ--=5d2LBWA=mOL72CYe4y4iCGS3c5Dw8PEd9BOiA@mail.gmail.com> <965e536c-bd5c-4f63-8021-8b07e0aee231@linux.dev>
In-Reply-To: <965e536c-bd5c-4f63-8021-8b07e0aee231@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 11:00:11 -0700
X-Gm-Features: AUfX_my9sVqn2htAb5x5-1TwdbZGaJswG7gE3Qs2A7WUT8EFQqLsOttnr2Ax94Q
Message-ID: <CAEf4BzaeKxZKgF-QeJ0RdGGwxSjKcH8uzgUnA8bBVgAX++phog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 06/10] bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:03=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 14/8/26 01:56, Andrii Nakryiko wrote:
> > On Thu, Aug 13, 2026 at 8:24=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> [...]
> >> @@ -263,13 +269,24 @@ static bool is_mmapable_map(const struct bpf_map=
 *map, char *buf, size_t sz)
> >>                 return true;
> >>         }
> >>
> >> -       if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & =
BPF_F_MMAPABLE))
> >> +       if (!bpf_map__is_internal(map))
> >>                 return false;
> >>
> >>         if (!get_map_ident(map, buf, sz))
> >>                 return false;
> >>
> >> -       return true;
> >> +       if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> >> +               return true;
> >> +
> >> +       if (bpf_map__type(map) =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> >> +               return bpf_map__btf_value_type_id(map) !=3D 0;
> >
> > why do we need this btf_value_type_id() check? in what case it's
> > expected that there will be no BTF info set?
>
> Add this check by referencing btf_value_type_id check in libbpf's
> map_is_mmapable(). That said, if btf_value_type_id is 0 for
> global/percpu data, is_mmapable_map() should return false for them.
>
> And, if the bpf obj is compiled without -g, this check helps to avoid
> generating struct for percpu data explicitly.
>

I don't think skeleton can be generated if BPF object was compiled
without -g, so let's just drop that btf_value_type_id() check, it
causes more questions than it's actually useful

> Thanks,
> Leon
>
> >
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +static bool is_mmapable_map(const struct bpf_map *map, char *buf, siz=
e_t sz)
> >> +{
> >> +       return is_skel_data(map, buf, sz) && bpf_map__type(map) !=3D B=
PF_MAP_TYPE_PERCPU_ARRAY;
> >>  }
> >>
> >
> > [...]
>
