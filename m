Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BB27B357
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 06:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579648; cv=none; b=b8eqE2UsJo8l8Uf0NSR4/v4mZP6UTHmWsr5KvtWucf6hw3UUhwnVNL/nh0s6wTlYsh8gLBUYTWrM+gV2sbrkPdb4JeoHrc4B8GWsrR1T5Ouv6E8B0Yknu1mLh55W7r+eGkZ4c/LzKWSDhLqBYTnqqz2F5Ll8KH5O2YTHkxxyoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579648; c=relaxed/simple;
	bh=P3DdR4s1kLt7WzVKHUj6fTXk+PI5dgeDUEMELoOfajg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qvdx6ZCzXWowJxJaYgNtyhDWhQvffADbsD+O90nbw0lzKUjyKtbds/YJLu4ZS3lWodL+vLRuLBXB/ykBQMmqVjy+RaHSfI7EcWS6kDgzvuJBvDCMM2oDcyBM8E2KH4T8KBagoNf57JY22kWQx7anObH1D2xGnInOQ4sihEIpN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UPx+Wyct; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UPx+Wyct"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so743433a12.2
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2026 23:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783579645; x=1784184445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3B/Dq0dBNn27ZKW7Kn4NVCyOhndmbS7oy98sHeCH+0=;
        b=UPx+WyctGb1piyweU10L55Y8bUQW/MCOHJ3vM3TW0oCsCE2xIG7a9mioBZSXY7LVzc
         qIU8ni8gQz0Qn6IFpXtPMDjnVsvOgKXjDUNX1nCxFWc/BT8M33/quXqePZL+uLqFgI1S
         MhkllHKcYgrlj/o7xwGJDz+gbfCnEs4RCNsH9vHpZ7lbOdcrFmPOsjV+LR3vES82OPBj
         uzkXEh+NJOCX1txEcwsADiaz/yAe/rzEXL5a+5YNvCBVStumBOXJHRJKSX6kWkNNXDik
         Vi62PJQOLTk6mNAZvFX+QZlrJ1uZnXKUJi4es9MLH0mjQ9zXz6BZDcjsCNPOkmbfTvsU
         tAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783579645; x=1784184445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h3B/Dq0dBNn27ZKW7Kn4NVCyOhndmbS7oy98sHeCH+0=;
        b=frR+cZFt8uLuF2knk8DhVdCqCPzQk1C0XLGyHdikB3Vjq/mLqgXkokXPwGPUsfIOD6
         W28gJfdq4uNJis9xGV47N+k1Yj6Id5opE63sYkzgu2whVaq+V04OaFrH/AYHP51NDK4A
         lsRUCPjIsVSkRDWjlh1VMJNCyCsp8bsga/HJ9rhW8Xb/XqmCLkKsqBq6taNj7YJpQpEJ
         Dm+r/SkCU0n9pZqLD5UeMBOLYPboL96t/1gUs6lAQPwKzL+y+0nekX66jHOFVH9lL6xa
         I48ify+fYFV8qeGqK5qweYo0gzktvWm9XKA48hdkjCi01n1Q2/zh455XKwzTya8Y4pFu
         I5UA==
X-Gm-Message-State: AOJu0YxXqHnnE/1eoNGVZowcnglB+SMpYvm+I5ThM025vdS0t6MWhHEg
	R8D8BmNm9gKamKse9R2X8fS+00vsgYyBKIRBTh6OqYnGu/qukS/HFd8YNVZ9mUv7OrU=
X-Gm-Gg: AfdE7cl/E0USBz84HXjbjKVN2WcyuCe89/ejhdyr6CG/U9di5qWDwoGsCLQzH6RYGJ7
	sKryFXkGKHFOZe0M+KKjBs7ZqK7UCNtfkv+Xoy0G7oZOlCwLgLF+kJVXhz40wOBcolUhPOrvoBR
	jYOBLqVr30pCNqbIOcvh7zo2cu5TjF+A5xlx/bNA47uoGmxLmtIGacXH72r+bY9QU7UwcULf9de
	T3YgU5SBlFHRgGJMAWwoMCCh4gI+fCRZLCEiIYcMIHPdTH3kx/0k5g41BXJ9N48mTJfGHbmAtKo
	YLLyzKZBtYP9Hblj9+zGoo5IVO3psBF5vujgj3+WmtTopP5hKsCmRbz9IOu6bZcZDtZ7SU0N6GI
	UGzxjmoyDiqwm6E/z5qdSxpBTHI6DvEdyc5J3aM9MZBXCCpK6C5+tnfJJhW69AUK6IguT5xs46L
	ZBRaR6TfhxJBLVGlqGnevUFX98My682pYOBl0=
