Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754851;
	b=daJ74qt8IyfdDWT9PkGEtTnG9IE3fdpf1QNIFboYvor0TKmP+7A5Sc9G493hGiCzIHvm
	 mOZ/L5x5C0VOpc2d28H8UAdEEgwBHwYeS2JDYHAdofRLYhuRmIpwqWb3CK90CIESdd6B8
	 aejk0RS6VFqGDz2CGv7a/CYzTORbxnJnRZW2p+xzb2q84HQIYiH3xu+sewaCIP5Ye81OP
	 hSsaVe8di0N6VC4PJD2TYn/PuACCU9F2aSMxBbsmO0dGw9IYwEi5FGzdXv85Io2po5MgU
	 znqlJYM1msb5an15006p/a1S6In+56wRb6CgfU8hsc0+vrNtkpSU1kwf95VCLyBad3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
	b=mFCtoyZXTu3CRtlR4VjkmTGBg0epYm6Cv/lEuWvTrwkYFsDLj9k1jDQjc0MH/f5+BO8+
	 sdskV+WBlGwl8RBK6Y51FmlyEeKeYE1ukQ7SaSpeVW7Sk9mS5MQgve/CSdZPy5q93Rsp1
	 ZTUhb8w4Dz7BIEynKLDZ37kh4tT/Qpfu4zsAe6m2SIbYQy4zamZG3DjYoDpUmYCEenhrQ
	 kzpjhBtvYH6PLbX9UNMG5G4RMRY6SGGpVjYoRxurExi/npccoC2i9KmtfY+VoQ3u1L6fe
	 YoJyZmSniZ4d0XImzko4D4xULLSqkqApCTa13K6lQBpzZVNc5gM8Ixh7A35bzKm+LVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEEE606A31D
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BEEE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c50dd1e2f11so11669166b.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754849; cv=none;
        d=google.com; s=arc-20260327;
        b=JjlQN8AFvJ1Ku10oOZzj3FS/otcBN+RQEXLm9oHj5IGcVlFlrMIbb7hFB6nrUBpEGa
         FSGLUfDKPmEuUtdFjAvvcBE61PwrZaXAah6/CKn06ErqvS29PhFrxrAQG1TfjhxJ6XQP
         LQpIX0uunoSoWPv25PMuJXynTiNXvtwowUgwVoo5FvBVHpaWLSDgkUE/rm6qE7JxOr/n
         IBnzMq8+AzgP84NzTYAA8IsB+ZRV3+/lyreb7Uaow8ya6ka+NlhkTe0l4K78PzxT2OhO
         l4pEskWEhYi2LrkqI1a3I1CS3GDQog91pIj/zWvPIg1vLDFrxshCdh7AuxDPhV9/Hf4X
         0v2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        fh=aQMFwzjmtWcPM7nd1I7VP2wPOguN8sikpZUoe465css=;
        b=jUJP2uPk8vK/I0qN7b+n1WUn7fLqOzpALn+MZAmtHNCM+zbz7LqVarxi827uqupts2
         3fb4dUJ1yYCkdYnusZ9kMrhCgFpmM/SI70aaqUNCeJE+J4UN6AU6kG5E+SZmMYlclpSM
         x4foOpHX/o6asZih1sE0A6U8ck9Fg8tJdcadhDDBTBsx5vNW3AEIUuTjnI2TbykxPci2
         Wbpiv3FT0D3m8ShKmRshtKcyDntFUc9N1agzWrL/9nCymLU6uP/NGBR6AuIBLmUurXzW
         285elOT6I1ABzYVMXnten9dEaCAFaEkKsx1vNARXu0hnI+JrMiBZg9qg8KTaDo+a5RJT
         v3rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754849; x=1795359649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=SHyOkxQwYuLtL0+Qa53+jCNHfMYZrDoIhK10usTnr/SPlsQtxy3DYcaURrAaqZRP6p
         j9KX2LwDO7WvpxAFvRbeGvPMOpBnbsJEvuh/a+pWnWLMDcViXZq6b/VVaPZ68EhpaptP
         zHr4LucIEpdLZQDJogd72JZdMAkBHyXTxsReEVunL/+oJmqoO/hXoqxPt2Qr8UINUk8W
         PKisRAodcZl5vzpIsG78e9fRi2Mkv3dgu35W/QqWyi6fF9QsZX61BfySIbEHZ7oFXuQb
         7fuxV2YOwjcp9LUN7zRZYNpbm5Ey2kJzr2xgJrjMsYP1vCyRno2ESPfdF+IIuftfMTEI
         HtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754849; x=1795359649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=o+5upC+iQq4FAMb2AoBAtVFGEJ/BZ+bxcHxH45XYktkRc5tftqZIHLGBMokQmoKZ4G
         C86eDZ8x2XLm3sLof/UU3hHrbsmsAIJydKm2pjWOJUlKRg9+VnyMha+1VA7etKycpkJb
         av4VluO2f5dDu6Gw8pyL1YC+Nd8MnUqO/eDHNqdxbWWwXtHCFVd6//nO8vnIx9RaLL0J
         gcKiGOQcCYyJHCzdl2UAdbR+16mz9MOgnnXXCFOlsqUOjzsNde8ywJf5+kAew1kL764Z
         MiSDdTTVnDwY2WueMOcya+cA7iHFALkrMxsaRi52ggbVwYvzEbG/NDGGSfXYmW7oMxz4
         xMag==
