Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E437C902
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683211; cv=pass; b=pgsRN/yzH2x5MR9S2jffHqs4ccYOMQSOU4nworqpZjPe43bQBfqszorXA0lAYqdtzlpeNKpTOX3uURHNvZ+8m95nqsruBSDy94TOL2roizeV+Z6aJ5Iht6hrYZ2UcpfRWXAh5wj7CQ+OPRi/TGOYzfqe0OxXP0TzlUKEuu/T0+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683211; c=relaxed/simple;
	bh=3eO6w9Bp5ObcuqLzTmFiLRp+r+T/pTgWq8ud6+7x5xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNClnW5QvkqpRi6qCzAgt0WCLh+vy6Otnzflt+78WftDBPE6DhVJj9iZyKhrft0J0zvixeNGz0cuCRDzYIQcIOUJBGvyq/OAjMxdUfvzn3NXlaqgK7G4LH8jbCauSZchv7VszrEklfxjkRdPZ/yRfVuYVeTgpe9V/qAolpqQuXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuxHEkvS; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuxHEkvS"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c96c92c0980so41183a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683209; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+7Ncm9snvpCOFDQI3ihCt/XB14ntfhyKeUgmcAoj+aCEGKXzmHDWr8K9qlzS7Phq4
         6FnOYgpwPoQRpYqwGaFs6JVP4R0vUkyJCZrmNP0xwOlBZgtOormKYu/5YcCeKcLWOc9p
         IFz2qafxN0e/cSglVfMWFMG5NeFNnVJqNbXb4nzvh8aQzW5Y5PSdiHS+kjaZVrlJG6mt
         vTk32KWCiwjATeemwIIiROLox7AGjB7CesSBL8wHnrLrRQYIiBaeNTU6QOBkg1K+ScN0
         vsplSE/ODfl2sdhW1WWFh5r6DNUAeubPDNcI/txMrXTJ5iUyx4W1/Gr98egLqxqjxaqE
         vd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vQaiqPlt1mbgROpOCjaOHGFPcF+Em/O/8v9mBKdo3T4=;
        fh=QAxeyacYi8rEhb34NDBKSVdNN1iPkocnnMRWucbWTXU=;
        b=T6r4pHEQ5Kg7xqIQNkAayqydBr59+pqQxBl6iw5Q/Xbk+KB5VugFDMDpMsTVE0/EB4
         oDWy15Pa98MXE+/dOZGpICpEC5oCj5pDq4JjOFn1I1MQYNLAnb+r3Nbt+ScoNx7CSyAy
         gAO6j6PZJRRyNm1Mp4yMuN2ag99ZTq/3BvKdpaX0UbcOTiLf0PfzWZjzyEi/8Dcaf4RX
         E4K1qusdagXBPVFd6Uj1P95WFGz7idoril3NYcjE/wDW+lyx7jjTEWforOoD6Qknq8St
         JWBqSYLEp6aLMatoKQBqX2fA23c37gA0ctkgb7ADjgwKXBLTn+CqZhxVGVztY3RtZ0tR
         weoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683209; x=1788288009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQaiqPlt1mbgROpOCjaOHGFPcF+Em/O/8v9mBKdo3T4=;
        b=iuxHEkvSiB6EdcTJMypDgXuK5rvNe15pvJFB8vlBX3DJEJpi0rwmg3vBm/Opm0Udu0
         dFXOiCI2WMQQKxsgUuFTZ+cFAu6ohBijSvgREtvMc9zvmYu4lbpMxuBp/yB5efrR5kXf
         6vCcRDTt7wyhVcPyOrvb4HUyude0KkVPsQIw/0k7UCdeZt1RXXWFdDc3d9jsah+dcSvc
         7/Gm02O1nkParfhA5xECgh4XML2JO4lME+redU9dw2YZh8s8w5NE9ZHoqDw0Ol8YRfcx
         cFhwV1zVtzFBvAh46jie5Gj6PQqpaxMOncIJJp/B/EpollQ/oKCSMGYgfYQHlK9Ck9Na
         5grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683209; x=1788288009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQaiqPlt1mbgROpOCjaOHGFPcF+Em/O/8v9mBKdo3T4=;
        b=V2qPRxvi+UUkTdq8iNYeQLJQmWo/VNObN5ZcWdZN9/Bc2JFSC1p58FJb3iPrEzAaXv
         hzKmn37Atm9tm0QzzDNuWS/iHMAmYksJyTKh5d0FszjJGDXQpgo8gcLwzOHQxaAEhbSF
         bppfjE19LwK4yflUq7qdIeFAH44Vh0Hq+7eCDfFpl8UJF/WeM+2UUvhcBaPSCaVZarvn
         VGp4jYkOWQsqOJZ2rtWTqYpzumCw0cQuZmY3FrHHsYQ+2+WT0GsWvaagl/JpdrI3VuEp
         hFLGxHOZCCL0LI5K+tMHPxvLEkcjcpU3/zOmepgRlL3LlP2CQ5KImJev3RZAVxM2lmak
         Btag==
