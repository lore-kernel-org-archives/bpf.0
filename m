Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D23F54C7
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706009; cv=pass; b=CbFfY5DedVA8VRJ6qJfAuh/pbF8lMn2gh2dUProAPI2ZQupbZ4KFoiBivIhlGlEQDibMvmW9Qzk/dS1YmWpQ2CkIhtfGflNQtF1M5c4+mdcip+0Pac39I4g2Pt2RXTBEyuBUmkoib2T5WpEmaFLKBqr4cUI/2FxVuIpSyy8MMwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706009; c=relaxed/simple;
	bh=LXjj2AX0Vl2kOkkKEFA18exaCc4ribznTBsnG03/ix4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiG6YXX5QVEXZF+LkM+Z8Ttk0KF22kf5XvEYF48UPj6pcC0uRBK/9ynlrH+jvsdCbBDG15bTW4Q87LS0WYeRu3P7kiNPzvYj0Iek71K1+Y3J30dLStV9fAU8we+Gw3NQYBQXXGkpf5sFK3wfHlI4p0iPCgBXzjuVnHVA39QR5ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7RWfaQ7; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7RWfaQ7"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-662bb8b1f93so1649543d50.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 07:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781706005; cv=none;
        d=google.com; s=arc-20240605;
        b=iDZ5Q62u7ERzI6a/SbLYY1SW1ezH1AGN3gbhi6hlMG4B2M/f4PQmzywQG0rdyBXr7/
         yLQJgKmIQXGD0X4NJasrnGLwqNK9/KXA8R6Lva0QZ5W6hkTAuxk7MojJi0Z5ONNfvozP
         PmMLQnhYxiJ1C7Uu6aCiSI3JVHpDDFLDQ72MR7Y2lmj3Vrh2jxzALaukwgzDnld0QDy8
         PpGbjq/oK5wsUMerhd37/1fh2k6Azy3RESNF7FGji5HkOCjVUXA9vZPvTEkc6KJCvqXn
         wAcyUzysv4N7fIGnH6dXVRAQNxsOSIW7I+XXYMYOB5Z6gg30WSFc2AFvqGDe0HPwehUZ
         AaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        fh=nIvU6wkJT3SNun4AP6Qj5cOz1a0JBimRNq6IgFcq1lA=;
        b=d9NR1APm2L1o2N8yEkYchpC2627cQTlk+5Dpax417HB4eWLk+lJJJrJBZP/KWQED4r
         1o71Y1DBFZngYEunXz4IX7+uz6u2oROAn167788Ue15HPYAzgXrILLe6j2RCcqaRjeVb
         Z0GctFefWLE+sZzrXLgwVOI60yOyFHUJGTlcs+tYLGbqtLdwA9jpIKyRxL+hqvhqMGjT
         1cfja2Ivbe7kaU06NV2fcMBZd5CGoO1kT7Rf4HCK2rHywoeBcRTIyM9ivvP75lY1++bX
         5t8456uFu07ZdVTrx4uiZCMRy8rJFy7N+nojEPYBBPrSD17iY8ZAZUPgdou7biSE1Yyq
         LUKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781706005; x=1782310805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        b=n7RWfaQ7ZOd2SD1V9DFHwe13YYH0VxgLZbdiRx442lRvi2cRqo9jRgUg6x24YEJadT
         odl9vzMHey4oHjq/m8RaDqVlMqUoQRKHyNUa91Tj2yXR55n2QL1cwWIP37wFW/Lp0cOm
         dOK/ZHk8uc43n0aorJgsDCRKOurioR1SxdTL3TPpGsfZOwdLnm3sZ6n+KBw9M8aToJWL
         UZyVq/Me66SZn9oWKqpoJRWCUqY22UNCh81OaG6yMCxhXeI6uoWxDdS9c4RlYzOLBSHC
         HSN9a0wG4DqgFwDs+LEkMofRR/G08PbNsMWenM3REfuI0hFpqtUBQy47iM4rL4WZVTof
         rjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706005; x=1782310805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KrC9X0aB+Fg+JQYfds61UWaxCNwOvyYtowwG8v7gyUk=;
        b=Rx5fjWtpY8qT+uBLPm4UHXIDM0TTO+8bHNLvqYubDgOpRPmw6ADzL68R49WfQpE0NT
         rphJzAcyzo0cQDIrxlhS23LpJ1Xy6Z9zo6smB+OEd9KbvTrtXjMLKCN+gHzx2mvUDJgv
         KRKXGeFFHZQq22x6XfSAcyNrbTOpbD7uVG45R4hCobi5GjO8EnPNVb3HyG3X90acawMZ
         2rwBYh4ndaBafuLHN3StrIiPHy1Y+6K36oBph2RxF8y/x0IjECo8uZq3zbdAztJwVMWu
         KabsqCzUQFIFm+9qjPCQlc+Nyk8Hat6H7yy0zNMpClVy5sIyLcHHriMBektEcBUb2N7D
         PxaA==
X-Gm-Message-State: AOJu0Yz909U+xzz8V66eZW0w5t38YjtscPR9DgFIdMxRleB6iTCrQxGN
	5ZS1qDXt2GKTHP58GYsKXA9JTK7kKy25rjdH2ok/YHTrazONOehEiglBzGYX+3+K96MgQC8nUUu
	Oa/wFDeNBgW7te4JRirvo9Rvxun2qrUo=
