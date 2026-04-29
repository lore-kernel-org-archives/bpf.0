Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D441F3F2113
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471290; cv=none; b=XnFduCSHW9dT42RKthXkmUMVrpd69SEJ5KNcia8918cfZ/R3w6rUUMVBeDUvHrjC6HynwOY9VWdKoSPWVMSt1xEw1Mu+Twh8z9s+n0sCTFkpGJtU8ifUS15K0OIe/pxIQ/BPP6YZRuVgbg7XLzFbZXCeml9bJV30M1HAg8qnEpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471290; c=relaxed/simple;
	bh=YkYM51GL/E0EPxztF09dalzXcDlZuXCPZe2oicp13x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5PpmtA1OL/22w+BBh8KsLcBZ4BMc0jcI9pQBR+/yQUWkntkHe/PxcODDsE7fdhIPELflkDBp5m5KTTgk/ewz9h3xNTmfX7bP7Y0+mULUFtxHc22KDB1hdqks7e/y7HOgMZiJzFwhB5LjhWFPRwx6Rga6pSyxzAKzYWTbHMnss4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ9IVMWw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ9IVMWw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7645adbdso6945177f8f.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777471286; x=1778076086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VAWCSrGbt/D1GbLISgkV4OM6Tch3UUmiA5VC/PVL/I=;
        b=RQ9IVMWwJFl5q5LE6bqpgKz6UTyJWahNofrWHcg3bJ7WX9ga8m+fWact7H6iAcLKWq
         7uoJtPxzVE5dEnEPQaJlWRXnLKlI5jnH7r2dcnZxYqHzHAayR0InQ/seYvj+FvTNV+zt
         mWC8xZq+5SYWl6erm9lFgKAp4dehNB7U1NRWDAUOtXFDZd4pLu2EC0+u8fpaS9C2aNDZ
         D8I/hVF8Gq41DAMWHkB33jce/WTm0uf98v0DCPggQRUCzpPiQue/nZUlZ4jjFMoSi1Nu
         5U0DsWOaaWvbW5NluHrB3CSXnuX0i/vXrMjWNWBtEH8yA7aqI0nK6vhv1PxKtcallbWF
         03ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471286; x=1778076086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VAWCSrGbt/D1GbLISgkV4OM6Tch3UUmiA5VC/PVL/I=;
        b=OLHssbk2gp1QTHulokj7VKErkEoQUjyTH4l8cBw5yKt3g7iB/LFOH0hQKiYxhbYCmQ
         VFDmUcZu/KPjT7L8i1PKpKv2uSzZa2z01O6Ovcq8F0qbKf9lBrLfCvaw/UwtdFq83vUz
         SThDMRqEZFpa/rOMg4Att0yDj8huwptKFD7SHBnI+4gej6Hk/zqTb4jPF2Ic5+syJhz4
         F24kJuP5fNoowdwyzjRS5gbJaBfyVIOiNSf36ZEhLq24HLRjFx9iM4FgDlWT1YbLXr9P
         4Jvs+FDWIcRLAbqyARZX0tf2dJFSWOCxjoL7sVrAdRgxNuNj8kBFZo8NZl0W0JX+3cF0
         Noew==
X-Forwarded-Encrypted: i=1; AFNElJ8Q5wSqZJKnJw7dyI1NoeuE3Ry3ABX1333zA6m9s/t9TaFz6kOuM7KMzkFcqB9+Yiz7AcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDb9jfDl2L8XyzGBsDL5j9Q/f+J7ZIRzRNemDQJCDrmfYqNHoe
	t6AjC7hQRKjeGkdYlJ7WuwiiyMVeZcwHhHJZVajKQR+EBSlpU1gEiFFD
X-Gm-Gg: AeBDiesn+XS4WAS47o3QpfmOke2xpGLZfyDbiT0CieGkhkzxhe61TotTL7AD8mreMYq
	HTEN56Z6vUMHT2BLr99RuRYO1EnMqrqzou3Z03BS6eagikWpK+39NmS91vffhHdpgn7tYUgaYEB
	edJwiqFajgUtgsiFDaFM9+reZlDGtV/ZTEdFauIjrDkL/3WksFSj3ixQZQNwi1PcCP/4vZeLWTa
	+f1g8nKP7J1Ycz8T70vP32vLev5C5+P18Iz+27Zs8pzKYS8YmqtTK/TSdtqNMrBn6HES6Drmt+3
	3BkrWjWqGyUh+VkXUSfU36q6hyOSkWG+8vlip1CtuiwZoswTE5pMehbC3M789sW27kn0QQKv9yI
	rKGzEpWXC19ghPS5PvevRwIr4hmP7/4RtdtFOW5fKS5SCJ/j0czHgUfVHk1Es9jcgsSigjHAj20
	+m1Y2tusGFcV6pZxFYveSpJGzEJhhGQAQ3SUYiTCyEyrrhthjbGDeOqXXY6eRJ38JeTosNfNZ1j
	wnAGbTgdiHSq4V0IAklSizXN8xICqDQ7WvanTZdYDPT6JGTIollFXEnjCxGY3MEvepX0e+3/eaR
	iDbTIADR7OfDC+8sZEPsLeokUG+Bd+lf7zHO/SVWaV1FouOpPGxZQP5wznCRLi6f
X-Received: by 2002:a05:6000:2089:b0:43c:f66e:f31 with SMTP id ffacd0b85a97d-446494ebaf2mr14548292f8f.27.1777471285475;
        Wed, 29 Apr 2026 07:01:25 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00fb2d91b6f941d667.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:fb2d:91b6:f941:d667])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216604sm7038590f8f.10.2026.04.29.07.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:01:24 -0700 (PDT)
Date: Wed, 29 Apr 2026 16:01:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
Message-ID: <afIPMllq5VI-bJLY@mail.gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
 <20260428230844.EFA64C2BCAF@smtp.kernel.org>
 <DI56ZVH6HKDK.1L8J5HPA37J09@gmail.com>
 <DI578ZDDKR6K.QH52KXPV1CLN@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI578ZDDKR6K.QH52KXPV1CLN@gmail.com>

On Wed, Apr 29, 2026 at 02:07:33AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed Apr 29, 2026 at 1:55 AM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Wed Apr 29, 2026 at 1:08 AM CEST, sashiko-bot wrote:
> >> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> >> - [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing verification stats for programs with hidden subprograms.
> >> --
> >>
> >> commit 08128f883e58301e0f97b1d4a94656be63b8f790
> >> Author: Paul Chaignon <paul.chaignon@gmail.com>
> >>
> >> bpf: Print breakdown of insns processed by subprogs
> >>
> >> This patch tracks the number of instructions processed by each global
> >> function (subprog) during BPF verification. It then reports this
> >> breakdown in the verifier logs under BPF_LOG_STATS.
> >>
> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >>> index 03f9e16c2abe..b48389b48eb6 100644
> >>> --- a/kernel/bpf/verifier.c
> >>> +++ b/kernel/bpf/verifier.c
> >>
> >> [ ... ]
> >>
> >>> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_verifier_env *env)
> >>>  				verbose(env, "+");
> >>>  		}
> >>>  		verbose(env, "\n");
> >>> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed);
> >>> +		for (i = 1; i < env->subprog_cnt; i++) {
> >>> +			if (!bpf_subprog_is_global(env, i))
> >>
> >> Could this introduce a regression due to an out-of-bounds read on the
> >> func_info_aux array if there are hidden subprograms?
> >>
> >> At load time, if BTF is present, env->prog->aux->func_info_aux is allocated
> >> with exactly func_info_cnt elements, and env->subprog_cnt initially matches
> >> func_info_cnt.
> >>
> >> During verification, if a feature like bpf_throw is used without an explicit
> >> callback, add_hidden_subprog() is called which increments env->subprog_cnt
> >> but does not resize the func_info_aux array.
> >>
> >> Since this loop iterates up to the updated env->subprog_cnt, when i reaches
> >> the index of a hidden subprogram, bpf_subprog_is_global() will access
> >> aux[i].linkage where i >= func_info_cnt:
> >>
> >> kernel/bpf/verifier.c:bpf_subprog_is_global() {
> >> 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
> >>
> >> 	return aux && aux[subprog].linkage == BTF_FUNC_GLOBAL;
> >> }
> >>
> >> Is it possible to skip hidden subprograms here, or limit the check to
> >> func_info_cnt?
> >
> > Don't see it happening, since hidden subprogs never get verified, so we won't
> > invoke bpf_subprog_is_global() with such a subprog index.
> 
> Ah, no, stupid me. We get here after fixing up and adding the hidden subprog. So
> we can still do OOB since subprog_cnt includes the hidden_subprog_cnt. How about
> the following as a fix? I checked over other places where we iterate over all of
> the subprogs and those look fine, so instead of changing bpf_subprog_is_global()
> we can adjust this function to only consider real subprogs. Didn't compile test.

That's a nice find! I also doubted it initially as we have that pattern
everywhere.

It looks like this would be a fix for commit 335d1c5b5452 ("bpf:
Implement support for adding hidden subprogs") (or technically, the next
commit as 335d1c5b5452 didn't have any user). So maybe I can resend as a
first patch (with you as a co-author) and the following diff (took the
opportunity to simplify the logic on the assumption that we always have
the main "subprog").

Not sure if it would need to be sent to bpf instead of bpf-next. Maybe
keep the patchset on bpf-next, but add "Cc: stable@vger.kernel.org"?

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03f9e16c2abe..8dfe7da76258 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18274,19 +18274,15 @@ static int do_check_main(struct bpf_verifier_env *env)
 
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
-       int i;
+       /* Skip over hidden subprogs which are not verified. */
+       int i, subprog_cnt = env->subprog_cnt - env->hidden_subprog_cnt;
 
        if (env->log.level & BPF_LOG_STATS) {
                verbose(env, "verification time %lld usec\n",
                        div_u64(env->verification_time, 1000));
-               verbose(env, "stack depth ");
-               for (i = 0; i < env->subprog_cnt; i++) {
-                       u32 depth = env->subprog_info[i].stack_depth;
-
-                       verbose(env, "%d", depth);
-                       if (i + 1 < env->subprog_cnt)
-                               verbose(env, "+");
-               }
+               verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
+               for (i = 1; i < subprog_cnt; i++)
+                       verbose(env, "+%d", env->subprog_info[i].stack_depth);
                verbose(env, "\n");
        }
        verbose(env, "processed %d insns (limit %d) max_states_per_insn %d "

