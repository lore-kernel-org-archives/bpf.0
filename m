Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB938B120
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776373944; cv=none; b=heKifP6ZTqJc5uko3kWHZEVf6qVV+pY/XoMIZcAr9YrOTI7PjuehNzgO8Qawm2AR8G8cLAxE1/bPNoVwA72s0+1PVNINiLwiXNh6CqTGNVuRzNlYyhj9lH7jYmm7FBmJLebTLUwyGdjz4Wzv65cbsq2XPZWcrNwnIQvBT/P6l+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776373944; c=relaxed/simple;
	bh=IrYmcZF9hxAXNqt9zfpOlti0Oz+SLkvIJYPq35Swg/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGK4oK0Bfu9FNhsVv908tW9GfymVpwAeeJSOIX6vAD4dvRyQ8jRdx+1SAZ02F5gVUsPQgl6D4CupcRAqglWPo1+6Qkb30ndKc4SLgSQZMntdwJDQVR4rJdCRMPWOG+TfPYhnBjdBLQFNvbuW6bNsWq5pxS8VgEkXIZhOM2Zo5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAwCrrpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAwCrrpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8D8C2BD04
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 21:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776373943;
	bh=IrYmcZF9hxAXNqt9zfpOlti0Oz+SLkvIJYPq35Swg/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sAwCrrpyjCeuDIwYlOGb+qhfSW8IAuUv1b2XSTzcACcQFSqbD5WndiLXGFLDqUtb6
	 1gLb0QMTTFdTbDJum4HUw+nZFDlDT0boBGY+n50w2HiqeWMKukR4W7yZN1Ba/3Ive0
	 l4w+UZLV6FtegytSbRqGK/9UxUDvJJTPhIQUAmUTUQSOwCX2xNZwbISkvX+onWElR0
	 Wy53pjyrIN965xKkiEgLFVIVQvOURzuMIxn40bn2NSWA4fq4LjoA1eoWzXd7YIeGZl
	 47AG412prmljKPORIJvl+HvA8UxP+La8pXeT1mGIcnHd3njllNsBC5hGHKO5PlPXGw
	 QA9i/zptvhU1Q==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd71fb9f06so530569985a.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9meIXLg6Wu+MLNtsHjSLGyGbCay0zpt6DXm4YQMTM//foed49ylWaGRYk82vItOhcRglY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCAaaWLGVQDll0J7z2dkjGFfymCRPbzm4PgphuBnrzfHXXoXy
	S/kOged9JQ9m5Ky4MVaBXS6Mgzffvcmcog9Jdu46ziSSw3cdsi33mD+Vag6Wsxz1/lt2pK0Zvzv
	byXMdA3qKJYaTzzz2GXFr/sJ0ATdEjRc=
X-Received: by 2002:a05:622a:a09:b0:50b:893f:7d93 with SMTP id
 d75a77b69052e-50e367feadbmr901151cf.2.1776373942596; Thu, 16 Apr 2026
 14:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com> <20260407200157.3874806-9-utilityemal77@gmail.com>
In-Reply-To: <20260407200157.3874806-9-utilityemal77@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Apr 2026 14:12:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
X-Gm-Features: AQROBzDk-eOQnc3KIcDHr-rTAWlI-wv9602XvRcYDgzfGDKiclbye-SKGL6YBWU
Message-ID: <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:02=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
>
> Expose the new BPF_MAP_TYPE_LANDLOCK_RULESET via headers, allowing
> programs to utilize the map.
>
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

I don't think we can introduce a new map type for this. Instead, we should =
use
existing map with __kptr values.

Thanks,
Song
