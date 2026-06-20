Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F527453
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781923701; cv=pass; b=PzmKEKZ0WAB+CrHXNxfpQqkz3hSSEg8QdxbiVyGmL6f5LL4HtkIptUZlkJCRf1dXgyPoOsGFPNl0jzTQ7HC7xY6a0LxMyXbrB86/Hpo11ozl8DX23Fd43wKAxnVNX8Di78xrxI42vE4Gs4HWphRCxxoq2VKvTdF4i5i1F92TU7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781923701; c=relaxed/simple;
	bh=Rbg/9D2p6GpBvrY1UMJqOy+ElyFK+3pnY/Q7CDuq/GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ceq9F4Gfqo+kRG21HWDDrBfwbhd2sfS2seSt+BIkFKG4u4wQKIG2GYK5NX/q1LWO8zLG58PhVakGW+BqjBX4NnDZ0/nZuEiJs3jczvd/S+5zh16V5A0dvJF7aJr72FyrHb3pccgeP0sNrMFl4aMonNUcBmZnIe8aTZsteGAoncw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJSnCCOB; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJSnCCOB"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1550320b3a.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 19:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781923699; cv=none;
        d=google.com; s=arc-20240605;
        b=huVgypXEJtTnglJgXzHDhZZcg5ggmjw6v/a8sT0Z6Y0h/LyqGA8+BdHauevYv0cMxv
         VwEgwCBYu4PBXXnuY9o9p5q5Vxsnv7HT/M4rha4B8T1Hd8WtrTZFGEvRtDqds0N8BFZ5
         qQ4Goe3VLSdJfav5X/8XAoVWTFj3B3L/lCxSYm2Ql0rllHGH2dC+rcXlmWKsdc2EJdCE
         S6binhbLVSez7Wyh8HgFf8KEVKaMecFIUifvE2p6K9BFOZNKOUGYluB0fVG+Z79WnsVv
         PD1rETcBWyiukGX1omEdu8WtqZrGi0E//t5s9D6Ohur76p3E/jG8R6e/YLgcWKVg04Bl
         28mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMog6yoEoQ/G09JDykgX7Q2v6LAP6zMnUEkcv+/q5pA=;
        fh=f5fVPZdnfewUSlpvMnKtU0ChZd/0xSI5vCZn+E3Rzss=;
        b=ODzwxBBVtWb8m1KXU2G6lMhJo+qQtpWv03f2bVg/8qumvRJq+tvYBWsGOkvBSB3Ay+
         7y5MzZrhKhjkUwEWxlomS45nzU+pMOLhbBVNuuAOhQL0fMgQjFbxc+y6Fy7sMHHYKVki
         9GcGWNbCYHSOpM7r03/IlRQ7Mtk3ZOEG9nxWa+/qrc4/KTD8VSxUvVKxe8wEb/NvAtVV
         8g9Wk7FVF8pbr9dsx66ZqjQrJSyC4zRvWEjr7tsniSOuSc/I33qxjQQ1cN0nXbvOS+Yt
         A/nIzTRuE4MRuDOY6qYGNQp9Lp80Hl9KK+tLZI7WAquGJeagVG54vsy74l+dnqMksNw0
         HUyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781923699; x=1782528499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMog6yoEoQ/G09JDykgX7Q2v6LAP6zMnUEkcv+/q5pA=;
        b=iJSnCCOBrJJs23xs53Dx0T4m1lQoRApRehkE6yv4enWe/UVSEOk00SqB1CoaHH+PgF
         tUKx9+i3mxRJpMS+sy7kNYOGfDYe0rSnEVTYc44k72aZq+ViIc4uMnGY4F/7SBSgp5c6
         0mcNQf/daT2OAOHZg5TIcPWH1SWhlO/sReZol4RtwKJZLUeJun+txmPD0M9vteG22sWF
         PLPl1V17i7gzdKa22iKovISn4ncG131M38fF5fCe1w/ByW7nZ5PEAoH3AIBK18fUW4eP
         mCUKkafx4vVERMt8UledMxtJxToFw1IixoQ+DxpOqeeGXXJ4va6xIWgQGDj6wbxtLxqz
         30EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781923699; x=1782528499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IMog6yoEoQ/G09JDykgX7Q2v6LAP6zMnUEkcv+/q5pA=;
        b=pw9XxJEjnM6Iii9HL9v9smQfcjuqKWszaOqUiesByjM7uVaFCSCHkVt7UMzSWeKPMO
         CgBdZn1OFkIAgN1f4n0SbJQzzqglZ2zUkNKBaGpJ17n9v1G3O97HikuzUeEbGdRg8JFF
         iHHqdBaTWRwBaWYAiB9goDAhkONrj891WBfjHTNsshtCJP7F9sn0ODDpbVMmqDdbvStd
         TjkuAnwr0Q4CjdEop/hYPlMZBiRkzzp0yy/fsIZBXc7FUK8pCz283lf8qWDi6RPLb+aW
         5sm/xstKyPrQDi8aryqw2wh+Zo4/O1MLS4xLZ+G6w4fzMkuyO6e5Ux4zA2riS7jGelY0
         cOIQ==
