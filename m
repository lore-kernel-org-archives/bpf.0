Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C05212548
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775983443; cv=pass; b=hlwKH1YIizbGUffldv2oP7anyuPcBbFTu9RB7naC9qT1RrIseic150mUDB/NedO+A71xUTqYGlF5+4xnjeZKDdGW364WsvPJMGGhaRNjca30ofIcXVfNliqS0SpLELhmmUKLKZYiPE4Q2Cstr+BsLxPyDEWizWJTnOcWgp4dOeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775983443; c=relaxed/simple;
	bh=gAIB+AaF7xxIF4XMdDIU95SpF09MZ+6nhNNX5mwZKRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOS/Tdif54i71zMtdlbXDnQfXgsKaNaXRxyKNEe05kN+hzWR9/q90ztiJ8M67mUJuFWwKmEwTMX16iFYP/j3Yhloy0V3JGK2w/Rn6P4iu3tXgiG8Na0VdyA4nhnGLYF6vb83KJI0SiGNlSujenQN+IMbT1B74xKswoA+d7mK8Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU1RA1jP; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU1RA1jP"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651b6a003f6so219899d50.1
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775983441; cv=none;
        d=google.com; s=arc-20240605;
        b=LoszXdOj+NdzRRwZ5GXFJiLWdj1wbua+maj9xh2I5QOlBxUSZGqLkhH/lfxgr/WaMs
         ZCzwLSDTQFgj2OPckVuxX1uRkecPMkZ/65i6+JKyUEaY7ZlHrn62hZGsj32wOBDFAbs8
         AjCUW44AUxszJGYFuRpsJPzQ2kTpqIM+HYADyfhraWaaVQyHb6sjHwgNRL9PPVn8dB8S
         p8avgFEdBFNuhtJz84p/xCiuj6GxLFGfuWBMXR+dLAqypfrCpMbPDSA38EOXJYqWbA7j
         sPaPb738/Erl4eXkvbaSExgW8+ks38tgG9J9RIHDool24BZVFv6aIxrFI3KPfBZ38f98
         ERkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UxfqD5EVRCTMiBU1BwyxlmhzFUdHtxnIDbBG54l9fRw=;
        fh=Emqdds5EqNOJ+YSWcFSc3ksYF3iDQplIEffyrGItPt4=;
        b=RlJIu+M7afsESBiWJge51vmP66kHKMkPjjHU/Y03IFJEswkQ+Bk8jQ5HRg8IvhdPT9
         5veZ0JI37o+4zR2HIi/slD/QJTzmiCPMPY9f5J0IDPkF9VvQ4LWjjp5E2UuH81d6vNP+
         ovnR7jP5eEq5xDoJ/SMEkveajF5FjHUraR1fPh4THwWtzSidEVU33iPr5YzEXvc+56N0
         ACEKm0xWIT4D7zox6ehgfIfVmfU9LS4h9DpbghtefE4oDOf6laAiInICCG3pK85aaByD
         EbkIjcralT9k8jcoZ422GFhy9jIKhxA+ohlKd+PNf/hyAwC1qDxB/ajQrWwrVctfl+vm
         u5LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775983441; x=1776588241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxfqD5EVRCTMiBU1BwyxlmhzFUdHtxnIDbBG54l9fRw=;
        b=DU1RA1jPykel2ytvknc2gGfcLVEcGLyKBLgpeGyszIWnZxXyOGSBl0R0pxR13fZCXL
         j7CYcMAwZvfxSEZMBDCc8AaJguM81C81Fk+r1lCqVLbXoGz38tFOj5lHKParz/MMzEtj
         fJ+aGEHq/pdumRicHZlayU/YuDsnSmURogDQvkIXaY072o1ISRaU06iV+S0gyP8tTWFw
         9oaOGKE97xlvEfBOxgQ5Lf8w0XZs3vAymiBx23MTEXmFcMtwhL3jq05gIUL1Wut87uNV
         z2JcMoJH+T2RgYJ5oQkbVEdQYJBq0La+bQtOhGoDSNVorCxzYLlNsuvFUMODvX2Wk/ae
         FkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775983441; x=1776588241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxfqD5EVRCTMiBU1BwyxlmhzFUdHtxnIDbBG54l9fRw=;
        b=czXvZ3X8ol5U+Ad35MxgKABO5MgkbdAv8PaxYUGUqk29ST4ZZVUQ8EShQB4VumR3zH
         4xdzai7O8QRW+SME3E6Q0zHL1L93uW8M+tMW8/7XZvC1SxZcWFVmruKTUGee1x24PquQ
         ImU971bpBt/Z3nSl1cjnEbjhK3uJvian7FRWwGvjA39ebpWiM2nGKpgXmc2d/E1sfiMH
         Mfl8J+bDPcSCOBWob+5Bao14mEDOBMQflbqXp3sEuPK9kL4JeXIHAnwGLJf32HF14EMM
         xf9K4ks7TRiWH3cvaS8ma38PJZdEJhiNuRrkNb2TYQaXHdWuUvte+1rcxBZSaBnz+XhP
         k4jQ==
