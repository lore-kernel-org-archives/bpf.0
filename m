Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661693C3789
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181261; cv=none; b=KkMeYr2rwZU/8XhBNN/V6aT6FcLOuDPjqZbJ+mS8coEmf/xw9caIJRyyiz9Llm4MAwr6wyeOGV8L4DfGMNv0icXnbW19rsIu4guGpQkXPSGOO3L9ab/rAAZUiWm97HOj/6/tMSTcSrUCAi92XYxicgUYK2Ztkjt8j0GbyLhkmfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181261; c=relaxed/simple;
	bh=Nvrl7wcQtldq9wdgVuk3u5CKvayoGjbq66DdtvxQmes=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElZ1fxMmC20T44vMspzYW7R/RYBYt4RJuf3uO+jvvXESwiKsvmQaPzFJjnuzsLBictLxh+iiFtMkp5k9jk2cKMwKEbXspnqNKxdUB4BgVQu4jS5JzFRj461h3DLFL4Kan/P4QNjpzNSuer09KYGz/YKQVbjR6ScuIO1KQOTmUgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT1Wxy25; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT1Wxy25"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393dfso827161a12.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181250; x=1790786050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FamkZUODYIGHbvA1njtcil/9BISIu3ifAMfURVlYBoc=;
        b=XT1Wxy25Z3jgyssiuZuq6uds2Pps9IQbwWBA9JYONeYExb08m/dpOuhZxKQjpE6GOX
         rTs+EauM9K234efYbmMLNVbC+A3hanpn+Vk5XiEWoT9uZ7o2E5IN8NdKESTc1B2j3/8J
         cFdaqizOwtAnla1cBGmjhi72NRACMGitwQp6ehpjt2cWn+G/fl/0zawn51ztHQEvdZQV
         Xzwqs8QyYM9Hgzglplzorl9qsZQUsT4NEuRdU/taWxRWC3X4GarsSuJxueAaJlIt6atN
         3TpI2r6wpsA0QW1TYF2TNdpFKS51/iYfSRkgafdeQiCjY/MNgeWI+umqXFokW6ru8qv6
         k6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181250; x=1790786050;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamkZUODYIGHbvA1njtcil/9BISIu3ifAMfURVlYBoc=;
        b=oKxeaZJNUTzjPqVqQFJqtiwNnxaXcUu3IicElT/nKEAYPAIbOTMV9H0aHCEjqclXZ4
         1GAkF6QI5Q8jd4tws2qlzTGdJ7ZdghBkCoGfMKyGpKER4IHLpPpgxB5KIIbFb2kM0Q8l
         mZEP50dquyq9V7EtSPxbtU42FfRDHkY1k5cGFtR4e0wmx92lyJdfopdmN1n/HUQB6shO
         FsWsRRx9UEgJeVbwvy8CpsfVSgxDKA2OkvOdPF4o7xx6N9y/t2jmq6M1LasXKCYCxWuQ
         NMoH1/2tnRdo6fMnlZGhNpxOJ39IUYgVxpGGrbWwJ9HNbkcHsu/CKHHciGJqIRqsIJiC
         kH/A==
X-Forwarded-Encrypted: i=1; AKwUvBwpTJqR0it89/qagghZsW8Un86wuCqKsddPFrhivSFMoyHvicF/UeRVAqmSViAHjM74n48=@vger.kernel.org
X-Gm-Message-State: AFuF++lfgLkf/8wLWVZTMw3LY6nihzjeGZU7j8jZ5Xk9rUVaXB2xwTus
	/NxKZ91psRzqUGxoiJuQEVHMQS/7NHhuLp1VW/sMCxcga7QmzF4J9m2ovFgIixh8
X-Gm-Gg: AYBFou3apPcDCyTLBRorxxnuOqMc5zQIXnLgwuGcuF4etneV9fr8mFyrKfcKsz0uKr+
	u23lLy71VJGG5VuWkOWmEcmNcN8ezWI0xsx4KC8SGPesb5Fq9Fe7EFWTsFm5ihvbVciLzafUB+y
	S9aDleOSYzHxsBDWKQzVM80ePcIwfrf2jxXZj4qIBW9zauFeOYMrIP8PqWMGtMKrdJ5PPAJI+J6
	7bnlFZ0N238T3gJuZiWAbfYgNJPBxqb0kpfCqNsmSHbJHHWxyaHZ4/TpNvhjbgGOPfqvRYU5wew
	h4GWcftJuGndkFIx4gU1hxj7a4YBv95vXlbLjO5DiZ/ylY3swGN4qfWZfE4rvoaepKwNt2bqoC9
	Cy25YOMwnvc+7ffuomxDbqI1bUgZjxKv0GnGqKqSAm4PP8fphY82IFFAWZSpfcVjP44OXpNJKax
	RFVsmRhwc3v1nB397TWlZrXYqtl99c1wDI4TLnOCQfNgUg0jt0kz6UzqIZRmJ6PkbUk8YXDGN2H
	JmB63Q3JbmzbH77I2RTFC6bvD/ASmF9/zzPm3aMq7SsEp20u4/11XxDaw==
X-Received: by 2002:a05:6a20:3d08:b0:3dd:7a92:77bf with SMTP id adf61e73a8af0-3ddf79f1a9dmr3618723637.0.1790181250437;
        Wed, 23 Sep 2026 09:34:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c487:37ae:5ef2:4c1? ([2620:10d:c090:500::7:ac0c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dff9552sm1614554b3a.47.2026.09.23.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:34:10 -0700 (PDT)
Message-ID: <2333883f3fe2abcc40679edb4dc11f7b9bf5d1dd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 08/21] bpf: Walk the exception unwind in the
 verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 09:34:08 -0700
In-Reply-To: <20260923045927.2418543-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045927.2418543-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:

...

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index e12ec91b8150..3146f707e030 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -429,7 +429,8 @@ struct bpf_jmp_history_entry {
>  	u32 prev_idx : 20;
>  	/* special INSN_F_xxx flags */
>  	u32 flags : 4;
> -	u32 : 8;
> +	u32 unwind_frames : 4;	/* frames popped to reach this landing pad */
> +	u32 : 4;
>  	/*
>  	 * additional registers that need precision tracking when this
>  	 * jump is backtracked, vector of five 11-bit records
> @@ -510,6 +511,9 @@ struct bpf_verifier_state {
>  	bool speculative;
>  	bool in_sleepable;
> =20
> +	bool unwinding; /* an exception is in flight */
> +	u8 unwind_frameno; /* the frame whose landing pad is running */
> +
>  	/* first and last insn idx of this verifier state */
>  	u32 first_insn_idx;
>  	u32 last_insn_idx;
> @@ -991,6 +995,8 @@ struct bpf_verifier_env {
>  	} cfg;
>  	struct backtrack_state bt;
>  	struct bpf_jmp_history_entry *cur_hist_ent;
> +	u8 cur_unwind_frames; /* frames popped to reach this insn, if a pad */
> +	u8 unwind_frames; /* frames popped, staged for the next insn */

Similarly to v4, stashing these variables into env in one place and
reading them in another in order to push to jump history is an
obfuscation step. Why don't you want to push to the jump history right
away? Like in [1].

So far the only field in env that changes with current verifier state is in=
sn_idx.
I don't see why this feature requires adding two more such fields.

[1] https://github.com/kernel-patches/bpf/commit/fbc89e90cacd207b4271da25ed=
7a380f6b56125e#diff-edbb57adf10d1ce1fbb830a34fa92712fd01db1fbd9b6f2504001eb=
7bcc7b9d0R5604-R18577
    (with corresponding changes in backtrack.c in the same commit)

...