X-Gm-Gg: AfdE7cnpVStz6+zRMCnX0DwpAaUNxvbx1GvrSpT7mD5GtD2moqHinzJuCMtP6XvMlox
	DDakWemjjVsnrwwXvJ+BuWwwMp+Ew+aRjYX96JHGoxxOzv+JszHHZWSuDxl++w7xWV26+MzTK2/
	2DwKXi7uDZ/Dcct1AySTXZ4Wojs3E84CscPcm1KF1JagQn4bniZYIT4SnxMuUxvhg/10cbwzv91
	TFIwB1HWzwrG8yOtqTXuv+o9Omvf85bBudUZE8+Z6JrN5ZJACVJAtr5kVpLOJ8hGE5DJSXah3UU
	sxSyN+KhmBeq/G9EGb5Se4rpmtqU59mkrXkMAvOYKdLEZV6AbSt80F8R
X-Received: by 2002:a05:690e:dc6:b0:660:933d:3057 with SMTP id
 956f58d0204a3-662cd092f11mr3027618d50.0.1781706005428; Wed, 17 Jun 2026
 07:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com> <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
In-Reply-To: <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 17 Jun 2026 22:19:52 +0800
X-Gm-Features: AVVi8CeJJOuka0GCnt7aRS0jt8X52KgHwbpSBiN7gwyo77ljDBh5CLPdi-Ab_Fg
Message-ID: <CABFUUZFeh18OjQ6EhjD17ZwQKb1aiVNkYKv-hAkVGrHhPpjE4Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of
 non-linear test_run output
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com, 
	lorenzo@kernel.org, paul.chaignon@gmail.com, martin.lau@kernel.org, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 6:31=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/t=
ools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > index 01f1d1b6715a..9cc898e6a9f7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > @@ -4,6 +4,10 @@
> >
> >  #include "test_pkt_access.skel.h"
> >
> > +#define NONLINEAR_PKT_LEN 9000
> > +#define NONLINEAR_LINEAR_DATA_LEN 64
> > +#define SHORT_OUT_LEN 100
> > +
>
> [ ... ]
>
> > @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt=
)
> >             "incorrect number of repetitions, want %llu have %llu\n", r=
un_cnt, info.run_cnt);
> >  }
> >
> > +static void init_pkt(__u8 *pkt, size_t len)
> > +{
> > +     size_t i;
> > +
> > +     for (i =3D 0; i < len; i++)
> > +             pkt[i] =3D i & 0xff;
> > +}
>
> A question was raised on v2 about whether pkt_v4 could be reused by
> reducing the linear area to ETH_HLEN, rather than introducing a custom
> init_pkt() with a 9000-byte stack packet.
>
> Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
> The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so this
> doesn't seem to have been picked up.
>
> > +
> > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access=
 *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN];
> > +     struct __sk_buff skb =3D {};
> > +     int prog_fd, err;
> > +
> > +     init_pkt(pkt, sizeof(pkt));
> > +
> > +     skb.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > +
> > +     topts.data_in =3D pkt;
> > +     topts.data_size_in =3D sizeof(pkt);
> > +     topts.data_out =3D out;
> > +     topts.data_size_out =3D sizeof(out);
> > +     topts.ctx_in =3D &skb;
> > +     topts.ctx_size_in =3D sizeof(skb);
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.tc_pass_prog);
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tool=
s/testing/selftests/bpf/progs/test_pkt_access.c
> > index bce7173152c6..cd284401eebd 100644
> > --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> > @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
> >
> >       return TC_ACT_UNSPEC;
> >  }
> > +
> > +SEC("tc")
> > +int tc_pass_prog(struct __sk_buff *skb)
> > +{
> > +     return TC_ACT_OK;
> > +}
> > +
> > +SEC("xdp.frags")
> > +int xdp_frags_pass_prog(struct xdp_md *ctx)
> > +{
> > +     return XDP_PASS;
> > +}
>
> A related suggestion on v2 was that, once pkt_v4 is reused, the existing
> BPF program could be reused instead of adding new pass-through programs.
>
> Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of the
> existing program? The v3 still adds both of these, so this point also
> seems to be open.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/276805=
11802

Hi,

Thanks for checking this.

I tried reusing pkt_v4 and the existing TC program, but they do not fit
the skb case this test is trying to cover.

For skb test_run, IPv4/IPv6 inputs with a too-short L3 header in the
linear area are rejected before bpf_test_finish(). With pkt_v4 and a
linear area of ETH_HLEN, the test fails with -EINVAL before reaching the
partial copy-out path. If the linear area is increased enough to pass the
IPv4 check, pkt_v4 is too small to both trigger the old
copy_size - frag_size path and verify that the copied prefix spans the
linear data and the first fragment. pkt_v6 has the same issue: after
making the IPv6 header linear, only 20 bytes remain in frags.

The existing test_pkt_access program has its own packet-access coverage
goals and is not just a pass-through carrier. With such a short linear
area or small packet fixture, it can fail before the test hits the
bpf_test_finish()'s partial copy-out path. A pass-through TC program is
therefore a better fit, because it keeps the test focused on the
bpf_test_finish() copy-out semantics.

For XDP, this object does not have an existing xdp.frags pass-through
program, so the small XDP frags program is needed to cover the other
caller of the shared bpf_test_finish() path.

Thanks,
Sun Jian
