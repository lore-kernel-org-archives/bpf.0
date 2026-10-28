Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793223811;
	b=Rey16nUnoJCrfQxvMxpdHVLU4bjVbXAA4sfUkdhpzYN3MmojHNVn7wwuqHKxGn0Yr0nw
	 JzZBN3xGKYA/wI2yhbBikcDObNStDexG6w3rLKMmAr6TgwuhypMRzz+USUVSVqAOmAfSC
	 yzVP92zN71ZzRx3L3xz4kUkjn4T7Hlem4oJBhbafwT5POBqswDKJcXyTt2PEGywrS/vgA
	 BP3ky7lFSZMLsrfonXh/Hs/QM+SvfqQpELcCmIvjyL3+IY4TXCD+T4ASK+N/Tj9cgd6YW
	 z0yCJnszaUWvIMAT/PwKwioLBghH6KKgSBNglHlJjLOqNWZCK9BREWHY3dWhfyJXqaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=zVW5a5j0SJ+hnUXmPiUkrG1SaFObXFEpAaNxFp3fTNc=;
	b=1JzZJBpf4pmNLKz1GoAX0SC3zMNgYfNAEPSvLYSht1FQVhyiSvUw/mvx2pl2EmOnUoWs
	 6Ny7PXKpin7SjgUmVC/JecxQd7X5M8JMipRL4q+A0wJ5nvNlqYKVJ/QvM6YOuJVH0jQ4j
	 Q3GBdO8W+jOqyD2DJh/DI+oI5f3puUCXnk8ct6AXOwyx+1zGxdacOZXxuSTCnWB0yh5TD
	 VPotXbc9eCzSJZ75et0db93iHrwfDC3YpdpKt3eCH6KgKyG9YYbe28bdzkgDW3jQx8a+L
	 zn46Kc8ZHSZNxnhxONvFZ1J+X9O2/gbEBISLl8lLD/wzOz2Hw3GFhwZ1DlJNmD0gfbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzVRDdoa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.72
