Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493192BE7DB
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441407; cv=pass; b=aotZNlvRaE+Aw0KCZLlgGNpMl54IYffJ+W0tEFZinYn30MrV0Jo0l/2aXkW0/fJrqhoTDOKErqMavi6Q8x2jHOZ6uFI4UTAdElWtELKCFMu0SqZ/gBR8Vn17fiTV6cRjwAR3xMafh32XZTU0RzpaOXc1TnichYTYYRDr8Ev/QDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441407; c=relaxed/simple;
	bh=F2YeY9UZ+z8mxm5SR19nhEAW7P+kxyra6l1T0e0eS3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ng9tr5hwyMbledF7YDTViLrOpR572vr+K0oV4DqlhIHYuI5BcjvMmo2qjxcDiGBP3IVOIOetrBZ9ppt6RP3A5Q6QSY69w+ZvuFeV0JnWt13SfyBAQEaXHQ/XCijJRME3FcyiXyq8UfU1jNG6NhlJJtP2FhdACgQ48WWKsjtFEH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj2Y1ne+; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj2Y1ne+"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35691a231a7so58174a91.3
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 11:03:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771441406; cv=none;
        d=google.com; s=arc-20240605;
        b=Fkv7EiGYrKfhkWdpRF3D1vA8YDhJ7o+uT9gy/3FVjwN5l0JkfdLLT2Tp9KT7cnGDQR
         SIt7P8Lg5kxe3GqLbi51U6uuQ03En8hf75QftskwJxIpXbvSt9BQaoxaT3v48A99ewxe
         njwRmi9ihRr36Zw9Fqhv6ruJCWT6C1+TxuWq8b6UFCuKA2kW+VPYHQKzGoohhlwsTKTc
         xVNYZzHnVDIMlGbh1hDwih/I59svwz+RJiOo6/fs8dseYEQcu04P3s0FrpZfYXPbOVOl
         PpQMNH+b919KK47w7fm7+ou3lMlo/MrelMQ7hDWTWangZHhe/jPJ1zaS9YJsjlA8vYw9
         uRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QeRt235Mzbb6VtVw2NRVGJUa4fk6f4jJ7Bo4HlhapAg=;
        fh=A4XgJlURankTT11MR4K1Gle/LurATRPhYG69TDUYmng=;
        b=Eik1FMBM8tNnDpOk/ae00Bq/Yq80ypxvmEyA5LmprcVGbiUdvSX/9Vdz2w2mqbwgWP
         pll+WiPzfEM/unoydEEPvfcLxRgvKFS20CSPnl9zRGpwlgibQ4JFFyQsHtmc4tTv3kYL
         EKNky7+5Wt5GbB6iX2EoTItAAqUvU4VoODXz1J+cT9cuRph4LVPh4IZNq8DzN5YgG77Y
         ZtjeAiogt3OhtWS1oEoq7cPp4A8H5cWOdXIjgXbWLZWKqBDJZmK6CEhhsdNbsyvSF885
         4bT+Ei+Sx0nsVFlVW6OgzMeOHx/k+QOxX8gKE04Saycx1qQdf27XT+6xDi1i7Xk9d2AS
         oTHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771441406; x=1772046206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeRt235Mzbb6VtVw2NRVGJUa4fk6f4jJ7Bo4HlhapAg=;
        b=jj2Y1ne+UTgjFW2c1mCqpLRQS9bYLX20L2O4jOpEHndgplK+tDgLC9d26z0ZpkZIC6
         3sdnh4k3wesMlLsfQe3D1lVqvPZFdajEncrBIwulYUut1xkpFTNl2uyYw4VOEi7MdaKg
         Q42l7gTWX51GONlpQ17avMbsaPLqfchjXpjWQqm7L6jUjo/KtSTWXM+/h/PX66+fEh8m
         AAvkrE7Prld/3L6FvdoRHaO/bSNFkX9L6YoM91UrS4OLUNRWGq5wB/UBSicqVd1+rIlG
         4LlQGJOh+CnXLnIpfldG27UuvDX3iMazolNQ1uD+2KLlIJ+KuDrK7RYISX+30Aszxj3p
         FINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441406; x=1772046206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QeRt235Mzbb6VtVw2NRVGJUa4fk6f4jJ7Bo4HlhapAg=;
        b=in8s6UO9KDE3QaR+dpmXs1C17+lbPkqVkPfeyC517Avht0n0FhtK3pz3XOFClPPMcE
         gJapY3nhSlaoc3pqX8tfTuIuHEjf1tNWTYJo4kAOIEoDCpcr7lE92MhkTAMORjnSG0OU
         HwwFJcomo683WKCcnumLrCTumAKNnzKN0VWk2j9x/2A5VWzxjKPfOeUBMZuVPPlzwF4e
         ZKllw5040JbujlUVJtMpOjktxuHw6Vy6HTLGqGGIPQ82mhxFaSIA2+JfiQbhWCrGFC/j
         UNamWAWj0dbGSr8apU1/ofVnyr1bIxCK4R6Un0XjGrYYWyxjpSpmyqYIbKyGKVlaQJo4
         1BWg==
