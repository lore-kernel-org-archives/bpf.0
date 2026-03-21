Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677A2D781E
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134512; cv=pass; b=Ko4ywWtaybZqzxJyo55m81UyPcRgFXGCdjJ8X5lKaEsQbnvqv71XICbXeMHLp1K2WJra2BqEJF+SJ42jTLrPlVCwYGdFrS4R8GLI6vs0tOPnngT9A/13A715p/ONOc12QnhtJV1utKXEPmaGtyxoxvWEY0lRa3DoP7OC0b8ZVJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134512; c=relaxed/simple;
	bh=wY8joydHrVweqs3ydVoiOLXyf6nSrUpvPCnt16XcKGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgaUElwFr3QrMrJXRBLWPW9JNpHSpmU8M7f3lnUV0tugcjnPlQt+JxTDR85afpABbCngj8eEdlwTo87z+FFXTimdopRXasWalxd/n6qRuXk2yRMRqzS9zz7t80LbxpTqbV4S+OWsQYq3pD2AeZvBuxMxxtBGZx8qAH+y5BdN5ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs8WCnv/; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs8WCnv/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b45bb7548so2145465f8f.1
        for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:08:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774134510; cv=none;
        d=google.com; s=arc-20240605;
        b=hjJgBCkNm71xn1i4+Y32q9JopoiS7hWjJ4HabQjoQYuq/7wu1oRjln0JKGjlPlYy2R
         pHR0JeVCFlhqaEhRowj3EOkOItaDfzU/UNf7XnvoABMZBH5yc4Cz9sZoJj0RS2g5vFzZ
         GTDwSnvFVaP9r1EDqwMb/sJ7GyWcpgLO7oCLQVffJQ6odXzoYpD/gfL7Ckq6/cZ5kCEa
         N7I/CJ5JKmjqQZJ2I3DQ1RYXdcOyT4RXiGDO6nK4HFlJ6xplL+JGs1NmRlZn0ydnWprr
         dAUbZzRsLPl3er5uUgjmsdRKcJkLPKQd0LkdkiW0ElL8wJsC92t/hDpF52O6Dopqradu
         fILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        fh=pQh/Lf/SfdI13MIZKIlcxNgajG4r3nTG0uyVOSyLfvI=;
        b=PQ+W9wgC9xFAJRXgReftuIBefGbNpTkDDCzjMnlvm0fc4WRp66aDZ1dNEtf89VBJjx
         O+8yuO6xzEV/MhR0+Bg6pUChM7xQ5d6RH8fzliIRCkczYKnCaNAbtnHkUsUlREVcKBK9
         zfyWQtQ2f1rIyrXbzsJ8A08EeDAql/LySjVjQSsGTnNM+viQWRYg8moksLapfZaoXkDa
         lZ48u8jGSOst4tU3iSD7XflS65p3JugSQYetyFF7f9RLkpEMUaTYe8zC2L5zUke3TrA9
         TRlA/v89ZoCSgNWt2sfzfhyPcW3+BYOa7Mn0lIK3ZI0QD+dSOP9yWrE8W+UNGEHpuzs0
         KKMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774134510; x=1774739310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        b=fs8WCnv/cZEGn7y7tadhdNr1n40WH7rpywbgt7+6W0eqUzENemMO6YpSu6cteoK4of
         n5CeLXOkYYSqWzwrkG99FK7W5MafyECNO6sfzxQbwgBnWc6OgESqLRRnpFqJUZ/ZclM+
         V7ITBtyesbhxycnR1jPSluRnqBQB96O1A0vJLhqh1+MZCiZX80sf7tigVhNNKGTYrJ+p
         hPB407rqPKqtwQHxneU5tiYVWd89/Vju5k/I/gRU/FrjxEUDhTBH18FQgclSuvtn5YJQ
         V4hJGDOqvZn6+ayQWNqj9zLKQWNq7SjenPdOl22byOuuuw9yBne79APfUZwVRQ6hjYlw
         Qpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134510; x=1774739310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTzWZEx2kpq/j4/EmeTJxrRzdEyN9FStqQMJ6aPQhfk=;
        b=Gy5QzCcOwAfCd2/V288qmjNT/k8mTMowQ9SEWqEBoCORSxQec068C4swcYrb1Oat6v
         suKRGkI3KYbqhIAbaj4/BcncWlDxANZo1M3vc9yD68artSH//T7pUS3W9zFe1DmXgCWq
         dDxQSZ7hWJGwkdUJKzfhi3Iz/aw6NMUn8GUSSVZy/IwFggX2F+g67yBvY0JobJ6ASP9O
         f8WxH9reGIjZLX3dr4a0WYNqfj01xgIpYpGdIGW/JGx32JwZl4RUaT2oRqYUwpzIyPpe
         8v8tnE7rpYloaJCiIsfp1lIjc1yLMYeX3uzLNGZl/VbAYK4/yVgkzXY/FOX4F5v3aIrc
         Ftxg==
X-Forwarded-Encrypted: i=1; AJvYcCXd8KACU4lLaqE7HgMez2wCHKqMcaq238F9Tppf2otg6I3PZh+lVzAyyAUFjULhNhfi0qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCL/sHwiJSGCk80NDVtVwX4m/3U1VvQaf0J3skzA15GCpjTudr
	R9rcxiiLvWbeVKbtXW2ra9FSN3K003ZRKVdHKkAQojQv83lMNNR/pjK2tVb571yq1dflmUB0EzG
	8zOCc7Ergli0/95n1379Qsnex4QjIzws=
