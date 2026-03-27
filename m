Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE237998C
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644495; cv=pass; b=A+bb4Fb/DIQXSHEszCi5fnLdTKhus8Uej9EIqwiE1ON5fUN6LxxDQ4j/Rj/vWd2176Es8E/H1RXYVLttflPt+AYnT8PAr0K+t9pMMOnmxBvsYGxuScR6HcvweOHJxemTeXHw4FB0/jL9SSKox/N5JHZ0pI22t1ojlEwwMWP2wEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644495; c=relaxed/simple;
	bh=3jtKjZVRBwkO1GjKld0BYyQoV8mfCUdU54giHEQ6hZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpkuKHECOm3OJglT6Q9GttMZ1DhsKu7F2CxI1YgGwOJyc5IAlUZsI+MwbWd2fd9FFdaD0VbJeITtTqkntJ5uRfZBxrUsW7vhcLZ95rXVXnGVovLyu/jYHZZ0v6YDxDjQedlg+8DxW7vU/Dcttktg1drknm0XekLVc4gy/RHnba0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnFiMljD; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnFiMljD"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486b9675d36so22215765e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774644493; cv=none;
        d=google.com; s=arc-20240605;
        b=jqpWu4lQ9yqHJSzF/COEInR6kuZLONme4owQykaciU/R8G9+yeTfgRNOutVc1AAHSr
         hOolbMiPx+p2XIZvPGpxEqwNV6zwHYITVUKhUzlkpqb4qtTphdcwRJ4jYdp5UojAk0wI
         hwN8kJhTRw6lZUeQe+zfwxb2zssl+xSAGO+/0UTYinFPDF9A83/VvEeKxDt7c6wCXPqC
         /YyU6IgGhzD5zb1cpd1Z3Cp2BaL+HEpzfPCaJhULZf/IPM3tveq7Z5fNFp+iTg4H0o93
         85e9ubL1lEIfrCIGHY2fYEl0VZaiaZIo2OSTBIj8xGccbrcPNRmeuOaeVv0zwlMur+fy
         mHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EbZDUW2lgE2wqdWUk3OEADqNuzBWF5QVcMl4CiI4N9Y=;
        fh=U7HmkA/3I48dPV2d4Wyd7/NJZtFoL1YwEZSzLuWYtgg=;
        b=MIQ+OEsp5AX9bohwv/Cz4NBxDbIeAKZCDJJIYHWNjPzUrezp1BsMO4BzFy+TghpvDo
         QTdofwrb357+yPGPyzHHQsWbli6AFDbnN1CTJBmagsLIQbmpkaI/XudG+3o3wLFge0WL
         tt/KaOcFWNgSIN6pDEYNAqnZMULeHV/3AAKX2ZHI9XByfTn0VoRk/rnw1QeGRpYR7ZW/
         /V7blUv/UaMLB/ewS4Q19P2xIxUFd2XTytJQdaSWcVOYZUcpnmyT8jMa6sV+H9YfucMH
         u0djFf4QXaGJzr/+B1IeaFoFFC2CQpEGVuVyFf/N/GdzrLdWHWrSpsWT+YMAaY1g9xv9
         ug3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774644493; x=1775249293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbZDUW2lgE2wqdWUk3OEADqNuzBWF5QVcMl4CiI4N9Y=;
        b=NnFiMljDsU3/HqCPbN5JUkDTP1Kt3fCB2CQpwq2+U2vVw21+BpWzbEBbYD89PvMnFR
         RPepeBS9MFuNP595eQR9mSnOdsCj2ERrLGE90Q+fccn/jI8w3pKDOeoa5MMKp60jBw+X
         ooDDzMR4gqN08KsxPDP67yZ5OWsSdtl46IOnAsB64Qq7qjZVTuy9wTxJr6pS5grks4es
         dyxfATNOfXmux4DZmZHTkFT5gRBexYtNX0PeR6EbGdcpF/lh9h3i7EbUeZ9N1r8IGyix
         zUo/n/MkxIaoc8nhrEVkdeEkWhogiiUryY93CEkyu416Kh6opqY23U3nwd7fiZuMeQFN
         j6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644493; x=1775249293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EbZDUW2lgE2wqdWUk3OEADqNuzBWF5QVcMl4CiI4N9Y=;
        b=LTbvolt8pH0Zg2dlTMANCNirtF3oSLb5YK5YtAVFlkbunAj0MMJyRwqv7DuTztV0gY
         bKf9tCzq91fiYJ+L+ArFjwLxR3R7PC7TmiusyctlddffvM+sr2n0SL43l3+/TmYrAZEn
         Si+qotrm0iV7BI7zO+TRovPkWZUrk3mhzQOkFV0qfCiqeg+ObPLwEywskJxOr6nqD5Rf
         cyrwJ9EiJXWqpadLRKGXMbb5LG4lWyG6PCpUtRxq7YXla4Ygs52skJxGw0HW8VD1mZZc
         aY40pzJuYP1ymKiHcy25XxGiw+yFr4mZReVk79Y49zCWnHVdDRIiLQXqJCfczjSz007v
         Y+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCV3BsBt6+IwbYq8EYkHcZEwWdkTkQgiPnwW9PKLQFZ8scmusSGhIP5APSU2qUIdspx1Hcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAfl7ArZWYcz/dP7M13uzrmTKkuG6aOjFRhDMf9WSL3zMy0E6T
	nqbgV5P1vxYR4Za7no30MmW2V7q/ZNPfLM0gMtfQdm3xr3kvhpun1qFIeABcPwz2qFnbpIg+izY
	9jNlnYU+CkvlO05gsqkomiE7WWYV4/0zX3FX/
