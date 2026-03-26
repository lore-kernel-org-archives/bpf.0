Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58A3FFAA8
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543177; cv=pass; b=SChF2cAfn3pNNkMWYwR8Dlxo0JrEhsN8tTgzEB+KiUyurjbZg8EuXfp7pNOcLKY9HJjUQSwq3VUlLyrNLWj6p193oIACSBnnJ5jnvtP8CR8z6jszE7y/KEqFHM/2mzJ8gMZcKlWXaN9BUP/H+UUEZxiNSwviAadxRTKG4gmFcto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543177; c=relaxed/simple;
	bh=2OYmYCv52X13FDVcKqDEcrYKsb2ia/h4VKvRXonAN/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HetF7Tz9BOHzXoGuudmoxghPYoYJgDRF0YvQWGbbY98dDlJl4k/SgiZKrPIpDJDpC25u/OdA4aq3vhyCNSxYiPceE53hfFVd4+mvzo8e94Vi27dRdLlY/V7P3SvjIy32uI3UnH5P9VEZwptlhNCx3B3XXRzgw+tb5bTOHCO0C1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL76S1j/; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL76S1j/"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-486507134e4so14322375e9.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774543174; cv=none;
        d=google.com; s=arc-20240605;
        b=eWTuWV27kJ3lD+lr/WZpI4+0XPJQ/jeHM5b3gD5sxIa+QA16jce7C0yxkqlEG0Ja6l
         sP+ZiO/qWGoUnDtWJeqB5Ike4P8IVZ5K0GNP3xmzEhtQW0g5WV9wKLFrw8uNIBisED/r
         RyJPoSBLjxGmuJ/jtRn9jio0VujGdUcnZjQtjPlqNQC/shNSqisVAiGyMNzXITf/egXC
         WP/8DGX7f3MutplJTBNlpWo/j621GYpIvr4FdvhYnUIGzMLl4ymFnIcWwSUZi6o+gXeG
         RqLhy3bXXrHbuIdMeAaDPworFC7VqEXm6slxU8kooTk47Z4ilRpmCebCnET4konrsZxD
         A6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2OYmYCv52X13FDVcKqDEcrYKsb2ia/h4VKvRXonAN/c=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=IVpf78cjXO1aiFjYLaXVxu5VLDfkWSmzXkQH7ME7N9e8YTbf6eL4BuQF02n4DasNPz
         miQn+FmRvjRzIWrty59M/WJP9Bw22kz6oglmOWM+lmiNExFmPR1BZmZ0Z2Nl7AAIjMWe
         r/1RJ6XfDkJfOKVeWYO+v/kqeuthBKXPlobWM33WERUSBsbM7eRlU+qnh4SnLHlJOmJC
         QrR7W3ygYuzosysN6OCLPQ1QWqVLBCz0DomIC2RPqGbanzcLUHEWQJXoa5jHSCG3mW2R
         kznvn4kM28QbkfF1OhmMCBUn6nhnZ1IhaBQM4a0AkSSLS+ORiEmSBVKk3ghMc4eGvJ65
         7tPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774543174; x=1775147974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2OYmYCv52X13FDVcKqDEcrYKsb2ia/h4VKvRXonAN/c=;
        b=cL76S1j//pAU322ZJXcFPC+11q9Ia12uHznhnnSLxk+Sf6559hjZVCfP9/+Op80qtE
         TQaFCmDCpFKLyJ0FJEg9fJEquL5nMHLwhSMNseQwCQXD260Z4iLsGAONwagGeHXMHfro
         GqdsYHLbvm2YPLIbnRZ0I2+MpvYqMnRMuNzOzCLEc0fB0QImgL0oK49HnZ/gpaTCLoCu
         KB+pd7A1y4mm1as/abruBDYiSLBub98xjEGn+7r8cnIwHPuX1Eq64WJlW28xrsuhSy/T
         Tio2cVBAzSRYiW/tunha21/pJJ9R4PhTASvkwvjjWz+ELYrEoFgQ90ds4jUnV4pb25Y3
         7nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774543174; x=1775147974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OYmYCv52X13FDVcKqDEcrYKsb2ia/h4VKvRXonAN/c=;
        b=mKj3+nA87OtgaSiTO5+TFrnl9BMiLyd7DUOda5ok+wOUMVJhZXpHyZNwd3hXMf3RZd
         jh8Nl/VZ/5caY3tt7RnL4h+guqM2KKH1E+FS+igf4E5Uy8QpjFuekD+pMoRKKQThX0/I
         c00TuE1EjPTPleXjwdN74hnNQ3LHMUWEhIXGaIb6gQiFrqFLsZ2iX6VeXpYKK2mQV1Xs
         TbW0JEW3DmtpEnNS64cltxQeQcjzZcHuCBK84JO6Jv+AWC29s9Ww4nywxSTH4vVJLrpw
         3sn76dBt29l6X7uh1n+6RS89zYVG5zm7i0vxMr6LOljleYvzZjuW2HWUvV10we9+FCCi
         F/Tw==
