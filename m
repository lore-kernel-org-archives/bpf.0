Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1155037754E
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475992; cv=pass; b=K4/vqbAPT2tWijJPrhIlq5J4pu7RWp4lq23eg+owKlpXT7jxV0rx19jkrlCASfrcoVtZXc1KvyvTDXLYfxJS0Qq7Due9GhExNmxPxy4fyC6+/qBK9BUMDOmi/+WbHdj4Ib05j922Dxjz6uIxyRnJAk7baWx/0CDIEPD3iDImsxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475992; c=relaxed/simple;
	bh=P0n1fZ8hC3OD4nF71hAInfcl9hkB3ZTgTE4eNK/w7AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGdH7z6GY04/ToI+0POn3dLzqUP1tNe8iAEH8HDAO0Vuf3pST+P+lftPp5tzNxfW1jlEvgETSS2hwfjaxWfxoDKD+prPwUCJSO9mIb6AanhfSOe5rcAkp0ACkuRIuPxDTMsP7ZJtL7i92fxoaPrLze7hV/Pkv8ls4qQlcmCWotg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2HSiunP; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2HSiunP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso3842159b3a.0
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 11:53:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779475990; cv=none;
        d=google.com; s=arc-20240605;
        b=U4CmKX6jKGOVv2h7Sm/W4URdHXNcDW1jFca919I2dnWKvsOdDkumsBwZ6k9CL/EvI4
         ZWIbH5Ip5wUCEyeMZlsQLGn5EvLgA3UeVN9AGCxRbjFALk1NOFGrtR/cMwLKpO9mh/bX
         WiWMcSI0hAJA1ZCkyXnnTLSEETlxDqsXOd8/YEAH9jmIKl9NdJIX2JFU77AFVAMxnPzE
         yEG2KFiJnNSM85gRpZnJx2/3tqAgI/m9EpljxmK9uloCWE/8di2AlIWVEq5lM6YrEugB
         rASdX3fCwABP0y3/O/CG65YiNNsoiG76Z2DSaGP4KPMZC0uhuIGZSPOE6ojIJKbc626j
         iGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        fh=t8qlXpOxPGh0zW9pAtJJkP2KzaRgrWbhDKS8DQJKybg=;
        b=ZidH6X/pe1tibqSSdPs/NZE765BJat76pAKFXPXpuMKTZOjXQeZIY+UmVECaRrgk7o
         lwht5p2P4/Ksc3zCo1PEap3+0q+HxGZ+eknpUnv2oYyqPqDks20zbl1S15uYfhCtz3cV
         b+74IZA4zWViDV1UHeC4SKnkRvECPdXePuDKHotBd4kLoAb9D2GuLvU1ylobFiY8ZImX
         PHZMU3YWlxgz68PQcRZ+63NHL5x+6QwZyBWgw750YIQrra7oAwjSV9ghf8zd5FQZCUqb
         DJXONl073v6UWpOn4GF8gmxjoVIjvIYPL1r8w8TxJkcYcMIEr04LhohcJhXW2d2/FBoA
         6Q2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475990; x=1780080790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        b=N2HSiunP1UgigdVHDUo1uMgkErcVyMNwSXBwMXluKojx4hpKKQ2C3u3tmgkL3vMvfM
         KoePQtmw0Z6XWdRAayGoz0YehS13YM4+lPdDMUV5fkbRCXFWcpIgOp73hx2O8pQjeIW1
         8yzDTC+HhQ/rx6kSosAwYphvVVb5tbLvGimA2iiGoQIK5itIzuCbvFN0d9A6SVQF9hJG
         7vlHmvKiGR2dcLtKTe+7DW+WXupliUQX+RAGcjBx4MKY6oM1Q6Yu8bG/PMe4M8fOlReP
         WpUKQ+QrdScbyujVxwCue/nYtzfK7LyoDTQtiJ9s5F50KT8UNgFhZqViZ9bcqFgMjNkt
         D5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475990; x=1780080790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y6yY3VmUMa0/EtKof3nJtANt3LRN7d5wyy83qIoZX34=;
        b=HwOepQontX4889hXehkJxHdv+KClTgz6OUVk++PqK7GXaD9tOAICIQ5tj8ZJMktcKd
         bzj1wDyB7xws/3RrQnteRkLVURAgCpqGaQx8gJy06vbjJRhIn5qLxQyLeFVodTRn0TOI
         ddrdCnoyhpfQrR0vx3RSWQCXwek0e+OcODz6/eVZMG3v0+fFnyeHHDuWqotPC45Y+eKJ
         RMsZYJyUdWOyB2YHZV6o8qbRzzbmsRkVy4nRdpcwwtCf10M8atc2LsCmsZiNZtfUwdFy
         R1D/XkjWz0DjyiHmF4Def5nV7L+woMakmcsqCRModB/RN7RHX4BdlYvavIpQSYlN6IeZ
         Vs9w==
