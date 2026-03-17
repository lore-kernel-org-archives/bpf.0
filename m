Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D426ED33
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713130; cv=pass; b=TofInWzK9jewa9QXFLmNfGSbnrU6cK3xo3BJSjNVfLRgsPaeI3Ejj+CSV9VFL2dTFK+BaxeWdjkq5nERUNzBa5FqZIQCUWfMKMtZW54XjbqzXc/pAflPQEThOOdQAjgIgS6v1xtqo4W7UKOvQptLPaSBhMZkBf+qBzc5VoLnkHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713130; c=relaxed/simple;
	bh=Pa15k/f7JCsKm8Ta1ZcAIc8csfcefiqxdQimuxdBxkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Frj6bN8I/qEox3O9nl0R+jsUq31dO6tWTpvf889Hx8Z+z3no5XOlrQlR1F1zufES8iK/0Ar/K1u3lbdDM3Fsy9WS13HsZOcELRuTYtFShUoDzLiIEpQpcS307DnMS/c4C6QcgTbO0BEDvAVi8CjHMQ9a8H2nqbbWmH9qp5xXezY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jaf/7i6A; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jaf/7i6A"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso4108980f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 19:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773713128; cv=none;
        d=google.com; s=arc-20240605;
        b=TWtIKmy00OwDntujFljnEGCnJEYd1aD4bnxiY4LWDTHy+47ClmEv9LDjyo27oBpohf
         PiPx+On81VYeJ95tu0nmPiAY/zLuGvmHQy5uSq0ohKIuHSHTu7fxxtzaflo48LJ7i7q9
         FFXOashsRgA9wha7uXXzN59HGmV5Z3bgeMrkIsy5AoOr2ouKlgremlXrzdYEzNqRNZmr
         +0LSRMxpQ83NPhHjJkHZEXsKzP1/dr4QSgMskI7XtIiVyG4EVwlAjra09YV0u7ysoduN
         03893KzTzGjV1aRpQtNU700WQ3pigwXER/o/vfM6GGdvI6i/bP+PIA+FWFAX0Ar/xyJw
         ADkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        fh=ovg3JyHpMyfKlDQt2nQ7ZnbaY905jL7OULiNRN4+s/s=;
        b=WznMxbil+WhzMPPcRwK/synOJonhKqUOJjbTyplAyJ5QdFxzU+nlpW7CMXjx/UO/Qx
         +QzkU6pfxrv7aNixG7IOg9x1gcIsFoWn3kFdGuyq4TQUx1SZocTMlGa78Wr1GHYI1FGW
         TySjSof7l5uOAwWJpaJH7KDqr5rTqLsSn35Lu63d2G7XkISzAgxRCC/3jB2eu8/Cz3xT
         AvHyPwBGx5eZZ0VZFAjSOzpPk3vgQEd9cVnQeUytGPytrJ2lrUUTlR10YIqjpWC4XQos
         437DWiIJOnFKT/Usbv9VhRtZB1cKScs1NI9SFWq/I/yBa+tFUtKqGQ4gFEo05x9+DfJf
         XSRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773713128; x=1774317928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        b=Jaf/7i6A4woP96PzeMnz+dwaCpSREdvPU7fIFv7Xs1A/+luFd6vbHeg9uXUt5h3298
         8voONoliKchubNnp6nBPDxwoOQk5Hgm42KmOYX6ndHVs2E78ysCtmBPnm9VAGfbYiozG
         NLYYUkspUIoReuRJASEJwGZCfcXxk3xDSqpSnXoxRWck9u5dMjmlK3k7DFmiS72a9jaZ
         xFkna4lMTeWOeu2AShluhp0HXYW/0msQfN+CWvQSPqZcZaUqcRXuF/SAWPzaxAHceWNO
         HUCurkWyT9M4DOW4W9XAGsho7qW4ZF5TLX6Xhxiz7wFVn5THDBHrPHXWlX0I4hjD46kc
         zEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773713128; x=1774317928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM8PvAQjaxTMcJaMWaL4GPi/Stw1aNsHY3fxQVFtBvE=;
        b=EHgtPiC352WxkT1PhLlca4Ef3BEu8+PnqdFRqCisPrv5AgoQywg93TZxBEFrraGRR2
         okzbSXA8BItIYvTbY9QOpFp2rFDDiAJ4Ri8ikEkEVSXTdgV623uwUQPR5YS0ekcWWdMJ
         vdbF4+LmHeuX/szv6HCJAi5fKzRBueMnP4P2/D0d09IF2ooEexZvSzRi1o6qE+y/aEaL
         ODS4UXMZiTxYtOKOMYASZy/FBR6F30ftYi9ekdSE7r7DspCk4y4cVnIBtSbiCS2Huo2I
         bc8+JlDQOmhnN3CYMK+JQxjXZeE4ddnwYlOPw+6gXTH0E0KGsSx7oUpNvnuJNDVVLr2Y
         QR0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLcnSe5xvdQMQyVXkW6iSKGrmMf8vnlJl/dEUuZ0DWRjEyL1yIOjDjzVWqbkNHjD4cO+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwK36sCE0nrDm00WSoTq/5QyKBG7XTvTakThiNK4gaduachh7u
	/mBt3Dds5vys+Cw1oeVWRklCQYv1Osok1JE8PtAKEJG6MwfdcyULle2nNkpwHCwngckgEFl4P7O
	7lRaIjILDv4LNMK2g/51camkLnkjyO3w=
