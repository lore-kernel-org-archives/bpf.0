Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74952B1E8
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575912; cv=pass; b=IgBkfURhK/2Wi0vkpi/lL9yLKAsfP+RiKY95QU2djr4hl91L/rVjlH1U8narJArPxau+ADWUACXB+sZH9VwidVfh7UgpIAS1U9kG54wrON+v1g/SES0TI+qh7vTYKyRPigTaq2cHITVD1K1+Nzvq2VaDVHWF9a6qUkhXhJtSI/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575912; c=relaxed/simple;
	bh=Tfy5DSiHTM2ZgjvWMzhVCdG5j/zkio3GvqabXlNj/F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeAb62I5N/etCUFfE71HCrADbFVbKSujfJ7eTYqU2+XqDoHZU8sTdN2hsdIlLi5yyJqePZar/Dal10Dw9peMB3AunQedm3Ui6ChBBGlgzCUXVXZomFiFwUx1tXD5klk4xmm3ShTHwSUTWJgVF96LjbMMUgN2zzMJgjFk44UkaSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZekhNhp; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZekhNhp"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so850152a12.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789575899; cv=none;
        d=google.com; s=arc-20260327;
        b=oOQ0Ozx+5aoWt/Dqh7wwLipwRi4KiNu+nSPq6LInblYcQGvi7ykkmB39kkHUv3e6mD
         lomGbFXCAQY3iTgAaLB//B5bl4NVybyOhehDhnCrkhKIGbNAJD1G8WCLQa8iqkDyzfIC
         pVKwh6eGQeN1qdaj0ms23e575NgB4T3+HV+Azk1WwpzeQgjTu/52QCYwGk4xaqRpJkgP
         gEvgtcMUUALKbMjK4gRymmuYZcXKvm/4kTuONPglk6fGol1W16jSyTYfqHBC8xx8Vpm+
         wig772AffJ+odFsPs64vXufGEnaTj/2lVCbjeJGTtXgiRudc4GErwvs045u9dB1cOyK0
         3v2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        fh=HCWv/jPn0XIABV1rVTJzeFQ0+BL+YqZEykH2E4NtgCs=;
        b=Q+ckP9qPml6vZLJVUHsVjAD8GgvoclH46/Xm/E6ycaFTfe0VLwj99BgThxuzFnrHr/
         BxUc4xolaGkefCtnS0js1SzAkDP9Y2bpNZQBEP+ct4Lr41xmRJ6WX+kFJskN/zhEMDWC
         uFVVbDXsufF10YO8gtPzndBo5wWFV0fXaXUT31o1TLC4rASeWeATNjMhEiUjaEiCLOCg
         hKV4oHDQq+b+iSjNjSUrf9t+LgXHD6cL7LZOPfMEGWTy7HEY36AB9X6zod7pe2vbfU3r
         KcBDKgNAKuVqP2mZFgmteGDLaCYbfWGVd1kRIkbnwLdTUEtnnTyRy1tVDg4+izTVrfJ7
         z78Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789575899; x=1790180699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        b=bZekhNhpcg/1WhRHKG+Te+9vs6pKpnPaeYDWYjxmHME2wRqUKJwf+jbgpyIQk0f+6V
         O13fJ64qVUx0EbIwbu58oC0t+S3pdV9MTIHi1uM7QDpLJvzHlet/u3tlnO9/FgAuHkFh
         WQBPJoP8/NXvDcjpTh7jSeinHytvfkuVsSilIQSGdhzC2KUbYqJliGCs21YfYXqSqETO
         rk4Z7qavbTXqB03s39SBI4JfjdMg19KoHEWsWzptpKFTAEnE0Gt5Uy1Na+pOvclqT9gz
         q66MNxfH6dcaNjRIEoaniNrjEW7bksizf8f9c6V1JGBGPZLtsddsnaFpbNi/nmwiAOf1
         wJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575899; x=1790180699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8vXUt64r835ESBTJB/dxhUkslLOOIq8gAbMXJNheR4=;
        b=QIuN8YQJWdz3CD+tp/Urik4hj/uWprl+lUccAlGbxH/FdxiQCEfLYVcQejzghXu5V7
         deUCA0xJVffMXBV1WgDS/inEKUBJLHMQTN9tsBBUuSK8+jHa9X1FPefN+thCpAZxdUWU
         vu1POXom1ujEXg8Aml2iYrI5/sPsBLuYUxqTWrakmGMhWNtqRl/L3YguukFm7TYlOFtH
         W3DFQ8+8bbNeyw24gB27Bpvq/vAL0tWgGUAlnI3c1XKBFQYBL64ROwNuI+JeVZ3x3B7t
         oCZo83YtPhdsEiZ58ul1yGRmdzv2aXJJgKYu49j+CcbetTk9kkK3HPRmTVeukm1AIcNb
         scTA==