X-Received: by 2002:a17:907:1c0e:b0:c15:b68a:55c with SMTP id a640c23a62f3a-c15cdffedb4mr269256466b.24.1783579644714;
        Wed, 08 Jul 2026 23:47:24 -0700 (PDT)
Received: from u94a (27-53-128-132.adsl.fetnet.net. [27.53.128.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-848530c5a12sm969893b3a.5.2026.07.08.23.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:47:23 -0700 (PDT)
Date: Thu, 9 Jul 2026 14:47:03 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	emil@etsalapatis.com, shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer
 pointers
Message-ID: <ak8XSRiLKx5WcIQw@u94a>
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com>
 <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>

On Wed, Jul 08, 2026 at 10:11:01PM +0800, sun jian wrote:
[...]
> > > @@ -5326,14 +5326,18 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
> > >  static int __check_buffer_access(struct bpf_verifier_env *env,
> > >                                const char *buf_info,
> > >                                const struct bpf_reg_state *reg,
> > > -                              argno_t argno, int off, int size)
> > > +                              argno_t argno, int off, int size,
> > > +                              u32 *access_end)
> > >  {
> > > +     s64 start, var_off;
> > > +
> > >       if (off < 0) {
> > >               verbose(env,
> > >                       "%s invalid %s buffer access: off=%d, size=%d\n",
> > >                       reg_arg_name(env, argno), buf_info, off, size);
> > >               return -EACCES;
> > >       }
> > > +
> > >       if (!tnum_is_const(reg->var_off)) {
> > >               char tn_buf[48];
> > >
> > > @@ -5344,6 +5348,29 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
> > >               return -EACCES;
> > >       }
> > >
> > > +     var_off = (s64)reg->var_off.value;
> > > +     if (var_off >= BPF_MAX_VAR_OFF || var_off <= -BPF_MAX_VAR_OFF) {
> > > +             verbose(env, "%s %s buffer offset %lld is not allowed\n",
> > > +                     reg_arg_name(env, argno), buf_info, var_off);
> > > +             return -EACCES;
> > > +     }
> > > +
> > > +     start = var_off + off;
> > > +     if (start < 0) {
> > > +             verbose(env,
> > > +                     "%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
> > > +                     reg_arg_name(env, argno), buf_info, off, var_off);
> > > +             return -EACCES;
> > > +     }
> >
> > I was thinking of suggest to just do a single unsigned check
> >
> >   var_off = reg->var_off.value;
> >   if (var_off >= BPF_MAX_VAR_OFF) {
> >     ...
> >
> > But looking at the code before 022ac0750883, what you have is closer
> > aligned to the previous behavior, let's stick to this.

Actually looking again at 022ac0750883, moving the `off < 0` after
tnum_is_const() and bringing back the `off += reg->off` removed from
check_mem_access() is perhaps the more faithful restoration of the
original behavior. 

Though reg->off no longer exists, we have to use reg->var_off.value
instead. IIUC any register of pointer type should already have its
var_off bounded to +-BPF_MAX_VAR_OFF by adjust_ptr_min_max_vals() in
theory, and thus shouldn't overflow `int off`.

See the diff below.

[...]

> I agree that the size check is redundant given the current call path. I’ll leave
> v4 as-is for now to avoid another respin unless maintainers prefer dropping it
> or adding a short comment around the access_end calculation.

Agree and make sense. Let's see what @Eduard thinks.

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d46f7db20d8f..e116b33ad83e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5359,12 +5359,6 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const struct bpf_reg_state *reg,
 				 argno_t argno, int off, int size)
 {
-	if (off < 0) {
-		verbose(env,
-			"%s invalid %s buffer access: off=%d, size=%d\n",
-			reg_arg_name(env, argno), buf_info, off, size);
-		return -EACCES;
-	}
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5375,6 +5369,14 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	off += reg->var_off.value;
+	if (off < 0) {
+		verbose(env,
+			"%s invalid %s buffer access: off=%d, size=%d\n",
+			reg_arg_name(env, argno), buf_info, off, size);
+		return -EACCES;
+	}
+
 	return 0;
 }
 
