Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4B34DB54
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 03:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531671; cv=pass; b=lb+l3l8QbHyAipXdBOA0DuMahDRr9Bi/Fp2duvlUXT5G9BXuzTLRo9+KQrzAjRsxe+16BeWt2o5XXsudbdejGzQD6PNLPUaLHNvGRDyHy1Sxg5LF9hFYdOj/03hm5uqGUkF47rIUWHf8ipff3mzkUS3GNAq6n0Pbv61oIeTl7Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531671; c=relaxed/simple;
	bh=squ6n2HGdHi3UxLO+I4JuWRPtoqYf/aQUuDGYO1d7Ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdpMk4JqFv+oJHC+oAdL9Yl6Y/a0JNBaA2d+tC/fBsevfbJ/i0rtl2y3JIe8VjGjTfIX2usevgOZfeiqXxJhV+W6KboYsKrUf2nzdoFv8Wch1vLnn+sC7byyJHvP6Ifw4U91SahYm8GPQn1KpP4ud9AuGa55+slMJNYzuhwenyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahofZkd/; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahofZkd/"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6507a7d2eccso420458d50.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 20:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531669; cv=none;
        d=google.com; s=arc-20240605;
        b=ehCobS1BDqyupgZ537UO77qQ3CFK0xJTmAGLgzZYSXLx1yADIRkPVzVVTImEFC+Uvm
         9cswfQdV/RY4UIP6u25iX9d8sb7RJViXP19ufBt2S7uvb6TapvVO5z1UlVFAxW/UBfSj
         o1R5Ao0nuKZr+cGc7s1uRBoDCMO6hDaqEkje6+62f6H4YfkRAEKKwVa+F/OQY246mSLd
         NnaHQwgs/kXbJ1OtzTPX5o6gvSI4fScJngikD2+OQnUf23QRpHWhMdQ4vq538N6DX0ji
         7AL1KJiUQLsj6Q2Demr2+7LH0EQfCLZuMgMEvcBoRCB8NeLxtbB4IgSGBg3P3rzaEdxN
         tPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        fh=PRYNDb+gkfZhxSkMgVcafHiJpzDEq3p5smtTAmiYpEM=;
        b=fo9o/xgZ4FxttII85qSYVsyQyaBTMuUc/Rw3qSuMgzmJUNVdBL6HmX2P9EZe/znfSE
         ylH9RhaiMzI8QzNYR3VJuRd2w2hdwJF8FKj2G/AERGX2a4yCzt/8jrViuf62Ugkuf4OO
         GvPfJnMpTXBJy12425VzSNtdGTdyvDiv+KGQA4/ikETn+nR6tzlL/Acu8aNpWb56hjnp
         I3BhVm8mGkc3LOvzXtC5KjpHv7jtyuEpCWBEOnFM5E7I/3QTv+0e9Oph8nR7VYK5hPGz
         MYze6vevJ3GrTS+6sKg+/0QM9gI4QJQ3YCqFQlpJCcCbDlTrUjmFQt9kQ5OMljtQyU6V
         3oww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775531669; x=1776136469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        b=ahofZkd/LDlzScpDFA08CbGu322YcV4lsdhPZDiDybFzOFhhNMo91dxCK37eMiltP6
         piG9ccJBTZzI9Z/BFScbfzMqc+xrZPrjgPZU1WBhVsJuhi6LAMexV8yl5LrnTe0c9Dxb
         Ys/7q0YZL+Coc3YuQUyijjudvKeiRt8F/aGq5F0ybfwNVSlyRLzxyPJNYHTr8zVkCWWB
         7ruYtyD2gMzC55+bnislk1Iye22fSsO9r2fnoT4j/fX4wZkTwSGb2cIwL/ZYFcgKgZfR
         b+aP2My5fP72z7x0UvXM6thljPQ9IB6X619zMo7zgTyo8oe1bofWQ041jthxJzV3k1HL
         dBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531669; x=1776136469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxsYtPm2hx4YrAVsbIcCgtwuR/ec20rxpqySMN9Lw4g=;
        b=R+t3xPr6ArCP7XHls32JX0wHL906othqDqrY5Oay957f3OgAtYwD8fq0oArgi6c99P
         mi1cyI47kk7ogOJ5c3lyQcrFp4BcgEo1DgDA7fNFcXhvgb42uIV8NDyVRBgZ+UXntkeT
         R5KrzqhVHJaEw4ZmYnmsDtt7oUhw8Y3fde1TToQuro66jzlIiALnOOlSKyOhr4tM0wac
         JgW2EwcbbWca09k4BVvh6v0vcZK/oHeVdXzqKHtnfaQYpJnfgYnHgbRop+Wu92IOHbvl
         /GvhI76QvAHih9ztsb96PtE9I4eK0AsFxe/BfUVVsZZOCOU6my76SPXetu4vr5QcBbHn
         dScw==
X-Forwarded-Encrypted: i=1; AJvYcCUanYKaxS6tdlDv1pX9CJRw9+RIxrD05YlM399a3+S9369YTTur/qnKI844ZF6rWkY5eXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHiInb3OU70mhWtJTYoWOsQg6DObkn9sZl6FfSACzfy/rR8AR
	B9WO4pqZg0eUt8XIKSC4WjMgaUyAsnUb+9nLu16pHVblWryryLD82GFRGya1cmDL7UIH3a06+3V
	BuPW4ntA+HG/EtfJvAYhn7uC9CfOjypQ=