X-Gm-Gg: ATEYQzxBm24ct+Ec/NTDoXa1bzYdWSF6/3fQeEt9Du13Wx+6ymKmZb0nLIw7dOa99Zv
	hmh2gSUv57odv72eJndbcvn41cq1KCTYC45nSSxPPr/WFr3HXcEubF4DPorxoPCrjbFwfHYu3wm
	mMUV9EGHri4fFQSohsLhq8TC8pGb/slNBm6YFmdmjH4ri6Fc/U/20fizbF1wx+5jIATvahoSPSh
	uFrvvTMqW8GrFdSPSE6Z09WGWfb5h7riTbWt0xQjL6pQ4WQM7jMa/05BHxVsAFMo76eBJMBI4Og
	vmv8njn0Ee1+zxN9UFDZJ2MtSHsyVjnQNoRrjTY2CtDpd2pAnUkbGQyAIufgm5hgUy8FKsmYv5V
	P3MbL9eH0sGdz3499Bw7Pzk2ZDw==
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-48727d84100mr61442055e9.15.1774644492645; Fri, 27 Mar 2026
 13:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318234210.1840295-1-ihor.solodrai@linux.dev>
 <CAADnVQ+iXJK46cFcGN-Ta8KGxe7Y+m_DxgWNS=QC-gOWT=WxCw@mail.gmail.com>
 <b040711c-0fd1-475f-b807-e4e0b4324f6e@linux.dev> <CAADnVQKVEYhFXGXJ0u6TWQDe4t=zmq_tLpGKe2n_pOYT-J58qA@mail.gmail.com>
 <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
In-Reply-To: <21e5333c-0b57-46ce-99c8-f6c414270e70@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Mar 2026 13:48:01 -0700
X-Gm-Features: AQROBzC9JQHmoQaU1x6dkrO8kqvIrWlSiibCSmPcS9z04apruFJxmsWIZmnHwrk
Message-ID: <CAADnVQ+bj2z0kzLcGTJ62NJgReTvqEu8fn6=7=bn+WKmfe9iTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 12:13=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
>
> Currently BTF_ID_LIST with subsequent BTF_ID create symbols for the
> list and for each entry like follows:
>
>     __BTF_ID__##prefix##__##name##__<counter><line>
>
> For example:
>
>     __BTF_ID__func__bpf_obj_new__8524584
>
> These symbols refer to a piece of memory storing BTF ID of course,
> which is how resolve_btfids can patch them and kernel use them.
>
> So the idea I vibe-coded is simple: let's directly access these
> symbols at the source level instead of maintaining an enums.
>
> The obstacle to this was `<counter><line>` suffix, which exists to
> avoid conflicts between BTF_ID_* containers in the same source
> file. But the suffix also prevents us from using the symbol directly
> in C, since you don't know the <counter><line>.
>
> Well since every BTF_ID_LIST and co has a unique name (at the source
> file level), we can use it as a disambiguator suffix instead of the
> <counter><line>, getting something like:
>
>     __BTF_ID__func__bpf_obj_new_impl__special_kfunc_list
>
> Having that we can add extern declarations (so that C compiler is
> aware of the symbols) and a helper macro to reconstruct the symbol and
> read its value:
>
>     #define BTF_ID_NAMED(list, prefix, name)            \
>         __BTF_ID(__BTF_ID__##prefix##__##name##__##list) \
>         extern u32 __BTF_ID__##prefix##__##name##__##list;
>
>     #define btf_id_named(list, prefix, name) \
>         (__BTF_ID__##prefix##__##name##__##list)
>
>     btf_id_named(special_kfunc_list, func, bpf_obj_new_impl)
>
> I don't know why AI decided it's a good idea to add one more level of
> aliasing here with asm(), but it is not necessary for this macrology
> to work.
>
> Additional caveat is that resolve_btfids needs to be taught about new
> suffixes, but that's relatively trivial.
>
> The above works, and the question now is if we like this mechanism
> more than current setup with explicit enums.

Got it. Thanks for the explanation.
Your approach does sound a lot better than explicit enums.
Make a proper patch out of it.

If we do this can we remove <counter><line> approach everywhere
while at it and only use named ?
