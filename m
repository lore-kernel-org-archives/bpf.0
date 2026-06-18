Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505093EB104
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779534; cv=pass; b=rBW9cavBw2YlAXWlf6p+EYTn7JcSrwPHE3HbMkulldtxWOi2vgze4vyYIlOfzKaO203uAesgWyMjdCLWoYDZSE0WePGs1W70RtIHdVdwsLd8Q3tjXn7Ey+rzB0YQ0Q3eb/Xj8EWCciYZjtQdIzr/jRNpcLaxEtIKYuPUs2jBnvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779534; c=relaxed/simple;
	bh=yeE5VZid+PR+8xO9WKfTDka5xDLbl39UJCqmBBiuLSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rna5lombEqCuWtkbhxgBzOMYzumrbCf/O/bpGanCZPjcu1Qer+OaZvPpbO3CHGtrgSElxM/D+QoAJ9DAOPbYrEvfJXNH9l0Us02JIY2Jy3WaK+LeeGv2N7mYuoWst+9+r1VovNn58u23GMKVil5J73sQVbAwvIzVlRwZc2TzJFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYvfibE6; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYvfibE6"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7ff0584c6b5so11295927b3.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779531; cv=none;
        d=google.com; s=arc-20240605;
        b=Oa2Jzz5KWfWCFlHuIcTr/0tAmSOT0+2jKgXa2bqrH9niQnvaeyaDqAR4UGgePe2DFz
         //XxGcjV+ie/IMo9/FOhFKXh39XZSRP6ykbQUse5DOhhCexUD8Jbjw/ubnsA93f43Eya
         O0f9tKc6YuPTU0YIodL8tbv9Fry8ycn8D6TlGdMz3LE4tK3GnjE+TUUTmJviduS1sPT4
         ikSlZDmgHsggDnv4FPPLw8u+49fjh2X/uNk60ts6mSIWhFBQPtEB6+gRlfMNyoWCEVa/
         l1tV5reYkXmOxrWjdRbJaCv0a1ZDtrFrzMOaXBlBf9+TGg32JKoeD6/T1nNgQ9icj3z9
         4s7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        fh=0mNPAfas24QXcKhyH8u22pys6ZJB8saVY9rgj2/LL1o=;
        b=A4KIHGtnbkpnbxZ/y7IV06tVXJ2DfW8WCOm17/rkDYQ/54HeTaXb3Kh7moP36fUmBa
         7bTWRb95cJM+4gHD/katPvHEnZVPfvURYYnzbjbhB6Zr7Pw+G92abK3P1raDLdJCRswD
         TpLtUCSY5GJu3xudjNeyZVLzNEvON4+YuMwNZ7ZFDxCXI44Z6QGhGJPgcIHQ068JsC6u
         JtxJKTaNAaGBzeGbhQU5V4H5s4B40/Z8qBA2lliQZuZ0hPtol0++mjQW3YE0oYqTtqov
         KC7wWPbCDo0oR/OlGpEWjY9ssKb8UEAB60OACDrZ/zZbRychToWJKE2JOqpU7slBOjel
         mohQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779531; x=1782384331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        b=DYvfibE6iT3k3xxwapGSwjFKAh2mfqmxG+heGaSqRjX6FMW2Pb+vbJcb4+9ALQM0Fo
         vC1n7S2rJmq1Pji9je9fpoWUzDuukmz5jcNv1Z/200bju5dOj0B3EwBt7XED9LHRiVw9
         YB49oRBwK20jUDd2ofifnf3lKvhDaOxJbT174SMFCyHOBGHgx/w+T3o9TUB4GtjJl10b
         fsTYS3iKXbadciPl+Ee6626u75GmGKdTfLPJEY4duXt+TPB0PCifGc+TeQfExSjAk4Ve
         +tunLmy2LXDglMLwv6OU/DzqPuzJIz9UHPFsZ/ehfJyiaLL+ZTmhOrDX1vf10rHq9yW/
         XMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779531; x=1782384331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAX/QMZ2lNnCR4HEVf+9VfFWBfEVxUbspDlYV1+1z1k=;
        b=j1YQe0oXhP4tXiV33s6wjo+tTsCag7f5mPE7mb3eP+h2LYv5JQT/3GySoDk/e1M6mZ
         l1sVgek6h1Pnz729Wv6Xsc4LKFQuvqHIIVBMSEgFl1WNR1Iy6ZAlxuIOIH+3i2iZ0Izl
         bCwMO0tihyxLewT70lbP2/ypy7g1NMr0egLDhv4Nhdn6fnmZW9JGfBALIDMx4hMwziuv
         80IEC4WDvCeDAWznrRh7QSWMnRysK5rJyjS9G32Hhzj+3gdD33BLv9IkSrBvTtzGLMst
         TiH1EaKmOlSjdjWHmJOU0mnzMQlUnhoRZmUkG3madIe+xvaaYcNjbyArH57N+/jruxhh
         LiUA==