X-Gm-Message-State: AFuF++lUipddwABvACVrm8ap0q+tMH87IKI1cWZmp2LlxGFjPEq6asIU
	pyrWR/aS6MWmUyEK7TbADDY1o4XsA6e63JKEgQyyxUGn9C/eaLtSxArSsV6jffRhbN2G82FBvwo
	LTw6R0rfMIffyWneb7vfTNNLZ7R8hK/s=
X-Gm-Gg: AR+sD11vWxypk+dsb9qTo7HBEj1E+geUS3GVNqEUA8Yh2fuAccdfq97P4dtryJbGKbE
	gGcLikCnzG9N5YfxKIl1G9/bn+vFi18USfQPNO25YjNMmJxRDbs2wKybLbCxhQNj/sse12I3lS0
	4xDcdKVrZy2bU2GNy3dhKtnLg6RbEnR7mte2gvT733YSGfYNtIGSh6TsrfNU2HblX+NV5jfkurY
	R14xUVBPxga5nSW3IE2Y1rMEkomfx040Ht1igepJrQRkVqzzooy26wrHgfMTEKYT/OXIZg4uWDW
	766QDC3NWMjC4FEBzaiKal6QhQVlWlKdAITFvFx7Vl9FICZgbTtxhET5uygSJsHThkO+80hoYyn
	UeJ0cUK8RVmiiGPhX4km4g7k9/xMY5iiBEMo12ZRpTw==
X-Received: by 2002:a05:6a21:a95:b0:3c1:657:4c95 with SMTP id
 adf61e73a8af0-3cf84459271mr851171637.15.1787683209224; Tue, 25 Aug 2026
 11:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825150444.31603-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260825150444.31603-1-jiayuan.chen@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 11:39:54 -0700
X-Gm-Features: AcwNN1VK5DUH4dTy-rnq5LsKwTmVH-bvp0xFbY5kQSIl5JV7Y6BEETHTTuVfCmE
Message-ID: <CAEf4BzZ_b3=MM2Fh0dEMv0N2TXD31DXdsJaAiDc64HcDoFYvxg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] libbpf: Fix usdt attach failure when nop10
 crosses page boundary
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jolsa@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Ingo Molnar <mingo@kernel.org>, 
	Jiawei Zhao <phoenix500526@163.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:05=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The kernel refuses to attach to a nop10 that crosses a page boundary,
> since it can't be atomically rewritten:
>
>         /* can_optimize(), arch/x86/kernel/uprobes.c */
>         /* We can't do cross page atomic writes yet. */
>         return PAGE_SIZE - (vaddr & ~PAGE_MASK) >=3D OPT_INSN_SIZE;
>
> Whether the nop10 crosses a page is purely up to the binary layout, so
> this does happen in practice. libbpf doesn't check for it and blindly
> shifts the uprobe onto the nop10, and the attach then fails with
> -ENOTSUPP. Just keep the uprobe on the preceding 1-byte nop in that
> case, it works everywhere as a regular int3 uprobe.
>
> Fixes: ee2862439e5c ("libbpf: Change has_nop_combo to work on top of nop1=
0")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> ---
> v1 -> v2: move check into has_nop_combo.
> v1: https://lore.kernel.org/bpf/20260824092847.361683-1-jiayuan.chen@linu=
x.dev/
> ---
>  tools/lib/bpf/usdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 2e56e3ab5b6c..ee9d1b614883 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -608,8 +608,12 @@ static bool has_nop_combo(int fd, long off)
>         unsigned char nop_combo[11] =3D {
>                 0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x0=
0, 0x00,
>         };
> +       long page_sz =3D getpagesize();
>         unsigned char buf[11];
>
> +       /* the kernel can't attach to a nop10 that crosses a page boundar=
y */
> +       if ((off + 1) % page_sz + 10 > page_sz)
> +               return false;

yeah, this works ok, applied this version, disregard request to unify
has_nop_combo() with man->has_uprobe_syscall check

>         if (pread(fd, buf, 11, off) !=3D 11)
>                 return false;
>         return memcmp(buf, nop_combo, 11) =3D=3D 0;
> --
> 2.43.0
>
