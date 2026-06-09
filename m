Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE13FB06B
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024244; cv=none; b=qma8S+EjERYAE+/5vbV57r6SxLAuimHfF6I6sumGu59tRKCoKf6Fpu1tCEMCSJbhkzbM6cCH6gASr7OhcOzGTxrD+RsUPot03fullFK1J0YK6JdGfTffGI/dsoCEVuWYrXgK3gO2JLLvvTtbW+qqiqFLqUHi/YE6lNp0L7YJYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024244; c=relaxed/simple;
	bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Qib3wA294VSbKpyhpWLbSutnlFEzZH/1uIr/ukz2z48qy2O8IeS3zP+hWqSjO7ic+ceG99FysV+7q/n/hMwJeiFquzDZJUO8UIEHrgfFHEDmDmV/8XGEIdZFtWjcDkrdWmBylXZK/iKMlsJ2Dq/xFg70pPN2lb0j7K03pIN6M6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am1oHjsQ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am1oHjsQ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e8d815c3dso1150345eaf.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024243; x=1781629043; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
        b=am1oHjsQrmrVK9phahzHHzAXs11aKqG65g0ce1GmeC/xR2DdQ/15Kp4iO+3LE8VdDy
         b7nNkuiExKFPxdHygHgsv39gtbFSzNeJKmpdI5N2Ew8ngyan47iU+PiI0g7DWKRMpqIV
         pK7ufdOqKY7MHOImA5BXTNpSH+WF1YPUdQ9YP18GOZPttGt/0RYJYy3xiEHKfoymHxmZ
         e3TVCnlQ5qQe84+tITwBLldXQMKd+mkZVKwHaPTOumlZkXdgT3d9IZ7POODFJvMx/vsA
         Yjqr/DKGUsirsjei0R3PZgWAqxxUSx9smPMei/MRw8YrnldCao1fOrytItG96gQGz49x
         L5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024243; x=1781629043;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txaHnFd2kEzMn2NCa6kJKZmvPyQwxRlm1pVcMc/jxPY=;
        b=Sk8BxIPr0zApNGsIUuyD85I7Bw3epDlzfE/h8yufr8tbDT3KIGquSM1XVuHazUd8pO
         s2et42qyvi7N0PUtSpBLvr1bkMANfjRuTwNUF7c5at8uKgCTf1jMRqWczi32Drn5rHXH
         8z1XGlyuZ40cEdg+I2t2YcAqdO6CRQq4ir7Mzer55QZztM2S0Sxu6+aKzlumHfcGAc4n
         sIgjPH6u4kRBx4pdP2qI6wcLcPSCJol1fCcE4xA29hf6fdwxr59+/ijtdThpDNsK3MwC
         RXwX5BD2KKZFKMnSqnWQJTdwKz+vzzQbz+Myevl5zNHnammgBFy4K5qWqcSLgJYLhvZr
         vuFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zdaLb+oG0TlHmVX8IcT8ut5iQbIqK+ujl8DHcBOQtmIuBZs0UBOE9B5la7LtoZXEa7aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlFnZyUo7tNL/+WtyQd1d5epgBsExsBJRFG+tXEWCoP13ZIYaN
	Eq++qwiotu5bLn7TQ4GFM73SuNmspmNsOzDv7c6vyvGU6fKHqc8LvraW
X-Gm-Gg: Acq92OH+cLjySUvRBEO+I70Qa/et39vtHbgkcLnKrHYNeFXXYESwiFV5VGQaEeEyVU4
	U3IQSMsAth8DVG7gPAUwMIyo0E4xGQFysV6ML1QDwzmqrGZ9AwYPbSj2VorEgoaTWb8bmwmkfMM
	gZnxEBiFALyWPj2EnItlRIKMr6D+yRcQRkZVGNW/l3YpFgNPKthSb8IEOoZEx2FdTi6LM9v9r4h
	UoCZJ1QXupZU+W6Z3YUGcYjiEEz8kQOKFUbIK9WeeZxhM4T8SgDIS9RUdeJhtozcJ2XxQDOjpiE
	VbcmquzZH4oIzHhZSmtDYWffyQWraJqWR9SF3MhJ8Yuv0TMr7ANjby0pkdYQka6JIey+XY8PyYq
	STzoHXFnsZ2NNMuPJzT68MmyXKudrJaze1MV+2uEu4EndrR0acqhVlCUf+kc1B8HTBJtytlMeGB
	cibnvfQwY/0eXJZNvO0yngFDtZSBXU2IdPYWkrm+OfPjw92E79Ay8yQWoxWz5zlTu4e5WA9/diF
	iPvRmZLt+7cOh9RPs9iols5gto=
X-Received: by 2002:a05:6820:618:b0:69d:8f47:f682 with SMTP id 006d021491bc7-69eac9f5dc2mr2867484eaf.36.1781024242591;
        Tue, 09 Jun 2026 09:57:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4620c6a3sm12509316eaf.1.2026.06.09.09.57.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 09:57:21 -0700
Message-Id: <DJ4OEH5KOP21.3HLMYH6CGBIMF@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>, "Linux-Arch"
 <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
In-Reply-To: <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>

On Tue Jun 9, 2026 at 6:04 AM PDT, Gabriele Monaco wrote:
> On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
>> Should this be Cc:stable@vger.kernel.org=C2=A0to get backported?
>
> Not sure if the Fixes: is enough to trigger the automation, I rarely
> remember to Cc:stable@vger.kernel.org and they're usually picked.
>
> In case I guess I'd need to re-submit the patch right?

Yes. For whatever reason the patch didn't reach the patchwork.

Please resubmit with [PATCH bpf-next] subject, so that CI can test it prope=
rly.
And collect Acks.
