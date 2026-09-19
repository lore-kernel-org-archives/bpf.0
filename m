Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560428B4FD
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789793847; cv=none; b=leEUEyx8q4kQaIcsiPgEr1XdzuOKb23cNVMNQ7nfkkAviY0iOURdz+5ux1vAzdYTn7KrzERvNrTTVRyZrfhgYhBNmY8H4c2bboZKA3PfqULlQEYRrOb9hS4bJSLOfQDlpLcQZ0KBBSROshi9WK5Yi8r0DioKE5C6qb7YWECHq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789793847; c=relaxed/simple;
	bh=9TjbfOYwLEelgN4FlNO7kf1gv2Jdqy3PJrAo3+QvRtg=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=oWKz14MahWof0LQ7Fb6U2rMIcUvOvwm8BgL3LlJNeQvdYTtG60iWi8jJ6tw7VOX9Jl0v77WNsC0T8QRyqeHOHOWF+/q0cqHtgbiv/Wb6WgZ7n5TC661BF1SxBwCFoomRYb8xj6/hA8iflFmHGitYCeqamaHaibJ4pzoiapbeYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNqkw32a; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNqkw32a"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d90ba1d807so17588535ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 21:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789793845; x=1790398645; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uGYUCnclMqpaGWojpN/1e5M7xIYkn4nbLsFpA3oI3dg=;
        b=kNqkw32aZSrloAGY9pAWwgegCxR6ZnKHv0zyumV5/V8w9QocBSA7PaAB2gnRtk7FQy
         3N4+geimYzAZtGfrlY9SYUF5QddRhPtimwKMNKElWhfzOOqnwNCKqh9Djw9EEbe69owO
         frHwWjNWpZUybwGeyqKDSntanBEhDy1UayJcY/7lAcuWR+IfUX6M/C2Yc+ibRBnnnF4v
         nHOJ3RHGYdnHFPMSfXPPn7euOvmg8XCZDFPsqLiOXk14F/t239A1hpQ5tNgUVt90Gbhm
         B/im0uDrt93LsKxuaJYUA12PMCG+LcYpYuYfDMaR1qezcKPFLWNlaJbwE9Wdq7tIVV9u
         5MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789793845; x=1790398645;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uGYUCnclMqpaGWojpN/1e5M7xIYkn4nbLsFpA3oI3dg=;
        b=QY/2zFm9s1firBy7WHdg8DqPi7cWjApnuCwE5LO2Uy0AbsUleH2GnEPXaQwniPte2/
         hFYeqLBdbCK2MUdIaFY6OFmt+3DQSG1x9yy25vB2sPrNH9OfMxyGXajWMVP5v4RkhU6w
         UNEV53aS2rK+pRwOVcNNRFecvIUo7m3yngU5rldNVKoMD5rX3lT28wd/MeN+DrRJPjql
         ZTKAZ3E1dH7DAxtI9O0qHGjK61oNM4y4opnkKWXmy60pdMu/rA+5YeB5lPTA6X3AAbJF
         cGNPDgVyoEvipONNHy3BsHS+UsQ5pmA/sChaDPETpVbLrUSE+nFS8cHEMGOWSpyFLNlP
         SPEg==
X-Forwarded-Encrypted: i=1; AKwUvBzGzojP7rwwrvA6A6azGSDikf8ZKgKpir9Qdf8f+VHT/M2o8vYUv1xr3Kv5CxWsLKwkmaE=@vger.kernel.org
X-Gm-Message-State: AFuF++ldej/d9oQhGzk0TUYaQOr0NV+hhGnWX3Y653qn/zv4Pb4E0zSB
	fMLeZt3chfoEUt8251aeauh3+4EFuGYmaF1FbMh7GeNxRhr06uE+XfZn
X-Gm-Gg: AYBFou1+gyDUbfnNXhUXSo+1ah88pIPUMCHIUqh7h9UlsUyl+Xq+baq6sc7DsXYuWb1
	VY/jCCCQb/YF1+CCKgldSaLWAVy3HS4R2xktV5f0Ol070ykGevnng+XsdX8eBVjBM5YwLc0DMqz
	pSCN0HP0q9x3/YNXf9G7PWRUjV5y4NbTdm1j88FFQ17nJ8nLZSK+NiuIszq4HJhDsF4vBNBmXB0
	M8OhP1dTo7os75m1brwrhGNSKIQu3Y8TGbFGxmLS082Os3PyaJbs9spo/jey3N3ezruXDvyI4ax
	gp5zpl1nuyV+S5Z/h99ahNVdSzLlVkpv6KeXX9SiGDxh/lL4Sc6qJjhnP94l02huedCWnWd4Kij
	ac8C8j0Dx/Ovy+Fk65N/9w+kquGWn7yPkaxGqDSUETUwSterNxlUjnqXDk2jmfLf9xJNmvIogXg
	Jef4ZCmoljQ49hpdMbMubFHcjXyd5OUHt6w+Y/xPELVl4vAJgjvgCj0K7urzHQmnFzRhZND0nDH
	K7R/YXU2fcYqYfSPJKVQCncO/UY8aN71qbsG0Ai6EHortg/95BiXEZ614gpry6tbDG+C7diSVNx
	r2AZ
