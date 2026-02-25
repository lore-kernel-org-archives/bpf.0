Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF842EB862
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771999192; cv=pass; b=RcOdp/6TC4w5V7WZWrpcgI1LmFLzKGYN91n7yVu6FKgMcHvs9xyzw49r6yp32cfMHciLp4DCGlkN7zNvV7hDGiRAYG9GHtCyE6OKpgehPQPyI+elBOcgzYwI0Hn1gcIVeMD3R/Aod+bi34nxbp7AvoVNtkMJbV6wTkRxB61Rts8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771999192; c=relaxed/simple;
	bh=0187+HJXbxbDqoLndFtsYeQmB5bITMCie3MJcozAX/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMUFDhwr8VUV/De/q/w4mjdATsrrHJMy2O5/VsfW9AaK2pV+jaC2pF0wnxPD5RStFzXXbe4uKJ5mtvMak7f0jneGqLn4Elq9cxWV7Evvv34lwsR6nG4AqP/4Vdb9KQbgPPpCXJcKLInGq8f5neVQvlTOBl6hz7pmgwKB6Kr/lzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zmd8nkhY; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmd8nkhY"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7964fb9ae3dso57155297b3.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 21:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771999190; cv=none;
        d=google.com; s=arc-20240605;
        b=LJxVEtgwjE1I7U/2j+u9ls3dTsEXInLfxmve2lfouIdSdjsLw8rMTP7RS6TTwHY4s1
         JHJ3sBL29L6ZWHAYrsSWJYTdXoqvtawxJaL78nMAGNXkx8+Zn+DjcYJr9tKgKwRRgnAr
         9fdkZieH33r4xNpO70qr/HHe4Yj6Nvf4WLmbU8ec2WLvZPGk2rnZvsrqAK3D5SQWBmMW
         EEmUIj3dZbJFq6YoHRS9Lqy7NlFPZga+WXazllVxJAwXQoqJCv6cr0pt5SamdccMMbqV
         T/aN9C0VtTYQFurpJ4pb7K91WYsax7+xnU8SOBR9CT5xzqCkXB/6QclxqvOEf07bqa+a
         +ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        fh=9qI50piiySQBcbtDrkNXKbownp3c+kGGmYKHUEGJ3l8=;
        b=kMxmvmnZEkVcFB2P8PPZZko9o7jDrlaxHEcMnCAjsNZ+UX1wHBSL9xDLQ/ZSJRYJPP
         Xw4OqdveN4VsYlmaGIKEHlRtg23xJsBR6ii/TgPWSaPFtIiaqAFxSIv0vfako4z+JsUL
         fzxTLyAlRWMJExPbS2BiMTbJEkYKVGfKaR39CEUfY5ojGzpRBveAfOCU78pXlhclhfnc
         8nAmWYkdc2SZh8SMjeHfpRUCnrYRN64IdXMh+pixiCvcXrSvSxJKt8ZloMYqlrO1x6C2
         HVdEPmSrnwPMc6eOUgwxjPdLDNqUjVfPyhqGlOJ01ghMLvzbN++7/JRvIxSTqZ8KccRS
         O9Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771999190; x=1772603990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        b=Zmd8nkhYOuPr3EEgo+NbAUzEvq8xZ/n0WVOYGtx+/65YvvUo6ke+vTHOc6C7rW0ldm
         2+n+AcVW2aZZMQdKNq+XIwzs3d6ktE6AQoxSPJbAGqZ2IThAm05ysU63tUo8sXyyyL7l
         fBXg4E0joW83zQDcvEB5+806ohIYajT0mOwngX3E7TN+u+yEEVmLswvSPyUXjFkuuIOi
         fbE90U9NfE/+VbV1xCWPP7fjD8sWkM3qpUkYgA7HaRy+KWTcvl+mxSBpPWItxfzYms4n
         sDnPFOH02NCImS3oDq9WKePZ7OSKMkQLJ8MZ9EJ0dRFpBus21J3eHxdwoTOV+f7jZoZ4
         QnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771999190; x=1772603990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTIOS1OA768nNXxxFVbpB4ZHw3BFrbFTz2tgbv5jMPk=;
        b=XpGjEg9H+6Qb+eoSh2mwLenKdXTNnjVNj50PJ4FEEt/aFwvHtSICNsxWmht4gy1suk
         hQy0juKJuuZwoM6PWhwm5VTw1ImBbkDEyVlvkDpA1FT+DeDP/fn8Go2NKZzk5ZUWQWNI
         +EpwbC+CwgHOd1rHvnyWDPCmuHjfZ95N+ZcXfzNRD4VWjVP0FKJKjgugo4TP4ybcaTLw
         HGFDMzOtRavJ3eHXiqQsk+36Eavr/+a7p5U3XXZu1oDY3uKmk9ShLZvkom1F3lk02p0M
         4atsCr2Cn26VoZ+Lq+NGxuvfZTGQCzYC/LOe8oMByy8Uu6dwQr8X93YKxzPQO/tTOjzo
         er8g==
