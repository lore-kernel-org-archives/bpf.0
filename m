Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4D1E5724
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804689; cv=pass; b=feQMMWdUCAvmu1bvkGpDO0sumAcEYBA8vzpiHQHy2hWurVbgF/lBHlEdEtQWd5X8fyJsDd+IbqnsuXH6GN+P0WHcCez1zLHBI9mQiDocX6FwBWdbD6rDeq6DumaFadUCohpNGE5wxIYSnkhn7rkYj+z4/kqN6YASODKd8rFTyOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804689; c=relaxed/simple;
	bh=/aWB6Pmbg60I9yLs8ZxhuklR27vshxBhB2lpuXaH9JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbgUK8WsQetU/PO5EWfwISDiJyyIkodCtJSMiH8rOinQvIeAFbG/1sr0BHDVuFmcARZF+RVhWthi1znD4GKHOh3yZuNiflgKQTIyzzmDszZTKA+lMUQD73xIwSZMYJO9+MDOiCIJRvmSyJCfRn6uVioAgHZeiq2fjUd6SDbGAMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d00+IxGl; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d00+IxGl"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7467865f8f.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 17:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778804686; cv=none;
        d=google.com; s=arc-20240605;
        b=XDwNk406Q69vdYgVsjwslkty7qfAyiE1goM4ViK1D+QAnQAnpiqSHP0gr8NZ6a53Sw
         XluuVPiekf3llV+OqubdObeNC3iKPQg9RPYdMl9kPd/hEc+WIC6ZcOqW53drKCh+HFbR
         mmZHSkHaoZtueHixlqoTR3SK1p8ruGwgfXexfZcNgzCtKqeNZ8k3MLvJe52EXns/aFrx
         ZrlUI/yi1IIoQPqIcAaPXl5IQqjJa1w1ju+aRYsUvb8k61R4QUiQi5mCPY2Q1E/k1ErA
         mKV1wrFcY6fT7E2jzfbTWNOGZmykUifsSt1gtuRT5e8xr1Th+LgGu90HLbahitCrgIqU
         33/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wdhzxb5mk+jV2AIvfxlbStu7QdONSTf7the6LM3yXdw=;
        fh=ux6PjGxwKJ4ULmQPykPI4gO+DDXmrq6XbBela77HwSI=;
        b=SjzyIOy06EOJNfdmvMYqPLatuQgV85DJOp9AznmmbW2pTRw/hK/bWUnU8lh2a0ezb8
         S9dVip1EgDOZvE61QdAweZHRwXKs0HkWjqEaWs8bErBgw4BhNXTHeLRRrKrNr6gR96Yr
         gtro6v5KSOGaANZ7XChMvnX+sfP+QJEvh73dskZLvPabcfs5+ed+VT7bawFxwSjtcXlF
         LLuK2whvO6kmVBwYij7pdwquiD7JAd+ZGgqFbTUWtIY7BA88vj4IGC1lFdZ5ZJabtHZd
         sTTr046Bbpe6fZl9pY3lUjCCR+iCGng6d/+Hw3zrNZpDgzOkF0y1iaY7yR/UyM4bSXDW
         TZNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804686; x=1779409486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdhzxb5mk+jV2AIvfxlbStu7QdONSTf7the6LM3yXdw=;
        b=d00+IxGlb0AT1cF/LX8juqMf5rKgbqxjnJKQstuVCskjHWZGxxu79ixSnbL1iaiHpU
         ovRrzyvFDYgd6EmxMMGNJNgk9Wn50iL4iIYINbA4TglUrBJjY4AFhZGyDce4b4Mw3cus
         zxGlLkZVbnMYYmIa8KhyFGTlI3a7Uq/IoDUVrHhU7fiW8qpnJJO3KTxlRQJfBE/f0Wt5
         WR9LXSMaxXaZt7H/3JPWbs+iWVIcxEgj6+Bei7Q7Jipd/71EK1hGs4ybTDIlWqy/z91n
         hKH35t3ShTOnqmWDMMfsJ61rNFlQrILg2odfr9Jrpw5nJ0+Nvwe+5muuI58Qo25Lt5th
         VsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804686; x=1779409486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wdhzxb5mk+jV2AIvfxlbStu7QdONSTf7the6LM3yXdw=;
        b=q5AcJZK6S88SI2ql0ey8d9yGXUcEtqDeuBuupAAmUAUs2hTf0P/kU54aj0QPng0xON
         mmIZ/jrH/FZKa++M/EJt3cqqoegt8BuPTk2XNi7kGCnicFfCzaRq1oCMSVisPovGOZx7
         1M4OlTul8amZ5FQNJx0r6fYXGKP4F/wHOgiQha8O+Z+6ihte4z2ghCmxDjdexHdwWcKH
         qzEVZDZjcSoeZ0ZXVsKuyxCllMnVkdAH7Fo1Q9cNcj5vfNTmnfA3mPA+QU1mhzyZXmts
         WTyM0Jc9SvgHD46wGoy9mdgApPDrXHlQpQ6VEgDQFz+1kDcR07VoPG3VKNhHUx9jGUST
         cEag==
