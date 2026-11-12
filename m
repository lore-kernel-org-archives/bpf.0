Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500849;
	b=UbBCGksQmWx4NxKSkhY0enO2x0AQ9xW739FdvGCun340EK/+BHGQ54kIogQ3SUgQmSAy
	 FwHwL+mI3G8U+rom7N60PztS4bTuABM+yxOnRzgjP2XM524DN8/toNQSrwicduE+0NfVk
	 xpmoWJnst+LvcLWxixGd5gKQSNU2Y+naP5AU1I3gtDeOosTJnp48Vwpb6llrAbGH8Au2Z
	 wT8klz4Z+f31fcxPQCN3JAZzARUMoQu86GCPcROXc/v/5GHsVGZqA0csTcqCE1Gj+6S6D
	 Kcz5uehyS6Kv2WSG2MsRd9qG3OrnbyAiQEVuDgZls62Odf0QDVechggB6jpTS171JjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
	b=CxQ12g9qmQ01HnLjxlH/eRtgic77Ht8tsGbbUxLRldouYV06LZYYBrE+Q6Im29aDq0y4
	 aYbHmRTW1mJSWb4NhE3SHFiYKFNQLnatlNKa8clt4z/QkvFHebwkO/hArR9fih3+0cyR4
	 ZXGGda/yHolbjdT3lFR9sdSNUYt/XQMIa5P3LQsplz05sX4i+2QIFRZEQvgPZjcBCtCMh
	 46KSTFrfUcc96+ybiJYJkkIZHng/o8ApKfQrk30DWIxa0owZ9NdaqjZC/sKX6Az/+53XL
	 93kmzmoFn5r92tDe7VBCcAD0jD+GTx3rdxX/Ms+IMAfPM96nOeVVlYm9dH84j6dZHbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcmCDyza;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD1606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 16:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BBD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YcmCDyza
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso61435e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794500848; cv=none;
        d=google.com; s=arc-20260327;
        b=QRxsFHkS9OVvb3Yutyam/Q4hM8pjEE61HyLY8HUelHFs0l20goYrmcrWYtAhZqq2Qh
         mi0j+7JSMviFHGo17OVHmxm+51iDBR7/wmecYYJo7zSBccrRF3pFJQmxa27JdXlA2rMe
         8SwB6Yn3eJnDFxaESkygkWRxu5BKGMiVYFXufNaBbJd5z9oe5avN/J/1z31TlnPtcTTD
         vh6fhQTxbsF9I2t4RshT0fivppn7F0QWKi8wl7jAwbhTaQHD0qsblxVkpubQUk7bmTg4
         3y54iKzKLGaPAPTm/MtCqCwjFqcWfdbZoLUJMlCiQAmBHsD4ZclexmLgPmheQ7n6Pm4N
         WW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
        fh=c36QkVzduEjNR1lUUywlMMDdQOF62Ew3QWt2BUZtX/4=;
        b=UD31fFcQTAvUD29PKxp6t+Z1ngwJL7QsvrOKgn1Fb/zxAMy7d0R4bvEY+/01MhV3Av
         HoZkJOQKsQvyteXIbQtxu8p5dv/Gnm+cjjkGD1b/ksUQXQMayiWnCZT+JD4IUhB+Rb8y
         a1hk7lzOLbC+M89ZhTDWWC5Oo2bqDQNT441tUviKM2z0+hdCV79rW0sjmVLWw3eT/Y+Q
         6+5dHdypb8oBScV57ezB7at6o0avh1qx70tONRJn/p7k6c4JGx3N9ZU+RKfN3338ycpz
         Z+N1e2pVyvjeew8A4LFGfHfxsVaDd4uxB1UpU6yBQUEs6W7vVNUi4QWQc8vbhsRyADcD
         9oNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794500848; x=1795105648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
        b=YcmCDyzav8Nt9tsG6YB1qdzrsUj2K7xN0qRg6FjWZ85PVWjBDXTysbYRtMopeaGbHw
         3AD3NY7Klvu3c//cl4xWyT9uv9XZ/YXGR9E9IhVCPadmz4MO66ZCO1opX2iXapP6/oAW
         rtO+VtvjKI3UtJ9VnqFC+tm2nkYPOWL4ytG4YVF/EbhrczQOQcN6os3wrD4qT8Ih8wns
         9iFRpW+zxr43BA4tifJ2kpNVhhJvQbYNQfVQQLbcZpDT7Hl0lS70q9bjAg3WzVJsnTRQ
         f5B7HuJNmAZOpibG3xssCazggPBdHG8B4QJ6mGcJJJb8+oewtXsLgZxQ5gCpnjQ0hotN
         VoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500848; x=1795105648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4rfQtqmAIAvmt99DAIISM3k+R3AqubbosQEc8qLWnGI=;
        b=M3fFeFtyAxim16GGsvA0e9SIqmnjUJAfcqicFb+cpTNOwAJN9VSziHKIIhaX/cIRo7
         pkGC864TvLN2lx4gjdlx1Qz7Cx+/cdBs3sdlIXmUZ9aWfEVmiwhW5clbX8/7EVuhdxkD
         5vhnHL8wP4DAfNPJGkPROGKzvZ7A1s/B/9oeEvoSghH3ZkAVRsZrYleKQu2wr/MyXgBB
         exJXXCL8KOXfx5GdmxWfopJAazdIBpjQGczVV/wEXR1K+N3uYqovFCPUAI5zJA/IpkbT
         tEMHT0duHN5zRaaSyeOGUytjHJWziMiVfGEh8MtykfmbekhBCIfC67mKAry6Q2COuZTZ
         eBaQ==
