Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A630FF1E
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770156911; cv=pass; b=Et4bNJhMgEhDZ/+2JdQ3HKRDvY/wFvCp9q75uBUiwFu7UMJQMs2YYHwOwtCv+5BcP5JJbdLtZFDNcV97crv9IFM9vgDhHgEu8uOIYCeboJFox/eh8KiDs6LrJJ2o+OF8PxuXFaPOstmoFzyZ3CaMlkzUJ2X4WXKwgld/j/ZiJvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770156911; c=relaxed/simple;
	bh=QfpxuD/oidyG8LTlk2GPNkUtYNV3l7U8YI7Po70o5N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxmRj7R/uiMT8U87UGSoM6za4G7E+pTIrh+Et8ao0/Tx3KMDAeoq7FsjyJDvmYLcaZQsimuOmMfqeUDlPp/LeMbbwUN1gWG9W/GBDfJp/dkNTgdYme+DC+hwanRjW4OnJddhzZtGaWFHmKENs982tM1vFP82MLF+WXTOYRswM1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFbHC9tW; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFbHC9tW"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4358fb60802so137534f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 14:15:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770156908; cv=none;
        d=google.com; s=arc-20240605;
        b=i99+F6R1z7ov+t+GBnecPsBHpR9bk5G74oKyOULDI+fN3CaXuZLO84X14DPskJ6DUU
         EwfGr6oYihSCB3CaSC1KqqN98D1UDPsvevqM5/sNMHSON1euoHQdRf0ZeZDUovXdighI
         CmxlwkqQ1sqtzGqO3kxRq6DKeExml0gjEuvRdhIizvKmCp5H6h2/I98FNQu8mFr1SrmQ
         BVeKfUJLKC/S/ExlOom+YZFTulQYj3Mu+GpyTXjV/LMwsUWMdtgKoaXUmhhszuxFzEEj
         3ZqHti/fQ8NDO3wBUSdGdvuylA1k4aKlh5NEvfUU9diTpxED77g/eHQ2+z7iiRbYvtnd
         jEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+de4rhbllHzzZ3/6XrjEsuW45shYFXTIZyAZ4Mbunhw=;
        fh=7wASyDI+GuWDanuC28Bitl2CoLMELp8xGkOoy8koFuI=;
        b=YVNwK6IM1Nz6T3kPBE3EgYd/1FAHzGOCgbLbnCU/jZ+krRHis1hcc7mscquSpCGB9V
         HgnLIgmYSZ59ny7HX41NaPu1rbALCsU7Gc3UIS+OyVFNblyy84bR2Vh/33RjvnJvHIHO
         R2XTvXj49tJhkpbGgzj8UUlNbAFjlg/Xe9P3BjwCSV6P54zFLEsuudYHq4YF6f0R9NGp
         Bav3IZwtPsxEvbMpsPw54myCQk2xX22pkQnzYV3Z0qlNtIMPTrI+TPSO0/qdCGIPl3ZR
         4TtpUTUs5U4KHfKqvAnSrdPQ9KURfGPzTrm2Bx3ELxAZR9o0ZYZmVAq7oxIW9Jb0a3B5
         8o7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770156908; x=1770761708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+de4rhbllHzzZ3/6XrjEsuW45shYFXTIZyAZ4Mbunhw=;
        b=fFbHC9tWypiGAbuTg7rZ7Pxk1urWLNVcrmi/r5ak4ypSm/NHoE96JRuycP1oiny96O
         wQJgD5n9Wb1Rk0OYiLOYc4Wx161JgzcUHGLQc3Dq7dnFw7lmWzeMbf/b9jTkY9hXqBAN
         kri/KUVnDbLvR8Hz+5Eh1Wwjxwq9C4icfV//6oPcftLoz0Gb7OvVmxnLDIw7gOV1QeJ/
         XLcmxpNKhhi2s7Yosn5c+6cKg/uSAOx8otJg8C8zwPkAQ0l3R+LuLAxqviuziBpgQN1d
         Wx/cF8AYhUWbuA00HPCXWB9qthp3/J1ZoRVauxhfE4KmmoFqSySaXjvTtoG6TgHVXLGs
         fzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770156908; x=1770761708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+de4rhbllHzzZ3/6XrjEsuW45shYFXTIZyAZ4Mbunhw=;
        b=KqE9lL2JpMVX2SVoPR+/NEilBNFKjV8QdRisj6cCzanEqNB+2OSzZ8qfE8fOes/qX7
         TOy4KsgnB1tzF7emtyaax0uUtcEEjCPodeHe/JqOf1eteHXvygZoHjSfjFd33ooMB4my
         ZZgyxgYnP2dnRWztYzNJZhpc2/rywXOHHuPk5jLIP6+jD6EUicsYPqEIOIV99fgB+IRD
         8V0FIVufu5VKAVv9eb5DRAsikCG1rfv4TIX4CNjUS0UlrA8FQi1Ylsm16BrHexghnBdG
         mYVcOpEZVgwTcy/ujZ58fOLpy83qU9A5y+ssNCVGza/0MkHbyiz+j/ESNUg1/STiWg+r
         XFXA==