X-Forwarded-Encrypted: i=1; AL+hErEHMhiTRn3YW8ytfAPYMtG67VH5t4EEbo3/nMSd5w63bTZEYYuareFhVi5wfcw7qcHZpis=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LIB03LDzzJBd7XDSPxKHmSKhcpX+nnvjTjGahFDv9slm8fcn/
	N+jbjJd2LQTW85ACItaroJ6nfEJoIF5m+M/c/f9wNqBvIv2q/CABUH0xL8d8ZCzidb98c/afh/G
	14W2NHA9EMUgdUAyAlL3Ln2MRd/LusVY=
X-Gm-Gg: AYBFou0sJ0elTziryy87wbKxSbAz/BGpaI1PrvIgaFF8TpRZTrL0xbPrJB9RNwKgd4k
	R9kyJeRWel4yXJnT+pfYo2IvyYa8Lma7GZza3A8/XXeJ456a1mqtbk5W4EQPENzpHUWrrnU6x9z
	l9TIyHi3War+I4bQ5Xp5tmvT5Q7bGKrAmhXi70KWBl7+ZaJ8eHflfB6njji/tDD1G4JpPfbImoB
	892lxMQG53palXrQvXwvy1EAa90Akn4Of0E6McCIOnKEFAFU5+N3BZXlhzhtVB/dWl8QN244JQA
	CkBGawUyyfRRg8vSeM9bz8+Waw0S5KyxnuyUuwVWeSdWe5Q8+RMGySbaPQ7nAPtnvc7hL1SbC/Y
	sREzpzebQIKzXlfwPkkHSEwFjY41xAJHN3+1AU2lgFzfy8urlgqugdShFYwQ8W3qbojL7MQ==
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c509612a23fmr694079266b.6.1794754848470; Sun, 15 Nov 2026
 07:00:48 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:00:36 +0100
X-Gm-Features: AclHuK_wHYShIpzO3KRe2QttGftKj9EtJqTGjYXExDCpgXdtVHvMQ3jGuPVE7gY
Message-ID: <CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+3775xA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and d_real_metadata_inode()
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
> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).

About those promises...

>
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>
> No functional changes.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/dcache.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..674bc50b81827 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_DCACHE_H
>
>  #include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/math.h>
>  #include <linux/rculist.h>
> @@ -660,6 +661,49 @@ static inline struct inode *d_real_inode(const struc=
t dentry *dentry)
>         return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>  }
>
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return d_inode(=
).
> + *
> + * The union/overlay may have to look up the data first. This can sleep =
and it
> + * can fail, e.g., because the data is missing or because its verity dig=
est
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an ERR_PTR() i=
f it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(const struct dentry *dentr=
y)
> +{
> +       struct dentry *real;
> +
> +       /* This usage of d_real() results in const dentry */
> +       real =3D d_real((struct dentry *)dentry, D_REAL_DATA);
> +       if (IS_ERR(real))
> +               return ERR_CAST(real);
> +       return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return d_in=
ode().
> + *
> + * Unlike d_real_data_inode() this never has to look anything up and so =
it
> + * never fails.
> + *
> + * Return: The real inode hosting the metadata of @dentry.
> + */
> +static inline struct inode *d_real_metadata_inode(const struct dentry *d=
entry)
> +{
> +       /* This usage of d_real() results in const dentry */
> +       return d_inode(d_real((struct dentry *)dentry, D_REAL_METADATA));
> +}
> +

Wondering out loud - since you needed to change IMA anyway and need
IMA patches reviews, do you think it is hard to also gracefully deal with e=
rrors
from d_real_metadata_inode() and not have to promise that it never fails?

This question is not intended to block your patches.
If there is a reason we should keep this promise for now,
I have no problem with it, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
