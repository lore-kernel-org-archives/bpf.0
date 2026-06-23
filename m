Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508F14B977
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782180242; cv=pass; b=KQswmPB7J5W328GvtEAxk08fTCFqi1mKRjTJBTVoaXrNpxy6DHoHs4N9cJ+xAo75ELZ3NtwZPpi4kNWsdh6zp4JHGx9pFGKMdIANo+21KkfHSZLZ/KCTXejxdZ/0VBtR0BbjxCmKaew/BdcggxhIYu1fANmcy6Dws/E3uI9aArY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782180242; c=relaxed/simple;
	bh=yfz/p2GvdAEBen0CxmAM1laTTtAt4iZdMa8fFT8fzAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCIC9wNBCahSC982/DfSGuPzOagJUvE9tKPkdnHbKLScW1bxciAbX/2vTKbZ6XXKgPOEPWYEQg5936HyJ9799FxHxZAPvZNUx/dHpYcsdZQvdUjOlbZeyczADTDhtCacj+RAdNrxhC1s14O2vth6vxnVYnC9+flhZP9pPySRaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/X0sfh1; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/X0sfh1"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-662df6a4fe4so6250782d50.2
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 19:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782180238; cv=none;
        d=google.com; s=arc-20240605;
        b=KPD2H3sdyF1a0FT7sUcpk5FjW7wVW7Qr2Vy7lFLhK+bH2yYKIATBV9x6sFJFVqeZKR
         HJqsuPLZI/nLSO5sXJtwGhK/HdArk6CDKaVqj17uZ1mVWx3wBWaHnWH2WvYpWIct1WX5
         mvP6cVLz7dqmD7rxCh2QIs35a1e47OoNWfoPdXoFDrktba5qbQx9u+VqWtgrOCCitqeF
         RSG5W+Q9B37N6d9yHffM7E5vZYI5hlz4rmuYN0A6erlR2xp6oiQOdFe3J4b7K67Ib8WA
         2uAnwXpkpiW29FrwRf86FhSE58dBvKEbdLH0PjmqsctiQJqaYKzW4TD8gE2A2CCAKtb4
         MuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mt39b+CDA1UqkI46nSmJGTg6k30239R4rmDIdfyhkmg=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=MxSIreckmBNeM4Z4rWtOjBpu7W5GKIIUXsfmMnPwDtNxfhgEC7le37+E82xvFuTuGH
         w492xo1ICRcir/8a7dR1p4BnCJpg1sy6GUUbKcHqi8bOJbilHJ7iVzv597fAjDyjR2pO
         vq7ASp7BFRRpdXtAFXYV8qXnG7s6esE5ao8/gjtG24JSIxfj5XjBOtlPDYZ1kKHORxaa
         B0XgvO0prXkniNg0WoywA2m5WAThINs8XtibuIZSdKsBAH8FFlXTSKgy3WMQvdxirVnS
         drcDqqTD2lyOXK4Tes16SOOtQPxGUs62p7Ayfv/QezHY8cz3eOHf8NW938gL2ZonTxNm
         3TeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782180238; x=1782785038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt39b+CDA1UqkI46nSmJGTg6k30239R4rmDIdfyhkmg=;
        b=b/X0sfh1V12Ktf5K+Vp9AI8wXqN/d1xsKZe4gRXQhXZ7LNNDZZLX6UYLV1lryCM2TI
         y1Er1J/swY+uJWn+wK16zO1W4JyUHlrGf7v27ax7S8Jze9nc1aVGce2KsoKGFZ4bQPIl
         TxkzXgUBP2ZgCa3surXIDvZqyrapAcWS94ZqZzcssqYqfn97KX/QsEzIHL6l+5ii5UnG
         6DQWtyDVS0fMFF3jwyzakWqYhX86ykXPgXauzbmp4m9D2k+hLwSrB2tLJY9VTNX8+MSy
         1cqnRmeJGbRmeBgdeM8oNjRpZ87SsLzsOvXgCsFlBeYGTePtKe2gVHXfqd7X6iNAYdl9
         sguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782180238; x=1782785038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mt39b+CDA1UqkI46nSmJGTg6k30239R4rmDIdfyhkmg=;
        b=c+i5k2/26KGeij2+jQ1SoUiTijcymzKcDMFGW48jj6U1heddFSm5/3Z0f31fvIzvFG
         0uZ7y9H8Fbe3rbJ+AgSd5Ns7qRagjRPAzUykbpKzD9tNkNt6mX5tbAPSis5DCYctTknE
         X9mb2EpMle+7dteumZXBxsmg1H/7eq+SI0ljedjuwbpSfagwxMr0ufPecepvcI29m6zR
         +5fkLwyqUjhm4Gbm8q4nYc4PocK3t8qxOJ8LDA8+JzlsK9HnKv7c6ljuENUR7pSWEfxJ
         u6dYISgM94wU15EpCZcxDN43KA06t6oEVm8tgT9wwdl22l1wgfCKNn86CSOlPdd920Ks
         tatQ==
X-Gm-Message-State: AOJu0Yz40kRsicBCCHXQzVxnTx4dUlKB8+2rz0oWAgBtC7QTlHVhHWDM
	1L+Zv6OsqcC/yGYJ+ffMN/r8KtUnS7ropI16JJ9unuSEDtA9qQfd0UTPGqHOwZOlDm1c+3ZlXbU
	c/SO7pYKxunmNZ2abMJpi6ING8nPWfPaarutR8/dpbQ==