Received: from mail-wr2-f8.google.com (mail-wr2-f8.google.com [74.125.225.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C79606A31D
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 21:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C79606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zzVRDdoa
Received: by mail-wr2-f8.google.com with SMTP id ffacd0b85a97d-48df4afd489so402279f8f.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 14:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793223809; cv=none;
        d=google.com; s=arc-20260327;
        b=Sxxe/IqLLRXAbzXUl39p40t/oO+3MtxXJeq0IrY8uALfX2x2uzEyRZbwQT56prCwnY
         vKW4/IeHx396dSddurKY6uSvwUxVXPTzE34YS0ctwHBKI+omxiH1YF7WI8HAy0CeNTXy
         bC3203ARHnoIDw9vOdIePipV9qQxx9kR7IXtNbbwkxllDKcjMp471N0ghswHec2NblM0
         fsw04zJYJ+EoOSFpAiNyoKnJFCBUmlLp/0zWfDFU/DKYfEjMkI0fO9gzQgWGG4GhEhsm
         HnRiS3aWKOaQSzvqo9xlmjo4vSHdROi3aq2MTi42cCCCw6lYw2gXwio/u6DqdV5WJxcu
         1B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zVW5a5j0SJ+hnUXmPiUkrG1SaFObXFEpAaNxFp3fTNc=;
        fh=ogoijjMSDoSJdjUdjbR65PhK9VE6buLokffzXV7BSrQ=;
        b=Hvo+W0ZKkAtymlGdAuQYHdvIyFYn4rEP2FjS1CXwiCZlIZ24pKMdVEZ3F6T4KLxaz1
         2Q3K/QSdvPt+EViXUQFLJ9B0y5jALKY8Nc+KhOEtNaYx6kID9WB/RDPdil8UgFERrhoC
         XWRXCpbZvqOCp8dcc94fh/Vj77C/tmh0h7/uOeiDtFoJ7+liaMbh/UiAhxVePn7c8WIQ
         nketqSEl6HIDZVgSWUgojLyIKqzoApXYytpa5MlXWeknSd84j3cVzWSF5L+q2rsJHZw6
         DsOqBJA09BXaLejxDVDt55vIfM55SpIuhV+G9qedsN3rKTnDUd2R2/khaaiTzSfQ3bmQ
         uEsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793223809; x=1793828609; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVW5a5j0SJ+hnUXmPiUkrG1SaFObXFEpAaNxFp3fTNc=;
        b=zzVRDdoace0V/eoz77r5dQww9DiT3AvjdMVZRDQKQ9EUfvQ83iOuFibOKzns/uQxKo
         7v6pC+vLLrMokVxZiKLUxuv6EoPUmgIDkuYpGzfH+7vuS1olY+b525FWJaBFxtz5WDlb
         DefuVg9C9Zw5AOHC0sKI9DBdr5uWy+PwRawSRIiBI6DQK54OUTcdb42nLH+66r2YPROT
         23J3EPmMyPIfMtir15vZ6g6Dy7UjOSmrp1tlozO1R8KEJI/XkiFT6h+B5nNgkf6G+VQH
         TJlurRrMqgnQjC5SfaRi3rWU1De3TVPH9bvFyt9lQvv4T9Zl4/qggiRC8/ZKN+Gtc9LS
         1sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223809; x=1793828609;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zVW5a5j0SJ+hnUXmPiUkrG1SaFObXFEpAaNxFp3fTNc=;
        b=d3ERKz5TXu79zwpVIOmj09Vo0ayxRcjx507QYYMGxTSAZk/kiGAdds7CCMA3OV4PGt
         5tH7LlNK/5Yf2mVrfkZZgykQyimQcA1Q7aYqb2JVxHkN3q91EJl9oWLz2MDrHLZh/Z9a
         pwFXqtskM3kDK9zVRLMkZAwtTNpLFb/cTaSokYRcD91B4rgPU/8iQDl8rrdiX9UWoz22
         KZo4dg1+q9j8vaappTF030Ll2wmban8EOANTo36YO9M+RV9sRu9j2YfyRJ8cy5ws7n/W
         2/AcH6Hg7pscq+Z+E3Sab2LlSMav/m/E0TEeylcCB5sHqpZoGq/9jnmkDjWG8S1h6c+m
         AnWA==
X-Gm-Message-State: AFq9FYJ8sOBblLmAzP35b08OUn6lvGeiv3AgoSIDbjPhzHWbZpJ7DMpy
	8MaYPddLQy5y9/uBTnwli4g/ffoT8a2FulrWrP3yfQ51qt9LKvBBk6QN08v9FzDeIUPXgPsJdDP
	x2rFhomx52fJh/4LSVd82/GPC2Esqy7U=
X-Gm-Gg: AYBFou1dzkie8bEatpBuo9AL/ROD9YTgkJUTu5JGacIJdquSzk+IAkSFC7fTPP7fjVK
	gDgFeMfXzKoZyG2qb+bUsbk75NWSrXTYNMX9vrmRJSmBGhvQ+4QW1H9RFwLNYsQ5gESTPaLf7UJ
	351GMfGxlk3RsS6jeKLpk7srKUN0WjPnJUz4q03NgKQ3FbBXhm/zhN9QS0ITcJD7eBBMaqGyLxb
	dAIxOgebPrAPLwq9RL01SMh/7usDTmvkytoFw8MT+HI3MQQbd45lON6zGe/2XjEyIuFAq8GGtcd
	mtzPpsYflC2x9S2zYyazJc9KRD+uz0Q1VwbruVU+XSqID/nS/iU9g+1PaRZXyi4gxMR+Zm505re
	fKURuhlIFFZ2854hJQxcxv3fpId8LOKEeV9DZRig8b+QawhOYm9kmDm+fic6Brb1XwZA00tPzzM
	XxXdQxoXhVQjlAfgA0YF16MafaX0FPYhavYmaVxzdu5Lm9/D6qgRPdLnFEksKayJn4td3nsMwuD
	pURaA==
X-Received: by 2002:a5d:64c4:0:b0:48e:4831:ae20 with SMTP id
 ffacd0b85a97d-48e5d5c431bmr8396412f8f.37.1793223809310; Wed, 28 Oct 2026
 14:43:29 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793147364.git.memxor@gmail.com> <DMG7KVUM9TV8.3QO4MU310J4CU@gmail.com>
 <CAP01T76uO4ULjNOQ217jXTLWtP5XT0rvB7PZxt8MJcoc==GBEw@mail.gmail.com> <DMGQY7IH5Q3F.4QQNA0FDUWY6@gmail.com>
In-Reply-To: <DMGQY7IH5Q3F.4QQNA0FDUWY6@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 Oct 2026 22:42:51 +0100
X-Gm-Features: AclHuK-gAQY3WeGEUZgcIb0RGM8cC5lQZQLYaPErsczA0Gf9Lzq9Gs0A3ZK1DQw
Message-ID: <CAP01T747BOE7DHMfUSqFXEVFr20x=mzBbU3W_E04+kNfvUQ44g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous callbacks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 at 21:17, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 28, 2026 at 03:20 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > On Wed, 28 Oct 2026 at 06:06, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> I feel that you're too attached to bpf_throw concept.
> >> The code was quite intrusive earlier and it is still today.
> >> I told my agents that bpf_throw is a dead end. sorry.
> >> I really think it's not a kernel job to solve it.
> >
> > Huh? This set is about making unwind_goto / unwind_exit work.
>
> Sorry. Mixed it up.
> I meant it in the "Eliminate spill overhead for bpf_throw()" thread.
> I don't see the point doing any work for bpf_throw().
> imo it's mainly in the way of any verifier work.
> I'd rather delete all the bpf_throw related code and make it nop.
> It didn't get any traction.
> Originally it was a mechanism to enable bpf_assert() which in turn
> was an idea to stop fighting the verifier.
> That didn't materialize.
> So when I see the title "Eliminate spill overhead for bpf_throw"
> it makes me react the way I did... in the wrong thread :(

I've already expressed in the past that I'm fine with it, feel free to
go ahead with it (alternatively, I can also send the series dropping
it). In its current state upstream, it is useless.

I mostly sent the one you are reacting to out to clear my queue, and
wasn't tied to my own stuff, but without any expectations (same for
this one as well). The less I need to rebase the better, etc.

That said, on the topic, this one seemed useful to me, but you are
free to disagree and not take it either.

-------------8<-------------

(Mostly for documentation and public record; I don't have the energy
to argue about the merits / demerits).

Since we plan to sunset bpf_throw(), here is some information for other readers:

I carry out-of-tree patches since ~2024 to complete the support, and
it works well whenever I need it in any academic project. All of the
concerns for the original approach + spilling as a fallback turned out
to be mostly theoretical. Across all programs in selftests, scx,
cilium, there are a handful of spills in total where the merging logic
is unable to reconcile differing states; naturally, in practice, the
compiler already keeps resources the program releases itself in known
stack locations or registers since the code gen is better.

So in practice, no program gets rejected; the worst case is having
extra spills for contrived examples. I personally don't buy the LoC
argument either, the whole thing is contained in 2k LoC on the kernel
side, including comments and various boilerplate. Given the rate at
which we add code today, it's a non-sequitur.

In return, we get various appealing properties:
- Do the equivalent of bail!() or assert!() to prove a property, or
just not handle a given condition, regardless of the language used
(and for BPF objects linking across languages).
- A building block to insert runtime conditions from the verifier that
the program needs at a given point (bounds check, etc.), but cannot be
proven due to the limitations of the static analysis, or losing
precision. It does not depend on whether the program properly releases
resources at that point, which we cannot assume to be the case.
- On arena faults, or may_goto timeouts, stopping execution of the
program and ejecting it from the machine. This is done manually by scx
schedulers scraping streams and unloading the scheduler today.
- Programs that hog CPU using very long loops get killed
asynchronously at the next cancellation point (loop backedge) using
NMI watchdogs, and get ejected from the system. The counting
implementation of may_goto can be replaced with a load of a bit in
prog->aux for non-NMI programs (majority).

There are other various other misc. cases where it is more appropriate
or necessary:
- Software CFI-checked indirect calls to subprogs (basically, emitting
a check on an indirect call (say with pointer from arena) and aborting
the program when the CFI-like check fails).
- If runtime stack probing or recursion limits are hit, the program is
aborted, instead of return 0 (as done in rust-bpf).
- Making bpf_spin_lock() just work and aborting on deadlocks.
- When writing actual programs in C++ or Rust, inevitably, panic() may
be seen (but may not be exercised) in code that is unwinding. The
verifier will just reject such cases. In both C++ or Rust the behavior
is to panic=abort or std::terminate(), which is a good analogue for
simply aborting the program.

In general, it serves many purposes, has analogue in every other
virtual machine runtime, thus is a well understood idea, and
encompasses what various alternative proposals for some of the covered
use cases do (fast-execute, etc.) but with better semantics.
