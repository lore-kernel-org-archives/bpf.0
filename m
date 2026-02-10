Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B6C318BA0
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770742692; cv=none; b=R/n/EKCzGXANo9A6Qc0LWomy0hB9QHUci4z9b/hgGi1VkZ7hGgTV+UJzPx27mFUWKFFGLMA9BcM3CNnifPWpQv9OE1CCceLKzlFfdcXcGLr3P3IMhOIAaJktNyDB0ePXHZbYYb5TVlTeN6eWtVLT/yIn3Iu0zpbLvnkNL4b9anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770742692; c=relaxed/simple;
	bh=Av6exp8b8v9M/B/xinzeWxWXNB7Pvp5rwEFqIj/TZR4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PIGr/eY6EvBeCGoCk8fH5Anpy8IAbrbpmLaXGK9vz3rRCfiJAtv3ZORx77lB6Z7SOIK4UaDUAMpBvDz6D/YebdGgYQOrUoE8ZBWv+f+4HLF0FUYzZ3YjLeHlTiqlBtlFB1kEcxJjuF5I3+IVMiMNGRLC+CaRuaPZ+9j+X+bn/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=reBoy+9R; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="reBoy+9R"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014b7de222so57732561cf.0
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770742690; x=1771347490; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gBKUSI0HV1A8ixUFw1rK37+DKikD+l8dudFxZELUvs=;
        b=reBoy+9RJC1XaNNZCvpf5HzFzA1K2AgSMSxwj9SG805NpuWfuYjDkmogH5pmbGZ3G4
         jtBrcKtW9STWe4d7fTZiQ8Ip0Agb3upW0X5NcUop/xniF6Y8YnQ8wQJAjP7ueEMqL92A
         TlLZLN+KqxmNQdeUvxJOt+PJFlzn1ZXqVX7YqcJseNhnJFHn9HZ6OUN61cvzpg1tJgj8
         JqxS227/EGGYEsTl5tgoFVcojJ1zhEeKBjjh8zw+0BazhYxeMxgqCWCkeFrlMpEfqbAk
         oA9OWnHw4QaMhv2d/2FKMNb9ZVaYFS1UsPlpW1X6zb1xxwqk2NTgR71fn7XAhGY9ny6S
         uwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770742690; x=1771347490;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gBKUSI0HV1A8ixUFw1rK37+DKikD+l8dudFxZELUvs=;
        b=s6TK8OgOAtPnU9It3fLie9/A10/94EyndSS67y1sLAeUsoEYw9X682y21S5sst16De
         0xmLAXc8tyOdAVjIPH7s0NI3XmNMZKNtSqDRHdsZQEAExCs9ui2YNR3qTypk6QrrKeAn
         X2QrrXqPKafZ+lChGg5oH/464Co8NROx0FkfEClUbepv+Oe6QKtvm5t10tkyIMbMv7ZM
         5iH741j9Q5NXzGPgWCpvRW15IbD/TBPVgKlVXE41eajnKZ4IduPnvOJ1rUMhjSVgyR0D
         V15SZASF2H4tUZnl5NTmHGr61igDgEIbLKOMnWkyk4KBHIWvrdKgPic4RMSzMtAOLnD4
         lSmg==
X-Gm-Message-State: AOJu0Yzrh7e7+4gL200mgDQFTotpMVj8h+y81mD4w2j2FIlGavigKPtd
	7sEEloMTNSvXUttYH/3S5UweMwIQSf/4/z9+3x1ZZft8piNtEg3ayi9mLwyugVeQ0OM=
X-Gm-Gg: AZuq6aK57CowXVLa4P1GT5smRlpanFnw00/5xHLgbxEMgDhVFF6WhHp50evwJov8Pt5
	VAN4mc7j0tgdayQgdYn15Fe+vTcJpC77rdIYWzNxlMV47X0FG0C58wUQEZufvZZ4soJoENyCw6S
	pfyroiGUM/Nbv/Udw1SLpAFTlMiL8IYJxkIF9APYYfhSb61Vhtz4Li+mkyHL9Oc4IbmVwOgPpoG
	Ua3bdmmVjbyS0Lxd84CjNyAgej5e06Rkn3xLhlxiAeDIErcuha2lGUMBLzKG3W4HNtsGjhvEdbE
	5UBMgm4JNOJdRKaea5GoBY4FVoEGJPmh/aoP9YC2rWdDA7z/cplSJS2KHk3qvn40AWGksonlnd+
	lTnDBeO24+K9uK7QrIZnBXIrDiCMaOrH0bbH2h0uUM+sKoANPfFotK4hkHgPtewhfov+xVOvlYg
	dezF4ktIVHT4rBQZbMYjrwOoo=
X-Received: by 2002:a05:622a:198d:b0:501:4701:e9f9 with SMTP id d75a77b69052e-50673d211e1mr31140241cf.26.1770742690080;
        Tue, 10 Feb 2026 08:58:10 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5064543c20bsm88735261cf.29.2026.02.10.08.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 08:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Feb 2026 11:58:08 -0500
Message-Id: <DGBFW91VCL51.2IQKDI5QP98UF@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <martin.lau@kernel.org>,
 <memxor@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3] libbpf: Add gating for arena globals
 relocation feature
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
X-Mailer: aerc 0.20.1
References: <20260210005508.3642641-1-emil@etsalapatis.com>
 <CAEf4BzaLqWT1oj-EXibyAfE0ExmiaCCqhosRujDi7Y0Nyho6dA@mail.gmail.com>
 <DGBEQ37JLW22.2IFYZDGMHZI2G@etsalapatis.com>
 <CAEf4BzZ1tedVxfv6G+F_w8TJ7ngkHe9Uui22xXOGc24Kdpi5nA@mail.gmail.com>
