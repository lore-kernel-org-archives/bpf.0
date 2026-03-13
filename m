Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BC36D9E3
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389102; cv=pass; b=XIGUGd8v2W7kzKlA1BV71d/sXdZroMHz4qyuO4OakoGutxZe9RhMVCkrWa/63uK7emymiyaqYDfcC8G20puCGrYZJ3PIVrD3bOc7qeGVk99wHlfWtIckzOzlKKuC7DLtRe/WNYInXNZCHclTdYRxEzACYILSw1veat6JEPtMTQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389102; c=relaxed/simple;
	bh=ysIOyZ96ugEYcY0rebcKJe1Ba+oaAAOlvjN38akal/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF3/djrESdNwUXn01qqcJ8ADPC8mV3SWyUfcbNjqSMsve9qmr3usE1rIClo+8VKCoCYHs2AenoU+CX/9uu1LjqRliue0mJ/Sny3YLZm91bjg9ZdV00q/m3wRXIE81f5IPtdEtCBu11PBdsvIoOGES62guQVAteKj6iAqblo0hk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcwkup64; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcwkup64"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a3066b68bso17719341fa.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 01:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773389098; cv=none;
        d=google.com; s=arc-20240605;
        b=I5+UG7A2XR0zoJWvOyTROgh4sm/ksuvKaG5b8/Y9urfzjBtnld7Vi5Wv+ZHzBQSNqI
         nAtREIGrkpNZxnOVcwJm9cjbS+0aYFhq6ZC0vcpgcOkpFW3LEtIox2GAD0h54LUWAcL6
         B94TYIavQJnsq8TUTtTQdd6PUz5Nu0zaCAnsEBuHXvVtqv9yon581y2vXbkvLtZ1rK13
         7xAnTNe9Ik7zHTcIbZgmEuQQOmq4zp1oPXLVIenJQeoEgBOQs0sST9SMFut2+epyttox
         3Oa492YygKCsMYi0Ao1p9GpFa6McUDt5nBkGmus7PoFC7+KuUmICCFut6775g8U9X5eZ
         gIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ysIOyZ96ugEYcY0rebcKJe1Ba+oaAAOlvjN38akal/Y=;
        fh=Zi/F5QLGw2T5e3j0MGIhinp4+sfmnN61EHYviP+NTQc=;
        b=MysfrQgh0cZcySv2YqOUbFWAyK7XSouPJ4IQBKxad6/chkvF1x8GbD0U/CQjPz4kE+
         ZThRD7ZM0yiVsyzIb66eHXxMhV/6I7UzmM3h8ZqeX1Ct68w5bI0EVYSkjsgooS4j7gPf
         BI88KrLyvAFoYdaofz/+9E9ZfCPzr4hA/4nNNPmBoR7kl0RQfU+0GDl61QCWO7LQZCEr
         ztnBkkcVut9b8pxcN9mTyezCR2BhCtuah3ZLq9oeIjOm9Vt2fCCq6jODanOl/VEDrpHe
         b1bf1D6Z2lPYezWadU2ZXJd5YbsSj9BF7iGmM/3YawUkFgPm8vHrimb2hHQuqI3b1/C+
         decw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773389098; x=1773993898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ysIOyZ96ugEYcY0rebcKJe1Ba+oaAAOlvjN38akal/Y=;
        b=Zcwkup648Cdywa5zEhGpdNmXKp4Trt2RUZfYo8fN1supdlT3xwWNvHMjCOQ861onw2
         BSe2qmRhRz732JL4lmbSf/arn8XmcP5nDc3+D2BfbCrJaSC7TqORZEbIWW6+QN8zI61t
         pDvReWIIZxpfkfsGNwVPEybQAp8XFUSZuTWU7SnqYMcDyp1mP7oBEJfyGHMw5VWorDHk
         h9YVfgMlvTtAl7egP4MLX1nQAvWcnCpiXGTKRRsCf4xbRlyZ56HWL1tjvTzXopSS0bO5
         2fqqkHHxF1cY+eiz5SXd00/WdWPB60pNhGFQm0va3IwCEpa+rbeNswtwKcon4ytXknnj
         oS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773389098; x=1773993898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysIOyZ96ugEYcY0rebcKJe1Ba+oaAAOlvjN38akal/Y=;
        b=FUG7ClyHI57cZ5ocfW53wf1hh5sw2BM9QYUYwXYiQsQuY/+Nj84KACyZh7j+/rMkyA
         dthqv7Shm6pzksoNw0mRJSDhDY+Ke6vQpH6fXaw/rpmChbuvNyX6CwYw/gHeMwoUcQjo
         uua3Gy/Sa6y66yCmFridWdFRDZC0PEhWqO/O5z1Tv47L7h/Xxfg+QvWVwr6BhMhdGuYD
         JpqQZP8EV7h1PKOucTaUYCi9EgPSxq20gPxDJdv1IUjgO0brGT50MkXxF5M/vqKpzo1S
         TBjHMtb7ZOhVQeHOwDIWvmXS4QcSv2D7oUMkYyz/oSgNQGiZPXkRdRsKbwyEzsy5CMnh
         L5XA==
