Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4604382365
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847252; cv=pass; b=CF7qVGNAhUraB9A/+zwnXrt86RqZ+cfFhy2W9EaLZhSMB1Ky2iAB7DI8ePt9P7bn7kD8aScJqzTJPX0Bq6F8HqxxOkTB6/SgFiYCDjBrilVuTrQMBKxJ9cAsFz50NAS7gr8wqjqNwE8owOPatka0ce/3wnwv8jaFSTbf30yaT5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847252; c=relaxed/simple;
	bh=65J+i3G6p5lcoZBTC4phByocAAxY190VmOFW7omB01o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnrl4P8tROSjmOy96LEMWrSdErUalRcDH60mTomCm04NEQJRuKmO9wf21tQ0/ji2yHE4rHZCLpGjH0YTOSE50xRdWOX1r9lR4s/katfFeEx+hAXRSiRMw8qrF1ZZ5tmZ26qa6WiAmltGtncBs8fyeZeMoQAZ9IYLo3qisd5HMBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=X5MxhvYP; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="X5MxhvYP"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37f72212544so4628226a91.0
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 12:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782847250; cv=none;
        d=google.com; s=arc-20260327;
        b=Ia2nACpxf5K0sRzk4UW8+IxTw6OnYsSFCthnuY+c2ZnM2x4a7Dfd9dcOEgn2EQr6bP
         lwNk07HVMg/kIBFXPUBlFRYDHZjxstI8B8yvQN55h2nGZLGAUoz5ZxtM0/Au8hVF3DHO
         10gYddOXBlxNzeNw7oycHYGzk82emeCvQsmxiBEe/nRcSQnq0RckMBji8pwyfaG5uLdA
         fsvBEya9uEavSsxsWEe1GeOpwh9q7crY3lxCmHkJYVlWQ2hVQOZvq7A2ayzuHDnhtctv
         Md0EtrZYTM593Xs6krT7SJP7NpV9O0ZzWgKBNf4sLTVlhrLLh0uM5e1KCLd5cBCemzrc
         mSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        fh=Rrg+Ifn7MINMu57Y8J/hm5v16Gdw8aoUk6zJYDHA488=;
        b=CsArjC9lCUdrrA4+mtyuKS/2VP1Er6pGN6KrB9hEoIR4mIE6Md+AWm3AGGnIvPMQu7
         o1cfELrVsEq5ZnMVCSJw7I8iOjc/UBHwgRsiZEG/LoYoP0YaFM3zDBIoggc/7i8Mgx9k
         cjQ6UVvcOTPjqt/U8SF1caSATtYFk4jThjP4BQd6+04YoAH92aIBkWWNzZcYZfjgJdbF
         JLmyJd8P7toXHPC+vbUNE4aCv6A7KeA0JfwJYDtN4P5h42Q+UYaBAatiGSvezV/XtmeO
         gZeaXguOMMXlpI79lfUsTMVQ/0kZJTB4guKoaQT6IrrqpYLdm/iMwybnVIrxUiLjex9z
         UxAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782847250; x=1783452050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=X5MxhvYPRN3WA2wN8tL/ZYk9NZEiQbt3zp7jjJgltzxvrPhMcgDbMg5S+ghGO6JFrV
         O1yiHUL8HLKhu//+JGJnCXi8eneIZaFMBhsfmu5xEyywT94F+72Bu6ykex5UZwL8hC7Y
         x9DHn2EONIrEHKr+zJRocw3ZO6DRVypGamAqAhU47sT6463F2xW51r6rTRektZ8qZs58
         e7c7/MJZFGQ2SLMW7XGcoPsGAHxHtixGOMzTpbI6bkqY+TSgjJ8aoDaBdqw5170xOh/K
         C7n1uxfzAR1/ftJDft78tixUKOMmdPxBEu5FgTwR1H8tgsPowu45eEy5Gat235dRyPTg
         EeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782847250; x=1783452050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HnheX6+q3F7lhzv+8WY9jgB+q1sOgaN80kpX4FHTGh8=;
        b=dTo10acgMcgl9IPzyZOAOcCkRL2hOVWCQBlxoPQNv2CwTMwQ6rqyf1y1E1RAAyf75z
         Za0HrR2kfWMps9s7v8JZpJZ1kLlpAcUq4oS29cQXLHBPZ+QrkZ7xDEq4S6aJa89YDT/t
         lAxUPM9EGGobBlK/W1uaZS2FbZec4oXm6PyIojbyKCAfXFdPmD505mlZgCq0RF7QQQKF
         3YePfcbyEnGGYg1JYAnpOcEjFgB2GVEdKqEGyB/fcRKcsEG4DJCNALZrIdHKGzFBqRN4
         Qtjs+xqaBX9kOID85Rfay87QjUmsUn18fXcRT6JHiVisZtGhczKyjmLdBt8VSXkfiZ4D
         Qfig==
X-Forwarded-Encrypted: i=1; AFNElJ/+DxOVbzT/lAqHGc8lE611tcgKgkKnma5993R29NGPs4a2dTELzd6Itgn/ndpgwsDuAp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzowfXwZOK1qT+r7Rfe/kLMNhbXqDzeS0N/vS7mmTte8LtHDldz
	OAgpfXaIcPvSuw+7pR+VHSxx8rVqKHKH1NWHd+1t71AxjLVxQwDTH13XcR2n91571+VO29F6mYe
	aXCz1juiFC9+l4cVPQBoDk1RoKgKpViGrJpW9bWEY
