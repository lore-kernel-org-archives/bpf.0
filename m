Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687A3A75AD
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809430; cv=pass; b=EL9pOQj7yLCyhQo0fVr9M/gPG02dnuZ2BUlX0Y8Z8q1i8jrrD5TyGE5lKowP0uni7Qp3Yl44HmA+37gP752ZRrAjV/Vw/fKapnrUhfjozX5SRnQVIxj70rQnx5Qu4788A9fRsWU8zJj3VtKNKfiKWxh4L2gk0c9b6TfZH23xrsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809430; c=relaxed/simple;
	bh=xFXFGWyulzpS5kgQ1H2MDTMFPA/U/219DnWbJY3bqbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxR0qEblXmsvHJutbJgiNIDSz1EDWL6xkW80S2loy5EBfc/ImPFp6XrfpOmeTBY7c2nZmRoI2yXwzgzGKrnbeMDXtb7+Vz5dP5vjRh09nZHy3y5dVKkKk60Ad8d2IraRy6B3DOFe9X8mJNsPoBhQ+itXy8+rxTmPOfXOoybMq20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CymeQB43; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CymeQB43"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c6e2355739dso1901490a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776809428; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7NbyF2wA8yXvS8w0rQ/BeXem5aWOoCxO23DXHLv8yphVM/03UK9Y7ey0pROz3j/LD
         RnF2KEg1vnzYr7Dejy8razEizbkujZAZ9p9yXzKpqHb9YDC8PgexKTxJqkWx/sfHG5FJ
         sBBcGHl1DjfPa/vclK/tqgFB3oKoWE91b6jue8v0J+ML3sgF0tiJxS+aQ5ipYgXl8dH3
         O9WOaDI9bZ/v2ei0RlV1qeCfQ0tOSkUr0YbmJuUYsWQVUOR2IkxRu3RX0K9CvkIAl+FW
         fxYkgnB5VKTvOcfFhmCz3j9U/qAG8Ok5OLfvvYK7PlA6Qr1Rlb88BAMVeqQc4eONFbNu
         mwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        fh=hTIcUK3WxNCQx0ekZER+zASj+wWe/21frmTM9dAWX1Q=;
        b=TwshFKz70C3OjGDJWnRV0O/vzlMbLFo+qvwwEKeteOrN7MsCFzlV899DoFGZ6YCSEq
         M59Tt9zrYu1H4IHqfAyWRBMQM7UAOgJpcGtKugpucIa+cd6J/8Nk4l70B/TR9bGL+Jlm
         gWGSScvAf2TOZ6Z0Qb26014BGKEw6LsGXf4PkFQ5S5Cm84HEghUKXoHGDVKWcY4gHPx1
         7V+GXJ1bZmk78bmEubGbtEbmE7VxSYHQyr2/iYDmk6dmO1R70km1O0bSqJSImRI6WtW1
         JneqmeEZZqd1vXRBELRYxFiTs5PNBrCVuzY+OR1lQcDN78M6lDi6dqObehGqDD8Z3r6l
         EFtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776809428; x=1777414228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=CymeQB43g+xgXJkvDnYkNZWs7GQqQn1p0+1Mp1dP+MUiiv2jL58H8azLIiUlG+C0CQ
         oVKVMDkL6kmEZJDJ0Al1sF5svSL5adj6rMz1Ie+h9FNhm+DTGzUW7USpBsRaI9Fit8Dm
         vVJRWetTHq/Zlx104bdtYXQZwnM1ALCHL6Ctr6y2TFxEtxpBKRkVRcGeDe7a18igmPbA
         OZqoHjQXWEONHQzAf+ftKhWbI8IUuf/VvuS5Vz/dFmUjQOcDMWaLXmcdi8vks5J8lExi
         LmZ1AlOdF+vfRsCjqb8V5ZrC9Ea8TeMNY+Gw2Jrka+cQzaOeRFx2iA6rpZ31/Eg70bcg
         6r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809428; x=1777414228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AiGwsmPVPMIRS9FmLSReJQ9g0VW0y/S1QWZXVUVPj4c=;
        b=G+EBAIyvTkN/v9Jfr8sERKzctdyrC0rKWTpeIa8U65hhzy5cH/h+B5sCPaov4h3cYI
         RtTX3wpg3CB4vz0oBz7YAThfBcakCaIv4FzlQxhP2BdBNucwbugL9JPLvt8J1gzEX4Ut
         JtlzKxLji71XkMSHoJzXeEKGfNHKsQmwx6snSpM5+OfA8VtXbtrGKmIdEO4iYzOf1FCA
         oxN+ztcDOrzZdGaFL/JRrYbD4eUgVL6BMvElJtlopV5hdytlBmBiW0devqR+RKaTeamw
         WpU0XZMU39TzMzG5EdDSCk3L34KKF/fyE4YxRcRYEpE83JEwOUWAmtHYjyiwOTGceq1f
         qb6g==
