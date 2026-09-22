Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A157730C160
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037005; cv=none; b=TrS8i8u9UUCEGeLZsZh8WeuIPTK23k0LvLDTmjEWMgfcUpTlDTdzs0FjTi8NV7p7anOmZpwyqt24Fp/Shd4VNOnPvn7y9QsT7fraynNfI2Sgj7W1CpkHfjVbx4ZiiJGIBIRr98UuLC0yCv2kGrw57Dw8tctlKzheKbIYA3drlIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037005; c=relaxed/simple;
	bh=fDabBSaxU4FAj5vTrZUw/8EtvOnA8fMJYStl8JuXKgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEcdQ3Z42/Fv7zvyjcJJsxm9V2JdClYYaZ6+Lc0CelzpV5o87Tq72IQOAyfAhoKYS/lHm9aShZpPTWbS1WBXVgyr0zEfnWfEYM5J5p8p9MUiBppi2vRubT7L3PPtX8ucvYtCLyIhWA3/lV8b0PHCgt0+ZDgrgNW/CiOY5mLK4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnZh2dK1; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnZh2dK1"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so23102105ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037004; x=1790641804; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1v2q6PdkKqR6s/y8BGqiNMp6mqYxFHwdTjmKZuHqhZg=;
        b=nnZh2dK1Q2ony0ktLfnlfJ/U7pmrfPMgeTYvUFbRyJpvyBMvhrx5P7meTll+n8IQsI
         9cTM2rXwXhU76BmPY5dujLEbfhA6jB5Zu2HenubxwEOGJAAOtEuWsiEXDxbMwZZLjxkg
         bz1hj6OOZeJsNHejwihonjciftMlwb2Hc3oTw0SCyO3BhDO/vr1BxeRPGGyORwZ03Enr
         aiWQcxG4fv7pGDhHbbvLYRsdEcrnfuYgWBtQsXzr6koZfrZdRxYAgELztkfKOO7ZsQQ8
         ySDF3UH9y9BHcPxHwlWfcVrbeOuJmQqO7wCtLkxn/lqfFCf2/NQ1WKrDrFprB2Jf+W2b
         3Zzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037004; x=1790641804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1v2q6PdkKqR6s/y8BGqiNMp6mqYxFHwdTjmKZuHqhZg=;
        b=BQeV8jsL6IFEHlJ69vdy+fii68FeXQgbnKV0yNy5k7f8KJ+29c06ehfCUD3bDd7rFI
         VJHnNhqhjHiL/8KJ6rIPu/IA/8XW1YNPlMWws6Cj5rKOHMaCOXT3GE1qAGpMv6nOnqRF
         fGcX4RDx3RdkPVwLS5K3P0U/dSWEXn/ZXvecrIpyqJrpj18dyohTyHB60TphhOzs9BPs
         op1+OXZKestn20ZFiqTwt/vNzGBC4g6Hfucbfd2qiX8YcP6FsFhUWn6WB5PYGoWH2M+R
         lgVexDvx3YHUJk6ngZMsEwb7ZqDiO/s2E0NZ4DDgIWVT6Nma8DcSf4L7aHf/7yILQL5Y
         cJ0A==
X-Forwarded-Encrypted: i=1; AKwUvBzBo6BFL8+ZGN13x4j7ol8323SYBISR+wGWdYuTHj3nne0i5UMZ9N3fz3qWpRB0WoKTZ9c=@vger.kernel.org
X-Gm-Message-State: AFuF++nuPBnSntOsgd7e2jjNeD9XtrlgbOOrSXlAdHVfqdPgu0Nibhtr
	2ub2c4cNNNY4w5vzS9BtxSos4sDC+L3aub7rbIbIvBjh1Cf8L1q9h1qofNZBCJhY