X-Gm-Gg: AfdE7clKkrVimbZOhYNv0LqkX3BX6IJiUMAXZNAutfMwvuOnYHShRPoZBWqR841tOXh
	Hl5I+e0VTfnssPH4Dck9fEisgjbLUjNBdMwScuEYTJ4YuiFVgM8Do4HtZYR1Od2SBbzexRM2y5/
	JnhCMWdr02ooci/CWRvqYqsB5ZEHhiMs3myCHm3Hu1vndOuXOMCicCbYCQ65F7GrkrIhkSo55nn
	ecwweV0m+RVi3vM9B0VF9cfL9AX5hQBtBW+Trr2FsiuR3ibWLWNTqTNKqr52x6AE4+6ZuoY
X-Received: by 2002:a05:6a21:62c2:b0:3ba:cd5b:3dcd with SMTP id
 adf61e73a8af0-3bfdc69589emr1376925637.36.1782847249974; Tue, 30 Jun 2026
 12:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
In-Reply-To: <20260630183956.281293-3-dwindsor@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:20:36 -0400
X-Gm-Features: AVVi8CeUWBZtqtU3wWufhJ35rf7KN-O35V57TZRDwEyvAO9h530GFJE7-OayBpg
Message-ID: <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 2:40=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> xattrs via the inode_init_security hook using lsm_get_xattr_slot(). The
> hook now passes its xattr state as a single struct lsm_xattrs object,
> which the kfunc takes directly.
>
> The kfunc is only usable from lsm/inode_init_security programs: no other
> hook exposes a struct lsm_xattrs argument, so the verifier rejects calls
> from elsewhere. Restrict the xattr names that may be set via this kfunc
> to the bpf.* namespace.
>
> BPF reserves BPF_LSM_INODE_INIT_XATTRS slots via lbs_xattr_count, and the
> kfunc enforces that BPF never consumes more slots than it reserved,
> returning -ENOSPC once the budget is exhausted.
>
> A previous attempt [1] required a kmalloc string output protocol for
> the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> provide xattrs for inode_init_security hook") [2], the xattr name is no
> longer allocated; it is a static constant.
>
> Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-Oc=
tober/034878.html [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D6bcdfd2cac55 [2]
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  fs/bpf_fs_kfuncs.c      | 79 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/bpf_lsm.h |  3 ++
>  kernel/bpf/bpf_lsm.c    |  1 +
>  security/bpf/hooks.c    |  1 +
>  4 files changed, 84 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..c4023c82f21e 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -10,6 +10,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
>  #include <linux/kernfs.h>
> +#include <linux/lsm_hooks.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>
> @@ -374,6 +375,83 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dent=
ry *dentry)
>         return d_real_inode(dentry);
>  }
>
> +static int bpf_xattrs_used(const struct lsm_xattrs *ctx)
> +{
> +       const size_t prefix_len =3D sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
> +       unsigned int i, n =3D 0;
> +
> +       for (i =3D 0; i < ctx->xattr_count; i++) {
> +               const char *name =3D ctx->xattrs[i].name;
> +
> +               if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_l=
en))
> +                       n++;
> +       }
> +       return n;
> +}
> +
> +/**
> + * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_se=
curity
> + * @xattrs: inode_init_security xattr state from the hook context
> + * @name__str: xattr name (e.g., "bpf.file_label")
> + * @value_p: dynptr containing the xattr value
> + *
> + * Only callable from lsm/inode_init_security programs.
> + *
> + * Return: 0 on success, negative error on failure.
> + */
> +__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
> +                                    const char *name__str,
> +                                    const struct bpf_dynptr *value_p)
> +{
> +       struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *)v=
alue_p;
> +       size_t name_len;
> +       void *xattr_value;
> +       struct xattr *xattr;
> +       const void *value;
> +       u32 value_len;
> +
> +       if (!xattrs || !xattrs->xattrs || !name__str)
> +               return -EINVAL;
> +       if (bpf_xattrs_used(xattrs) >=3D BPF_LSM_INODE_INIT_XATTRS)
> +               return -ENOSPC;
> +
> +       name_len =3D strlen(name__str);
> +       if (name_len =3D=3D 0 || name_len > XATTR_NAME_MAX)
> +               return -EINVAL;
> +       if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
> +                   sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
> +               return -EPERM;
> +
> +       value_len =3D __bpf_dynptr_size(value_ptr);
> +       if (value_len =3D=3D 0 || value_len > XATTR_SIZE_MAX)
> +               return -EINVAL;
> +
> +       value =3D __bpf_dynptr_data(value_ptr, value_len);
> +       if (!value)
> +               return -EINVAL;
> +
> +       /* Combine xattr value + name into one allocation. */
> +       xattr_value =3D kmalloc(value_len + name_len + 1, GFP_NOFS);
> +       if (!xattr_value)
> +               return -ENOMEM;
> +
> +       memcpy(xattr_value, value, value_len);
> +       memcpy(xattr_value + value_len, name__str, name_len);
> +       ((char *)xattr_value)[value_len + name_len] =3D '\0';
> +
> +       xattr =3D lsm_get_xattr_slot(xattrs);
> +       if (!xattr) {
> +               kfree(xattr_value);
> +               return -ENOSPC;
> +       }
> +
> +       xattr->value =3D xattr_value;
> +       xattr->name =3D (const char *)xattr_value + value_len;
> +       xattr->value_len =3D value_len;
> +
> +       return 0;
> +}

This is not a generic VFS function, it is a LSM specific function, it
belongs under security/, please move the code as discussed previously.

--
paul-moore.com
