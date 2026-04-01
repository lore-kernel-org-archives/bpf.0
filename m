Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5434255F52
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041880; cv=none; b=hzk9YWXSKP7YUucIzL7OJyuDMEDbdugGju1f+rVP6o950Od1GQAyQ8Pi5XFIhncxFSQ6RIkbAvZtYTx+DsCkvFVPPTbodP+VBDN+ljkLHDx2nhNdA4QrqStCvpslRkLcRFNG5tVtyeD2VIm9h3OPDeuiYl/hO8E7LtvvIJHChcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041880; c=relaxed/simple;
	bh=ys6QbGqtIf3vUTMLjAVhyTj+Jc49b1uMUgxV4mB+c6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byo3LNM33KpFRob/N9hqXx/qE1tz8u7Nm9r3KNqMCflcjuIxbXRi/SZ1iQ7FV3Pg7UOInz627Qc5pfcP4ARW1f1d/Aw0axWi4m+gpp+A2vW4keifa5EkUEvrdeZ7scxksEAtTZIsj7R++YtjlauV4mMa2ojNmYc8VWPhTGYyAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH2b30eM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH2b30eM"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cf636dac8so92137b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775041878; x=1775646678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKhmyWakaZY0hQAPPcPSbGZZjBppGWnz15eQUM8mSn8=;
        b=OH2b30eM6E/wEpkeax1sRNNRu6TVWhd/Iz0bb4o+7FKdwBkahBbe1YEqyhiOBV8TJU
         PEi+FiElXunKfmwNVwqePe2ZV3ayVg/QHCq2HZbtQCAmUxrl0G7zPAMbe25VhreohMmo
         oTZS/WrXteU0iPPJv2/bFuzRwHCqwx2WI6iaiB0hg5+RY5Hx5piWdfyGmxT3Bw57xL7R
         QPxmx0+kbwq1s3m8kgt1PCJrUxYpYArzU/dCZ0ULfWzyl517GhlvdexxCFUoiSQxxN31
         tVi1qyQXKxnOui7PxYZnlh4txL3vmMffOethOW0RSUb3UvJKAEjS0DgBgKsqgiJMvz53
         ibmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775041878; x=1775646678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKhmyWakaZY0hQAPPcPSbGZZjBppGWnz15eQUM8mSn8=;
        b=JdLI6f++ksRNNP9P17n8cE4h4sUFFUFUv0QbQarqiR4JL+/bpvB4n6vzHkcrxl4AZj
         3bhHfPxXWnh8w6XG6Y1QGQuN7sWObUxCxEjAPjSVB+Qs/6KLVLUnntXcqDsdeCVttzE/
         yx3Yy2x2PSc5fjGk9Llo0H5tWxPdHOMSVz15uZfVvjeDvn569eXwmoKsstv5EEZdA68b
         qx//zUB4dBeRYB8d77/9D4siYDs+VsIB3b62KGlp9WPFLwBLYFagHg4+2hEoV3ygwcnG
         nh8uGHuVQCv2fehnzjtyujzj0UYUtbJrvkyUcSo9UYkp6wsFYbvmRhwfj/GrbWACuaCI
         iP/A==
X-Forwarded-Encrypted: i=1; AJvYcCVzuUFW5aL+dIt6zhbZLYy8J0PI3979bBUVdEDZk5pfhg1JNBbg4iT0DWU+v5yc0HF/3Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0UakkA2uhDlSgt/79bBVn39nUlmTKS9ATqcEUhFJRAfI2tWn
	UjycEEY3EdVQc977KXQjkQ0rGacYPCD7tln6DFVWTc1E5Yu4R7+Z8rLc
X-Gm-Gg: ATEYQzzQGWqrN8il2a1OQ9pLaXEibq2ShMBps2pc/ugSL6tzzBGKFL6NUtqlYsxH8Xo
	CM7B0+4QiM2T7/Kk//XN/68R4hhJnVsSTOW6tZyp4ADIaEJDN4Wv/l7eY6+QNu9u+bB7uypLKd+
	9am4XlRkGU0Efgvs04gfr49RkY7WCTWe5rXyDr1atpLiT61ZyZIoG/2LWPrZwPSdo3sxFP9YIOT
	Q4xfpHk1Kn9vv8REmmBqHGGyNMl4kpwoWzzVDde/dSptSX6U7PzOo0WU/pF6HYc03M+z4wpfs5C
	tXa9ULYFn1Y0ieEpkUxkx4Z3IrVjBH9stBv6kKObojF1sgq1GkSU8/sxoeHrAvK2fsTw1/87MA9
	clGocapfmZhTOqqqQ4XHEcqV+akdv6bunQTD+0z4S5eHdpEZi0tVQLabXbyieDkcODz4cZmXxSK
	pYK9LTu8NptoBavKAgtcruor9MStq/k71g7p4NaQmr
X-Received: by 2002:a05:6a20:3d10:b0:39b:e789:7d06 with SMTP id adf61e73a8af0-39ef774e39amr3404277637.51.1775041878068;
        Wed, 01 Apr 2026 04:11:18 -0700 (PDT)
Received: from computer ([2a09:bac5:40b2:a82::10c:35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b9b2652esm2857587a12.23.2026.04.01.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:11:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:41:06 +0530
From: Varun R Mallya <varunrmallya@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, alan.maguire@oracle.com, yonghong.song@linux.dev,
	song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com, eddyz87@gmail.com,
	martin.lau@linux.dev, menglong8.dong@gmail.com, puranjay@kernel.org,
	bjorn@kernel.org, leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 3/3] libbpf: Auto-upgrade kprobes to
 multi-kprobes when supported
Message-ID: <acz9SosYy2-pAKRS@computer>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
 <20260330110019.549079-4-varunrmallya@gmail.com>
 <acqOcnYHvG4GUgwN@krava>
 <aczsqSHLdM1KtFFH@computer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aczsqSHLdM1KtFFH@computer>

On Wed, Apr 01, 2026 at 04:23:15PM +0530, Varun R Mallya wrote:
> I had to add that check because selftests/bpf/prog_tests/attach_probe.c
> was failing. Sleepable kprobes are not supposed to attach successfully,
> but since this was upgraded to multi, it was doing so. So, I had to stop
> all sleepable kprobes from being upgraded to maintain compatibility.
> 
> I'd like to know if kprobe_multi is even allowed to be sleepable. I
> could not really find any selftests or patches for sleepable kprobe_multi
> functionality anywhere, so I just want to check if this is not actually
> intended behaviour and we are missing a check somewhere.
>

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
        if (!is_kprobe_multi(prog))
                return -EINVAL;

+       /* kprobe_multi is not allowed to be sleepable. */
+       if (prog->sleepable)
+               return -EINVAL;
+
        /* Writing to context is not allowed for kprobes. */
        if (prog->aux->kprobe_write_ctx)
                return -EINVAL;

Adding this removes the need for me to add the sleepable check. Should I
send a patch with this or am I making a mistake here ??
Sleepability for kprobe_multi was never checked (If it's meant to not be
sleepable, that is.)
