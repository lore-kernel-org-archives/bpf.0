Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17434CEE60
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226751; cv=none; b=V0TM682c1aJFWNuMJKBes1IPaA9fc5xnM+H4uLZ8d1TDQ9YgdzaoQYKAIt6AeIZ/EbZt82sY6ZOFwbsoosCFrpF716rXSoxpJ8F2kt0K7oQXOzO4f6NNF87TLXwqbm0Y3CLZmPvwjEypnA0DkYGdZanmYrySl+lciy9E/foi7do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226751; c=relaxed/simple;
	bh=RH+CnPT5AboZDzkPfzmDDAHIiqyv/a+uYoK+W5T39CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2ANMY2++CCZ+DZb4KT5ehtfXCtGnXBYBRElzLK4DHjoUV/aWrBFXx/a2zgWMhtQeIqZPAo31SJzkx5GVwp74/+TW47RvmhcO047HMpXFT6crsVLYDrzGP3ki0RqnACFXxJVaEnlCrWgyb+GdSwxZh0rSS4wCafn5kuTauPZ4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/jCv1cQ; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/jCv1cQ"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a82eab3fb0so508648a91.1
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226749; x=1791831549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSXi87+ATCOArHRRy46mVukElIuhUGDXLY5gl03Kkf4=;
        b=V/jCv1cQN58xQVKttsAISPtfQCYACiNg6oK4DnpQk6Rclz7II6zzF91z6uzBgu0yLD
         SKlW1PU0z2aNgHq1eaUDocCwvwXlLfWK86doxBlqPKjoTMVy46xl4CkUVF6BabXXUd+z
         QnNiG3G+JHRHGHlS0VNCGHHZjwayXiEjcLFh3Oz9WqBQ+3Phx7vUpPPUMaj7RJLx+VO7
         NGe+lYGRP1enmS4WgP96CWZGgD0U2h6bwelvDj7Bl3XK3AmeNe5YATZmN8K9gCOeTizi
         d/0yKrcDq6kSHyYIO7bY3IbZNnnHJ3CpacMFtnpNKsQqMIK2jQkZvij5LlPv4cxXxF0o
         cpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226749; x=1791831549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSXi87+ATCOArHRRy46mVukElIuhUGDXLY5gl03Kkf4=;
        b=qX+UCjQYM7xA5pboJvIVNmXEye4cq+RMoVFoYRPQ5Nr3TZYCYp14dm90arK6QWIOfK
         yMEqi+NwmfWE0tj7BB3vsP74ou+VWRoyuaILoQzuLCOgHqoQuYOBn2zzd1O7+otaniTu
         sKvf+o1WWuBAjx1OUk2EGHg2us8va/DpjOU61jYSW5MmvV6wG478xuw0SmDBlQwskqfT
         uAROKAiJd3s+3UvGHHB4ga2IbTqrYYXpr7Cv7zR1sOZm6wGbwybJH/pnVXxPMFnVX9kN
         HWi+vJ9qLfg8ypkM70gVhk4BJcotVSD62G3V1bcwB4yGzwB1OLzXyLdOBLJjz6/brGAR
         iLZw==
X-Forwarded-Encrypted: i=1; AKwUvBwbGisfn8py69zJ0oBkZvyd1ZFqcHtB5HZJZQzxfFR2qrgvjoJitJd5bX1eRBf1Hkk2zLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRXekhBt2MxrktIiNf7F9jFFTEMDUSeo1HgjlhTewt8/AInEC2
	eDPt18S5v6Gsk9NutEtjawdtWFkFNO/BeBv6+aci9fERJ/qXBrPGDUmq
X-Gm-Gg: AYBFou3vnO/r/oTmlGO5fyekAB4va4mWtQTxr1zN5YLyFEIfCmf2Qqbvujw/zmLbjrt
	HLTSYc3uD0K+GC+I4xhw8XvuRvWjlKQlaQ1qwcPCzadQ0aKWg8ajNBmq+AoueH6DgslsZQOfywj
	kn29EaFKlqpxFoPuBHJfYWRz6p42a2qmoibW6SHOcDeu8k/Uklpd0g20/xwag8XL3gPdDbLV6mO
	2DHSljZMolTn5yNGajvYMkwBDYcw68pQQVYFBIbJvx4n9jhSGgVnyo9IvfG90BNy5bfVbjg7WxJ
	9/EA2poI/GdUHwxCBno4P6pxlM+LCMarEPFZXp/eqETDShKMYTbEBV5AGXjFAF9TyfhzZzTRkxV
	HmeGspoHRVLIkjS1FEKkql9mVNBQO7/K55X4dDUQpF48epMI02Zzn8XdtpgZakFRgct/LjK2vzH
	FDSyVyiJ+OvbtHXNAvl9DdX1l3kmI+nwFfLCJDiFdVzlooDv8pProxtg8jG7OXywa78qMYWXo=
X-Received: by 2002:a17:90b:4b01:b0:3a7:d2b5:2e99 with SMTP id 98e67ed59e1d1-3a7d2b52f9emr3999739a91.20.1791226749036;
        Mon, 05 Oct 2026 11:59:09 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cea0f1sm748786a91.15.2026.10.05.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:59:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 02:59:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: song@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kpsingh@kernel.org, matt@bobrowski.net, rostedt@goodmis.org,
	mhiramat@kernel.org, akpm@linux-foundation.org
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, martin.lau@linux.dev,
	yonghong.song@linux.dev, emil@etsalapatis.com,
	mathieu.desnoyers@efficios.com, hch@infradead.org,
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/2] lib/sort: Clean up sort_nonatomic() and
 sort_r_nonatomic()
Message-ID: <asPzdeas0ZP2Oeis@google.com>
References: <20260910165222.1186628-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910165222.1186628-1-visitorckw@gmail.com>

On Thu, Sep 10, 2026 at 04:52:19PM +0000, Kuan-Wei Chiu wrote:
> kernel/trace/bpf_trace.c is the sole remaining user of
> sort_r_nonatomic(). Switch check_dup_ids() to sort_r() to match
> bpf_kprobe_multi_link_attach() in the same file, which has safely
> used sort_r() under the same limit (1U << 20) for 4 years.
> 
> With no users left in the tree, remove the unused sort_nonatomic() and
> sort_r_nonatomic() APIs. This drops the __sort_r() wrapper and
> eliminates the may_schedule branch and cond_resched() from the inner
> sorting loop.

Anything else I need to do for this patchset to land?

Regards,
Kuan-Wei

> ---
> Changes in v2:
> - Drop the already accepted arm-smmu-v3 patch.
> - Convert bpf_trace.c to sort_r() instead.
> 
> Kuan-Wei Chiu (2):
>   bpf: Replace sort_r_nonatomic() with sort_r() in check_dup_ids()
>   Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"
> 
>  include/linux/sort.h     |  11 ----
>  kernel/trace/bpf_trace.c |   2 +-
>  lib/sort.c               | 110 +++++++++++----------------------------
>  3 files changed, 32 insertions(+), 91 deletions(-)
> 
> -- 
> 2.55.0.1003.g10538fe699-goog
> 
