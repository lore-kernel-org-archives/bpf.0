Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793320095;
	b=RqHtFkB+CC2LYr68cXGVV6hYmczPEpVUnoHO4XptUvAAWAYWa1+eDYS/ahB7cH5haP0p
	 aBwApAE7Yx7TjxYNpxSLUV/b+Hekbn2Kx+u+2Cy0cYbx7v+Qf5BCO8AfN+w8d+wNSdHgF
	 5F2K6XLDfAUTXtSNnq+20NjVh53CbEgeigmhd9PGGkmSKHa4x958O/7OcBoUjQ5usd0N1
	 /KM4C9zCt3Y/Lc8HRfWuNb9lt+530TPQgPmJSiDuS3V94+GX1i/845URXaz0zStZ68EHr
	 STU6WqYBoiwLSU1Z6yH5hpfifX/yaSfKj4fmLRKl1OAWR6SEjhe9CSNN2ksRa5cylbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
	b=uFV8gpPcjgoriKEGE7SgNQi1/+zbqlpr2ilZX/5olLOuZ+wIbq/MdwMiUiLBbmHM2x3h
	 exZloWgiywWh46w79In/FzlbEaWffNe37jyhBAWHaGmmThxIP/jiVddjjs0gI/ZSgXDRq
	 x22RHD1cfwLJH5PSsNR2rD37buiolNjUP0SkwqSwJAuqKl1LDYcXPvlZJ+ePOZ22IuErm
	 gThLDRGX2ub4N9+uyLE2BU79OxsTz4nWAMaL88brqAyDCTHEag8f6iLAxPPTazJ8RfeoQ
	 ZPLtQO22KCLsMUDfV6zumh3fNGpMT5Xc3nzWW4oox2Dsz1TITTqL9dP+5VfmNhgYEdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EPx92SD2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07A606A31F
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 00:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B07A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EPx92SD2
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c40f29667e6so15476066b.0
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 17:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793320094; cv=none;
        d=google.com; s=arc-20260327;
        b=n7aQu85ovcPeQNiYybIsguJ1nt59UO3b4hJRGlu0Qbzqbp+MBk7pFFxzo/AfNSzZXR
         wJPsAXDrCyHSsQBniRMFf+8sxMD4wGUoquXKkgOYDAwHmCXDE/2c3c7AhSeCIWQzUhR4
         NyoxmG/6kPmkN8WdF6rIrkaJXMy4imMZQQDwSOvFURmfkgpmVaMnedDP8pE3PKSZ35j+
         H9QeHxbfxBBdURf6NtQ8pNi4WXVFJmrD0ImGMhNdYA7+Nc3xOtf4BxhiYq9Ym8bHnsRV
         E75XOSUwRfWCEY6bQKLSsfjwInXHOieAZUzHwL85EKgaovmkTShMgxdndyBFZY/apBxU
         B7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        fh=u+a5O4bjHVD3yAl9wj5UNJFq7BXtyv1kU7Kqg+SxQxE=;
        b=FRxaaPlnBNgAiUxx0B9kWJSSvktqSqpS8avdRBmmkbShD0x0S19CdueEzX+q8UjgPX
         Pnh0DJqTvTVniy6zGhvVdCIFNdj3E2DBdQ1btn67DgSCyuRsDG5wlQSZ4XIK/kJU+6Si
         Yoe7TDOfZmj4eRLoQZYGua5zJzxPllzWsYYVfNwuTsM8zb/jcNRrrp69426gdyD3NLBn
         bSJDeRhOKajmE8Rd2xOVOpHsJgoHR6vCPx6FB7H7Zl3cX04i7sIcp+YUFZMdo39jCrzN
         z/sH3pcUood50tD0J0EFNoKhzxpWxu7Sd7HyrsJOIX7/fDmmKTBgzdst1OLoCJgrnxE6
         4/6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793320094; x=1793924894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        b=EPx92SD2/nlj7Gy51oiGKSuUhEEV6f/QjPP90GOkDFVvLeS6MkjDeipocwNmUYAOHo
         Nma4hshQFzy8X4MAfiLVXTjTch8fzebGbKsTHtFJVZmvtcJ/XLqiU+X5MXeqsCMVmIYv
         Za79hAeh1NeJmDlCqaGo8wCd2EdswfqWUwrXH4+pxbUG3u1MGAduayGdfH3uUrZKg2FG
         eri6QEgtNhdn53F3TkjFc1eyvmQSMpWYENciLq1Xsp6jUql6lXYYI0BBLIWwe3DleuAP
         Gnl0sybHD7FswrWEWSln9OeTt7tTQs+RyhYAc6FCxYbGnZJZKGP3TlK3uV0H5AyQZyiV
         9+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320094; x=1793924894;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brgLj6lJ9qrzkbEmy6aUespMxR1HwV6CvzIg1+zIkpE=;
        b=M/adrObk7w7iLwu76fJYwSkoV5qFzgqr/O3WE4n+uxAMeBYc9+fjBDH2ovhkEFCjb3
         g91adYHyd1B/z5lVidzn+fjGnSz/n1j6KTnkrmCwjFWfYwLHfcAyMD3JjnB/ZlnZvA+X
         oaBrtwkIllOylj1anrN5IwJEI5pW7LPCaT5Ngux3QsQcugpMpHDIyF5LQWhchugtWTud
         vNfbdM8qxcrsxlWzD5Q+Uct50gq7OKvLTJ8PRP8BSWCCgzDoqC7b214vuOMIMOWw3/Yx
         E5kvRyaNkDucJbFa9E/hkUZQzoYeFlF7C5PpCv8JFJoIkYf1e3RPzwMogJCfambApW7S
         UmBQ==
