Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13A37E307
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083859; cv=pass; b=SgKmy65Wd5BzwEYFXhcMxRIDUnZBw3R2XrEUNQfLH/yz9pbC/OY5gTQDRbsW03+K5qNRHJXHnmedQmEfpgScMmgzYBithxLUfIH6/hjdY13JugSwSBXwpobfufn8ukAa6WHUR2G5NWDwVnHqIUOcfK+sQJcRsfnMTKXqHQoaZU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083859; c=relaxed/simple;
	bh=v4M8KMoXQgklC+cA2d0h0B28LBb6xOYosA8DjXrFB7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8vtYs885u2MTF6OR2VM8Dyard8fxJ5HNWCqVJoR3Y2nPrA8ck/YR/oUMTp4CP+DR2vAiNP/GHOjSQtMJwljOmd1jTLw/gGxcKhdpDvwYE7rfk3Xm0VZgW7qYqq08xvVxqp8vXqqEfXwM2uC+IJXBVzAAaGUQhUp+TIf1IgfDqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6LyGuPu; arc=pass smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6LyGuPu"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso226228f8f.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 15:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083848; cv=none;
        d=google.com; s=arc-20240605;
        b=e89UOFT0YeExH04SnMYgKzHuqXF37CVVGSPc8RjDAzONopWBjIeUEgcYe6vFyXfA0J
         vzFktFQr0ftfj4T9spzVGCN5BC011XT4sNLN5h3J2nJcVYcR9Y+EGFbqo/dKSz4xhXbR
         14gXAnAq2hLxdqjVecm5t4XX0hN0/YBGFNaFBWPX9NV/mpt0m6xNfEmtR9Gr2PbGStpC
         wEIZ8vyoQBpUNR1aIgnN1VUmxMStk4ZADFZ4ZKIoVjNsJv/MZieSr749UcejU574y7fO
         OOvVCcXlJeqohskC06ORNC8RWykonnSeXqRhLLcaXwMICEDgnsAnRAysiwrT45sfwrjA
         1gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        fh=EdDJNFuvvaXJcXOExiesiTd7Q2Nck3mDgpZ8012B5HA=;
        b=K7vIPxdfxS2MZuE0qqK76XSJ6rmU7vf9HJnsCkEgY3fr2OXEIDv5ocXd0+rVO5iKm2
         N0QfBkaLZKBmj825KNo7IrJuTMni1cSPJitJ3UBA8HauExVhE6yNSg1goM37fVTL/qZF
         idDSo/BJOTHBEsRaRNAF3hFeTyM+P7oMBZoxZXisaG3T0Tii2efyQp66WThAvADIwUNq
         zpGpbKE2G22+EObUIxdCnC7opO57ecLdo++JQPCTvHe+foFB9FiDMM5TRxQEmMtWMDnM
         EFsOoJKsRNYOb7hVQSw2UIttXAls2Wgbe630zchCQ0IxrZY+XEzHZsjboZs4+lzUwSji
         pJ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083848; x=1775688648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        b=M6LyGuPubn9CG7GKr5u+m8OeJsVUu1AMCpWfN3pfkONIvilTkoMuA/VXx+UgfFTdPi
         SQI0YnWtd8FTboWAwZS5Y4lvnAra/pdVKB3Kz+11vowJZFMSws6V6fsv11BiFR09N1ma
         0lb8vEt3qz75X4eiCKBNLmL3VxXUzUpTHaxjncM/UTMRiVWDTrbnTrz792y5wIUGqd5P
         eEKhCLb1vMd9bH2szVHsFQo0cWGYZOaXylbM1uBOnm2aVgYzTbSF2f2p4ijqvWLEmvmR
         xZu8w8lLJnCvLrQTZ3jihy3OxT9uZgCrCxEpl4Fj0pEeGSPWElYvqCcV0dg2hNrqkWdq
         eINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083848; x=1775688648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        b=n09troG7neu+cHdOUwczV5+8BTDPHW7sYkAL3MHIem1ja79j4VkzvlZW2rpx5UrlcS
         BTt1D8YiJN9JdpMHws4fty+EPw9R+txd72ArCeE8sslEikIG8eaAuRVKe6J/2Dyiel51
         FSXqi8NGp+jmv+WdkvkyfHumkHv7l6J7svLP9IjhP5u6WHwLltf5SfiFeueHQOIdLrwF
         /M27bEhH46MJhPcDcrn/DqQw2JRh4164RRyzIHPqbzhbz5tCVFamZubxCixc6aEszoEW
         mNmqDsFx2T6VTSOvnTTItC54RuE3NsVzk2s1mTKjSxE0e1Tj7Ch6h8KZQWEdzHq4Zhrw
         pG4g==
