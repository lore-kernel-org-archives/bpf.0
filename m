Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86831E834B
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992343; cv=pass; b=BUfU3tQqM/GWiQHfzMXzhL+T89x4rDaHgJuLRPm3Qki3L6dWTE+E3KZanPl/irameBrftj/zHtcj9SIwWAKuJfNrgybkAPMY9aEYjismIJAviPP/ekTIfGzWsA1V7AMhRdWFP28/rRnOPlx+/6AYtq/OuBkvGCupRdpBK0+hjWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992343; c=relaxed/simple;
	bh=O29QH1nqEi06EwceJfS+6Rm8Yz3WXybENc7Pz9CHxE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXoBtnq6ulBWLslnLJC+RK7Jv4Efpyk6CW9YoCTc2b82fS8kaHAtf2lRfRNeRZRy03mARv2ldkW8P8b2UrUzlnz0XHpguqGDI6qX1zjEcaCHi9kL1x0+RjeZfdcoxWDvp+bMYPAnNOM9D9F7KEXCA1b4aC57/hYTotknxSjAfUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCJmSIWe; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCJmSIWe"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-436317c80f7so270995f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771992340; cv=none;
        d=google.com; s=arc-20240605;
        b=K9YqnntHI+vfqHGTqJOiM7bCMY1YmGzhsdQuTLD/A3uj4mSQLmWA6DnW8Kt3lLp+I2
         KocAzf7/q8ZNlCVE8959hOxMbgRaoU1C57X1kWlTfin8x+YFWXa6DlLeFYeQl/F6w29d
         6nAdK8mmX7yb/LEzmiec14XACveZ7vNWqzJ3af+a4NV0+YtVhN8yOhlZ4c/JIl5fzhFX
         gvvECF/X8qntriYxRuTKNhd/3AdcVnJhnH6AfIXGA6WMaKoKhY/L/vS3PJ/Rhxu+iiJ1
         B6g80iZwLe0fA4G4lldPS3OmHwrOL+k6nhNXEgj8HD0QEfrVDLO2Vnlo1qAKv2uYXQXa
         d2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        fh=IxIzqvRclk4ckGrl6HzbisEBsumaIY8NQx4faSiToFI=;
        b=TTotjNX1MVLSzCxdAWEc48rEAdTAyqxjp+WvykFk8Oz+oj1IUYR54eG6FIWsits/FT
         rSllB4w/0DnDJK255/lF16BXgx8WRpfmqtaAIKMzi2lgdGEew6VXdg7TC749fleskMhc
         wmdIUCeYktogXjUIuLNv7jkCzk97OzTX+bkqPsHMThnnUlUcWOOw9wqdbAM3uo0UzIZg
         E7ViJexLueWSNeH5rWqoT9ZIIIRLobn0/WPUSebA5iyd0I/37xkGV3u7v5hV7fNfhePx
         UEzQZqKdzZH5FNsBYjMwDv2NHhPBIJ7yuufWRVBC9xVkr19KXUjVLLP3u46iV5VtSEIc
         rJmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771992340; x=1772597140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        b=KCJmSIWe7WCpKKdqLko5ApgRwIaaWMpUVehXaYYOorsjdpUkoBXdRemWnu7R1Ioejc
         B4Sh2rQlOG5fsfg7bmZm/TXSUYYJMhwokV4HwUZWNshuUJADhRYB0orU2FA/OubgRqcP
         vPCQJRHnS1howdqxz8FFpY/731h2iajO3zxA8fSBiHDdJqRQXceGDM2ep/h4b8JCxHA0
         avj1keuN6Lp3iCYjiN+v31Fkw2Uj729vQbPE2ldejANVyTcWA+bsai+6ixvzjQ2+HdEC
         Ce5Hs+1jE+/zWgPQu62KGBmHlBxLrBb07aIaXviIQXgQAeI8voAbeMf0LvNqKrlg9Gl8
         HXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771992340; x=1772597140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVj+eO1lEYzx1IPTvNrukfWxr4EtHXMYmANg24lti9I=;
        b=kkwYV3mavF3PDZDtqs96wn4CkAXTjNLRe85jLfR6/4aRXMFWr/iyTi9DwXSferMxqt
         A5zaU843TsWoaEO+/RpoqLMMDkXhxWAXfQfIbKuo6pMeypf7btlhktzJRyulyAHzfXFK
         ByRqsTV2sWY002y92yewxoPwBOVxOTUD7sHC0eQKdtCgXPkrBnVt96Zxd7Ux8J+KoR2C
         lwrx/l19zNja39S1jFcD2Ac/t9aivlXxMBd1N4W5JWdXmacF6woZrABeWZyaHH0FXnmL
         5CSdo8fuDKTFaXpX2zLNfIjReZTPEvgQtV+WHs+SMQyzBXGe8jI8wx364JZiUBq7vhDc
         M7wg==
