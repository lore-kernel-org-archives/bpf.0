Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988F3DC4AF
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842587; cv=pass; b=u5eotfPuvpSZzexOthIkdRznIq0R2KwDjRGHbiYQfi/8gB91+Gs0tEIS45sASnRvYbe5hD8oEyeagBZbYMalIluzUEjdiO31mtJtTCqpHC6DzpLC3NzwBqVXLtpFCkHdeh9QZlkV4swJlHl56jpbw9YpoaxBBt5kBYbaMA8NQSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842587; c=relaxed/simple;
	bh=0mstDLpNE5HqJ37WPV2/6GB6JwYfKQBjPJNFkn1B/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGmggxZGSCQQBaVnm3WUOFY3YntxQMuwNQC8s5tgg27e23n17TlAYxk7vXxwa/h9dXRbJNOujB4fmbvEcaReT2SAXK8P8bp/Bpg7wcbzxiR3Auzch7UbXrd2114MbmERfBqgGOJLu1EqP1XxMj4qqf1a0QmbXrMD/kfg0Fyi55M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqejJpi7; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqejJpi7"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e04df8c46so2777449b3a.2
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787842585; cv=none;
        d=google.com; s=arc-20260327;
        b=K7dfdUhlkhXEdeuBEoyj9Jlucna9bKK3uArG01Z+1GSJuJkFaK8SBdGC9MtcD+5/Vo
         sBc1WFgK+Q/D8/v1qvztia3Fr5MS4XsSZKA6uCG+9dwcyOzDi0yeHBUkUybKkCa+V3CR
         k2lVw/A9KI8FeeHX3qwyrVx+kjgbuWwLkYdorZ6rTzbI1Objs7TUFBl9ANZONKvabU2d
         OeZfCGjtUm+j8/STJTPTEGByxllbR/+LyWsouxuTHxob6OFH9CKa6toLTB0KIvg4D4C1
         33lQsokcAyAmjeAiJm9FiJjzyeRkmzJUyzRotMCJv8fyZUYHWViyJHfUlJONyiYtVAMt
         SRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        fh=qnBrIGg4A01ES7SU/UktmWK8a2XMKJeE7aqua04qaG4=;
        b=j73kvGmNKe2cf+BqbMQVR/Vp3ttZyXW+Z5oyYpPXME/B1TShJAjsP8kv4IPI3Ts/m7
         +M7sSdlypQWJ2CZdSHKp9bbOrq+K7DhtA1QguMaPfmE2niNW9jJHsw31NBEI9NgH04cq
         vSiE77/ZLA3Z81ec9rxWUDzCZWYlo9ak5NyB9cg7MfXY53ZX5JJtmCA9+Kj5W0QbzLbz
         c1rylflK1RaJMctE5+8lQCS7ZSYxvafXmEnwo6+mjuW7CweNkQzNMX6+dDs3DBBCHt8Z
         k94tQRweblk9WnNYLpmx1Fk51LyihD4BpBORYaeluhV8UDYjH1aweGW/mDkozB5zRNAh
         IHEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787842585; x=1788447385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        b=ZqejJpi72YkEooyXZ/y46qcvpKhrepGfPp2G8lrP2ejv2GCOgguXBmpkvVQVzKWuzB
         2YePS/6hypACVMQ6odCH7XZ5eh/ZS/C1VN04tIdHiX0/6GErV8xxEWMNdMARIyalYlXV
         t7hVzBy7jt6DGd5kqIInJd0C5v8UUEmohfTrXThbUYH5SKCxAqnJQRa5mB0p9XzH0wSo
         IeuQUCNwP2Uhft1iF/30b7oMOeAU8b8CCcxapCZbuJpfrfIRwptegSPS3GJef+XxsKYT
         lOvw+Z6e6wHnI2FNbjMnNQ2BpBkInCqrvnGwDllt+RGu6unZ/JZbNQLZogQ9zH4awfbb
         soqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842585; x=1788447385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2MTw88jVLBTmyVxQrGtyl4vuDsvFs0qyxjhjgsnHbI=;
        b=bt7q1/cC7H4ejinZ+BpVJ8VuCAZjCv0OLB3R2e2RdexnghpZ4d+83ANuviEClltmI+
         at/BthgWuaDTPi4qN8oF2rmRdmJbYvzpw3oJRdTV0/D4VcmkwReTmdK2Pa4ntrHVuLJj
         Y2Q2upjbNoAbKV8ION8Gk7IstRc143JoIyten/QS4Ddqg6mDcnYaXTaocpZdXxD1BPlA
         wwG29RY6doVEi2e1cxB71B3n2H52OwK8BCqI5QMi+zQzhDdPbGWjMkpn8Pd1bphQvNaP
         klZrliLXRFLrcY8wsHr+POh5OcmQqDIrDuplh0xyzdW3eoX8PVIArY+2+QIaX4RciGIk
         kfvA==
X-Forwarded-Encrypted: i=1; AHgh+RofyYtP202uC2e6eiIZmVpBmN28Kze4e0wYhxGgoRd4+9gRjUw9wHD0AeE2bC2BYblqZz4=@vger.kernel.org
X-Gm-Message-State: AFuF++lvP3sWIiKcPYdzdPfD5wbb2XpB9dR3bO3z+wfDdIMdmFOtQr3R
	5w+dGUBY9ljsxeKk6UZGYjSnAUgb5RkFgiLaLIoDhCrrXxO5pa7aAiwcOshsgKDSQlsOgI+WV9J
	t0LWgu/NfSE9LgddlyQvU7BSB5XaXAro=