X-Gm-Message-State: AOJu0YxTbr7/u1eWwX6u50E7+kEEglZu8b7FB0LmGAmnxRJ9Not9FG/J
	6NubCUvuspLvTQygIZm2cmx7/es8Gg1Temvfc+RspmnPPV+L4FSLhswZVHBnkNkoL1D9bYYCMTp
	ydD52fAKNoaHllY0FHunuRQoGL8/UxIo=
X-Gm-Gg: ATEYQzyv1WH+Qg6mdEML1aVfWame9QCmzyV58csGAz29Ez5iG70SsAVPQRE6rTUXlN1
	P37sGZ6j+gEZJUNAgLWfuWBx7NfGcaqDrFq1cFybqadPV8fOVtitr5dVXxXWXQxMX5FoPLWl2JX
	MErFaRRtDRbkryXqMlOqXvOcmhTt/yBHQZsTtaHcYgH2LJSRd6PeN9s9zhADz0FQ0VaHkujDJ/Y
	NELZePXPhpCVPFfcGIU5JNwd7KRWu4/Rcjle3GX6EgKS6IWlyhvE/G/TPyj5Y33pLCnuLZt6bX/
	maro21ff7r3DWGKAjilpAskfQjhBRud2BhQKiySFsTdSRnZJ6Q/S
X-Received: by 2002:a2e:a5c3:0:b0:38a:8321:b70c with SMTP id
 38308e7fff4ca-38a897d3991mr7781641fa.28.1773389097707; Fri, 13 Mar 2026
 01:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312112643.22659-1-danjwade95@gmail.com> <20260312112643.22659-3-danjwade95@gmail.com>
 <CAADnVQL1N9HLNsuJu-hcVPPE-jREOCsau-sicXi4koehnSd0vA@mail.gmail.com>
In-Reply-To: <CAADnVQL1N9HLNsuJu-hcVPPE-jREOCsau-sicXi4koehnSd0vA@mail.gmail.com>
From: Daniel Wade <danjwade95@gmail.com>
Date: Fri, 13 Mar 2026 18:34:46 +1030
X-Gm-Features: AaiRm52k0DAxq8rzCtylDdz7EVnaBrnxAgW29RpDs_pBF2KvlrsOwuwbEfnqjv4
Message-ID: <CAMn7ay-tt_n-iCaCHwLPj1-DKaOmdqW_dvNChy3_OKhir=aFQg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for
 maybe_fork_scalars() OR vs AND handling
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 at 13:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:

> Small nit.
> Please use proper kernel comment style in any new code.
>
> pw-bot: cr

Thanks for the review. I have updated the inline assembly comments to
the proper single-line style and just sent the v3 patch series to the
list.
