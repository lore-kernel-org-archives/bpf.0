Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754132;
	b=y5mnEAEWIk6jPZIrYKZWl7r+qlNHhB5UYZyk8wvmKOARMmCOwO7WjAQdpjln0w+YHCFf
	 pED6886gTDW9/H1Dy2Wi8cN1LMisf6gQuolt8f+1Snu7Vnee3QRaF8NxlSXPmAQqot1I5
	 hWI2H2m3lT1Qfgjn7o2gpg4E8WH73rBVNTbwmVjZ2Q2QLBiH1X9MNhkv2ZEQtQM5Y8p+Y
	 UtUi9UqN9ei+laq6UjLncldWvZPqSu1gxgpKR/4Y8vnJO5nC3zqeJo0WcvnEg6IYQuab/
	 XsLwV3Pv34GGdYQQt+kyHA3Gdc8hOP8RevZMka0meh48RCc2+fU7qGSUYf7Bw1v3R9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
	b=J7LRCzoiSFyuq9owlkGvbbRk8/cuOYcNXXBwbH4ysja5wNrEoing+AUplJED72qJ1S+f
	 RWTGpmGSzx1nTDb2Ord3lVOLY6dI3j5nKKtS7sHlEAssLtd7oAT70VIh0gDKKGYwyISM9
	 hP3jNo97R4Oz3ozyJvjKoGLkStC4pLLQ3LGSiaAZRQSmTgBXNbfr2BCWY2732UdyQT5l+
	 RG+4+WH72V2HZqEdvWnxZvmfFDkOKiVivp+K2CNRyN21uGxaiaZ1iex5f5+GwPNzbOYbA
	 E7NwN5Q6msXsUDU2XK5RvXIPivc6GEPPYt19rjdt8V8rRIuXXuKusl/ybvG6Y75rn1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5g/XQ3c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDB606A32C
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77CDB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5g/XQ3c
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b577addee9so4278936a12.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754131; cv=none;
        d=google.com; s=arc-20260327;
        b=jUWBnM1tBIxhruN6S7VDj5eUjVTt6XBI9N4QohD3Zycd0SzZhvOAgFxmpX1AXu7fO5
         R5EW+eiJDJ/BEI1RcqXgM6uDJmiljtoN6Fa7rWxJZyzenIgh3cmwY1DHg0axuyS59nBC
         nMe10YLoYduTdTH6gc/xxAvSnT1G8Hh9dcMkq9B4npTyTv/nrwGJN4KQSyoCavgyTfzw
         ATC5e9KI8UzfXX9tLdvcnl2F5RuWk4+9J5MF/Qyejdn7faCJaIBE6UYKq8smn2XXugAQ
         FXDx1NTLrnc1Puef43/r60FHz/1lIeHlE22lH/dVnJAPcoTP5sBNCl84IMTniOgHjT+2
         FBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        fh=VMAyj4XPJrPYSxTJvmV2e2rBSGUOaBuO8qx2i2hOPVM=;
        b=o/aNj/jPg7nzxl0dFz9Q/GA5/2K4+JgmOKEgJ1Hv3oo8F6ZTPJcthP5LfXNyJcBgW/
         QENRrXEEX5DT02SWxFLaOXXWBkraeojrLnrAfli4G5NblKmZ9MblBC+Q7YD+XlKQLvMe
         cn0mjvj05KPBAASvDCwU/Mrhb8U4g8gqCdhqQIqjqHm/zILopPQnD5RhBolt9GrxXocj
         xFVf6IrUCtPYZMiS1mhdAw/beOdkHRGVkGMJNNJRhjQl60LDFSiRl2BOlgGGuOYlrFvU
         QdUIA1Vxifp9XtlJNYb5MjmEUWwp74p1D3MQWvNxyqFkRmnny2Ca1Ljyc4YgX9WTmtfh
         a3eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754131; x=1795358931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=w5g/XQ3c9k+Vmzjr8H8faYY5EnV44gyfCeTqkUEnB7IDVxBorehzGxTmotRUcFMd2k
         yEd9UzOdm44dKGOB9vhvuqA14zDF0izirGlMHcIkPmvfAWV6oC7EWoZSr/n7pMgjOayy
         4XbbykfX2tOLXKQEY71fD4ubWMAf5smyh0PUCbn4ouKSDid+wdpti8tnvMNzC9U0omm7
         PfP/4oysMFjcZt/QSyQgeX6xWgKvlNh0WDaR4PRzqjFkBPghAucojPZwp0HxO1dsPk5w
         0TrSxGukXHJtQczzx+u36Zh+VEpUmtRmnvhCaIPp54UmNZzIkin7PEC6+n43usjPmyxQ
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754131; x=1795358931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=ICJdJaMnVnPwutRiqTLouaKQbW2N+fRXDxvUD2m7Bc5hc5bgk/039Nm+6G9NBo2AEs
         inmXCJjaioHKwwiaFLicUqrYF+MM7Ks3p/qj+5w21PhLMkT9phDjXKBxg3QdTdiRVuBl
         4JSoCy30ITv39B2tgqT74l6WFauah1CJPTbHr0qF8eOf4SOzgwGZ49O8cAAS1qPtmD4m
         SrUydfjAzfxgoecPeSEodNo6WwsRj3h37nR6rI2r3CJXzIrxe5nez5/KiikCdrjyFlfY
         49dFyxiv/0xtQakcvCntsNuP04Ho9dkSpWfXFEFe9Du826l6Cu0iZaVuZvWpbU0le+fK
         DgEQ==
