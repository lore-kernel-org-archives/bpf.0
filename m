Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793930452;
	b=fi+1a0+cIdMI+4XFfAbQz0u/Gx29xE/EvmD8vqlWdiqmf5bJM6H/pVrjgW9F+4C4JKT8
	 BPqcQEWQfVa4BrqcWQ2na+ScOCJHh2x6tSRtXrcAl1mqpVVp1QURPtOn07GODYkPjdF3R
	 LpzEL3ur6cotl8dv0wdPidW6eGpfpHT6GvUbcY2E2sz3AtHVQSAe6RrWPcJIzmUUqr1mR
	 6v/IvSDD0G5lsg2WSa2+kLFuTliOnJGTb0eRjlNI/hbSRMzSxx17n8HPkjOobTLJch4z5
	 T6/UG5GIxfjKlougiPX7zFj68ZsK/X0iJCly4E38GTGu/c1trXV2m60AMg/XU+qfW9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
	b=Aj3yCJusSoKAnpo5xrA/MAg1vw2HLbD9zunTUx51YmgZfB454F7zLKEDDh8CMoBKHu4L
	 0qPJ797+OHlgRh40wfj6I+fPxbjd3QrkcZiCTNieFb1UL6ZSLPqqzBplptJ82MXliGGN8
	 iTnka3wVDOi90YzQeKCWlSXesOQWIF8CeMLwhztTJA+wmBW8+mNaBe00cFBtEvpLpkU10
	 fLPPLlcTTkxB4nO7hdDefmcra0AozwxwpJgFL5Z7gCMwmcQug7vNXjGKGuEcMW0ZqUF13
	 J2zr0UFgZwf+to7L/QHFE7rG0qmru8Q6u3puvXvCYnIDTJs67NT25Pqnpjoh0dl9apQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0sfVB8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435A606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 02:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6435A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n0sfVB8H
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c34bff61551so20454766b.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 18:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793930451; cv=none;
        d=google.com; s=arc-20260327;
        b=WFN6dryqP7QzUD5qupkWEb4aUDUnhPPxOHQr1du78BCyFLKcrjlSGtzXbVJzXDcNm4
         Rsg6OSBj92VAxK6Tn4Pj6nu8e6cPBr7GyngQ9lOuyxb5rIKdniY7ZR668Kx1YzswAbst
         y0rTkJ0AwGc0Xse+tJohgwJN0OPNA4d4Q7Fb6FqE3cTBhvSirAkNC0VSwk3Y5g4+0IB1
         P8LyOgi98TxpFoJQr01GFwADXFq/1fqJ2/rfD7ZyaJn2/r7sEwo43H/i4GrGBk9EpiC0
         BQj5MgT/unpy+bsn0rpup2BnfOCczGB3h6sPPUbeAj2OR3oF18Riy8joZ/sB1phsJBgI
         VHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        fh=+kHwpsPf+CX7iyDw3TGV+REqHDlWxEun9NZu0SxBkJo=;
        b=BUWUfVobDmjoL6ZoDeALsdU0e+RmqF6zckNRV2TMXYaW6rFrGacwp1PXPCyvwah3Ts
         IixAfmjKPmZ0C8JrKUGluQ1SF9W5hYCOj+qqkJCHEAyDerc5LaYyUu8sHA4ndlliiOrb
         aXr+biz49r/Yi58oWyqW3YflbODcGaKjhU9C1CjqfW6gfmA8lwfFBAPCMzSN5vxXztIj
         b+EZTI0D3AMJ4EU1VYJEuvHEJI/Ut17qyj4SQWD//wtcjyf3zP0Bvmfp26YdHAcitauZ
         L6GjHqYF6CDShmiyPRHgVA8EVFqYI3LhtARousIh6kkBS5HJAz2Wb3G71uyt2xCyVqeA
         jIPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793930451; x=1794535251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        b=n0sfVB8HDMUIuXTocfcJVzoho8pZXk6bz0tzYjFzYmhSx1pFhTaSZo2yumVp+d748k
         EF4jR91ea7ibNEGxROUSMHM011PgzTAI8L1qWD0ISoyr1JcQCXHPqNvsMWVFxbt9wB8L
         pVWLUNSqw5HdxDBqekaiiz5oT5qSjOrJE5ODDKZ/VB3w6uZmeyx/0kQYDZapcUrltRdZ
         8fR0loS/DvGXRU6jX9KX9o6p1Ldw8G7WKpqq2NCoD45ROybfLxtqHAL0Tx2xU7De+KLh
         gi5zSg4xLzZZYLvuMhcffDFLNETBzEZCobr2lGt0WTB8BXHid6mc2feh+qdplGHJNBHS
         He+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793930451; x=1794535251;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s7c/qg88c8erx5Dvpd9/JaL1ilkeZNtkbNUxPsE3zPs=;
        b=HJSfRfjK43wIJlm6TbBalAYCxRMc89+Fnc+QdS+v9O705VpEpJqFfjRFK6EdmKgZv+
         aaJPOCZ26imq45TlKM8GI1IcUFt4rhnWuHfe1EWWdfZvyqjKdbXtVsPi1JCP30MYAGgJ
         O1w/4cqVj8xDSyBRP76AXx/NinuamoZV1bAUJX4bJI0Vdn8rFp+YuxihSo0tLMv3K4v+
         OXEgYyRhhsKIeQKBaySQD7JVdQ87kGyTB0eSu5MpwK1Wrq3MzhGiXU4S03rJ6UbmBk/k
         B/1b+MX8Ihy/ciaXPP06OyWrbvdWlPToOUDhUBho2G5vFOpRYKXjqw9bMRzasuri6Rzf
         +nEA==
