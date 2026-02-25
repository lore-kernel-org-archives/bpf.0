Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88193D5251
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033525; cv=pass; b=uwswiNPrKlWDMWWmNx4FOqXr2I3hgOH0NGnK1Vk48Hl6w4LNLWqAj3kA9r+kumlUBSALIFEQacTGuYItzzORfuAnLAstnGNuR0y/4sYvJsR3nBuWpu7M6zErwsD5V+b3B6N7pioEzxGNtfcTue8pXKv6alJLIuh9E8pKERcp6wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033525; c=relaxed/simple;
	bh=bjupSToOrAI0DDwjT7STEKsEGqrDSWoZgas6vdq8Ts4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV24WDTquB6TN8OZShCv2fDJ0wsXM8OMlaLEkEcGRuPkYKfep29d2KRuDD5U5jLALp4QW9cwFNqXV34ozwvvgTZP07o4Z2rUV6XL8bnJ45W3oeXlduHF2BYFBBU7jDCHnCaaSUBjF0Nc9SicFjy6GEDBj3FvRlWBAYWVuXXGRkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyGSCSO2; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyGSCSO2"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48370174e18so37916975e9.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 07:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772033521; cv=none;
        d=google.com; s=arc-20240605;
        b=IeLrLnSK4ip/rYPIxKGLZK3k55Dwb7zpJhN6WkBrvyg2tRASX1s0rYqoFtsAXDRLAC
         zWKqA4VdFgahjGVHTprpnBpaGFHNXN3kJ9dSr3XlVvzJRrME/Lq6EjQck0ff+9CXchkM
         phSkeIP2B29uKUlyTXYVom0S94IBPQzE+zz7YUkw6yKa+V6nRgHLnB/6RXm6R1ehW1XC
         8jirCq8U8x3dZq4EmAjEmQzS9Ec9YqGWckZy+rmaO/L9QsQDgcaN9LeBBBP2NMlEk2OH
         c12+Lb3JMZ9NUpkfZLPfTlbD/8YVq2S2BtN8Ip4pSac3zeEryqUXApQ9a3j1MRGsZxIU
         9muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        fh=IxIzqvRclk4ckGrl6HzbisEBsumaIY8NQx4faSiToFI=;
        b=PlYJIqEvUFmd305A7Rm4B1PiXcmCiOKDbO8+kyRBfGXAhgXFACCH0WoUSENT1wro4y
         DjKsvOOwpKye5T22nhKCUmGYA44VVbteY/K6Do+7Vpbi0q9mnbHl5Q1CG3E6ZnH8gNw5
         mFZOJJAALdWHHxwyo1+6GDqhGPoZ8Lw2XCQuhGuSHnEdfLTu09d08qqB8DoFk5McxnUg
         qMlfzB9qxp8l3OJEwhSgaRWrIbavTX7yphyn2ADn5s6eqScWLbSK3IV0lTns4xy5BNJg
         BZwU1sVYSvZBRFvcredRmlHmGA/DNZvGwLOb6b/80yvugAI8NsOI/CE6PUsua8J70vEs
         acXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772033521; x=1772638321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        b=dyGSCSO2uFZ3XjRKUlBYi5DA0DRMbuNpVnPifvFYenMG1nCBJSQvtRc1VrI2lESDXF
         Wn2psPpywm2DFoyL5YBQ1K3uHK6wmbeGKGaP9v+QZGNuYzFS3zgKTBI2hKC4xi2SvdMP
         oDeOeMDUsx/wI4kb08ywtvxYg8k1Al/Pf9RQlGyWGTHxohqEjPpmZwxXa3c63r5oGENx
         fjudeYM8I7rUeaVnLD+eH+6+2W3sWwjB9PZoYe/5sy8b3JclO6RiI8s7PuXXvIJHCNej
         RYMxXDQjkcCVRkZXDtlZmCymVXXInvZ8zdAXnn1PXLNjPGhc4sItegHKMEwIRQQtU0o8
         xGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033521; x=1772638321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgxTPby1B2Gu/ejHxpJhTk6zFGYoh4BW/4cOBUn1anA=;
        b=olIkkbXJJViuJly2DgeqglMo6rSEKXDhfVo3y8NCGCdJeubnEzYwIJXpb+UNDjzWSG
         Gb5c3UPGrJtGkzOwrERLHWOx/FIqQfGbTeqGQ8C6UyMymZhEFH1/g3gHH0E98Y880aOb
         XieAjip7Gl94FselFj7s6bGo0gr4GBYZWPt1nY9ypC2VWtpfv0sW11qpYv55Hcn8eXH7
         X7wkydQiLV9DDspGYIdkliWGmUYhpVhtWBeWbF18FTNCVSZxyUph3k3Pm8N74hfkYpRp
         xWwKMcNp4CmNkSrD5PfCUGa1B5B4D+aBea3oki3NIm3JagC5qyK6h5XirgZS+foaO+DF
         payQ==