X-Gm-Gg: ATEYQzyy2AcwoIzIFtAOdzdcbkL/yi3gKNrtb90yXsU94NarW8OGR1PVwZFaf7N0k20
	vLeymKH+uEyvbXb9P8qA3NVVmsxhINql4RBZ8Nj293upAAwizAintr1VGxx/p2abGNmUOdSWozJ
	c20o3AW/JeZBWeXCRxILIOL2b2Hj/fYmpZiCRkUjBooAexMOrK9vJYEKqxQLp9f/092loecM8Xx
	pZRtiQeG7m0TdckipYIDErgLgES//CiFD9b7cad1RqB3TGce4xZl/+zAtv4T6YB3LEIA3af1eVv
	+yHh10LsqGOIN0yTUSFNDFFCAEPt98NX1MJrp3RzeSJEHPAISPdqWzeQXRM=
X-Received: by 2002:a05:6000:4011:b0:43b:4720:1102 with SMTP id
 ffacd0b85a97d-43b472013fcmr6516708f8f.32.1773713127331; Mon, 16 Mar 2026
 19:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 17 Mar 2026 03:04:51 +0100
X-Gm-Features: AaiRm526aBgdvFmf4JzfVkPGCIcd_fq8FocVpkKM-YUNW1KDtzdIsycxc9Aw8gE
Message-ID: <CAP01T77mRSxLN_nZdgd-qv-u7i5SEiSU5azohVcc_NZdqHnqOw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/4] audit: Implement bpf_audit_log_*() wrappers
To: Frederick Lawler <fred@cloudflare.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrote:
>
> The primary use case is to provide LSM designers a direct API to report
> access allow/denies through the audit subsystem similar to how LSM's
> traditionally log their accesses.
>
> Left out from this API are functions that are potentially abuseable such as
> audit_log_format() where users may fill any field=value pair. Instead, the
> API mostly follows what is exposed through security/lsm_audit.c for
> consistency with user space audit expectations. Further calls to functions
> report once to avoid repeated-call abuse.
>
> Lastly, each audit record corresponds to the loaded BPF program's ID to
> track which program reported the log entry. This helps remove
> ambiguity in the event multiple programs are registered to the same
> security hook.
>
> Exposed functions:
>
>         bpf_audit_log_start()
>         bpf_audit_log_end()
>         bpf_audit_log_cause()
>         bpf_audit_log_cap()
>         bpf_audit_log_path()
>         bpf_audit_log_file()
>         bpf_audit_log_ioctl_op()
>         bpf_audit_log_dentry()
>         bpf_audit_log_inode()
>         bpf_audit_log_task()
>         bpf_audit_log_net_sock()
>         bpf_audit_log_net_sockaddr()
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  include/linux/lsm_audit.h   |   1 +
>  include/uapi/linux/audit.h  |   1 +
>  security/lsm_audit_kfuncs.c | 306 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 308 insertions(+)
>
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 382c56a97bba1d0e5efe082553338229d541e267..859f51590de417ac246309eb75a760b8632224be 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -78,6 +78,7 @@ struct common_audit_data {
>  #define LSM_AUDIT_DATA_NOTIFICATION 16
>  #define LSM_AUDIT_DATA_ANONINODE       17
>  #define LSM_AUDIT_DATA_NLMSGTYPE       18
> +#define LSM_AUDIT_DATA_CAUSE 19 /* unused */
>         union   {
>                 struct path path;
>                 struct dentry *dentry;
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 14a1c1fe013acecb12ea6bf81690965421baa7ff..7a22e214fe3e421decfc4109d2e6a3cee996fe51 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -150,6 +150,7 @@
>  #define AUDIT_LANDLOCK_DOMAIN  1424    /* Landlock domain status */
>  #define AUDIT_MAC_TASK_CONTEXTS        1425    /* Multiple LSM task contexts */
>  #define AUDIT_MAC_OBJ_CONTEXTS 1426    /* Multiple LSM objext contexts */
> +#define AUDIT_BPF_LSM_ACCESS           1427    /* LSM BPF MAC events */
>
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/security/lsm_audit_kfuncs.c b/security/lsm_audit_kfuncs.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..0d4fb20be34a61db29aa2c48d2aefc39131e73bf
> --- /dev/null
> +++ b/security/lsm_audit_kfuncs.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Cloudflare */
> +
> +#include <linux/audit.h>
> +#include <linux/bpf_mem_alloc.h>
> +#include <linux/gfp_types.h>
> +#include <linux/in6.h>
> +#include <linux/lsm_audit.h>
> +#include <linux/socket.h>
> +#include <linux/types.h>
> +
> +struct bpf_audit_context {
> +       struct audit_buffer *ab;
> +       u64 log_once_mask;
> +};
> +
> +static struct bpf_mem_alloc bpf_audit_context_ma;

bpf_mem_alloc will be deprecated, please use kmalloc_nolock().

> +
> +static inline u64 log_once(struct bpf_audit_context *ac, u64 mask)
> +{
> +       u64 set = (ac->log_once_mask & mask);
> +
> +       ac->log_once_mask |= mask;
> +       return set;
> +}
> +
> + [...]
> +
> +__bpf_kfunc int
> +bpf_audit_log_net_sockaddr(struct bpf_audit_context *ac, int netif,
> +                          const struct sockaddr *saddr__nullable,
> +                          const struct sockaddr *daddr__nullable, int addrlen)
> +{
> +       struct lsm_network_audit net;
> +       struct common_audit_data ad;
> +
> +       net.netif = netif;
> +
> +       if (!saddr__nullable && !daddr__nullable)
> +               return -EINVAL;

Code look a lot cleaner if you just stashed these locally in a better
named variable.

> +
> +       if (saddr__nullable && daddr__nullable &&
> +           saddr__nullable->sa_family != daddr__nullable->sa_family)
> +               return -EINVAL;
> +
> [...]
> +
> +/* The following have a recursion opportunity if a LSM is attached to any of
> + * the following functions, and a bpf_audit_log_*() is called.
> + *  security_current_getlsmprop_subj,
> + *  security_lsmprop_to_secctx, or
> + *  security_release_secctx
> + */
> +BTF_ID_FLAGS(func, bpf_audit_log_cause, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_cap, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_path, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_file, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_ioctl_op, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_dentry, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_inode, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_task, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_net_sock, KF_DESTRUCTIVE);
> +BTF_ID_FLAGS(func, bpf_audit_log_net_sockaddr, KF_DESTRUCTIVE);
> +
> +BTF_KFUNCS_END(lsm_audit_set_ids)
> +
> +static int bpf_lsm_audit_kfuncs_filter(const struct bpf_prog *prog,
> +                                      u32 kfunc_id)
> +{
> +       if (!btf_id_set8_contains(&lsm_audit_set_ids, kfunc_id))
> +               return 0;
> +
> +       return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
> +}
> +
> +static const struct btf_kfunc_id_set bpf_lsm_audit_set = {
> +       .owner = THIS_MODULE,
> +       .set = &lsm_audit_set_ids,
> +       .filter = bpf_lsm_audit_kfuncs_filter,
> +};
> +
> +static int lsm_audit_init_bpf(void)
> +{
> +       int ret;
> +
> +       ret = bpf_mem_alloc_init(&bpf_audit_context_ma,
> +                                sizeof(struct bpf_audit_context), false);

One you switch to kmalloc_nolock you can drop this too.

> +       return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +                                                &bpf_lsm_audit_set);
> +}
> +
> +late_initcall(lsm_audit_init_bpf)
>
> --
> 2.43.0
>
>