X-Gm-Message-State: AOJu0YyEmhetDqdec7SIUAa4rvcowM0JyfsvHywBZeW7D0j5hRnr4CTf
	igfBxI64AACgpzkgZM62bKithIWmtsrIqoAXS4EPAU/ggKKCu3grk3oZozfAWjXFcv5E/9T+tVX
	lyfZNYtHZlgND3TXtqa8nddWntTbT690=
X-Gm-Gg: AeBDiet29MabgN6sLl0Q+g4I+v2teVT2N2qlhQp1U+bYL8wl0hAAyLS4Gy6JCryfXlw
	LA6dlTjTwb7qO7NfUmGsxUhiPUNbgxmzJjixRimKETwGBOX9Szza6jaPYFKJqc9Ys0lAh/Oxcmy
	E173ZJE8M/9YbdfuWfwU5nUKW0jIDeLv9QggzFKnkCdBbwouIpxqL71lUE0SmTJh9l6uzk284sk
	tD+EBXtcKxpqKlzl/m2PvpF4kD8mjV+BLBbDIGUgstUvzL9UmARaNv4BeNX4VfNXdNb7pDy8WHQ
	93gLZT4Z47Z5MI75xXXuW94rZ8vM8zMKbChma6ZV
X-Received: by 2002:a53:a108:0:b0:64e:db50:37fa with SMTP id
 956f58d0204a3-65198b9f8fdmr5751772d50.47.1775983441470; Sun, 12 Apr 2026
 01:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org>
In-Reply-To: <20260408175217.1011024-1-song@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 12 Apr 2026 16:43:25 +0800
X-Gm-Features: AQROBzAgldO88DkLCfii6Zrrz5KWSGRaVz6Lr25QA0WGtMdW1P6pqFYpljXPplU
Message-ID: <CALOAHbBpK7YBz2Y8YWL0=0dLz5DLUa003y4b8SMgB+BVjePeOw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, jolsa@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 1:52=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Add a selftest that demonstrates BPF struct_ops controlling kernel
> behavior through livepatch. A kernel module (test_klp_bpf) livepatches
> cmdline_proc_show() and delegates output to a BPF struct_ops callback.
> The BPF program writes a custom string to /proc/cmdline via the
> bpf_klp_seq_write kfunc.
>
> Components:
> - test_kmods/test_klp_bpf.c: kernel module that registers a
>   klp_bpf_cmdline_ops struct_ops type, livepatches cmdline_proc_show,
>   and provides bpf_klp_seq_write kfunc for seq_file writes
> - progs/test_klp_bpf.c: BPF struct_ops program implementing
>   set_cmdline callback
> - prog_tests/test_klp_bpf.c: userspace test verifying /proc/cmdline
>   output with and without BPF struct_ops attached

Cool idea! I just checked it out, and it works perfectly.

[...]