In-Reply-To: <CAEf4BzZ1tedVxfv6G+F_w8TJ7ngkHe9Uui22xXOGc24Kdpi5nA@mail.gmail.com>

On Tue Feb 10, 2026 at 11:48 AM EST, Andrii Nakryiko wrote:
> On Tue, Feb 10, 2026 at 8:03=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis=
.com> wrote:
>>
>> On Tue Feb 10, 2026 at 1:54 AM EST, Andrii Nakryiko wrote:
>> > On Mon, Feb 9, 2026 at 4:55=E2=80=AFPM Emil Tsalapatis <emil@etsalapat=
is.com> wrote:
>> >>
>> >> Add feature gating for the arena globals relocation introduced in
>> >> commit c1f61171d44b. The commit depends on a previous commit in the
>> >> same patchset that is absent from older kernels (12a1fe6e12db,
>> >> "bpf/verifier: Do not limit maximum direct offset into arena map").
>> >> Without this commit, arena globals relocation with arenas >=3D 512MiB
>> >> fails to load and breaks libbpf's backwards compatibility.
>> >>
>> >> Introduce a libbpf feature to check whether the running kernel includ=
es
>> >> patch 12a1fe6e12db, and only relocate arena globals if it does.
>> >>
>> >> CHANGELOG
>> >> ---------
>> >>
>> >> v2 -> v3 (https://lore.kernel.org/bpf/20260209234850.2750149-1-emil@e=
tsalapatis.com/)
>> >>
>> >> - Rename feature to better specify the verifier feature it probes for
>> >>   (Andrii)
>> >>
>> >> v1 -> v2 (https://lore.kernel.org/bpf/20260209210240.2051209-1-emil@e=
tsalapatis.com/)
>> >>
>> >> - Reworked test to use simpler array-based program (Andrii)
>> >>
>> >> Fixes: c1f61171d44b ("libbpf: Move arena globals to the end of the ar=
ena")
>> >> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> >> ---
>> >>  tools/lib/bpf/features.c        | 92 +++++++++++++++++++++++++++++++=
++
>> >>  tools/lib/bpf/libbpf.c          |  7 ++-
>> >>  tools/lib/bpf/libbpf_internal.h |  2 +
>> >>  3 files changed, 99 insertions(+), 2 deletions(-)
>> >>
>
> [...]
>
>> >> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_i=
nternal.h
>> >> index fc59b21b51b5..974147e8a8aa 100644
>> >> --- a/tools/lib/bpf/libbpf_internal.h
>> >> +++ b/tools/lib/bpf/libbpf_internal.h
>> >> @@ -392,6 +392,8 @@ enum kern_feature_id {
>> >>         FEAT_ARG_CTX_TAG,
>> >>         /* Kernel supports '?' at the front of datasec names */
>> >>         FEAT_BTF_QMARK_DATASEC,
>> >> +       /* Kernel supports LDIMM64 imm offsets past 512 MiB. */
>> >> +       FEAT_LDIMM64_FULL_RANGE_OFF,
>> >>         __FEAT_CNT,
>> >>  };
>> >>
>> >
>> > So overall this patch gets the job done, but I think we should tighten
>> > it up. I was curious why you have so much ceremony, so applied your
>> > patch locally and tried to strip everything I thought unnecessary
>> > (plus reformatted that big comment to be a bit more greppable). Here's
>> > what I got and it seems to do the job...
>> >
>> > pw-bot: cr
>> >
>>
>> So to recap:
>>
>> a) Remove BTF as it's not necessary
>> b) func_infos is also not needed
>> c) Use sizeof(log_buf) to avoid having a separate variable
>> d) Use a TRACEPOINT program to avoid the SLEEPABLE flag
>>
>> Will update with those.
>>
>
> ack, thanks
>
>> For two of the changes I have questions:
>>
>> >
>> > diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>> > index 034ea9b20617..6e27aa618e70 100644
>> > --- a/tools/lib/bpf/features.c
>> > +++ b/tools/lib/bpf/features.c
>> > @@ -508,90 +508,64 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>> >
>> >  static int probe_ldimm64_full_range_off(int token_fd)
>> >  {
>> > -       const size_t bufsz =3D 1024;
>> > -       int btf_fd, prog_fd, map;
>> > -       char log_buf[bufsz];
>> > +       int prog_fd, map_fd;
>>
>> Should we rename here? Every test program in this file uses map for map.
>> No strong opinions one way or the other.
>
> given we have prog_fd, yeah, let's use map_fd here as well
>

Ack, will do.

>>
>> > +       char log_buf[1024];
>> >         int ret;
>> > -       static const char strs[] =3D "\0f\0";
>> > -       const __u32 types[] =3D {
>> > -               /* [1] FUNC_PROTO `void(void)` */
>> > -               BTF_TYPE_ENC(0, BTF_INFO_ENC(BTF_KIND_FUNC_PROTO, 0, 0=
), 0),
>> > -               /* [2] FUNC 'f' -> FUNC_PROTO (main prog) */
>
> [...]
>
>> >
>> > -       /* Be conservative and NULL terminate the buffer to ensure
>> > strstr terminates. */
>> > -       log_buf[bufsz - 1] =3D '\0';
>> >
>>
>> Should we remove this? If there is no guarantee the buffer has a NUL
>> character somewhere, the strstr can fly off past the end of the array.
>
> verifier log on error will be properly zero terminated, that's part of
> verifier contract, we shouldn't doubt it
>

TIL, thanks!

> [...]