X-Forwarded-Encrypted: i=1; AJvYcCVNy/vDuUGD9Y11TXoAecVMLWpYUTsqvA/82nJ9Pln+lg343FmdHM7OaHPjxU9hnRYco2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPTynDnPXvG1eSbTpS8bbBCbQMBvr19t7boLs8rF9j9wvNVQC
	M0pm19fhGApR/PsohJb8tjVmTuuXPUXUt1XoyHPvgXvJWwTF5cgpMTBPITUkWry0ct1ceGDMzZb
	DgUYvLhr1cOt/Y4yXGhdhw+/g2RElYe8=
X-Gm-Gg: AZuq6aKQhF1aNoQJK1F4naoipHNJ60GuvCuee8glY3QckX4CW87yYFYG5L3+NilRaDT
	DSk6e0YEzjHqJ89lteSl3m2WNsynqC/vsnjk5G7QwEN0Gi3xQYLb4Xm4tnROa12AWDiyqZYj5xT
	h5pMsT3l6tzAz86yB074e+mLjjQLmq+ibWRTKaojNiteWnhCvjVf5KOheZwzxpo0I11Kt9rsjBq
	eFkz2hD602RJaJaGYfSVYUVjVkHqP2QqWEw49AnbjAiRneng4lFKLTJfZ7PLs6rRWOFaQzp66Mj
	TtzHBtxxUfM7r7DlAJH36w==
X-Received: by 2002:a17:90b:2882:b0:356:2c7b:c01e with SMTP id
 98e67ed59e1d1-358890e02dcmr2494034a91.11.1771441405550; Wed, 18 Feb 2026
 11:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212152013.17351-1-varunrmallya@gmail.com> <20260212152013.17351-2-varunrmallya@gmail.com>