X-Forwarded-Encrypted: i=1; AFNElJ9DQYidVdSVQ19Ch/kU7sLoEKnFnzzDh1q18ulXnF0ywRR4Cn/DwORsEQb8MLlXf6NhZBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBCWzeeotoz6maGLfklG4jE5CWOxOM4sfka+aWxk35YWy3T89M
	RfHISNW47/aWFXnb1mEYph1hZEVlwALukOq1RvFp8uF9C+RgCDS2bmGUJDfb8m2+aL0Zf+QWey5
	Mi/RFWhKwUAKrvEZ/2zkoU5nvrXH52b4=
X-Gm-Gg: Acq92OGT7ZgAPDEaTkND35T3F7xwCHxR+9v52a+7pn+pc885r/VK1M4tn1OYNiLaivC
	ObBB5CXnCqOjCD4VCsimIg7vuwO4Z5SUcoWtP9DBhFW1W3wSDpNLJw0MgKxTI24NIF+RyU4MHok
	BCx1oSay2h+pDubDUas6aVISkXSlFADT2SdvSIs31gL/DwqAY1D2k8R1W1ka0V+26dm6mu0ZSHp
	Goh3OruvtbJAt36JcrvT9OZrfLReKztBwnwTEF9Uyafggx/uPLGKmQ1ftKSRi3sISojCks67u8y
	V2pohM8Zr6mgpsRk7UvSHzzyBe56ZNIhkA==
X-Received: by 2002:a05:6a00:a96:b0:82f:6cb3:645a with SMTP id
 d2e1a72fcca58-8414b5956bemr7133353b3a.31.1779475990150; Fri, 22 May 2026
 11:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124411.31133-1-jolsa@kernel.org> <20260521124411.31133-6-jolsa@kernel.org>
In-Reply-To: <20260521124411.31133-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 May 2026 11:52:56 -0700
X-Gm-Features: AVHnY4J0I1T3BExdZJu4Z_1SbsaTPMCUJYXQuJWJAXmxIXaY5DnKc11XjERAYdY
Message-ID: <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of nop10
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:45=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> fixing has_nop_combo to reflect that.
>
> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions=
 combo for usdt probe")
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52..484a4354e82b 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_obje=
ct *obj)
>
>         /*
>          * Detect kernel support for uprobe() syscall, it's presence mean=
s we can
> -        * take advantage of faster nop5 uprobe handling.
> +        * take advantage of faster nop10 uprobe handling.
>          * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to sp=
eed up uprobe")

Would be nice to add commit that switches nop5 to nop10 (but until it
lands hash is not stable, so, hmmm, maybe we'll land this patch
separately? send it a bit later to bpf-next?)


but otherwise lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>          */
>         man->has_uprobe_syscall =3D kernel_supports(obj, FEAT_UPROBE_SYSC=
ALL);
> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, =
const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -       unsigned char nop_combo[6] =3D {
> -               0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +       unsigned char nop_combo[11] =3D {
> +               0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
>         };
> -       unsigned char buf[6];
> +       unsigned char buf[11];
>
> -       if (pread(fd, buf, 6, off) !=3D 6)
> +       if (pread(fd, buf, 11, off) !=3D 11)
>                 return false;
> -       return memcmp(buf, nop_combo, 6) =3D=3D 0;
> +       return memcmp(buf, nop_combo, 11) =3D=3D 0;
>  }
>  #else
>  static bool has_nop_combo(int fd, long off)
> @@ -814,8 +814,8 @@ static int collect_usdt_targets(struct usdt_manager *=
man, struct elf_fd *elf_fd,
>                 memset(target, 0, sizeof(*target));
>
>                 /*
> -                * We have uprobe syscall and usdt with nop,nop5 instruct=
ions combo,
> -                * so we can place the uprobe directly on nop5 (+1) and g=
et this probe
> +                * We have uprobe syscall and usdt with nop,nop10 instruc=
tions combo,
> +                * so we can place the uprobe directly on nop10 (+1) and =
get this probe
>                  * optimized.
>                  */
>                 if (man->has_uprobe_syscall && has_nop_combo(elf_fd->fd, =
usdt_rel_ip)) {
> --
> 2.53.0
>
