Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE282D2491
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774565267; cv=pass; b=rpqxG+ADrRWmPxGpzndsjonKM3ogXsFYfakZe06vzpV+kThAjfBtOtrOT2eyJN1wOjX+jsW79hiuFqtps0mU+Z3sMQP5BxGyitUFXB+b8k9E03HNN7xJ+Vb4pKRBnXXw7w9KLQbLrft5OJLWdrBJk+0L+qssWMPkxlH2cC30FTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774565267; c=relaxed/simple;
	bh=26f8AkXgyZdzSVQpRqlDpxEomjykHBwySjRfmZp3STo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7vUwROVEJ+UaO3/uDpgqkoTLlgpBq6xFsXeyQhZF8s9v2AkSgLTcaVJTpqotmU2BFnr+pWPebsGx14E48IAdKH4N/mH7RZIBLq1b/v1t1aKV60H/hy6g/q+W1rlAM4qs0lNnNy2OeFAOtGoUQGUQP/FD77y/6BXMwHjsKi8eHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We/oP21v; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We/oP21v"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c766a95a72dso1077250a12.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774565265; cv=none;
        d=google.com; s=arc-20240605;
        b=dKsTdoz+QdsVprTq+ZDIyGkIDBUXZDSOcd7QmxqupwP+93nnluw2bGxrfXMFrKy/lD
         l0lr2bpnWOSpRifbnl0TIy8M/ov1i8N+D4SaXdTYgAFZgcquGyNirHZzjPc3gVh9w40N
         s/KwNKNcitfZdF/hrPLdu0Oo96j02ztLYOw2P0v+o4euZVk2hr33wXw/HmEpDHKQQkuY
         /hhVXCSOEOgfEC7H38oElUPMnHmhhXPXCtrZLtEmLzm0+0cSrGYHxXV5i1ZwV3l2jCGM
         SUpMH3/7epYpwPcWoRVvOEJvdGoRnI7+b2ZF/M39bHO8iFLH4tt/JinS6j24GxNkKYuh
         RVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=glcnF+Zp3kCWJWXtXg3/2N0qCwuSW7czevMRqbPbgs8=;
        fh=CMKt418lNpu1zNx/8+qMH3mvDCmfIjFGi++/7hpTCJU=;
        b=jO1LefQs5tCe4fLWmi31d0GyAjxZQAgfds5P9D6bWpAOp5xREhAR+ObBJSPk2Zqn7s
         izCZ/owxWwnirJ2pxuaVyHJyh5pySFusHjm7YVc0lc286Y0m0fejnMmBpHGDLAGCbWCP
         QGfzplIg/VcHMlLjPSq1zvYYjW52E6sgczUol8rQKoK2GaOnJKJwD+A9UPrExeZfQV4c
         KYBQM0721VRkDZ5b+oI2hG1NHq1pd0K9NvaO+bEb1PrqfhU/UVNrDh0KiQxaerOSlg7D
         E5ejDuAF4vBtyhnTxLrwHnaZuS2PaeelkqE8G6U0tJRprexaQEQNIRzkL5Y5nbXUX1EN
         StEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774565265; x=1775170065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glcnF+Zp3kCWJWXtXg3/2N0qCwuSW7czevMRqbPbgs8=;
        b=We/oP21vQeiw5UftmTICmLfggZDBszNREOeGhLoyXpKt492xAa6HL7diEAqf27SNJX
         vwQ3Ne14bZYqFISlFuHrILEA4/hWyEkXNC4JulqMTSH9yKXXPjAda7UcvmB5n8qfasOC
         E5Y8jaBQ3V6/i+xVONKeXW7pCjS/k62WFVjGlalkVJtotPcpL7t71iw+ZpbEQqYp3v91
         fG8CW2tsZKFyr37K9jjEo+6xnY2nuHGRhYHcCUusKnEK+mIznQ2RhvjcI1FYy1DuEFlo
         +7HAZEMof5qiHYLVndRQ7O7DAWH/jki92ujvjAZ50x5AAv+d52IpBuAHue0H+F1JeUmq
         zIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774565265; x=1775170065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glcnF+Zp3kCWJWXtXg3/2N0qCwuSW7czevMRqbPbgs8=;
        b=OwvpaEqSJp7MDl78OirwEaiHa011LZ/f74HJDe3K6cPKvfQ08gqHKXeY4rloWAKCjo
         094lJ3GFjB3NeUru01uE6fPSDpEjNaozDswa7yBxatUOkTA9uHrcbbc7qaOndt3V74Gi
         4nhI7YS6hvYDNTF14zgDpShddFlXmdFQpIIMq/gY5RASwCfnK6IfqczRGyFLn0CbA4Ay
         flpKytzRPRbyzuYBJNv7uUtc0HLni8/AqKe/qV52QJI4HemlbdhWrQBFw3spcwBhhoqm
         Fx8WWXtqQGeUfEnZYmEs5U7yI9RPd3T8uo/wrP1sBifcNyGls2ubO6aZT2R5cYQRxwIG
         ohVA==
