Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65120386C2C
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783351671; cv=pass; b=DTssZ/G/AbNj0gUILGeM2vIIi6lkF08qeCWLhpSAd+Ug3isX9P/sL7Jo5JpZUTylXjQsseJr2Hlc9KAkkIpl0spcw2lJtDrIfIGpI0oEi3TxCXV1+/fc5dp26wk+KExJAvgPnPar2KD8O2+DW1qJVwFZcMyQnLBoMd0sxTs+bvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783351671; c=relaxed/simple;
	bh=QTAc35LBPTpEtZFTnRHjoDshvh+YhheuGWUZ5W3IT+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8gEIqesKA3Hr8igxyDNhD9sI9XN+yAhA+Ue1QMJSi1qc2MaLkovIMr/sNlBaCB/rjCQ1l4UKGn5ZF43WyjnXGsDEuuV5HdsRNBxvJn0tP7AsjO6DunJUeNv8tFNZ4fvnk2jM7ZymE9wPZhGUEVv7EXmI6ehUrH65yd3f890zXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dEPm2uRA; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dEPm2uRA"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c01c79467so1554141cf.0
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 08:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783351668; cv=none;
        d=google.com; s=arc-20260327;
        b=kDrQjd/btVGLw/MOua4Eo9JArVUaobKWzEQihYDMt88N3hGnRP1NdPrtRDerFd4XOP
         h9NUlxOZqLsbzqSTVL05NWOVKlnKV01rasCWMPTeYMBZSjO7mK81TYmWLLZOP2MCEC70
         0IHNgu1oqHfqN6UMi7p9zSJVWTMpRJXwQhEInTTesn8Dua+fuk8tYztgI2L6X4Zif1NG
         aB+vS4TRTAeiG7YyGsUeDfAsuOd6PPxgo4TxF3CHS2PChSUmiWZuYjQpQavgXO9dGhdb
         WfUvCUCQdyWNy1wvumVHXx+hPzo7bGwHRIKIE/xRMOmXBz2Yu1VilxlbjBTGhgRw4y+t
         cQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        fh=zdDkvOm5FeXJezco1JA42bvBfuJYC/ame72GfOyuhn0=;
        b=bdfuomQv2H4JoDTyQcl64bjxjFxL7Vog40BxdIneBAmGUI9WDHS7JX4pCxEP1Puixj
         ESNyl2zaCfgqDPFvtBfrahYgenqckpfBkqf4cVFOYTmZ5Ju4fh1q9nzflmCg/LiZuw83
         ubxLoMm4cTAQd3cd2BwdtABNjFGARg2IcFJzNPGH5VqwK1SjxzPPewgGqO6+AcXL6aN+
         tkrhNal/zJ6UnXwtzaxJxXE5lnsqO9htYeCh1jRxUsnByfwvOMCHE10MRK4/SBrP7iL7
         HbdLN2iOd/28J2I9hZUsfDsbZlKQfrpypughwIxfhrtfny+JEP7hPV8FHZxeO3GU/IPh
         zZUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783351668; x=1783956468; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        b=dEPm2uRAr7B814fPOXVD945XC8OGpIzRjomioRNvjI8HChEDOizAGUyK2uvSOhRZsv
         z0C4m+9PApGVEMYNNrBX5JDov8WTEhT+0T9z70yZ7/x2Hi7x58V3UPjxF60OSovGIy8U
         9Tavg//DTSiBcwRRqsLgM5sA334+V1MtluypMfLU8YMDnbtQZo6xJhoFh3aIziCAQ/dZ
         l12Q1g5mlwM3kFsZ7jtqpDbBUeC4QEFwEbDqfEkc+XQuqYbNDxQoyT4aqx3OddT/cfM5
         y1Lmb7VZyDpC1FrPpafuNhOB7ULF6fOI8mOHifxfX16ttmiwAFotj3gMBjUaGKkP12rv
         d7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783351668; x=1783956468;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/0HSoGBQhE1LvG2VZKuQpXEA5YTFklsV8HmlGjIdI5k=;
        b=de4Jpr6HhMmGOIHuHVDImcErBbWldwuWoue7TUNheFM1X45c+cjS2+Yk7yrLvfUJNh
         ySvC9YU6Qize4Pj3VdZmJo/8G2qIRWN/kwWG/JkE7ofDtKkAEujv2oI2ZY6w+gVvQiQ/
         qz6dno5nHF3tH0FLenXGgqaOjxr/JRGiZOh2n+aO9ZbKvzEM56olEfOHL1VCboyFJidY
         caQw+cvRZYO/avXva+UK13p+vQ99aHnLxfe0q2+80e+KflllAoKVVx54sxZawXLTdlIn
         svU29oyKsexjfywC8AOL/KvOv+XtYi+Wvv9FPuKzZFCZ/2MeRsSDcoYEJpmTOFXWOXTL
         A6Gw==