X-Gm-Gg: AR+sD12/STbW44+5IMabE2R2QVCwzxlqLzLY5MicF2g52ZZHZX6RAlpuGreVuO1Kx1Q
	jE0g1AaL2aX12EY3XVui1eIq/hK9UZTG0aQBnt9L31iUqJCgJzvVYxNUp4hAFj+lslZja1LesEm
	WM2SqhvF+P/g4iDbc+wNTHkXXogqVMA1A3Bsy9DSUjiMIiga/7UDEj5ofmWLLEt75qF2qucS1wt
	Gmzk/3ojPRmVQGupJ8KJqvvl3XZKS1khpAIL3Kp1VAdw+LOOqdatKyesnDCB0PEvKtKkCaDWES+
	q3NBCTgzPTOFZJ6+lQK1YWEqMMrilFywGo+lsd2BofQUTkMgwIXdP5ZEpwgk0ILOYTnJ2DB7Swa
	6aPgw26n16kME3JePJj+g3sh0PqNhjZkCg+Qi
X-Received: by 2002:a05:6a00:3984:b0:84f:dfce:966b with SMTP id
 d2e1a72fcca58-85373bb8dc8mr26253345b3a.8.1787842585290; Thu, 27 Aug 2026
 07:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
In-Reply-To: <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 07:56:13 -0700
X-Gm-Features: AcwNN1WJoNUFqCJjOSLU7Hm184I3k4u300g0JamTEyCvcDlP-yF2LMrAI2A8EVc
Message-ID: <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, tj@kernel.org, 
	yonghong.song@linux.dev, stable@vger.kernel.org, olsajiri@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > A JITed BPF program can use one private stack per program and CPU.
> > Sleepable programs can be preempted, allowing another task to run the
> > same program on the same CPU. The second invocation then reuses and can
> > overwrite the first invocation's private stack.
>
> I'm confused by this. sleepable progs go through __bpf_prog_enter_sleepab=
le_recur()
> which has per-prog recurison counter. So preemption of the prog
> doesn't break private stack.
> If the same prog attemps to execute on the same cpu it will be skipped.
>
> syscall prog types go via bpf_prog_run_array_sleepable()
> that have per prog recursions counter.
>
> Looks like we're not doing it for bpf_prog_run_array_uprobe().
> I'm not sure what the right trade off here.
> I feel universally checking for recursion is better
> then selectively disabling private stack for uprobe.

I'd really like to avoid adding this "recursion protection" to uprobe.
With uprobes, there is no recursion, it's called from well defined
context in the kernel and you can't have recursive uprobe BPF
programs.

All you can have is a very valid and possible sleepable uprobe
interleaving, which the user cannot prevent or work around, they have
no control over this and it's just a fact of life.

 E.g., a simple scenario, we attach one bpf program (let's call it U)
to some USDT. BPF program U is sleepable and actually can sleep due to
page faults (e.g., unwinding Python stack trace requires sleepable
mode for reliably getting filename strings from Python runtime, which
are not always paged in).

In such a case, you can have thread A and thread B both hitting the
same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
thread A hits it first on CPU X, BPF program U starts executing and
unwinding Python stack, does bpf_copy_from_user() for string contents
and causes page fault, is taken off CPU X. Meanwhile thread B hits
USDT on the same CPU X, kernel runs program U, and it is supposed to
work completely independently and concurrently (no shared state or
whatever) from U's execution in thread A.

Yet, if we add this per-CPU "recursion check", we'll just skip U's
execution for thread B. This is data loss, and it's very bad in
practice because it frequently just invalidates the entire data
collection trustworthiness.

So I think we should disable private stack for uprobes (sleepable or
not) instead. I'm not sure private stack buys us anything for uprobe
cases.

As Jiri mentioned, at verification/jitting time we can't tell kprobe
from uprobe, though, so that's a bit of a problem, but it's a separate
discussion we should have. Perhaps having an extra expected attach
type, or type, or some program flag to designate uprobe program as
such would be appropriate, not sure. Let's discuss that.

But please, let's not make uprobes unreliable for no good reason.

>
> > Disable private stack for sleepable programs so they use the regular ke=
rnel
> > stack, which handles preemption correctly. This change is intentionally
> > limited to programs marked sleepable; preemptible non-sleepable dispatc=
h
> > paths require separate protection.
> >
> > Fixes: 7d1cd70d4b16 ("bpf, x86: Support private stack in jit")
> > Fixes: 6c17a882d380 ("bpf, arm64: JIT support for private stack")
> > Fixes: 156d985123b6 ("powerpc64/bpf: Implement JIT support for private =
stack")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Simon <simon@swine.de>
> > ---
> >  kernel/bpf/verifier.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e37ca75e5c4..038753ef07a9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stac=
k(struct bpf_prog *prog)
> >       if (!bpf_jit_supports_private_stack())
> >               return NO_PRIV_STACK;
> >
> > +     /*
> > +      * Sleepable programs can be preempted, allowing another task to =
run
> > +      * the same program on the same CPU. Since private stack is per-C=
PU
> > +      * and per-program, the second invocation would corrupt the first=
's
> > +      * stack. Disable private stack for sleepable programs.
> > +      */
> > +     if (prog->sleepable)
> > +             return NO_PRIV_STACK;
>
> This is not true in genreal. sleepable progs can use priv stack.
>
> pw-bot: cr
