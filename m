Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030A2F6918
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607209; cv=pass; b=kwRs/G1IIuMUIoA15pZq4QM6lDIvyvBV8ONBZgVKT0sIF6UIj43gOH4VgXHQDAOlb/i7uYrVpITJ6fYxhoajvtbudgOUKT7jvffRjRWw/6aEmzu3unOn+ePx9EpBajVH10hdg38Cf/J2InN89/AoFwYwYMcOioZ91EBLa0PQp9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607209; c=relaxed/simple;
	bh=UfmsZp708Ijy54fCK/57bC1uRgIZdRWU2UrdakwbYmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EESe3pdMfHnRPK5t7rPaPY7CbLQ5m4rOPRAPtaMjXncsMHJc7J/WkedwaFWpDDYVHgymw6dHvgQowmMwuXDu48AErfc7UL2OS6oXzxLDncIpRtRykiYSsVUioObpuN145ysO7+16Cr2KDy63A9kMy6WUMPxCQ8+7c3+aFIOZY1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9Ja+iYr; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9Ja+iYr"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so92431cf.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 18:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789607206; cv=none;
        d=google.com; s=arc-20260327;
        b=l6xwMB5ZOGxrJm3KspEGz8GXChvrzsy4um6MxP6sLhMoLE14ZCrW6HFqmrdkTD0j0Y
         ahogI5PxUtZzSG1oifAm+pmXJhFA38zhCoIHOV2BCBGjrSN7FyA/+duzWJ/g3NO9dacO
         ejFhokbpxteSqh9NhDfFkENG3XgXNiuLJYD79hgNDtP9zqd5Ced4Rs4p8eSbuSfFR7Na
         ke7TbCEtCvlHXTimclbmYGQ2ZXpCR3EdafRo/Cr1XtxlOA36FLARIRHd8+enBmW2aVdn
         ULn3em6XYiBZqEHUfPYFZM9Y5nCMqlayVZfODMBwFlv9Z/kCm3bhxQ4/rG8cp67GEWMf
         AeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVqnTRvwlJyUC6eESGjXw1fA+M9qex3i/sfxeqTQDo8=;
        fh=XnYMtGByDPltuUvkw7rL9pd7w23RVAdI0vgPJEbt/6Q=;
        b=DlzVS/vvCt6IGmxCd/NNtmfBQa9AsIFzdMVQw7p27xlty0Q7gWXEn3kLQGRKg5kYIe
         zJrPDPMG9yEXuwUgWlPtkbNNuWLEBvN1ST8rgyFB795QhRHE6J7dDzjwxQjHAG4BGCu9
         SuUxzedx3rtpzYrkjJg7CrlbqXoYGA+M7ziyK/L27H109KBacMEeSai9bb5yynlB4PXg
         mCu9VFsWiN6vitFBkw0vQtBWg8x4cOI0F+AYABBFF+3FvVJd2n9WH5er9mwL7jk2Wu7l
         U5omXJ1BSeXdXNbX/5YLTNJvpC+Q6LT4Y1o7vtQa//dOYVga/StrRaMqUGhwwr7KNw15
         Nxug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789607206; x=1790212006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVqnTRvwlJyUC6eESGjXw1fA+M9qex3i/sfxeqTQDo8=;
        b=i9Ja+iYrTGq5fF4BO36dSNnLpRptWxPGLH6SXtT7gj+Cw5YBVAlrObueq2Bt18qX2/
         9XQHZ1nQ7pWh9tvDWO8OhlDb13n2yZ7NIBqOJ/JC6/62WMsCRYPXJhUr1jBEkm6cMRAh
         6uloYJIwr8CJe+FdYE1ADVB2eOnY34mx6LPXcrj0DbK+hggtBMydfwKXvmQJwyHRj0fX
         Ud6UFw0+aP7pEp8vRYK8qvaC4snzE+wXA7X07QqrwAqZkGdIYECW9/qoE9PkACD4LKsd
         RSSj8bydQIEUE9qworxEVBDOMpCmqhckOTbsou8+v+/exJQH71VoMW6+QhY/e6DePVgQ
         nVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789607206; x=1790212006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVqnTRvwlJyUC6eESGjXw1fA+M9qex3i/sfxeqTQDo8=;
        b=tuLWThEsoQki8y07czpfoP3augRbCvZ0WXf4+HSyEzcYBNsQxApGgcqm72c2YffHNR
         7YmFWcFrnUW+TURL3yUnkUqy2/K/BPq2sXCS9smTdnf9rJDo5EkDEg1CBQmArDN8g8sC
         U3Sjlul71TaTiGts10+2QQIow9T82/NWHB5TMbzvZPGjXGzCtgAJYIJjOvjUh4zsYBgP
         U7bbDMmhTHR2fIg9rxGDVngFaFYMLIAFIvEPuvlQIIj8FJbizye9qPIZukn7MwXb1fD7
         fuaToCnmQzw6rzkVywmfN/AalmQGyS0P3RjPo09c361AhMFQJZtUzl2jo4/68ueD7xsf
         PEUA==