X-Forwarded-Encrypted: i=1; AL+hErEJdkF/XCUJ41ZYInju3Qv8VIoDN+oaJ/xP9Kq3moUNUHlg9NKbiavRSMn0ri+koI/Cvqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RfJPabKK14D8AmD4OeyDztZBACRQO0HnB8UrpgG0koMTaSzvO
	WpS6fy99Y4vtHxJGDPtX6BRzL7Iwow1vAnwpmbjDAlZ2aDJDWR7Cs2nUqZnbpcmLzDILBmDDKBx
	Gbq8KCSoYWG0owHTyzr9wlJuVXp48LyeQfuuV4Sg=
X-Gm-Gg: AYBFou2nKRg/ZIBnuryV3tScISaUTZBpNDGW1NEe7wcYiViJoazYP83PQh7F25v+55c
	P2iYwClDHq4oThb7tf1jK7tBmr56HHbHT5Hq4i9GEZ1RKmwmIiOPoJH9FhmcWgGyuh8B1RkDEwD
	hEquY8r/rA4lETV2mXvUudSWTOXRoRVPNH5kkWt0iKkqqq4BT5Am6Rh1nw7MwMz1YW72WF3j3nn
	mQjSLe8ULOxec6KzKGuRW/FQjVW+z9GGleZR/cRO6Mg5bSHS9f3FR6os7pNZkZN+HvWHcGttGQ8
	KDYPxbxUbSD3dKRVWeKIafEnr7hS3BoSCOmYA8fWo5om3ht33xWWOldM1DIl8+X1bY4MbWDo27s
	fjsWXGDwEOLR+CShVcGovtNkjPGQ+x71C6+W3tlJX3HvJ3uC15tE7DOssjApRQm2BWdZa5Q==
X-Received: by 2002:a05:6402:1944:b0:6b6:edd7:790c with SMTP id
 4fb4d7f45d1cf-6b7c0d2c969mr5932123a12.45.1794754130672; Sun, 15 Nov 2026
 06:48:50 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:48:39 +0100
X-Gm-Features: AclHuK_loWLpZnEsR5-ArAPNE_f3U8cZmm7GbEpqPveHBdFtxvcWfTtvtccYOKk
Message-ID: <CAOQ4uxgiwKsadtv1Me3ZkSsTawjNey3wDDWVAnx6U0+Oe+uoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>
> Add a porting.rst entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  include/linux/dcache.h                | 13 -------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index c38f5df755bb5..28a24b702f2a6 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *. mnt_idmap=
() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified i=
t
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and return=
s an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a metacop=
y file
> +in a data-only layer. Use d_real_data_inode(), which returns the inode h=
osting
> +the data or an ERR_PTR(), and handle the error. Use d_real_metadata_inod=
e() for
> +the inode hosting the metadata. That one never fails.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 5b3b34d271bd0..2b15179e9baf9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct dentry *d=
entry, enum d_real_type type
>                 return dentry;
>  }
>
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real ino=
de.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry *dentry)
> -{
> -       /* This usage of d_real() results in const dentry */
> -       return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
> -}
> -
>  /**
>   * d_real_data_inode - Return the real inode hosting the data
>   * @dentry: The dentry to query
>
> --
> 2.53.0
>
