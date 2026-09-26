Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9CC7478
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412548; cv=none; b=BqDCH/KxkH7JdpQeYV7QEt+daOn0IXsC+LGxEgz6BPCrlRg/oa8/wYrKA7gMrR6ZoXBt36jS2Ow/S9A/BD40WZ8/1N7fKScfKlfW0CjVODczJw6VWkxFigw+sN2wEoo41UdrLsurkLknwMO08Aw9qizQN1Ieo8oMCMIU7rpHUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412548; c=relaxed/simple;
	bh=lBjXGzkTGnu/5mpxiIppENfxlG/iScmtzz62e35CY0Y=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Y5UCcxXEntKHLcG1Vc8o9iEP6kGWiOItb9LpGmemdRwDi9cnETL26dVE2twCsPca071zaqdNEaGRDCpn57tYqBop6rmKbDLeg98F3gqQ92hN4FXPO1mnO6D19NUaWPXPatNQiWOE+9g355LJGlegavM4SUH1R5iCtHllbF65xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVZFdG4g; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVZFdG4g"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so1264011a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412547; x=1791017347; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oyti+Vs9dId6SbMoKuguljbuMUb5LEKYIFbEAjltQ20=;
        b=NVZFdG4gLDORLJBaTbt4ZxgRbDjV+ZzZncuxFNwqrv7meuhkl6kMLLMnkSkdS+yUER
         VaBNEss6aw2geUcRrUTfM/p4/wBKTLJYsFAPTE8Syi7CWLNwNKar2MOMfpNyWW3xJyNa
         Fg9OTxfEK29lcADw05nPt/RXcG4VwLck6SBN4ua0SwDYohQZpfEjdAxGZelR/D9jRsLd
         MVGeE+t4uxM2wOsZA6KiMZNxHIRUb/dTO9Ws+L1idAZ20TLiiQFvQpEVrEeyLFr6WPv1
         dhiZ4M1LJy3zOYZnKKPGPokzAAaNI0Z4/CG3Pf7n7JrRfLOfpOt0NK+mf970dDwGA5qt
         g1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412547; x=1791017347;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oyti+Vs9dId6SbMoKuguljbuMUb5LEKYIFbEAjltQ20=;
        b=nwaffdAXnlWmcsMVddtFk4MjMyJKJItb80SpCd7kFqJyNYY20KUsGX0vGpecQcc+s9
         FAsa93L30k3dF6sIXhuuQo4zwzUwXksgkSVXdy6FPbnaXrN0lyUbP5kE0mowWaCoGA11
         5o3JhVQQklUlcMvx1Yi0WmAmvq8nYDNM+G3vU8El9mxI/GQmsQnrCw0W/Kb+LOkpmBG2
         BoV8fYmJEFIT+mVA5nLcNkDgQruJxl3L5IqgxVoaixmbIpdj4dPIRHgsJgmLpKiKYJFN
         tYx8RlobD6f4SaOAkaaB6NercoO6uD1PC9qlG4YsUB9DTYQqbwQkm3dg7Go9FmdKr8vo
         yzxQ==
X-Forwarded-Encrypted: i=1; AKwUvBygM3i5kFkUZYheD2GwpGhwbZc2/dYKXyLzKkcy/UaX4d6upON/FDMuAMJCRacjZ1zC1rM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0G2cEL435IWS0we5VL5S3dzd/0zXj4zslidpApdK/+A5Uv3BM
	XbE9eky07BQ4AVE5hs3aWASZ4oFnFK5FHIUabkkUn/6GS2eaOaNe4LU3
X-Gm-Gg: AYBFou0MPc/f41YbWCYURLQpAZU43sDjafJ0ynYRLaMa45qYFHw8CpB4xYbC6B5yZ9y
	btfYkcg4K4+2FzCCwVDLNxNLvENJ5crYi/awxGReOL3Jl6xGc8EmP1kCpXmot1SRWk21vyRLGD2
	SZ9UIg7d9Z4mvU+NiRtuSUU1SSeM6b/HDWMk0ndxj+s0VowwwGH0Ph3+zZA3GPLdPMwveqmNBuZ
	zK49mnStMH/fUIBp/2kV35CVYeDcVt+zJZz4yav1IttGO3MaJ+Zv/vOUn/pzdt/7xaLmsnY720R
	G0cMBICL1nRVqqa50KpKhHejvOStKmlxO46gk00reU2s2h+JDpkwdCPtNKBEEq+PH3TeLt5yJ4/
	7sm6++7k6AlBDr0lC5joTknYqGnbptsUVhsuUym6QF9IKSTn5QNw0guIJJs4qeJ1T7o3kBNgxs7
	NB0gf0LY5VL/Y58TKvpV3n5FHZDkSvLxFGRLKOxLk2QUrhHZEYg5N8++oUkq41XMXQxt+Q13cIi
	Jgqu/0H/uWs1lhuw/xQGbYYwzBBTK/721CPKC4HwqFcFVs49Vix+otp+tydvNtSz1eZAPmQr2kJ
	nM4H
X-Received: by 2002:a17:90b:3c8b:b0:39d:f064:3a68 with SMTP id 98e67ed59e1d1-3a0bb57874fmr3608063a91.21.1790412546709;
        Sat, 26 Sep 2026 01:49:06 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm14754502a91.8.2026.09.26.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 01:49:04 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 08:49:03 +0000
Message-Id: <DLP49ZWG2U69.HDSWP7IVT0YC@gmail.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 10/12] bpf: Track packet changes in call
 metadata
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <20260925211256.1834061-11-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com> <20260925211256.1834061-11-ameryhung@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 02:12 PM Amery Hung <ameryhung@gmail.com> wrote:
> @@ -10970,11 +10971,12 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
>  			      set_callee_state_fn set_callee_state_cb)
>  {
>  	struct bpf_verifier_state *state = env->cur_state, *callback_state;
> +	struct bpf_call_arg_meta meta;
>  	struct bpf_func_state *caller, *callee;
>  	int err;
>
>  	caller = state->frame[state->curframe];
> -	err = btf_check_subprog_call(env, subprog, caller->regs);
> +	err = btf_check_subprog_call(env, subprog, caller->regs, &meta);

Nothing reads this meta. Same in check_func_callx().
The only place that needs pkt_changed in meta is the subprog
pkt pointer check that the next patch adds to check_func_arg().

can btf_check_func_arg_match() keep its local meta and set
meta.pkt_changed = sub->changes_pkt_data there?
Then check_func_call() keeps reading subprog_info[subprog] and
helper and kfunc paths don't need to change.
