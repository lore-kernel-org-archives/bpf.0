Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845BF29993F
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789432882; cv=none; b=Gtye06egqKBI0vclSr6oipCpupHx2o2jb32/qeXAbSQtIQf1A7cDf9YkIO9JvBwjoOSbvMurBo0kCSlAXLE8WmGXJ8RK5evWBIext7/UfYLxHowwyby47G0vysygWByEJsD5dG6mpeGFxhGgWJmEnayGZgBQyTEfQtHUiHng/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789432882; c=relaxed/simple;
	bh=Ryw6/56jVXyZ81+kiWd71Kk8cRt3y/mfFIFogjzXwEg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGqrj/+v4Qu2Wf+Aj7vKsFp4cqm7h0LaWh2q1IWs90NSpWAf5prkGXRafPRFlybK1lACAHwZX59qhoqtmK3aF9SEgkLz1TRD5ZI4HyU09LguN/6AodjYOG7+FPUFx9+Pqo01C65FKeXGKn9KKrZIVckDnJIABgICoRicMscnfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sm9sjh5p; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sm9sjh5p"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3990fe066ebso3168712a91.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789432881; x=1790037681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ryw6/56jVXyZ81+kiWd71Kk8cRt3y/mfFIFogjzXwEg=;
        b=Sm9sjh5p77wm0OnmSvwDJpNB6ANvsOjsw1Fr2clajnzVEL+8bTJk+RFNKgZRnqHhAo
         wnr/QW9eirc58aPlXvDXRRTMuFTfPgJmTtajVA42tS9tSsAbR1HkwfYlbUqZ5mmLafbF
         r6jWt5IxuUsOw1TnPVR3im+dD/SLyH2H1MktFRfneHNUl/Byfg9IWQqbAqkwGIePOAzo
         fQ4x2apFPpV0ltziVxow9Sc0G1YhSpMJhKna2L4Ai6i4A5YmaaXDB1IVsHdl4Ro82ZaA
         RKB7nPvCfWO5A+m1q49htZ8trFpyXE07XLg9FEB4chqitpIgmPdJTLNv1cJEBJu4X7cB
         kxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789432881; x=1790037681;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ryw6/56jVXyZ81+kiWd71Kk8cRt3y/mfFIFogjzXwEg=;
        b=OxwnP0yeKDavartJBV0MNM6JaNa5VRHBUYvo2WDxPDN/GvmqBhVsUuuJadAV+U9IlD
         m2bIzw6Ozbpx1UoRQ09tSC6UJkLu50RI0U6m9xX0Fy2XeBSexpFBHyu6tfiIdGBSVsSe
         F8IEsxo/Qe55S/u/Zls5033PbY1mXUSHNUsSKd7AcL40rVNKYaRhKac6D/aT/Hfry1E8
         RWIuIHHonzj9JMPhrR5FyJpb7wcrFrUWO9tztkqwXFv40AedqdJYApqlsJkpFiTBier4
         0ktM+G68QQwThB4lDfzNMy80zz8fmBrGQ63eD+hhzfJjo9NWDDePEGLQatxHekknxLhb
         noRg==
X-Forwarded-Encrypted: i=1; AKwUvBwQ082wwLH0HOwUu3pdEPGxqa8lIwxZDWljXAfv34mqIJrQWNHGKGRNUa8K0iGAyKHaMg8=@vger.kernel.org
X-Gm-Message-State: AFuF++ndshiM2cmPkcY5HKVDUcTxsAfjmQD7ratNvY4WRLri66mEKrHG
	3JLGzsYwxBOA7uh6hWgKlwRBAFkN1Y3kRHdWQQftlrj7QeoIoYu/0p0Q
X-Gm-Gg: AYBFou39W4/AweqHzTfQFdK/XTeChve+ql3mXbLStyUKuVzVX9xTbj6IDq0fQ5fCvY6
	3cTqQXowYyX+I9raeaiBugTvOLFl8Dm9JaP1GnjdAIg+8iOWOqHoaRZPBmrnag5DyV2qcN3oNxs
	JxuehF8v9A6hJYj8JyFUSZbivhNy0RBptz1509+cGeJF91I/CGKR6t55Odg79+aUZ00kWnfKAwZ
	dO+PgL+0gDEfrXjbakA7Dpaq66BGfa5Pad7urzqdY3BDeK08F6HCxH8z92EtsHylMd4tgdttb2D
	mjUiINXD2bA/tkuUsMjgFdMNddjDjUJaNtNdYQPINwV/KtYuZzFR19BXiIKXc3wCMkupPTHdt85
	dGALwDmNBrI2sbItxSVVRCowxzWNUH2D0+82Vgg6vQofy/Sxy8VnB61z06aXE9y8Df3UfiyDrct
	nECvIf4r4NudTUJAYRlcbVh0lATqtdOX5fRFSsKgVoNx2XYjMb7KcuEL+RtIYZ+x9gVeFdWLURO
	9/nHZfdyFOptNjp/TJipNaVfBw=
X-Received: by 2002:a17:90b:5850:b0:39d:fcbe:fdcf with SMTP id 98e67ed59e1d1-39dfcbf80a3mr4295519a91.1.1789432880429;
        Mon, 14 Sep 2026 17:41:20 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda24dcbsm1788237a91.5.2026.09.14.17.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 17:41:20 -0700 (PDT)
Message-ID: <7300920180144df4991e4aab7a54508e8091ac62.camel@gmail.com>
Subject: Re: [PATCH bpf v2 07/11] bpf: Retarget indirect jump targets across
 prologue prepends
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc: memxor@gmail.com, a.s.protopopov@gmail.com, info@starlabs.sg, 
	bpf@vger.kernel.org, Nicholas Carlini <npc@anthropic.com>
Date: Mon, 14 Sep 2026 17:41:16 -0700
In-Reply-To: <20260914170326.249953-8-daniel@iogearbox.net>
References: <20260914170326.249953-1-daniel@iogearbox.net>
	 <20260914170326.249953-8-daniel@iogearbox.net>
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
> A few patches do not expand in place, they prepend: gen_epilogue and
> gen_prologue splice their instructions in front of insn 0 in
> bpf_convert_ctx_accesses(), and bpf_do_misc_fixups() prepends the may_got=
o
> counter init at every subprog start.
>=20
> They copy the original instruction of 'tgt_idx' into the last slot of the
> patch buffer, so it now lives at tgt_idx + delta, and call adjust_jmp_off=
()
> to move direct branches from tgt_idx to tgt_idx + delta.
>=20
> Nothing does the same for indirect branches, so a BPF_MAP_TYPE_INSN_ARRAY
> slot that named tgt_idx keeps naming tgt_idx, which is now the first prep=
ended
> instruction, and insn_aux_data[tgt_idx].indirect_target makes the JIT emi=
t
> the landing pad there. Add a __bpf_patch_insn_data() variant and pass the
> BPF_PREPEND at the affected call-sites to fix up the delta.
>=20
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Fixes: 07ae6c130b46 ("bpf: Add helper to detect indirect jump targets")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
