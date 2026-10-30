Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793329875;
	b=2Zbz270PNFTZefib1XAgsqdiiENGuSUmgPHyzF/paBGgZR8lzpueNX0EyInXL5Wrx38m
	 uPz2Cm8PEqXvZEBuGn5jiF5jOCOGCy0UJBxAkzkfvIOgw8Qx0hmaovm6EHu/c5OYW6US+
	 bP/NjtpDAmOPD8a2Rgx5jRZR0whMYP5sxYIKEbzbOD4YQPv7h7DvHO0qWanFUwZbBU9HN
	 yk2jhm6HM3tTqPvZxfpFF15qo669Yu12TO5jEennWDMqWw7NCrXAt4jOb8W+TTInAJCUZ
	 5WduVizj+GMV5GhhgzN7IB2OGqhkE/G67TIel+PlBvlOV4z2WXW7yY3guYl7PUMNh5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
	b=doJoq3UZTfLXQ1aJp2npSZZnp88J41S5u0UWfzdUIE/HIYrTkHHTty2dv4ViX0HUkq0t
	 hNL7MNFhMZAbIgqaQZgYqlE8JcV0NYleyCuTGuQA6YAVz60rBA0+Lf/QkL8CYqoAmggJI
	 /SWz5mDvUF4+1P2SJ0TE1v6vhRo753kZJhX0TIlPEQmty85Wwr9nkR3IQB2Xnp8uFx1tJ
	 sFsOYOgev2rioGkFB+wIArm1NRHYkDLcJtPKn1cpe4wIoVSRGPUmabSOU7gWGJPdfnwHz
	 4/s7PZSuk8Nr1mRprq5FPWGlsnWIkTFuIRhuzCZfDlVgniJ1ChXVdAr4oTTnN9U4rYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kh2HrdRU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11F8606A320
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 03:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B11F8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kh2HrdRU
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337c7b9937so164001cf.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 20:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793329873; cv=none;
        d=google.com; s=arc-20260327;
        b=HPTNFoXtMaqApCScfIgOGVgSBYrlDPKu3ms3PBvCJkPHlWtsbOgXHeZnKT75g4IJva
         Yg6Uvs/qCTKdraoE5GJw1jv9FSlLne/ZWdN8AH2yThLnh+qPtjVt+MH4MJZ9kS5UJpZE
         QNFYkow+f62baUUFBK59iMHvaAMo701kQZlR52gZVoqLOSwMXeWI/NkHF7XoEFu8lEIX
         0uw0qPFZv8hbfVc/ieBFEDfNC4BtPHPmtRZnTjatG97f1gX8BKuqyLCush1WJdfxrtGZ
         g39KGXUyYbQdhIMUglp7ZlZ+loDy5p4VpkRhujHY0fMsHWRYtBcYNEEY4leQRPxt7YK/
         zeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        fh=UkC2+vTl0RbkugVIE6v23tPtnWskZmP7pRzNXzd+/wI=;
        b=If4W4sj7ISEHt5ObOvZAugdu7LwW/bGdfufmcc75f3pyYf1pW5W48NbuiO1oZQ3fdT
         oyUBJUOqtHa8A4T/XcgEzJ/h1Vas0KAEphxnf+2gYm+tL1LFCv/IbUCbOQvKDiXuApcR
         J6Q2BXvw3fG56RtyC39eyCF4kyREiFachageN5mIjyOXrf+QIvCsvHvGVnv7HYuxU5YG
         8PX9RZ+5BJn9zWZQ/Klcpvw6/ul59VfAJxNLocqQEe7xTK/YA6Sugjj0LrIWHVzdIHAo
         bhEimArLoQujyC3yRvlTN3HUkNRFfuwR/nnjBZi2rkehZ/CfYNr2IspA1OIhE84L4+J5
         uuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793329873; x=1793934673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        b=kh2HrdRUmrMNIG/6fwizpyRV2s3ZGcRq8l+qhBw8D3lvG8emEl6JjqraKmxtxX2X2O
         ZVgvajWvOtpUnbYl7ZWbzrX3gx+Nz56XLrBfUp/MmTdYPJ3VGsBg83OgypsE+VVnTee0
         B1zec4y+h6QhIc4Iu4oy6WYjms9OJRLgyK3xNdLlO7bckZRnUc/bDAtF8JBpXU0XMUOn
         1I8oAMJqjNaCzflStpKVCF0Bp9tH4SII9WfY81WZQT/FvfENzypAo+IMJO27Nyr6kjlf
         vYvY0iyeiRpFjkQcCmE8mKfeZW5WkPkXWbwrjjVJ2hhNOQ+832Moo79dOhNjQ7s/j5df
         umBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329873; x=1793934673;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoVHC65GR8n9FjINMXnaahKi7WXhnhvguTlzPVQW3pA=;
        b=y7eJk95i0S+my3xx+KUiyO4QNoAgKqKhuAXIiHdru5yhxxO9u/jAvXLnNJAEJlViN7
         rhCl9CHq7SmF7HPj2+zq2bQpA5aGWq7MFeOCP0JfX8YI1dIaBBNBD+tpMl0S2JrMg0Nh
         BmgT5K0GXcO7JxjVuNiY5BoXrszA211GoPu1eIHS0+aVafOSKx8tqNbtPVRvZSVfYhsz
         OZ31nhN+PDCbIbYxOv1UOrZooZ3z2EUhneuadFX3/nT059lzYWKS30iVarzfCljHqP0M
         rCZwB4iioeiskY57n8lXDDp7Z9jXcVVJCyi6GQfiwNqmTvBsUiUYxW+MWojSK6U7D880
         /9lA==
