Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3E1D9A5F
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788396509; cv=pass; b=MpSlzgLold9L47BTrw98RE2cuCfHII+4RwlSp2UnSJWiVSUzjHQerS5GUJ51+CerfbSMGZLnrEZFmtuHdcVlSLsxZGDZcaoRsYzl5Elw52ansEiAse6XE6yA+trSOChAyC3V8ykUPacMFYMKodyAm142a1AhJ+Nkzq05bIXZJcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788396509; c=relaxed/simple;
	bh=pcMbVHcQmHfSQ80hXIs00Z5K3jn7dtMrGjSap6QOZNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gelqy0VhSgWwA07vn6mfxjbAsQRD7FWwxNQ+W9dW3ZH2RRSoeABCmNYsf33ItL6lud7RNOrs5Te41Lsk6FGI8GSUOuulKbHajDl3caE7umk5rFG2YFHffCBJdkSLaumpeBrbkL7z9BUZbUKQvUGN8PvSrir+C0cRe2z35ehEA90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYPeR/7u; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYPeR/7u"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2313169a12.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 17:48:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788396507; cv=none;
        d=google.com; s=arc-20260327;
        b=DsvjBHlpr8TxuiyaswwQkQSWjSHBsvn0Xcw49TBEoJ5mrj6UleOwdmzFbsuPG0pQ6x
         kAL0QOubMyiDexPXxZz7Bdwb4Gl7UO8siBvldacQQY0nKWVp9ntkn5CfrBA5K8fyq73U
         DqPq8nAwlT/FF8CaR2uOK1c4YRrq4Sw5peklnK+OM9vlUp1d73LeI3IdeD4J4QXwB3nb
         qTSH4+9xOieK8lxhiQqXyRJS4p1/m6nXOYRzAHCvzC/IxdZj/Ot8kEArZp+E47tknbn9
         v25DT5Y+2zMFWPMDs478iICCg/h3H94pR7hRilZuL0AyZEQaxLvXqIU7A5sSLO2VFb/5
         zfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcMbVHcQmHfSQ80hXIs00Z5K3jn7dtMrGjSap6QOZNE=;
        fh=I/Tn4NPtfjVIpidn/WjyPBJ9LcR4egsDtKyjhMU6Ucw=;
        b=Uq30362VyIu6NS9xUOjwiVhI3u7AbGxhwXKH1A7Zdbl2X3zmf3wasm25eucMFlWewZ
         MVDiDxzG1Qq4ViZxZu3RNJj3cTb1x1CSoJOF3ejMXH8JZmvyzfD6MBhVEm3j/4zz0fMv
         DL+up7fqAqO2Q55/Zlo1Pp0KrFSebZx7LSWxU49v8RRLpihQz/TZlEwV382vwAJRUs2T
         w0LixMT6HWLKjP0er5bN6dIdOJi5+PbZvEOPUL5GUSM2jgm6UKXF2/tA4Vk5GR8I3KN1
         bMR2F9fSYTGQYz/LdUAo99DytixftEEhFKqgCppyf348VyQe7o/aamA9fOt3zz6KBipp
         5lGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788396507; x=1789001307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcMbVHcQmHfSQ80hXIs00Z5K3jn7dtMrGjSap6QOZNE=;
        b=dYPeR/7uEMlrn1zIOPnWEPkg3No2sxKEbTjj5Kyu+4BT9aLyKu1Zcc6EVomS97p7IA
         mFtS7b2ZZi026IUtk7uQTXN2WWBjijejMW2ebarW+IcuFxKzFVXULBUPP0Ca7s27/tPW
         PeRo/Ko0jDMS0GhPdwyvHZGsBOG6G2fOaPMoFsPwi7R2FE+tGkBqZhynF9PbA2qffagM
         SynwLkbXI1ngJdS9clV1RiA2EgcTsj2wb4cTyRJ2cnVhNXmnj49yCH7T95ecoVc5DQn4
         0zkzYYIjwUMEMWslJlJi+5jC8WNgYtbp9pgNVFfka77JW5wTJaPiA09suy/Aq5JAolNM
         akCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788396507; x=1789001307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcMbVHcQmHfSQ80hXIs00Z5K3jn7dtMrGjSap6QOZNE=;
        b=DTbxc0muL3mg6adQfyRQsZYy3Z9vlL8hlcqfhhUIYg+eWunSlOIFg/vgQOT5I1+0Jd
         e6ohQFmKxtXHIAYITfHAFwMR7bRMdup+A/NfC6e2wMxVbvuc8HBU0h60j5wgZyEA2Jzk
         IWasY5XZZqbr8vFqhCg6Z8eeQAlA3nuBRnc13aKTQb75L2XcVT1zT8OxSRk5lqHW2+Zc
         4VV8Z+ZCIFJD+f/vI+TeVhh0zNOh3oYRXdkGVqjgactHd1jy5N2ZXJfGBWoz6VZHRzSo
         ofn1VgNJ/MR0WDREW3bVTx11SDeg0fnkImziPceYiCd2oIbKqZV2zLnpVd0RarDhHYws
         vhTQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4AoUwbHtaGZpP5jWVAmZKQk9Tmq6ZSUR2dtByUA9hpY+uZbOW0dFu/slUNIuvhK7EuOQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ntmKHkn1H41IlM+i53Xm/1Jh4Z/ORjKHDkWZByf3pxFWilrffj
	WGytkG7zM3XXrtOGjWv29GahTZPmTV1MQlwLPwGi2vn9B+ncG7T4HSboSqoAXlS1N3lTVWZLhs+
	cmTrkpXkVr8DMMpDIexAMCu+4R5JCQvE=
