Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2D1C3F31
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614934; cv=pass; b=G7FVXefeubObyBKZKmRx9lUD219vA9i2lInGnq8X7cyt2UKISwnf7OQCER9okKmoeMdcDGN4dkScuJxg7AIc1gP2ITWMWJfuRk4gUUj3yCYi5+0pBa2PkYvfjLWszU2I9Gl7oBVwEv8jzGpn+isDd4l71WwC4Qz1R/YeGx2Q1T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614934; c=relaxed/simple;
	bh=zbiiI3CMjb5D3iPOVo/7mXbdDD4CFhPBypPorBe3+AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIOIeCvdq2SyiyapHWjK8sc63wCgkxAfcSLDAx8HV4iHSdjrNqc6QyyHzYBrpC9do7UIuq1UA6EQJ1bJp0NSI/+VLpuCoblRjEdu33R70RZ1qH9sFXEfYq0B3dSabTti1mDC7w89LDL/hhPkOM1F67lJ9Nss4Z8+VakCy88lxBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc2ZJdFM; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc2ZJdFM"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so4581518f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775614931; cv=none;
        d=google.com; s=arc-20240605;
        b=eWOAYq1GpMgXkTHrat99Wj1LLVRWUfwne8nmZV8yX9DB2twto3ADXzXN55dtplmTqP
         4Vy5l4Fy7VmO4a1ZmH4mjmHyEjCDG/GkVo/m8ImyvVJQC5d/kPaFcs2v1AjbEZOmBwWW
         fjdaRJmKwfg4ojvBk2LsbQEpKwTbA4kzv+PATA96b3jYyFRHzTQs4KXezRmstXAExT1w
         YHk7507zmG3RE6IxLlZoW+Rj52aCP2Jd/rf9vAidvHN7KB4JqiVCcdk6PnwovtrYP7nb
         3OFe3zZqxi8JF7hiUCFgiaGfpzxpdx3biM6QnXs1viGigglDPjoEiddZSLWWCqFu6Wqv
         5ZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UUlpFVKmJLkMBf76OS6o/TLRla0tC7iTkChWn/VZTLE=;
        fh=AaIzEkgkNIJjXdkyAW6PcSEkxXyyRkGvbiSIybnPGm4=;
        b=S0SPa8glhhDp4TU0SQA9j+8H1mYFws3FRW+nZtQFvib3Aw/GqcAS6DW2GzKE0kbLkM
         3Pz3jviFNtebxoFMrclEuGwVdM0RKrd0wkN/zqiB/NeFBPUJER4LcaCeiri75du55nH8
         SiF/0HBjee7bzTk+Rptf0hZkwAiMQmpSnatLwqIpPQTSGJIft1zNfdPA0fxNxLIgn8H+
         L/meicP/6Pbd3veVFtOPofdoqfewWDXqZUnq+B1L843+H8m+2xYjODc02fXoCMqs9nSK
         th36weMlmglOaHYF1avIrwAGBz00pv6EgebhHQ4+HkkcluAtsDdwAoSWATe7SnSV5Vxf
         ga1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614931; x=1776219731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UUlpFVKmJLkMBf76OS6o/TLRla0tC7iTkChWn/VZTLE=;
        b=Bc2ZJdFM7PKO/M/bTfUizVgR5cLvNkc6vpmu3EtyGb2ENjF4dhRBULqwFgm86/p7lK
         iZmpUyCUz0cesxA6E6fNJ449ZAa1K19mlqNZDUKHMTgsyF9uAg1bCe4vUQNP9aIswTle
         g7BHl/1wuZIV2M9KcAv8cvZP9X6RkPE1wQF766trRzjuiDxx1oeTqzr1enZLcJSayCRn
         gtBBoh3N7VOmJC3IXYoO2iYj71CjY1a9/QwPodgVqEtE3hv8MGWryPkn2FkNczUMiZMr
         m2E+fJLhvG6QGeeurtgo9hSyCEnIZqLUiIXZXOn2Mdw9g46kcF2aU41VUQ9iMzoLDvp+
         6EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614931; x=1776219731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUlpFVKmJLkMBf76OS6o/TLRla0tC7iTkChWn/VZTLE=;
        b=lCk6BSATUQQTOOStbNr4BNwR5WzYZ1giVIb9GB2DMLpnGk5sliwsA+2v2I6u2VfLY/
         bJRnhfLAv7cL3Hn7dPNXTlWVRMWoxz6fTkL9BofNG0oC+0MoLo6Ctu+M7U2OEkESfv0H
         inPMGg3lxXYyFqEX1fbOsygH3R3hcU0DT6FIJ6jQaCP0cMxbiA2uWU39sEj1ilwLHXn1
         HF2fq9BEmTmLqU2MxGSq4IJ3zcss2LcpZMNTjBrDo87hphXfQx627uSe0x/Dbkwuu4It
         rEtx4MiFAJTN+/ciZ2wchEGAN2+wiJny9JxeqY3PSqWm2L/gD/69cfg1urTc26Xy9imT
         Bxew==
