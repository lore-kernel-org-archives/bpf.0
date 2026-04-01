Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C0401485
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057575; cv=pass; b=Wvgx09AfuUSmvSdqBeS8TNkmSoxva8BjjjLGeX2Bx3cXZ27FXEimA9rYb66S+hRb1rPbTxuWcp5oJVty86ib2Em/EeEVml8Hv/afJOxBTmzp6OJudQUXXd5+RKtQTyuyHlEYlFPwkfEFWaS450t51DK0eUYvaZla5XscYt+SZ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057575; c=relaxed/simple;
	bh=WpZkwFPK4saKVkaEUfteVuf/s+gOKFi990nBEr23mvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeeoYKwKyegz3tnMhhWev4rZ9M2i9rOkuWbwA1bX++qj1xKyDgP0sODd41E/9FuoVmjaxV76IVJLVYTkHMh4nt8dCy7xPhBNShivS7u/D5/AOdDkizdlRBo85pTM8vw8A03Kz5Gfj0qpFoI410TVN08WT3K64hSaT+jMfxw1NLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dACMqkU1; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dACMqkU1"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486fb14227cso93401165e9.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775057572; cv=none;
        d=google.com; s=arc-20240605;
        b=SuY/FsBW4wVYnkTj7khgYJCuTjNPO8lRUfcTUrVyvqxfrK8K6ThS8k4EfEgU4jp+qc
         c8gna16jOQN9oT9LWaIqp23e2xgQmKY3+PrddLfhtuZu5/j9S3zRJV2DKIFqRqWXbFg3
         VowDGS9D9TucYQsavUwGum/bXKg3qiESeF/bbwp/LZxgJTyVr1tIqqhEpS/FP3Vavnf6
         DQdYHTKiyGFgvGAemZEiRrUoDgUL2E14jHATGg6TunDB/Xl0I9huxZnSgE4SHsIWYk7M
         18pBchgZrCt3yD15ODhpK1hDdfbZ/+QI/2eUpesS93U6ysRPXdRZRgDZOoNq3I7fkjID
         KIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WpZkwFPK4saKVkaEUfteVuf/s+gOKFi990nBEr23mvY=;
        fh=rLmqXxFwTjn3MWgMjMUWqTqF6NDtpW25XbYBZi4KECI=;
        b=EVHIdsTksHQ6lGl4BnLBZ7RklLhzMhP+XBwXCYDjyOu+WTXNpH5ocNlG2cmWmZSB4u
         OullR0AJdtGv+wS+v0UJ+6CTii7Ci4u43ka80vCJkC+LNLrmpPcYga8Pu2nVwt/GTiQG
         sYcaAxc7uDlexAeDMoBKXtDG0ylj+267G+XqesCVR08LAZYeK0G311o8zNcy4cfDFiMO
         pg/oNhcEKXb4VYD7erUx/JASbk1DI1N/sd88nlCgPdF6ixiAoiwJGQWwHnGSBOQB2Ycb
         QCjqUb4k7eL926sMPa/aapTmMyJ7Qo+Pmw2rkv2Ki6Uvm9b3vVMvqZ4wbNVxjHzNBz4h
         UGcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775057572; x=1775662372; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WpZkwFPK4saKVkaEUfteVuf/s+gOKFi990nBEr23mvY=;
        b=dACMqkU1tHFqG98ZcmhYhb6L90l2Qs6DMFf0WgB6FEShNC4kKLjYGCNFByKHe2I80R
         teM+0VCIAHDNXnT7sOlvAbo4Nl5YxzaEE8Uo8wlXRvwxOep2cRhjgNHZDCOSPsf2g8IT
         FiJEX2l+Pdwe/N1IyWsw+uNgUkhx6KMCrSCVSdQLOLo+4dkBpc0Q0j2dS8TCXLFhalWG
         uhnVG7g+NbNfmgsY2a5O+7g7QZBkDXHtmQ8vuwIRlKzNh1qGneqE+y6X+Q9Z8ukMCBEn
         //PO9b2aCCRBl65XQclaOt/+lzxvIKqIXEWpy1znZKbEUFf0tZ29bNWjsMHFfV5mdMEj
         dLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775057572; x=1775662372;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpZkwFPK4saKVkaEUfteVuf/s+gOKFi990nBEr23mvY=;
        b=eazYFbmuTxUIUYNG8HDuVGjHLPcC+w7pkD1f3se8J5FrDK2oRlI8Z/mF7AalRWATlr
         ikIrKHNV7XAvyjek7l6QHW8QwbSCm24DHEH+HumXGv0BH08kRoCiW/1ms0ggxi6v8/jM
         nP8h+ZN3r266rc16eagoFZTmu00opltHbA97z5mwAHmw94toUmnwsx6dbGAm3CD5V3GF
         melwKjeZlTKgdDyvRDJz4ceyPI+YhT8Lav48/d5rVKrihKp0FCZLoFeSJX+NmY9Pn8L9
         X+JEUDN4VNfOpvfH+in0vGXvndVrj+r4n1hROOM4BBVmMwCHrOzPsQRKzVZUSkXtpuuq
         8wSg==
