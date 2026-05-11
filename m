Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC35425CE6
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516225; cv=none; b=S6EJbCOCYIztUQpHMdqZUm5ikRKYhlpf8vMfQ2+zPhUUZgOiyEX956/QA/lcDy6v7dQRMlNZURw71N+IYKSzvsvmKI2DwuDN/HMD3pYu2eBqpWB2pTShxCQpQcFeazuAzGv+klDCi5az9It1L7dGcE1PEucUQQqV6GshMjSzrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516225; c=relaxed/simple;
	bh=bKIT5QYp522o3eA8Shrb5E1ccNYI0Upv9/JZnA0dv2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ny6p0aNKdBPE7+zlTh918YOk7D1i+7EVzMnPwgnH0Oy/XPKPdicWQWowdV/MyV9DqFTibJYet9R+6mRCtxBummpQ2nyFjb07KVB9XYcR5bTpCCpQ2ygmSo7SI7/7ULEmnlY4UtAI2mpf7i2xE6hBm2X5gefDFeWGLbGDdhxp05Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC6wXRn+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC6wXRn+"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479dc6d26e3so2576963b6e.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516223; x=1779121023; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/2KcY2QUgwYTB7Wj9CkoIhwwArdYatRrkS5KECgOCI=;
        b=LC6wXRn+SFZlmJ850mN72XO3gk4SpM3acWhOUCOFZ8sPquNhbcLxV43SkC++M8cXfV
         /+fgPb/4CPcQnrwp9ZApuLCBLXlklh/bUdtMvr5PI7TYKAyy0ll5BQWBpqoal6FxtVRT
         8UqYlOLjcBQEjjxBA4wN1Dbyv6CxmmFYWwbHCP8Nxpl3SFBRluR6zTZt3N+yJoOoofs6
         8tu6hBrEIuyP6J4oPrurTljobZS36WmfhEumdVk5WoQftjaWJVqgsK8DwUnXl6hjKMmL
         3vtSG/nsJjqItN7PxKzC8liWqExSQ4aaiBvT6xqUfbFUXnB5RDGgx4t0LuUVdQa5KusT
         mw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516223; x=1779121023;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/2KcY2QUgwYTB7Wj9CkoIhwwArdYatRrkS5KECgOCI=;
        b=pT3ZmV+gfPgmFii/ZhCnQFb46bzLggj24LujEsMeIfdafZCyzy97E+ZP09CW0Ezlsq
         EswHY8fN3Hf5afOqpROl8+2kKlVyB9WVlqqk0pFMCI0/IieRe+A3J322XQmHIcHnlBHT
         JmdSt+HJSjIXsRnq7nPM9hdCVNxqVrNLaAc484n1uW1paA4DXfhxsJ1JxyOaMqgHfE/C
         NfZKiCrNXPocKkvRBN5kFPU8XozJMRBLKdWDOdOoWMTXmcqyWE+BVNpu8eeR5+LRckSt
         /kfyjusszMUp2VzqH4aO+GGCHfWXrsIFRsK4xqiNp4t403e8arJqx7x7QP3GQvCdk3f0
         JUdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LsMjzb3O3SnFRIaota4foOZq/xxEjsvNleEeAdmvdo+kgII/RsQREKizfGq941mRBDkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyEqZJ7wD5uf0MYEnlfpSp9rcYNzKnQsZmeoxs+MOVtX8eXiyZ
	PS21NoGdLDQdrbgMM4U2yb6Tk/RXio7BXrbRABH0PXUGOZRvWJNxk963
X-Gm-Gg: Acq92OHiR+wJ+2q7xWolHZMgiX+WaImVPxLmLoSfGzvVwXNGyt24rqzGAhdhLoKhRNa
	UpEBB7ouJNMlC1YWsA9BFOJWZYaPmcXb7loKn4hxrwUsBYVPRXWat6U+s9QWl8JHkNxOUaPV3sY
	rJ5MXddPbhF7l1r0wf7qpgTNURCZ3Wd5OvjRiXQKkH4cSbEvTThnTtP3WdWg2rOS5VYpr24c8wW
	9ACEl+hXnJQGqd+JNnVjlb0zBEORdhuakSutdUWuU6M528ATsx+s9ej4iYTfDJevIe+hB74NwvO
	S/Sj94yWuL44PE1e6heNjcqor8DmLlXXcWWliBMHZj6cYU5Uw6OQlssfYjS8eW4hhzuNfVK4TXR
	bVSqucG+oxYGwvX/3JOSWGc3HnQRAkBygyVS4rlW3ngWsKTB9/21vgK4Qia6uRA2yqGJPurmvdH
	cjn2IfWMNbXOdW6SwnXHXSmBF/QfKQrO4EruSgDnS4Zh1pMbJdGjkNvEq0CS4eSUYTmYJRCMmFO
	L8qbDiVOcaM5QKL6Q==
