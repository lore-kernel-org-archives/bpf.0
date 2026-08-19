Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1FE3C3449
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160292; cv=pass; b=dyPJTCOOXq7hwG8vyvT/G9JCvxb0oiBiNnESvOwP/CDMId+rbC61f6EhIF1YHHXNby44RLneICwPRGam/jZBU5K08AdB/RxpGuD0NLN1q3CBBdbFmAx6K7aEBATJpGTZfQqhczwP7k6gpQm2d4Kgkeg1KXp6q2vkNkanSREX4TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160292; c=relaxed/simple;
	bh=x2315l0HX26F0q2RsoAivd6Rb//tCuIU+qZjABFUpwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCV43j2AEIkcsI8lgqWECqqEvk4BLbIyQbaErFfSdGRNDVGpmxiEdEQhAjWOAHq6ea1H5p86P9fX4BKkslY8coyXG+AuQB32xOAtlpTnE0ZB/FqTfpLi4x1tf7CU4tSeZRT50PcyHl5FRvbvIaOWjtcurn+LUR/9nRZWtUQdDXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN0p34V+; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN0p34V+"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so97928a91.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 10:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787160281; cv=none;
        d=google.com; s=arc-20260327;
        b=UgPDGjpm/vSN1Jn54kz3iff6pAp14g5Uys+pLbHw383SrrWES59/D1t9dCowka/H5J
         dm6APLyAu9O+5LUw1GXkAXKB68tfdapc8L9zFLpus2ALUC3JjajBgnJHeNq6oplLrgcf
         ZrLDvLcLQlykwUXYH2E1T6cfY8++eD7xd/En3N9omFtQTHWSWzwbACXbOqPmAO5XpgYG
         Cbs0utCz2kzuJi4uYrXzeYym8plWxZpW6gXNKatkPxNCQ78mOD9knWFPJUDov5VT9ZfK
         vO7RaNpTuo9OFqOJdOKYjktUdp44XIRn8/xB880CwDHO6bAkfuU5UisS8ejqimTsyESI
         O/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        fh=Fjv9n8iJxw3EmDYn34vM81CraWJEgy6tNke6Pz2LRp8=;
        b=BqS7ZXKqMI4GIf78t7e3LepaTzKYGiasUiCPK1IkBGoWuq1RelQk5WiBGh1CacUNoX
         9gwo1wF0sUyle8o4u9VbQDZDdreS8Vw3L1byR1vjYZ0wRhM9drqTi+iE7M9TkR+UEoHb
         a2PcKtB066oi872Bfzx97+ofnc3Xx5ppLq9r9V8NzxY9BR/NbWDFncpNv5DRy038LYlQ
         q22OcSwMuaZVoV9EslFGi98Yj8i/lpeJ6MIq75Y2gl/ndIJ84c63Q5+1FPIRf5tDNmwZ
         E9vb9IGZAMMjrkh8dswq14vTcAB2plTXNSwN3BWVEYlqjnr9iFCUefIiNHfSvgc6/MCo
         3efA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787160281; x=1787765081; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        b=LN0p34V+zf6GcmWOt/Mya4jxPGKORT+aiF7cQqitzc+HJwdziNXu1sZUsiPjChXR00
         4ZyVFyqDdIH0rcaZRUy/05DXPtRojfnnE2hY+4PqV8R2SLAwM5o24bpYyzmwTLuirojv
         9QgIMmwdogFSF8FZfsdecpl1l4rd6wtXgObtarWcs2ObaiSX9crtWET0uGxAq9EvvpT3
         VIvBw16cVId4/TBYhi3yxaJB71zdabuxIzExEdtsJk6d1Nfqg0koX/woNqgXHWbBUofa
         ujELi9PF6R27t3LXPfNBJbPdsw9nMrKeQzKbmdysVJS6+Ki+oQ/06CboDPaKn7+bPhxM
         6pFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160281; x=1787765081;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/s3DFDu7mQUXNF0KqwtrJ+MXPopmdruNjqo6IWXh1qo=;
        b=n3s0qEgA9dEr0seZWz9tdA8SzOC8A3sUIdOhlU8RyQ0j3RDQZevw5mwaODxq8gAEer
         RG2/wWcPSRJ/BE48+M98ndrClDFJETOh2RYqIZWF6zuo/nNen5uny4nkf/ZovA/yX8AN
         Z59JM9vIMT6xOTLg/cXL9LA5/Kb4zZTyJ6P/rJVDENMlnCNGz+PJs0AWpmz0HDPfNfts
         zFr+h9bQER0BkxZG7fbFHnowM3xpudksF+XY3/5aqS99nzs17Xo9xXW257O/fRgMXjmw
         zAfOUMCyDNSDnzL18QKoq3YWZrMUHeXxE8NJAyFVMIEV+UJ16aXJR9dGw5pK3tL+ocqS
         r0Jg==
