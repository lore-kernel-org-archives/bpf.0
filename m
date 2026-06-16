Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315232C302
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 23:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781652937; cv=none; b=B28ZFxUgncVWSY9D6hBxkipCgKZFsqYA2vs4uRbEBacZTvYQZbnmnljUHdtqk93DwG8Gz3kNIEfIpHbufDOAV8bxub1lzw8igFtKq30dfaex+wd41igpQwuLvmKVOtrJ3jwS5jPqUBC6KjI0URCQuPpgbaLut9cARmpYO15ph/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781652937; c=relaxed/simple;
	bh=KZOvQxZy50gYPFxhnZu9XcEiN2jcIv3rhRYvhuCs4wQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RaHiBehRVDFwwyBhQhvPNnhhrzJm//dmWTEOfFf8pm1+kFoiMPU1aMqZZ0GJc5Eb+wGP7evptsQgxAMIGk9RbYrxqW/1xSuC+XONxjkhoL8KtajmlqZzUVBNDT0O/0GphB7Vs+DDx9821Ae2HzH9MvNaK1p1P7tp6KpYYU6M1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=KDrL1dqB; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="KDrL1dqB"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30bcf74e617so405445eec.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 16:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781652935; x=1782257735; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO9GhEB0RqsfMRIU+s/5rIJn5IBIFCGVZh4WwNHq168=;
        b=KDrL1dqBA3cjXyXgKs5S05ggxGGWMFFIzx0UwKX37fAXq28Jo7e9nAR1+lYOu+ghBP
         akTUBT1SeMpD2UhxUUUhU6YgPluJPhYeHmIaxD+ac92OnIisEbTVaC8qpUMCgoOPuoq9
         z70eQg5mcrvB0RoU4fGv4tLsPaNAiNrX23DycUv/mUjWsoYVgPIF9YIm10Ty132rQxSd
         u3vW3xtXzQA6i+khuA3/1CnuTMix+Nx65WmAa3S7FO63LxcM6WgQyRBFXzj14T3y0/Nc
         RZ+5rjKlEDhp3qyxIjC2CvFJ8I2beR3drp/FdtOiBX09ie6j/BlCjlhnCuLAzA/+4sPy
         M6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781652935; x=1782257735;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GO9GhEB0RqsfMRIU+s/5rIJn5IBIFCGVZh4WwNHq168=;
        b=oZJswpsrN3GJd+RNMzcFYYY/7O/QIxcv/Eei+CE1CcG2TsSpswQ8T8yg+dbnYOqmIl
         0fvNSj8O0nx30FGPFwf77sonlOKcXj1fJXetLoFjOeK0IsD2v4ecKihppelasigY5COo
         WJ9SzPuirVvPKMR65WwzoH3MWGN6dZqu0MYzlVmqq6HDCimrY/Pfqf1b0ylSneP3Euzz
         hHozC8RkwAZ/Rnru4DJV/h/zRiwmv9Lkxltv2BS6H14jNhkZTtnKLsrFFloVmSpfGif0
         7iKw5Hjjpye239ZvtjL2mooF3cwMPA96cOcZZ1UM4QZTPkXSOyDAmQdrxLIXTIs1vaqq
         UFXA==
X-Forwarded-Encrypted: i=1; AFNElJ+3Z+qqqWUag+ZwiG2w22hBfTd8KL34pfKRycm2cKwVng5C0YGXLnRYDlP+lOphvpPAQlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe29cMBXGBLc0BeHN2KhobhR2mVHsrzOgrBjKHDT1tA0SNZwVt
	0L06NPuHaoOQom996vwWAJDxK3kH6w129CZyC7rUBLZWQESmKVPjWdtBtWJhkRMDjUg=
X-Gm-Gg: AfdE7cmgmo3f4fgwdrt1b+0T/krt5Z/S/P5UiX8azfI9LttxPUXluTZOrP63Y7XvnxY
	KdatJHwmm6OlEiodZEgDtOe6+8fk7zkIVvnUTv0LDJfVa9nN3BVJhP5tpks0VpTJhirdDKNjdg5
	UaeIQBpalhYNuMHbuLKg3Ey9RJNXjyBgfhaR1lOrYMIL5m9UyDS3dolrUxMcyBrvzICh4pkCaJZ
	eXVJ0IhXrzFASD58cKzr7KmnOjCPsITExGL1Ct7Mm+e0sG1SdgQHPhrYwP0kfrURJ63TXbG1dLk
	ntNXn0hnWVNEoQwkSb7ckhGVc6zYqLP15Huf8Br8aNzbftYPNLNA0gFsZe1L9+08eOQjz+P0QeD
	kGP39Qhxu73X6LPNemUTS6bEvAzrIa+UOv9AaBLGVrO962zDk1P6+Wh8ytSNOl0F8xxDABTKkl9
	uk1wTN
X-Received: by 2002:a05:7300:d516:b0:304:d8cb:841a with SMTP id 5a478bee46e88-30bc9efb228mr917030eec.14.1781652934917;
        Tue, 16 Jun 2026 16:35:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1a8e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bc1e2bd13sm2341882eec.2.2026.06.16.16.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 16:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 19:35:32 -0400
Message-Id: <DJAV95U1GCBI.1LKNKIW9SW740@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>
Cc: <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>,
 <bpf@vger.kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <songliubraving@fb.com>,
 "Yonghong Song" <yhs@fb.com>
Subject: Re: [PATCH bpf] bpf: Add missing access_ok call to copy_user_syms
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260616083056.405652-1-jolsa@kernel.org>
In-Reply-To: <20260616083056.405652-1-jolsa@kernel.org>

On Tue Jun 16, 2026 at 4:30 AM EDT, Jiri Olsa wrote:
> As reported by sashiko we use __get_user without prior access_ok call on =
the
> user space pointer. Adding the missing call for the whole pointer array.
>
> Plus removing the err check in the error path, because it's not needed an=
d
> also we can return -ENOMEM directly from the first kvmalloc_array fail pa=
th.
>
> Cc: stable@vger.kernel.org
> [1] https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kernel.o=
rg/
> Fixes: 0236fec57a15 ("bpf: Resolve symbols with ftrace_lookup_symbols for=
 kprobe multi link")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/bpf/20260611115503.AC16D1F00893@smtp.kern=
el.org/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/trace/bpf_trace.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 82f8feea6931..75495a5c3507 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2376,9 +2376,12 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	int err =3D -ENOMEM;
>  	unsigned int i;
> =20
> +	if (!access_ok(usyms, cnt * sizeof(*usyms)))
> +		return -EFAULT;
> +
>  	syms =3D kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
>  	if (!syms)
> -		goto error;
> +		return -ENOMEM;
> =20
>  	buf =3D kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
>  	if (!buf)
> @@ -2403,10 +2406,8 @@ static int copy_user_syms(struct user_syms *us, un=
signed long __user *usyms, u32
>  	return 0;
> =20
>  error:
> -	if (err) {
> -		kvfree(syms);
> -		kvfree(buf);
> -	}
> +	kvfree(syms);
> +	kvfree(buf);
>  	return err;
>  }
> =20