X-Forwarded-Encrypted: i=1; AKwUvBz8wnn4HaJIUGqmObXjvhgQRNsfKpaK/BWURzSjcCxDvQJm9q0kxF+kenY3Upv6ZNv2Sgg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQEBZxvolfQ4zJrHEiYmL3f6oPp1SPtzIu/hsRF0nBSPjCWgmw
	JriqL/SFES2udwu32DE4m19wi7AsdG5JhRo7kCKYDdcf2CdE8WLDeAWfwSpMZ7fD6RX+j8Biu0J
	MqywL7EBw7JdmXDENb1MdZvK+1e0lW7ZZ2O3pGpBy
X-Gm-Gg: AYBFou37g5reKnjudUTTBmPk4weU4mlaIJgw4vGQArnx+n1ah8OrOchn796PSxEE2xz
	ErMbWM94GrwPSwRAe79m3ntc6fyRnsF0Y6ay9sPynZAj74AXg2fT18GHx9nwwj9xiyhfEUG21nk
	XDCrB7sFNb3KF3IKwnEvmDpHK5YWJCz8628OQi21xBEdClXFk4Z1zbGsZZ1kKLw4/fNKwmsCIvz
	qaZj/GUekR5rPY1+vZvn4BJs+h0QsnMKcqTlFuBlCpicB/dEhD7LfLuoLVQ1eKh4SlQToquH8Rc
	q3WtVB7z/qXV7ArzYezZW4akKuf2EHJZTSM0tnlrDjvzud8S2aOYMReB/tgapKLjpMHnH1nKAne
	w+S1em1P8NIAwmoa5cSaxjew1Y3R6PABsKtEqyg==
X-Received: by 2002:a05:622a:1b0e:b0:536:6d88:600a with SMTP id
 d75a77b69052e-5414de1cf2dmr34323151cf.9.1793329872551; Thu, 29 Oct 2026
 20:11:12 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029162958.3224280-1-irogers@google.com> <20261029162958.3224280-4-irogers@google.com>
 <d1267d81-0ed8-4b3f-a535-88ddba51af88@kernel.org>
In-Reply-To: <d1267d81-0ed8-4b3f-a535-88ddba51af88@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Oct 2026 20:11:01 -0700
X-Gm-Features: AclHuK9rCNoYtTV6H1GziiI59-c1QFU3f9f-3J74Fr_QKbxS-WGNb4D7UrtMMqU
Message-ID: <CAP-5=fWaLj-ToYvAowp-_dk5tL-_Ju+i=U90GRK_obFNqn5axg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] bpftool: Prefer zlib-rs over zlib when available
To: Quentin Monnet <qmo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:15=E2=80=AFPM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2026-10-29 09:29 UTC-0700 ~ Ian Rogers <irogers@google.com>
> > Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> > tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> > ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected, falling back to -lz=
.
>
>
> Hi Ian, bpftool doesn't make an intensive use of zlib (mostly, it's a
> requirement from other dependencies; we may also use it to unzip the
> kernel config on the host if necessary for probing BPF features on the
> system, but only on some distributions). So I'm struggling to understand
> the motivation for your proposal, what do we gain by switching to
> zlib-rs when available? I understand this implementation is in Rust, but
> I'm not sure the added complexity and feature probing in the build
> system is worth it.

Hi Quentin,

At my workplace, we are transitioning from zlib to zlib-rs for both
security and performance reasons. I'd like to keep upstream tools
aligned but they don't have to be, it just seems nice. I agree zlib is
of a lower priority to users than, say, zstd. For attackers, like with
brotli, it is probably an area of interest. Knowing the implementation
is memory safe is at least something in favor of zlib-rs. I sent this
series out as an RFC because I obviously have no way to mandate what
upstream should or shouldn't be doing. There are things that can make
life a little nicer and easier, and this patch series, for me, is one
of them.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/bpf/bpftool/.gitignore |  1 +
> >  tools/bpf/bpftool/Makefile   | 56 ++++++++++++++++++++++++++++++++----
> >  2 files changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignor=
e
> > index a736f64dc5dc..ea2222373634 100644
> > --- a/tools/bpf/bpftool/.gitignore
> > +++ b/tools/bpf/bpftool/.gitignore
> > @@ -6,5 +6,6 @@ bpftool*.8
> >  FEATURE-DUMP.bpftool
> >  feature
> >  libbpf
> > +libz_rs
> >  /*.skel.h
> >  /vmlinux.h
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index b0f7168e7943..a193cf89a034 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >  include ../../scripts/Makefile.include
> > +include ../../scripts/Makefile.arch
>
>
> Looking at the GitHub mirror repository for bpftool, I'd avoid including
> this additional Makefile if I could.

Ack. I also acknowledge that the CI failed because the patches were
against perf-tools-next.

Thanks,
Ian

> Thanks,
> Quentin
