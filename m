Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240C18D658
	for <bpf@vger.kernel.org>; Sun, 15 Mar 2026 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773545278; cv=pass; b=ksi99T9dsDV7bKNWF4uS+1GRsAyzac61fBXSA6vUJQEhflAYv6FngjLrUlbiZDvHgHCzwHWm3y6t32osaw7AFZTR4tBdzSg9DL0DSad0072tsRIaz4sDBgVCWdkiB1v3Tj6/twgJTN1yarFBlHcB/wFF8z/wvOIe73dsdW5c1iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773545278; c=relaxed/simple;
	bh=vLo0aTBULrldpWshfCrk+12BbGo5LOKzzi1Eoz+QGms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bls4OpYItZq2q3JW9HJKaDwfFS5IQEJSyvsACKFZMe+M/2dYRmQ4YvRUcCuGV4ZOE9yTqCZ2bWGQWatSEsVGDva3cyiVH1lRbJgmlnl6/a2Y/1jfZ9Gw6yyfFYskkTNYZuvsYGud39EDLQAvRyWFvtksAvfN6leho1z5bmMdI7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG7FRnbf; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG7FRnbf"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74c1157a4so3548333a34.1
        for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 20:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773545276; cv=none;
        d=google.com; s=arc-20240605;
        b=LRL+D8fIdonRmifGWawZLDuIRJGKHC+ATrMl+9jbgpzIYwOfN9c0CYt+PXYijO5cpU
         Cfc0Qnlf7BifxgfO+CNux8Qbt2brcZSkXUgmvnHUcIFAkCeZzHO17Olrs68wL2BGlnPN
         ozz2VM32q1AQQo5eDUKe2W0j+cyToirSuazNAtzGvFFvedpamHJ7rO7CpzNMbELMo3wf
         taS60ez2uDOBRk8LIRvqfEE4oFFw4dLQHHZEwFSJ+j3NRkPgNxZcexqRFJ1huO84Q7wd
         lf7swv+lRELWZqYgB1AnKtw9R80CpjTyjABhUiRutX0097AiTT7KS2//HsBWY57Hl6Mo
         I4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnPH3VGFWMUcHKF0SMZcxSg4Tfm6cTcFIpi0Zio6Tig=;
        fh=A+9/YIaGUNUVZBFqV2X+ek9LgFSSgukPaixwMjspo1E=;
        b=ZIXRCJBs0gfX7MHig2147a+GfCr+zbzls9i2MM6G0+o8Q9Ix2LfOjWegpOPs2S4zC7
         PbouSWT/k8gCQG51qf+q+DZdOz65oNvqaKtZH0nXJAFXIZp2c1Oh8t0jTp2qrmKDREkK
         9LS+HL4OfrOnbScxgYt1Z7AQ8N2jJT6wm2NhgQxHroS5W71Ombp8LpFfjcJngl33YtPz
         L0lz2qzt5CDqHkL1Fybs/7BSlxJ6YWHutUMUYAgs+OgMISBRgAtOXWB0dHQQMITPFtqj
         sJh9dfDLbuPi/j1013lu/bDFaUYkzJnQq09dqtYYrq+FRR8o4teO6wifkQ9jBDL6MilS
         5b5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773545276; x=1774150076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnPH3VGFWMUcHKF0SMZcxSg4Tfm6cTcFIpi0Zio6Tig=;
        b=LG7FRnbfDL1kdrJlVa6FtdIW//DsQjgsoYQaHbPquGqjnN57SZzozs5ahX1OUQAIaZ
         48SNxV3x18oN/yQAw7Ub0q2J0xPx3IaLqPpzYfrvFzTWCwya12sHUSeVnocHIrJdKGEg
         jAWjGlFs4aX504bYouoGKk153IR8tHs4LjyLN5QYdrCWgwxQEFDPZz+f5ZMsBv8yIFM3
         eyceBbIO9jOVIy04bV22GDIFN27QN4MLYkarDLeXMMIqzriikaDDgVfNyA2n+6E1nO1r
         9JGcGsXc8aMikUBRcBGwiEBaa8g7l9GXdSUy2KevlcnaYZ6QrEBQMhuenUJxDl5BAm2I
         h+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773545276; x=1774150076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnPH3VGFWMUcHKF0SMZcxSg4Tfm6cTcFIpi0Zio6Tig=;
        b=cF4gLQ1/cbMcIwGxMVFVa6UVRzXZDTL+DiosuxwNz9YVoJgZ46O9JjouO4fRMfLQ2l
         DxjIBIL6cC+ZcLlYoh3Q7GWWEIE7y2iLzevvwJVqRyfCSe24S+BiDYuxv9i9S3gF2piQ
         V5Q8fLdbIV+viyXGQ8JuRYjWw0ASDbu61QbXf+jdkhItHr8Bb9Me2XZ+wUW26JLpw7An
         XQToRV7Pap5Y4nsu8cUWzrOArxgK5ULuB+SHGvtKsLj8ZLXBt9kT4sEa6Q/H+eYA6gcG
         2mNr9P2pOiDIsohOXs44J6HhqmG7bkuFFSuzvVQDa9FJuK4PpPNWoI/iKdEeD77AcFH/
         Kapw==