X-Forwarded-Encrypted: i=1; AKwUvBzD0W8Z7EZBtHp/Sk97TMtugZDI0I6ugB6IgO1qa/qb3cq8eAeree/6fBomOivbN1aVZPU=@vger.kernel.org
X-Gm-Message-State: AFuF++lY4xMFynx/jQCJjmIsKLp+AmzvcFY+ViPJCW7uMWdZ4ekGaO5C
	CWzBcuGTJZ4m488kuSfZnaakPq3kgiOkwx5qoLPPPIkvVHPqDt6afJ0p3gZssGJKxCaPYr85ZKn
	8UhrvtP2i1Jd6X9gj/QbdTMN4oI5E2g4=
X-Gm-Gg: AYBFou0koR+hzTRxaZPbxheOZ+F5sovlcOzAAqythI80l+FPLqHoW+u/Yqw38H2gYCD
	V7AEn9w9NHY2VEZNgcCk+cedHW/RoNVjGFNd7NPEp/hFc3Z9Sxp1xt6KKvXzQPd3DqAvU6Hah6Y
	Bq64Oo6Ce5WmIqe/zERo2kpyI3dozIaCHBvVqqTWR/eiax9ob6n/PsaClBmoHWAi5cqWcNxXZKc
	xVqnCRaW5mJKfC3SQBo/x3DVGQr5GaW3aE+d2UZa9rRKhABkvtyB8eC0AW53+ZVjtHEVXpw4laQ
	eOjlV5ktJLILwKcd6d3q4R+Ip/9scztyVOmCDKLp3GSl4rrU7p9NcboxKcZ+yQ9Z9wtlp1PvPWX
	3V40WKwzjsStU1e3JHUH5yvb26puwRn5KOJJj1zULke8+HfM5c/8JS12IWJyiuaq7FR01MUppg4
	QOHA5pXGx7dagN6ZoYbz6/aMVR7/0HBJ8=
X-Received: by 2002:a05:6a20:9c9b:b0:3d3:adbf:7781 with SMTP id
 adf61e73a8af0-3dd5f73f2fdmr9852912637.22.1789575898997; Wed, 16 Sep 2026
 09:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916112554.413933-1-madhav.khoslaa@gmail.com> <fe92569462dc4decf36f4dcb3b45372fc0d42fb6842eda0d3396fa18ee32aa55@mail.kernel.org>
In-Reply-To: <fe92569462dc4decf36f4dcb3b45372fc0d42fb6842eda0d3396fa18ee32aa55@mail.kernel.org>
From: Madhav Khosla <madhav.khoslaa@gmail.com>
Date: Wed, 16 Sep 2026 16:24:46 +0000
X-Gm-Features: AcwNN1U8QHUiHDV5g4tLvSfFw01ei7S3h8NzFnBoBxITmcE6o6f_L5XxCkZd1mI
Message-ID: <CAHFb0oABUaKNWVcNZwrxPv0MJU=3Jt1X+iv3fJX9RgO97uu4iQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] selftests/bpf: Fix csum_partial() dropping
 trailing byte on odd length
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexis.lothore@bootlin.com, eddyz87@gmail.com, ihor.solodrai@linux.dev, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> This isn't a bug, but would it be clearer to paste the full failure
> output or mark the elision? The summary line says six subtests failed
> (1/6 FAILED) while only the ipv6 one is shown, and test_progs.c runs
> three ASSERT_EQ calls per subtest ('test first port', 'test second port',
> 'test third port'), so 'test first port' would have failed too. And
> '1/0 PASSED' reports one passing test, which cannot come from a run whose
> only named test failed.

