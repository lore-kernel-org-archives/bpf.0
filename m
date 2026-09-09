Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7B3264EA
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928706; cv=pass; b=FwCiiZUSC6Fe7TJrGXLeWQCEuQTglrDIEHGBI1cY8bF2DtMQEqdX8bw9UypCRpUkVWU+Z1/nArBX4gdw498hkFcYRGe5s5VOvoGP/LlkRfFAPHl+6cwL2Y+dScsZuFDqxf5JIXlscDCMRJTzJ14mGJDh3ZOh4NRdbsy5svmPfmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928706; c=relaxed/simple;
	bh=/+3eKYYz03dUBjHcHqHQIQKyut0iHUO9Sr1nrn4fiWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qORGfZch3ZRYLdGuHVPa93py/KSaBqbgmxMNX9hoKLdupbKHc+slfMMxZmEU7CF0ZyGyUsRHsgijzCneAPKzquQpjloty6YEeV2M+XvMGb708rcJ7zsrLyV/mCEf2eZW7svG64A2d5EUgGXgt9/ehBKPffoqmpkyC0MaKkIeUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=G+slYNMJ; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="G+slYNMJ"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-87ffa98d4a9so2469577b3.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 21:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788928703; cv=none;
        d=google.com; s=arc-20260327;
        b=p1HT3KrBJt8pOBYlCSbUPn+8JAEP2nJbEOxC4vYluY1eI6OQwW+W9r9zkE4mzyXFph
         EAfYMe6f1hxARtsyVCDU394Xb+zqZGoNt9DfU6zxsYmxRznsrbHiNcXpyv29jr2qqsRH
         nByLCQpmP2LRnT/xT4pqcnbUC4ci9kH2Dn7zTRe3dvULnWPMY+zY09S0rmWM3NMxl1Ao
         RNZe/SK6NgG6Jrg8D01gcKe/RS4P/AFDkFwvMjLq+e/tIS7eHs55cqCqqUgHtuGDnnAz
         m2yK64i3skyiG6H0o/l96vrWLmCnEic6Xv285TMtfioID4OLhn6LaetsNj96UW+jqMdG
         bwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Teu6cC+d3LHtdtN3ePnM4eTc17lML+xatDJgJtdz0Ns=;
        fh=dD/tw4Drl7/qsMm0h4NNrnxrpYFNDaCSlGEg99R7lA8=;
        b=hZ1FhZdpyYl5BPOlqhlJcD2I6HegtGvvZbpoC7JgKHf1UmUKNavpm41EC9/RwvodY3
         NhWU+YNmunwuxuf1LgCcujeLsE2mFSAJsUcG8diB4H47SkCctDZI3b052lAU+EkFsUwX
         Nk0m/PO34r3JaYIWjKglaRCI2ZI79NcBMoXDN/YDIgOQqculSjzk9781gkS0Q8uEqthk
         DdHrzD0VEl7tzqFy9RQfwKp2J7jzUwlBQHMteyPBGNEwaG/guySTtwMadp60uG2B2n2y
         mvO6RNB6mo4MZ3Uj8ZR1KgVcUL5PDc+C7Zja1PwcH0/jEivshd5rhkOFZausewro4Ozq
         UcDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788928703; x=1789533503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Teu6cC+d3LHtdtN3ePnM4eTc17lML+xatDJgJtdz0Ns=;
        b=G+slYNMJ4NeYNov1rDcn3MJkqULMh4eAK7gcukOQB6HThKx6bB05QZKrqxMyyNZDg6
         qQ7nlvJQp27dtcDujIxhQMxrNeKZLOKfUDGMeyKDpOoKLk+ad9bSIcI6ezlT7yHqihsk
         h0Z9SjcyRDJfbVk7Jgx28PATGsWAs51SmRg95r0crWFucxkJW8J1+uEaU+5sr50mvVGO
         BJnLvXTi9B1YqaxczK7sUZF1nJGRAh8x7jTDRAi4DLB9+sOju+Vx8XMcD7aVlcEZE98h
         u+qKtDkafzy077tmVLUxRqtWLbgCF/FbzhwTCAH6OaWKd9dYs3x7OqEmuwpwC+Df3YPo
         UjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788928703; x=1789533503;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Teu6cC+d3LHtdtN3ePnM4eTc17lML+xatDJgJtdz0Ns=;
        b=KyQBvi29As5kUTXpuG5ea8cf2KfPeEomwVmx0qfOyaKsKNMrf16+dPoqbp7n8RWYCC
         ruEmPc4f6dXGkQrqsdTnX0rYLC4liiVnhIT+lPyZBf01p1hhirK14cOs3mW8Hss6qQns
         mSbZ90GMzCWlP9oVs8CvYGlagUjjtvdGIp0ghM/sWtjgbEvjVrbESxMdPzHExPw2aYtL
         bJJqJWi0WTgGFB93/qMrFpqnUb5D73i9+A+Z5orI7afU+qaNRCxYTaQYI+07bUC69iq8
         4yKM9/cDqAjFR6GlgVyN5KaUIMhC26UaHyYrhuZoc5Ai/HcEvZ59eRpDaQEzhULSrvmb
         MP3A==
