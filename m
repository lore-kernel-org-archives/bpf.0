Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754480;
	b=D7REeNr+Zs6Ml195QQVdbezYYm/HpMZTtE/drwzPTmo9CKqVUWuOIfKx1Y1ldwn+TrYM
	 3aN8DSYzDRA3QRVi1wW0aZiE8+oTb+qxiNPAsPe1l1Ie2G8Rh28VAC5bpkS44+SKGyefv
	 1Uq2AO6kzMhhOseZjMyzk6W5uW7p9rQNk8Aj41YJ3Ficj/aRSSKHGRQk2oBs3y2zWBDRK
	 7jPKupsuNa9DhD9W64nhrfqoMebRRIKWYzRPlTkpsBEC9OJbJNW/36NcZK6aHR3bp1nB5
	 jf8DqxrFNx0q2BJtqC+WZ/zZV38y7BI7P+OKOlzlhiwEXQvKm0gjFjatJkIwfyyZytA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=AMDeJbOsOit+kBlpng2dzMCOIrhmBc1IORd2XHRI9bJxIbJRnk5ywXFaChMiR82Gkxv0
	 7fi2zf+FrHKc5Tt9cOqWS0wDjdV6zN0YJgXlPZx6I0t1GegaiBdFDpbHVRV/d/rqm9vpK
	 gv8jpEVj94ovV161AR2lSylf8Gmg1nF8pKuNpdzeMph1uB29oaDmSGMR/Bi8eCI6Qk5Du
	 3EUbpkrcA9/ynSk5f/c7jh35LqM1bSi9gQkq1cdMYpvsv9qaZ/QFaA9erKBNi9FXzpEKc
	 vNjXzFEpT0B33S4fB8UEPAvaDdOAKqSeJNWruMGacxve99cQtsRhj3Li1cRgAJdwvqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFE9606A327
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFE9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4466939a12.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=lS4ZUaW1GVJXeooaezrXzfBd8RhCjcDeUmQhdkNn3GDJTjksBq+ROIipWaDhel3A3g
         tjGG2MA+KB35v3rQlHpg4b4kNBkkWWwgKsheOCY+uh262ICClpWe5Moh20ii/xIr3d/1
         PFyylT8pENZH0jS+7BggiTm8Bscxtwl4twYndjzDmWHZQYWSlO/QcWTAsLaMAcC5pZb0
         vvzpXVsk7eo+jD564RJWpuIE2nllfWmqF/s2WC5iYLRbBZ+KVRLdeMXBKLGNmZBRVTnZ
         710ArUldZ+cZk0zaMhzZi5mT3I/1WuW0WhHDbeed69LH1v+kiH6SqsWaJ8DOPT63I0qo
         b+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=Qz8J2fL9I7IWvG/rzuAt3Ct4xQDzrBhdZ8dmX5s8YfU=;
        b=cg7K9JsfR5RI4HfvdKqzSANTV2lM69Xp+EZT2nE4IJT1e09vGvN8BaB9m05+4JWaRu
         Luxltlv0S2d8v7zAyOg2ExwRdfZ3TEpbNZKyWDoclcGefM+MwLedd4fc8X2xhkE6vN0J
         yXkhCyxVfSpDCyf23HnKiQUohcFScOeVWLuuPmQDJ9ajdoVzzdSyB9e49OLg9pAuAvb1
         PHJC8bJSZzLmYPU1x56hSQ9yAFZfB6jrqC4F5+iYsuNwm29nlgJGIAPIYFFD0xOhxIkF
         dS9FVUla3rmFM580tJajR7ZM8Jj2myKEHFxrTnEUf3DsN2Scg+spXcIFHV1bCKmSHuPJ
         /sTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=FjUglF/+5IylVgt3I6gLysLnrDn+q4tUuqDj1bOFCWwTULMRMnDAnrr98yeqgl2jtk
         yHRbrATAq3jCslL8uFBSp8KOL3a0pXri5X4VbD76kiEc7S1ySi9jp1Keec/DsYB7Xerx
         QoCYYXIH1J6GSCwvZtYUsxUyj+RTmMp23+9O/nB7dp8peizentsILcJ3xlOnOfMPlDJm
         ClFrYmXs4WF+OqhcIgKhrovvk+F3tTgudsmnkUKmAcCQguWw9OX3fuJ80+m2KtvKN8Gm
         UNnFTKyl+eYPxjFAFDjfzOzB4h+QktXzfADVhX3p67B8HDTacp/TKtAlxOTrkxWBogRI
         g3zQ==
X-Forwarded-Encrypted: i=1; AL+hErF0CEcHMZ/DANTVlks2e+Dnnqc7BQr9Mtjixg+Kr0TylVBbLV7AAxd9u5+ZsMgn3CL3Sx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pJOKO68z/9e9v5ZBEQDsxGs5hg/nck+iwu/X4l9HJV18DRl5Z
	PaeX1wYvQ7AReMXR8ryLh9HcSTsSe8Yt8OrGAaT7fOZaGRoK8EPNLuyd+o/EoHxsDC1zXejOStL
	G5eKzDEoY67RpTR3Oino17emKohIYdOA=
X-Gm-Gg: AYBFou0hdtWipKONKx7tj+1+haIWiWjBLlIwo8PVG0yy7iHWSk0YlflWjqXfQe/FjyZ
	9psjuKNK+UM4TdbiRbuXyAVeXBJHniFHchxHTd6ojJbNW9nDIHcm5XMifWyZiOdi8I0VZXUROF+
	Gx3KNaN4ZyOKhjzi2RAmbAcuCurdvXjMn5PEAqbeFFX4rCnr7M23aYrXLTHgaNPsBib/KvtWlAi
	9mTlRhgPTg0a1Ojr12LjC0lSvNP1uMte58xRbkMS2Yh0YkimZ6ghC7jGXO64CjXc/GjcgjZCIrg
	2F2u+WeEgS/zv8Wl9aWQq5t0yG3wkW+PKI2VoJlYP36FBXczuG3G+dqNHtGkTi/sWijCCvpSIaK
	Lu8DMxn7qRETloB+YMqK2OT3MD7lE4ybRbRoP5gIdp8njc0gWrXRkMYXbBz5pq9fG7Uzt0Q==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
