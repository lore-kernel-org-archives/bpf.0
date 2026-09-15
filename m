Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71905286AC
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430688; cv=none; b=uS+N5LrnJTvopXVmOfcP8BwbzhyzkImNO7mrXAPWLirlACcVtjupwzOM57aXgYy6xd+WWML+69nhhQpipreBdxwn77cXbF7tlWf+ZloQwBLbVqRljkHeTacFyPTZUSxOg1woOcUEZQ4qmWUO9+SbhVgWCvkiAPpg/3uihBbQlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430688; c=relaxed/simple;
	bh=Ws+mH+ru9MKLvPRNEFCxVmuayyFwiV2nHX38Mr+/Tic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inJ/7EtXX9PAWjA0ikxGILvIMlQ3rMR0tjKpKEpP3O5y0UM/uRcURyWtvI0o7Fk8LfKT7pm7ePNoeg9Qk7RQgI8k6wdd8MFhEVSLDel1y2YbnpwBBF3lDBvEsMwP6vdu+DjqpKaYFolI0SyK2kT/L7A8xYe3fgYjt7Am2IAopSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6Pl6oY/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Pl6oY/"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso2724568a91.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789430687; x=1790035487; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aEKBrAOj0hFnPBRYer3OT5A75zFLT/g/x+XvnxWj8Hw=;
        b=P6Pl6oY/fUvlz7WO2Cggw3L0JEsO8VPPWGwevTw6yaTLkX957QExHxnlYJVUzfcDdy
         /7/kRvPzB4rsHOUEIoBqqyHwEaRMbNR4LWsmLxU7K16DEFxm7gpPnLzbsLEa0bvcrbRv
         Oh0ncehw48p9HK9BsQTRPNb0e81TfDHePgcNOrJYxwgVLReDmePtYwBi7JwJCoCubyv8
         hI2uQhtIm6w+FCFQEUFlGt+yJ7etjqN+IeNi4nqdUVN97/WmqsqMnVDa17RE6LedM6Rd
         H5gh9/uoZoesoTrIaKoXnt26ajyN9L3zhOfJknq9kt2BBlCq3uJ8de+5U5hDndMIEDYd
         ybOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789430687; x=1790035487;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEKBrAOj0hFnPBRYer3OT5A75zFLT/g/x+XvnxWj8Hw=;
        b=QvYTqQ3q3h9bnzJim+FjUHAc6SCFSN5CJzKyZQvN8OgL/Jgr1uZj1O5VlaTd9apYBz
         a+BJJQqBuzOazVMVgYwVKiYheju/Fr5WliwbSYsvOYiCYuMIENvnBJqGjwNFmSxgqSFR
         gCfFWwMeXFmML2Jf931pTziDjswUg6pketWiHV/iT17fvrwrduy92J7zSb5Cu/vRMdyy
         i0rCxcxKPbiQeTJGBIqbxCNEylYnv07FFR+MV50wcOnVjMqV4LUA84gxZ49EQYdlEjdR
         SyUqcQw0H6n0Mv9t/YibSSwI2aq8xk6YdFflhkCLfaqB6wRyWr7/7cWfGvgFaikoKnJt
         O/Qg==
X-Forwarded-Encrypted: i=1; AKwUvBzjrt8I4Jenwml3OIAtWwZd5FLMrI8z5vofrY7KK8ismTuy57dbqtF9lVj3pT183Wh1BiA=@vger.kernel.org
X-Gm-Message-State: AFuF++kxkYhF0OylfL6EjT+YrKiMD+yznNo5fa+DACdJ4NaeK8bvP3Cv
	Qnokfy8hzoCcw534SHwtKlNWXjf2AX186E+HQdoIEWjZt31G1Wu4+UAj
