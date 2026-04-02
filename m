Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7702DF137
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118009; cv=none; b=dOTXSyvDpaCkh6CW6DiNlY2TtJvorVV00n38fCQD1N2zru0u5EVEmiP4/FMmcf3u/OTStT5L4xH+w2sblZ/ag17mVKbRlUW3REFMqRD0dz2aD32jpjSTMFSmgtolDJqN0cGdwz9essvtOr6BSljx8WaWu6q85NMjv2gu4MWPjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118009; c=relaxed/simple;
	bh=2cbFc0+BSewLfqlOanrLpCFE/MzoXTbce6soA8EurIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjSCzp3GV3zZWZ5ov17N8tMrQpnp/yuxk6CkijlZZuGpJnwvLI1gy3uvn0CZoiTN5Q+0j9k74l3O2p2aAjGyHJsO0v/F2Z0V5jeqIumdBuPwvniz9ol5mgjyGJdEGLWm5AaqDlkW/KJEB32c1++lkEkM+9i+ylArk6fWx0YSf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do+vKl0u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do+vKl0u"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso4792505e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775118006; x=1775722806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fsHbwSzFqZ8lYk9WsN6hatiARTYkH9iqAVwT8NDlQ3w=;
        b=Do+vKl0urjzYaQ1yyzN8pSKaq9uT6zNgD/965VAf51/+bnsNnu7nYUxbqwDJzH93z1
         I9zczf9yllWT4IU6BybKdvxTUTURujfB1Hu6795OH1hDtwQk9jEcCHTRkmmzXoJrjoss
         C2Gz+O83ZyqGOQOBT/13A12q4ShTHKCW4uU6PstllAx1jSFm3HkeJIUwrdhBZW0VaPmh
         m14OxvnOdr1iq0DE+YXuXlAky4dT1a4+s2LUKx+0ohYIIi8YDs9o7V2cjygYj/GWJ3Ss
         1QBclsw3ajiD5pJOiZXv5fgkciZ4Q2RV6CIeugkOObE8lukG56DO2DuPbzmiTC986bOt
         RDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775118006; x=1775722806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsHbwSzFqZ8lYk9WsN6hatiARTYkH9iqAVwT8NDlQ3w=;
        b=pW76GNhHx/CN5bWn461f9FX9/mZRerijiOTO8OUE+Kb83sWMHKpdzM2/EilJMBjbbk
         3OULmecfXqUKS7ua36lCQ5iA7Rw0Rj7WKv4iAjTr4eUvwVhx1qOG4Y3bcoukD+JAdohz
         Yz/E2eFTSN99PuQSfPkzDXaDdfDrDpXM71hiNmn4bOxBVWxTWOuE+9oRMvkco0k7xNik
         aKNdi3lGOhhyK625+DZtvlbE5zVQ1nUEre/tUm0KhCXRLrTvZywpD5H0u8Uxbflq5JJn
         mIyVIRt+uFkIzr/okcf5DAhUcgmA+KsmLlWh30+S7yMlZKtVkdLEqTgTCIN9xxx3rMeg
         CEQw==
X-Gm-Message-State: AOJu0YwJYVjVIdN5hWTEfbzllW2bKE3xQZMXmYOD4CrzI+zicwYxpBGT
	26WXYPeuzwncHhFh3NmZIXXd9h0oSDxA9kikh4n9GqJMGw9I/ysMDtzy
X-Gm-Gg: ATEYQzx1w5X6+mz7VDPgHS1plctOqgLkv5QjBKm8ynUFm0gp0xi0O2CcoLNjOMNa22V
	TNAq0dFRq51wUusRbF4wFadUDOYIgA0bBnmznUYbP5t0REAVgC9nOXE+MUGdNgr3DguF1uZRNqM
	7mF6gVG9AN1+cOZBFLPeWwmre8c2yCtB5cltolE4bo6wVXW3wek3cMiVksb4uJVLAqpBkHe9FjZ
	Mc45Prm4EsQ+temf8FlqTNmOX4QxgBYcDn7/+L5k+u+VUAONEMa7+BJqBaqKpw73rvdsQHdcpRU
	P8b6izQF43Kmh32wHd4nDgrpiPDW9xBu2uEJS0gtFXaouigDocf72vrmLcPRognwFiFSS6cjtPR
	RFGk1QB2pm7Gl1bzkHk8oYm2AxEU/2HrAjgAJGWgbYBB1c5E1Td2Tt6+m6Kbky0T2Xp+u89N+vD
	AGKWSSst48z0+PWh4A82va3R156GZLE8JT