X-Forwarded-Encrypted: i=1; AFNElJ/MAs2j12dJMz5X8qGxyqlqRmaspSwdaEuwlzhkqcI7ePH7fvKMp3+to0bt8njBgzgjSY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8KIohlDZVRsJrveI5z96djNpw/wrMW635fPXa5SMczf1EW9Xx
	hKDanvihhXynupGpkqgh20gkT/1+TnnlLL1srLSLxgfeIeQSM9uXKRjK46oD15xuOjJ31veoESy
	4HTWziQzNYfuIBFeBWl3u87oHnqqB6e+FL0K5cmPB
X-Gm-Gg: AeBDieukE6OY1/LU63efN2kLN2a1+mzUlvzne2a6C/yAAxyymsqHUnBunCu2nclRYta
	o3kBIQ9NgUK2uc7PwjJntzBIGsEj0qxSXJqYeJmvP1rrkt+EtVqq+RwsCqZmSJipos3GkAu8s4V
	E2CJ5z75R6RbaBOSsh9j8K5lgC2UeiHHYVQqmRq072ngE11mDLWcZlKFlgKC+dJ4CTcrSSRPU1K
	EbCtLZ/AuJJ4+dnCW3EbxsvHINYO+OENBgvruY2gf2gp3tGBxaAZiJzBPPNhoI2+wzLEqRi1UuR
	GFVLP88zlX9SP7lDJtNxsv23DbC9
X-Received: by 2002:a05:6300:8088:b0:39b:8dcb:f37d with SMTP id
 adf61e73a8af0-3a08d716acemr16416581637.17.1776809428374; Tue, 21 Apr 2026
 15:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <aefnIw1Tx_2r5nkS@CMGLRV3> <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQxa+fHM9X8COc60ZMcxF0DMhWbtArg_gPynpbbg55TQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Apr 2026 18:10:15 -0400
X-Gm-Features: AQROBzAZx6KqlUgLuc6SEp8mHgK0_7ru1fA894kSMYQ0Oc1ORPoRRj_U35eYYmo
Message-ID: <CAHC9VhSo-M1wK2s2P0B+2F0pJqNguW7Kj-g63anp1xCMSBLa6Q@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:12=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 21, 2026 at 2:07=E2=80=AFPM Frederick Lawler <fred@cloudflare=
.com> wrote:
> >
> > Hi folks,
> >
> > I was accepted to speak a little bit about this patch series at Linux
> > Security Summit this May [1]. I'm going to use this opportunity to
> > re-iterate some of the motivation, what can be done today with BPF,
> > drawbacks, and wrap up with discussion topics. I'd love to hear feedbac=
k
> > from audit, BPF, and security folks to work towards a viable solution t=
hat
> > addresses shortcomings to allow for better integration with BPF.
>
> I don't think any bpf folks will be there.
> Also giving a talk about it doesn't make it acceptable.

I think it's valid to have a discussion with the LSS folks as they are
the ones who will most likely be interested in using the
functionality.  From my perspective there is still value in validating
the basic ideas in Fred's patchset and checking the value amongst the
LSS audience.

> It's still Nack.

Based solely on the diffstat and a quick look, this appears to be an
LSM patchset, not necessarily a BPF patchset; yes, there are kfuncs,
but they are LSM/audit kfuncs and not core BPF functionality.
Regardless, I want to see how the LSS presentation is received before
worrying about this too much, but your NACK has been noted.

--=20
paul-moore.com