X-Forwarded-Encrypted: i=1; AL+hErHa8zjXFCt/eXJgue8vuXrU29wkOSMacK3oLLajtZQRL7ksTcffBNmo6ShJlV5rBGFdkeA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TJOJf4Am3shT8nAUdY4F7K7n9PDNh1ocvL+JdGUk0SkoxDnjf
	KCgvtVNg4ExBBXjwsiBQWjEICb9oZV1t/vitWt7D9sYBStKjblnjmbXYV6HWYsMT5X8qZZNE+ia
	DXKE/qs6bPPiRb9chHDOMynKI720IZa8BSuJ/KB+Y
X-Gm-Gg: AYBFou2kBA4+MKu/5SspjasawlTBA3aa22Eutt1tTFqZ5kbMee3Bb/O8rpgwFxYnfg1
	pWS+duy2nQFX1v/yy4W+/Rxe16h/if2TbnSBug6L/t9AF6X7/zFSyqcH1e5LQtv2ox3Wwrtoyfk
	+TENlVhMVo3MljNulB8RCS/3c9C/I/lRtK4/KwlxTcMjd6SMZFreTuT5yYI2X4rqb2aQH/Ya26q
	P8QeArBXbd2ndtdiSAuh4rlPlVVu00B5dVuBfWpnSzmx5roFhcCOxoF3xysZcNPuk9OomOnKV1W
	0WJYesbSbDNecTgXxh8l+mP1OnpWDximl8kuJ2z+7hcVQW4jwX4d7eZG2ZvTNPn5AfuNtw97kzM
	sU9WChkYF7CWkoQY5juGZNU6eYcyX0dibwUJ8lDJq5Wxgwx/cyfhpZkYtCeiCAzNP68n4nDPE40
	kprObuwqwtj2jSs1WUmINw
X-Received: by 2002:a05:600c:3484:b0:4a1:d7fa:ae36 with SMTP id
 5b1f17b1804b1-4bb4f596156mr1132755e9.4.1794500847262; Thu, 12 Nov 2026
 08:27:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110125106.2935677-1-k.chen@smail.nju.edu.cn>
 <20261111195942.1283060-1-tjmercier@google.com> <70c7192e-b9e7-4b06-9d78-38e9de85f486@amd.com>
