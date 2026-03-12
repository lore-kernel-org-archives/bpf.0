Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40663AA514
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349164; cv=pass; b=PiI7lfxjaV0aznEUQO6dZlGcQbKiJDcTnernaxEcFJTU88B4O2Jcbp8itLYpi1W2RyvWNJnjyINjoOadEn2FLQrr4NBnTh0buv0fiOWjE46/0+VlSk1Ssil0hIZV89ifyaJqPpS3sQBjhXWWYwImaR0CXSwcg/G99QLifTMFyoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349164; c=relaxed/simple;
	bh=+mC7v/u6PPGbpx1+SbbsAOlbvQbryROtigIxwXug4VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=le9VJaFHZCjnZWjmmqgw0O8oL2NSU4++PYKZf6jsVp7EDSu7LgRRuOkHXYZwPa92woEz1chVNzfzKcqxOyBOUmWaNlQRPhI1mnGGsyrWrgh5qacrwYJNtctbHCthl5sLqEOy+h12/5WFnKGYvOWSWlghtJUWYVNcTiCHU5rAJg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpnKZatf; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpnKZatf"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae43042ea7so18495675ad.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 13:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349162; cv=none;
        d=google.com; s=arc-20240605;
        b=PdGGz4rlAcANYjd8tw+M8v1i2IBc9m0B+G0RPNA5qQyn8WleundxMFPlL1iVbggHvC
         eHPfTP0oDqz2CFTGA6lUIgAZQ178T2xfJbutq7Jwgu7KX+NAdI0ebvMl7+jBH9Mfmncr
         Ra9AhFbDaumq4HBffGZjYjNQB73mH7XESI9Bn3eMg2yjq+lZ2GRXSd9q92NHD9rbckQV
         hXabc6XeGzx217rYE4mPXJpdSurT9heH0oCwimMw6NR2yoorOHocvxxjhTR4HpE14KPQ
         F4EHT8/hitXuYa4QtS3ROyVYn/O7w0sgb9M1hSNO3VtPzmVD5oPE3tA0V7+eSG0+as0s
         kbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdO2EbPNF4H9SNxQdQX6Ta017anpVEthhmT2/M5wn40=;
        fh=un2GWPmYwFWbdF1XpxMPQYRxhKazl5Rxm/QZWha9hkc=;
        b=bbnOAy9KTaa6ZJ13v1OU6j/2xSKjtT2fUNBjlz8j2ax3E4Fw1BzA6FcmCGsN1nYToF
         C2FKBso2ZzXwleEgOhULIxAfro+ZLB0r+MCeHTfhSup8XBZSEVFaPLtEpEJY7fx+10pu
         4DAiThHB7JOTrgX/25U2M/phO5TP0DgRUh/TsEZkrysGd2R8++FR6/5uNSXf7yVjNLzw
         llfizHEvVZRmJI4P6ENKLcMoCv39RElueTGwf82/Wq+BgO9lZhUkMhL1l3m3e/RBzaNy
         gNjZQ1Ui/TFrOx0ZeB0RXqNscQwzHLNW/PgrXUED8iG3SQAHb4gWiNp2KHsw6X3+J5wO
         YV4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349162; x=1773953962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdO2EbPNF4H9SNxQdQX6Ta017anpVEthhmT2/M5wn40=;
        b=BpnKZatfEIUUMYTCTq4cEQ++La0gLRLgV5EAGm6fBNRCj6yQbDIBEe/0uffWrBq1dc
         UNkZcxq69ylYKK/DTJUGxqPNli+mxqywRPKIn3dWqwVF7Fys5NRLvgZ0wHabml9IM8Ub
         ih1pdEBp9tOSF5xIobNR8hUlTc+yQYugHtQNxccWQBfab+Tp0PHygUzjGrCz9fw1fJPB
         CA35pTEBB0a9ocJ0yLyyVFoJBmti/QxSagwGYbU7LyT0QRQobNvtBqQrMROIghsf60Ye
         LATF9aKYgrPf/7EcbEwF1xjLloEGdHv+22Lr375eZPyvwMqDMTVgwFj8wxshUFZbn4JY
         mWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773349162; x=1773953962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdO2EbPNF4H9SNxQdQX6Ta017anpVEthhmT2/M5wn40=;
        b=jWdYezy513BaioY6bfSpfHA/m/wiEDh6GTH6EhVLP5PcWNiAlcnyl6jVNC/lPPwZUA
         0CBBdF8b8yYRHiJQE6NM4dD1wfzhr6m7gLU6Oa0l5b892BU9zy3MmrG54OV0k3ZvUZsC
         tkMFFq0Q4poKY+jlWnxIMQzzJOnm38omDHOzsVPTHoPl+kFUMTqv4ZiIQCrKQh0nMJkm
         vt8NmUepsSYJ3+Z4qZji3Ysj6EeGM2+QocP/JpClbJU5tkI+l/O9oN/IjtU9ALl/7QEJ
         8vmYEXd8QvCfI4iPclC6vvZsyecZcik42uEMuyW0Iuz5RSL20BqNiLDZOSnamTphiJaK
         JExQ==
