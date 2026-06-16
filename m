Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359AF37AA94
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 01:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574298; cv=pass; b=QR57uhB9I3Ue1Mc4+LotLmumIOJ0ThFsQrZz/jHk+NmTnf9kGMldT0emv/N2G1dZErAuYOGvSp1DbvgicgZRdCtGDKoMXZ0VivjN9J4mTDHaWJfXOamA6mu0ZVpxyEqZCj1/NQWlX/1mppaeKYJ/AYctwqSAuztJvLlueJeSURk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574298; c=relaxed/simple;
	bh=8tb1U1aZ9n4reEv10sQy7avbCZsN68fkX6jT/KPserc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEwbjqEtyLmPQ+pYgPPf1a703/5bmTBUREIsPIP4K965q2Zl9XsN9nS5TjC4n9TOY1JEQzhFEU0Lu9da/BWO0wAVLl4u9xCb0HWe6bseYk+ouRvJpXTqkBHlPnrko+6VMOOe0SvoyVDtDyqVbDPX4EPdfSqhmF7LPAbjXvWxByE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwnPR6I5; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwnPR6I5"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e3b2a435ecso43616157b3.1
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:44:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781574295; cv=none;
        d=google.com; s=arc-20240605;
        b=R+6OtOQ1WUZlgtyD6BmxRNa9Tf5cDGG4xOASzOx+7jM08Fa7MP0IjHnq9Jey8nQNp9
         eK2D6QP1/xxHNbKP7AsGC+u0TewK061CcNp46oXRVxK5DFkT4JCmXg4i4392rLejL90o
         WrdioA3ybmRywQKloJoXD/Oz9UwZcsTPiH6iWQyR0E8lXFs4LGzPx/pc8jvJNt56buVG
         wFAb29yTGCSDIU4xowH5G26VmWwzbj7SseR9p7rhY2KC/lV11We/IfIArOkzaonmo7xO
         6YI91yMptdeaD1+lV0R723lszOW0LTKT0iQGz7j/XJe5oe3Mpa3weXUeQSQqMf3Xp1Pw
         2jJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        fh=xBeIBgkDbd0exZ3T/3galYLqEpVRufMAoTdOHDqhD9E=;
        b=XazOdLtK5VZSe7V3Q0vKucJSKp5+Rz1xHfDRtmi9rTj0gAdb2w202Ros19s9gUyY16
         exCymg91w6Z/suomYTwoh5V9ZySp43HbVrOT/n98Ng/y4apEzNpfzwQ65hdpy/kQK7Ke
         elM+5uhYngkpESLJBz8nvqY8osr13dJb4JjOPE6nWbgDHAdZbidxj4O+4neiAg3SP9qr
         B9329v3OA0u6Tu42hsu6fKbsf5F9j2l/P1Cx/k9SLvb7SeoWzeaBeVhE+1tharl/Srdl
         LjUX2Zp4oM6uhgufza1Uy8ll6FgbyCoiNdbmE76SK5bK1N7+WBlWh1uuOeM+g2O+X1Yp
         WxxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574295; x=1782179095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        b=OwnPR6I5iIs3RNyIl7li/ifWPBaRoWSLpVjjuEyDVWS62jUrE/MoAVNMhCMGpbIqrE
         /2i6BuHuX5b8az7Yo1OrPtmAge1WunOi45at90gpQXXA/h+ywccJRNjhtDGcvoWRkalM
         0t8GYkldhbtUdD8qInwfGg2TvXqpUAa202NBRcM/1pWS3TcgtOwUXQ/YXcL73q8uHwyZ
         WQ88gK2/RAaSyRGDAb/uKncOtos2rQsrinmHOu8QAoAUV1OX5Ot4heHifAaX1zRLChWf
         p+itmcyBFTIaP3TS2nXxeGozYEFk8Ycz22PxffOZOP78k/qVNtZ68Yss6STa5J3UfeAr
         eUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574295; x=1782179095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73H1rmBZsR9HB0wLO22wKQ4YOh6GObKN7jR8HYwzlak=;
        b=B3+CtbC/Wk9ypIlHeDnArWdIfhSwMT9l/Y5kUs8Ko3zKvXR3SlKQ4U+eIHOZSb5FGo
         Qw9REFmUwu4UKQ37W7NC+qMY5A7oEY+pM3TIIVTmp/sNtLdtAe9q2sxmVafScQFpmdwu
         hip8IRTfHBQUp2XQWXvTt83SM9dR20hT0HTk8MW9pstfxVTwv024t03fKg8I8hHAxw9M
         mHd1gFCSXz/R8Spbrb813tTendfRPbOpPIx3Kclcln4RYo3udDnUsJyw0H9xjVe0iICQ
         nayoUfiiK3R7bQdsLbCzxCHdGkefRt1srWzIWc1bLyykntTj2j9eczMxR9t0noJf20uB
         BLkw==
X-Gm-Message-State: AOJu0Yywb+5yVE33io6r1LS+3kEU4RXMGhm+xG9N6oGR//ss/fLqGCRM
	vrMOS7lOiC2R9jz6yF7CZBhcQeR9WXU1Gfk0CpFxBzA5xYelYKeQ7zsSVDmXE5zXIvwa4IlLRaL
	gCQkdmcEqXX1YCbPyXpp3XYJkxfklqYuaB4SgcPyKAg==