> --- /dev/null
> +++ b/tools/testing/selftests/bpf/test_kmods/test_klp_bpf.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/livepatch.h>
> +#include <linux/seq_file.h>
> +#include <linux/bpf_verifier.h>
> +#include "test_klp_bpf.h"
> +
> +static struct klp_bpf_cmdline_ops *active_ops;
> +
> +/* --- kfunc: allow BPF struct_ops programs to write to seq_file --- */
> +
> +__bpf_kfunc_start_defs();
> +
> +__bpf_kfunc void bpf_klp_seq_write(struct seq_file *m,
> +                                   const char *data, u32 data__sz)
> +{
> +       seq_write(m, data, data__sz);
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(klp_bpf_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_klp_seq_write)
> +BTF_KFUNCS_END(klp_bpf_kfunc_ids)
> +
> +static const struct btf_kfunc_id_set klp_bpf_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set   =3D &klp_bpf_kfunc_ids,
> +};
> +
> +/* --- Livepatch replacement for cmdline_proc_show --- */
> +
> +static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)
> +{
> +       struct klp_bpf_cmdline_ops *ops =3D READ_ONCE(active_ops);
> +
> +       if (ops && ops->set_cmdline)
> +               return ops->set_cmdline(m);
> +
> +       seq_printf(m, "%s: no struct_ops attached\n", THIS_MODULE->name);
> +       return 0;
> +}
> +
> +static struct klp_func funcs[] =3D {
> +       {
> +               .old_name =3D "cmdline_proc_show",
> +               .new_func =3D livepatch_cmdline_proc_show,
> +       }, { }
> +};
> +
> +static struct klp_object objs[] =3D {
> +       {
> +               /* name being NULL means vmlinux */
> +               .funcs =3D funcs,
> +       }, { }
> +};
> +
> +static struct klp_patch patch =3D {
> +       .mod =3D THIS_MODULE,
> +       .objs =3D objs,
> +};
> +
> +/* --- struct_ops registration --- */
> +
> +static int klp_bpf_cmdline_reg(void *kdata, struct bpf_link *link)
> +{
> +       struct klp_bpf_cmdline_ops *ops =3D kdata;
> +
> +       if (cmpxchg(&active_ops, NULL, ops))
> +               return -EBUSY;
> +
> +       return 0;
> +}
> +
> +static void klp_bpf_cmdline_unreg(void *kdata, struct bpf_link *link)
> +{
> +       WRITE_ONCE(active_ops, NULL);
> +}
> +
> +static int klp_bpf_cmdline_init(struct btf *btf)
> +{
> +       return 0;
> +}
> +
> +static int klp_bpf_cmdline_init_member(const struct btf_type *t,
> +                                      const struct btf_member *member,
> +                                      void *kdata, const void *udata)
> +{
> +       return 0;
> +}
> +
> +static bool klp_bpf_cmdline_is_valid_access(int off, int size,
> +                                           enum bpf_access_type type,
> +                                           const struct bpf_prog *prog,
> +                                           struct bpf_insn_access_aux *i=
nfo)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static int klp_bpf_cmdline_btf_struct_access(struct bpf_verifier_log *lo=
g,
> +                                            const struct bpf_reg_state *=
reg,
> +                                            int off, int size)
> +{
> +       return -EACCES;
> +}
> +
> +static const struct bpf_verifier_ops klp_bpf_cmdline_verifier_ops =3D {
> +       .is_valid_access =3D klp_bpf_cmdline_is_valid_access,
> +       .btf_struct_access =3D klp_bpf_cmdline_btf_struct_access,
> +};
> +
> +/* CFI stubs */
> +static int klp_bpf_cmdline__set_cmdline(struct seq_file *m)
> +{
> +       return 0;
> +}
> +
> +static struct klp_bpf_cmdline_ops __bpf_klp_bpf_cmdline_ops =3D {
> +       .set_cmdline =3D klp_bpf_cmdline__set_cmdline,
> +};
> +
> +static struct bpf_struct_ops bpf_klp_bpf_cmdline_ops =3D {
> +       .verifier_ops =3D &klp_bpf_cmdline_verifier_ops,
> +       .init =3D klp_bpf_cmdline_init,
> +       .init_member =3D klp_bpf_cmdline_init_member,
> +       .reg =3D klp_bpf_cmdline_reg,
> +       .unreg =3D klp_bpf_cmdline_unreg,
> +       .cfi_stubs =3D &__bpf_klp_bpf_cmdline_ops,
> +       .name =3D "klp_bpf_cmdline_ops",
> +       .owner =3D THIS_MODULE,
> +};
> +
> +/* --- Module init/exit --- */
> +
> +static int __init test_klp_bpf_init(void)
> +{
> +       int ret;
> +
> +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +                                       &klp_bpf_kfunc_set);
> +       ret =3D ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdline_ops,
> +                                            klp_bpf_cmdline_ops);

Is it possible to integrate this BTF registration directly into
klp-build? It appears we might need to extend scripts/livepatch/init.c
to provide the necessary support.

--=20
Regards
Yafang