X-Forwarded-Encrypted: i=1; AJvYcCVd7zgZlUaJw+el2nncoCnif9twHx//0kIXVZr1lJI0HXdjlOQAckLX+AMq4btZXY4VYbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxccK+ag0rq1wyTMFr+NNZQ1t4SpaSXs46IyI6Njqc8drzTfHZ
	4jF0NIrwsD4Bs4sYYsXzGCP7WnPVhwrhMTe/3EMqihY/ZGL9r0/kavXDoSaLB4lHvmZH51IYUle
	v3cXbDLFiC+R+i/M3oXei0PsCaxr0cfE=
X-Gm-Gg: ATEYQzy8L4/PyLR9/HPwwyfvdVJdIBx8ZMlTRGzYPtSWTz9h3p20PX+JACTV5EPHPG2
	GgRspZJ2igP2T4bg+LQ/T4ZLfoHcToj5lbXz03a8cw3DXuLkU5FlHaQCPX4Jr18cXErzFuQwd/L
	gv6dIihAG629qPTLTIDSPCZqoGJtywmXLsJgOBTh8PzBwG6MTR/jxBRHhdRU4pm79dY1RtLSr4w
	IjYyOKm8/jhB6GQUjoR/Oknmhv1VS4yR94RYjIs6rYKafjLVfjPBWXylzSnY5M4lc38YNQ6xU01
	bZX5EV19R+CNFvyCTzg=
X-Received: by 2002:a05:6830:258c:b0:7d1:586a:32a2 with SMTP id
 46e09a7af769-7d78232b1a0mr6066286a34.0.1773545276088; Sat, 14 Mar 2026
 20:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310064706.4985-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260310064706.4985-1-yangtiezhu@loongson.cn>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Sun, 15 Mar 2026 11:27:44 +0800
X-Gm-Features: AaiRm53o26SQ9HtIxoiUSju9Rqix7VoyfBCQjRfv1lRMcCvaqROe5BiuSA5Mj9g
Message-ID: <CAEyhmHQiz510vQMu-WRZ==Q71mW70UEDvyedqe8giXF=0hXSHw@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline()
 return 0
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:47=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Occasionally, there exists "text_copy_cb: operation failed" when executin=
g
> bpf selftests, the reason is copy_to_kernel_nofault() failed and the ecod=
e
> of estat register is 0x4 (PME: Page Modification Exception) due to the pt=
e
> is not writeable, the root cause is that there is another place to set pt=
e
> readonly which is in the generic weak arch_protect_bpf_trampoline().
>
> There are two ways to fix this race condition issue, the direct way is to
> modify the generic weak arch_protect_bpf_trampoline() to add a mutex lock
> for set_memory_rox(), but the other simple and proper way is to just make
> arch_protect_bpf_trampoline() return 0 in the arch-specific code because
> LoongArch already uses BPF prog pack allocator for trampoline.
>
> Here are the trimmed kernel log messages:
>
>   copy_to_kernel_nofault: memory access failed, ecode is 0x4
>   copy_to_kernel_nofault: caller is text_copy_cb+0x50/0xa0
>   text_copy_cb: operation failed
>   ------------[ cut here ]------------
>   bpf_prog_pack bug: missing bpf_arch_text_invalidate?
>   WARNING: kernel/bpf/core.c:1008 at bpf_prog_pack_free+0x200/0x228
>   ...
>   Call Trace:
>   [<9000000000248914>] show_stack+0x64/0x188
>   [<9000000000241308>] dump_stack_lvl+0x6c/0x9c
>   [<90000000002705bc>] __warn+0x9c/0x200
>   [<9000000001c428c0>] __report_bug+0xa8/0x1c0
>   [<9000000001c42b5c>] report_bug+0x64/0x120
>   [<9000000001c7dcd0>] do_bp+0x270/0x3c0
>   [<9000000000246f40>] handle_bp+0x120/0x1c0
>   [<900000000047b030>] bpf_prog_pack_free+0x200/0x228
>   [<900000000047b2ec>] bpf_jit_binary_pack_free+0x24/0x60
>   [<900000000026989c>] bpf_jit_free+0x54/0xb0
>   [<900000000029e10c>] process_one_work+0x184/0x610
>   [<900000000029ef8c>] worker_thread+0x24c/0x388
>   [<90000000002a902c>] kthread+0x13c/0x170
>   [<9000000001c7dfe8>] ret_from_kernel_thread+0x28/0x1c0
>   [<9000000000246624>] ret_from_kernel_thread_asm+0xc/0x88
>
>   ---[ end trace 0000000000000000 ]---
>
> Here is a simple shell script to reproduce:
>
>   #!/bin/bash
>
>   for ((i=3D1; i<=3D1000; i++))
>   do
>     echo "under testing $i ..."
>     dmesg -c > /dev/null
>     ./test_progs -t fentry_attach_stress > /dev/null
>     dmesg -t | grep "text_copy_cb: operation failed"
>     if [ $? -eq 0 ]; then
>       break
>     fi
>   done
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>

>  arch/loongarch/net/bpf_jit.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..4f1af3b7a363 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1568,6 +1568,11 @@ void arch_free_bpf_trampoline(void *image, unsigne=
d int size)
>         bpf_prog_pack_free(image, size);
>  }
>
> +int arch_protect_bpf_trampoline(void *image, unsigned int size)
> +{
> +       return 0;
> +}
> +
>  /*
>   * Sign-extend the register if necessary
>   */
> --
> 2.42.0
>