X-Forwarded-Encrypted: i=1; AFNElJ/n5Hh4MROPfu2C7iyKi90bTpD1bteXh6Es0asnX5FtszhD9jLwzxMmX+EgXcgB81A4Ch4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRO78tAGk4sSU27vJbsEmy2kpk8KivgW3wuc3ZKjBun0Idr1u
	nYdgxbFHGspj/H96rXVR8S1BVy3omsGH88S0tiGb+7FHu6GgCCVjeCRNWw+5lYb1tniDGXKk+Kj
	hOJ3jeEe4rbZWIKIRoQU1DlzcdwiJJ6E=
X-Gm-Gg: AfdE7cllzxKl44TcRt3CdzGYg2h4LrjZ/XiUzpHNrtQLuHmNk4joW6k+y7ylp6+7Y7D
	D1KxcPkmqR6V2HS9oD0CvO1ZOj1cyKFLhj4MytktCMvEBkrMwRlY4beG2enh+Qebp3tbXgcc33T
	2IyaQLP3H+snvsWaqvEMhLzXrq8h1H9265ILBLtvnjh+DJ/PUQ5hP0AHpVO0sU2YLLjTfhFnvhU
	EyG1hHyRYV44Cy/0H7AxA7D2NESjVcni0LvyVy0mfnsnU7o2wLu7VtyvDJ3q0OBvaeW+Ad4ZUGa
	rzP+2t9rGZwYI42s0g1vJOTI84ysO09VvOcbFYfc
X-Received: by 2002:a05:690c:b91:b0:7f8:7e6f:f543 with SMTP id
 00721157ae682-7ffc86c9549mr29850657b3.49.1781779531112; Thu, 18 Jun 2026
 03:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
 <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
 <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com> <ajOv_oOd1zInaW1b@mail.gmail.com>
In-Reply-To: <ajOv_oOd1zInaW1b@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 18 Jun 2026 18:45:18 +0800
X-Gm-Features: AVVi8Ceo2RL3_RfBhTUKCmC5sJSFyC9LIcZeW8zb5WpwBtQh_A6J58Lq3pCapyk
Message-ID: <CABFUUZHCr=4kb7kSaaPGpc4nkyn32i-svD9v7ONF+TYrrQ-xaQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 4:44=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> On Wed, Jun 17, 2026 at 10:19:52PM +0800, sun jian wrote:
> > On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c=
 b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > index 01f1d1b6715a..9cc898e6a9f7 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > > > @@ -4,6 +4,10 @@
