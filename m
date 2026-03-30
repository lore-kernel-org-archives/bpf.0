Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9E33689C
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882973; cv=pass; b=pyZ2OVWvrI9a3334Kkg2be1OstMw4FsenibV2xhzX20AbmtR2KAtn7yciIM/Uuat7lN2a/+fBviETc2dKkIT0mscUe1a/o5xO3hUH8ucu3IpSZdAQe/qg9Jme/L2tmQNpxtvYkPHi/x41o2D+6b/A+u/uW541kbfaO/xe/9HN3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882973; c=relaxed/simple;
	bh=mWI6CGrjZ6GleikLSXBvxgJunZa1oGyE1IZx4k4g5kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJV1qJJvWNJ/9BWRY5fZLJiyvECY/ouD+6GwoD19KbO2trHaGlcf9gKR128Q5PH2ik9zclJMAYZJTa2ZdTvA2/fjbcYY43BKDNwoGPB9hIB3WVGjxRl8OOXVy6CA6paLkXTJF9ADIJNXXnTzYXwCJGvpOq79MnmAR3UEnuktHe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYgchzsX; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYgchzsX"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so901141f8f.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 08:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774882970; cv=none;
        d=google.com; s=arc-20240605;
        b=eye+00FPMnRQRzY1gQP1QV5FIl4I7a/8ECBRIbFeUpGNXhw0SZ4oMqg85Pn/35Yv2/
         3/8arBgWDS83kQuTSRawtxMN38M7SVANfLgDpaqzvmoB3MQq0+Zm0ABM0LyTo22AzD9y
         NYKjWBu5fkIv99NyJkmx6Kq2QFBZ90utq6N1qbD+9QL50arKr1pMjLPU2sGdf6jlC2PX
         pfPdqcjaCb4lk4h3+6M/w7iqSwjk50co33ggOrLwelrPrs0sxojBvgfh400j2RCOv6kx
         trU6T5S70qDdBvRjg+Gpj/lgrn/IB7Y6qk7osfFoMzJY78t+AgtluqSKp1bPVu3wfqRt
         NfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WxslLM7DAGNt3GjJqZblT7BAkLS56+uLYD8pZtmF2F8=;
        fh=RjjnTCvWvCZ2E3syD7rnd6tBuUJRd+K++pAni8vipgg=;
        b=RgVhCgsF8UQOvTZxWB9FMNl3YLtEBOvWobjFP7QndwU/hVgunnuZ4HiOAyUYqXkcl1
         zBZYnr+2K5x8RviJAmDCFWsCaqByn5dg4IcLprPzaHRwoZFEl85lAKzVe3a8FVOJZRtG
         7ADELLK0WKdaOXbYZ0qjxrQeKnXLm57/CMrodEgOtgWHg5mYrSeJGZWHDXFyq9nPflID
         /i4VhSPBVTqonpBFFCH7oPk0ISpOAPgY9imZrsYMWzl5/YzPDrEGa9Wz2aasDr61Te+/
         p4RiCz59hpPjRjE04hD0vEssEprB+uHNv4bkGWObvvrdQCw6FlUVRpe9CA02J8n728j0
         Gh3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774882970; x=1775487770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxslLM7DAGNt3GjJqZblT7BAkLS56+uLYD8pZtmF2F8=;
        b=SYgchzsXqFUygqgr/pZM3f3ZS1/ynELhIVLWOt6HPaCkYehE0XQvUGi0uLlBzYx9Ko
         HW1CLB63Yi1T0APQhHweuxxl5Vy4QjK4xqhgMceFzSOf35gGi5HEjX/nF0K1k6K/DQXI
         Af2ag0t/jr4sSmQQWq3hPV9WOEZlm5BzBI9XwCVoxkb+jky0Wtc9qQFhN+rxFj6O4sUb
         YN+qWUSBE77++BAtxy9CejkrURyOLBUMx67eNYIXOg1seljRvhOhZFNv7YbC5bi9xaBp
         bK3YnXLnLXQ2bgpg0A1tFFVtrKua3pVtMHhDKnUfeDAyUR9uMJ6ixkt31H2hal+9jb5X
         KC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882970; x=1775487770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WxslLM7DAGNt3GjJqZblT7BAkLS56+uLYD8pZtmF2F8=;
        b=DdMFqDDd4StAPFOjsaIdAsFyACbCooE5Tf8TtcVb9rvpoQUVsLHg7z5vQVvaI/X22w
         ZupHtzOJ1aj5bO3drsJVFFIXLmVLXeFkgO29sbIIjasU2Sbcw3SY5iyyP70s0+PekISi
         r63axvkkryD2Th2dxnsdYh8N6Kk1Ujv6Ow/4SrmjjHow8CrLApYvIDDV2dLPB3LfG90I
         eCP1WhKgMdEYVxzZ/xb6OuHb929emee1EvIvehntmtp9/pug68oJ8jYzuz9x6isqVqqe
         4s1zp6dwXxc9PGeSqb5IWIOI8+n2DiYMaAYqgdv7n56v7CwM1rfa1/FiPPmZHMo2iSjS
         ERqw==
