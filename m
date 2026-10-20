Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526676;
	b=slsVxffO03dbjDChMsGKC223n2CGnrigIgK4u2Pnur3vfoBERz04zbebMRBOpP4ec/14
	 R381sTyr2CAZydXR2H+ZothVjDhHQuFbpbdSWKb6gxv/Y12QlJkyOolexYvluoURRONSG
	 T/9LJxKzHNlsXGXgdVjuzpb5KXVj87kSNqsvDGLHF2PNMMj/n1GArUpffPtfvy7+NcBwq
	 VdfAhC63GIsb38BTqTkhnQRHcc4EBIuGNhREAHN42R4yPdO+Zr0PdacojZ+Yn7IadJuaE
	 7m87sFDGsMfOChDPluSMxsLOXEJRYhDlte2a6+zgSUX5iOhTIe71lmM2YP/XyZok1mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=m18DMiyB+7VTcut54fI0anXX4tAmR8j+EXZ+9qn1WDU=;
	b=ZmyLfxvMjvCxOTpf+PQEhP/KN5C/tXFr6T/ej2lKf7dBOuUHAXDYXjiibK9Y9hto/ghv
	 0Da5hbGmOMxB0PQ23+wYjncSkjQ9tTBJm/P0yeaGvtnjBXR0ssFYwdtuXmz+VndMZLhGJ
	 +1ENcRt17hmAQ0bkWuKGutSVg7bvCWYmpfIHgGv15htKkhG8/8I0N1q+DlOtuvdlxq+ga
	 M52QHK/l8FOxCbDS8B4eSGJY0oemC3SOTtoGVOI3/j1n45N1mylAOn7DJLkYZc0uh0cWv
	 gX4/RtiNXAu8K9U4IBxJQzVHRV4vYl/SiPgLns2F961RyGPYQRsS/qmoQ03BUwJjZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRZtBkwX;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73493606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 20:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73493606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pRZtBkwX
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e946155442so29134155ad.3
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526676; x=1793131476; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m18DMiyB+7VTcut54fI0anXX4tAmR8j+EXZ+9qn1WDU=;
        b=pRZtBkwX/GLj69biQFthVUDcY0Bh9+Or+AyyzplcVjUoudL32uRxJ46ytob/wWKQFO
         l/PBO29IoB2s3yZbdCFDyYZoG7NFrdHOBgZq9e7JgvBlkqixV+pRAwaU/ZVP8BYvt3Xi
         X/RBn0fmseD5EuTx818RkmMK5OzIKQYGB4eIyDi9Tioie+NLYm5PCo2Ma6tLSOIO1J1u
         O6q3i/oPuGApiAbP06RQ3AGgyJ8ZRyaI4JmlUPxjtUtWs49+42h2uqC5Sa4K+Zx+ktk0
         UQsF/19coCewWbAlDUZ0p3wdBU9l7peSEBo4fsvNVNuq/FXo9XPzBPTrulRIZu8Dtbi3
         vHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526676; x=1793131476;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m18DMiyB+7VTcut54fI0anXX4tAmR8j+EXZ+9qn1WDU=;
        b=ifliGssUTE9pEchsGpc4lNSVUF6cz0+3rItQCHglZ0saHrC58SbUMxy9UFZOIO1cxq
         NDmNEj7LiFcCE83totjCAG11bWsrHSOkesNp987diYvJClRkiKDGdOsbxEEdTvuFcwhu
         CUpTWGGyJ+OMnnYzHV06ngMiXer1Q5WWozLn0zujQoLsv6kArJAnPV9wo6eJisPumqlS
         Gkg8WmVPJB+uMdbULlIQdc7JQVy3NGSPRHwZ1Ziw5ypmr2eEE6IMvwMD+eZbGFEQb1Y8
         0G+6j+KfdUTlbmzh6juUBw34x1jMzim62/NSheLKf/+v0hwLgMIQBdwmXmS0FeIO/WB8
         HBQg==
X-Forwarded-Encrypted: i=1; AKwUvByczqIm17CrPXfFlLpIdyzJwXlUh39ctWtI5TR9M5zJwQxaf0+v6IlPXlj1oxW8iA7Bdh0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsLe3O17Rr0YynfzUuoNoCvzf9wRc2xwOd6rWj3JLztsx++TJx
	fjNYcUqGL9Go3fnfhdyCY+UHgFa+9r1sH6Ik3F5P0OTXSP0Uj+dqlyixzi3irA==