X-Gm-Message-State: AOJu0YyD/7GkIMCNHZMpdbIcVL1hDoBNS9M6PR4qA69uC4vDT+Xl60dr
	wnd+9zMn2l0ZNhf3W7AHVW5UyizXPABMEOYLvmaRSTqe5NGmSqmL79+Czml/opnUJgQAgNNgcn4
	bVuCdQaEvozH7kv8LunwAfjqYlfCG9vA=
X-Gm-Gg: ATEYQzwKWQCo+AOPM8+b0AASGEd3PGbA92BWewD3b/YlItZfKyOZTqDUM9EhWuxHFBY
	SrhEF9LGxvQzu62vdxd4eoNSt/Qm33y+kLD3neFp3oNL+WWKB6JsCDnSlIPzX9B0hiJ2EvFlKDm
	trOWb5Y1MencblB44e2HJyfe3hfNjSiaKSo0uVfHqBInWQjODViroQaHLKDy6IrVB/+HEOSnEky
	l/8IAaZN/5yq2oxybS4Hwg3A1dDEgMqA3RxgYRXsGTRHWzLh/ouri+hwU4oa2hTVNyq0g+sS+bt
	EGsuj2QRm8IUeGgcDhQBjyzF9QoAvP/FbtBBxdT2RFRGNxuZfmrcdOeflpnr
X-Received: by 2002:a05:600c:33a6:b0:487:1fbf:e0c5 with SMTP id
 5b1f17b1804b1-4871fbfe1f7mr27171205e9.19.1774543174157; Thu, 26 Mar 2026
 09:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-sleepable_tracepoints-v6-0-2b182dacea13@meta.com> <20260325-sleepable_tracepoints-v6-1-2b182dacea13@meta.com>
In-Reply-To: <20260325-sleepable_tracepoints-v6-1-2b182dacea13@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:38:57 +0100
X-Gm-Features: AQROBzAbCFj-IYzPdyPbycBxrJ0gT8f5pXCozUr6WBLXVIoiyJkVBtUgILMA9Z0
Message-ID: <CAP01T76dcn9qGLsNXRqBnQvQc5WZj5E0mTsprpwnLr3B7qhMLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 1/6] bpf: Add sleepable support for raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:55, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Rework __bpf_trace_run() to support sleepable BPF programs by using
> explicit RCU flavor selection, following the uprobe_prog_run() pattern.
>
> For sleepable programs, use rcu_read_lock_tasks_trace() for lifetime
> protection with migrate_disable(). For non-sleepable
> programs, use the regular rcu_read_lock_dont_migrate().
>
> Remove the preempt_disable_notrace/preempt_enable_notrace pair from
> the faultable tracepoint BPF probe wrapper in bpf_probe.h, since
> migration protection and RCU locking are now handled per-program
> inside __bpf_trace_run().
>
> This prepares the runtime execution path for both BTF-based raw
> tracepoints (tp_btf) and classic raw tracepoints (raw_tp) to support
> sleepable BPF programs on faultable tracepoints (e.g. syscall
> tracepoints). The verifier changes to allow loading sleepable
> programs are in a subsequent patch.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> [...]
