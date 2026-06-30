Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDE3E0245
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843085; cv=none; b=h2m3HS/z2Y3D/L01hqxr1rbsi6wM592359oK45j9yezm+Zq+H8fks1N/APPNbiX0KBaoJKm2a6D9neQ4Or+8iFFIGIF7XTF4PO/Lbq4l35hZ0nMqmJBFUtRcMhm3vkAMKNEL0AnrVZFkwuWs4N5yDx5dijmEeGgfNksGQuc20xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843085; c=relaxed/simple;
	bh=GmiSEyyNB7x0aLtv4lpKAHOSN/63+9+ZgW63VVm+7/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9Qyxzs9Fa2lNYatJrkjULCY6+iAg8KZ9wUCZvMnWOTQ6ASw0L8en8pmDePtwAws0X49HgX/t8iQveiKlQqWvnodtgQO9R2lXstmFPGTVxotMCXd32CECLGLKzOY/E0IXiuJMjf8km/18ZvSjLeaU6cd5EWyUULo3ji2pVa/1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBHuX4I/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBHuX4I/"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493be1b9682so2245235e9.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843083; x=1783447883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkvmyfnD6mRHr9hwmtmQjGJkaKe6zFgifbRb8CeRxNc=;
        b=CBHuX4I/Y6/XEbcw2lE8Utt+ncjgKRcBEpOkTbNHApttQiimI73cUQ5E8s+FMGTnam
         0QNo+u5CGinuvmEBOGyNHmNvdEKHrfkJsRNhYilTAEtwEMrXzKd7aak+p8xvGlGFzfT2
         aEJ/tqBMtJZrwEOq2nCUgZQz6dWpEIKK0m89cx/5SgYJ1beHV/XWM/vIQU+7+bM+rnD0
         4+cPwU9Ptduh+uvIiMf8LbKj/p2DVY/dP/hX2inG0cw59CYLq8Bhri6Awyg5beHgHh5U
         fJZyJHlLU6s1S1Ogs/fsgghh4AF37+dys1yCNxWjSG8qsZ5UFBP6B10M6jQhXMQ5zJxZ
         glww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843083; x=1783447883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkvmyfnD6mRHr9hwmtmQjGJkaKe6zFgifbRb8CeRxNc=;
        b=NCfY6I7HLDarEHP7fuMAaO/ftgGIDQ9hoTEU26DYF4S/K3Y67RVg0doER938sHzcEC
         1hS8FI/VXnYSQ+Se3jlFBTWB51OfkTQjjSQ9W8E7r/N298GYsM9o2oVErplGGL25gyJf
         Z9wsQ6eR1yiSGTayHmbv2FrbSIRUZUOFLvEL57aGe6EgJmm/0KQ3hSyY7IB4WdkOFW2l
         G4zZvw5ulT/s1iH4oRMzPF9w1Ikk4yWCTr9h/zWO03a4KrhUsW0FW8UcBcYHmGkUbDuS
         FHkPIGAGOcsGKuHs4iTacna3UgDTTnIgdwCIVY7lBTIDo+mY4e6OA7c0cyvkWbf1Gizy
         T6NA==
X-Gm-Message-State: AOJu0YwMLSLSCp1ZpVpLeZ+6fiOlGVjVnws4K/qpT8mGm/XX0TYRg+q3
	4wKZmEQnxhXBARextNnmcSFJW93zXzAppBUpugQtLS6C58fcARh9GIOp
X-Gm-Gg: AfdE7cmmXn+bitkCCUazPPyiUzfenGFMaD2wd67/2YLoxCuhTJfW+ekmy+RrSV1HPKS
	U765+ffidetbYK3qYxupMYRdihqbQYt+pftFNbp5IbF3ba+0Ad94Gf8QHFa49S7ywzd+s5aoRet
	HgcyxWWJnXhZclnTUNOkyH9b3R1RUoo7ns1hCDtDR7e3Pv2JrenRVs+J5vK3WbtUteq/zZBPX1Q
	prdHHbILcu5qgLxb7aak7rwES0CMMrTYLj7or/kT0zMd559j7k9RV4zAIZ9qXG6j7XRdFbUDZ+6
	g3k4kA4IQi/SkSrg7V7OV8EhkYcDNDdlgwIfMgg7vlLX5CLX6EfFyapwXidntdLGWWW7VB7th0V
	haW5ukiEOApFtuO2TOiO4OfKmwb6yX3TUp9RbXDP5EAtIjHyYWnSjLtKjeMcEOdA6LPfl/hOOLt
	nHnT/1E9BVvTyZvDqAcDyU3dxvl+/8C8NA
X-Received: by 2002:a05:600c:6994:b0:493:bb6b:5bda with SMTP id 5b1f17b1804b1-493bb6b6372mr47286425e9.29.1782843082488;
        Tue, 30 Jun 2026 11:11:22 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef248b7sm2760925e9.2.2026.06.30.11.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:11:21 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:21:22 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 0/2] bpf: Enforce gotox targets against
 subprog bounds
Message-ID: <akQJIsYbSx/8ZpE1@mail.gmail.com>
References: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-f01-03-gotox-bpf-next-v3-0-b744432e1361@mails.tsinghua.edu.cn>

On 26/06/28 09:59PM, Nuoqi Gui wrote:
> For gotox, CFG construction models the indirect-jump target set in
> insn_aux_data->jt, while do_check() later follows targets from the runtime
> PTR_TO_INSN register's own INSN_ARRAY map. If the same gotox can be
> reached with PTR_TO_INSN values from different maps, do_check() can accept
> a target outside the calling subprog.

Can we use some human-readable description here? Please just explain that maps
considered during the config stage must be a super-set of maps checked runtime.

> The observed x86 JIT case can then enter another subprog without a matching
> BPF call frame and crash when the program is run.

Sorry, but why the x86 is still here?

> 
> Fix this by rejecting gotox map targets outside the current gotox subprog.
> Add a regression test covering the two-map cross-subprog case.
> 
> v1 -> v2:
>   - Validate gotox runtime targets against the current subprog bounds instead
>     of scanning the CFG jump table.
>   - Fix the selftest expected error from -EACCES to -EINVAL.
> 
> v2 -> v3:
>   - Drop the Validation section from the cover letter.
>   - Clarify that the crash was observed through the x86 JIT path while the
>     verifier invariant is generic.
>   - Simplify the cover letter and commit message.
>   - Remove the unused skel argument from the raw-insn selftest.
>   - Move the raw-insn selftest to the end of test_bpf_gotox().
> 
> v1:
>   https://lore.kernel.org/bpf/20260609-f01-03-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn/
> 
> v2:
>   https://lore.kernel.org/bpf/20260613-f01-03-gotox-bpf-next-v2-send-v2-0-7c883b43f3c3@mails.tsinghua.edu.cn/
> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
> Nuoqi Gui (2):
>       bpf: Enforce gotox targets against subprog bounds
>       selftests/bpf: Add cross-subprog gotox target coverage
> 
>  kernel/bpf/verifier.c                              | 19 ++++++
>  tools/testing/selftests/bpf/prog_tests/bpf_gotox.c | 73 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+)
> ---
> base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
> change-id: 20260628-f01-03-gotox-bpf-next-1a7af91d2c82
> 
> Best regards,
> --  
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> 
