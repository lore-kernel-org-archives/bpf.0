Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B4A3DB32A
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217901; cv=pass; b=r2KRLQf48P2mXKLx7ybxW646f1nTGuylKs+uOFhIrvM1VoJBKgAexqBs6PH8QMPWybIxWeEf/ue80NdgugjzfBkRXvlTrk7u9/a0Cz1oaBHTTnXulWWOyHt4l2zUq1VOxmVtwqIMn3CqlLiOLYLzH1K9rFMSY2Fuf5f4U8lpu0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217901; c=relaxed/simple;
	bh=J6pJEcffUiTLi75txyPQCrPmtUWqJbrCyrMIu8ScHZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvNt/4LJb+LviO74aozPxrILhj+ODoOt3fLRen/DQNScuAnNDCPgwz51yw3ZXcvEO4tceCWK96I3zLZwwMPLiYIAmJ9ggzGZnuF/28Qerx54nqqL0hCcOsrnk8BFDOdbFFgmrjbWeHZ2qZYV2sf1nQk6XyKzmydbpHHwsXS3SYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fV18UZIa; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fV18UZIa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so36255465e9.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 12:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779217898; cv=none;
        d=google.com; s=arc-20240605;
        b=MUzY84uV2nWmzOO5O8N5F6mR6r33RDiWoMPm5OheaVfwpAFdQTMWkp9bX/GybL4IVM
         nKKAxKQfzVoU8LAb5Egmnc2xofMOemG7VDc1DUVOct8oMCUXN/qAkZQq3HEVN/UMYzZ9
         2kWNQmK8IuZZ3qJQCvPyss3gajiHqQetnQurjdSKZvwreWkgxbjjRjluVswe+88gDM6E
         +iTgjMgkQeOQXKu+7+p6Tpbj1tP8C7mzLaTgz+s01xN4qNDWdbPBySiYHt7sxIMl8v7Z
         wl6+431D0MgK6Ua0q9WJ/L9VjwOiErZ6IurpFud4r4Hzshx+Ztkt4gN1LCUcBTkB74YL
         U3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8NbDZ0ZjCJQcRE9GB9Z9kts0AHnHcRXfmmnb9LgwCgo=;
        fh=tBXT2UM00D6/7rD5OtPbkvDzXEnh3L5E5h+5Ht9DBZo=;
        b=GOGakMugPJw4GrXxMA48QHAOc10aVQDdgeZ5odRs4rp2anBij15Xz2QAyHHancZMiX
         vQjAPmYI6aa4CHjWmvFexXfv+96NGhoHsd4UwTY07wHOWnbMbFK3o0Em0Wj0W0dTGdCq
         bscPBTcmz/R1+53S5r1pKyFDhh/yEXOSkvABdeOlVRoSIR9Xxe0GXJgqcl9FOhjkHr3o
         YtfyQdp7097OX7VElrIvgYcjVqfn1kgYBP59MrwE5IMvxHGZ2NP+5svAsbKouQA/OIJK
         ZJrJTbgzUfDhQTROmTGhdHoN550zmaVIbb/BmcHkeclG2rfNiNv2oX3s7dADRL4bx/eq
         zq+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217898; x=1779822698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NbDZ0ZjCJQcRE9GB9Z9kts0AHnHcRXfmmnb9LgwCgo=;
        b=fV18UZIaDyKkrX30L079ULTp0QjOkvU5PNDTEpxnEX7oxaygQx6cno3JIzEVqSYawB
         nx5r2QwBpvn82Hr0zCGZDRUKbjLjGz6Zjz6rEr5pKEbpWbVp8aI7U8H41r/Vp9uaSgz9
         RHrtwQtZguAWk8HDwnHtNAebvUY+si7F9O8F7e9+7XzoEgGh1K1vA1Du7uj7vPApAwbv
         Vn1UsFnQvyynYWQxhgy/gdKz7JGiwlVhXwVXnlOV0YAAVZC6Q0nTB0u3MLt/6WuVVeG2
         X3+q2mystrJ/q6ZGccAAbKnPC5lRy0L13lQ2oHCuTgYQXv8R30mpKmFX4GC6svAYQFU7
         Zjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217898; x=1779822698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NbDZ0ZjCJQcRE9GB9Z9kts0AHnHcRXfmmnb9LgwCgo=;
        b=ZiTdEcu5um4Y+lLRu59IGOvqLh7fc4iZUFvyoInWs5OaqqE/NyJKBLGbLT3HQsRnZJ
         3AUbkx9JquBfcl9Y1Tb/KBAj+qXv/4nKDgTWCL4J/azPClSHhFYkVhRN31EmyNXpLYcP
         eJAsGhkz9gxCCaGNvsyQ/GT8gSGiDB2d3YYD+AMrcEY8vT/SsQOpz3joQvhrQOxDOL59
         ZpQxx7iJsv+8GnOiXh9xo+C5juiprNOYRfPzbotlmwKcB6TmjV/EfD1tfbRMXeOm+xzr
         GTlghuwz/KPWUp7DrQhv1I5osC4lHFSggoSliuo+qc7cLALbAHG7iLyTW/7sVT++tcB6
         Hzsg==
