Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A43F4DE2
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449833; cv=none; b=pGg3O9fiQD2fLa0IoT3kz3Y30HfZKX+iy9Kpu9X/Kt+ePNB0T1tNY74m7ZU/4uWd/NpOaLWkQmKErNzPcjQf9hY0tSp3clU5TAU2MHIhan8FErpukrDyO4afvzEnUOoosUQVvTU7h3P6AgQauzjwB6FSeYDRhp6hP+WC7pI65cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449833; c=relaxed/simple;
	bh=i2KUcWLAGDSGOXHvbDehNsc8JJV9P52vnf2Y98TLJG4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QoPevecLtiUvVrGxMncClkirfiJBN+Cbk5X3ECzE6HhKeOp6kI0cwYtT2W6mfN1mtJ/fesKsFUOFhHj49+Jzngnn0Zle1jZZCt5Fd4pTc83H0EsjuaQZOdr8egKJLahq1lgMEpcT1KK3jZXuZ280wAtjfY4L+sSme8aCb7xbxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etrb91xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etrb91xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241461F000FF;
	Thu,  8 Oct 2026 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791449829;
	bh=soaaNZVfAZEFj5MW8f17yidfI6BLpJhwEVKzexIbCUE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=etrb91xuoR0E5WWqY/9Dp7PHLe6lP2JEhzjgCc4Xa0qYbW05CTdvJgWoahAnRKXfs
	 Q9HbKuHkJjeFFNB5pdVx/9Yneo5u9iSKWdpOhaU4BcmdRh3KaqIlt+YOzJgFny0zFZ
	 Ocb/3qbpjyVZHuqa+QzqF4DikjoX47bnMcFzs6bahCUmsLR19sRyt+R/BD6vqTy+Nq
	 3NRbl+y5Vlnh337eWf4MOOxg1tlZxp+YbHokD+l1isdL3TdsvSaj3QwU8oQYIJOopa
	 xD9sNIjO9R+AgRQXedYwuSa8O2Nuc9NgLrhxiG1R3MdABoTo/SxE6WLMQNlszW3Tmr
	 SMYoxp+ZkKNtg==
Content-Type: multipart/mixed; boundary="===============7281663702417711310=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14b2036055b5d1e4aa4d8fb77308eece081ef7326ef7afe208f7bd0ff3092136@mail.kernel.org>
In-Reply-To: <20261008075040.2999036-1-yonghong.song@linux.dev>
References: <20261008075040.2999036-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v9 08/23] bpf: Refuse a landing pad that does not resume
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 08:57:08 +0000 (UTC)

--===============7281663702417711310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse a landing pad that does not resume

TL;DR: Commit message only: the patch also makes push_callback_call() reject
callback subprogs that may unwind, even without a cleanup table, but the
message doesn't mention it. Mention it or split it out?

>     bpf: Refuse a landing pad that does not resume
>
>     A cleanup pad runs drop glue and calls bpf_unwind_resume(), so its frame
>     returns and the unwind goes on. A catch pad carries on in its frame
>     instead. Only the first is supported: bpf_unwind() rewrites every frame's
>     return address in one pass, so a catch pad's caller would still resume
>     at a pad.
>
>     Nothing in the record says which kind a pad is, but the code does: a
>     cleanup pad reaches _Unwind_Resume, a catch pad a return. So the unwind
>     marks the frame whose pad it enters, and refuses in the marked code:
>
>       refused                                  where
>       ---------------------------------------  ----------------------------
>       an exit: how a catch pad ends            the pad's own frame
>       a tail call, a BPF_LD_[ABS|IND]: it      the pad's own frame
>         leaves through an exit on a failed
>         load
>       an indirect jump: nothing a compiler     the pad's own frame
>         frontend emits in a pad needs one
>       a bpf_unwind(), a call to a global       the pad and its callees
>         subprog that might_unwind
>       a bpf_unwind_resume() outside a pad      any program
>
>     The first three are refused only in the pad's own frame: a subprog the
>     pad calls may do them and still come back.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

The patch also adds a refusal that this table does not list.
push_callback_call() now calls bpf_exc_check_callback(), which returns
-EINVAL for any callback subprog with might_unwind set:

  verbose(env, "subprog %d may unwind and is used as a callback\n", subprog);

This check is not about landing pads, and it is not gated on
env->cleanup_info_cnt.  might_unwind is set for any bpf_unwind() call, so
it also applies to programs with no cleanup table.  Later in the series,
bpf_prog_may_unwind() makes that case reachable.

The restriction looks needed, since bpf_unwind_rewrite() stops walking at the
helper frame between a callback and its caller, while the verifier would model
the unwind continuing into the caller's frames.

Could the commit message mention this restriction and the reason for it, or
could the callback check go into its own patch?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37747693645
--===============7281663702417711310==--