X-Received: by 2002:a17:903:2445:b0:2dd:c100:a5e9 with SMTP id d9443c01a7336-2ddc100a6c4mr21285975ad.61.1789793845187;
        Fri, 18 Sep 2026 21:57:25 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17b9d0dsm5179485ad.48.2026.09.18.21.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 21:57:24 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 04:57:24 +0000
Message-Id: <DLJ0YT6G4EZK.22FEDYYMKS4E0@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 08/20] bpf: Walk the exception unwind in the
 verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260917055726.3930930-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev> <20260917055726.3930930-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 10:57 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9cbdb8339701..a3b34ded1392 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> +static int unwind_step(struct bpf_verifier_env *env, u32 callsite, int *insn_idx)
> +{
> +	struct bpf_verifier_state *state = env->cur_state;
> +
> +	state->unwinding = true;
> +	for (;;) {
> +		int pad = bpf_cleanup_pad_of_call(env, callsite);
> +
> +		if (pad >= 0) {
> +			unwind_enter_pad(env);
> +			*insn_idx = pad;
> +			return INSN_IDX_UPDATED;
> +		}
> +		if (!state->curframe)
> +			return unwind_finish(env);
> +		callsite = unwind_pop_frame(env);
> +	}
> +}

robot voice:

mark_chain_precision() doesn't know about this edge. The jmp history
gets (bpf_throw in frame N+k) -> (pad in frame N), or (resume in N+1)
-> (pad in N), with no BPF_EXIT in between, and backtrack_insn() only
switches frames on E
XIT and pseudo calls. So bt->frame stays at N
while it walks the callee's insns backwards. If the callee wrote its
own r6 the request for the caller's r6 is cleared there, the caller's
def of r6 is never marked precise, and a later state with a different
r6 is pruned at the call site checkpoint even though the pad does
r10 + r6 with it. If the callee didn't touch r6 the walk reaches the
static call insn with r6 still set and hits
verifier_bug("static subprog unexpected regs"). For a throwing global
subprog it's verifier_bug_if(idx + 1 != subseq_idx) right away.
The unwind transition needs its own jmp history flag and
backtrack_insn() has to bt_subprog_enter() once per popped frame,
like it does for BPF_EXIT.
Pls add a test that does a variable offset stack access in a pad
with the offset coming from r6-r9 set before the throwing call.

> +static int process_cleanup_resume(struct bpf_verifier_env *env, int *insn_idx)
> +{
> +	struct bpf_verifier_state *state = env->cur_
state;
> +
> +	/* A pad entered by ordinary control flow. */
> +	if (!state->unwinding) {
> +		verbose(env,
> +			"bpf_unwind_resume() at insn %d reached without an exception in flight\n",
> +			*insn_idx);
> +		return -EINVAL;
> +	}
> +	if (!state->curframe)
> +		return unwind_finish(env);
> +	return unwind_step(env, unwind_pop_frame(env), insn_idx);
> +}

unwinding is one bit for the whole state, so once a throw happened a
bpf_unwind_resume() is accepted in any frame, not only in the frame
whose pad the walker dispatched. The in_pad rule from patch 7 doesn't
close it: take subprog S that never throws, has its own record, and
whose pad is just "call bpf_unwind_resume" reachable by a plain branch
from S's entry. F's pad does "call S" and S branches into its pad.
Here the verifier pops S, finds no pad for the "call S" site, pops F
and finishes, so whatever follows "call S" in F's pad is never walked
in this state. On x86 S's resume is a bare ret, so at run time it


returns into F's pad right after "call S" and keeps executing it with
S's leftover registers. On arm64 br x23 ends F's pad early instead.
Remember the frame unwind_step() entered the pad in and reject
bpf_unwind_resume() when curframe doesn't match.

pw-bot: cr
