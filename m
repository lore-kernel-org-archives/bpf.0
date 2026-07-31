Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28940F744
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501325; cv=pass; b=JJvHpjrSQh0VttmNnxx0seE//ZWwxA/DxhrAeB7hearmSYe05/6pGqz2I1PClQGRbzBhVgnh478QOkP1gEQ0Djs2gi8K9/C3bcbnS6OzlT2YqFTmKoxisofwY6/xeRyNWqqoMvO73tgmb4IHsEo4UJRxcF8KtDk6KqWogT9yQSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501325; c=relaxed/simple;
	bh=UEXA2jz7/8V+cAKqn+ecsYKqLFIMPeiztSrq0J+wmAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5ePKsxAPCnJvce7PR29tCH/Ldu0oFZ236YhbqKdVGzM/5G2yUnJg5ZwQDcw8eRna/SFrzeU0AX5b+U5zRC/asuLWHOw5YUaEQXsY6rzr6FlpYSy0Zq1tKupWh+QRioVrQRKXUZHQgfNcqq0i+aWrP4Inc7VOTKzXbEOnEXuvRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXVkRy3; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXVkRy3"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aa9606ddadso618414eaf.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 05:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785501323; cv=none;
        d=google.com; s=arc-20260327;
        b=KnVsderxUfWWUP3mWOvfptpw0vHwBd2nDgfICFXcgtSl6wdYwCzqvizFjONlA6pn54
         OxzNNs8FlZPymatkQMupeByZLuXAt3ovYXyHhvB1fIAPX5cTeXuwRUmA5oOgFoXXFmR3
         e8fas3vx1iUT50oBnd3/895H9SDN51efVjWSiP5xc5vk7iKWSOI0CXe866413SFwAo//
         puDLPPVucEDoXfaOqksIv6KYnDv7ruHS/zLO5GQjzV8iFV0890WjHg0CqPd5/kjMwKp5
         1eTqPdD7Z1OrUll/tsrsXVON01FT3UJU9zQ7sYI8q/pK8BH6akFTONivWunF9dy2PV2D
         rQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        fh=OuF8M1vkLeJNHJSzWoh5flOUmqlp/vDLidtmIMYbKM8=;
        b=kM3kzeDLi2sAuvLUrtaNUxTbFfHYUNK9f1bjOXi0efGEBL4RsBA8kPrADV4lESm7zH
         DsMnTrqfFkWD8BJFlLwNqH54m5PStmQrg7QqDSAhEDS9k+rHSWzKELURdxewMP4ZfXgZ
         QVHZGWofh8iPS6UGkLv7QgrijcCyAfkSfeui55BHZ2VghCW12ULkiVmmxyZV8HCxjVU9
         4JcTXkhr0dYsfIjDNYa+lY1BeV6ihanwRyy+KZQV2u6eJ4q2JUIvEci3n2j9v98LvljO
         RHHdXNAbfhwZAlR3AcreOMYUtkqraVH+rnuh8xXUE/ekTtOcasEXn74KVEAvGq19GsXq
         Ph8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785501323; x=1786106123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=REXVkRy3KxPSPr+1PvDbz53nE/VdaLuOmJyFOcwmV9/GnhNCzeZ+LKuWgCI1kLGTzz
         sA8noSXGop1VRy5mJv/qmiWYoURK89NTQQLd3e8h7t5tyCNKWx9c9b4aMDqIYPu7Ov6j
         w0PXfFUz70YrS2zcA6g05R8Ck+Pllf97q9vn+wbtNLoq48MOhER6RrH62c9Go9fA2Hc9
         IHdp/Kkxh2dsQYLJS7R5ebo3N8cABHgcasxljvAgQD3MMjQgxb19FSEkSnsoXoV4R+ql
         MJu/vwTHzM7ho03qU1J1SCjmcXrtJQ3tXsejZdwt9Jm7K5gw5nQFvzxaykrZr2VZ5sy0
         rnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785501323; x=1786106123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFAI/9+RvNlaopRe0SqCEvXX6CBi05C4fAg0TyUNeEU=;
        b=aMHjIjSokzYSFSGqDExr3DoSWpgrIoYm90ZiZ4JbtHRC/8e+kKAv6TNi9gKR+iNwf5
         kyhe1PVmmecUTpW7TbRth+KhuFArdRQtIR9DGC8xRbo93zDir5gWV+wRE/XKB7bsgWZU
         t++sGBXOTCc1w4GEC35t4hSHXY/uT0C0zzSHy5JT3caT48XgWmW1IjXsk6pVm1bnq8nk
         NYyU35GbJokWHeNfwHrmDoMI1NphzALOqMPK7H/C4FN9Fztrql/ltRGDsEFAG0zwX0+m
         +yODA1C8EaYVCP5dXaTBdQ31YbU/1B7uCpl9b6RB4sD0wUnB4+onCPKeFPz6iSN8M7i0
         yRyg==
