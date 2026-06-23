Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D713AA1A8
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248485; cv=pass; b=SXhRLW8kgpSIsw6L/hosAfvSkwZv/bt8OKx0vXBdgJ92HNZjqpCkUEA5260C+S/2a+iLGGnoi/Hhl/7qzAFnv2IxVgLt4D0iq/vGNSTnRwG46ejGmwsUV96hoReMbrwhOgZPe0IEoiFjkDrZVE4CMlStKrPdrJvoKVoZs7ekbrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248485; c=relaxed/simple;
	bh=7T/6V1SFMpqdmkLBplAd/Ku+9PmkK2UkbtvMC8A9z3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZLZiv9EHi/2TGQpa1FQNH0yQxXFmrKGaeqzEU0AH4N3pv1qi6KIziHCwYFjBPzXUgyBT5+qzhwBdsa9qQ4x0TfdfcLom1noVOIBG2FaCnsDjAiIPjheMvHyDu50MdJdHJlgLc7IIc4q932xDDDfeFiFuEB9UyRo7IWWi99Zsh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffrQsnC3; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffrQsnC3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c74383c93cso2392375ad.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782248484; cv=none;
        d=google.com; s=arc-20240605;
        b=I/djemVemMMpU9lWme0Fr7I3z6R190HSQGtqgu6yaiRXH1W/Wqt803PDh3JyBot1QI
         iqoQsjsg9eVw3LWh5SO7EiHq4/TJp8MYPkjBAf6P4yqdf4mdppNGwpqWjhz6kQ7vuNb3
         UbExZQvZBwS0oiDgRj3g4NMQWQRt68GKSAWLbc4NpCHzt7HwaqHd6EQR/PtE8ur3IKJT
         xMWrT4lTh3cMpmPE0VZaRsSysjzrl7fLZihJir8Yfhj4xF+ggHfiNRTvPOYMd2M40vw9
         vTedKvDeFLAl8rW9PH3olIYIftyKJrPLujflTK7tKpHa/mbrx77n0cJ9BOt8XKfgzXEF
         TmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fv7Koq2XgnVxWRydV+PSc8mxcORJr0BM/BkCsXVSp0w=;
        fh=m3sBHM7lRgVtGSSCXZ6GNFC5i7W9vuSNmSsiGueNmyM=;
        b=JtG0/VKbs2tMVBxum0cUhkD4w/gnoFWMdRPc6CCMx9JScsTpUgkqU90yLyViNQPLge
         Hbi1U9MautwcOEZoL9Qwe2Rmuv9p8Av3kJG7vOPo9xL1j+l7vG4tyHcbTsamNcfcDrUv
         vrvdu7nMkh0LQw8ul7MYmIUfCOANzOjMlcCYr3qacrgoo02+SXY+Ctpk3kW4e4QzJqHW
         2y5wD34ibbn//ltUavqwH8crdyd3OgQBuLiAbDrEYBahgYYlGnilYBy+gumtLPjI2bDE
         y1/M170jisVBIdRXxvGtti3GiTcwlHjwes+MXVTD/C+mBvdRy55wqH1k1HbN7Tqps5d3
         dxvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782248484; x=1782853284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv7Koq2XgnVxWRydV+PSc8mxcORJr0BM/BkCsXVSp0w=;
        b=ffrQsnC3MC+7ro+wXXrqJ7LfiLg54UNU+F2aTjZ8CVUJ1PFSOkObfGYZbpO+zhieiL
         gEw7WMJjn5uPhMg28kCjvagivl/rtpP2jaYTKXrgU8dveFH5afQXJMiNAeV/JPGw4iPJ
         o0f6b5pgmlm3pdftgq9B8dwjVYMIxaFHLdAUo05rTvRRco0ywsidtVDztcqGpXD6ztzm
         lHnO5Qg09cgL2cL96Krsvd0G2QAo/f2ghqbbDNe8hwN5M7TOlONMnk+GfjMBkiqKe42X
         FdeATVF5RWgphRTfnEtCdTNvA1Yhkx96tFevkrkBNbwly5xQGK6m7B0dqADdcTbLg/Y+
         zHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782248484; x=1782853284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv7Koq2XgnVxWRydV+PSc8mxcORJr0BM/BkCsXVSp0w=;
        b=pTnR02OPq5K9TFbBpQwixuElyid2bW47SRULfGZD8HKWCBl/lIMBXenazsQCgDo8gN
         ur4MDkn/MEgJxmEW6lsom9HaE8YZHaTJU4ZERtCUyudoa68pWn77ZODl/GexvL+8+DSg
         LxRl1a3NQjqyv8LqmZYxvlmHpKesUqMalsARqVDxUiTvukyUwtcCd8OMR/C3ezZ5xD7b
         6xWoEefcO+uxlZGUuqc6vxv/KzCD6IGlPY+48UHtchnvRLOjIGWjMkSTmrHXwj1zMKHr
         +xS/Gd9bdSqxF7GZI6PzyDlVKNk8Y3OKHTiiZ6nM8U+4kAmzX8/ruOl0XaLIUqWST7dv
         JBww==