X-Gm-Gg: AeBDievgknaZK6tQegzb0oL14PUfXQyJdiEihp9IfrB+d4Ch10DAUXo5i4fCQVOqDqb
	5HFhNTgQ94bT0ces7w4d00Vslh6LtqIyxgIhi/Os+fIjhQ/vwfaUG+/1T8KCfykeMJNA6x6gDAI
	GNmf0bKuYan2RSUCYYj4M6uXZKH9hIryez6/yteIySjkwq5EnO1Ww2VV/mgYCydNtNRfwHyw42/
	+xVcvFhovqtAag3S0nodC6ZQ13aG5s9c89BMSY8m8blHsDHZBh0irD+OI5PB4JZauYPMUoM509z
	vJ00CbzVWZCE8ySMYcGNrk66zko3nQvH++yw5xzQ
X-Received: by 2002:a05:690e:304:b0:650:3bbc:57a7 with SMTP id
 956f58d0204a3-65048746577mr10316392d50.25.1775531668967; Mon, 06 Apr 2026
 20:14:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
 <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
 <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com> <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
In-Reply-To: <CAPhsuW5MN6ikKmxgqby5RJ3_gvjJ4B77X74OvfbTQoFO8iUgzA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Apr 2026 11:13:51 +0800
X-Gm-Features: AQROBzAwoTocrSdgLlq9jjuaEvd25BiOxk_ha4-MCiHen7ISJudiyPIWC0L9dTA
Message-ID: <CALOAHbAmTAfamStF9sZtO6efWYJ1sbXJp3PbsVapZf7dba91ig@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:47=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 6, 2026 at 7:22=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Tue, Apr 7, 2026 at 2:26=E2=80=AFAM Song Liu <song@kernel.org> wrote=
:
> > >
> > > On Mon, Apr 6, 2026 at 3:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > On Sat, Apr 4, 2026 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> =
wrote:
> > > > >
> > > > > Hi Yafang,
> > > > >
> > > > > On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > > >
> > > > > > Livepatching allows for rapid experimentation with new kernel f=
eatures
> > > > > > without interrupting production workloads. However, static live=
patches lack
> > > > > > the flexibility required to tune features based on task-specifi=
c attributes,
> > > > > > such as cgroup membership, which is critical in multi-tenant k8=
s
> > > > > > environments. Furthermore, hardcoding logic into a livepatch pr=
events
> > > > > > dynamic adjustments based on the runtime environment.
> > > > > >
> > > > > > To address this, we propose a hybrid approach using BPF. Our pr=
oduction use
> > > > > > case involves:
> > > > > >
> > > > > > 1. Deploying a Livepatch function to serve as a stable BPF hook=
.
> > > > > >
> > > > > > 2. Utilizing bpf_override_return() to dynamically modify the re=
turn value
> > > > > >    of that hook based on the current task's context.
> > > > >
> > > > > Could you please provide a specific use case that can benefit fro=
m this?
> > > > > AFAICT, livepatch is more flexible but risky (may cause crash); w=
hile
> > > > > BPF is safe, but less flexible. The combination you are proposing=
 seems
> > > > > to get the worse of the two sides. Maybe it can indeed get the be=
nefit of
> > > > > both sides in some cases, but I cannot think of such examples.
> > > > >
> > > >
> > > > Here is an example we recently deployed on our production servers:
> > > >
> > > >   https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy=
5hy9Yqgeo4C0iA@mail.gmail.com/
> > > >
> > > > In one of our specific clusters, we needed to send BGP traffic out
> > > > through specific NICs based on the destination IP. To achieve this
> > > > without interrupting service, we live-patched
> > > > bond_xmit_3ad_xor_slave_get(), added a new hook called
> > > > bond_get_slave_hook(), and then ran a BPF program attached to that
> > > > hook to select the outgoing NIC from the SKB. This allowed us to
> > > > rapidly deploy the feature with zero downtime.
> > >
> > > I guess the idea here is: keep the risk part simple, and implement
> > > it in module/livepatch, then use BPF for the flexible and programmabl=
e
> > > part safe.
> >
> > Right
> >
> > >
> > > Can we use struct_ops instead of bpf_override_return for this case?
> > > This should make the solution more flexible.
> >
> > Upstreaming struct_ops based BPF hooks is a challenging process, as
> > seen in these examples:
> >
> >   https://lwn.net/Articles/1054030/
> >   https://lwn.net/Articles/1043548/
> >
> > Even when successful, upstreaming can take a significant amount of
> > time=E2=80=94often longer than our production requirements allow. To br=
idge
> > this gap, we developed this livepatch+BPF solution. This allows us to
> > rapidly deploy new features without maintaining custom hooks in our
> > local kernel. Because these livepatch-based hooks are lightweight,
> > they minimize maintenance overhead and simplify kernel upgrades (e.g.,
> > from 6.1 to 6.18).
>
> I didn't mean upstream struct_ops.
>
> We can define the struct_ops in an OOT kernel module. Then we
> can attach BPF programs to the struct_ops. We may need
> livepatch to connect the new struct_ops to original kernel logic.
>
> I think kernel side of this solution is mostly available, but we may
> need some work on the toolchain side.
>
> Does this make sense?

Are there actual benefits to using struct_ops instead of
bpf_override_return? So far, I=E2=80=99ve only found it adds complexity
without much gain.
Can we add something like ALLOW_LIVEPATCH_ERROR_INJECTION() to allow
error injection on functions defined inside a livepatch?

--=20
Regards
Yafang