X-Forwarded-Encrypted: i=1; AHgh+RqRGNeFl++Bd6NbfKsZvJMUcTE1VBhYg6jj6pChIsWlvKFSTKtoCwSryB6xAqRG4LsXnvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIT38wQ2PsKxMvubXrP985wvB3+AfoUdgQEzKdDMFUUD0ijmz
	o6Z9X5ZNJPr0tMeYIWpKYI93jH7UVPCnevtlWMiWDLgtfnJCNIc00XSOzxOlusn0fWySRGU++PS
	KMhiyhwEFCKdI4/8iBfMM3aqWGzsGkaW7llVDozAT
X-Gm-Gg: AfdE7cmizpH/I96efaxwhxETS+U+sF3AqW+xZOJNLx6T8LCWtumCQ3MTOdLV1aZymiF
	fHd3oB22wc1B5TdBq+yFaTrjghIA3hw8NhZZs+Be8q5r/wFDWuz4sSOIaEU39uFcx9IdSUSvZYK
	jC3AGSLMRz3NDEHunjtNybq7aA16tUkL4t+soc69uxfxx5szEA0hWtkjZ7tUTGsP64iL147Ygf9
	wSi1gucj/UHSFZya2ODFWYLxtvKvh+vzRE5YRYyygLM7SItbE4nfqNREPqPnCSa/a4VbxYH
X-Received: by 2002:a05:622a:12:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51c4c0b5e2bmr17981081cf.10.1783351667666; Mon, 06 Jul 2026
 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630141152.3757722-1-aaronlewis@google.com> <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
In-Reply-To: <45022e92-7840-45c5-ba30-a276d736505f@redhat.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Mon, 6 Jul 2026 08:27:35 -0700
X-Gm-Features: AVVi8CcigofLNQ1bpauMps2t4CVwYArmvr2bOPAAIS6Cf2m4U9AathUI5NcTHxI
Message-ID: <CAAAPnDF4x0Ci56PGUdZ2-662Xs2mf6iA2AuWsc-iOe0mL57OwA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Introduce an instrumented profiler using BpfTrace
To: Viktor Malik <vmalik@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, seanjc@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 11:57=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> Agreed with Alexei, this doesn't belong to the kernel tree. For the very
> least, the provided bpftrace scripts depend on a specific version of
> bpftrace (e.g. they use macros, which are only available from 0.24). But
> we could certainly consider it for the bpftrace main repo [1] or the
> user-tools repo [2].
>
> Looking at the code, I'm just wondering what value does the Python
> script provide. Wouldn't it be possible to do the same in bpftrace
> directly? If so, then including such a tool into bpftrace could be
> relatively simple.
>
> Thanks!
> Viktor
>
> [1] https://github.com/bpftrace/bpftrace
> [2] https://github.com/bpftrace/user-tools
>

Thanks!  I'll look into those repos for a potential house for this.

I wrote the Python script because I thought the logic was too
complicated for bpftrace to handle.  I thought it only handled simple
scripts with simple logic, i.e. no recursion which this script uses.
If that isn't the case, I can certainly try it.
