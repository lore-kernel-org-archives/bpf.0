Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695844CAE0
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530494; cv=pass; b=a9cBUp8HXuux88F3QfFXwDsmAQvRJfmy2qhodyoNMut6u85waF1x40Go7dEtbUc3ug9UXRCCIoYt6YlVOTZlzAAwcYcaOMjSiKoBks9ilzowEdaJlT0NARZqeHoYFxsmHF0WkxyVmL/XuXRzYfPJGXRuByd5v7OZypEs9v335QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530494; c=relaxed/simple;
	bh=6Z9vStdVoY+sm0vZkxTWbl1FRA0xSzco601c//yjuzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBvXTnkH48cBrJotD3ljqz6jEoIMdNhv66drg4qH7ax3FNCByqPsszdllw7BgM8L2umqv5s1Hsv+IinikUFeKOpDMPjT1RYavIuPz+9Jre01rO+b/ih/9mKWyDFDStwmw8bIpHBqKfZfOume/a4We/KHF0hteYZ4kKH37DS/PLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xir5PNzL; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xir5PNzL"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bed2195323cso11300266b.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 16:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780530491; cv=none;
        d=google.com; s=arc-20240605;
        b=i/2A/Pj0lriHSyY2hTgkjyyO1GK3dOCZPsFDT4QrUzQB8Ko97D9RqRNKdRcvoK757W
         5e2WIPcbmnjUkAMa2xeXdJn85ppAmPTZlfga/pIvGfmwOfMZ/LUvIg9A5/lgQ0B0FZl3
         gygz4beKcV8GEGLV6hveUBteVxILqDi/boGadLQB6KkUohJipFNdcHe27/TzM0tUmFbx
         RWFbQDng4bdEUD+N3HWUUFCFl9mzMUDoai1HELqiLCVseyYPkKEbXgziqMjCz2oeYNEZ
         J5nN4FXqZJ+KQ3IJdmwrOoHrJBwmo6+/eRHyYwUstDzmgioINtFiWALoukfB/V1l/Sll
         l6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TUBXpiUq5JEecRy7kmi+oWzZmqqtKmb4nW09LCQY1iQ=;
        fh=smiRmoxkrffsAxU2yNVtJW3gLs0fG45qsKiW0qmeN3A=;
        b=KjeE/amjwzQwtoQqqfOx2qpMORB5dnS3VgF4Cg+fU3PnWJnrYiVajJI5kVT/IEe4Dn
         UQjMfpQFZAw6CXRzVANbwP/VfRoaze+VgpsrWU4DOl2bQqS9EU/U76l0BpElTE7fMN9Y
         bkk//TbpScReR7py63mE2jNQWcLITe7lfUBx0Mdv7bHjzUaioG0MGejteKHHkJqLbxz5
         0sqMjh9XsC21O+2pKGclHtlaZjBW/ApxfGOdSgCuMXq1Nl0MWAluBis5dV44curgiJtH
         VHykGXI3tZoWuk/hbcB+0FDZpIJoPj+Pb5MTR753mg1yJ5ZsKLTropbsoAs2HcJGiHnz
         wOOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780530491; x=1781135291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUBXpiUq5JEecRy7kmi+oWzZmqqtKmb4nW09LCQY1iQ=;
        b=Xir5PNzL/W2qkce0U9Hvd8W/1a8MFGpExNIb4hwPRG3IBhPW/aTKFQbwGOyXeXy1J4
         YRMTA7PE/u6HtD6qODk5nI/MfG72qv1NLW3DWBYLQy6GSOpGIEYxle6VPkXcKuiG8PeZ
         wgiIs7ZRl5b7YS6Ok9tgVVHjdP1T9JSlQrWNOdpkPBjS4XEqFM2+D4UeTLf9czhAmfYK
         XbVuNKFPHC+MavYzsFL+yAoDD1fgg6aVdQUkeR6/cJXwq8RYpsVezPxVrzEA69tQnofw
         sr1FDsMmXJvNX/G1xnV5M4CIx5+MhwN0bMDkPklkgKk2c6QGP91cvkmIfqcRI6UqZ6Aq
         sAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780530491; x=1781135291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUBXpiUq5JEecRy7kmi+oWzZmqqtKmb4nW09LCQY1iQ=;
        b=kCYSRMlphhDzBTMLvXvjItTvBCz6YdhWmyj5Q0PitbLAZcIbDv4fbWZlcy1zj9FjA8
         tUxEAnLE9tsAU8B4RCGTnfoeJwXrKnTcqPgTAz8UTJ3PZYCxFWDV3X+V5wFTCHT4XaR4
         sHFky6CeHbZV6SdsUqNhFsJoXM8sQXX32JAlpEchX0NknuHlPiazac7ClUQbMve/eW8E
         tKrWoDFwDIhDy0dea/IW+0m91WYP16URmc75aozkRC2XW0GI96YmixLozWISVnEqhDG5
         a+9K11GmFOsIvK09Cik/OScF2DbKMcQH8WiNrTnaXdJFT75afeUmP0w+cDHfuZ/3/GkJ
         pIqw==