X-Gm-Gg: AYBFou2wV2wtEq7o5xFBBqYuPbrYYFWqz4hL47rA4rPjgvP+FgrNwLEG+C0jEjLeElD
	qNhpEhgUflhPzk92Vfq76n77gMffiLHQx87u/3W1dFHM+pCqRihJ8a3S5vCU4HdGbowex9szYdO
	AKrasBCknrC9b49/0lGI4RGTgd91JWcA31ZUXiw34YHpxx6X5VoG5yu9PgLd4nTOFte5RFYSFNP
	WLCP1jyKPR4r/g/wNGEjuIC3jRCWHTmYIlE7Eycp2DorgKuYx2V86zu/ayowRdWbfd7PMPc3bq1
	tP2lmrZtDoDdf4P2tvPrU+m1SSE4QcnN5YiwYWs0WlUcLMjSHipmyrpy8XfNUumBqGWqwnxdT/S
	s3lWGWx5ub5yDTA6MtHBhyD1DSD9gQbiIEbpJKvrhKDejNxfA5UyiKeG7mQD7cdKMceB5sg8G7I
	fXbeTq1rGhUhn3tneqlKOBxrLyUr3Oqs77IywCQSy84c7hQz7YKjnN668/KQAuJrOAcMUJ+KHbO
	kVJLbBol6QkrpJ/mx1JSjzMUDmxxDmQj5gnvA3gFf/it+RL69O24uWsLiYKV93YI/we7bwEutbN
	zJ3zNlxUHkvxe3QjeTCAJMvBPb/6K8b9wXaLIuGH9kcBeUeqqygChLbl1vXunICcPbjtZocqWi+
	cI8NEtg==
X-Received: by 2002:a17:90b:574d:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3ad86f05a40mr1417a91.26.1792526675585;
        Tue, 20 Oct 2026 13:04:35 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad813de463sm808246a91.13.2026.10.20.13.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 13:04:33 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 20:04:32 +0000
Message-Id: <DM9XO98ZA7UV.2V9PDC4868WI9@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/6] bpf: Add unwind_goto and unwind_exit
 insns
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-179499@kernel.org>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com> <20261020181320.1284798-2-alexei.starovoitov@gmail.com> <sashiko-outbox-179499@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Oct 20, 2026 at 11:57 AM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +			if (!aux_data[i + 1].seen) {
>> +				memcpy(insn + 1, &trap, sizeof(trap));
>> +				aux_data[i + 1].seen = env->pass_cnt;
>> +			}
>
> [Severity: High]
> When bpf_opt_hard_wire_dead_code_branches() overwrites insn + 1 with trap and
> marks aux_data[i + 1].seen = env->pass_cnt, could stale flags in
> aux_data[i + 1] corrupt the trap instruction or trigger a verifier bug?

No. That verifier_bug_if() needs bpf_jit_needs_zext(), and it's false
on x86-64 and arm64, the only JITs with bpf_jit_supports_unwind().
needs_zext and arena_scalar need an arena, and arena needs CAP_PERFMON.
Then bypass_spec_v1 is true, there is no speculative walk of i + 1,
and they cannot be set on an insn that wasn't seen.

> Also, what happens if the call and unwind_goto at insn i are themselves in
> dead code (!aux_data[i].seen), but jump to a shared landing pad that was
> reached from another call (aux_data[i + 1 + insn->off].seen)? Because
> aux_data[i].seen is not checked here, insn + 1 is overwritten with trap and
> marked seen, so bpf_opt_remove_dead_code() removes the dead call and
> unwind_goto while leaving an orphaned goto pc-1 in the program (and any
> later live conditional jump with untaken target i + 1 can no longer see
> !aux_data[i + 1].seen).
>
> Should this check aux_data[i].seen before handling unwind_goto, and clear
> zext_dst, needs_zext, and arena_scalar on aux_data[i + 1] when writing trap?

Not a bug. It's one extra 'goto pc-1' that nothing can reach. A live
cond jump to it is never taken, otherwise i + 1 would have been seen.

>> +	if (!bpf_jit_supports_unwind()) {
>> +		verbose(env, "JIT does not support unwinding\n");
>> +		return -ENOTSUPP;
>> +	}
>
> [Severity: Medium]
> Should check_unwind_insns() also reject programs when
> !env->prog->jit_requested or bpf_prog_is_offloaded(env->prog->aux)?

yeah. Only netdevsim gets there, nfp rejects the opcode in
nfp_verify_insn(), and nothing runs such a prog, so it's just a wrong
xlated dump. Will reject offloaded progs in check_unwind_insns() in v5.

> Similarly, when CONFIG_BPF_JIT_ALWAYS_ON is disabled and bpf_jit_enable is 0,
> checking !env->prog->jit_requested in check_unwind_insns() (like
> require_callx_jit() does) would reject unwinding before passes such as
> bpf_compute_subprog_ret_regs() that gate on env->prog->jit_requested.

Not a bug. jit_required is set, so bpf_fixup_call_args() rejects the
prog at the end of verification. It's only a matter of when.
