Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40413A265
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321345; cv=none; b=k4RThQ0/3MGjvzTnKnqSfaD27UxYgO1CFmKt8RTIBmPM8IAl/rGJ6vbh6bwNDzQVTY/zha456FwPmjTojX1Cq3icawkfZbYt/2F2eCPUrVjfOcbk2wD/xV6NFxfrJPBqgzqzRBGaYoVY9b993cX+bikoqoIl/jfLlY62VdekGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321345; c=relaxed/simple;
	bh=c3J6jAKaTtTmPOui96UQ96ZbPWY18VVIr/70zXRVwO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh9wEEdlIueGQBogR6kY0O8U1lpdPro6X3wxdwdDyFzTQniEmKQq0DxJPSXky3We1gnO4N3i0qydK43p4DNtDmgHaraxZ5w+23lkou61Y5XgCODCURICKLP/o4ZY6YU8eJxfsx9Rj9KcrS9kU1KBrBa04wB20mfUrhFgOdkIvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKea5osP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKea5osP"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d264d0e4so952122e87.0
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 05:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712321342; x=1712926142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3J6jAKaTtTmPOui96UQ96ZbPWY18VVIr/70zXRVwO4=;
        b=CKea5osPKod/R60bOHR0Uq6PnXwJ0qS+cUlOGhptCIdglj86Y8enSVfZk+AWmntsZ6
         4xBhRqkT1HqrKH74oKt6/WKi7ypmGsatqNTs3JkSmrnfaFRTERLY/I4TPipnoobl+jFM
         ctwciMOU6+TJefoaT70X6aViE5bMKly3s+IyN8JCtG7bwrE4B9DK24R1xZ894aDPd6E8
         hLWPTNVNiluPpYH0fdSdVcIaTEmb6qbFVHVoIWCUpKy15YjRiZuhg56r/Q6Wy5eGfC6r
         4Xa9BawbG/WoPypcjW6s5bIige+hQ/GkXWVkiPkrQQk8zPGCIDlZFrGBbfWi66vAO0O6
         xHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321342; x=1712926142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3J6jAKaTtTmPOui96UQ96ZbPWY18VVIr/70zXRVwO4=;
        b=kioMticXWYX8K1UUncyXbIsYJJfmhLVINT7FP2mh0hzeavJe7CzF9dbW+owihCVs+3
         NvYxUlPP0PgZXpyEgiMNSLT0TzIquinqevIvfiGdLMlhyu2DCPQCG8xT2STTe+GLwsUN
         VC8YUcTlFYY+4fJb1YahGei2TXXl1geTMwpGa9uWhdJcyjvmjmu0Pon9miMvQDXadyxQ
         DhqTOqa9BzV0Vy4WTZInIIQdyaEDodbUTigx3osHjhvedzix3iwKZA7RtAldgBNPn5Rp
         BX4+O2Q+qbcJ53v79H91CjYnyZZ1CpdxlP4seAn+qDf4w0pUra+S9riqk1tPARaBlX91
         nOyg==
X-Forwarded-Encrypted: i=1; AJvYcCVhyTFTwuf/zKBGYqNUDQpEqIADeN9y4OJY3E/SN52gtY0qe8sSkSWIEdrlTSJojOnYE5p57m/md3SQAjqNQ0p+Ju2v
X-Gm-Message-State: AOJu0YyFldWcfHuR9tletLyl528/zBzmezxVvApeLvvuMZwll9ky00BQ
	eJvmktWZuO5kogBdKmbxGJlIideJ3qNCN+QlRHbS5FMkVCWsXs7KLq3J09B274gMrOQucblc7cg
	8LWsv9xBtZzMUQIxFD3M5O6Kpxqg=
X-Google-Smtp-Source: AGHT+IEx7NdwInIxolXonx5etOO8Pb61DVbVfcT6KItPX5FKqKIQeandNadimg0+8mMvs6ZliwrATc8roM5lLz8Gx1A=
X-Received: by 2002:a05:6512:20da:b0:516:d281:c678 with SMTP id
 u26-20020a05651220da00b00516d281c678mr567468lfr.17.1712321341947; Fri, 05 Apr
 2024 05:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402021307.1012571-1-andrii@kernel.org> <CAEf4BzbQrZ5XpSTv-0NXLRcb3g4VZRymar66zs2QyCVBmB1Mpw@mail.gmail.com>
 <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
In-Reply-To: <CANk7y0irLCvngsPtwR007DPoTjgT0BQfmkPW4AOY0hTRkWV8Xw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 5 Apr 2024 14:48:50 +0200
Message-ID: <CANk7y0jBsPJWUHQSMfVK3f8uLgMyUwiG1QrZpTsF16+gw2_T7g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Pu Lehui <pulehui@huawei.com>, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

>
> I have already started implementing this on ARM64,
>
> Pu, can you do it for RISC-V? If you don't have cycles then I could do it after
> finishing ARM64.

I ended up doing it for both ARM64 and RISC-V. But I don't see as high
performance improvement as we see in x86.
Maybe, I missed something. Please see:

ARM64: https://lore.kernel.org/bpf/20240405091707.66675-1-puranjay12@gmail.com/
RISC-V: https://lore.kernel.org/bpf/20240405124348.27644-1-puranjay12@gmail.com/

Thanks,
Puranjay
