Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289A29CE1
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881911; cv=pass; b=aIqEmUxc5gcYkPlAmsnZS1UXVl+m4vSZs/AG8c/Ie21qwsFgV6EFW9YuqTZrG730qliTaADpxJH5qYkoWkcV1477AicJFXSjydZlmBhrKle+2AutMb5o0LAZXz0uMg75nmLy3FrNIsnkBgmEtNa1Kf+E6kBBxBZ6nuUou/YpP8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881911; c=relaxed/simple;
	bh=vznJGcVFKx7WJm3HEPHdXsSmIXw9DXrVy9VCJ/CwSW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWmQI1Yjsyjr+3PJpfXFy4RdeHEb39Ze1XpG1IvZT4NJwsYG5Zc72iUC5DXs9ZyL3/BKL6kYeRVixBCt1+ehHxwygLZ0Oag0QkE+SsP5QTyjbELDI+R5iy2QI7llDZKZis7zn8iexzcehonHVe3uZQR/dHWNTwfVjN1ZSBf8xUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSGV5A1b; arc=pass smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSGV5A1b"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-43b48ac2727so254747f8f.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 17:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773881908; cv=none;
        d=google.com; s=arc-20240605;
        b=I2vdD4FLOhix0NbVRpRNU9kuYqZu76FrIvJd+J2RenaPTarpkouM5kRBXFxBUNnFCL
         9nnf8QcUQ2OZa9bcPw9FQB7qpkVRpSfFTfdhqIhQrfpkCnOgy09olDRn+fiL36mAzMPK
         kSw4SyUlYnZuacaI3lXX/kHnnlXOMypheuOv/fgPYfJ51/vWPfbCpP1PIW/VCDMzN/PU
         Ujhv7ffYYj2/gu0ue1NpvllMjQs08ykomYr9SQ+bbzns1FymfD9D4ZO/ifatUzoMJdPK
         ETj0ubCqYca/rhTo3xXehgl9YFDkZB9FxrFMZW1b0W8tTP5Qe60hAKRlR1mVWB4949Yr
         R99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nQBRL9i36+WUfYzgIngzcy00B176DtKoVkhoGh/yz0o=;
        fh=nBHPQzXQzNeywpV1+qGu3fmnl32p/ehv/zPIhbWrdUQ=;
        b=S95ep2GJFRh8wqb1ukngUGMy6zBtkNQ+J0dWAD0I1/DTC79H9ZKgAN+nq/KInIHUtu
         SdWqMjQrsDgT7iss0YFs7GTwLpmHOliJs/KhjUXPInRLoi56x1xk40xS+5jSzFUHgckW
         8Co+ETmviDAnMHjYdtrnDEdacGA97cMfZBiyfaVBG7U/rEEK6nnOZNqiT6+v/kT41dTU
         R8cMrK6hDn4hf7dDy1iWO3fO2p2OU+GZX8vrTOOf9a3vM31CkuUKSpzB7QLF8xzxefNo
         steJGPF9AiEzw58ahFxDL+O2+UJY3fQ3L1E+ofNrkBlBMuXicYsObpx1+6xU92eZCYPK
         QYdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773881908; x=1774486708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nQBRL9i36+WUfYzgIngzcy00B176DtKoVkhoGh/yz0o=;
        b=XSGV5A1boQD5PEfdOdxlp2ymkTR7hp9maM4pp1khYpQmZhNll3450Yvk48/P9ZaMqq
         XvD6eUgoPmxi4d2y1qqORYJLGubOEgufDYX0hYoyFOmguRf9BAmO9lgz1kBiSl1qBSaD
         8rvzoUH9SyyTvy0AoFUDJ1/188cUV/PwnEhDWk6YqtNlZYW8wr8ll1Y80EiI0mBaKBdq
         S78WN7DlKv/ETR94PazrayKBFN+1eJ8Zywfxsl+9UOFHeLg+IAw53dtbjAG1SbypXkJu
         jNgGJctDCuMSD6eFz3s4aJH8E2HU+1jxpRXQzpQPnPaJejWo0sB+2tqMZV0j7qacBHHZ
         3XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773881908; x=1774486708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQBRL9i36+WUfYzgIngzcy00B176DtKoVkhoGh/yz0o=;
        b=hkulanpBfUbMIVaGMl6nbixUIcb6z/Lh7rdZL1GVkNkWXf2jV7AGuhe1s8fJSbY1OX
         2NknMxQh1a/dx9rQ3rJOlMdqyfEq0eYtSTL4qlxRSZvU1UlFn7G0A5DigYozx1ugcGfY
         m9upRD9wWmkwCzb0bGD3+JeL9TWYZldY4dKo0Jf1q3E1bfHzy5E5PA6MP8K9C3qAVBIB
         /fm9qVDlmANMFbXRXIxoNFIY+L1/dPBgi9AXrR94Co4kRNcP0VoYTwJVkjv6riyU5vKP
         nrHD9DjZ0rzAjwq3fACgUIsTTKy/fJiEUz7gZBJsjYOn+HuqSW+ALVOLejdF9jqqHvU9
         bXoA==