X-Forwarded-Encrypted: i=1; AKwUvByklf7aPFplh+tOPpQSqgFLrSXHtdUAv62dS9lUVt64TdbLAjnmFYxiDAuVBY7szRfYc2I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpeQxbQUOnMEKNl+dz9GwEu6l93rE35I5zigIvZcQVhXdf5lwv
	vvnDyOHv6dC+weyRZ1GhUkOKoIuwMIc4qHANNcoogsbxNVWjUuKW/SoMDBKiFOSukIKTbhJyJPB
	u6+Z9lItPEqyfbJdgbVTccRP5feM/50ai8FDefUni
X-Gm-Gg: AYBFou1BT6wEa2fGgO0m4Be4Ilx/fFeiQKCnLQ/yhFKn09+pYg9z/E4AtvV3FiL0GKQ
	Mn5LeiI2UluwHmXXQYiihzOkKTWZpFxSAD0udw6BWziU6uBkN3JFTEDvpW6LN3neKvQ8AJ8esZl
	QRA52qC2j5G29tqJV4ajODko3OFGkg9hFtPYjYQ4fVHTC8iGvWZ8PPxjXvdW8vxe2n4mLxUVcY9
	PLL1XQEP6yN0RmEGA9VwY7QLYeFVztZvn/nYLk7+zCpSqFix77gIC2aBJ+X+JaDSTHXDgDxTygj
	Bi4UfCutbCwnQ61Ud8iy0qfwT6L1ufVdK8+opfsRMhNV/7n+4tGHnvJQCFkK7giLSPDLZt/n53l
	3AXCBtDj15CJx4SGnW/+99Jpob/4/z/1U0iju6oCF+AuovcnROGXm9MCeypaGkW1synfYVSM=
X-Received: by 2002:a17:906:730f:b0:c49:a849:cb90 with SMTP id
 a640c23a62f3a-c4ca7a9b33bmr56944566b.39.1793320093443; Thu, 29 Oct 2026
 17:28:13 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023001603.560210-8-wusamuel@google.com> <20261023001603.560210-9-wusamuel@google.com>
 <20261028134012.01d52e94@pumpkin> <CAG2KctpGPHo-S3AEvBhK5HPUnDHfoJu6Z-r+cS1hQ4Ps=B3DmQ@mail.gmail.com>
 <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
In-Reply-To: <CAEf4BzYT4rvKwbOJ6UQ3zcp4wdsSBqRsMz-2=U1DA2RyUA3XSg@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 29 Oct 2026 17:28:01 -0700
X-Gm-Features: AclHuK9TILtLrldY6faAGXZBT-kc2c2frEEMYWdaANb8mW26TierZlqcroORRGk
Message-ID: <CAG2KctrwzWGFRs6CZcSRaFOWx49WbH9LQVQJunWsPD3MOXn_iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] kallsyms: Add KALLSYMS_QUERY ioctl to /proc/kallsyms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:16=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 3:06=E2=80=AFPM Samuel Wu <wusamuel@google.com> w=
rote:
> >
> > BY_NAME matches names exactly, like kallsyms_lookup_name(), so they
> > would be different symbols at different addresses. Please correct me
> > if I'm missing something here!
> >
>
> foo and foo.constprop0 are different functions with different
> arguments, so I think we should distinguish them. The only special
> case is .llvm.<hash> because that suffix is added by compiler for LTO
> and I don't think the function itself is any different from the
> original

[...]

> I do think it would be good to spend a bit of thought on how to
> support at least one-by-one pagination from the get go. The same
> mechanism can then be used by batch version. I.e., think what can we
> use to provide data back to user which they can use to continue search
> after the symbol we just returned (at least for fixed set of symbols
> in vmlinux and modules; we also have dynamic symbols added for [bpf]
> "module", etc, we should support those as much as possible with the
> least possible deviation, IMO)

Let me sit on this a bit and figure out how to distill all of this
into a clean interface. I'll keep the .llvm.<hash>, pagination, and
batching in mind for the design.

[...]

> user code can be easily written by always setting buffer size, even if
> kallsyms_query is reused. This is the pattern with PROCMAP_QUERY,
> let's keep it consistent.

Ack, will have size in the struct for v3.

> also, returning actual size even if buffer is too short is a good way
> for user space to "probe" and increase buffer if necessary. unless it
> adds tons of complexity, this is a good and flexible UAPI

Ack.
