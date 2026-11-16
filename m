Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794850649;
	b=OYDC9Q1Zmx/iWTNscxFaTU8V9jx3zfedVFbesWZTMQs8avVi7PK8L7ZCLR31Ev2NWCKJ
	 L+68lO9qB4iAq6Cv4rD7rxheSNh4pp4oXb1xWa0gWSz72nn8uclExQHyC81jfeHws7SCm
	 U3RhiwjeSPgBt4sMFfLzHEuqEpTqlNm/hu679rHpC8x64RZn3QjpPYeD2CKlPtAIaITEu
	 1234EuwjjtC95jeEsekQashhzWuR1X9F5/UfShuJ7EJzOdQfO/kyfMJZMVZeIGfZatgCH
	 dqZY83B2TPnhTwPm7BMvpOCBld8HZA1C2qPsKjAvVZerwge7Cq+TrVIBZh9rauBKRRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
	b=CRLXYe5v1HyN8GWipRt8ZRJ0PrwDESnhdQV4RwS4LrreK7nSrZONP4ofM60QB5aSGOkx
	 GxKid/jbTSzKBSwUQ6yA+MWl/Cdc8kLcnjP+bmn9nPWsWhjew5RR455U4YfqitI2Ah7aW
	 F+jgwmrtWu2dXtJyqDVSuueBOKnCy34gUEMqJDZWBwIyIzKYWiKPLK3e9m2iCVCiNOMoT
	 fUuHZuhiKy0cy5c6tkNQwtGj0V5+UK8ErEDBD3GhInRobr7MzxxjmBHTnHXUFJsf0KdYt
	 Jieo3ql/A1oyegg7ON2BhUGUnryHpRAq6jvRtev3mTDSvSJN/KfAebnbCJgKmfAWRmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C43606A33F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 17:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C43606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wda5m4T+
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so218686a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=V/c+OGGZJA9+xfiaRngN0nP+3mPOt2uaru2qNQa7dPOzhumdTfq7Obzq1GwgsscMYQ
         +r7D/e44GOQjxCZ9inXbjpLm7KLyB5KKgsygX9QJMUNBpwEqyqkRBZScKPJOed+65zlJ
         d3pSTJJkCyGH1v+tAQZRcNfNfe7koeKGuS73WeNK0/ZLCa5COSpNhW+hnWUjyqJLfVw1
         jaQMT00oezHgKhz0npvKdt/4EwbBbGfq+OELXuiV5oKi6boV7sJyqjQPNGSHp5jUp/a4
         IboOY+i6m+pZLK5D2oBXr7IFBvQJWDKITTqMcG+dkWYALoy5NJKIK51Opoh/5/ONX9VJ
         eMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=gp9vcJQ05KdWj6xvPohCfjf5DmICr9Q7ZMaYFTyNY40=;
        b=S/GQNF+9YG9Ba5ZoY44cdQGJPiVFQhm3pdQOgP8qEigKa7daNg10hSg2YOR4sQgM+Q
         tZxAU/N9qIi2sYi5naYxyAiwaRzHYY6cup6RtPoTTqyT3Ljvut6s6oY0AlKzFJosHte3
         BxjlmZPpTvc2Ky0xALrQpHiz356o49qYQim03m1IuwNGpgF2WFJrRkAcBPyS7cdrcvtZ
         7IJt9h1SzZd/Odt2R6G69ifshjD+7aPEuf9gEs0+z1riibtApa7i1VPZSKpoPhgjp1ga
         7fYaygaDgwYx6258ITySRIzxiLr71aCZ1smIVQ7CSeovhVp47Ms/84ljm1E1G4gQZ4Gx
         kT2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=Wda5m4T+Og74YNLartpajMnAcctT7hnb5haqi9hjLlBRa67TYcEPjf80gw45qsgIx7
         FMobW/aC2ZXQsUmoaLilVLeaESS9ODytholTX6ZkGdI39Z50BqAMQuVm0upEGdU/eTIl
         KzXBiwaEJY7eqa6p49n+ZePGE0YUDeVtz78JPQJb7w7ae3zRsyAfYOAEtJq8eS6befDe
         ANfoXo4rOnrr9cTK5CEQbvEa19yD1CMimOfBL7pxwr0U+pGpN6RB970vgsC2xV+kB6BG
         DqloDFELm5xz1LM2zdKvbUwHIwogDmvmrNVDo81Was00uh+K9TR8cjrFQWZvFUjBWrt9
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=o6+abVFAx7gLv3gtpIFZUNhAuFyb/yNDv7/jZAYoYVVuFIMkHZNCloRu6BPh3Rlywy
         Gvi23l+KlDKuNbJqiUU0EQqEtMogzL9zJU6C4xsH0ilLFGKkrr2xAqRuGy7D9KwOpuDV
         TRTOndtafX0MoaQIwwauT0t85jB+G8f8d6S5Yvlw5kA2IYa5OHyEozMsnkPu8MEB1QVL
         8WAZTpfoNlZXA8dvuEtim+xM+Olxf5t77ppYq6nFpBKEyfzUkvEMdWP26MlRcHDa1CTU
         H1mwyWj1VFoOusI4rCMx+HsH6oDYzGLeRIhDT2KiOCMnXUE4jVm/02Qvs3ARVcaVEibU
         7i1w==
X-Forwarded-Encrypted: i=1; AL+hErGMr0E/0QNe1joTdnTmxfNOJEDiCHNVIfSi72vScSi+ev41sFU0KcqiwCD4EogigVzUN+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z871s0Q6/EYu78enRWFxWo0cskcBlih/ZYEi9xd55bVVxM8gWtf
	fQpFAdFl7HVHQXKDxCOUWUI6VXf1ET23t/J+SwQdl4kV0NwYc8HIn+SWra/BhfRQXEkBceNkYku
	5DGreXeSD5MgkjIXpZodXilrP0Dldenc=
X-Gm-Gg: AYBFou3gDffti5FHAekxIO2T6mIt0UT+7H8RHlkz+2u2mIYf+0/XnOx+xDTP1pxiL/1
	opA9QsvPZ2wGOFM/Ii/F+204N+ZpnzowAh4ORFLJ9EzFg1CD8wsm8Uv3oTRXTouUu63v4+qLoBg
	FyRhuSwhO2dbU1o7j0s4vFpKTKuv/fS2/XgPeRyvENP8N0nLQtdhvymv3atzsNkz+F+EAu6j9Tn
	oyhFtbSNgZzXcO1Y63dYGss+qmRgWDWWgtnwa8qW8z1GM2O0JHKJBrVVzIyopJGey8d+AKo3qIl
	eemJUC0fupnFb3PHV62qbHc4MBEqyxVpEeW2R25gN0UwmcKNUDSfLSeu4/1zQh1YZTtApGa7g4s
	ZaWpB1OU3Eh9hxHBSz0fj6+QNGKsrmivXZ+fcmrZ8yvbTCuP+80lK/XlGj8WC9Bh2W0Vpvw==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.