X-Gm-Gg: AfdE7cl8+cGi36KN1qLw1LKsfZ1THM8YR9tUZWxG1Yvv/zn1OVXGR0rJ7fMKBaDVuNe
	ZxGGX9nleO7oCsSrhh0Bhl/JzFteAgT8o6Gd6hz+Fv+1GocWKa1o0cNbCCZtPKcZR0Twxqh/BTP
	oKIUZZpTQe4K2I8cYCZX2Is3r7XToBiJkoYDe8GTP3ZgqAVL/UMRWsR3+ULjI65K+tFeFXDko7X
	iM3MzYLc26oUoPnjJMv28P5FdKdsJNdmAkbniBJ7UsoJhq++UaEX1uUE+axQtxrmc31ZF2yiYL7
	yZkr0hCloedTQNhOzplbLs/kk2lFLUzMN4knaqKREIHm3+sgFRU=
X-Received: by 2002:a05:690e:14cf:b0:65e:3df3:1c30 with SMTP id
 956f58d0204a3-66359e1c2bdmr866674d50.7.1782180238233; Mon, 22 Jun 2026
 19:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623014027.402820-1-sun.jian.kdev@gmail.com> <20260623015325.2F2D31F000E9@smtp.kernel.org>
In-Reply-To: <20260623015325.2F2D31F000E9@smtp.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 23 Jun 2026 10:03:48 +0800
X-Gm-Features: AVVi8CcrcdC8SK0ck24XjoJflK84MKqPtrnYp0MVTlRgZUmrjwG6UcuRpikinWE
Message-ID: <CABFUUZFH=qx7e7mT=GSepdk_XUGhPtJEzuFf-qjUUMLRaEv0kQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4] selftests/bpf: Cover partial copy of non-linear
 test_run output
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 9:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] The newly added selftests `test_skb_nonlinear_data_out_partial` =
and `test_xdp_nonlinear_data_out_partial` will unconditionally fail due to =
an unaddressed arithmetic bug in the kernel's `bpf_test_finish` function, b=
reaking the selftest suite.
> --
>
> commit 99284be8e441ba5ead251137597e96ebcee998f4
> Author: Sun Jian <sun.jian.kdev@gmail.com>
>
> selftests/bpf: Cover partial copy of non-linear test_run output
>
> This commit adds selftests to cover the partial copy of non-linear test_r=
un
> output for both TC and XDP programs. It uses a 9000-byte packet with a 64=
-byte
> linear data area and a 100-byte output buffer.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/t=
ools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > index 01f1d1b6715a6..beb6fa78fd949 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
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
> > +
> > +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access=
 *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN] =3D {};
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
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +
> > +     ASSERT_EQ(err, -ENOSPC, "skb_partial_err");
> > +     ASSERT_EQ(topts.data_size_out, sizeof(pkt), "skb_partial_size");
> > +     ASSERT_OK(memcmp(out, pkt, sizeof(out)), "skb_partial_data");
>
> [Severity: High]
> Will these assertions fail unconditionally due to an existing arithmetic
> bug in the kernel?
>
> In net/bpf/test_run.c:bpf_test_finish(), the length is calculated as:
>
>     int len =3D sinfo ? copy_size - frag_size : copy_size;
>
>     if (len < 0) {
>         err =3D -ENOSPC;
>         goto out;
>     }
>

This looks like a false positive based on the old bpf_test_finish()
implementation.

The fix patch has already been applied to bpf/master as:

b5f3534268e3 ("bpf: Fix partial copy of non-linear test_run output")

That commit removes the old copy_size - frag_size calculation and computes
the linear copy length from the packet layout instead:

head_len =3D size - frag_size
len =3D min(copy_size, head_len)

This v4 only resends the remaining selftest patch on top of current
bpf/master, where the fix is already present.

I also verified the tests on current bpf/master:

./test_progs -t prog_run_opts -v
./test_progs -t skb_load_bytes -v
./test_progs -t xdp_pull_data -v

All passed.

Thanks,
Sun Jian

> Since the packet length is 9000 bytes with a 64 byte linear area, frag_si=
ze
> is 8936. When copy_size is 100, this yields a negative length of -8836.
>
> This triggers an early error exit, completely bypassing both the partial
> data copy to the userspace out buffer and the update of data_size_out.
>
> > +}
>
> [ ... ]
>
> > +static void test_xdp_nonlinear_data_out_partial(struct test_pkt_access=
 *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     __u8 pkt[NONLINEAR_PKT_LEN];
> > +     __u8 out[SHORT_OUT_LEN] =3D {};
> > +     struct xdp_md ctx =3D {};
> > +     int prog_fd, err;
> > +
> > +     init_pkt(pkt, sizeof(pkt));
> > +
> > +     ctx.data =3D 0;
> > +     ctx.data_end =3D NONLINEAR_LINEAR_DATA_LEN;
> > +
> > +     topts.data_in =3D pkt;
> > +     topts.data_size_in =3D sizeof(pkt);
> > +     topts.data_out =3D out;
> > +     topts.data_size_out =3D sizeof(out);
> > +     topts.ctx_in =3D &ctx;
> > +     topts.ctx_size_in =3D sizeof(ctx);
> > +
> > +     prog_fd =3D bpf_program__fd(skel->progs.xdp_frags_pass_prog);
> > +     err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> > +
> > +     ASSERT_EQ(err, -ENOSPC, "xdp_partial_err");
> > +     ASSERT_EQ(topts.data_size_out, sizeof(pkt), "xdp_partial_size");
> > +     ASSERT_OK(memcmp(out, pkt, sizeof(out)), "xdp_partial_data");
>
> [Severity: High]
> Will this XDP test also unconditionally fail for the same reason?
>
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623014027.40=
2820-1-sun.jian.kdev@gmail.com?part=3D1
