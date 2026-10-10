Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E43803DB
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791620815; cv=pass; b=ZXthVKuIJkD76vI+quqEd/UF4TVAefa5u3AtJk8JfK/Kn4kjELXCo4NMNo9sW8ZUE4FkbKrYUr+XEV92Ck68IGTJSGf7JpKrC0J9hsxu2rVeTV/qI97dpbimMTvII5xSMiS8wev/ic2bWTlW9PID0eUzOspn2goD3ERqU9pKe/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791620815; c=relaxed/simple;
	bh=yGZl/hG9BKBfhYLh3HnO3WHa8MfR6nQRzFQuvrh40GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mU0S4WfJd6e5MgvgzimaglLkV1Zrn+6Ih+1zu7m/8hkmXlHxV1MqeJlqKL5H5bMQwp2Gl6ji8JGWYIhpAU9yZ+q84XBFAj1xuG9cC7VK1TngVFOu5p1my5uOA6O+8+mmZ7aW8vwD0VkcNiMkd+ebToAYl58Bs/h6EGgk955SeL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORs8aide; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORs8aide"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-677b5148acaso322697d50.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 01:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791620813; cv=none;
        d=google.com; s=arc-20260327;
        b=UaZPh4ZRiZqGRN7JRgEEtfK7IfPAK3aQlMBPKsuzjhLGf9mZ4jq8VMn9GXNv5zsnjW
         88zPAYIae05rOk04nsF/8PrHscbpP1VJXy4YT8+LdQsDuaf2hLbJZKUDNY1doz6s2QJj
         Pf2oW2BGB7Ksr7h7sxdBV7CC/aOp+BwJrAUJ0wdQUe9bHo6vrzoCAZAvN8x2BW6KVvsW
         0P0PPr64/kEPExkaYbcQWn4iX3yxy7NLxrsNc8k8z3YYMpQNXmlP3C8BPO7B7du9HUZN
         3p20rJEwjhVwNs6mO83jDRt1oAdmNxYJvAAfjlsQNXyKmVIPerDxrpNe60nh+a2SYZR4
         P8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4taFzx4ZqDR2SeWluPXbnOCCuhe1kKvXHPzkXYOhyQ=;
        fh=KQhFS8yoK1+IAXzND5oL/spUL/N06beKTfMwYnkqKM8=;
        b=eJOrxKs8XDvwE7eg6treOk1J/CurMdDQBXO7S3+5HSio4lciBNkFkOSBqEEU97Fs+c
         E99nDA+HCXSbrunbPz7D/bnuJ8Yak2yYtf2UwDfyjFtUAvxfVuUZtQaXLkel4JntNPac
         NEwNytH1lmDE3EQU03Zadkut42x1Vvvn1oPZRmxLXUYHzBjnw6jcDK2QG3eQaI8CJWSV
         Hmt9nlqo1UbFvkyB4KwrPjjnFOHITYVyxtzzPbKrhyGX4kOgXiGHfVXQZ72lMfQUwIN3
         4jTaD3tPFolKGteW0nE7WlYz5YXnVEO3iCpRx3Nzso70owCpFcd4txoq5D2ize5M+0pR
         I1Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791620813; x=1792225613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4taFzx4ZqDR2SeWluPXbnOCCuhe1kKvXHPzkXYOhyQ=;
        b=ORs8aideBmBB1h38hkdkCylGRgVfxJuy/GiNMkBM0ERFVL095utIXEVQeGP9gYnpmL
         EbnCaj6uFHnpaj/OdBjyF1kB4fWiat2x7SbRTVbFYhe8Qxj+RzoivzDzIIbFK5GqvaRZ
         KU/s94esjxgmAENHJfuQcpjNVtr3BfqXQTD/b/QUB5QaGRj5hg9TQ3WLzKnJpgxdrZr0
         JTNh+Ynfm0xmcUAf34jjNigmimxCq7WnMd0OrpBsrMG6FvlUgOzAsq/rSSXGAN5FaB6S
         dqq3k3ojaOAxjY5XPYPlRYIe0ah0naUyA/s46jvqw0Rt+GffxLidH6G82eSk6Vo+9iJF
         TBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791620813; x=1792225613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4taFzx4ZqDR2SeWluPXbnOCCuhe1kKvXHPzkXYOhyQ=;
        b=VMnB+gQGvrU2zx7wGCZFH/nXlSYZQfLoaCYqAbpjrZozwob6fSbDqdg4de/S1uG5cC
         GC6ETL0x64yPX1+tR1ozUOB+rTWDUjnC9egWzygiQRqC4uxcibt/Sp5oZwEpfWPhE765
         EpOWmnf9v2VoorZuhR/vz1Kl0D1LxCv5p+BxDjSMLnQW3e2EgdskSdlP6IkJaxF8vyEf
         ltHJY/ieVizVB0mlYnz0sf/J/Bk8feTroE5iHn/Co58c+7PykKGXFuH9HLHN7H+Z9QPu
         w7zUaYPHO2OPbrNdJ/6EmShFCVBg8g2GsFHgJrtc46K533E7KIxAPh+j6okeNOhCo4z3
         nmUA==