X-Received: by 2002:a05:6808:e658:b0:47a:8c2:a55b with SMTP id 5614622812f47-480424e555dmr10827589b6e.42.1778516222893;
        Mon, 11 May 2026 09:17:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76936220sm20544389b6e.10.2026.05.11.09.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 09:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 09:17:01 -0700
Message-Id: <DIFZDSS2F9P4.9J051GNVD30G@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 06/24] bpf: Refactor jmp history to use
 dedicated spi/frame fields
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
 <20260511053332.1884123-1-yonghong.song@linux.dev>
In-Reply-To: <20260511053332.1884123-1-yonghong.song@linux.dev>

On Sun May 10, 2026 at 10:33 PM PDT, Yonghong Song wrote:
> Move stack slot index (spi) and frame number out of the flags field
> in bpf_jmp_history_entry into dedicated bitfields. This simplifies
> the encoding and makes room for new flags.
>
> Previously, spi and frame were packed into the lower 9 bits of the
> 12-bit flags field (3 bits frame + 6 bits spi), with INSN_F_STACK_ACCESS
> at BIT(9) and INSN_F_DST/SRC_REG_STACK at BIT(10)/BIT(11).
> But this has no room for an INSN_F_* flag for stack arguments.
>
> To resolve this issue, bpf_jmp_history_entry field idx is narrowed to
> 20 bits (sufficient for insn indices up to 1M), and the freed bits hold
> spi (6 bits) and frame (3 bits) as dedicated struct fields. The flags
> enum is simplified accordingly:
>   INSN_F_STACK_ACCESS  -> BIT(0)
>   INSN_F_DST_REG_STACK -> BIT(1)
>   INSN_F_SRC_REG_STACK -> BIT(2)
> which allows more room for additional INSN_F_* flags.
>
> bpf_push_jmp_history() now takes explicit spi and frame parameters
> instead of encoding them into flags. The insn_stack_access_flags(),
> insn_stack_access_spi(), and insn_stack_access_frameno() helpers are
> removed.
>
> No functional change.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf_verifier.h | 34 ++++++++++++++--------------------
>  kernel/bpf/backtrack.c       | 24 +++++++++---------------
>  kernel/bpf/states.c          |  2 +-
>  kernel/bpf/verifier.c        | 23 +++++++++++------------
>  4 files changed, 35 insertions(+), 48 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index f9020a4ea005..adf00585a627 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -435,31 +435,22 @@ struct bpf_func_state {
> =20
>  #define MAX_CALL_FRAMES 8
> =20
> -/* instruction history flags, used in bpf_jmp_history_entry.flags field =
*/
> +/* instruction history flags, used in bpf_jmp_history_entry.flags field.
> + * Frame number and SPI are stored in dedicated fields of bpf_jmp_histor=
y_entry.
> + */
>  enum {
> -	/* instruction references stack slot through PTR_TO_STACK register;
> -	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES =
is 8)
> -	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512=
,
> -	 * 8 bytes per slot, so slot index (spi) is [0, 63])
> -	 */
> -	INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
> -
> -	INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
> -	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
> +	INSN_F_STACK_ACCESS =3D BIT(0),
> =20
> -	INSN_F_STACK_ACCESS =3D BIT(9),
> -
> -	INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
> -	INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
> -	/* total 12 bits are used now. */
> +	INSN_F_DST_REG_STACK =3D BIT(1), /* dst_reg is PTR_TO_STACK */
> +	INSN_F_SRC_REG_STACK =3D BIT(2), /* src_reg is PTR_TO_STACK */
>  };
> =20
> -static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
> -static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
> -
>  struct bpf_jmp_history_entry {
> -	u32 idx;
>  	/* insn idx can't be bigger than 1 million */
> +	u32 idx : 20;
> +	u32 frame : 3;	/* stack access frame number */
> +	u32 spi : 6;	/* stack slot index (0..63) */
> +	u32 : 3;
>  	u32 prev_idx : 20;
>  	/* special INSN_F_xxx flags */
>  	u32 flags : 12;

If so, should 'flags' width be reduced as well?
We don't need to burn 12 bits after this conversion ?
3 bits for flags will do?