X-Gm-Gg: ATEYQzzhBqKn2YuHjVxhbK+0ELSpcFVLBIO3MGUIuE9WbK8yM8UL/jGTcj0HpTJEZac
	Ar5RW/lBEHi/6NlccRb8J6WjtQDiW724tiQCYO4KL6fIFQh5j12S4j9PgSABd0sJpCRozHB2pPw
	TAkxQRGlCvFJI6UEBCGDEuvIN6xTPRLi3K+75968+0Wb8gdYPYCtu+s5/GCwVoF4bcwN92nNKgV
	uHxHpX12RVz10ff2QuIpDjvs3VTG5YPi4a1RrXYKFU9+dypj88R6NkUzyoA4hgGCJQY0jTNfCuP
	bbo/p3xnlrgS/psHERW51wkb36oypARiLoyfinXNOMuHahgfrkfWsJn3ls4PnWnSI1c5hzOQPh9
	Pun6w3FSKdS+yJc9piFN/NPlvMGW/Y0WeIIs9
X-Received: by 2002:a5d:5f86:0:b0:43b:4921:8743 with SMTP id
 ffacd0b85a97d-43b6428168dmr11888566f8f.42.1774134509454; Sat, 21 Mar 2026
 16:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321024446.692008-1-irogers@google.com> <20d77c80-6538-4dec-804c-156402c26534@linux.dev>
 <CAP01T76kB8BHSQXp_1+tScrHhQayVm+BhAiDqnq4NeNOS_cMQg@mail.gmail.com>
 <CAADnVQLKv6LOQw5=8_ZagRXdU7dRPYA+fxJsXiGncqJjZ2hK1w@mail.gmail.com> <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXhuLE5R_t1A=+WLve3Wu9N999gXcG0KjEFGVBBh4+1=Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 21 Mar 2026 16:08:18 -0700
X-Gm-Features: AaiRm50YejLEeFdLghBznogBMbsouYJT2jK4XNYtxycz3X_8HKLbkyv9F9l35dk
Message-ID: <CAADnVQJNt0Xmcm0L7u87fX3xFeVGyLnTxUGjPsnYcNSX4Zv5rQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] libbpf: Fix strict aliasing violations in hashmap
To: Ian Rogers <irogers@google.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 4:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Sat, Mar 21, 2026 at 12:49=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Mar 21, 2026 at 10:37=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, 21 Mar 2026 at 16:42, Yonghong Song <yonghong.song@linux.dev>=
 wrote:
> > > >
> > > >
> > > >
> > > > On 3/20/26 7:44 PM, Ian Rogers wrote:
> > > > > The hashmap implementation contained strict aliasing violations.
> > > > > Specifically, the hashmap_cast_ptr(p) macro was casting pointers =
(such
> > > > > as void **) to long *, and these were subsequently dereferenced i=
n
> > > > > functions like hashmap_insert(), hashmap_find(), and hashmap_dele=
te().
> > > > >
> > > > > C's strict aliasing rules (C11 6.5/7) prohibit accessing an objec=
t
> > > > > through an lvalue of an incompatible type. Dereferencing a long *=
 to
> > > > > write to a void * object is a violation, even if they share the s=
ame
> > > > > size, as they are not compatible types. This can lead to undefine=
d
> > > > > behavior, especially with aggressive compiler optimizations.
> > > >
> > > > Potentially this could be a concern. Did you actually find an issue
> > > > with it?
> > > >
> > > > The linux kernel build has
> > > >     KBUILD_CFLAGS +=3D -fno-strict-aliasing
> > > >
> > > > The libbpf does not have this flag. Maybe we should add '-fno-stric=
t-aliasing'
> > > > for libbpf as well? This way, we can avoid any future potential
> > > > 'strict aliasing' issues.
> > > >
> > > > Note that bpf program (tools/testing/selftests/bpf/Makefile)
> > > > also has '-fno-strict-alaising' flag.
> > > >
> > >
> > > The change itself looks correct to me, fwiw, but as Yonghong said, we
> > > can add -fno-strict-aliasing to CFLAGS and move on. I also doubt the
> > > compiler can cause issues here, since the usage happens in hashmap.c
> > > which wouldn't be visible in other CUs where the call is made and
> > > pointers are passed in (unless compilers also do aliasing-based opts
> > > during LTO). I guess libbpf maintainers can decide what they prefer.
> >
> > Agree. I don't think compilers can misoptimize things here.
> > It's safe to ignore this.
>
> There's LTO support in the Linux tree for tools/perf with the LTO=3D1
> option [1]. My experience is that it works best with clang and ldd.
> libbpf is statically built into perf by default.
>
> A sashiko review raised the issue when perf was reverting the addition
> of -fno-strict-aliasing, the sashiko review is posted to LKML here:
> https://lore.kernel.org/lkml/CAP-5=3DfVro6E6fowmmJ7gmKX-5SN8bFU7-5KJk_wFG=
-bQuVnMHw@mail.gmail.com/
>
> -fno-strict-aliasing was added because some crypto code (copied from
> the kernel) requires it for get/put_unaligned. The fix was to use
> memcpy in the unaligned functions, which they now do [2].
>
> I'd prefer not to hamstring the compiler with -fno-strict-aliasing, we
> have sanitizers that can capture aliasing issues.

We're not going to hack libbpf source or add -fno-strict-aliasing
to Makefile because gemini found a "bug".