X-Forwarded-Encrypted: i=1; AHgh+RqXUO11qPKKlJLeYUUtXuKCfPYIATQqfYjz9Xc1bdT4u1paz4xIS817PTcl80cMTREjG/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsv8Gh5rE4U0/JucDQ2Z1c8me/jtIPJyvcP4FXFkZXT4Do3nKu
	MP6nLRM+N2l5CjqjJhlmNK+c9CVAcsy2Gih3FcyiR8HEK+WQTAhuVCs1x8Mnp+Y9K+GL7qm6OKX
	RghG07zzVdhwiBjVrz4OfshBiuPklvR8=
X-Gm-Gg: AfdE7clilRcZHK5QULlv7yW6UJHph9BS/Fll/T7eCVzc8UedMtbjlgOct/tCFT7XdU9
	/GWFBnthxm0mhz/pQuwtERhtAoj+4DEWyjB9UlHH0rclhF0QdyNj69aKum07lOHxBE3rSJf4Tpr
	wJfYYf9dssowwJ635DHwVA+CJ/9fazfVGfpACPmQWMhmKzRsantv0igRz0RmbaI1JUWGpToztfD
	DIC3Q7VlcOiqBMWw/sdPS2WhF7bfugBPzCJ6g0ppB9pDK0euiy1eJvKZWu9f2JWkIj0k+rhknak
	WWiD50pxU93kHFPPatJ0f3hApob11uBCaVVYBmYEMOC1WJS6h6tHqTtBdJQRlSddQPJpDt9Czy1
	BgJ3G
X-Received: by 2002:a17:902:d505:b0:2c0:bff4:96a7 with SMTP id
 d9443c01a7336-2c7e149a8b7mr5784275ad.12.1782248483664; Tue, 23 Jun 2026
 14:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623142417.275892-1-jolsa@kernel.org> <20260623142417.275892-2-jolsa@kernel.org>
In-Reply-To: <20260623142417.275892-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 14:01:08 -0700
X-Gm-Features: AVVi8CcXleoXsgMegctqxkoXOhkCD-CpnLrf6-waSmx86hOAYM1yRO9mYi76Qg4
Message-ID: <CAEf4BzYVjf4PfJUedkzRUteNOsb7kHafAbndaaNHBbVHqtOEPw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/3] bpf: Add tracing_multi link info support
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 7:24=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding BPF_OBJ_GET_INFO_BY_FD support for tracing_multi links.
>
> We expose following tracing_multi link data:
> - attach_type of the program
> - number of ids
> - array of BTF ids
> - array of its related kernel addresses
> - array of cookies
>
> The change follows the kprobe_multi and uprobe_multi link-info convention
> of optional output arrays with an in/out count,
>
> On top of standard tracing link data we also expose addresses, because th=
ey
> are useful info for user (especially when the attachment was done via pat=
tern).
> This data is hidden when kallsyms does not allow exposing kernel pointer =
values.
>
> Assisted-by: Codex:GPT-5
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  9 ++++++
>  kernel/trace/bpf_trace.c       | 55 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  9 ++++++
>  3 files changed, 73 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..80423ccc6b57 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6839,6 +6839,15 @@ struct bpf_link_info {
>                         __u32 flags;
>                         __u32 pid;
>                 } uprobe_multi;
> +               struct {
> +                       __u32 attach_type;
> +                       __u32 count; /* in/out: tracing_multi target coun=
t */
> +                       __u32 obj_id;

we have attach_btf_obj_id in bpf_prog_info, but target_obj_id in
bpf_link_info for tracing programs. The latter, though, is actually
not always BTF object ID (it can be prog_id for PROG_EXT)...

So, me personally, I was confused what "obj_id" here mean, it would be
more obvious if it was called "btf_obj_id", tbh. But that's a minor
nit/confusion, not feeling strongly.

everything else LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> +                       __u32 :32;
> +                       __aligned_u64 ids;
> +                       __aligned_u64 addrs;
> +                       __aligned_u64 cookies;
> +               } tracing_multi;
>                 struct {
>                         __u32 type; /* enum bpf_perf_event_type */
>                         __u32 :32;

[...]