X-Gm-Message-State: AOJu0YxJx86I8+lGl+SmoKHkTNm4fpnY2S5+kteGNtrjc0vdLPrVWJ4X
	aHOqBocrHu+yGqUzMo6Url1R6KxZ+afFfAZxxewWb9EtySLxK6gXhvY8ZrVqL45FimfJ5pt894G
	/mj6F6MnvuOOQNr8Oft1WUyNxdcKjmXI=
X-Gm-Gg: AZuq6aLyX0rI6BWu+1YSvl+c1gx0YRNN1BO/Vjt7wC5CNhXOkL1TnJCGF07MoUom/X7
	FEhwOt0520r42hf+xiJICF6ruTHdLZwOBOZWqbPXXiSZOb95ZuO9h248mABkqPkomlxXLAjudI8
	Psc5f8Q/ElXTNnZCTPbu86ZgGuNpyeYtnZS7QrfjUoNnBrUIqPESahSMiapmN6QtVuU+RTonTOd
	GGBVTvbD1XhKjCCEJllgxj2pdsr0bteXZFp82Heh2E+ZgJxELT4W8VaFQoBTpzjM2/QR8TgOnsJ
	aEhftfsyv1tcArVAHNayYuikjaGCrbW7qNK1ICLO6ru7JrSeaLVILJGW7J+/FoWJpBjIuI0=
X-Received: by 2002:a05:6000:18a7:b0:435:db9b:5881 with SMTP id
 ffacd0b85a97d-43617c8d34emr1343157f8f.25.1770156908144; Tue, 03 Feb 2026
 14:15:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201025403.66625-1-alexei.starovoitov@gmail.com> <20260201025403.66625-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20260201025403.66625-2-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Feb 2026 23:14:32 +0100
X-Gm-Features: AZwV_QibfRlPTR19fO87lCtgV6W2byfKLvpOCKsiYiywUItu8LDY1KtlDfcu9Wg
Message-ID: <CAP01T77qdSTU1F1q9Oe8Wu_Q80oXJQo-PRQv4FAaQpRrQwHEbQ@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 1/9] bpf: Enable bpf_timer and bpf_wq in any context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Feb 2026 at 03:54, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Refactor bpf_timer and bpf_wq to allow calling them from any context:
> - add refcnt to bpf_async_cb
> - map_delete_elem or map_free will drop refcnt to zero
>   via bpf_async_cancel_and_free()
> - once refcnt is zero timer/wq_start is not allowed to make sure
>   that callback cannot rearm itself
> - if in_hardirq defer to start/cancel operations to irq_work
>
> Co-developed-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