X-Gm-Message-State: AOJu0Ywya17+w74PSNLnvoKnFeU/36FGvDm8121jX+eI9bFpRDWomcgy
	lJKJ9bSLL8UAxyGqzMf8UNY6doBnVfCYc+tjD6Wd5VAfd9odgemjMOSKarsUqmKbD0QsSvkLWjZ
	fpVtkRdtNtsd7TzwhsKHo9EWLCR/txD8=
X-Gm-Gg: Acq92OF1aBh9BxTmLDGiQb1l73oNE6QpWUwSAN3IHwtv7MAL8LClKq6M9lows8f9RVt
	FZx4BQ6rKumRZmyTIdM8dJ6H4Fdcl/FF2uNTYF6PtmTyFLKkpIk5agyYf50bnOuuO+ywc/2vVtR
	GeF74lIcFYhkjH6OLbh1avZFIhhNvBCuIui9vZKPwQAg+dHLS8jLRF17ZP9XkzYIalBHimrVJbM
	wsXAFjiB9OLKzQ3YAgUHhuxEY2IGhqmO00ofwf2ZSq0zW4TUthCRj+pXai84rwmtcLDnrjia/4p
	LHSWr0F9KUf0Z8GGErBeVcwMFnEpTQoUBPND5PCPfUhFG2Fw8I1unpUKPEwxiVnXnJvv49A=
X-Received: by 2002:a05:600c:4ed0:b0:490:778:4fec with SMTP id
 5b1f17b1804b1-49007785052mr196795605e9.33.1779217898268; Tue, 19 May 2026
 12:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519163632.2220753-1-puranjay@kernel.org> <20260519163632.2220753-4-puranjay@kernel.org>
In-Reply-To: <20260519163632.2220753-4-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 May 2026 12:10:47 -0700
X-Gm-Features: AVHnY4J-M9z3lby_BqbYpYmzEAUlnEJOHItIKOmVUQspicWBmGI_BdW2q0ceinc
Message-ID: <CAADnVQKhkKPS_7v-4dGWEsjR7rBRB_XG4jHq3JpLYwzKmCn4Bg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Cap batch-timing calibration
 at BPF may_goto loop limit
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Fei Chen <feichen@meta.com>, 
	Taruna Agrawal <taragrawal@meta.com>, Nikhil Dixit Limaye <ndixit@meta.com>, 
	"Nikita V. Shirokov" <tehnerd@tehnerd.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> BENCH_BPF_LOOP uses the may_goto instruction (via can_loop) to bound
> its iteration loop.  The kernel enforces a maximum of BPF_MAX_LOOPS
> (8,388,608) iterations per may_goto instruction.

claude is incorrect.
may_goto is timer based. It aborts at 1/4 of a second.
Old BPF_MAX_LOOPS limit applies for bpf_loop and bpf_for() iters only.
Is this a theoretical issue?
