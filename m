Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E13E0C76
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782332543; cv=pass; b=Uq+aEm4V45083fFvFXmTtuwphs+iGI2kH+yNa+7BHxwR5GJk1K8qskDJ75lnVbnQeFQdelJcphOYa2coEWC9mc0aB0PYkhP+zv6To8wNHhZTMDha2XnVwTZWjSSGePpmesGQzqRK8Vflo6BrGUeeYVxGl9+cD71xHrnevqL8ov0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782332543; c=relaxed/simple;
	bh=BtjUuXZ73D/qyp8VKn6KPfK6YXmAmDeXxF1Yp71qiyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThpexBrPnQUFWKZZ+5uroNcp8n7w26UgrzhEoQ43oiVCrCW40kF+A1Tkycs0BHd4s1DFSJaDff88u42M1kOSwU+SIgimbzhOtbMMMN9zrayqLPGSRqRKMbG0MpPDqzPq7z4xsIjRY0HrOkbXHASZpicz9JQZzdM6VU5Mgv5dmg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odMRxrLB; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odMRxrLB"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6603d8697d2so1463770d50.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782332540; cv=none;
        d=google.com; s=arc-20240605;
        b=BinND79grX4lQxoF21LzAwDQdTNhLfgG+Gn0/OQboCgF9XJLqd7agTWkIDYfh+SThK
         Ngxjhk4nLSruCbJqYN5ditHMjDNUqA7s09jOAzRRg3JvHwhGwebhbw1d14ry1FYzZubc
         A6FGDfZgXGIQie7AuatmLikNZSQH0tPHWFDBzEqsP9Qj7sdNvF2CSYCI8mPK2plvqG1M
         CtF5saZToi82r/l9h0oHrBkt6peQiB+GW902AiswhrvWfqyoEo99bY4kP/J2Gr3UVfuy
         gvotO8I2VckL/QGpe14dPDk1eg1O1qFVylSKoZHY+jk7xp9wEPD+rmmQJQcXiCyDaunn
         kXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fNe75pW3ZXrVsmALyOE2GE0eISHbsPXr9AeMBKq40Eo=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=MiPZhDbPENdKczBaHufTc98WfOpVC/yA0BZtYmJcMrhgiOZQr2tXr2ofrCfffo3g2k
         7Pari0tkKSxG5WLT7/X5BwMPyDbLbVGwJOEIvl5VHvu1fnPGACe5seXC6AxxqSfcpSn8
         lPN2vs3MQilejmeCIwc9eCXARm655D545Y/HpMVYAEM84jbkI5L5nyNNY7PKrnKVg4O3
         XReByMLC7onmo63zxg4LRgm1DpHsIWuQXAcr7I2uYp2sQjF6jtL/OCqvBTzOqFtmF3Pa
         HRcVlbiJk4ugemdVAzmCAq0RrYJmcm/dtj4oxZzrxKHQWbfsTPWlJrYcAi53O/d6riUg
         61Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782332540; x=1782937340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNe75pW3ZXrVsmALyOE2GE0eISHbsPXr9AeMBKq40Eo=;
        b=odMRxrLBAwLXbhmvXYJyvTF9OMi4r42mlLgMHJZ8s8jDQ49EBRdytyhJTYAGiGlBOx
         fc7iFYy3SqqZzxk8yEl62NZzteMDX9XSNbRAs34Lc4sIORT9fTlzjsuZFprJICsDn/ol
         LxF79ahIsHAvogRAMfVw2aan6azLTpy8ZOvJei6UMPxam+gbzwCaGSHOEKAK9K+KmRDt
         d0FlYgNfAvq31eFYD+j7oKVLtuHynFzVNR+R7/NJZ48wmwgLAlmBqgjnulg32h64/dGQ
         +Dbevve0xxTcUqH4YitrS12aG2lHUfG8Q7l9DyXVHo0+/J6JLIJxSB5is3YE4yF7bl7U
         Cb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782332540; x=1782937340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNe75pW3ZXrVsmALyOE2GE0eISHbsPXr9AeMBKq40Eo=;
        b=IMIn9CHaQNJ65ft7ggRiuBYhzrFbSFAEYCsOoZs3Kfip3ZMa5dg04eGUvOhAPCkY1F
         o2Ep3B53Cby+BdNtGMB1D1Od1Ihnv6JKkITVdYRyikUBuAQu2OhD64hIhghRdJBELLZW
         8uROLmoX9EwOqyK7c98f3Zz8M+xUcNNV1H8jYHFvBrwnkQWSG3zRw8kM03d3bLVkbqGC
         Y28z2HRO9SFQF4kaMHJjPI/bbqutw5nK12selpm3wt2TZ10WHJKTtHoEPB14vjuiBAai
         uzWM4nZ3jDz/rnSf2RDU1rx0nFjNv/4/RocQiXmGImwrPBhwmC86A/Z78M6R6nhP/9Bk
         D0+Q==
X-Gm-Message-State: AOJu0YzpeytXrrrsNyxiUF5uCgoGmLjl10vZh2fX9t0xE4EmnA2Nf5nY
	UF7FneLgR9tPLqy02ETYwUBAjo/Mz7h4YXINuDdqOPV0v+yBv9MpVVigsNTDf1TUEE5aqXDGBiC
	aoPL56BIwN4kHNRPW/OKR55YIbiV1L6X/0A==