X-Gm-Message-State: AOJu0Yx1Ziz1DqIar+kZG7XmzVGOsF2VJA8VNLhjEAACAAWc0G6AzFxp
	YaOc2jH9wOOryLnz+hoY0mD7Iaet+AHu+9jsrqWQIJ9suLhViTCiuloDcQeujjAeDqPf2sFg0yS
	xeezxZ2A0oGutiefbNcg7D/Xj6RuPrw8=
X-Gm-Gg: ATEYQzy3QD3S+8Ya+5Wjb6cnk3HuRPDUCXBs0cZ00dMIVZqFClo8MgPcxp/ixJPBDFF
	2leC13iAA+rDBalYEI9DquvAqct3yC+f8vlhl1dsExzwItyIVg3R2CcS5ra8MQJWFuQQhVYIibe
	h4WgtiaD2yi7GmXB5Pam4g8vDuXkVWQ2u11KTUvSPy9hwK8YVHxkiC9iL6K0jZyJQL9J+c3lq9p
	iZmOamir6GkTZfzW1gMDJhl3lVhOjHnWC0MhSyLib/mRUV5HlW9lwQdMmgjvBOy98esAkDgLyOK
	COkKMHcW+iGA0F4X69YjR1ywkSwBeAZnpmLimnODhPiCDGLx/HgdqULBDj04+NHzkJ36lPNQu8I
	qYqYmOvso/ZNAMwx5OABlx7grHw==
X-Received: by 2002:a05:6000:2006:b0:43b:86ce:27a1 with SMTP id
 ffacd0b85a97d-43b9e9ea409mr23400340f8f.17.1774882969615; Mon, 30 Mar 2026
 08:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329212534.3270005-1-memxor@gmail.com> <20260329212534.3270005-3-memxor@gmail.com>
In-Reply-To: <20260329212534.3270005-3-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Mar 2026 08:02:38 -0700
X-Gm-Features: AQROBzBM5X4ByuglDMTc71ndQpCkNXXRfQfZ_LRZJeIGbiWyH4IHT-UWagoDbzo
Message-ID: <CAADnVQK7_quTWNt1R8Yj+9iN-4W4T7L10jnsOGj16OR1a50DRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Emit verifier warnings through prog stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 2:25=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> There is a class of messages that aren't treated as hard errors, such
> that the program must be rejected, but should be surfaced to the user to
> make them aware that while the program succeeded, parts of their program
> are exhibiting behavior that needs attention. One example is usage of
> kfuncs that are supposed to be deprecated, and may be dropped in the
> future, though are preserved for now for backwards compatibility.
>
> Add support for emitting a warning message to the BPF program's stderr
> stream whenever we detect usage of a _impl suffixed kfunc, which have
> now been replaced with KF_IMPLICIT_ARGS variants. For this purpose,
> introduce bpf_stream_pr_warn() as a convenience wrapper, and then mark
> bpf_find_linfo() as global to allow its usage in the verifier to find
> the linfo corresponding to an instruction index.
>
> To make the message more helpful, recommend usage of bpf_ksym_exists()
> as a way for the user to write backwards compatible BPF code that works
> on older kernels offering _impl suffixed kfuncs.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h          |  9 ++++++
>  include/linux/bpf_verifier.h |  3 +-
>  kernel/bpf/log.c             |  6 ++--
>  kernel/bpf/verifier.c        | 53 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2c4f92085d79..d0158edd27b2 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3912,6 +3912,15 @@ int bpf_stream_stage_dump_stack(struct bpf_stream_=
stage *ss);
>                 bpf_stream_stage_free(&ss);                    \
>         })
>
> +#define bpf_stream_pr_warn(prog, fmt, ...)                              =
\
> +       ({                                                              \
> +               struct bpf_stream_stage __ss;                           \
> +                                                                       \
> +               bpf_stream_stage(__ss, prog, BPF_STDERR, ({             \
> +                       bpf_stream_printk(__ss, fmt, ##__VA_ARGS__);    \

Warnings are helpful, but delivering them via streams feels odd.
streams should have been an interface for run-time where
either bpf core, kfuncs, or progs themselves send messages to user space.

These warns come from the verifier. So conceptually fit better
into verifier log. libbpf doesn't use it by default, but maybe it should.
Eventually we will have common_attr in sys_bpf and other commands
like map_create will print human readable errors.

pw-bot: cr
