Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D441043
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208356; cv=pass; b=JYERTZA3MLMn8Ofne3FJcFJMInA3Lg6HOHVR59cAr2xdM8QxuWjpYhEvlz2NONeCXURSbzpMnG1fqjatNKxpG59KIjN6A7lXPy8bMgs3WXL4BtJKHHkrcbWeUVkTYu/4NjEuW2uhlfPzjFPjILgkyr9ehaQymYEd5LPR8s7iVsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208356; c=relaxed/simple;
	bh=XWRFmApZo3EeyDOBlJmpjRgegzMqTxAsMi4wp2Eo1BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvFF6/v4uNiUhGLa2CuJ9BRFaCA7qfxE9+s6c+vII+n5RsX1/8ccsWdv96bZswDC4vrWOK1rXVNDBVOFz4mZ6JsEqQ/jVIK2Vt3EVabE/YjrjsybUsSnKsX+A8BF2YR7HBO6ei9pw6L9JqKQsRP5kg3y3vpJ/AUYZoRhFARZH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LfmMR7yW; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LfmMR7yW"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506c02ec1b3so25530621cf.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 08:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208354; cv=none;
        d=google.com; s=arc-20240605;
        b=fVGQ27nkoaiqIZJDGyWkdsyBWBN4/+5ZmObHtsJfey9ZegMe00IJNVdoSzDyMd8Ncb
         XNj7R5oSd0fjQb0hALYT1X2gnM9AOjy+B9gbm6Srd6qkLYw+Ztz952qXwfYmtir3GIms
         7L2kwEUqn28wr8xQpnAu+tRG9wJds9xGV5ThmzNxksjueIe4X4K7twpqU/Rdv5Y59fS/
         e6Vm8qAFHpCXD8KM/cR3x/1dUD6Y/cwLu9in9OzgZT5lxpGjmAbB0Z0N6CayXnJIlnHL
         m5qE1RBfZU6WcO4Kza2xq/ZSh8RqzhiKkWz4ZPYbadcyNtBNBwq16d1RCLLBm13zu9VS
         OTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        fh=w1o4U8kAUCGQ4Hm9sVpW0AJPyIZHRbQnUieHcu5V7UA=;
        b=lhXUY+vRQ3rGG59FnpsM0+g1XMCmfxOlwF6exlEZSagfMlHQu+TwHll+1os7zwU4H7
         gsbOdWw1x+rXkAmpzAp9yfMOciu55qgsZC6+2rMsKwtToHB3Dk7IcVx3f/XAgemcFGH3
         A+PgXVoF01jtWhd/GcfvFuT0GdpfY0V3dkZ4wAZEDM7Uaw8Ty0OxYNytZFtG5n8iHoaQ
         zi4ZO+XtqHgfXB8N9BbuFvXYlSI6M891PAZmnJt19f+Psgm+1XLi3+5sXLs3G4aKRs8Y
         mjGxWTiDwI/iKjNmzIuvfyZCTJEwExBFwQQrTerLVqxAq6Cwmeuy9P+XqpXXNur3aYkR
         cCJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772208354; x=1772813154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=LfmMR7yWSQDmoRuq8VMySSMb8MeEheV9tG0G8OqPmk/6sqF0avT6fPmX07OP7d6QPp
         R8LeZJN6zJ+aybdL6KzvIV4eRn/fXKAorfRYAC9Hg46GD7soHmbbqrWu9iCrPrF64Jjf
         /83il98BCG8P0YvthzYNAGxMDWz2f7wI/2dgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208354; x=1772813154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=TBnzrrbP9W2gmsy2X6jfICEGl7MkaT3KOO/P/90DZ38kyGLqG4Lw1GsnKWD78QHAD1
         X1xRTkn8B1Che3s8zC0T6RmWkVVVedV5yydwNC9g8ZxY3BX/eXogCowwEc5pWmaIVOwg
         VpFzRAIjjAzQrQJ0xJZxWn9WnVRAV7FDOxrk7H/m4a6bvTHHG2d9hGRaZD1VXAFjzmqp
         wJIsSA5wPPxyh3AIrFnbpYa9xn3ZNjFA1yALYxR4u9zGeJqGcnj6GXOq/6vcxfB0ABNY
         hqjtC8q2VlZ07JMmragKmK2I0BYGeLexHm7xINE0RAT+w7QpCa0OJ0aVWpJQP/pr9Mgs
         nqoA==
X-Forwarded-Encrypted: i=1; AJvYcCX4/CWUqh6Lc2DIz5fEQaSlMjbJhZEI4k+IbI613hdsT0CYvdQV3G7Cwui8kRIKiOmBmqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrV06nLg0yD8iiPXSWUVO2HQQgmBwyIXm6KWQK9ge6OYpzzlrF
	JOOWAPxh3KI8+w5XCayTgIVFIeLW1eITaJJ8+Y4dPN0jTsgqHMhDaPc8Sh8V0aBA3WingjC+NF4
	NYzgHMrkVpUXcJcvtDmINGJK2meia9YNqluwoeKiQEQ==
X-Gm-Gg: ATEYQzxCTjlLrq84dTH00mIA+woEquJ/hIUeQ5agwSkZZjSyjNw78Atm7AeQd8nNbqF
	gKBxxAPXunPF6YND9UPprfjOLz0VwRMeL7sSZWFKzeayjILSlPlieW8dRpTl9x+UNsJOgiQurAx
	ixIOCuJ83sVizQpHirZZHCOgxAUl3MGbAQHb5EG2aKQB4m36S4aC8IOW4WS0FDpSviMV7KnkDkL
	bCdJMBl92u+dqs220BjFpA7tPqqeLcgXOJu0JI71n3iEEh9Qzv610tqCIKF1p+xwhlB8YTf0tfS
	s1U0ZA==
X-Received: by 2002:a05:622a:15c6:b0:506:a574:a98 with SMTP id
 d75a77b69052e-5075240cb43mr43969551cf.25.1772208352680; Fri, 27 Feb 2026
 08:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 17:05:41 +0100
X-Gm-Features: AaiRm522nNR8quw6-QPApM41f6VxVhfe4lhaNvG1qaOhqP6WFi_K60TlVjnXPqk
Message-ID: <CAJfpegubENC3LxtG8MbO4OxUgD_Pd1GR9pw6Xcob_JiG+2cOFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Feb 2026 at 00:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos
