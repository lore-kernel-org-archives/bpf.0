Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34A2F360A
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318612; cv=none; b=lf76uDP+CAnOJP88c9spCGjq/etr1LVbqw4ydY1qc7/nDOhcObQ3bdvr6TP5tnpb3RB8or4bnLQtLoT4YYTZRWkUzdHTflNE4FAUqdRVyT7I0DjKg9V4Lxd3970uMfg0XyGvan/7L2A3TMtJeAwgrApqsqyzWrclbD0oY+c0b0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318612; c=relaxed/simple;
	bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=J/k7X69W1Ie+KPPLF2j+adZOOsh3YM+F5OSLWTbDQRgr4W7I36q+YJVhh8CdWrBz0qVGE0Zq4g76aD0jV9iIfAUjGpaCNbBFVbsEu6IJlgI/DgHm6muamUaJ17H2P8uWnTz5iqz2MQPUgZQvrW4HhNwMu//yLEvzfvaZfPgpv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crhrza/W; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crhrza/W"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e46524711so879905eaf.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782318610; x=1782923410; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
        b=crhrza/WLbngnIdRw1HQJ79XUYHZFtLWbF0EM6sZ/LoOZmBi6ofUu9+JNlpZ/zmgc+
         7xXmTqgsKxkzc96de9zXLHYR+aiFYHVxbjsryE/PjvrUZXHVYsCu/wIPXoqu/PiSKYIt
         SidqLIkqaVLKz9rvu6VPB87BMQ+/TYGjg/kH6M/QJsY+WkJIJDNq61KtC795r4xgbIAr
         1otyGQ14zLVmWV3GtNwvSwsNde8J8c6fULMHYAR1QGFd6z47Rkl38GeUPDMcUWceg4Y9
         abg+mck+Dks+FhHACpBA9b4QDXyXOj3gKLOwGw7xdRvEDKRd9Zm/Oa9cjKTp3o+CLMxe
         N/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318610; x=1782923410;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4Q5tTzUw3dIHq5IKDitX92kWGt0Qu9vdWkJH7Q35Jk=;
        b=OTDIbB1gERF7l62fFiGi6k8O8mzafsj7gdE35zL23I7Fbv8iE+VV8I1qW3u3tGIs5+
         ak7q39PfFJJvnVj0/8cDU6vFyg/+jsWU+5+3OrKBLRqtrIlI+hKoE/BLNPLvVT3Fa9M8
         HhuL55RveD89tX0AmIDfpqQXijpgvbTZ+zRpr27vG0OUVmtatc33Ju39LTm9TrY7wqTQ
         GkfsMzC0MKjE0DLaavcGdBHmWmLMyh5G8nFyLn0Qx8rWmOzyPW98IgGC95UY8MGmcAZV
         b3mDgohuaEU0laufpdqVEiOkU9TsKf7J2eV6rkDzDtIkFFPAganUWLf00MXstaYX4knJ
         tWkA==
X-Forwarded-Encrypted: i=1; AFNElJ87lZMaPjcW7A9cnQAv9lgHcMGDI4d3lRXzKldCqxF3r4mxphW7LEt27ZRzDQrPbWnnPWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJSNs77DUKDR/RM+6mp47zI7ycaGvPuOnHbR4FHcmwC2G2e1D
	p0TWnAUS7OdVQKB7oWeEDSc5tQRU4d7xMeRdKQOi79MNhWmt6UIMzejg
X-Gm-Gg: AfdE7ckBL5Hy2E1yJ5zrPxbVj0UXNTN6+S8iEAPRHhEgTnIUjI95GTFGHfpnv/k0MQi
	cFOlRbXTfQuoaYJDGJ3O9GSDzstLdAI+N1FmEEZg6wYeFgaBZTCnkeIpGXLN1/QyOM5zCV5lykY
	z92BjGRbJgs7ldkIPODATJqTILfWw6NUxF6tn4zco6WIlBiZMvY+r06OnCOjAUSLuJrrCL+kivr
	7Df4iZn1ClviIxxbXFp4Y3qVpqP0ZmsIICVBYyOzP+TFTDfR3bsC9PPMxQ8aQxgLEZgucL0iT0A
	uvZT5EY+LBUIa8TAkPd6xtVhDt4rwzFK8DSKSnKDE8pZ4Khs3z9YcKW+bXqMsL+7urVoK/WUxDU
	cMjuRpYdLcnYZCb/b+msm7zy9/N6Ehzz5q1T44se2bWhAKap2+hUJwmQl5DPB+yNdqZ/8tiRSXf
	E7WkkyaVdPyqaysjpiMo6u6CjNKtzKYZVlfi3FDgQPNMtXeFHkSVaQpJisIwOutLZY2vWh5ajz2
	pZIQnE=
X-Received: by 2002:a05:6820:906:b0:696:1e45:9011 with SMTP id 006d021491bc7-6a1231f9adbmr2366325eaf.28.1782318610157;
        Wed, 24 Jun 2026 09:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9faf29asm9654118eaf.8.2026.06.24.09.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 09:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 09:30:05 -0700
Message-Id: <DJHF7S039QNX.KNVMFISSMLMU@gmail.com>
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Hao
 Li" <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David
 Rientjes" <rientjes@google.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>
Cc: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>

On Wed Jun 24, 2026 at 6:11 AM PDT, Harry Yoo (Oracle) wrote:
>
> Bug 1 was reported by lockdep, and bugs 2 [2] and 3 [3] were
> reported by Sashiko.

... and in fixes for sashiko complains sashiko finds more issues.
I don't think it will ever end. I suggest to fix realistic scenarios
instead of one out of billion cases that sashiko think is plausible
but will never be hit in reality. The chance of server crashing
due to cosmic rays are higher than such bugs. Hence do not fix them.

> To BPF folks: do we need to backport kmalloc_nolock() support
> for architectures without __CMPXCHG_DOUBLE to v6.18?

nope.

> There are still few users in v6.18, but I can't tell whether it is
> necessary to backport it to v6.18 (hopefully not as urgent as other
> bugfixes).

imo none of these 'fixes' are necessary. Humans are not hitting them.