Not a bug. That log is the test failing on the TEST_PACKET_LEN=3D99 case
against the old (pre-fix) csum_partial(), not my patch. My change is
what makes the test catch it; it passes with the fix applied.

Madhav

On Wed, Sep 16, 2026 at 12:13=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/test=
ing/selftests/bpf/network_helpers.h
> > index 75133119c04a3..878c9fc5c37ca 100644
> > --- a/tools/testing/selftests/bpf/network_helpers.h
> > +++ b/tools/testing/selftests/bpf/network_helpers.h
> > @@ -129,12 +129,23 @@ static __u16 csum_fold(__u32 csum)
> >
> >  static __wsum csum_partial(const void *buf, int len, __wsum sum)
> >  {
> > -     __u16 *p =3D (__u16 *)buf;
> > +     const __u8 *p =3D buf;
> >       int num_u16 =3D len >> 1;
> >       int i;
> >
> >       for (i =3D 0; i < num_u16; i++)
> > -             sum +=3D p[i];
> > +             sum +=3D ((const __u16 *)p)[i];
> > +
> > +     /*
> > +      * RFC 1071: an odd-length buffer's trailing byte is paired with
> > +      * a zero pad byte to form the final 16-bit word.
> > +      */
> > +     if (len & 1) {
> > +             __u16 tail =3D 0;
> > +
> > +             __builtin_memcpy(&tail, p + len - 1, 1);
> > +             sum +=3D tail;
> > +     }
> >
> >       return sum;
> >  }
> > diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector_clas=
sification.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classi=
fication.c
> > index 80b153d3ddecf..421dfa6c4ea36 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificat=
ion.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector_classificat=
ion.c
> > @@ -27,7 +27,7 @@
> >  #define TEST_NAME_MAX_LEN (32 + SUBTEST_NAME_MAX_LEN)
> >  #define MAX_SOURCE_PORTS 3
> >  #define TEST_PACKETS_COUNT 10
> > -#define TEST_PACKET_LEN 100
> > +#define TEST_PACKET_LEN 99
> >  #define TEST_PACKET_PATTERN 'a'
> >  #define TEST_IPV4 "192.168.0.1/32"
> >  #define TEST_IPV6 "100::a/128"
>
> The commit message body includes:
>
> >     v1 -> v2:
> >     - comment style: opening /* on its own line, per BPF selftests styl=
e
> >     - Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
> >       ("selftests/bpf: move ip checksum helper to network helpers") mov=
ed
> >       the helper, but sizeof(iphdr) is always a multiple of 32 bit word=
s /
> >       4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
> >       was never reachable through build_ip_csum(). csum_partial() first
> >       gets called with a length that isn't guaranteed even in
> >       bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
> >     - TEST_PACKET_LEN 100 -> 99 so an existing test catches this instea=
d
> >       of the bug staying unexercised
>
> This isn't a bug, but could the 'v1 -> v2:' block move below the '---'
> line so it stays out of the committed changelog? Documentation/process/
> submitting-patches.rst asks for inter-version changelogs to go below the
> '---' separator so they are dropped when the patch is applied. The
> content itself is useful review material, especially the reasoning for
> retargeting the Fixes tag.
>
> The commit message also includes this test failure excerpt:
>
> >     Without the fix and with TEST_PACKET_LEN=3D99, flow_dissector_class=
ification
> >     fails under vmtest.sh:
> >
> >         test_flow_dissector_classification:FAIL:test third port unexpec=
ted
> >         test third port: actual 0 !=3D expected 10
> >         #137/6   flow_dissector_classification/ipv6:FAIL
> >         #137     flow_dissector_classification:FAIL
> >         Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED
>
> This isn't a bug, but would it be clearer to paste the full failure
> output or mark the elision? The summary line says six subtests failed
> (1/6 FAILED) while only the ipv6 one is shown, and test_progs.c runs
> three ASSERT_EQ calls per subtest ('test first port', 'test second port',
> 'test third port'), so 'test first port' would have failed too. And
> '1/0 PASSED' reports one passing test, which cannot come from a run whose
> only named test failed.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/350910=
50280
