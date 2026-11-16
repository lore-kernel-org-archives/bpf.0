Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859646;
	b=gjOne29+kGPSuwkHdgr0YkIGVLDWtX247DeAL8/LipbzyyVR14JheBP66O7gYxjo78Pj
	 5OEwwXA2CIFDJhgUiLTr0QJpO2U0SDF2SCVpxq0DRbp6JYOHJdJ+d2Fm3DfSXV+xu2pB8
	 3xHppTeohQ9YkwStm4oQQQfEFwxPZlEyntLzcOFkir8+1grFvatzAEVqbTUt0Cil+4TAQ
	 bSIwZsRJY49I/yZra+C8lAvZlu7paApCNl93qgrW9IaRl81JqzIIBWdAXcOqd/vz9HruP
	 DAJ3gRKhG6s3A6lktY0/wplD4AF3RzJzRb6EdrgE5O017SbKFTJFawd3Ew933hgw7qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
	b=bRDB/+/gIU91POXONiBKN4QQsc0++Pk+z+lD4x2kJSkWdCv9s8V+CjCx6+fKPUKWd5+C
	 q5H2TTas6fwr6MSWbI5dmaPbw3arjm2kxzkxPXxTrrOxikIB0UrMgmMeLBoRX0fNvX5me
	 HXzSPedY70jb+plDJRzb6L/soh4Z//jyo0afkLV1ul/0M5//zyPg1T8QTozy3cpO6TyC0
	 q1vTFhiz63COH+LDwLo6o6TFOFt/yps0ttCXy88PNvH5JhrqwMrqwYKFXiPxl08DQQzZQ
	 A198RzXEeWOijpb1PyrYcKwk2dQaZQhRmbDTdTTnjb9xBWkHbk8QD0LgcU5DVLpSxXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D70606A338
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D70606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso24829905e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 12:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859644; cv=none;
        d=google.com; s=arc-20260327;
        b=d28bZUU0qxglxgdfJ5TLIdn3l9WY1huGUUQIefBxCMn8U+tDFGchcM7Ce5dMTIXSoS
         91eA0Xvr0ppFCFJRqw20z2iEPgk7t399v96FtofU15nPDLZDkeAlRSCLRu+3tR+ey0O9
         llYeSDMnLYMpfvEvGnUjnGFhQ/e7p0R3f/uBMkGxseF56QNYths3ZnVcDG7FRb9xlKhF
         6OjC8YRUYlIr9tb12mhCv+t/pTGO21OiX1pFu51NIzK/gAzOHKKeK5Zc10Cq61rujd3f
         PO0yqvOkco+N176yqkTJ210//dnJnZsvIEv5uH+ULiB1h9QsAzXk1xBILcl0E1J7gmgT
         uDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        fh=4yIIJ3ttTy3o/IskNr0765Esi598mlQJU6hKuirS+jI=;
        b=sB7Sus0EwbFX+TJUgRwRj2uCJgJ5sO5q/6MZ2mhNkHjIcDDl4atoPdAJDDtAMN+AMe
         0Bf12WJo4rRpXhLyAOFlbUNaRgFbHGzTwhFCLlAKIXIcth8SncVJWNt51HyxNxj8rXGj
         8i7snJSesxeh76eUISGGSWu9OfmAu9CaPiM1tdtCwxxM2OaOpMEiPc+oEuOwAU40uIlv
         WPehJnWxGpJAKeMAsth9w3u6GfdI6CnoBhLA2/tAlf7XdaqK2BJdW/fcB4b/F8d5QJ8R
         0zO25fEMxBFZmr9d/Xr0zomlVitwYIHO1Dm7SwNBTOkB7ODG9oWcgL22mYJmlSMFWbDa
         HkKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859644; x=1795464444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=XFDBy0c2q6nTYiJ4dwLENH1mguXX/IcFF58gOeYQArjps79P1XpkrhGZpUclTyZwpS
         r/ZYwRoOG8WhRg+8JvLZN08T5FQLHs7jA/CzeQCQsJeulI93s02F+iYtli/pBjYHG+CR
         W2MoU0n/+grSPpLZW83MAsn9WQiLh5CCwtBf/0GxLqRHC416IFZ4i13TeIFhLxmbz0il
         NPxDzLDOL7N17VVYsTOL0jDLDvB5woBcjlvcU+oGB0Wrnz6q9rCc3VHuwmdjl71ac6+n
         fuvYHmykPJU4vuSvTSKMetyKY9BqLddb2of0qXOJ87q21uNxSrudqkhk+T/+cyqihyd7
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859644; x=1795464444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=x4xSD0e7wh2nLttuhQY2FumA9eL2xi0G+TghmIvIK26g7rT9YhJINSivEJVqoCsWY+
         kaFd5ukhregj2aOFSKBtwxUy9N/gf2hrPvWffQDrQ50jF7ybX9V1lCh01zFvwHPLiUJv
         AD0Eb6Tln/lVO8JzvIUW9AeR9cjDNH8/zR4EEw0FGJ653QldHiK8UuOD4L1v+2hP/4aJ
         Pnk9b86eMK482YpiCMBk5AiH1zIB3iczD7jXscjh7P60S/8vD/w6WmCmz1LoPha5a+as
         b1SbOdKescbrjEIjRthHZsPlfdEtKXD8RB5DGF55wDjds74GLToUg66B3vSE/NHeb2HB
         aBHg==