X-Gm-Message-State: AOJu0YwNalZ1GSDstB7oI3oblEzmw3HEawA6xVBQeVLGRqbildt9j6/K
	k1LfV6CvS+/y10jHGlRlBYOwi4DYGKetlpFeDavmD4YVZ9insJTrfq0YEKdI6LExOB51g2w0SuJ
	7wrSgI0ViRq/4tuSdqAeRz2c7hdx86r3YqL+FFHORTg==
X-Gm-Gg: AeBDieu/rSybDmNZoA6i46+y2wzu4a5kpMZYOwUBGgxBlGHkLvAegEknhqMFVoH3MU4
	o3GyGJw5p+LK6veJSLT7eNusT9bpF6W4hznUIMFqy3foiuzyXXp/CN0N2zQvBd0vRhdIsi9/Ocj
	Hrc/tQ7rjgtz/K9uEm0B5y9EyFZJ6C/pFqlOSls3kAffPwRkr3gH0yZhXhay1hRsoRlPGODosET
	REG9JYWnIPAtU9aIAwo6DK4b1STTAspdevrOighsr5rsG5Dz0I98t/8u+jpCPONBjRyf1mrjfDD
	QkSYL8Qd2bTrQ2kl2MAQSOfxnqofhFT+f7VK3CCzYVSsj9AFvIEp8gNLr90XaRSVEo2wUsS0
X-Received: by 2002:a05:6000:4313:b0:43d:6e0:9447 with SMTP id
 ffacd0b85a97d-43d292dabfdmr29602107f8f.28.1775614930625; Tue, 07 Apr 2026
 19:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408021359.3786905-1-memxor@gmail.com> <20260408021359.3786905-7-memxor@gmail.com>
In-Reply-To: <20260408021359.3786905-7-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Apr 2026 04:21:34 +0200
X-Gm-Features: AQROBzC20Qb8iEJrEOXaxL62fqJgWDKo6nGEtucaqNncz_9-sMhPIxakly_UF5Q
Message-ID: <CAP01T76s6C8rM-5M2e=Jok-GJr-9BeVnuc7JHaODQmUmam9hdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 6/6] libbpf: Flush verifier warning messages
 by default
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 04:14, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Allow passing a log buffer with log_level = 0, and also set the log
> buffer by default when loading a program, so that warnings can be
> captured and flushed, such that we can notify users of deprecation
> messages from the verifier even if program succeeds in loading.
>
> Use the presence of enum bpf_features member to disable passing log_buf
> with log_level = 0 as the verifier will reject the program due to an
> invalid attribute. Low-level bpf_prog_load() API is relaxed, and will
> continue passing on older kernels as long as callers don't pass log_buf
> unconditionally.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> [...]
>
>  retry_load:
> -       /* if log_level is zero, we don't request logs initially even if
> -        * custom log_buf is specified; if the program load fails, then we'll
> -        * bump log_level to 1 and use either custom log_buf or we'll allocate
> -        * our own and retry the load to get details on what failed
> +       /* If supported, pass a buffer with log_level=0 so the kernel can report
> +        * success-path warnings. If the program load fails, retry with
> +        * log_level=1 to get details on what failed.
>          */
> -       if (log_level) {
> +       if (log_level || want_verifier_warnings) {
>                 if (prog->log_buf) {
>                         log_buf = prog->log_buf;
>                         log_buf_size = prog->log_size;
> @@ -7927,7 +7929,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>                         log_buf_size = obj->log_size;
>                         own_log_buf = false;
>                 } else {
> -                       log_buf_size = max((size_t)BPF_LOG_BUF_SIZE, log_buf_size * 2);
> +                       log_buf_size = max(log_level ? (size_t)BPF_LOG_BUF_SIZE : warn_log_buf_size,
> +                                          log_buf_size * 2);
>                         tmp = realloc(log_buf, log_buf_size);
>                         if (!tmp) {
>                                 ret = -ENOMEM;
> @@ -7945,7 +7948,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
>
>         ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
>         if (ret >= 0) {
> -               if (log_level && own_log_buf) {
> +               if (want_verifier_warnings && log_level == 0 && load_attr.log_true_size) {

I was wondering whether to use own_log_buf here or not, but would like
a second opinion.

> +                       pr_warn("prog '%s': -- BEGIN PROG LOAD WARNINGS --\n%s-- END PROG LOAD WARNINGS --\n",
> +                               prog->name, log_buf);
> +               } else if (log_level && own_log_buf) {
>                         pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
>                                  prog->name, log_buf);
>                 }
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index cabdaef79098..7c72ade7a179 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -378,6 +378,8 @@ enum kern_feature_id {
>         FEAT_BTF_DECL_TAG,
>         /* BTF_KIND_TYPE_TAG support */
>         FEAT_BTF_TYPE_TAG,
> +       /* Kernel supports success-path verifier warnings */
> +       FEAT_VERIFIER_WARNINGS,
>         /* memcg-based accounting for BPF maps and progs */
>         FEAT_MEMCG_ACCOUNT,
>         /* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
> --
> 2.52.0
>