X-Forwarded-Encrypted: i=1; AFNElJ9hlx4kMnP9bCNE+6k9O3Lx64vdH/+j+zh/sK8sU/8gdReFe2ENKRCEHiiXMruhLWDV7Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSsNgTVuPEaXdA9lMS/vtUx4NI8giTF3nZKOZwBCNuiPxV7u1O
	dliTpo7lLYESvfPSAZ41wUBBgKW/KBNI05FQWXzveZEYQKjXDLbZiyeowbA8QMbsAiwBKVGS1i4
	5ivY9rKAym6VYJucBR89mOPgHHTN/2Ds=
X-Gm-Gg: Acq92OH4YapfgHoZtVZJrD6cNMnWrfsFavvEIgh+j5i/nEobnQDK67wGsA+Oy/r8Va5
	H0clEDds4pzXwqunwphMiN7h6qjeWPR62xw9hkf6BFqPlvrFzZtq+gpEaC5eeIyfsJfDUH/YLZf
	ZsRuBbt+ErcInyj4mG6F7wdxgZsuTf+u+KeU7TD6hG35lfU5o1vcRubSLNrUdCVNGnZlHc6LI9R
	pPQTU7WME125K8BwzT/Y2UE44pbQIxLiT40STnSiFl/ON1II1UzMAoZ0SncVDekaOsJTXKqvCes
	1PhJPhmlwgfMfmSefrcTtZF3Zi8+P9i8f5IiBbuT9mWx3XkBLiE9mIYwu+5Yg9Hdy2ndTnEdnnK
	ZAqCrhYO9aKSlte5Pu2BOwIbOXSUm389PtT7v
X-Received: by 2002:a05:6000:1ac7:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-45e5c35e285mr1590779f8f.9.1778804686211; Thu, 14 May 2026
 17:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev> <20260514184727.1067141-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260514184727.1067141-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 May 2026 17:24:35 -0700
X-Gm-Features: AVHnY4L-A40GDAOSh7XHUSjVW7201FwoBUz8eOGNrRbkW4r-ZsDtJmFsaiGpi_M
Message-ID: <CAADnVQKA+uTzZECqijzRhjfY7MNxr-ehMzjY0ea0S=QWk+KRYA@mail.gmail.com>
Subject: Re: [PATCH bpf v4 3/3] bpf: Cache build IDs in sleepable stackmap path
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 11:48=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Stack traces often contain adjacent IPs from the same VMA or from
> different VMAs backed by the same ELF file. Cache the last successfully
> parsed build ID together with the resolved VMA range and backing file
> so the sleepable build-ID path can avoid repeated VMA locking and file
> parsing in common cases.
>
> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 56 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index c1e96df360c3..8a18c9645933 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -226,13 +226,33 @@ static void stack_map_get_build_id_offset_sleepable=
(struct bpf_stack_build_id *i
>                 .vma =3D NULL,
>                 .mm =3D mm,
>         };
> -       unsigned long vm_pgoff, vm_start;
> +       struct {
> +               struct file *file;
> +               const unsigned char *build_id;
> +               unsigned long vm_start;
> +               unsigned long vm_end;
> +               unsigned long vm_pgoff;
> +       } cache =3D {};
> +       unsigned long vm_pgoff, vm_start, vm_end;

cache logic cannot go into bpf. it's not a fix.
So either drop it or the whole thing into bpf-next.
Which is probably better.
