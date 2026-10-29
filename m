Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313228;
	b=me7n2/SWnGXY/z/4SolGWJldSVbHpx527M7bZcNVPjUiqOIcSPZDbval+0v6Ol8xA8xT
	 Dk/R4uRHTmI5ofsBoc48iOppTWwEpyncSwUaDuoMOJn0nB84jF6GBs2i51Pp/EK9CH9lV
	 2Rh7z86VrVzvhbUzxm9PYdTKz+MDo3sK/uKnWSTU7g6A4iTiGuKD5Yz88r/mElAlz5qcf
	 ArNapsKCQ6i0hBtjHzXu9G/3eveUgwaXZAzIOt6Jdh/p+k6pG423vLDt3DB8xY/uSVMsl
	 Ul2NA8g1mJBhfVbH0K+4wac5yDu3n8pqKZ0Uz4CTKHUPiv0Y+5QiNrg6p8JohJ587EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
	b=do6RVf+LICNErimbhnkCikJN1fBudpQ+C4U4B6t2IaS7B/f8vX4PXDHppZKLrGkbv313
	 4YZPrg7pczLZ8MRm2cW6SyWBHhRhWy9ISaN6QTDypg4x+nQUeOPz083oQ7PUFihOnuF2p
	 9xZnBv0OKDr3Zq8Hl2mHxQHmn9ZRt3ebv7DyAUrirn8YXlv6KcjWR4N0H5bRVsr4mdrQh
	 Dy4XY4xGVC9zTzI97nJOLwoaMvjaexIQo411jAw3jDgXNzSfvm9Vt6dMpW2rK04/3yUhe
	 vo5Ndd3VpfEtsaXsZ5nsBhQdHm1g8WdShvgRw+kzA4tDGijijmi7ApercUwTxwISg3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t/bNGN/n";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C19606A325
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C19606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t/bNGN/n
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so6804905e9.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793313226; x=1793918026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
        b=t/bNGN/ntazoGXxm7cEZZ+GwsGGsVh+C/0Yut+b49ElxU09W4nXbv1RAqNfYKvcJHq
         gOGys9TQp9AY0Af1UtWfeQ94USgYjsksf7rqxv43aOs4K/6L4QwE/YkFsmJPISOhN3Ib
         /nbmG8zYiEi8kSCiQybCdUzIBXmdKKb6/yNOgeJ/0pNXqt7/CSdeVO2Q2JdQCILUuTF7
         qwCtWsvbTtAAjeMV4A4cwc8R16QkWvQsJ/IU6Cz0mRo6BSolCCS4gHWpxoa7KDLD3O0t
         uVtXEeLvOC1hcynSXlCTgEgiaRd5A1TtFFfR21YrZO4HhQE0tjgHG9m1BJNgGd0EVTZp
         VZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313226; x=1793918026;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C16if6DY4JWsOG2lgpyOm+rUUE2AWwmlNktllWtOWQ=;
        b=JGbOhwwhr1uPax9qIWLGA9NfT4BlmQXeJoiv2nlYfz39CqVS62Gk5ohP0BsU5ENWuf
         efO83Mi07bdbzs5nj7ygdVrs0mCWBlMYrg2RchH6Q+QiXfNd5b14j4IbgyAsdhI8+7nA
         5qcgvDS/sAkUWydZUaANV2whUqDEZkUfXSothrBxqYOCOlgdbeTjQP8amiPJob7X4LPl
         NyAv9eabH0FECAdEuTdYKZ1QqDT8Jjqxw6U8nh46SgfO4whzhTmcAo0Nfl9GvyBmwwJ5
         ytLVveptSCXIH4vUvn1z7t/8KFQ3DqKNAIVcaOiMrFRC9QP8ZQNVnvoslymfS2bzIb7E
         E6bw==
X-Forwarded-Encrypted: i=1; AKwUvBwCU2S/YhCckN9V3I676bvFt7+uqaZ9MQO0JnyF9yysutpXjhHyVfqN73R/amUJCJ/dgxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6Q1AQIfTIciXqLRSJaADnPtROB5hi8l09UVhWSZ0gR5ibD/qY
	EhDIMFnOpzH/nrm7c00qwdaO5UZrd1dKCzGcYg34cHiTKuSjq2X9mHRQ