X-Gm-Message-State: AFq9FYLI4RarYaOSAvlXK1HuJ3eNj6T3amqkgpWnSlglW0bltE4IfOrM
	nxxpvn4or6APdzqyGaEkAx+iiCCCeFVuK36PxvwfWqsk+sZwF2ErqbJpGLjfBWFrjQCiSSmj1qt
	0YSmCvbNFaTqZ32i7EPg0bpXHxsJckNI=
X-Gm-Gg: AYBFou3PFsoLkyU1+IVmNA0T5HVK+e1cLIdHQwQWopwpcvx7tx7DqCO/vhsLeKEMuJj
	UmgMM9QXMwaE/N6DDBOuhOhUTOpZz6KQcLliggbVj9O1bT4oSUAKc68Xo12e2QEvO2VK0Dcz5cJ
	rh9OhrD/wrC6yaMShwAdo6pNDBULu1h5xc02iQy659m8UYGBcgnPknY8oZJQBaAAyp6reNIStcc
	KFPo1J9XT9UboSTCGSPe/XJ+TK9hchZii6ntiBv1Ks31THS1bX8Z3F/pAn9wunQ/rmf5GZbVbCA
	FzFh2+WetHl9ogJLvUMP8W4OA7WLlBBJyzIYu5xcaulnPS5UGyzINcfCoC6c1ZfRNdqF/IkYCOB
	8I/wEqBxh7Q==
X-Received: by 2002:a05:690e:4006:b0:677:cb98:35b7 with SMTP id
 956f58d0204a3-679362b7d1fmr1253901d50.131.1791620812785; Sat, 10 Oct 2026
 01:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010074435.1415234-1-chenyuan_fl@163.com>
In-Reply-To: <20261010074435.1415234-1-chenyuan_fl@163.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 10 Oct 2026 16:26:15 +0800
X-Gm-Features: AclHuK8LRVqGX5xgGPuub-kHsmJVaM2UaUqdcVwN-6BAA3YlW_5CH8aqwEhPU-c
Message-ID: <CALOAHbD8v=d-QwtjbyJ7DEBCiUZxhUDsrkdfehyUchHzAzsyyg@mail.gmail.com>
Subject: Re: [PATCH] bpftool: Fix out-of-bounds read in kprobe_multi link info dump
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org, qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 3:45=E2=80=AFPM <chenyuan_fl@163.com> wrote:
>
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> show_kprobe_multi_{plain,json}() walk the sorted kallsyms array against
> the sorted addr/cookie array with j as a cursor into the latter. The
> loop terminating condition is checked after the cursor has already been
> used to access the array:
>
>     if (j++ =3D=3D info->kprobe_multi.count)
>             break;
>
> After all count entries have been printed, j has been bumped to count,
> but the loop keeps running and dereferences data[count] -- one element
> past the end of the calloc(count, sizeof(*data)) allocation -- while
> comparing every remaining kallsyms symbol. If the out-of-bounds value
> happens to match a symbol address, a bogus entry with a garbage
> addr/cookie pair is printed to boot.
>
> Fix the off-by-one by advancing the cursor before the comparison, so the
> loop terminates as soon as the last entry has been printed.
>
> Verified with an ASAN build of bpftool against a live kprobe_multi link
> of 3 symbols:
>
>   before: ERROR: AddressSanitizer: heap-buffer-overflow READ of size 8
>           at link.c:860 (show_kprobe_multi_plain) and link.c:352
>           (show_kprobe_multi_json), 0 bytes after the 48-byte
>           get_addr_cookie_array() allocation
>   after:  clean output, no ASAN report
>
> Fixes: edd7f49bb884 ("bpftool: Show kprobe_multi link info")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Nice catch!

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  tools/bpf/bpftool/link.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 088d1d206065..5cffa2d283b4 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -364,7 +364,7 @@ show_kprobe_multi_json(struct bpf_link_info *info, js=
on_writer_t *wtr)
>                 }
>                 jsonw_uint_field(json_wtr, "cookie", data[j].cookie);
>                 jsonw_end_object(json_wtr);
> -               if (j++ =3D=3D info->kprobe_multi.count)
> +               if (++j =3D=3D info->kprobe_multi.count)
>                         break;
>         }
>         jsonw_end_array(json_wtr);
> @@ -867,7 +867,7 @@ static void show_kprobe_multi_plain(struct bpf_link_i=
nfo *info)
>                 else
>                         printf("  ");
>
> -               if (j++ =3D=3D info->kprobe_multi.count)
> +               if (++j =3D=3D info->kprobe_multi.count)
>                         break;
>         }
>  error:
> --
> 2.54.0
>


--=20
Regards
Yafang