X-Forwarded-Encrypted: i=1; AFNElJ/HmLtMviInG9Qy/y+pAkGMJrut2MgVw31NK9fjr4EU+Hh+3SdZ+VxZFfp+2tMqRSq1CDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEa4cxPBTGxx5hxdIH3Em4PMNA4mHoNST7mx5rQONeqHxsCvYF
	d8eSwdFtFM2choYYyQfbdbSi36SSZSfkuC74LX3302yelNbb0EGlrkiZbZi+/3p4aB5fMiMN7O4
	0BIhbdW3KDaNYuTJsU/8ygMc1ibJd1JQ=
X-Gm-Gg: AfdE7cn2mOXr2lMwEvvQN0Fy8OCwr0oxsGwJ9DT316NwYbJV+Zt8UkhJNLLm+acxNiy
	bo1RpfvuHecF7v0msvPtLOI3zSCQvSkrkJeW4SEAKmPD18ydk2OpY1s3avg7W2cQbz/qkTLtCdJ
	Me2V41kHO1QEwninvMLM+iR8gNCuixCw6rMx4v/mTKkJEARJLcZoC1AssAJh8mOVDBcAvZ0g7F7
	bXGHQZvjbI7ETJZmGwWtNMRXORBvFWJMQ9tO2eCtii+XgGS7FDXQT5YCcu+o1diJ2SDQ9PhbCw5
	08wBZBmZtoRbqDEigAMR5zL08d9kJsH9MNGNH50TD4hcFBC1Y5KgEcIGbHPnIJZUP2hHamXDJHK
	6qwOV4xeUeFpAVh7i7pHoDkIh
X-Received: by 2002:a05:6a00:1251:b0:845:352a:a207 with SMTP id
 d2e1a72fcca58-845508aba72mr6261855b3a.34.1781923699092; Fri, 19 Jun 2026
 19:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org>
 <20260618-bpf-ringbuf-fixes-v2-2-33fde039ddf3@kernel.org> <ajVKM9tJskwg9OFa@krava>
 <130931685c8b2064325fc65a856ecd810c8a6b5c.camel@gmail.com>
In-Reply-To: <130931685c8b2064325fc65a856ecd810c8a6b5c.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Jun 2026 19:48:07 -0700
X-Gm-Features: AVVi8CfPILgC_aJbPc7RvcEnqlaV04eO7hG5z3eafsoNlcrC-2DekZ7AbCtJxFU
Message-ID: <CAADnVQLuNSE5AM6Cqzs4yDFrhTyD=j-y5dfya3dLwk3si9v26w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/8] libbpf: ringbuf: Prevent NULL callback crash
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Xu Kuohai <xukuohai@huawei.com>, 
	Andrea Righi <andrea.righi@canonical.com>, Bing-Jhong Billy Jheng <billy@starlabs.sg>, 
	David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrew Werner <awerner32@gmail.com>, 
	Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> > >     int *len_ptr, len, err;
> > > @@ -240,6 +260,9 @@ static int64_t ringbuf_process_ring(struct ring *=
r, size_t n)
> > >     bool got_new_data;
> > >     void *sample;
> > >
> > > +   err =3D ringbuf_validate(r);
> > > +   if (err)
> > > +           return err;
> >
> > as Emil noted in first version, this seems like overkill, could you
> > just check sample_cb !=3D NULL before it's actualy called?
> >
> > in [1] you mentioned you plan to add some feature that won't use sample=
_cb,
> > it'd be easier to review/suggest the solution with more details on that
> >
> > jirka
>
> As-is it appears that the simplest thing to do is to error out in
> ring_buffer__new() and ring_buffer__add() when callback is NULL or
> when overwrite map flag is present.
> I checked our internal usage for then __new/__add functions,
> and it seems there are no cases when NULL is passed as a callback.

Even such an early check is probably unnecessary.
A valid callback is a part of api today.
In general we don't add defensive programing checks for NULL
here and in other places.

Sounds like there is a follow up to add callback-less api.
Let's see how it looks. If there is a need to check
callback nullness it's better to discuss altogether.