X-Forwarded-Encrypted: i=1; AKwUvByPHmbVUB6Xcz5em2J21ZZabdT1aUKEqLTdFgLcoGx431nYEZOXIN6T/Kt6jx+BK4ibTWc=@vger.kernel.org
X-Gm-Message-State: AFuF++kGpGPSXHT1U5wkZpiFdYhgXBSpd+TTYlpq7O+Se5UhFW4nu5C3
	CTai8gIDSLSDNIRqym7Yeqa1sH3ZBgfZYgmZxuU5tz3ZQI3KQo9NfRAP8b3dyBziKTwh/Xi34eX
	5hzwMEXpvEEYaRfkFpx43wUOyTDzr2ae3Il1p149n
X-Gm-Gg: AYBFou1/9UhniYFvpOQDmjLH6sImTSZWODOEgyorSsNTf1uXmQgAa1rpDBd1Bwx+5si
	jxc0AiihMh/gSJRxI3FV8uxl9C5ZyF2lqsT3xt2eNsS0S1fWohV7ND8PuECotjBWtKTOyRNH4YS
	zSAwlfJPBcR0CXnaqj04tMtahJ3Wru0R76btlcU3kf/0GqeMOgqSmDzf0LAxv9Eh3usFvBUBx2B
	lMKjlURPNFieSDm/H+oep2buoGJXfcMqFE0eWilQks8slwRJcPQ3rYODxcGXm2OpjdIGzTedbHd
	TCJJI6zcob8gB5sLNmDfZWDHG/YNLsksCNm3k0b4Z9SxsRqHOHmqIiWtIZGzPH9RM+6yrTLAWHT
	XHN6FML5+F4vEoNZ+sXSTygjYGhqelSy4gAQIy/Q=
X-Received: by 2002:a05:622a:997:b0:531:2284:4b09 with SMTP id
 d75a77b69052e-5328f60023bmr5751171cf.11.1789607205250; Wed, 16 Sep 2026
 18:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909042433.1775591-1-tweek@google.com> <20260909042433.1775591-3-tweek@google.com>
 <424ef244-f0e0-46e7-bc27-fffee80f348d@linux.dev>
In-Reply-To: <424ef244-f0e0-46e7-bc27-fffee80f348d@linux.dev>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Thu, 17 Sep 2026 11:06:27 +1000
X-Gm-Features: AcwNN1UtZ3hvthqV8zrZe_2I0a-BHp5mZjUvG6bkreK5qsDS51UGzgeJ9gYHVWk
Message-ID: <CA+zpnLeRmo3RTAxmMUHepm+kmpG4nw+z_vhR_kNubqEEEAVxbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Verify program FD after
 non-autoload programs in lskel
To: Leon Hwang <leon.hwang@linux.dev>, Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:49=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 9/9/26 12:24, Thi=C3=A9baud Weksteen wrote:
> > In test_global_percpu_data.c, dump_percpu_data is defined after two
> > non-autoload SEC("?kprobe") programs (verifier_strncmp and
> > verifier_snprintf). Verify in test_global_percpu_data_lskel() that
> > lskel->progs.dump_percpu_data.prog_fd is properly populated (> 0) when
> > loaded via the light skeleton.
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > ---
> > No changes since v1.
>
> The Fixes tags of v1 are dropped.
>
> >
> >  tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c =
b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > index 7c539cbcf3a1..ebda60200b71 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> > @@ -214,6 +214,8 @@ static void test_global_percpu_data_lskel(void)
> >       lskel =3D test_global_percpu_data_lskel__open_and_load();
> >       if (!ASSERT_OK_PTR(lskel, "test_global_percpu_data_lskel__open_an=
d_load"))
> >               goto out;
> > +     if (!ASSERT_GT(lskel->progs.dump_percpu_data.prog_fd, 0, "dump_pe=
rcpu_data.prog_fd"))
> > +             goto out;
>
> When the light skeleton does not skip the non-autoload progs,
> lskel->progs.dump_percpu_data.prog_fd is 0, actually.
>
> But, theoretically, this ASSERT_GT() is not good enough to prove the FD
> is the correct FD of dump_percpu_data prog.
>
> How about running the iter subtest against the lskel? Factor out
> test_global_percpu_data_iter_fd() helper first. Then, add an iter
> subtest using lskel.
> When factoring out test_global_percpu_data_iter_fd() helper, pls change
> 'do { } while (0);' to '{ /* no-op */ }' btw.
>

Thanks for the review Leon. That sounds good, I can implement these
changes. I am just waiting for Quentin's feedback on the first patch
in this series before spinning up a new patch set.