X-Received: by 2002:a05:600c:3e14:b0:487:288:1199 with SMTP id 5b1f17b1804b1-488835b75e2mr118120215e9.28.1775118006251;
        Thu, 02 Apr 2026 01:20:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887adc52b2sm62616225e9.12.2026.04.02.01.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:20:05 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:28:52 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add more tests for loading
 insn arrays with offsets
Message-ID: <ac4oxGJVRYN/K2co@mail.gmail.com>
References: <20260401161529.681755-1-a.s.protopopov@gmail.com>
 <20260401161529.681755-3-a.s.protopopov@gmail.com>
 <680e35d1-04bd-403c-9aca-f2b8a0af9af3@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680e35d1-04bd-403c-9aca-f2b8a0af9af3@gmail.com>

On 26/04/01 11:38PM, Mykyta Yatsenko wrote:
> 
> 
> On 4/1/26 5:15 PM, Anton Protopopov wrote:
> > A typical series of load instructions for a gotox looks like
> > 
> >     r1 = &map + offset1
> >     r1 += offset2
> >     r1 = *(r1 + offset3)
> >     gotox r1
> > 
> > Here offset3 is, normally, equal to zero; but this is not guaranteed.
> > Extend selftests with tests for non-zero offset3 and, while here, also
> > add tests for negative offsets (the offset1 and the sum of three offsets
> > still have to be non-negative).
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >   .../selftests/bpf/prog_tests/bpf_gotox.c      | 114 +++++++++++-------
> >   1 file changed, 73 insertions(+), 41 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > index 75b0cf2467ab..594adf698fdb 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_gotox.c
> > @@ -317,7 +317,7 @@ static void check_ldimm64_off_load(struct bpf_gotox *skel __always_unused)
> >   static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
> >   					   __u32 insn_cnt,
> > -					   __u32 off1, __u32 off2)
> > +					   int off1, int off2, int off3)
> >   {
> >   	const __u32 values[] = {5, 7, 9, 11, 13, 15};
> >   	const __u32 max_entries = ARRAY_SIZE(values);
> > @@ -349,16 +349,46 @@ static int __check_ldimm64_gotox_prog_load(struct bpf_insn *insns,
> >   	/* r1 += off2 */
> >   	insns[2].imm = off2;
> > +	/* r1 = *(r1 + off3) */
> > +	insns[3].off = off3;
> > +
> >   	ret = prog_load(insns, insn_cnt);
> >   	close(map_fd);
> >   	return ret;
> >   }
> > -static void reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2)
> > +static void
> > +allow_offsets(struct bpf_insn *insns, __u32 insn_cnt, int off1, int off2, int off3)
> > +{
> > +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +	int prog_fd, err;
> > +	char s[128] = "";
> > +
> > +	prog_fd = __check_ldimm64_gotox_prog_load(insns, insn_cnt, off1, off2, off3);
> > +	snprintf(s, sizeof(s), "__check_ldimm64_gotox_prog_load(%u,%u,%u)", off1, off2, off3);
> 
> here offsets are int, but printed with %u.

Yes, thanks, fixed.

> > +	if (!ASSERT_GE(prog_fd, 0, s))
> > +		return;
> > +
> > +	err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +	if (!ASSERT_OK(err, "test_run_opts err")) {
> > +		close(prog_fd);
> > +		return;
> > +	}
> > +
> > +	if (!ASSERT_EQ(topts.retval, (off1 + off2 + off3) / 8, "test_run_opts retval")) {
> > +		close(prog_fd);
> > +		return;
> > +	}
> > +
> > +	close(prog_fd);
> > +}
> > +
> > +static void
> > +reject_offsets(struct bpf_insn *insns, __u32 insn_cnt, __u32 off1, __u32 off2, __u32 off3)
> 
> If offsets can be negative, should these arguments be int rather than __u32,
> also matching reject_offsets?

Fixed.

> [...]