X-Gm-Message-State: AOJu0YxLRpocSswoBUa5KYQSRbIdWs563lkxeyMoo9jpRIMjKK5bdwm2
	mpP5h7VoWOUr38NdgL8x4rTS7X6I6rGeNFU2gK8Fw4vo+CHBtILVSbLOKOu08V36Tcvi1j3HTu2
	bLTLVEGVSv2aWgOQwOc7l2qBbs9K/jhw=
X-Gm-Gg: ATEYQzyRmK51Ei2mA6iLk8/oUzUBCq9tGH3NYjCipN3QeEb0eEZtYeDmzBVpV7Aj8ay
	cn9+ZnEx3RXkRkZkK5hj/zWMEYedh7wFOkjv1GkPz1+72sasCe13gRoHkLDT65HmuA5T3tPeof6
	wAzDuvHmwitXKGuwI9wIC9xGM/1yPzI/P+3bXrrFWX/3FSLS5uK6+Oz1KwgR8u9mLpHLijmX7TP
	Je84eAyOdvjsRcagCbzHxowjB2ZOfy6bhlZxZQt2SwvnTXqL3JcJHiq7EE5Eb0oB0sMkSPlrK80
	c4HR1zqc
X-Received: by 2002:a05:690c:9d:b0:798:25d:9b1 with SMTP id
 00721157ae682-79828cd049emr129572897b3.12.1771999189729; Tue, 24 Feb 2026
 21:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com> <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
In-Reply-To: <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Wed, 25 Feb 2026 09:29:40 +0330
X-Gm-Features: AaiRm50Jnc1hdfMZrcEoHjnxIA7SWXi5yLlX7fypqKNkoMiU9nlIjTPDz2hqS3I
Message-ID: <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Wed, Feb 25, 2026 at 7:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@gma=
il.com> wrote:
> >
> > From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> >
> > This commit fixes the integer parsing of -t option. The cli parser
> > only relies on errno to detect parsing errors. The manpage for
> > strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> > states that the said function "MAY" set errno to EINVAL in case the
> > conversion fails. Currently on some systems, this leads to a silent
> > failure with return value not being exactly documented in the
> > manpages (probably zero). The reliable way to validate the input is
> > to check whether the endptr has been bumped all the way to the end
> > of the string or not.
> >
> > Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > ---
> > v2:
> >   - fix style issues
> > v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.=
com/
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/s=
elftests/bpf/xskxceiver.c
> > index 05b3cebc5..5e4095fd1 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifo=
bj_tx, struct ifobject *ifobj
> >         struct ifobject *ifobj;
> >         u32 interface_nb =3D 0;
> >         int option_index, c;
> > +       char *eptr;
> >
> >         opterr =3D 0;
> >
> > @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifo=
bj_tx, struct ifobject *ifobj
> >                         break;
> >                 case 't':
> >                         errno =3D 0;
> > -                       opt_run_test =3D strtol(optarg, NULL, 0);
> > -                       if (errno)
> > +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> > +                       if (errno || *eptr)
>
> This is unnecessary. It was required we would have hit segfaults by now.
This patch does not prevent segfaults; it prevents silent misparsing.
On systems where strtol() does not set
errno for non-numeric input, passing -t abc results in opt_run_test
being 0 without triggering usage().
Checking endptr is the documented way to validate full-string conversion.
>
> pw-bot: cr