In-Reply-To: <70c7192e-b9e7-4b06-9d78-38e9de85f486@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 12 Nov 2026 08:27:15 -0800
X-Gm-Features: AclHuK-uQbQFbW5RNXEONirv5hUwyDZLZazYVkX411MRAANXcv3dooeKp4V1qsc
Message-ID: <CABdmKX3rqcf-U7W7E+d79dM9H3VnwUjAH3Hv92MczMSmQauC3w@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Test that a drained dmabuf iterator
 keeps returning NULL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: k.chen@smail.nju.edu.cn, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, shuah@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	sumit.semwal@linaro.org, phasta@kernel.org, tj@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 1:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/11/26 20:59, T.J. Mercier wrote:
> > The BPF iterator docs in bpf_iterators.rst specify that the next
> > function of an open-coded iterator should keep returning NULL after it
> > has been returned once.
> >
> > Add a subtest that checks this for the dmabuf iterator. It drains an
> > iterator, calls bpf_iter_dmabuf_next() once more and checks that the
> > result is NULL. The dma-bufs the test creates keep the list from being
> > empty, so an iterator that starts over would return one of them.
> >
> > The existing open_coded subtest uses bpf_for_each(), which stops at the
> > first NULL and never calls next() on a drained iterator.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Let me know if you already have drm-misc commit rights.
>
> Regards,
> Christian.

Thanks! Still waiting but no rush.

> > ---
> > This depends on Kang Chen's fix and fails without it:
> > https://lore.kernel.org/bpf/20261110125106.2935677-1-k.chen@smail.nju.e=
du.cn/
> > Kang, feel free to carry it as 2/2 in your v2.
> >
> >  .../selftests/bpf/prog_tests/dmabuf_iter.c    | 19 +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/dmabuf_iter.c | 19 +++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/too=
ls/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > index 1a5dc1adae73..c1f81b5dccdc 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
> > @@ -265,6 +265,23 @@ static void subtest_dmabuf_iter_check_open_coded(s=
truct dmabuf_iter *skel, int m
> >       } while (bpf_map_get_next_key(map_fd, key, key));
> >  }
> >
> > +static void subtest_dmabuf_iter_check_next_after_drain(struct dmabuf_i=
ter *skel)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +     int err, fd;
> > +
> > +     fd =3D bpf_program__fd(skel->progs.iter_dmabuf_next_after_drain);
> > +
> > +     err =3D bpf_prog_test_run_opts(fd, &topts);
> > +     if (!ASSERT_OK(err, "test_run_opts err"))
> > +             return;
> > +     if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
> > +             return;
> > +
> > +     /* The test buffers exist, so a restarted iteration would find on=
e */
> > +     ASSERT_EQ(skel->data->next_after_drain, 0, "next_after_drain");
> > +}
> > +
> >  void test_dmabuf_iter(void)
> >  {
> >       struct dmabuf_iter *skel =3D NULL;
> > @@ -315,6 +332,8 @@ void test_dmabuf_iter(void)
> >       }
> >       if (test__start_subtest("open_coded"))
> >               subtest_dmabuf_iter_check_open_coded(skel, map_fd);
> > +     if (test__start_subtest("next_after_drain"))
> > +             subtest_dmabuf_iter_check_next_after_drain(skel);
> >
> >  destroy:
> >       destroy_test_buffers();
> > diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/te=
sting/selftests/bpf/progs/dmabuf_iter.c
> > index 9cbb7442646e..d5421b75c39c 100644
> > --- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> > +++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
> > @@ -99,3 +99,22 @@ int iter_dmabuf_for_each(const void *ctx)
> >
> >       return 0;
> >  }
> > +
> > +/* Result of a bpf_iter_dmabuf_next() call after the iterator was drai=
ned */
> > +__u64 next_after_drain =3D -1;
> > +
> > +SEC("syscall")
> > +int iter_dmabuf_next_after_drain(const void *ctx)
> > +{
> > +     struct bpf_iter_dmabuf it;
> > +
> > +     bpf_iter_dmabuf_new(&it);
> > +     while (bpf_iter_dmabuf_next(&it))
> > +             ;
> > +
> > +     /* Store the raw value; the verifier would remove a branch on it =
*/
> > +     next_after_drain =3D (__u64)bpf_iter_dmabuf_next(&it);
> > +     bpf_iter_dmabuf_destroy(&it);
> > +
> > +     return 0;
> > +}
>
