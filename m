Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BA6239099
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 00:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775177660; cv=none; b=S8m4ExI7qBdGhXe5OEOCfz07XeldGk8NnrMtnCwDdRj3iFLuy6zBq681kAIagyPfaaS1HoL96ocBLl26Bc59bOhFAFXDJkYtyAMn5I7eTUV5f9cUwXFi2+/GJAA+QJxdfief+8g4letI8rtcACMnH5Ofavy48iVkzgRRrnJfFTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775177660; c=relaxed/simple;
	bh=OxgDXY5MHRZdh9/FfPvdgtFKeIa8+a1kcpWjUsOgytg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cuhnQAm2Dp/bvWawb3uvBAc6kAqhjeeevNCEwE1bBlCPPCSKvSpFLMNf1Iqms9qaJLuI8KxUur4rb3h2bs6pPsCQvvq0BzxGv5w9NHwD4c8xLZDzawG1QI7ylzkhsIg0y3NkMr/saBAckf96Sqt1gpJ38vZhIjq1gndLKYuVVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL9x6t1R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL9x6t1R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so8781795ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 17:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775177659; x=1775782459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OxgDXY5MHRZdh9/FfPvdgtFKeIa8+a1kcpWjUsOgytg=;
        b=cL9x6t1R50v/iIAcpoOYwusR0AhGcDyDGkEo6ed1+VCuOawYcQSgyG2vCN2R3OdL6a
         4jQaAUgo2c1LUS/uCJWhSv5/prEsDykJyEUpNPztViZcLKdFxyev/3W08f+xJGtsT4iF
         +cg/Uh62028KGXONcxymZUM6C7ZkhB2LPjjReHKuOI/KC0JhsH7D8ypujWE9KwLd6g9O
         5sDgp66WoGdW5T72BUm+TtPXuV/la9YIHbzaYoystUva+vu7fMCnmepQgS22qfr8ZULI
         TudMgB0mEie583uS7KiVIVPqLhF0lvwKjOQjgMn6Df/Fj2RB9HXQozH5PmC8rkWN22uE
         YUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775177659; x=1775782459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxgDXY5MHRZdh9/FfPvdgtFKeIa8+a1kcpWjUsOgytg=;
        b=PFSgIGs8CDbe2U5cHf3S/bMDAy7tM9PvenNNkjP6Gzp+oXSlUNmsRfNoP8lWTS8m2b
         LQ3piO0IDwBLt/3Kq24PklWLI8JdS6nZt5nskEVL3g9C0YI1Tg7SEmnkL3sbenz/Ng/2
         CXasu6KcD+HnPdgnyHZzDWcRwRebxYIZK+cArfHVMz07Uq6puaIbH+khuOt8bllopIaQ
         Cbiwvr+sNfQf3YuVTUljU3OeNO/dYGhK2Tdc3ZdHfntxD0VbihJnbR5wc+kTdu/45z1Y
         tr3dD8ixKEJDnPhvk4OSFXEMnGKGlhDlVUTwWjkMy+Zwh0UQ2bpw8Ms+wqW66nC2tlMx
         Htjw==
X-Forwarded-Encrypted: i=1; AJvYcCVmHAxAhGk1OLX1Ksuv7ZNOlICf+BE2/nro5PfNkmC8gwJQrnbMmTBtR66iFxq6YWZdFgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3hx/iExyW28IN6ph/bk+qfNraoYK2qCx+WnUk90C+xlWEaDRI
	OzH36656soYjym7OoiY5RRhapmNLYC87hRTnOP/LtgRyMazlrMP+7X4e
X-Gm-Gg: AeBDietVRSuc2BIlzOZts45ZO+j7HoSn/kFtVnLG5H6ocBcGx7wMj59TCyMQ/Fyi1aT
	XAf21CmS0bfGDT92jcZ7L7yug6NtazmrEbI4bBk/vWzXiwJLLS2sxvolDvuat9B8oOvGsyhPTzZ
	aVvI5cp2Fee/N0jYhLHvDNrUTv+jBxJTnDNWS58xpE4fDUpjve2LoSEmsylTGVWJNwP8JkQuLwL
	k+6V58TNJn3/MTtk19gazJdxMW+uo2V4adQiH7KHgGqd59nORfB3EJnz4Sa0V6NETy+j2eJVxve
	Xdm7GhBXcD+dGjtpZLHqr9EmVsGgfWDCP2y9n+FVZOxWgYe6dry4sNDnzA7kUMszPBBKX8Ge3iq
	/xZhCkazF/y7e7vgtgRSwnA8quzHa2z3HPHqgdtWmkRqr7ONqVDRDfEjGuKmI4vdFMX6Rluzkvg
	hA8oiM9ViuNrZl9M0ZsrQ/Yj1YYEYbJPLn5YDqtIazkxs8qEO5dY3d
X-Received: by 2002:a17:903:1b24:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b2816789efmr13100105ad.11.1775177658689;
        Thu, 02 Apr 2026 17:54:18 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274978fd7sm54116705ad.39.2026.04.02.17.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:54:18 -0700 (PDT)
Message-ID: <23328b2590a83694ff5b6edc3041c650a16d4d1f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Exit early if reg_bounds_sync gets
 invalid inputs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 02 Apr 2026 17:54:15 -0700
In-Reply-To: <73127d628841c59cb7423d6bdcd204bf90bcdc80.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
	 <73127d628841c59cb7423d6bdcd204bf90bcdc80.1775142354.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-02 at 17:10 +0200, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>=20
> In the subsequent commit, to prune dead branches we will rely on
> detecting ill-formed ranges using range_bounds_violations()
> (e.g., umin > umax) after refining register bounds using
> regs_refine_cond_op().
>=20
> However, reg_bounds_sync() can sometimes "repair" ill-formed bounds,
> potentially masking a violation that was produced by
> regs_refine_cond_op().
>=20
> This commit modifies reg_bounds_sync() to exit early if an invariant
> violation is already present in the input.
>=20
> This ensures ill-formed reg_states remain ill-formed after
> reg_bounds_sync(), allowing simulate_both_branches_taken() to correctly
> identify dead branches with a single check to range_bounds_violation().
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