X-Gm-Message-State: AOJu0YzyNAqrQ2S3jBiROJ58nBOzq8HcpHUPnf3tF78Zpz+KoL7x6t1N
	5QAMsD5jGKIo4GvV5whgGK0pC34VFxQM2/ZT3s/DuLFTIDT+RN8uNTJ4teXXcuJBMNlVG3W/wLA
	AwiYxVAH5h4dRUmd9YcjedAePcOyK3C4=
X-Gm-Gg: ATEYQzw/AWVQkM6gtNmXTk6vm/R53hfC2j0XX59zgqN55PyWq7dPefLPNCPqxEI3zBd
	/dELe48c2z1vSIsTw8mDSXq+3Uu5EonA0JocbQqTctycHhpCphJDI7sNTisj5maKduoPB3xeWtI
	6Jp9d+E+uM8NdN3bmINmpeZ2MMCc/b7urAlCFXgQ5vP8P63Yl5xmVxht+z36RyX6QkOqjlCyGoB
	q+dfzafw6UzkOSPkKOSuXCJah7ukAIdsPyuJaa0+xyEF+Ls0u2SnJwwwrDSL9QbsHykCZ5hsf8x
	ZwJsilhvJnLcXHYaVFUiSHM=
X-Received: by 2002:a17:903:3c6d:b0:2ae:7f24:2378 with SMTP id
 d9443c01a7336-2aecaaf6055mr8379495ad.38.1773349162098; Thu, 12 Mar 2026
 13:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com> <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-3-3e9bbde5bd22@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Mar 2026 13:59:08 -0700
X-Gm-Features: AaiRm50I_zxxmcxuFmdCtBa45wRWJsXWViRKtDqJpZL82V4rw4itEXNsDdW88A0
Message-ID: <CAEf4BzZ83nVSG7AhzfkNXy3OnomFT781L61sNbJGxFnP0hphuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] libbpf: Add tp_btf.s section handler for
 sleepable raw tracepoints
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 11:23=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add SEC_DEF for "tp_btf.s+" section prefix, enabling userspace BPF
> programs to use SEC("tp_btf.s/<tracepoint>") to load sleepable raw
> tracepoint programs. This follows the existing pattern used for
> fentry.s, fexit.s, fmod_ret.s, and lsm.s section definitions.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 0662d72bad20..7b65869f5c8e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9863,6 +9863,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
>         SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_N=
ONE, attach_raw_tp),
>         SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_N=
ONE, attach_raw_tp),
>         SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF, attach_trace),
> +       SEC_DEF("tp_btf.s+",            TRACING, BPF_TRACE_RAW_TP, SEC_AT=
TACH_BTF | SEC_SLEEPABLE, attach_trace),

what about raw_tp.s+ ?

pw-bot: cr


>         SEC_DEF("fentry+",              TRACING, BPF_TRACE_FENTRY, SEC_AT=
TACH_BTF, attach_trace),
>         SEC_DEF("fmod_ret+",            TRACING, BPF_MODIFY_RETURN, SEC_A=
TTACH_BTF, attach_trace),
>         SEC_DEF("fexit+",               TRACING, BPF_TRACE_FEXIT, SEC_ATT=
ACH_BTF, attach_trace),
>
> --
> 2.52.0
>
