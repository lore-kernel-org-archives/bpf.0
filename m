Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46337C925
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238725; cv=none; b=IGXCp+XXE/DDux7Dz9oC318NYENOAQRk61LA5Q7DwqQH4PN5xWwn1RfAI3P4PH/HRYPHli7byKMCv6Yt5lg+f31HgS5Hy3RbH1RnBdJ18k81hUJlCOcmyL8Otruj02X01Cc+U7JIzQPqLLi3sUK3x1pDJnfUAPn30ceZyzLXdzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238725; c=relaxed/simple;
	bh=8a+KoKXYK/XT+p7eiS+WSNre4xuPpzkKUk6DZsU0AL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I1LHqtwygs8GN+0kOhcK+2OF77ZydP9dfVXCJqsPsumwh6pxz/B+MHuPnn1JLIFqHzYrMqKfhkDc0AI0tfYeOHixiHkcHTsspyoN/3BGfw78/4Vr5jLqCpLTFdUujOLIuYAi9HyDwiI6chFgd2z3+AZvynUxwl/L2qIaBdDIiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eBP22FT1; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eBP22FT1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c26d7e951so381721366b.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787238722; x=1787843522; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8a+KoKXYK/XT+p7eiS+WSNre4xuPpzkKUk6DZsU0AL4=;
        b=eBP22FT1LldfC8dfsiLboWVTnPNTFpWPCuZrzpUuJ55MCh1taYTpcoQShS0u7Xu5+k
         KLoKMKlNqi40WNgYBhGnp4gjo+WJeomg+NAbVD9RHVtvDgRX5FIOWlI/bSdaukAgKTyp
         G+cYKJl7e+xhIw/+VftOmDCaWMAWgKspDlUEJAkbA6qZNjtuWdnESFK31R6QfZBR6crZ
         HCk2tZeEkuW/uyLM+G+sAzSQoa2WuCcpKwfvh6EuLvNX9hBsNCacfnD+CND7GzBA5iNo
         yZeoZz6BoKPFY+NlUcqvcsJE/PIOSvMqz8EmemAxNe3qBK2lHiVAQZH1WnGEYK6DNxK0
         y4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238722; x=1787843522;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8a+KoKXYK/XT+p7eiS+WSNre4xuPpzkKUk6DZsU0AL4=;
        b=WlH0l/A6yHKGOWee/KJsROguNd8G4hfcm/r+Zb05hYo4KR7ERVMDk6w+0R6CckQ4Xd
         i+JpbdhxVwPRN1I7CIkdKYWGPNQmw6TKX0JSbiS4w88FdgoaNDFpZuXUp/Dbk2tS25ZP
         2JCov0ocx3MYZL5ldypFs8BiAB0v98LnQbxslAZmtldPeLZpc1oz/e2rfm+H6L25xVNB
         SDKvI1BXIH9ep6nz7vHB/rcnN6B9bs1uVrjIfwzfq63gyG6zBXhPfT/BDSJltCWz2QoV
         s0s9M+sTrRp69E5GL2Pem4mxGYIxYXIFdqD70S1pPA7OpK5xbSjzRNcfC4k3rc/Dvyv+
         VCBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqaxt298An0GG8fjA8HB5h61QgBSmqigLwrwfm1dImg+0HS5jC9wWue0vyt89RbmRsSCTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4ueszLETFdXptwaOHqRqYeDRJNULWWPHlamYr/6nqcznzVOY
	58KJ6JWTovJgLPF3MpTd88dLnY5zCzCH4AQ4g5M+L2SFJBByinY9weOsJ4LnYsxw+N0=
X-Gm-Gg: AR+sD12ssB3nHQBU6BrglllHORtnSwLUPOOc9ZJWOKO5jAUbSfFH1J6J36XNTUm6Tjx
	0QpYmS9l09NI1rP/LEJgY3dLk7vjWoxTVNXEjUOpQ1XYo3DzZHTQ3M+EOInzVuxVo1lAXPF45UD
	pSNFS3KJMa3t+b+ZLJBBl5h+1hkCZBPHnFTv2ZWhmH37IPKAi2RSFdvcFE08Um7L27GVsGkGtb/
	BfHBitqA0Aqw5EoeEQW4no9VvJAYJ79+evN+3186oRdsWmT41y9LyZHRDvp2wbMS+tnT9z9aWcL
	Nq614DVplQRcHvFPlDXWwziSTMHAUpmTLDmV9F7nIHVhAiHpes99TCg38SuyxjUAk36m8QWyIgP
	czXu0iN5eChFOCz+6Puf20w9N7+15Uu5Ci/RBCn2KHFv1nVCFjFbWh0qHZkMrNMY4tgyGb3DDVb
	+OjJcsiipxlDUyuWI/5+xU4RsLJBoqCY/Z8LcCRaGTFQGp77SGLJKRCWd7/6uLIPrbIMf/L0LXU
	g==
X-Received: by 2002:a17:906:9f8e:b0:c1c:64d4:5ba3 with SMTP id a640c23a62f3a-c242e20b758mr1100820366b.20.1787238722009;
        Thu, 20 Aug 2026 08:12:02 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24589e1b0csm90698766b.8.2026.08.20.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:12:01 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kenneth Lee <kennethbwlee@snu.ac.kr>
Cc: andrii@kernel.org,  ast@kernel.org,  bpf@vger.kernel.org,
  daniel@iogearbox.net,  eddyz87@gmail.com,  john.fastabend@gmail.com,
  jolsa@kernel.org,  linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
  memxor@gmail.com,  rhkrqnwk98@gmail.com,  sdf@fomichev.me,
  song@kernel.org,  yonghong.song@linux.dev
Subject: Re: BUG: bpf: task hung in lock_sock_nested during sockmap free
In-Reply-To: <20260820022848.1408056-1-kennethbwlee@snu.ac.kr> (Kenneth Lee's
	message of "Thu, 20 Aug 2026 11:28:48 +0900")
References: <20260812050758.813489-1-kennethbwlee@snu.ac.kr>
	<20260820022848.1408056-1-kennethbwlee@snu.ac.kr>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 20 Aug 2026 17:12:00 +0200
Message-ID: <87ecfsvnb3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 20, 2026 at 11:28 AM +09, Kenneth Lee wrote:
> After further analysis, we found that this report is triggered by an
> SK_MSG BPF program repeatedly calling bpf_msg_apply_bytes(msg, 1).
>
> For a message of about 557 KiB, this results in approximately 557,000
> one-byte verdict and push iterations. The TCP BPF send path keeps the
> socket lock while processing these iterations, so deferred
> sock_map_free() waits for the same socket lock.
>
> This appears to be a long lock-held processing path triggered by a valid
> but very unrealistic msg_apply_bytes(1) workload. We believe this behavior
> is benign, but let us know if other behavior is expected.

Thanks for the follow up.

Perhaps that is a convoluted scenario but what caught my attention is
that if you got the hung task notification after ~120 seconds, and it
took ~500k prog runs to trigger it, then something seems quite slow
because we're talking ~240 usec/prog run.

If you have the repro still at hand, it might be worth to take a look at
the CPU trace [1] or a Flamegraph [2] to see where the CPU time goes.

-jkbs

[1] https://perfetto.dev/docs/getting-started/system-tracing
[2] https://www.brendangregg.com/FlameGraphs/cpuflamegraphs.html