X-Gm-Message-State: AOJu0Yy/EKUsuROL137+3ri94hk+R2Izl7+cTO9IZCkB0GgV2xMLDLcQ
	xJtEPShBlmF34ACZsuRVrFJwxKu7gKgN2pxzw+oUutPRVXe0oPdsjpJdffwRCDvqfOaPFGeWTLV
	nzVdNJYnlWzbKynd0b8re+ye16EihpVQ=
X-Gm-Gg: ATEYQzyWpLqfe7G/SEnvvlDGd1bNdJWk6CU7U+mXk3zq8X98BMTC5Ht4u0mxpYhs/Lb
	CNR79Cg4MEnVlzSSkA6p9i8pnaz/UpqTIXjGhQYPT3Qkp4A8Rkk0YigkjOYpRozmoD42gX1uOPK
	fYOhDKxb8FaU4lu1jQraNoOjH84rwMZCAwZOTWumM5Sq7RzCNAexTHnx2NaxxCIfiMEllNAXKty
	pvnXemQiqEx5sJMOdfiiqsNYmx0ZJqwvm8DbH0as2gwa9rj1I7swGSVmrvJcfwzzQnwpJ9tqlqs
	CC1aRUvpO9QPhpIVzf6TtoZ75lO1IfjpaBTtyDD2oAUN3BbQWws2VlYJlwc=
X-Received: by 2002:a05:6000:2689:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43d15045e2amr10280803f8f.6.1775083848125; Wed, 01 Apr 2026
 15:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com> <20260401191126.440683-2-varunrmallya@gmail.com>
In-Reply-To: <20260401191126.440683-2-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 00:50:10 +0200
X-Gm-Features: AQROBzD1-AIT4sIJv-J5BCUSlZzW71S_yOFNJ0PyY4p0C6cBjNf7hayAGjE8zSg
Message-ID: <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi
 is not sleepable
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, jolsa@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> Add a selftest to ensure that kprobe_multi programs cannot be attached
> using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
>  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 78c974d4ea33..f02fec2b6fda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -10,6 +10,7 @@
>  #include "kprobe_multi_session_cookie.skel.h"
>  #include "kprobe_multi_verifier.skel.h"
>  #include "kprobe_write_ctx.skel.h"
> +#include "kprobe_multi_sleepable.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>
> @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
>  }
>  #endif
>
> +static void test_attach_multi_sleepable(void)
> +{
> +       struct kprobe_multi_sleepable *skel;
> +       int err;
> +
> +       skel = kprobe_multi_sleepable__open();
> +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> +               return;
> +
> +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> +                                    BPF_F_SLEEPABLE);
> +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> +               goto cleanup;
> +
> +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> +       err = kprobe_multi_sleepable__load(skel);
> +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> +               goto cleanup;
> +
> +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> +        * Also chosen a stable symbol to send into opts
> +        */
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       const char *sym = "vfs_read";
> +
> +       opts.syms = &sym;
> +       opts.cnt = 1;
> +
> +       skel->links.handle_kprobe_multi_sleepable =
> +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> +                                                     NULL, &opts);
> +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> +                      "bpf_program__attach_kprobe_multi_opts");

Nit: While vfs_read will likely remain stable, the check could
probably be stronger to distinguish an attach error from -EINVAL?
I added a typo to vfs_read and it still passed, because it failed to
attach instead of getting rejected on unfixed kernel.
May not be a big deal since vfs_read is unlikely to break.
I verified it works by adding bpf_copy_from_user to the program and
attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
LGTM otherwise.

> +
> +cleanup:
> +       kprobe_multi_sleepable__destroy(skel);
> +}
> +
> [...]