X-Gm-Message-State: AOJu0YwTeWfGPpDAA/2Y8rVnzGiT73fC6Bg8sifMShZ1r38ZbFzUwtKE
	0ks3POyoOYjRgC4VxrgC86xFNU7qhmrNSiRhhbXUmQkQN2asaVuQBV+728GIKmFNtfemwNAUqhV
	B2vrtz63HNCpUIbYywmBxQXRb1Fc/c5U=
X-Gm-Gg: ATEYQzx/eLjmwOq7SmhRjebK8y1NMAlc0/JJgfB1SP9R5Kvk4QylyBm4MGIkot9a1D8
	5jyjgSinIQ1SkX8DjLIQZY+Vyd7ae5FNgZqCM15lqy6nnYjYQhS1IoUEOQAvSN9RN2U8dNp7B3+
	CTnKbSdt2xM0BxCncbmBCN/o1Qi3xZju38LbNdMPF6xSpGKEWYEp6OZ0lNnnYRjyf9m33oZfAUh
	mB76wuBf4uVTOsHmcWrLDeoXJeWX5Gz/aIkH+Lzz0WjwwVXq5HAAXn48pR/269iviXPmSuDGUio
	vuacfKPmg1Ty1ySyt5PTxvU=
X-Received: by 2002:a05:6a20:3d0d:b0:39b:f9f5:7a66 with SMTP id
 adf61e73a8af0-39c87aa07f7mr354815637.33.1774565265378; Thu, 26 Mar 2026
 15:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-selftests-global-tags-ordering-v1-0-5dd2ced5d9ad@gmail.com>
 <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
In-Reply-To: <20260326-selftests-global-tags-ordering-v1-3-5dd2ced5d9ad@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 26 Mar 2026 15:47:33 -0700
X-Gm-Features: AQROBzD9gv3NmRuCRiJOTmz_3ihipjOZV2-j63dqePaB5hN8BEqHrWZ1iI5U9YE
Message-ID: <CAEf4BzaQqWprVN8RcvGvAEML7rGsGE+x37+RYRHADsGRNd4JXg@mail.gmail.com>
Subject: Re: [PATCH 3/4] selftests/bpf: impose global ordering for test decl_tags
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, cupertino.miranda@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:39=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Impose global ordering for all decl tags used by test_loader.c based
> tests (__success, __failure, __msg, etc):
> - change every tag to expand as
>   __attribute__((btf_decl_tag("comment:" XSTR(__COUNTER__) ...)))
> - change parse_test_spec() to collect all decl tags before
>   processing and sort them using strverscmp().
>
> The ordering is necessary for gcc-bpf.
> Neither GCC nor the C standard defines the order in which function
> attributes are consumed. While Clang tends to preserve definition order,
> GCC may process them out of sequence. This inconsistency causes BPF
> tests with multiple __msg entries to fail when compiled with GCC.
>
> Co-developed-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_misc.h |  60 ++++-----
>  tools/testing/selftests/bpf/test_loader.c    | 174 +++++++++++++++------=
------
>  2 files changed, 130 insertions(+), 104 deletions(-)

[...]

> -/* Matches a string of form '<pfx>[^=3D]=3D.*' and returns it's suffix.
> - * Used to parse btf_decl_tag values.
> - * Such values require unique prefix because compiler does not add
> - * same __attribute__((btf_decl_tag(...))) twice.
> - * Test suite uses two-component tags for such cases:
> - *
> - *   <pfx> __COUNTER__ '=3D'
> - *
> - * For example, two consecutive __msg tags '__msg("foo") __msg("foo")'
> - * would be encoded as:
> - *
> - *   [18] DECL_TAG 'comment:test_expect_msg=3D0=3Dfoo' type_id=3D15 comp=
onent_idx=3D-1
> - *   [19] DECL_TAG 'comment:test_expect_msg=3D1=3Dfoo' type_id=3D15 comp=
onent_idx=3D-1
> - *
> - * And the purpose of this function is to extract 'foo' from the above.
> +static const char *skip_decl_tag_pfx(const char *s)
> +{
> +       int n =3D 0;
> +
> +       if (sscanf(s, "comment:%*d:%n", &n) < 0 || !n)
> +               return s;
> +       return s + n;
> +}
> +
> +static void *realloc_or_free(void *ptr, size_t size)

but why?... why invent a new realloc usage pattern just to save two
lines of error handling code?

> +{
> +       void *new =3D realloc(ptr, size);
> +
> +       if (!new)
> +               free(ptr);
> +       return new;
> +}
> +
> +static int compare_decl_tags(const void *a, const void *b)
> +{
> +       return strverscmp(*(const char **)a, *(const char **)b);
> +}
> +

[...]