X-Gm-Gg: AYBFou0CR6gaN+af9m79cPPm4kucbzwads3TLTz/oqy4SEZ5NLK7OD8ddUtoa5Zy6jE
	j+3Uy/CKIGGzF6s4hvoZ5BsTufwPDqQ9xaX/X98mEU2aQx6e/HaqLsjs1WZVUPFFinYNpQxzmWr
	7N/lU24QqBluTMyp2FL82qxNjN3UMPpOeiCB6DfMh9Ah4zwN2/SRO68r+7LQgM2g7MOtidjYg/g
	q3EqhFfR9KtktHqR0PmYBGKT1qA9Vixo3v6vwaaGTadft3gStTQs02WBcA9t/ZiyANljrKCGpBt
	WaeRAlFSSZ/EIgdHyfb+9YC0xeOdIv+StA0PEp8IgozJ8+z87F7ewB23ngwUiBEdCS4W+QRr142
	ynPz7+3Cs4BYWE74jrG0cGhIrkdga8a1NCZyEvfB3t7WECohXGLpXmx0vRdhui2n+ByT6B8yOE2
	YPVxYhf2/JuJ03xfQi0zPI03EFcn/6dAZFVqRa2pnQXai37I6qwLDxFdNLUEOAyVMU+4vvpEHvi
	GCdqHsU5Slj695u9FiGQ1moQhHdCEA+MEcE+hhkrZHcoHJeYSbiN15gHTXDJnYmmxFPt8rTm8Vb
	o/o8UpH+S39nCBPeMz2e+TajjWdzYBR1pMTR64iQOSeLyt7QFduZzwNTwtO6IfeGTLuooX7zFeX
	/ppHevsWcmTI=
X-Received: by 2002:a05:600c:4687:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4ac16fa4dadmr7994095e9.7.1793313226338;
        Thu, 29 Oct 2026 15:33:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm91077035e9.1.2026.10.29.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:33:46 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:33:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis
 <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
Message-ID: <20261029223344.5dbe60d5@pumpkin>
In-Reply-To: <CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
References: <20261023001603.560210-8-wusamuel@google.com>
	<20261023001603.560210-12-wusamuel@google.com>
	<at8dNNb4vwovNZcZ@krava>
	<CAG2KctpMEuK5OJSedSFshNMSwOqe1g87m2ZOKBhn=Z5iCA45Aw@mail.gmail.com>
	<20261028140127.7bfeab46@pumpkin>
	<CAG2Kctra0GYjkzggB0cdMxPK-b9U9x-m+gR6E8goAYvhsNXEdA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2026 14:35:36 -0700
Samuel Wu <wusamuel@google.com> wrote:

> On Wed, Oct 28, 2026 at 7:01=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 27 Oct 2026 15:07:44 -0700
> > Samuel Wu <wusamuel@google.com> wrote:
> > =20
> > > On Mon, Oct 26, 2026 at 2:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com=
> wrote: =20
> > > >
> > > > On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:
> > > >
> > > > SNIP
> > > > =20
> > > > > +static int bpf_object__query_ksyms(struct bpf_object *obj)
> > > > > +{
> > > > > +     struct kallsyms_query q;
> > > > > +     struct extern_desc *ext;
> > > > > +     int err =3D 0;
> > > > > +     int fd;
> > > > > +     int i;
> > > > > +
> > > > > +     fd =3D open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> > > > > +     if (fd < 0)
> > > > > +             return -errno;
> > > > > +
> > > > > +     for (i =3D 0; i < obj->nr_extern; i++) {
> > > > > +             ext =3D &obj->externs[i];
> > > > > +             if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> > > > > +                     continue;
> > > > > +
> > > > > +             q =3D (struct kallsyms_query){
> > > > > +                     .size =3D sizeof(q),
> > > > > +                     .query_flags =3D KALLSYMS_QUERY_BY_SYMBOL,
> > > > > +                     .sym_name_addr =3D ptr_to_u64(ext->name),
> > > > > +             };
> > > > > +
> > > > > +                     err =3D -errno;
> > > > > +                     if (err =3D=3D -ENOENT) {
> > > > > +                             err =3D 0;
> > > > > +                             continue;
> > > > > +                     }
> > > > > +                     if (err =3D=3D -EADDRNOTAVAIL)
> > > > > +                             pr_warn("extern (ksym) '%s': resolu=
tion is ambiguous\n",
> > > > > +                                     ext->name);
> > > > > +                     break;
> > > > > +             }
> > > > > +             ext->is_set =3D true;
> > > > > +             ext->ksym.addr =3D q.sym_addr;
> > > > > +             pr_debug("extern (ksym) '%s': resolved in kernel to=
 0x%llx\n",
> > > > > +                      ext->name, ext->ksym.addr);
> > > > > +     }
> > > > > +     close(fd);
> > > > > +     return err;
> > > > > +}
> > > > > +
> > > > > +static int bpf_object__resolve_typeless_ksyms(struct bpf_object =
*obj)
> > > > >  {
> > > > > +     int err;
> > > > > +
> > > > > +     err =3D bpf_object__query_ksyms(obj); =20
> > > >
> > > > hi,
> > > > we could also add similar support for libbpf_available_kallsyms_par=
se and
> > > > probably in some other places like bpf_get_ksyms.. which makes me t=
hink it
> > > > could be useful to have KALLSYMS_QUERY support for multiple symbols
> > > >
> > > > thanks,
> > > > jirka
> > > > =20
> > >
> > > Thanks for lookiing over this Jiri!
> > >
> > > Using KALLSYMS_QUERY for libbpf_available_kallsyms_parse() would
> > > theoretically by O(m*log(n)) instead of O(n*log(m)), where m is the
> > > number of tracefs symbols, and n is lines in kallsyms, with n >> m.
> > > But AFAICT, libbpf_available_kallsyms_parse() would only be called in
> > > pre-6.5 kernels, for kernels without commit 83f74441 (ftrace: Show all
> > > functions with addresses in available_filter_functions_addrs); so this
> > > ioctl could never be called. =20
> >
> > Isn't that code also O(n*log(m)) ? =20
>=20
> Yes, sorry maybe I wasn't clear before, but the current code is
> O(n*log(m)), and the ioctl approach would be better since it's m
> lookups of O(log(n)) for vmlinux symbols, where n >> m. However, this
> is a red herring because that path only runs on pre-6.5 kernels, which
> won't have this ioctl.

I was thinking of the ftrace_lookup_symbols() code (called from
bbf_kprobe_multi_link_attach) which O(n*log(m)) (the wrong way around).

David

>=20
> > I've got a patch (I might send it after the merge window) that changes
> > one of the ftrace functions to look up every symbol by name, not just
> > when only asked to look up one.
> > It can also use the 'callback' function to detect duplicates.
> > That should be massively faster - especially with my ~18 fold improveme=
nt
> > (also waiting for the merge window to end before posting a new
> > (not much changed) version). =20
>=20
> Excellent, I'll keep an eye out for it!
>=20
> > Does look the the code could do with getting the 'symbol name table ind=
ex'
> > for the symbol so that it can read the entries sequentially from that
> > point onwards.
> >
> > David
> > =20
> > >
> > > And regarding bpf_get_ksyms(), it loads all traceable functions and
> > > needs the full syms table, so a /proc/kallsyms should fits better.
> > >
> > > I did profile a slightly different form of querying multiple symbols
> > > at once [1], but didn't see much benefit. struct kallsyms_query is
> > > extensible via size and query_flags, so we can update in the future as
> > > needed.
> > >
> > > [1]: https://lore.kernel.org/all/CAG2KctozPSev+EXSpHitM3JWfjufQaEjsPJ=
HS_1HJ1wSm7sJ1w@mail.gmail.com/
> > >
> > > [...]
> > > =20
> > =20