X-Gm-Gg: AYBFou2esL3lRcIJk/IVsW6At65vHbCd+6uiVAS+F+3ei+RKu/KKLNuK1jYmKozfZTb
	H/Vmwb6oQvtwfTVKF+A+De40GTmU//g5fvh3koV5N51tf5PNxVvKXWoPfAxg6lT/WrECC61Vd6t
	IB3cqPRk8vNTyCPVHKgJvYA/vleF8XpXVnwV8fE+BpWFdng05HY0AlumnqsB9nQZ5rc7+DvrLLT
	94yQ7873LZe+njjhI/hnlM4CaW3Sz0ZOYkElWtz6TM9PItyGGQnHC4e7lR91k5+1gkRWWv+dl6m
	iS/YpQF1fyMd2W20ACMxbqLI63qASMfEaepuyjPgSzk2g5GT0viXv2dyWLuQz1A1BCqVhG7r84x
	0XSYAoS4Q2ol7eo9EyAoTh561ds0bJAaYMmk2rl3Zfq3Y+ke6JZ2DMBCQea9AnqG4rgVxp4H7f6
	OoZICV5QULRVgF/jdr9OjsoOfRzcRptmL6qIPSd/T60Y0PCuA2fFUUZEXkn8UpruadnGxeZGyW/
	534/FdBGQZx/TRld+aMhzEluFHJkCBGmJk5kQ==
X-Received: by 2002:a17:90a:e7d2:b0:39b:92bb:9ef0 with SMTP id 98e67ed59e1d1-39dec0bdc60mr8984702a91.20.1789430686561;
        Mon, 14 Sep 2026 17:04:46 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfd9bb4basm1640319a91.3.2026.09.14.17.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 17:04:46 -0700 (PDT)
Message-ID: <25467ac2bef2c5a911ed81b2c9e53276090e90b2.camel@gmail.com>
Subject: Re: [PATCH bpf v2 04/11] bpf: Reject indirect jumps that leave
 their subprogram
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org, James Burton <jamesburton@meta.com>, Nuoqi Gui
	 <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 14 Sep 2026 17:04:42 -0700
In-Reply-To: <20260914170326.249953-5-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-5-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 19:03 +0200, Daniel Borkmann wrote:
> The jump table of a subprog is collected in compute_subprog_jts() from th=
e
> insn_array maps of the program, and a map is attributed to the subprog th=
at
> contains its first entry. check_indirect_jump() instead resolves the targ=
ets
> from the map the gotox register actually points to, bounded only by the
> index range of that register, and never relates them back to the subprog
> of the gotox.
>=20
> The two disagree, so bpf_insn_successors() reports a subset of the edges =
the
> BPF program can take and a gotox can enter a subprog the CFG never walked=
.
>=20
> Close both ends: reject a map that reaches past the subprog holding its
> first entry right when it is collected in compute_subprog_jts(), so that
> every map is confined to one subprog, and confine the resolved targets of
> a gotox to its subprog in check_indirect_jump(). A target inside the
> subprog is then always in the jump table the CFG walked, which is the
> invariant that actually has to hold, and is kept as a verifier_bug_if().
>=20
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Reported-by: James Burton <jamesburton@meta.com>
> Reported-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...

> @@ -18238,6 +18270,29 @@ static int check_indirect_jump(struct bpf_verifi=
er_env *env, struct bpf_insn *in
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0
> +	subprog =3D bpf_find_containing_subprog(env, env->insn_idx);
> +	if (verifier_bug_if(!subprog, env, "no subprog contains insn %d", env->=
insn_idx))
> +		return -EFAULT;
> +	subprog_start =3D subprog->start;
> +	subprog_end =3D (subprog + 1)->start;
> +
> +	jt =3D subprog->jt;
> +	if (verifier_bug_if(!jt, env, "no jump table for insn %d", env->insn_id=
x))
> +		return -EFAULT;
> +
> +	for (i =3D 0; i < n; i++) {
> +		u32 target =3D env->gotox_tmp_buf->items[i];
> +
> +		if (target < subprog_start || target >=3D subprog_end)
> +			return reject_gotox_out_of_subprog(env, target, subprog_start,
> +							=C2=A0=C2=A0 subprog_end);
> +		/* Maps are confined to a subprog, see compute_subprog_jts() */
> +		if (verifier_bug_if(!jt_contains(jt, target), env,
> +				=C2=A0=C2=A0=C2=A0 "insn %d target %u is not in the jump table of it=
s subprog",
> +				=C2=A0=C2=A0=C2=A0 env->insn_idx, target))
> +			return -EFAULT;

Nit: I think this check is redundant, it can be dropped together with
     jt_contains(), moving the above subprog_{start,end} checks out of
     the loop.

> +	}
> +
> =C2=A0	for (i =3D 0; i < n - 1; i++) {
> =C2=A0		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
> =C2=A0		other_branch =3D push_stack(env, env->gotox_tmp_buf->items[i],

...