X-Gm-Gg: AYBFou3Hx4J9OZ6iFyJtxdrASdW/bLcY6a1kS2H0ltLH1z/Xx0r8NH+28vSgK8X0nZo
	Q8Khle2h0hy/Dtc6gjMwigKAx1amUlQs9+9yLPn/wM9GnGVqftJX91xRqyg/Db8K2fBKFXyhbn+
	L5O/F1C7Fn5h1XyW8W6Z1LpnQmEVzowBbGXr1cB8ulcLIIVg1JS+adg9ToK82hOjUCClE7TGXxX
	n3YVcbyCObFpX524mvcY6C1JwCkRGfcUhSxrLMaRZ+bkRqIxfCHsFbASd0ouw3/CbWS/xlDQO+p
	s1s9e0ntB274NZB00tvasA3mLsgbwLxSsUytwrNRiqJSNTzOkGKkAd0Uv5MH0SdCD/iaELhoAC+
	10u/97d57Q2ii+Yzdr6EDq74d5dT/a3bdmbhPfeCJmAR/iAYx1UQuW8CDO7r19IyuRkGSp/rkKs
	/ie1ZxRbwhgPQA9lmPzaveEW41w6YPomfIAzVLq8SVk9AhMgUU8RkE3hKQgkBBNAFuRT9NbM1+a
	wbzG1zPdsWgSH0eBwvrRDOA4nH5g7SDCHHB363wOLZblcLjnzwtAjYxvg==
X-Received: by 2002:a17:903:390d:b0:2dd:ad73:c98a with SMTP id d9443c01a7336-2ddb1bd6f42mr171555485ad.34.1790037003770;
        Mon, 21 Sep 2026 17:30:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9de9:26b9:a969:69d7? ([2620:10d:c090:500::5:f95e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6127001dsm601552eec.5.2026.09.21.17.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:30:03 -0700 (PDT)
Message-ID: <d87ccb2d98acc167a80ce894a844abb29ee433a9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 21 Sep 2026 17:30:01 -0700
In-Reply-To: <20260921210109.1719713-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <20260921210109.1719713-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-21 at 14:01 -0700, Yonghong Song wrote:
> The table is on the instructions and the landing pads are in the control
> flow graph. What is left before bpf_throw() can be taught to dispatch the=
m
> is to work out what that walk will need, and refuse the shapes it could n=
ot
> handle.
>=20
> bpf_check_cleanup_exceptions() runs after bpf_check_cfg(). Everything it
> needs is control flow, so it reads what that walk has already worked out
> rather than working it out again:
>=20
>   subprog_info.might_throw   which subprograms an exception may leave,
>                              closed over the call graph by
>                              merge_callee_effects() as the walk pops each
>                              callee
>   cleanup_reachability()     what each instruction can reach -- a resume,=
 a
>                              plain exit, a throw, an indirect jump
>   cleanup_mark_pad_bodies()  which instructions only ever run with an
>                              exception already in flight
>=20
> What it refuses:
>=20
>   - a pad that reaches both a resume and a plain exit, or neither: nothin=
g
>     says whether it is a cleanup pad or a catch pad
>   - a catch pad, which ends in a plain exit: the walker calls a pad as a
>     subroutine and cannot hand a frame back its own execution
>   - a throw in a pad, or a call from a pad to a subprogram that can throw=
:
>     a second unwind over frames the first is still discarding
>   - a bpf_unwind_resume() outside a pad body
>   - a subprogram that may unwind used as a helper callback: the helper's
>     own kernel frame would end the walk before it found a boundary
>   - a tail call, an indirect jump, or an outgoing on-stack call argument =
in
>     a pad body, all of which touch a stack the pad does not own
>   - a BPF_LD_[ABS|IND] in a pad body: a failed load leaves the subprogram
>     through the hidden exit gen_ld_abs() patches in, and an exit in a pad
>     is the epilogue, which pops off the walker's stack and returns throug=
h
>     the frame the walk is discarding
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Why is it necessary to hand-roll a CFG traversal and a separate pass
for this check? Given that bpf verifier state already maintains
`unwinding' flag, the instructions properties can be checked from
do_check_insn(), e.g.:
- bpf_throw()               -- reject if unwinding
- call to a throwing global -- reject if unwinding
- bpf_unwind_resume()       -- require unwinding and the pad-owning frame
- BPF_EXIT                  -- reject in the pad-owning frame, allow in cal=
lees
- LD_{ABS,IND}              -- reject if unwinding

I think that would take much less code, wdyt?

>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/exception.c       | 404 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/exception.h       |   2 +
>  kernel/bpf/fixups.c          |   1 +
>  kernel/bpf/verifier.c        |   8 +
>  5 files changed, 416 insertions(+)

...