X-Forwarded-Encrypted: i=1; AFNElJ+uhUuoMR7tkr1J3NLkx/HhRmYOJJXIUCSJtAmo8LsQiXbgdMgnvzStFk9QfdiN2eALoBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww4Pl/YO/IUg9+SU038p95hrAl6xQKfGaR1J/mtkr/oJHs27kk
	LwqJ2da4N2wkR+keBMTTOtZ1cgQwIDI2lI/zCvgCSU2RzGOM8JzXQQD5K8neYgaQFOO8qS7ewDF
	n/IsygZFJcnXL7wKdGpFfOGDmluSqUfA=
X-Gm-Gg: Acq92OFX7kHciZAA/cR7ZxB7ICYkplCFJ1z/MQgf2IwyYdYD9vft6J7Sc6VJjDEPnDL
	e/A/oBHwcOBIO/qxHLPHooE4Dw2tHlg5VWaM0Fqi9uDY2u4VrUSVPptZ6T4Jt1vmwOVSzIlKB8A
	QrTxeZNB/5N5MSrL95k3lfECsiFhMbV6raNNFsLmWNgB8cG3pbnpMInthJVqGrYnVhD6NS3Z322
	Go/1qA3Sl6WC9GBJdAt68ohJbDSHJq/Q7e553wYGgM07suqAN+jX5JOHLt7GARIJACXVOYzWwld
	4EVzrtTUI4PgptQJss0UzCV5WtNaydLfpQw2C3jqwdpwws8uJQ1mPqD90sRVF5P0+xv0319D40o
	=
X-Received: by 2002:a17:906:7955:b0:bec:d077:c4dd with SMTP id
 a640c23a62f3a-bf0ae9fb19fmr282699166b.32.1780530491132; Wed, 03 Jun 2026
 16:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601221805.821394-1-ihor.solodrai@linux.dev> <20260601221805.821394-11-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-11-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 16:47:54 -0700
X-Gm-Features: AVHnY4JQct_cFDvrD2wM-9U7CrdDqWa-_ugyrfOX9dhEe2b_w71d_thBOQIEue8
Message-ID: <CAEf4Bzb2=RvOv_geBt9T0fBvgT23V1NBEgqmG+L+v2nP-0cpYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/14] selftests/bpf: Verify bpf_fastcall decl
 tags in resolve_btfids test
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:19=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Extend test_resolve_btfids() to assert that resolve_btfids emits a
> BTF_KIND_DECL_TAG of name "bpf_fastcall" for each kfunc marked with
> KF_FASTCALL flag.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/prog_tests/resolve_btfids.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/to=
ols/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 7d9c3460cbed..eeda4e3b6a7f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> @@ -246,6 +246,13 @@ void test_resolve_btfids(void)
>                                              kfunc_symbols[i].id),
>                             kfunc_symbols[i].name);
>
> +       /* Check resolve_btfids emitted bpf_fastcall decl_tag for fastcal=
l kfuncs */
> +       for (i =3D 0; i < ARRAY_SIZE(kfunc_symbols); i++)
> +               if (kfunc_symbols[i].flags & KF_FASTCALL)
> +                       ASSERT_TRUE(btf_has_decl_tag(btf, "bpf_fastcall",
> +                                                    kfunc_symbols[i].id)=
,
> +                                   kfunc_symbols[i].name);
> +

{}

>  out:
>         btf__free(btf);
>  }
> --
> 2.54.0
>