X-Forwarded-Encrypted: i=1; AHgh+RoqlIcgn/vNNij6QIL/p9flFQmXdjB9/z8HLzYmQrOVASV2F9GQByAR1/0s5ov7kCjUpZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k0qWFmRv/s/jJ3Eeh9bJ4oFxPESSLjgbBDsz+/8gUoYx9wfbGN
	aYrpEsRNaSjxI/Q2KX9L0KsnJPtuGexpj2mCXRNyM9n43A7cRnoTvjyHNjhxqo7N2KNApIIIZYT
	YhunoM1+0kXwdjHLPnBkuUfSq4jAcvI8=
X-Gm-Gg: AR+sD13p0ay/GIpuaeiH0M7ZIfE8XndDTmAzce7B1dv8ZTFUE+ovvoiOOxk/x+0GUTF
	6BdXkDRo+G6GasF6PIJ1ICzoNGfC26nwBFBTcWbboYdzQ9Hd40zvU31CWoToBs1pM1HEQqOS9IA
	9vDyVs5i4KduCQH3nLSG9XRfc9Lh+eXqlUFZHzPSJ+UxAqDJCfB4+V947e696+uhiqNfxGsb0zA
	Z4N0ibmr+zz2PDXttMrhRkUk/mti6a8T8JHel7dPDABb+vxOmy1J0ouZz2ozwtlKYxpSf98T8yL
	Co/6FHt7ykVEl22m4S1H14Faj8+rytDLOZmpOEQa4WSAkYK3FSXTewfrUG7nVGk4J8sJACpcGLs
	IH3IIPkmCviffzOeWeTsopHTiRQ==
X-Received: by 2002:a17:90b:5104:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395a04e3ff5mr731754a91.2.1787160280176; Wed, 19 Aug 2026
 10:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
 <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org> <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
 <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
In-Reply-To: <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 19 Aug 2026 10:24:28 -0700
X-Gm-Features: AcwNN1V5XFvKw71PEM0biAs1oBlMlI9-0UtGl8hho5Gay8JpXC3-FqvpvbkLZuc
Message-ID: <CAEf4BzYQvhSVN=Hggg5FHzFdkRr4UNBD6yXaBsOaAwbsRpXpsw@mail.gmail.com>
Subject: Re: [External Mail]Re: [RFC] bpf: account ring buffer backing pages
 separately from Lost RAM
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Xiang Gao <gxxa03070307@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes (Arm)" <ljs@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:46=E2=80=AFAM =E9=AB=98=E7=BF=94 <gaoxiang17@xiao=
mi.com> wrote:
>
> Thanks for the pointer. Understood =E2=80=94 no new NR_* counter or
> /proc/meminfo entry.
>
>
> The remaining question is on the consumer side: Android's Lost RAM
> accounting would need to enumerate all live BPF ringbuf maps
> (BPF_MAP_GET_NEXT_ID) and read each map's fdinfo memlock to sum them.
>

For BPF ringbufs specifically, you should be fine just iterating all
map with BPF_MAP_GET_NEXT_ID, getting its FD with
BPF_BTF_GET_FD_BY_ID, and then passing that fd to
BPF_OBJ_GET_INFO_BY_FD to get map's size.

>
> Is per-map fdinfo enumeration the intended way for userspace to get the
> aggregate, or is there a more efficient BPF-specific aggregate interface
> that I'm missing?
>