In-Reply-To: <20260212152013.17351-2-varunrmallya@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 18 Feb 2026 11:03:12 -0800
X-Gm-Features: AaiRm53vgyqQmTMpqZONjXdRF2vql9sAmlLQLL7_K_y5xnJmtL2zt7Qj1rOJ2BU
Message-ID: <CAEf4BzaLF80MrRgD4zcpUcQ=Ywt6ytbHoM1OsZTrxWtXdRxtLg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/1] libbpf: Auto-upgrade uprobes to
 multi-uprobes when supported
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, ast@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 7:20=E2=80=AFAM Varun R Mallya <varunrmallya@gmail.=
com> wrote:
>
> This patch modifies libbpf to automatically "upgrade" standard
> SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
> infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
> supports it, making them compatible with BPF tokens.
>
> To maintain backward compatibility and handle rare cases where singular
> uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single"=
)
> section types are introduced. These force libbpf to use the legacy
> perf_event_open() attachment path.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 42 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0c8bf0b5cce4..a32f221d3245 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8265,6 +8265,22 @@ static int bpf_object_init_progs(struct bpf_object=
 *obj, const struct bpf_object
>                 prog->type =3D prog->sec_def->prog_type;
>                 prog->expected_attach_type =3D prog->sec_def->expected_at=
tach_type;
>
> +               /* set BPF_TRACE_UPROBE_MULTI if sec_name matches "u[ret]=
probe"
> +                * otherwise, leave alone.
> +                */
> +               if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {

bpf_object_init_progs() is happening during BPF object open phase,
which is too early to check kernel features. We should postpone
expected_attach_type setting to preparation (bpf_object__prepare)
phase, at which point we expect process to have CAP_BPF and other
permissions.


pw-bot: cr

> +                       char *probe_type =3D NULL;
> +                       int n;
> +
> +                       n =3D sscanf(prog->sec_name, "%m[^/]", &probe_typ=
e);
> +                       if (n >=3D 1)
> +                               if (!strcmp(probe_type, "uprobe") ||
> +                                   !strcmp(probe_type, "uretprobe"))
> +                                       prog->expected_attach_type =3D BP=
F_TRACE_UPROBE_MULTI;

instead of sscanf+free, can't we just strncmp() the prefix (and make
sure it's either full match, or is followed by forward slash)?

> +
> +                       free(probe_type);
> +               }
> +
>                 /* sec_def can have custom callback which should be calle=
d
>                  * after bpf_program is initialized to adjust its propert=
ies
>                  */
> @@ -9822,9 +9838,11 @@ static const struct bpf_sec_def section_defs[] =3D=
 {
>         SEC_DEF("kprobe+",              KPROBE, 0, SEC_NONE, attach_kprob=
e),
>         SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprob=
e),
>         SEC_DEF("uprobe.s+",            KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
> +       SEC_DEF("uprobe.single+",       KPROBE, 0, SEC_NONE, attach_uprob=
e),
>         SEC_DEF("kretprobe+",           KPROBE, 0, SEC_NONE, attach_kprob=
e),
>         SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprob=
e),
>         SEC_DEF("uretprobe.s+",         KPROBE, 0, SEC_SLEEPABLE, attach_=
uprobe),
> +       SEC_DEF("uretprobe.single+",    KPROBE, 0, SEC_NONE, attach_uprob=
e),
>         SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, S=
EC_NONE, attach_kprobe_multi),
>         SEC_DEF("kprobe.session+",      KPROBE, BPF_TRACE_KPROBE_SESSION,=
 SEC_NONE, attach_kprobe_session),
> @@ -12722,10 +12740,10 @@ bpf_program__attach_uprobe_opts(const struct bp=
f_program *prog, pid_t pid,
>   */
>  static int attach_uprobe(const struct bpf_program *prog, long cookie, st=
ruct bpf_link **link)
>  {
> -       DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
>         char *probe_type =3D NULL, *binary_path =3D NULL, *func_name =3D =
NULL, *func_off;
>         int n, c, ret =3D -EINVAL;
>         long offset =3D 0;
> +       bool is_retprobe;
>
>         *link =3D NULL;
>
> @@ -12752,15 +12770,27 @@ static int attach_uprobe(const struct bpf_progr=
am *prog, long cookie, struct bpf
>                         else
>                                 offset =3D 0;
>                 }
> -               opts.retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D =
0 ||
> -                               strcmp(probe_type, "uretprobe.s") =3D=3D =
0;
> -               if (opts.retprobe && offset !=3D 0) {
> +               is_retprobe =3D strcmp(probe_type, "uretprobe") =3D=3D 0 =
||
> +                             strcmp(probe_type, "uretprobe.s") =3D=3D 0;
> +               if (is_retprobe && offset !=3D 0) {
>                         pr_warn("prog '%s': uretprobes do not support off=
set specification\n",
>                                 prog->name);
>                         break;
>                 }
> -               opts.func_name =3D func_name;
> -               *link =3D bpf_program__attach_uprobe_opts(prog, -1, binar=
y_path, offset, &opts);
> +               if (prog->expected_attach_type =3D=3D BPF_TRACE_UPROBE_MU=
LTI) {
> +                       DECLARE_LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);

nit: use shorter LIBBPF_OPTS() macro for this, we kept
DECLARE_LIBBPF_OPTS for backwards compat, but there is no reason to
use it going forward

> +
> +                       opts.retprobe =3D is_retprobe;
> +                       *link =3D bpf_program__attach_uprobe_multi(prog, =
-1, binary_path,
> +                                                                func_nam=
e, &opts);
> +               } else {
> +                       DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
> +
> +                       opts.retprobe =3D is_retprobe;
> +                       opts.func_name =3D func_name;
> +                       *link =3D bpf_program__attach_uprobe_opts(prog, -=
1, binary_path,
> +                                                               offset, &=
opts);
> +               }
>                 ret =3D libbpf_get_error(*link);
>                 break;
>         default:
> --
> 2.52.0
>