X-Forwarded-Encrypted: i=1; AKwUvBzfSVakVmDUSuvuXSjkNAekJUjGcb/NqRdvjA83cPMScvjv5/thW9aSefHp9yDsEbwn8k8=@vger.kernel.org
X-Gm-Message-State: AFuF++lCTCwLLtAkM6yyDN0+blJ4d6oe8VsMQmm9ks8KmplyWLAvQHKy
	N1UEts8/+NtoeUFobRcnxaa/DdPT9w+V+NCPMln50rpIGapXnUnEZ2MAiRykaSTj932/BIEIDUT
	cJxTrH7dtlGOF6rPmr4s+sNsHde4a7bJRe6izCUhjpw==
X-Gm-Gg: AYBFou2Icb3lpaKYKd/M/eQVYEmuLmvFY8zMPU9zlHQeq4l1TwjXWf8CszeuMkFuz+w
	3QEobaz5u65xN6z1bm/XxHgCCCBXqOc82U4vq1ElimTBI6wtLBEf4K4tEpwtJgxiuT+Vc4KO5at
	1jvrQpBgAxSt+bYNpDf8MFq7tM3yqan83tEpdxAgX7RTIS07cUnEIOyeMF/ornsZYqrjexgsrLi
	nkrsQMu++WznxwW8hhNtL8mu7SDVF0UggSUn/IpFs1Bff5WXj8f0fhSEc0nTi+qjOYNKNmjIFN7
	iX21KCFiRkvEdyqX+ruLDRC1c9qw4zZs5rx8klPtIgWyHZ1a4YPQHqU=
X-Received: by 2002:a05:690c:e3e9:b0:870:820e:da66 with SMTP id
 00721157ae682-87127d2ca36mr124113977b3.23.1788928703258; Tue, 08 Sep 2026
 21:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903150351.12725-1-colin.i.king@gmail.com>
In-Reply-To: <20260903150351.12725-1-colin.i.king@gmail.com>
From: Emil Tsalapatis <emil@etsalapatis.com>
Date: Wed, 9 Sep 2026 00:38:11 -0400
X-Gm-Features: AcwNN1WAFyR_AVCv1IXGTjGY0PGid8q5kgFayEO3Y82fm5jIlHk6g71DHjJvDXg
Message-ID: <CABFh=a7YTi2U2-cx4b5zejWv6MXE-VG-u7K410pPbtJiw6qbWQ@mail.gmail.com>
Subject: Re: [PATCH][next] selftests/bpf: test_xsk: Fix spelling mistake
 "conigure" -> "configure"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 11:05=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There is a spelling mistake in an assert message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing=
/selftests/bpf/prog_tests/xsk.c
> index 6e2f63ee2a6c..772f3dd7ce64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
> @@ -75,7 +75,7 @@ static void test_xsk(const struct test_spec *test_to_ru=
n, enum test_mode mode)
>         if (!ASSERT_OK_PTR(ifobj_rx, "create ifobj_rx"))
>                 goto delete_tx;
>
> -       if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "conigure ifo=
bj"))
> +       if (!ASSERT_OK(configure_ifobj(ifobj_tx, ifobj_rx), "configure if=
obj"))
>                 goto delete_rx;
>
>         ret =3D get_hw_ring_size(ifobj_tx->ifname, &ifobj_tx->ring);
> --
> 2.55.0
>