X-Gm-Message-State: AOJu0YyZNx1ZNnaD4VOrG/RXbNZk6xUZpJQly/oIoq7aDHhLNqIYgwKN
	Ek+NaT1gjbpKOuYIFQLSWyF+d1u088+NQFlL/9+xGBaimRzJsQQYD1V6CrBN0p2Zd7FlMPeyXFf
	CyQc8Y7aQgP8uwkiHkYJmXz2X0Lx4UmI=
X-Gm-Gg: ATEYQzzdf1nAWLHAzy7b1QceZ/76GoNcIHY8H9Mf1tQ6KyTYcVcUH6C9la7pnFWX7Ju
	vmKeJ/CJsZ73bSJKFteT5LtShVh7YCuRf0IodC6Y83hWChTXuP4yIEeOQDJHeWSUt65FnCTyAa6
	mQEDd5IuG3yQtlGd7ltfRZwzaO85FRoX/QKkUAYBj4+2bLA9QlDWa9FZuI7jSv7vmSxxGbSCyHb
	GiGn6xyYE5BTWiM7WoXNIK2MEGlwjXLnZzH1Yf4rgSnbxSumFRFMArbs2jREIK0PnlI4csq/wB4
	ZeeEzninM7N9UTbN51Za1XNk8BGCIjlw3B7Mz+u/+JFVFJyLGhCzw4hh6fg=
X-Received: by 2002:a05:6000:1889:b0:43b:4273:a6d2 with SMTP id
 ffacd0b85a97d-43b527a8e92mr8379238f8f.13.1773881907755; Wed, 18 Mar 2026
 17:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318224219.615105-1-ameryhung@gmail.com>
In-Reply-To: <20260318224219.615105-1-ameryhung@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 01:57:51 +0100
X-Gm-Features: AaiRm51bT5Oe_8bwFNtnmRYURHEh7zzzf3g5YYjjW839ihg4_RUn1rlDJXYZ6HI
Message-ID: <CAP01T77PGBh2782uEgDPEXwdcbYkEVOBdSKYsMUedKKhwes7dQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Add warning to detect memory leak in bpf_selem_unlink_nofail()
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Mar 2026 at 23:42, Amery Hung <ameryhung@gmail.com> wrote:
>
> While very unlikely, local storage theoretically may leak memory of the
> size of "struct bpf_local_storage" when destroy() fails to grab
> local_storage->lock and initializes selem->local_storage before other
> racing map_free() see it. Warn the user to allow debugging the issue
> instead of leaking the memory silently.
>
> Note that test_maps in bpf selftests already stress tested
> bpf_selem_unlink_nofail() by creating 4096 sockets and then immediately
> destroying them in multiple threads. With 64 threads, 64 x 4096 socket
> local storages were created and destroyed during the test and no warning
> in the function were triggered.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/bpf_local_storage.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index 9c96a4477f81..69bb2a7a71bc 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -494,6 +494,14 @@ static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
>                         }
>                         raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
>                 }
> +               /*
> +                * Highly unlikely scenario: memory leak
> +                *
> +                * When destroy() fails to acqurire local_storage->lock and initializes
> +                * selem->local_storage to NULL before any racing map_free() sees the same
> +                * selem, no one will free the local storage.
> +                */
> +               WARN_ON_ONCE(err && !in_map_free);
>                 if (!err || !in_map_free)
>                         RCU_INIT_POINTER(selem->local_storage, NULL);
>         }
> --
> 2.52.0
>
