Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF283233926
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075341; cv=none; b=s73kC5fF2Y9nycXRRYNF9qcOQzUziGfVqn3qME3HySw8Ixr/Mu0RHerw/McKT1oOVUYSWFM4qqdnARjVdt7U5xnrJXV05hF6bOr+6j4xcXgVxYwieFMtmdOo3KPXt4YP4qdfGlomX/2pC6iZhyS/rjUSa0M/khmhfQJPWa44hc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075341; c=relaxed/simple;
	bh=5o86A89Z5MWE6H+q0agSl6Z3/q9EagTnYFlt2t3fqys=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=o8pu7Jagv5xlyqASDcwVxQ3xT2msGJCteUqBlQFLywlZ4QPkj/u3iv77jEicFdKiHqFaTssv3BKGhJDxiJI9lP1dWODCWN7TeNADLRlSlKcgP0YZFoN7MXK1b/uGBZYEAKCQnYp8kkPoanNuAhFdTbSC/x46Bapu3av/wocWD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Syyzcd/A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Syyzcd/A"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381891a9525so5238156a91.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075336; x=1784680136; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q6EUyZKF6G67Gt1NStk+455yKefIcrRIfkjtGEXNiGs=;
        b=Syyzcd/AAmnTZnTu7b6WRbyhIeuepJHfLt1IdaybX9m3NwOJkgjuX3Mf8aGjurOizp
         n4ub6zGIOC46qcfniZp6g/caVkXbWViZb0ufFwHT10QlCe3j05x2RT3Rp07mo0KTzF+b
         4HhOViN3IMZCn26sJhYJ29HRpZ/LcpMhqN0D6G1v0LzlUev1/MAMPG8005GqsSTZNhwB
         CvPeY9edymLCHwuf4KS3aVtDuGHJipre7gK1rTuISWtv4PF3guBSeZhdEm0usCpbdLUX
         1sx3l8vJRE3nXUQHRLNh/V7IGT78bDZr4xsKyXmjJ6YT5ZwLFgZlipx9KmC4gY3D1afe
         Y8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075336; x=1784680136;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q6EUyZKF6G67Gt1NStk+455yKefIcrRIfkjtGEXNiGs=;
        b=NSUCgRFZBohb5+G/JO0Qi3XbKbrigurIfnCkXtKlNV2IRlBjlD2AIhDDo+kjDaRGkD
         cDgTPqnAV3tsAREX273ial1zWK5UeoEwrJ5CPPDotcKwouxwbRCYpaOgKJdMgp76Q60a
         hga9B61SuL+qLSqtHCaJtMOaaQTmKlXNoj/3JAqzZgORsUX1QbD4kelYQo9LSqPVfxMc
         Aj7gK/dqwSEZ4Y4/DpMVoGymsuBKyLrMuDHEpqDqawffpkisGySSTQyya8AOSeq/u63z
         SuX1kYaWWyTyJr7e4vUer3qN/HeIBwZd4O71rWl0GcAeAcKh8GoXhyAaC1BGjyHHUqPI
         Ik2A==
X-Forwarded-Encrypted: i=1; AHgh+RqpazbwVO2j+2acpIann0ceHqCAbuVMRbrTUI5gJjJfukBLWrgEWDn8rC9y5Zr0u0QV6w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzgKDv1MtROv0rQxpjVrD98DR8+WnhnRx/3aJhTvR2Wy7SAD9
	nuTaZMSYN9O+0mGRXreugXRXAtrSLJQZzqbxo+hfDadwy+camPftyeh+
X-Gm-Gg: AfdE7clOEvWivaeUAtdV9R6CR8rH6YuyaJVggcOw/FD5Ooo/4/F6871VsUwoYytZhD0
	+KrZbMJ50eJlR0548xJH1KELLR6zceDCMMWTShH9mhoqXT5F4Xqis+pCtfwb1Hi97KA2yvfq6qa
	DRUBBhFSs1t7HpzIeZaSiY2zsxlluSuZZN9zUwUTeWA4Op6iLK5VFTyEY2Fq5soJsFEP7qNVtlf
	MgT334tnV4qTZxhKriXWhDcy3x1alkvuGcP6eJYRdKXeOQf4lBgDFXKTBa56uMCbPMPdibNQPYD
	XuvZgf8m/xO2LWQ5hAUqzqNC6O+2/g27RtDO9eB8L7rOhDpsZlC5LOALwhZAvL8cUB5ypcmEyr5
	kMHrIfddM/rAud6AzhWFH96u+5mWeaPG6NLiVcwOJ2Ml2yVrfHVkPP14xpFNK7yvtR/m+8LfQkj
	2wgWsFp45TXhgZRt5d
X-Received: by 2002:a17:90b:2544:b0:37f:9ce1:736b with SMTP id 98e67ed59e1d1-38e1af37168mr4216164a91.33.1784075336213;
        Tue, 14 Jul 2026 17:28:56 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/9] binfmt_misc: wire up bpf-backed 'B' entries
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-4-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-4-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531871.2243172.18093804936760543620.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:09 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index f7264b136..a8f641c4e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -226,12 +240,51 @@ static struct binfmt_misc *current_binfmt_misc(void)
> [ ... skip 34 lines ... ]
> +	/* Selecting an interpreter is part of the contract. */
> +	if (!bprm->bpf_interp)
> +		return ERR_PTR(-ENOEXEC);
> +
> +	return bprm->bpf_interp;
> +}

The "contract" says that if the BPF program returns 0, it must take
ownership of selecting the interpreter. However the bpf_interp can be
NULL here and therefore is indistinguishable from the refuse to handle
case.

We might want to treat 0-without-interp as a hard -ENOEXEC-to-caller.

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
