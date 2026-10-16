Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F3175A6C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116319; cv=pass; b=ZRRUj+3KpRLPVG21nQLyUlQ/6r+gH5GwwgUejMSeyA3Jfqm8pPRqwOt4sQLj5y/pgjJxZxMkC57pW/gHj9lEGmWoA+i2i1F1nNnl1rNNFG6ccPpcrvqa+tpE4lvRzBHp48wWpRy+u4dCFW5Rm1K4/t4jFakbziLjB0mKH4Oy3kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116319; c=relaxed/simple;
	bh=V1RHkZWGIsZPUYNuKoM8AB1AdnrpuIi9xIHrxtjsVz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGG/X+Z+GG+W3tArla1y10Aqs5F2J0/2AH0ZADXdwSeXe2cfwQcYhD/l9Q3WuKMFCi2fR8fUWdRJYl/tY6fgQK2rUoiCZawVz++maiVLtFyU+SnXD46gcLmQdPeYCH4pKw1Ep0LCDBwSUfteXdFimeQPMCRwbR2DdDuVXDXIE00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ss5v8H6u; arc=pass smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss5v8H6u"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-48c688a7cd9so1672733f8f.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792116317; cv=none;
        d=google.com; s=arc-20260327;
        b=PVeKJzOyWrTN/+T5SthKsWW9qrJsY1IiciGcymKoUWQddBMGkSKFoql1/5Bay2Em9J
         1JVMtxHGbZwoZoPQCcEPvd9ehsZ/niw4E5E6iMTQU3c9texr6qIyyTAajxE8qyP6AQiX
         JeUGrLzXNQTqYubW0dVg4EMXdqdISh2H50YXHXT4mbWXkJeeg+o8OwPI0vdQKa0RZJgc
         LvdVrXUTRpuO+X68QO/ewPequCA+oMDfEj/AojXsGcisuGKf7cERjivVJZ+fIb3/dA/W
         /5ct3AyiMqagFnegTL46ThefUfsUJtwkuarMqKJwuoEgFMPTgsEriIBcoIy9PmValoE0
         Jjhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lD019ja7KlBNN+ZZOPdqrM9A3SGTnHnx7QfDozK2kS0=;
        fh=XRb9Qb+KyVvM3PB+53gjUzCWf1FO/OLJrYfCzoUflUM=;
        b=BnRB4mRTy5CLwjXd3hh1reptm5MJwbkUoO+3zjnnwQC2RGQ0jrQb5xlAklnTvllYB0
         +XUOXGwpFKXO5nl2B2sso5su0FEjUraMw2Xw4epTl5yXDOkR9jMpQxs0SpBy5hCKxyAa
         hrWI7Duwe6wX+nNT7gfnaS0SvrW5aIR42oLXaD7CNOt7Gpv7HH+hzOVzh9jfM3XNfZ3y
         ArchzTRGGZCNYT3p1wjJB6g5GZJ7kruGjHmY6FpM3p7l09bhk2mx97LE5V/3KGU2A4VV
         /uqWPuud6wUE9wgHer/sMX4CtWLwrYSGV95yiiFdftAPopZC96YNf3/qYo+sa0xeItD3
         jngQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116317; x=1792721117; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lD019ja7KlBNN+ZZOPdqrM9A3SGTnHnx7QfDozK2kS0=;
        b=ss5v8H6ukTB+Jj/aKwaK+QnqefE5HlZb23XqofdKxd5kBJVIdKfZn9DPlaC55FUt7D
         fJFNq10ggfGVNRxcatxdqi+TYXVRhlgHZ0l/gJt6sAidHmT9JQFkcrWe1Pylf3DkTyEA
         UPfSMIilqQbbb/j0ipLUZmoiETbNWQi/FYK51uK7jqOJjav8KjoeUfQ3OBOJ9uW7LlMZ
         tK8P0kcmeylM5GAWhBqYHiaaThQ4NMpJCdNTWnAhLzclRMjBozz1ajcomJLYFvT3W98C
         yY2Na3y2KOiJj2adU75vyrsvb0fkcrZWzAogT+cczgpI6eyLpkKT+imKPqGgm/Nk96eE
         jGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116317; x=1792721117;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lD019ja7KlBNN+ZZOPdqrM9A3SGTnHnx7QfDozK2kS0=;
        b=kYlvHoA2BywJrCeNLNIS9IllK1YLFeeoUi5oh+b1OuLp7YQ6MTH+n9050vzAxm8hOt
         ww2svdr5Ti3CHoM4vg9fmfZoIbahTUwVVUhakJd65RTZuRgzpL7K7jnuEWz4bQ4Pw/XK
         hVwKjiPdTkiRpXBvnjdI7PVXe3gHd/lPf0Dhu77owmpQSow90k7h3HOnRx2O/4J38JNO
         dWvhBgP/y48DzgoMOpaPjxFQUT3I9fnlnoY+E6uIbbWccwgx5hUUsTZ72XcsqIrEAvyd
         EfFpHw7FcNuUvJknqlPxFPodgPox+NX/Ozxwh4yoGxJ6gT/ung70xBV8ReXxzBLEWKjN
         0xQQ==