X-Gm-Message-State: AOJu0YzrIf2pXuXp3HtcqIcqsrhv5ljA1BH5yLVgewUOBaBqMNspYiBo
	rP01KAjWpiIE/bXS/hbjl+yailetaY1VTM2THm7flW2Yx+rDgfLb6w61s5YH3enhlDOuPxQzp4G
	LccMkgXT903NwZXu++1Qyk5xQG0pBBgs=
X-Gm-Gg: ATEYQzykOJd8yT07AM3SIIk/6QR8mL+FNSlBKXXpCYqzqQ8BPiDBpSyRIueeLW+/cT9
	5/dIb2+FwsT1pHVZME7Zbu48BCmSvq98pzysmz9AQDJStSvsAr7XjNDvcdkgcfcnDgVlPdFQBXz
	sAmw8uc28t2VUHctF5uXrWwAVp2SDFLuj851A64HMCWGfH9ngFXnjCLEOZpw/ulYE4kwNEDg4fX
	3AdbCCjSDspWWn7zingvsnIO9DtJBJNrHCDk2xclfB2Sba3kROhGy2Xrrrv4TeW9dAfunUmCgVD
	ejjqXPljuDQ1UWMHyJYYoO5hXKlp1gcNwlfHAI+OtKxWB6FtTbgl4K6uV9A3jgEt/piH/NEKM66
	Za5fb8G2qqtbPdsuXjSO2WrO8BoAet/Wxpb/f
X-Received: by 2002:a05:600c:5253:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-483c21691e0mr12465775e9.6.1772033520933; Wed, 25 Feb 2026
 07:32:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218092002.147306-1-mahdifrmz@gmail.com> <CAADnVQJdQ5PpHRvYahuSk0=cYBXnf5Z9tkdBLs1tcnasigrntQ@mail.gmail.com>
 <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
In-Reply-To: <CA+KdSGMxO5C=nFVFbauS2DTRzSvoj14pAMwmbWpj_c50JgOroA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Feb 2026 07:31:49 -0800
X-Gm-Features: AaiRm50uUxf6w6Nm2mJwbIUWIWYnVWO71EBV1G4XR43xAenu_Z1PpkZg1sv6ayE
Message-ID: <CAADnVQKE-ULKsArGdHs=_xakhMJ7-hiYrQ1X2eLpXFyJyY_ORA@mail.gmail.com>
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

On Tue, Feb 24, 2026 at 9:59=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gmail=
.com> wrote:
>
> On Wed, Feb 25, 2026 at 7:35=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Feb 18, 2026 at 1:20=E2=80=AFAM Mahdi Faramarzpour <mahdifrmx@g=
mail.com> wrote:
> > >
> > > From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > >
> > > This commit fixes the integer parsing of -t option. The cli parser
> > > only relies on errno to detect parsing errors. The manpage for
> > > strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
> > > states that the said function "MAY" set errno to EINVAL in case the
> > > conversion fails. Currently on some systems, this leads to a silent
> > > failure with return value not being exactly documented in the
> > > manpages (probably zero). The reliable way to validate the input is
> > > to check whether the endptr has been bumped all the way to the end
> > > of the string or not.
> > >
> > > Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
> > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > ---
> > > v2:
> > >   - fix style issues
> > > v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmai=
l.com/
> > > ---
> > >  tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing=
/selftests/bpf/xskxceiver.c
> > > index 05b3cebc5..5e4095fd1 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *i=
fobj_tx, struct ifobject *ifobj
> > >         struct ifobject *ifobj;
> > >         u32 interface_nb =3D 0;
> > >         int option_index, c;
> > > +       char *eptr;
> > >
> > >         opterr =3D 0;
> > >
> > > @@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *i=
fobj_tx, struct ifobject *ifobj
> > >                         break;
> > >                 case 't':
> > >                         errno =3D 0;
> > > -                       opt_run_test =3D strtol(optarg, NULL, 0);
> > > -                       if (errno)
> > > +                       opt_run_test =3D strtol(optarg, &eptr, 0);
> > > +                       if (errno || *eptr)
> >
> > This is unnecessary. It was required we would have hit segfaults by now=
.
> This patch does not prevent segfaults; it prevents silent misparsing.
> On systems where strtol() does not set
> errno for non-numeric input, passing -t abc results in opt_run_test
> being 0 without triggering usage().
> Checking endptr is the documented way to validate full-string conversion.

Prove me wrong with a selftest.
