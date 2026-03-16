Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A014372684;
	Mon, 16 Mar 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773650111; cv=none; b=aOWKJsuhkdt12+fQr07mDEZK1SzEkV8J19LzMBEElQt2xmjLCueWnRJYcivEmyLI/9dGFvCw9pDjZ0ejAoONF/3bZC9JB91fFIE1SGjc+6BiMAIzcJCIoGsS78Sr1MW6iH9QGG90NPJHpJ4oqlWlOeR/SzQWkLvdvl3vGhwFQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773650111; c=relaxed/simple;
	bh=LmTgFlU3wkJDQrXlfZu6PuMFGZenmqruYOJqJ7rtVsg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=N+30ZH+EfdXC0r6FPnvkzqjVkFUNKeTbxYAcYrYogEubt6Z9uM7DHTzdorYx/VxqmMtM0Q2/F2djqPFgu0m7dLZhFh54Lhzcg8nKHDXpu+gaxCr1LtTkpJ++hnLXOavWv1oomCcl0suUdCfcyJ/kZVTGh1ZxiDhxmaOHCzLAQCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8gtTFFE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8gtTFFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A447C19421;
	Mon, 16 Mar 2026 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773650111;
	bh=LmTgFlU3wkJDQrXlfZu6PuMFGZenmqruYOJqJ7rtVsg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=h8gtTFFEUKRj0YCscslNynUhq0YJTJpfLCR4CvXh36Pr8BefK0Cy0Q/J4/X7N52VV
	 80t+6kX6n/q8gRLG8U31VJTrqhPEPGFQRS48Bh+Y4xrTGYuNUA2mdAZCgPi5quNaVd
	 5KsRKUCgJ5oJWDJ6W6tJms4MTnRAeGAK2OemHLp0c3ZdGi25FN20PioTR1TlTlnE1c
	 fhLKFy7cDwwC1wD5gDpRc40TNcNgOkpSBJPAlJOYehcs8QAw0Mir3s2kxiFZ1OIqyW
	 BFQGHHIoh1yOb7x6E15prof1ahVddRn+eoluJ0/41xYdpW/pSVL5Bem+BeMCPd0eVa
	 cFey9CKYhbhkA==
Content-Type: multipart/mixed; boundary="===============8312636464555216910=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a34d2de2bc6db3cad91a50bb298bd687fa6ffa8701a14d6e7a07a29e7c34ffc1@mail.kernel.org>
In-Reply-To: <20260316075138.465430-15-jolsa@kernel.org>
References: <20260316075138.465430-15-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 14/24] libbpf: Add bpf_link_create support for tracing_multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 16 Mar 2026 08:35:10 +0000 (UTC)

--===============8312636464555216910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -454,6 +454,11 @@ struct bpf_link_create_opts {
>  			__u64 expected_revision;
>  		} cgroup;
> +		struct {
> +			__u32 *ids;
> +			__u64 *cookies;
> +			__u32 cnt;
> +		} tracing_multi;
>  	};

Should the ids and cookies pointers be const-qualified here?
Every other multi-attach member in this union uses const for
its pointer fields, for example in kprobe_multi:

    const char **syms;
    const unsigned long *addrs;
    const __u64 *cookies;

and in uprobe_multi:

    const unsigned long *offsets;
    const unsigned long *ref_ctr_offsets;
    const __u64 *cookies;

These arrays are input-only (passed straight through to the
kernel via ptr_to_u64), so marking them const would be
consistent with the existing convention and would avoid
compiler warnings for callers passing const arrays.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558
--===============8312636464555216910==--