>
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B48=E6=9C=8818=E6=97=A5 =
2:22:07
> =E6=94=B6=E4=BB=B6=E4=BA=BA: David Hildenbrand (Arm)
> =E6=8A=84=E9=80=81: Xiang Gao; Andrii Nakryiko; Alexei Starovoitov; Danie=
l Borkmann; Andrew Morton; =E5=8D=B0=E9=97=AF; bpf@vger.kernel.org; linux-m=
m@kvack.org; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; =
=E9=AB=98=E7=BF=94; Lorenzo Stoakes (Arm); Steven Rostedt
> =E4=B8=BB=E9=A2=98: [External Mail]Re: [RFC] bpf: account ring buffer bac=
king pages separately from Lost RAM
>
> [=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6] =E6=AD=A4=E9=82=AE=E4=BB=B6=E6=9D=
=A5=E6=BA=90=E4=BA=8E=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E5=A4=96=E9=83=A8=
=EF=BC=8C=E8=AF=B7=E8=B0=A8=E6=85=8E=E5=A4=84=E7=90=86=E3=80=82=E8=8B=A5=E5=
=AF=B9=E9=82=AE=E4=BB=B6=E5=AE=89=E5=85=A8=E6=80=A7=E5=AD=98=E7=96=91=EF=BC=
=8C=E8=AF=B7=E5=B0=86=E9=82=AE=E4=BB=B6=E8=BD=AC=E5=8F=91=E7=BB=99misec@xia=
omi.com=E8=BF=9B=E8=A1=8C=E5=8F=8D=E9=A6=88
>
> On Mon, Aug 17, 2026 at 11:10=E2=80=AFAM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 8/15/26 11:18, Xiang Gao wrote:
> > > Hi,
> >
> > Hi,
> >
> > >
> > > I would like to discuss accounting BPF ring buffer backing pages in
> > > system-wide memory reports.
> > >
> > > BPF ring buffers allocate their data and metadata as order-0 pages di=
rectly
> > > from the buddy allocator, and then map those pages with vmap().
> >
> > I assume there is a reason the slab isn't used, right? Are these pages =
mapped
> > into user space such that page->mapcount would get used?
> >
> > Can you point me at relevant code?
>
> See code in [0]. And yes, these pages are meant to be mapped into user sp=
ace.
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tr=
ee/kernel/bpf/ringbuf.c#n93
>
> >
> > >
> > > Because vmap() maps caller-owned pages, these backing pages are not c=
ounted
> > > by VmallocUsed. They are also not slab pages. As a result, most BPF r=
ing
> > > buffer memory is not represented by an existing named /proc/meminfo c=
ategory
> > > and appears as Lost RAM in Android memory reports.
> > >
> > > We measured this on an Android 6.18 kernel.
> > >
> > > Test case:
> > >
> > >   32 BPF ring buffer maps
> > >   16 MiB data area per map
> > >   512 MiB total data area
> > >
> > > Observed changes:
> > >
> > >   Lost RAM:       approximately +529 MiB
> > >   VmallocUsed:      approximately +2 MiB
> > >   Slab:        approximately unchanged
> > >
> > > After destroying all maps, the values returned close to baseline.
> > >
> > > The question is whether the kernel should expose the unique physical =
backing
> > > pages of live BPF ring buffers through a dedicated global counter and=
 a
> > > /proc/meminfo entry, for example:
> > >
> > >   BpfRingbuf: <value in kB>
> >
> > This looks a bit too specific for my taste. And I think we should try t=
o no
> > inflate these statistics here too much.
> >
>
> +1, way too specific
>
> > >
> > > The proposed counter would include:
> > >
> > >   * ring buffer data pages;
> > >   * metadata pages;
> > >   * consumer and producer position pages.
> > >
> > > It would exclude:
> > >
> > >   * the second virtual mapping of data pages;
> > >   * the pages[] pointer array;
> > >   * map metadata allocations;
> > >   * vmap page tables.
> > >
> > > The goal is to account for the currently unclassified direct backing =
pages.
> > > Slab- and vmalloc-backed auxiliary allocations are already represente=
d by
> > > existing memory categories and should not be counted again.
> > >
> > > A possible implementation is an NR_BPF_RINGBUF vmstat counter maintai=
ned by
> > > the ring buffer allocation and free paths, with the aggregate exposed=
 through
> > > /proc/meminfo.
> > >
> > > Questions:
> > >
> > > 1. Is a dedicated BPF ring buffer counter appropriate?
> >
> > I don't think so.
> >
> > See [1] where we just had the same discussion for tracing buffers. For =
them,
> > Steve [2] had an idea on how to expose them more fine-grained and traci=
ng specific.
> >
> > [1] https://lore.kernel.org/r/20260810094025.136705-1-gaoxiang17@xiaomi=
.com
> > [2] https://lore.kernel.org/r/20260810105710.6ee5e493@gandalf.local.hom=
e
> >
>
> We already report per-BPF ringbuf memory usage either through bpf()
> syscall or map's fdinfo. E.g., with `sudo bpftool map show` you'll
> see"
>
> 1455733: ringbuf  name event_ringbuf  flags 0x0
>         key 0B  value 0B  max_entries 262144  memlock 275776B
>         btf_id 2193434
>         pids tcpeventd(2549812)
>
> where memlock is how much memory is allocated for the ringbuf data area.
>
> > > 2. Should this be represented as an NR_* vmstat counter?
> >
> > I don't think so.
> >
> > > 3. Is /proc/meminfo an acceptable interface for this information?
> >
> > Again, I don't think so. "Lost RAM" really is just "excessive memory al=
located
> > by some other subsystem".
> >
> > I agree that some users might want to figure out what is consuming that=
 much
> > memory, but I don't think growing /proc/meminfo in that way is really w=
hat we want.
> >
> > > 4. Is counting only unique physical backing pages the correct account=
ing unit?
> >
> > I'd assume the "It would exclude" part above should not be accounted th=
ere, if
> > that's what you mean.
> >
> > --
> > Cheers,
> >
> > David
