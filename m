Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016191842
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208438; cv=none; b=X2I6WpaKB8/af+gbOE8kvejopzH4rmSKAh9aiRbYZknZ87fsmTJkKgPEr542GnptD59zoXc/b8O6KxRkkzHKPOYiV3zdEDp+qN90GGblzykbFof16Fh41rUj4NwhkyHNO03FeMgH/2lBuUVOo+LPRJHWJ3Do+Qcmld4nlllYnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208438; c=relaxed/simple;
	bh=I3fTBn/wVvCv8wJz3S0c7XFDmGuGRN+xuP6W+JUCPFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ux6xq5QWKApmj7XyOLzd3TXHCTbxX47hGI/0GLPiZZ4WKlJuBukoYvF6qyxI9E5Czyk6VWIgCjJfvWKIs3bNLezvseypMj4VquCKl2XE+eBYcRzBaHcuI+vKs1AoYppkBohVHb5iL3e4WYfZJpoxN5u2dEBmNCIHM+Mr/jyYQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gqzO+a1j; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gqzO+a1j"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3707151a12.0
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 18:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710208436; x=1710813236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+8U24REJsycoMY3gapLXd6No4Kdp5va5OvGqVZaNtY=;
        b=gqzO+a1jjHOI/w0pMfToI1QKtDcRnyMXI1L4htcnM9oM3BxUP5MzM64TykQ1A/w61B
         6SN/UpkjdOP/nLhZYMxzhkf8I1bt098WSz2tbezMnBmbXzK1vSkzxRCr8zwY23epb+Hq
         DwyNxPr4uAglsLiod8M5wN3XSVQztL9k2Tp8h+TsVRhyLfTqLN4yAscHjE9s4XdONMG6
         rQI98uDiDheGtIYYe3ikSJZFDL+DpK7Fof38hYjjh7hhvmvNvRVBJ9z6xdbZtgnGTfww
         0s9ah7zPLeQ/eP8dnV6Ocnt06QcFG5Mz3K5dRAaYWlLI7UWaVi0l8kTd77ldtBLe7SAP
         DjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208436; x=1710813236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+8U24REJsycoMY3gapLXd6No4Kdp5va5OvGqVZaNtY=;
        b=mS7RVyhoN3Ejk2kct1b9Q167ZaEoTpasfkwLH2UA4PAW9qKBCY9XiiLUILAU9yXshR
         GHksw/s2owHt8BfcE6CKBLH0WIyiiVn0O7d8suHEl4GTXot5B3rnrlh94xy1mpyBqhJV
         kZByMS79Z8WuK0yMI6XK1sxrJHbo8UFrF1lBcam7yPgzNf6+e6dz7tLLeMApi494Zql7
         hdut7Riek2/lJzBmjjns/QhhzzoujpuADb0DbRVSvhENq1jPH5xGKkhF0zF0KeSciqJx
         rXNDemDfMGdbqbUGhrM9T+fJHi8LQgMqF9PJjvIxm2a4yZarKdQCy2RLN0hTF4w3aAC1
         q7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWlI6PH9AsvYZ5+tJ7Mp47jjozRBLCyN6KcSlqO+EAq36VzjsJTUWMPMJkoWYUkZXX3OgvWY8kAyaoylLED+hiXcveo
X-Gm-Message-State: AOJu0YzeN3PCCC5/dKCcKExfHM/2anG4b/DEgnivgfTDM2Gunhjcuovb
	AMhu615eqSRxvronE5rhzgxi1oKfi/M6Lczu3HP0mKbHEdlDqPdniQ5TlVZA5S/XQ5IxNFJ8TaZ
	1Asm8Ms4elBtBkiWPSuaDvlhIaQWnOc7tKbbFqg==