X-Gm-Message-State: AFq9FYK0HpCcYrOUf+2lMe/g01DonOcwuxkQ7IvRvM6zNrtqWjatELO4
	gHDg73AQF36nfTUfRCMeFqFuG/geiUXmk4gqM013HxrTqZGOwyle0ZaUsLBOW7cV5AYgnqkiT/p
	UklLYVBGtJioicRWLBBkdkozlAKXlZss=
X-Gm-Gg: AYBFou0aK+C+fYS4vOfRmS7262hZCvNnavhJdYjJZc2A3YBMI6SmPNu524/Xzs9E5mh
	9NrTjVagxTtK3T0ZO/+i6pFAQo97MVPIdMtPVr1CDIjsK8uwUjIjeO6dP6vk29/F15sx8xcej9e
	MqZj06OZ8hZZ17qBC8BVCNjE6ahQoMwMWB0WLDAx36UuA8s4l49DEbOli3y+L5eaZ3r3ATmyqZP
	iV8iZaijjeKvXCY6/UKGQA0ZGnaA43hHhDraKJaYNyw6XvL5Xox3GEcFsMyMujQWB1mAItFIq6o
	fyFOfGvniXRNChlXLthNwPfXC3mujvZcz4z6wwcwqufiv8WLYzKTPxuEnYkGOUNQOA+iuI9gLrP
	kUFI+FVcEUSED/ydZKtToTvTZ0VzkQ1hykiOTuv2TpEfAsKUYhD2pJuQUh2pGP90/avCfyQMJ7f
	FIWcYU7xXTxBbVI++MJJcKKLI2CopcEEY2rZZI75/ulw==
X-Received: by 2002:a5d:64e3:0:b0:48d:fd4d:7fbe with SMTP id
 ffacd0b85a97d-48dfd4d818cmr1777578f8f.2.1792116316728; Thu, 15 Oct 2026
 19:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015234125.3152346-1-memxor@gmail.com> <20261015234125.3152346-7-memxor@gmail.com>
 <DM5V1EIGVJEG.1IIPS4R40HPA0@gmail.com> <CAP01T743a5wuvP=5cc8Aqb=PHGhSFWcir0sCSWMvMT_=gk8Kjw@mail.gmail.com>
 <DM5VHTPNK75L.25IC5ASG1QDJ9@gmail.com> <CAP01T77q9Q-kj1gjsm1U2Nd7QaqjjSrNhF232-dt7cehrWw+uw@mail.gmail.com>
 <DM5VYE2LA9E2.28YJ11VXX558P@gmail.com>
In-Reply-To: <DM5VYE2LA9E2.28YJ11VXX558P@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Oct 2026 04:04:38 +0200
X-Gm-Features: AclHuK8O8RQBqFIYxjAnFTPmYtiBXBrSoxOa9z0H_m9_lyPzJDLPSX8l0nG0hzQ
Message-ID: <CAP01T77Rt=2feJ_HgAW2eq5GntJ6-UNwAh-1cWUCsP6zJ1PQMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 06/15] bpf: Recognize __nullable on pointer
 members of kernel structs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tejun Heo <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 03:53, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 03:39 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >> > Well, BTF_TYPE_SAFE_*_OR_NULL also enforces a NULL check, so not clear
> >> > to me how using the annotation over that will break a program (see
> >> > type_is_trusted_or_null() usage). The only difference is that this
> >> > annotation works with type tags applied directly on the struct.
> >>
> >> Got it.
> >> Can we start moving into this direction?
> >> At least for clang compiled kernels we can drop BTF_TYPE_SAFE_*_OR_NULL ?
> >
> > Yeah, makes sense, I will send a set doing the conversion.
>
> There is one more difference to sort out first.
> type_is_trusted_or_null() and type_is_rcu_or_null() are called only
> when the parent is trusted or rcu.
> fentry/fexit args are plain PTR_TO_BTF_ID, so with __nullable on
> socket->sk
>
>   SEC("fentry/smc_release")
>   int BPF_PROG(bpf_smc_release, struct socket *sock)
>   {
>         if (sock->sk->__sk_common.skc_state == BPF_SMC_LISTEN)
>
> in progs/bpf_smc.c will be rejected with
> invalid mem access 'ptr_or_null_'.
> what should we do?
>

The right thing might be to just strip or_null_ when walking pointers
where bpf_may_fault_on_deref() is true (plain PTR_TO_BTF_ID and those
with PTR_UNTRUSTED flag). That should prevent regressions for this
case, and match behavior of the macros. It is also okay since the
fault is handled.

The plain PTR_TO_BTF_ID can also be passed into helpers, and may be
NULL, but that's an older problem. I have plans to revisit it at some
point and close the issue, but it requires figuring out how we can
annotate and prevent breaking correct cases, and provide some low
effort path for incorrect ones. This conversion can be first step in
that process.