X-Gm-Message-State: AOJu0Yw1vog2VM9GWOzVvGRWaYSZ6U5ItlpslOPvyAZDLGe+xRbiOb7z
	2w01DyvbGf+x0bZFV2Pfbj4DVy9DWpmT3AxQGkcEhdOMmhL11wDtzhy+K+BYXqUzzL1qVFHW+NP
	mNSlWVBnzgQCqs0rPEsi3f8rRXb73I+4=
X-Gm-Gg: ATEYQzwyI4m7naWDM+SCOK0UFM8HYJ9TWjWSdjUUk5qmF00qEq4j3oZ5NTutYfS+cUt
	55DMyKUnnqdPJjL4IGyx8ef/zTotRtEtKyS1V7qGrcMdzATDnkJrp265SYncZjDkkWmBPDnQosp
	H3qDj1ETYVnQOcHAA+w7E6nnUXVhy+Eg13nfoqNeofkPvAXEvJBjyhgCAxSV61bgSt9dBkBhnTi
	c3O8YV/AHVQgGS6aCH9ItWct/1iacX59zSmbKq7mW2RZWQlWz5iZKB9tvekRPLzHzm4fX2azOP2
	4wz2EcscsAPcDeTRE/upZdtz3IUBjEc5S1nwY68AlnyV/iBXBMbwKX+XMNwtHG1gtlUYqCSpLdR
	gs+Yhpxq8q8w/vA2+FPdLQY04kzNqgc0ivz2U
X-Received: by 2002:a05:6000:230d:b0:439:84ac:56e4 with SMTP id
 ffacd0b85a97d-4398d82ae57mr4494934f8f.2.1771992340075; Tue, 24 Feb 2026
 20:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com>
In-Reply-To: <20260218092002.147306-1-mahdifrmz@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 20:05:29 -0800
X-Gm-Features: AaiRm50hIgWAVdyuR2Vku851sxqq7il1PWJsM35jT1Q6WLt9SSiWvlaXKFRgpIU
Message-ID: <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
>
> This commit fixes the integer parsing of -t option. The cli parser
> only relies on errno to detect parsing errors. The manpage for
> strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> states that the said function "MAY" set errno to EINVAL in case the
> conversion fails. Currently on some systems, this leads to a silent
> failure with return value not being exactly documented in the
> manpages (probably zero). The reliable way to validate the input is
> to check whether the endptr has been bumped all the way to the end
> of the string or not.
>
> Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> ---
> v2:
>   - fix style issues
> v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.co=
m/
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 05b3cebc5..5e4095fd1 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifobj=
_tx, struct ifobject *ifobj
>         struct ifobject *ifobj;
>         u32 interface_nb =3D 0;
>         int option_index, c;
> +       char *eptr;
>
>         opterr =3D 0;
>
> @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifobj=
_tx, struct ifobject *ifobj
>                         break;
>                 case 't':
>                         errno =3D 0;
> -                       opt_run_test =3D strtol(optarg, NULL, 0);
> -                       if (errno)
> +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> +                       if (errno || *eptr)

This is unnecessary. It was required we would have hit segfaults by now.

pw-bot: cr