X-Forwarded-Encrypted: i=1; AL+hErHaYaQlUX9FWpMaDQ/61pJLq+3jRyltZFXWEDSlKjTOwcXRs7ciyHFHNDFl/z9ZQcEfu60=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3yIqYWJKDm3arP5+27LzfkH33vScrzrzs0cSFpFQfUZSJfAQe
	DrYb1EgpJT7AbOVpeCaC5VFzd1pMjkdoafgChpt8B3pRBF2PJPYUoQyrDN+ucfh0b59qyRjsiWW
	UcGsuRbZzuAi/TNvG8TC9xm9yzhW9vBU=
X-Gm-Gg: AYBFou3BfkI52EQLHW0NDOY+uPeStVRHqflJD7KbMUpY5zXYVS0ulpug+KEV3km0wvp
	JXptUWISlO28rzDuNCfahnPh16qOiLPJuIYcZH7KJSuoc6rwCGsdOnLA/Au70Jv80I3wWlQX1FP
	5D6bO2Uor5dyp7wJIW+UGjL3Ft+sPePTrRnv6pcfPhKLu5nQfWbU8AxIapRAiOYdAbFGd4OrR6l
	NRhpTuxJxqa+aEyGBsTgKM2jAmoug/SFs3x/B23NeNOP9YRm5NyPN6EPOEHO9W39tOZTXl5F73t
	lxYSliNb9Z5yay9Ln22rFhnIVkfEbfcC63BHMsWcmUUNcLQlo5Cky3eM/TBV6cfyCMXSAMlPg3e
	28SANP+BUF2K4jkkQh4L8hUDB6XV6V3Akhm3S6Goq7bbYsOnFQeImdEQVEYUvyZibLVXEgbt5bs
	lSqjW5nF1LLvFUA2KurA==
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb55a5d6bbmr165067875e9.10.1794859644313; Mon, 16 Nov 2026
 12:07:24 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org> <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:07:13 -0800
X-Gm-Features: Aa3M54rpWiCplKeR8o5TX-NbYGDID_36BWk-3VAyUzdEoXSYZ7J-t8pfWvm9Fcc
Message-ID: <CAEf4BzYANM9vtQ8L9-rJPQC-tTcw3YUGsw=qnCaoym3+EU=DBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
> __vfs_setxattr() and __vfs_removexattr() which leave freeze protection
> to the caller. BPF LSM programs call them from sleepable hooks such as
> file_open where nobody holds it. So a program can modify a frozen
> filesystem.
>
> The hook may already hold freeze protection or locks a frozen
> filesystem would make us wait under. So don't wait for a thaw. Fail
> with -EBUSY if the filesystem is frozen.
>
> The _locked variants are only used from hooks that run inside setattr,
> setxattr, removexattr, unlink and rmdir. Their callers hold freeze
> protection already.
>
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xat=
trs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, f=
lags);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
> @@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentr=
y *dentry, const char *name_
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_remove_dentry_xattr_locked(dentry, name__str);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
>
> --
> 2.53.0
>
>