X-Gm-Gg: Acq92OH5mHzCwPyrnwtSgu0/KUHD6kvU3D9GIgHHmWtdO4+WoXGkR03UMXhU2adl/aD
	wGA/JUrR8fJvfx8awLXWeQSfcO51p5kW9reIWmKe1SLG999LExfmFYac1H97agIM+xkmtwrVVIR
	YRa1bIiPqH7DNAj9E93lcUgnsStBj5YKQsPT/m/soO21XCsQUc6NwewrM02v39EdFvfraaL5oU/
	cGx/MtSbJuKWyDUmCX/ok+vorVKQ+wxVHY73mrOmVzRBoO/Lh8+f9bpOk0aDPkEqncJkPKT2AOA
	kY+lew0ky6zhQbNAJDQTrmlvBKy6P4mb7Gpl5SzJuhY/5BN/6lE=
X-Received: by 2002:a05:690c:4902:b0:7a3:7ad3:3e9e with SMTP id
 00721157ae682-7f8c37d34b1mr121816437b3.32.1781574295274; Mon, 15 Jun 2026
 18:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615073856.152479-1-sun.jian.kdev@gmail.com>
 <20260615073856.152479-3-sun.jian.kdev@gmail.com> <ajAIdJHvvIH9ZSrM@mail.gmail.com>
In-Reply-To: <ajAIdJHvvIH9ZSrM@mail.gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 16 Jun 2026 09:44:45 +0800
X-Gm-Features: AVVi8CfJxceWjHoo-gL6bJqNaLI_gcPFSgsxs1Oced6jE74a7o2xoyErdyfibJ4
Message-ID: <CABFUUZEkndSQyxckpNZ8tbP6_o7zL7fBNdrsWNia4JDiHD-NHw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover partial copy of non-linear
 skb test_run output
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:13=E2=80=AFPM Paul Chaignon <paul.chaignon@gmail=
.com> wrote:
>
> On Mon, Jun 15, 2026 at 03:38:56PM +0800, Sun Jian wrote:
> > Add a test case for BPF_PROG_TEST_RUN with a non-linear skb and a short
> > data_out buffer.
> >
> > The test verifies that test_run returns -ENOSPC, reports the full packe=
t
> > length through data_size_out, and copies the packet prefix into data_ou=
t.
> > The test uses a 100-byte data_out buffer with a 64-byte linear head, so=
 the
> > expected output spans both the skb head and the first fragment.
> >
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  .../selftests/bpf/prog_tests/skb_load_bytes.c | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c b/=
tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > index d7f83c0a40a5..134be0ea8ed7 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/skb_load_bytes.c
> > @@ -3,6 +3,39 @@
> >  #include <network_helpers.h>
> >  #include "skb_load_bytes.skel.h"
> >
> > +#define NONLINEAR_PKT_LEN 9000
> > +#define NONLINEAR_HEAD_LEN 64
> > +#define SHORT_OUT_LEN 100
> > +
> > +static void test_nonlinear_data_out_partial(int prog_fd)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, tattr);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN];
> > +     struct __sk_buff skb =3D {};
> > +     int err, i;
> > +
> > +     for (i =3D 0; i < sizeof(pkt); i++)
> > +             pkt[i] =3D i & 0xff;
> > +
> > +     memset(out, 0xa5, sizeof(out));
> > +
> > +     skb.data_end =3D NONLINEAR_HEAD_LEN;
> > +
> > +     tattr.data_in =3D pkt;
> > +     tattr.data_size_in =3D sizeof(pkt);
> > +     tattr.data_out =3D out;
> > +     tattr.data_size_out =3D sizeof(out);
> > +     tattr.ctx_in =3D &skb;
> > +     tattr.ctx_size_in =3D sizeof(skb);
> > +
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &tattr);
> > +
> > +     ASSERT_EQ(err, -ENOSPC, "nonlinear_partial_err");
> > +     ASSERT_EQ(tattr.data_size_out, sizeof(pkt), "nonlinear_partial_da=
ta_size_out");
> > +     ASSERT_OK(memcmp(out, pkt, sizeof(out)), "nonlinear_partial_data_=
out");
> > +}
> > +
> >  void test_skb_load_bytes(void)
> >  {
> >       struct skb_load_bytes *skel;
> > @@ -40,6 +73,8 @@ void test_skb_load_bytes(void)
> >       if (!ASSERT_EQ(test_result, 0, "offset 10"))
> >               goto out;
> >
> > +     test_nonlinear_data_out_partial(prog_fd);
> > +
>
> Maybe prog_tests/prog_run_opts.c would be a better place to cover this?
> test_skb_load_bytes() is meant to cover the bpf_skb_load_bytes helper.
>
> >  out:
> >       skb_load_bytes__destroy(skel);
> >  }
> > --
> > 2.43.0
> >

Hi Paul,

Thanks, agreed. The test is really about BPF_PROG_TEST_RUN copy-out
semantics, not the bpf_skb_load_bytes() helper.

I'll move it to prog_run_opts.c in v2.

Thanks,
Sun Jian