X-Gm-Gg: AfdE7ckcAPjhL78h0OgwJJptGZZvkKjggtsLvgE1XL5S+MtauTCOqWC8/PGaz+6t18m
	yDidg+Rv0q4oMV4/eritwl79lJM8XLvgrQ5HDQgg1YJXG1jRM3S3mESP1y3ex7Qp2nW4IYv+7nE
	Ow4nVC/zV0lfEWwqTHfMobICZToPKJ/ckClmJqbw2+ghe58iu4btHMfe8kf18iTHEt4R4ufcLJS
	CKoXZhyP9ItVnsVNebh+NO8vmEwA41DbjmslI2tQBT33GJ+SeIltXyRvDqjPXyZd5valYNkdlE+
	CLS61uY=
X-Received: by 2002:a05:690e:1382:b0:65e:1d95:29d5 with SMTP id
 956f58d0204a3-66312f6d069mr21718468d50.41.1782332540348; Wed, 24 Jun 2026
 13:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-15-ameryhung@gmail.com>
 <20260624000312.AD6581F000E9@smtp.kernel.org>
In-Reply-To: <20260624000312.AD6581F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 13:22:09 -0700
X-Gm-Features: AVVi8CeluNs5g7tmC-ra0iSyMfqPCKtbCKXij75pC2NX9hfHTma3PP7t1VOVK6o
Message-ID: <CAMB2axPJ+iQ4kr4RkQtGYbzUe8sfVaVc3vjXj6_Gv=1NNhEP4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 14/15] selftests/bpf: Test attaching
 struct_ops to a cgroup
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 5:03=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Test state pollution in the `inherit` subtest bypasses the int=
ended `cgroup_bpf_inherit()` testing path because the child cgroup persists=
 from the previous `hierarchy` subtest.
> --
>
> commit 9dd80df6f86c72623dac7d2f203da4036e4e8827
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> Subject: selftests/bpf: Test bpf_tcp_ops cgroup generic link
>
> This commit adds selftests for attaching bpf_tcp_ops struct_ops to cgroup=
s via
> the generic cgroup link infrastructure. The tests validate various behavi=
ors
> including execution order, query interfaces, updates, and inheritance.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
> > new file mode 100644
> > index 000000000000..4d087bdc4613
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ops.c
>
> [ ... ]
>
> > +static void run_hierarchy_subtest(void)
> > +{
> > +     struct bpf_tcp_ops *skel =3D NULL;
> > +     struct netns_obj *ns =3D NULL;
> > +     int parent_fd, child_fd =3D -1;
> > +
> > +     parent_fd =3D test__join_cgroup(CGROUP_PATH);
> > +     if (!ASSERT_GE(parent_fd, 0, "join_parent_cgroup"))
> > +             return;
> > +
> > +     child_fd =3D create_and_get_cgroup(CGROUP_PATH "/child");
> > +     if (!ASSERT_GE(child_fd, 0, "create_child_cgroup"))
> > +             goto done;
> > +
> > +     if (!ASSERT_OK(join_cgroup(CGROUP_PATH "/child"), "join_child_cgr=
oup"))
> > +             goto done;
> > +
> > +     ns =3D netns_new(TEST_NETNS, true);
> > +     if (!ASSERT_OK_PTR(ns, "netns_new"))
> > +             goto done;
> > +
> > +     skel =3D bpf_tcp_ops__open_and_load();
> > +     if (!ASSERT_OK_PTR(skel, "open_and_load"))
> > +             goto done;
> > +
> > +     test_hierarchy(parent_fd, child_fd, skel);
> > +
> > +done:
> > +     bpf_tcp_ops__destroy(skel);
> > +     netns_free(ns);
> > +     if (child_fd >=3D 0)
> > +             close(child_fd);
> > +     close(parent_fd);
> > +}
>
> [Severity: Medium]
> Does this code leak the child cgroup and pollute the state for the inheri=
t
> subtest?
>
> Because the child cgroup is not explicitly removed here (e.g., via
> remove_cgroup()), the directory persists in the filesystem after the file
> descriptor is closed.
>
> When test_inherit() runs immediately afterward, its call to
> create_and_get_cgroup() will re-open this existing cgroup instead of crea=
ting a
> new one. This causes test_inherit() to silently bypass the intended
> cgroup_bpf_inherit() testing path, and instead exercise the
> cgroup_bpf_update_effective() path during the parent attachment.
>
> [ ... ]

Ack. I will fix the missing cleanup: join the original cgroup and
remove the child cgroup.

>
> > +static void test_inherit(int parent_fd, struct bpf_tcp_ops *skel)
> > +{
> > +     struct bpf_link *plink =3D NULL;
> > +     int child_fd =3D -1;
> > +
> > +     plink =3D bpf_map__attach_cgroup_opts(skel->maps.tcp_ops1, parent=
_fd, NULL);
> > +     if (!ASSERT_OK_PTR(plink, "attach_parent"))
> > +             goto done;
> > +
> > +     child_fd =3D create_and_get_cgroup(CGROUP_PATH "/child");
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D14