X-Gm-Gg: AYBFou18Cxwn2yCD+eRbq4syrZc03Ivlpm1qf2UMDH10RocZKOIqXnATGKntsiUgU2e
	mNtGXN1c/LBezWsMetS2zNohRuHiFAi2xbneBFIskrgAiNDGRTDF2JyToA8hLorgZ/khN6d0AI+
	5pFKPWoWxDPT/sKTUMBn7mDG48PmNe8aitgorGvri6F6VVtt70tWzGuMys02AKfM3MC2p2TlT1V
	jqXYvF+VDueGwiKF4wo9i3fMLEUO8T1M6KHyLF2tVLWXIw3sWtY7jQ7Zm6DN/uT/Io9wM80dU42
	wwOH+M3yf9Z6fHIW/9y88FS8p9Tq2rjTp4e6uD0x+Y8bYeL6i3i7KwACx0czejK+w81ol+xi1yl
	wnw5zbdItyxBChl52f0/pSMYnME3PNjOmfUMTKJp1jvoqWz8IADyp
X-Received: by 2002:a17:90b:3b81:b0:398:9be5:b41d with SMTP id
 98e67ed59e1d1-39aee2650cdmr12358772a91.24.1788396507007; Wed, 02 Sep 2026
 17:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com> <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com> <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
 <DL4R2YXF9J8G.203VBANYFFSET@linux.dev> <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>
 <DL57W17T3VEC.1EJMWXYOB7JFU@linux.dev>
In-Reply-To: <DL57W17T3VEC.1EJMWXYOB7JFU@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Sep 2026 17:48:14 -0700
X-Gm-Features: AcwNN1W8LC8fgwtZ-phigylO3GU4p-vuY6fqVwU-3N3iINKxrRhBVAdkq7Z11_Y
Message-ID: <CAADnVQJLNW=FqPrWq7MX28iA_Qsw_N1mT923WrVkoqES1ZArjA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: Florent Revest <florent.revest@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jose Fernandez <jose.fernandez@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:25=E2=80=AFPM Florent Revest <florent.revest@linux=
.dev> wrote:
>
> On Wed Sep 2, 2026 at 10:06 PM UTC, Alexei Starovoitov wrote:
> > On Wed, Sep 2, 2026 at 3:15=E2=80=AFAM Florent Revest <florent.revest@l=
inux.dev> wrote:
> > >
> > > On Wed Sep 2, 2026 at 5:57 AM UTC, Alexei Starovoitov wrote:
> > > > On Mon, Aug 31, 2026 at 1:58=E2=80=AFPM Florent Revest <florent.rev=
est@linux.dev> wrote:
> > > > >
> > > > > How about having old trampolines skip freed programs instead of k=
eeping
> > > > > them alive ?
> > > >
> > > > Isn't it doing it now?
> > > > That was the whole point of patching nop to jmp in a trampoline.
> > >
> > > Just to be sure we're talking about the same thing, you're referring =
to the
> > > "ip_after_call" patching done in bpf_tramp_image_put, right ?
> > >
> > > My understanding is that this only helps in the case where a task is =
in the
> > > traced function while a prog is detached. It'd make it skip all fexit=
 progs.
> >
> > Right. That's the one I meant.
> >
> > > But if a task is sleeping in a fexit.s prog for example, it is alread=
y past
> > > ip_after_call, so this patching would not prevent it from calling a s=
econd,
> > > freed, fexit prog lined up after it in the trampoline, no ? The same =
situation
> > > should happen with a sleeping fentry.s prog followed by a fentry prog=
.
> >
> > Hmm. You mean like fexit prog A called a sleepable kfunc and
> > another prog B is attached to the same trampoline.
> >
> > Then the trampoline needs to be freed. ip_after_call patches jmp in,
> > and trampoline proceeds to free progs A and B.
> > B is freed right away.
> > Eventually A's kfunc returns from sleep
> > and jmps back into a trampoline
> > which is not freed yet, since percpu_ref keeps it,
> > but prog B is gone, so it attempts to execute a freed prog B ?
>
> Yep, exactly!
>
> > > I have a reproducer for those scenarios that crashes bpf-next. I will=
 make it a
> > > selftest in v2 like Jiri suggested.
> >
> > Please narrow down the reproducer (sounds like it's a random stress tes=
t
> > at this point) to specific steps.
> >
> > If my guess above is correct the reproducer will be short
> > and deterministic.
>
> Indeed. When I originally sent this patch my repro was a stress test but =
when I
> found out about the above scenario I could make a short and deterministic=
 repro
>
> My only question then is, what kind of fix would you prefer in v2: keepin=
g refs
> to progs while the trampoline is alive ? (like in this v1, but I think yo=
u
> nacked this approach already ?)

I'm worried about holding fexit progs potentially forever.
There are kernel funcs that enter and never return.
Attaching to them will pin fexit progs forever.
While right now it's only the trampoline that gets pinned
which is 4k.

> or some other creative solution like having
> __bpf_prog_enter*() skip each freed prog individually ?

I don't want to add more overhead to __bpf_prog_enter*() wrappers either.

> Or maybe something
> else ?

Let's extend ip_after_call concept.
Instead of using a single NOP after the call to skip fexit progs
let's add NOPs in front of every invoke_bpf() including fentry and fmod_ret=
.

Then on tramp destroy patch all nop-s to jmp epilogue.

llm-s helped me realize that fentry has the same issue.
fentry prog A can sleep
while non-sleepable fentry prog B can detach and things will crash.

better ideas?