X-Google-Smtp-Source: AGHT+IGOVuFmtgDB4ZKZlti8h1HNW5R33qsIGe5aBgT97QBW6StCjxMixdB7ixy5JtN/Q4HVD/m09pDHUBGfcjfmCjc=
X-Received: by 2002:a05:6a20:429a:b0:1a1:4a4c:9f5e with SMTP id
 o26-20020a056a20429a00b001a14a4c9f5emr646029pzj.49.1710208436407; Mon, 11 Mar
 2024 18:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-3-dongmenglong.8@bytedance.com> <CAADnVQK57PziY+xdzW=d3HaG-bn87E3p9zf7thvmqV1t0iR4Yg@mail.gmail.com>
In-Reply-To: <CAADnVQK57PziY+xdzW=d3HaG-bn87E3p9zf7thvmqV1t0iR4Yg@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 09:53:45 +0800
Message-ID: <CALz3k9jNY8NmB-=qKogA=WVC1dGA=git_hy95UoJV2=KLfhb5g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 2/9] bpf: refactor the
 modules_array to ptr_array
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:49=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > Refactor the struct modules_array to more general struct ptr_array, whi=
ch
> > is used to store the pointers.
> >
> > Meanwhiles, introduce the bpf_try_add_ptr(), which checks the existing =
of
> > the ptr before adding it to the array.
> >
> > Seems it should be moved to another files in "lib", and I'm not sure wh=
ere
> > to add it now, and let's move it to kernel/bpf/syscall.c for now.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  include/linux/bpf.h      | 10 +++++++++
> >  kernel/bpf/syscall.c     | 37 +++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c | 48 ++++++----------------------------------
> >  3 files changed, 54 insertions(+), 41 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 0f677fdcfcc7..997765cdf474 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -304,6 +304,16 @@ struct bpf_map {
> >         s64 __percpu *elem_count;
> >  };
> >
> > +struct ptr_array {
> > +       void **ptrs;
> > +       int cnt;
> > +       int cap;
> > +};
> > +
> > +int bpf_add_ptr(struct ptr_array *arr, void *ptr);
> > +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod);
> > +int bpf_try_add_ptr(struct ptr_array *arr, void *ptr);
> > +
> >  static inline const char *btf_field_type_name(enum btf_field_type type=
)
> >  {
> >         switch (type) {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index f63f4da4db5e..4f230fd1f8e4 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -479,6 +479,43 @@ static void bpf_map_release_memcg(struct bpf_map *=
map)
> >  }
> >  #endif
> >
> > +int bpf_add_ptr(struct ptr_array *arr, void *ptr)
> > +{
> > +       void **ptrs;
> > +
> > +       if (arr->cnt =3D=3D arr->cap) {
> > +               arr->cap =3D max(16, arr->cap * 3 / 2);
> > +               ptrs =3D krealloc_array(arr->ptrs, arr->cap, sizeof(*pt=
rs), GFP_KERNEL);
> > +               if (!ptrs)
> > +                       return -ENOMEM;
> > +               arr->ptrs =3D ptrs;
> > +       }
> > +
> > +       arr->ptrs[arr->cnt] =3D ptr;
> > +       arr->cnt++;
> > +       return 0;
> > +}
> > +
> > +bool bpf_has_ptr(struct ptr_array *arr, struct module *mod)
>
> Don't you need 'void *mod' here?
>

Oops, it should be void *ptr here, my mistake~

> > +{
> > +       int i;
> > +
> > +       for (i =3D arr->cnt - 1; i >=3D 0; i--) {
> > +               if (arr->ptrs[i] =3D=3D mod)
> > +                       return true;
> > +       }
> > +       return false;
> > +}
>
> ...
>
> > -               kprobe_multi_put_modules(arr.mods, arr.mods_cnt);
> > -               kfree(arr.mods);
> > +               kprobe_multi_put_modules((struct module **)arr.ptrs, ar=
r.cnt);
>
> Do you really need to type cast? Compiler doesn't convert void**
> automatically?

Yeah, the compiler reports errors without this casting.
