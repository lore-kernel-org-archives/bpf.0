Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245038662F
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037390; cv=none; b=Zj0LezgqG8+9IvfkfjKIloKYUXGYLtuaM1oyvoj1f8EIKdP2nM2dSoJuQclIK5jYv64i79mC6BYNFelgU0LmeIOZEBOf6mqZ/fhXcsSWNJshVeATd/EyJjyBKQcmCN9c1oE0tWjM821pj9ax4WyIbN553ZfSUzgVgzpUYrzu9eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037390; c=relaxed/simple;
	bh=Efa9pooFtZFexc8t2FHAlDSOT6+OQH2tDlvcl4EcU6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I19+LYgmfNhQMjhA9SVy/HsNrENsEQHOR6+azcE4di0z6jvxXgDwAY7Ip6h9kXhT42SYEykQRWfEEnW/ZWBS7Z8FgTvT1N30HY3Wp9GIURwX9rjiELxzwsS+EchGWF2GceMERe4jnbQOuRMIXJekvL4Yu/kX2l9x6i4XV6JExWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkFd4asw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkFd4asw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711037387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
	b=WkFd4aswQKdNUgA7tHiUUgYBtSpUM2qMhmjIQyQdLUdkdGf1vH3rFIxQdRkFk5hZXjrjst
	CNqDEjZhp571QSEIicPUfk16bZSXPbcbYIUwV6Z/Hr8RuzyXyfxTa0CXywitLad8i58f08
	LJk8x2Eub0Ofj3Vj/JTt6kQIiQyc1DI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-x3UKgbnqNxm-0I6RWwUP_A-1; Thu, 21 Mar 2024 12:09:46 -0400
X-MC-Unique: x3UKgbnqNxm-0I6RWwUP_A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5685d83ec51so643736a12.3
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 09:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711037385; x=1711642185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cR8GpDLO+4FVgHiOEVtV5NgNDutqCmPeOvWuL5WwZo=;
        b=tD+7jsd7tEHy0JsPrjXDfBrUY1zq5EqRUteJNRd70dM/CS76qZ/pceJHINWP4+Ijgx
         YVqlPc2lPEKYnt4o21OeCemTf+crGENhyGPHeRaHR3ieLxVNBoUvf5WrZMPTqrJSXmz/
         U+sOZx1X8v1HiQGeZMHkUVxC2p03wZfPL0qwPBGnTzyM0Ae1rNQBS26a0a+FssVZ0jMd
         ypxj2QzHf/PBNhxKWgy0PATLobpiQZH7QXPLEFGyAkdao55kaI+jqfBTyQ5+CHjTTr9+
         mNHWgls5pADeKbVvgSAs+J8Ka5Xc2zURWbABtlWC/DWFeLISz7QYFjeju/uCB+ZDAGrR
         XAmA==
X-Forwarded-Encrypted: i=1; AJvYcCXIM8/vt/PS/FfaC3NwLCLWSTuz1V02gBsV/Ri0Z/RMjCwCxqlGnZEUTm0NzN7WuEUEombgprvhR+GmfbU9yd4D8n6M
X-Gm-Message-State: AOJu0Yx3SwHcz5PCtN3cMlH3Au70cdvYTifDvoe2Tw1IQQGuHM+//Jhl
	sQ7m2P53/Te5D/ieQubPlY0SgAVwHlp4DWtEFoKjiEBEwzMQhKZgClxljz8J1u1/sr+2AKiFohK
	0WoG68AgIcy8Jc0cRISzYxQkn2MSkJzNJrMBHgy/lWI5xIt0+3+SWt7iSIEuodC4gzRikBQcl1N
	GmgbR0VJk5760kepMCHJJcMQIa
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id t33-20020a056402242100b00566f5d604b4mr6854698eda.12.1711037385191;
        Thu, 21 Mar 2024 09:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJczUOKWHiXnEN5u0YPmmuAnhgkpGir9OOZXAH68RtsDs3o/mdfwXGaEp7tIlIBwPP814Hb6KspJCMPCXLbDI=
X-Received: by 2002:a05:6402:2421:b0:566:f5d6:4b4 with SMTP id
 t33-20020a056402242100b00566f5d604b4mr6854684eda.12.1711037384888; Thu, 21
 Mar 2024 09:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315-hid-bpf-sleepable-v4-0-5658f2540564@kernel.org>
 <20240315-hid-bpf-sleepable-v4-4-5658f2540564@kernel.org> <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
In-Reply-To: <bee98dce6c5bf59fb1ad06855f0a1740b8195d45.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 21 Mar 2024 17:09:32 +0100
Message-ID: <CAO-hwJLh00--9AbS=7z4+W7FgA+hLA8hViMmaMMfz2mERcMwhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf/helpers: mark the callback of
 bpf_timer_set_sleepable_cb() as sleepable
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 12:54=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Fri, 2024-03-15 at 15:29 +0100, Benjamin Tissoires wrote:
> [...]
>
> > @@ -5279,7 +5281,8 @@ static int map_kptr_match_type(struct bpf_verifie=
r_env *env,
> >
> >  static bool in_sleepable(struct bpf_verifier_env *env)
> >  {
> > -     return env->prog->sleepable;
> > +     return env->prog->sleepable ||
> > +            (env->cur_state && env->cur_state->in_sleepable);
> >  }
>
> I was curious why 'env->cur_state &&' check was needed and found that
> removing it caused an error in the following fragment:
>
> static int do_misc_fixups(struct bpf_verifier_env *env)
> {
>                 ...
>                 if (is_storage_get_function(insn->imm)) {
>                         if (!in_sleepable(env) ||
>                             env->insn_aux_data[i + delta].storage_get_fun=
c_atomic)
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_ATOMIC);
>                         else
>                                 insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_5, =
(__force __s32)GFP_KERNEL);
>                         ...
>                 }
>                 ...
> }
>
> When do_misc_fixups() is done env->cur_state is NULL.
> Current implementation would use GFP_ATOMIC allocation even for
> sleepable callbacks, where GFP_KERNEL is sufficient.
> Is this is something we want to address?

I honestly have no idea of the impact there.

AFAICT, if env->cur_state is not set, we don't even know if the
callback will be sleepable or not, so if there is a small penalty,
then it's the safest option, no?

Cheers,
Benjamin

>
> >
> >  /* The non-sleepable programs and sleepable programs with explicit bpf=
_rcu_read_lock()
>

