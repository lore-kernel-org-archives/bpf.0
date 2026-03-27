Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00439150E
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642254; cv=none; b=WxyDqnfdfjTwVPWBcEkcE4n2KJRVbMhVyq7/OlEpBOlw8ylba2tVJYy3w8q7LDCPDv1rcKkhKnA+IAZBN9kkfU3jwhiMALn151wZ2Os6b7ijRjyI/eHMtANIQ2SLmDBG39i6PnapFLINyq1WCybgo71ATx4FBDFUnfSJUJpuSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642254; c=relaxed/simple;
	bh=tCIPzxd02HlIOngLskn0aCLc47LzVpybFDcGNEV4Lk4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GN/AoRfdL7xX/U2uvJ+RpZ+aTfeyJRBaA+TzvSeMR7Z3Zcnu+AWZdk/A16m7RxpGMdxqnP6m/dEUZT3vfUVC7FGAqEdJZOnmuxfKsg2fKuDDfe4nNtfgQ/zq7A+ETTXybe4ive27Qp2kr/PjWFK3aWiE1OlAK+zseMvTR/nIw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Kd/RuJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Kd/RuJ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35a1cc6e478so1543494a91.0
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774642241; x=1775247041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jWOaTybVWqF1QWsgUBetxrOguyM9XN4fF9S4x3ItzK8=;
        b=Z+Kd/RuJQ3yb52Vm2t+ljgGlLIzmughv2sVZ3qmJTmBmaB/WWiwVJpBkPqrX2TlTHB
         o0e0NROgh+MS2S6MAI76rg5AWjk5xSuS/GjmAUEIt07mPTHKHDVqzidTB75Yldc3C48C
         HkJerOkbI0VBKfDVnM94Xlaazp1XkqEonc6cg8qfxq0iF9+TkYn7OXrF/UmykRUzkfnH
         8cpBa7/PkG9BS8RbochsQ7T8SjHNoczFzU3ZzOaJZeF60AQsOH++j7jNR4ZU3QcLYxxc
         t5IjUTkkYb2rAdFYUnsj6dhW1PJfSSeBWzFTx2tPxgrJux7PoKa5k7zRj8TJUXiaZQTl
         FdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642241; x=1775247041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWOaTybVWqF1QWsgUBetxrOguyM9XN4fF9S4x3ItzK8=;
        b=S2suRM1YIUfmvG3jBYeqoZeI2341OYj2XVTrN5YK0oBKXQCHORENrBtsghR6TRyRTa
         /Wl/I1QLKSlEcoQKahPBz4pm4OtjS61zhRwsmmr++0cp8WNjaA/1j1xhOQILUsS0hhiv
         7SSqZ5CUDmQgBzlynbPCZE48hlA3R/y4qjFzZkJOtuSU7USLQF5sNnUKkJpcDFXkIjTg
         biEoV8ssC5+ZvyBZmFB8KBtA9dwVBkhhqIbzgRsM+Qa6Ez5+4GSDq5N9kr/FvwCrftY0
         3y7YXuHLf9XcjQZYjN34iKyEXuSM5n/b/YY5Om5llX14Q9VZzTKWQfG0d/lBOoo3ykRw
         0dPA==
X-Forwarded-Encrypted: i=1; AJvYcCWKrNSdUQjIyKJSCGLaR1qAPbMUy1oo63xXvpqUHPwy6B7EV0IUKp+SFRtyCcVxP4ql8sI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs72QwBw29fjava83jMelBBcAvKcvP+J+zPr4lFjEIKljM+1FE
	odHNhrxnIqKpefC/9lS1/EwPbz2LT8MbYrFZ0Yp1CFX0bA8iB6f5Fw/u
X-Gm-Gg: ATEYQzyqJyxJN0Aokj/CqcPTf1nFQVAtZna7Ki3M4Cf7iGRQP4UHt/FlGgp/ioqOJ4m
	2ikE2c1Kva3/4bFqVCGIDu8b6yz2KMG7egF8FG0lOoj8MtyXmY61eJ1ABbwOGEZgt5kYmWnLsqL
	D5VJnXdQCKR52J4xbBt2rn4z3R7JOhoyALRkngRimg/rB3ZFfplWMjhJwbu1ILWNShVQSnH8s0L
	dVIvRDCY/2udJ+IJy5wpjZrrvIiWlJ8jOfRi+2sox6erTDHXwjPYNXkWjv1kS+V6CK3le2zSJX4
	yNx1uD/a5yFcrfJNgpBUpvo0AWhmR4T9RvaCpo4sMwvyNgw0QhYSt9fRMDhqf8Fs7ZoPpZXUnME
	Uy63g3RuwqvpNnvEWmkDAY0thR1K8VdEMzk2+th8i80NpReXdawLfbO+A1uQR7UHi/wzySBS6vf
	qujGgUn8WVhqAmkh8uIP8wmuhlVpvBWleZ4TlhUHIuL4AfDib4iVY=