X-Gm-Message-State: AOJu0Yz6shTAGKKAs6SC7mIC8Z5af+y1mzbD8zqdr/mcMjRD+40kModN
	PTJgD7f4T8eHWm09JjMjZUDEhv4HnsNTLP/w8YS1wI0wxfv8K1FanTMxgUhqbO6bRnCmdonh99r
	NeRG7vIARjinPtCk2sgPHE/BDzZV2E/o=
X-Gm-Gg: ATEYQzz5CGIKbdkiujFF3cXi9YSMr18/AevGbGNt1LWu9Bvv9vnMiiKZVPiQPY1tHpo
	T3EsOaz0zDoB4PZn4Rt2GdwoZuvDxZpF+Xd9Iu7dqyR0NDUk1HpqI/4cy3Fyt1zQy0JZAM2CVn0
	ls2dRRUmzMJyKtUFVr5Nnns/v8uIPy99Y4QFjI2OoRLu/TI1xSjrQ62C/7E8526ZM21AtUduShw
	cixyFl2XzfBcJ1mldJMGOfVGHhH5df1cZcrYwDAbocVZUCEuSEgy2ltZTG7yid6tImYWOLHkmbJ
	A5Jkuaht56DNwPJfozj5RVXR0wkDOD+hS8tZtGhNDfhHo6Sw3mff1+VONUU=
X-Received: by 2002:a05:600c:848d:b0:488:8185:e672 with SMTP id
 5b1f17b1804b1-488835cceaamr76731335e9.30.1775057572216; Wed, 01 Apr 2026
 08:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331145353.87606-1-leon.hwang@linux.dev>
In-Reply-To: <20260331145353.87606-1-leon.hwang@linux.dev>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 1 Apr 2026 17:32:15 +0200
X-Gm-Features: AQROBzC6WUTGQAIQiz90MC8if1nS4J3sjsF-SZP_U8DhDtTW8ITNnwzplLstXW0
Message-ID: <CAP01T74Ncg0Q9Fx=vbgLK0zuUitBQOE0jtJqzKGpu3Pn-fTQKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Fix abuse of kprobe_write_ctx via freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 16:54, Leon Hwang <leon.hwang@linux.dev> wrote:
>
> The potential issue of kprobe_write_ctx+freplace was mentioned in
> "bpf: Disallow !kprobe_write_ctx progs tail-calling kprobe_write_ctx progs" [1].
>
> It is true issue, that the test in patch #2 verifies that kprobe_write_ctx=false
> kprobe progs can be abused to modify struct pt_regs via kprobe_write_ctx=true
> freplace progs.
>
> When struct pt_regs is modified, bpf_prog_test_run_opts() gets -EFAULT instead
> of 0.
>
> test_freplace_kprobe_write_ctx:FAIL:bpf_prog_test_run_opts unexpected error: -14 (errno 14)
>
> We will disallow attaching freplace programs on kprobe programs with different
> kprobe_write_ctx values.
>
> Links:
> [1] https://lore.kernel.org/bpf/CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com/
>

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Discussed offline with Leon to follow up on other cases and
incorporate his fixes for tail calls.

> [...]