X-Forwarded-Encrypted: i=1; AHgh+RqsDs8ctVEe9x+kLjalnuq0/GvvS/Agpvv8V5r6grM8QGuIS6BNjwH16b+BL1XDCBBHK64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBa3XnfdsKidrxC2fAkPMmIQIpJnwdYcdicIElvCxtcx4uJpID
	qk4EmzOLZQfGJ5XkmoCYjihSVN+Rl90JOzjPfA9iIcvEGICRhSSSAwDV4iTFo0+4k2W/o/x0R8l
	qZF/qmpWR/rlODJbkUnOwmgUtJcgvL6U=
X-Gm-Gg: AR+sD13gpgMaM9dJbIe1WUthsLHkABUp6WcHtIKZ4lqgNzEPPwqVwhTa32+C58P3QF9
	TebT5vuSSUp2mFPW4w3JDyLLIAKfsHKzY5aRIsbgosWNQAos7AJ3BPNotySJtiNcdUKRdh+f3PW
	TMmydQN+r2N4fcobAwloajrk9JxwFjbcrsBMJQVRZcF7MslpGVAsUBLmkayLzvsRoDABwl5I5/T
	WeIcUmcwamU3/p79C8PfrXuhWeyPUiVFHra0wxjLSOJqbYFqMHf8kH4kcth2Fw21wn6MXDnwATo
	UoKhsxebkkOrutRSj3ElD13y2W+mQQrVO62qc2VQgh4E
X-Received: by 2002:a05:6820:c0c9:20b0:6aa:e252:dc59 with SMTP id
 006d021491bc7-6ae37cf9c54mr1615552eaf.5.1785501323220; Fri, 31 Jul 2026
 05:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com> <20260730221508.3846409-1-cmllamas@google.com>
In-Reply-To: <20260730221508.3846409-1-cmllamas@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 31 Jul 2026 08:35:11 -0400
X-Gm-Features: AUfX_mwlKgyb6AEn20yiXH-27f3TnQmpcyFREg2qUfV_pjvNieyaRo-vjnWDeh8
Message-ID: <CAEjxPJ5PPyM+fkMnLj+FATHtoyYg4TK+tthGpudWnq52GSF6MA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: bpf: check SBLABEL_MNT before isec init
To: Carlos Llamas <cmllamas@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 6:15=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> selinux_inode_init_security() marks the isec as initialized before
> checking if mount labeling is supported (SBLABEL_MNT). This was fine
> until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> xattrs) and yet leave the isec->initialized. This breaks subsequent
> calls to inode_doinit_with_dentry().
>
> Do the SBLABEL_MNT check before the inode security is initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Just re-affirming my Ack since the patch did change slightly.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2:
>   - Move the check further at the top per Paul's feedback.
>   - Collect Stephen's Ack.
>
> v1:
>   https://lore.kernel.org/all/20260730181008.3654413-1-cmllamas@google.co=
m/
>
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8d6945edae7a..18dd28b2bb13 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2974,6 +2974,10 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>
>         sbsec =3D selinux_superblock(dir->i_sb);
>
> +       if (!selinux_initialized() ||
> +           !(sbsec->flags & SBLABEL_MNT))
> +               return -EOPNOTSUPP;
> +
>         newsid =3D crsec->create_sid;
>         newsclass =3D inode_mode_to_security_class(inode->i_mode);
>         rc =3D selinux_determine_inode_label(crsec, dir, qstr, newsclass,=
 &newsid);
> @@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inod=
e *inode, struct inode *dir,
>                 isec->initialized =3D LABEL_INITIALIZED;
>         }
>
> -       if (!selinux_initialized() ||
> -           !(sbsec->flags & SBLABEL_MNT))
> -               return -EOPNOTSUPP;
> -
>         xattr =3D lsm_get_xattr_slot(xattrs, xattr_count);
>         if (xattr) {
>                 rc =3D security_sid_to_context_force(newsid,
> --
> 2.55.0.508.g3f0d502094-goog
>