> > > >
> > > >  #include "test_pkt_access.skel.h"
> > > >
> > > > +#define NONLINEAR_PKT_LEN 9000
> > > > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > > > +#define SHORT_OUT_LEN 100
> > > > +
> > >
> > > [ ... ]
> > >
> > > > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run=
_cnt)
> > > >             "incorrect number of repetitions, want %llu have %llu\n=
", run_cnt, info.run_cnt);
> > > >  }
> > > >
> > > > +static void init_pkt(__u8 *pkt, size_t len)
> > > > +{
> > > > +     size_t i;
> > > > +
> > > > +     for (i =3D 0; i < len; i++)
> > > > +             pkt[i] =3D i & 0xff;
> > > > +}
> > >
> > > A question was raised on v2 about whether pkt_v4 could be reused by
> > > reducing the linear area to ETH_HLEN, rather than introducing a custo=
m
> > > init_pkt() with a 9000-byte stack packet.
> > >
> > > Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> > > The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so thi=
s
> > > doesn't seem to have been picked up.
> > >
> > > > +
> > > > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_ac=
cess *skel)
> > > > +{
> > > > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > > > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > > > +     __u8 out[SHORT_OUT_LEN];
> > > > +     struct __sk_buff skb =3D {};
> > > > +     int prog_fd, err;
> > > > +
> > > > +     init_pkt(pkt, sizeof(pkt));
> > > > +
> > > > +     skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > > > +
> > > > +     topts.data_in =3D pkt;
> > > > +     topts.data_size_in =3D sizeof(pkt);
> > > > +     topts.data_out =3D out;
> > > > +     topts.data_size_out =3D sizeof(out);
> > > > +     topts.ctx_in =3D &skb;
> > > > +     topts.ctx_size_in =3D sizeof(skb);
> > > > +
> > > > +     prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
> > >
> > > [ ... ]
> > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/=
tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > index bce7173152c6..cd284401eebd 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > > > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> > > >
> > > >       return TC_ACT_UNSPEC;
> > > >  }
> > > > +
> > > > +SEC("tc")
> > > > +int tc_pass_prog(struct __sk_buff *skb)
> > > > +{
> > > > +     return TC_ACT_OK;
> > > > +}
> > > > +
> > > > +SEC("xdp.frags")
> > > > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > > > +{
> > > > +     return XDP_PASS;
> > > > +}
> > >
> > > A related suggestion on v2 was that, once pkt_v4 is reused, the exist=
ing
> > > BPF program could be reused instead of adding new pass-through progra=
ms.
> > >
> > > Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of th=
e
> > > existing program? The v3 still adds both of these, so this point also
> > > seems to be open.
> > >
> > >
> > > ---
> > > AI reviewed your patch. Please fix the bug or email reply why it's no=
t a bug.
> > > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/R=
EADME.md
> > >
> > > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27=
680511802
> >
> > Hi,
> >
> > Thanks for checking this.
>
> Hi Sun Jian,
>
> It would help if you could reply inline instead of at the end of the
> messages, especially when there are multiple comments. See [1] for an
> explanation of how that works.
>
> 1: https://kernelnewbies.org/FirstKernelPatch#Responding_inline

Acknowledged, I will reply inline.

>
> >
> > I tried reusing pkt_v4 and the existing TC program, but they do not fit
> > the skb case this test is trying to cover.
> >
> > For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
> > linear area are rejected before bpf_test_finish(). With pkt_v4 and a
> > linear area of ETH_HLEN, the test fails with -EINVAL before reaching th=
e
> > partial copy-out path. If the linear area is increased enough to pass t=
he
> > IPv4 check, pkt_v4 is too small to both trigger the old
> > copy_size - frag_size path and verify that the copied prefix spans the
> > linear data and the first fragment. pkt_v6 has the same issue: after
> > making the IPv6 header linear, only 20 bytes remain in frags.
> >
> > The existing test_pkt_access program has its own packet-access coverage
> > goals and is not just a pass-through carrier. With such a short linear
> > area or small packet fixture, it can fail before the test hits the
> > bpf_test_finish()'s partial copy-out path. A pass-through TC program is
> > therefore a better fit, because it keeps the test focused on the
> > bpf_test_finish() copy-out semantics.
>
> If we're keeping tc_pass_prog() then can't we use pkt_v4 and get rid of
> init_pkt?
>

pkt_v4 is too small to construct a meaningful nonlinear skb with a stable
linear/frag split while still exercising the partial copy-out boundary in
bpf_test_finish().

With pkt_v4, we either do not reach a fragmented layout, or lose control ov=
er
the linear/frag boundary needed to exercise the regression path.

This test uses a 9000B packet so it does not depend on small-packet
allocation details. Smaller packets might work depending on allocation
state, but 9000B reliably gives us a non-linear skb with page frags and a
stable linear/frag boundary for the copy-out regression.

init_pkt() is needed to ensure deterministic byte content across both linea=
r
and fragmented regions so that the memcmp-based validation is stable.

Thanks,
Sun Jian


> >
> > For XDP, this object does not have an existing xdp.frags pass-through
> > program, so the small XDP frags program is needed to cover the other
> > caller of the shared bpf_test_finish() path.
> >
> > Thanks,
> > Sun Jian