X-Received: by 2002:a17:90a:f94e:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-35c30052dffmr3979571a91.16.1774642241177;
        Fri, 27 Mar 2026 13:10:41 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22db12f7sm5704166a91.13.2026.03.27.13.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:10:40 -0700 (PDT)
Message-ID: <b943320a099bc171a10e533935eef8dd06b30e2c.camel@gmail.com>
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: Eduard Zingerman <eddyz87@gmail.com>
To: Barret Rhoden <brho@google.com>
Cc: Levi Zim <i@kxxt.dev>, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, 	yonghong.song@linux.dev, Matt Bobrowski
 <mattbobrowski@google.com>, Josh Don	 <joshdon@google.com>
Date: Fri, 27 Mar 2026 13:10:37 -0700
In-Reply-To: <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
	 <ed857a23-bd73-4915-b080-558b5934bc8f@kxxt.dev>
	 <79ac0188db82c675e62c36c8ab036b45cef3f3f7.camel@gmail.com>
	 <9a418287-f8e3-4064-8364-ff85793de74e@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-27 at 12:41 -0700, Barret Rhoden wrote:
> hi everyone -
>
> On 3/6/26 3:27 AM, Eduard Zingerman wrote:
> > On Fri, 2026-03-06 at 16:20 +0800, Levi Zim wrote:
>
> ...
>
> > > I have a BPF program [1] that is badly affected by the patch that it =
no
> > > longer loads on 6.19.5 due to
> > > E2BIG error.
> ...
>
> >
> > I'll take a detailed look tomorrow, but am curious if patch-set [1]
> > helps with your program? As far as I understand it is not a part of
> > 6.19, as it was not marked as "fixes".
> >
> > [1] https://lore.kernel.org/bpf/20251230-loop-stack-misc-pruning-v1-0-5=
85cfd6cec51@gmail.com/
> >
> i'm in a similar situation - my scheduling program, which uses
> bpf_loop(), won't load with the dreaded E2BIG:
>
> 	processed 1000001 insns (limit 1000000) max_states_per_insn 76
> 	total_states 59608 peak_states 171016 mark_read 0
>
> i tried the patch at [1], and no luck there either.
>
> are there any tricks with this new SCC stuff to help with verification?

Hi Barret,

Is it possible for you to share the program code?
If not, here are a few generic tips:
- If there is bpf_for or bpf_loop based loop and you hit 1M
  instructions limit, this means that internal loop state does not
  converge to some previously visited state from verifier point of
  view.
- Most likely there is a pattern like this:

    v =3D 0;                            v =3D 0;
    bpf_for(i, ...) {                 bpf_for(i, ...) {
      ...                               ...
      v +=3D 1;                - or -     v +=3D 1;
    }                                   use v for memory access
    use v for memory access.          }

  Or its equivalent in bpf_loop terms.
  'v' might also be a pointer incremented inside a loop.
  Unfortunately, we don't have a simple way to identify which variable
  is a culprit. We do have a way to identify which loop fails to converge:
  the 'veristat' tool executed with --top-src-lines=3DN option will
  print out C lines corresponding to instructions that verifier
  visited most-often before giving up.
- There are several possible remedies for the pattern above:
  - hide exact value of 'v' from verifier by initializing
    it using a global, see tools/testing/selftests/bpf/progs/arena_htab.c
    variable 'zero'.
  - change the logic to rely on 'i' instead of 'v',
    for 'i' verifier does not know exact value, but knows its range.
- Another generic advice is to split program into global subprograms.
  Global subprograms called from the loop body won't inflate the callers
  verification budget.

It is hard to provide more specific advice w/o seeing the program
code.

Thanks,
Eduard

P.S.
  I know that loops handling is a major pita, we are working on a
  solution but it's a complex problem.