X-Forwarded-Encrypted: i=1; AKwUvBzh4JmKn+PHQ80VLpxSdTwhV35wUXeuNIygeMFgjzZGTNURzwbrqZ2BhApLo5qd38b2ye0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+VLI/s51KYVCkwLlLmb0YSltOvM0MpNOhDj3BZCfaFr9QTTUuH
	xfi6Q9vixY2GGqqqQ2uVR9RIgiIGdCbiRszNDU2bZ8BuOtwljLhPMd9ezc2Z3LabH73gjfmqQc+
	K+uDuUKD2bJLYiNTEe+MD8ItlNx/KJ8WYAubuUJxo
X-Gm-Gg: AYBFou00FBHyjOblhIAtMhHaq/N7fflglxPz2Vgd/EFGoFNnZvOMyWKz2GBtsiOM+b2
	dYk48Q43KifkALU+2dyQOlc1oEMN0lTb2ffhhQ+AcyNHMNmoUziilDeLCpUBf0vG39eXndNDuNd
	4Gznbu4tkLqF2stW794n3H8zKEpL17GiFv0speu39CF1/+kit4EsHtDQqBqdxSaVsgbP/H8K9/U
	KC/B3q6AXNgoiwARgfz3trs4DO8Yp/w7sPgfQ96CCCSzToXMXmeMMxQGvGVEdFrch5/Esk3/7M4
	f7+fWtTo2M/qk02AyXpVF5FiYW9ZzLKJoEqlFJp7Sz7iZPEJjuiw4ZBHf5kJCXnLej6wISGU4nw
	037IK4vdFCrJkAE/OI0f3Tkgw1CZXr6O38C9hH2CctsmMQLZmzSa6r+WA7wVij0EjrAWIOB8=
X-Received: by 2002:a17:906:ef04:b0:c24:6985:d7a1 with SMTP id
 a640c23a62f3a-c4d3468f9f2mr101330766b.7.1793930450357; Thu, 05 Nov 2026
 18:00:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <20261030100215.6f8e0d4f@pumpkin> <CAG2KctqdPq6NmK6rB13s2bgM7kP2w4OMMy2hdp_OFMVYYhTnZA@mail.gmail.com>
 <20261104142307.431fc12f@pumpkin> <CAG2KctrY6GmVqsKP+fXYCsL6wDR4zp1kdRd7a7uOdCgg_JcMdQ@mail.gmail.com>
 <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
In-Reply-To: <CAEf4BzbYqbPRPWQU9yM29E+Pr68y+KX0O8whK-36dyH=Zd_udg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 5 Nov 2026 18:00:37 -0800
X-Gm-Features: AclHuK_AXTODf6fbRoRayz3qqp4e-qEs_ls_rSieFkkllrojC2ZFyUBK4KHwxAM
Message-ID: <CAG2KctpBEtBxwb6Tayg8z5na39TVe9GQ1+Bk5ts6eL7VaKjKnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Nov 4, 2026 at 4:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> wr=
ote:
> >
> > On Wed, Nov 4, 2026 at 6:23=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 3 Nov 2026 17:14:26 -0800
> > > Samuel Wu <wusamuel@google.com> wrote:
> > >
> > > > On Fri, Oct 30, 2026 at 3:02=E2=80=AFAM David Laight
> > > > <david.laight.linux@gmail.com> wrote:
> > > > >
> > > > > On Thu, 29 Oct 2026 15:05:45 -0700
> > > > > Samuel Wu <wusamuel@google.com> wrote:
> > > > [...]
> > > > > > BY_NAME matches names exactly, like kallsyms_lookup_name(), so =
they
> > > > > > would be different symbols at different addresses. Please corre=
ct me
> > > > > > if I'm missing something here!
> > > > >
> > > > > Only that the user might really want one of the copies.
> > > > > Sometimes there is only the copy.
> > > >
> > > > Good point. I'll have v3 add KALLSYMS_F_PREFIX + pos/next_pos
> > > > pagination to cover these. A prefix query for "foo." also finds the
> > > > copies when plain foo does not exist (expanded on this in my reply =
to
> > > > Andrii's Oct 30 mail in this thread).
> > >
> > > I'm busy rebasing my patches - they got stamped all over :-(
> > > I should get a v3 that applies by the end of the week.
> > >
> > > I will add a 'prefix' variant for you.
> > > The 'next symbol matches' flag is exactly that (actually it is a
> > > this symbol is a duplicate to avoid issues at the start of the array)=
.
> > > So in this case that application would always need to read
> > > the next symbol (by name).
> >
> > Thanks, that would be helpful. For my v3, I'll keep the lower_bound()
> > approach so the two series stay independent, but I can switch over
> > once your series lands, so there is only one search over the name
> > table.
> >
> > > I think it might be more sensible (less pitfalls later on) to return
> > > the symbol number - not that of the next one.
> >
> > What pitfalls were you anticipating? If the current symbol's position
> > is returned, userspace needs another ioctl() call and an -ENOENT
> > check, to learn that there are no more matches. Alternatively,
> > returning the next position means every call pays for a look-ahead,
> > which for an unfiltered query walks the module symbols even when
> > userspace only wants the first match.
> >
> > Andrii, do you have a preference between the two?
>
> no perfect solution, but given you don't always care about duplicates,
> I'd probably return the found symbol's position, which can be used for
> further pagination (if necessary, user just does +1). so, let's return
> current symbol index, and have way to say "find by name/prefix 'blah'
> starting from position X", where X will be previous symbol index + 1?

Ack, seems reasonable to me. Thanks Andrii
