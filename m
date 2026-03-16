Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343A382F39
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680952; cv=none; b=Ob/D3Tjbnn+Eu72hpP17iSnL5uYZPYIyP4hqk5b8jZuvK32BEsKeJVt9pqDYOsNaDGlybR+Iv2J3mSWaS1pfCCY/TVuEogBP37YQO/3QeqktNQyg5mkz6BsJN1nlFOHkn1vGhb+bIp7YcBuCmB/sITLLdOwJCvptY8rlnmvGFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680952; c=relaxed/simple;
	bh=mV7dEgaXDm0MPz6h+0lagbeFxD49mNzu++/87xBQrnQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sbEVnSZotULKAOcYQ64tpsmeyuurfK7P1moae782iCH76EzTMWPllm2BEkdtHcbbWdzCGroRqyqPJLk6h4WCTvyzVOnJvYEBDDHk2JfW3kZBggHTYQk20GSh8Kup18sYtFceP+ee6dy5SInt3zs9+uU4E9oelU6bgylvrQWIALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcAf0tka; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcAf0tka"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso5701921eec.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680950; x=1774285750; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOhSo5BvwMQ1S7ngwZP+aXm0XUCoCl7VETBpvgnLFxw=;
        b=XcAf0tkaEaZOFg7E7dKTUnNZYNam2rGUKqbYrJ4+493Thx4QQO+4+MGlcE81AGxVQy
         sNMUGAkCrP/r3GPKzKrZtmQeDRqGYqMGHGTPdvSU9ecNwxBxNFemY9TbY2XQiVRuFb34
         7vkLDyTXvTPTGlHPdz3Dne++JoZ/ub+U3camIp25UQZDVmMS/fdmnRcuzw1UpxO0y4IE
         HcUEjbGAKJ9bCme7iTJcRtDPvyEtUe8i8WoZOkky38ZZ0hYCO8m6Yf4l2qItJJApA9RM
         XG9vhUSYxz2kZ7/J3w0z4jMNSbo+C+Dbz+MnUGrEcvc0lJL3P+gUhpodLWriSsdZ5HGj
         rACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680950; x=1774285750;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOhSo5BvwMQ1S7ngwZP+aXm0XUCoCl7VETBpvgnLFxw=;
        b=VKnNz+iy/SxbUwZGi7IvE1K3lB7jP+TsBlRKTVag/13G/YxwKHKfKGQ48cmoR5N7dj
         ixf/KsRVy8R/u8EIBA0JW12ScOtPkIuJe9fFfY4sdoaJCf4kN6cqSLUkkNpacsvMMfVZ
         Qaqp2retapfwdHz6nRnKzkyWtJld6guDGrXS58yLhe0Ph/x6HkIRyZrT3lKdjYtoOJcd
         cFdWI3kazzt77M3WCKv4Af4sOvu+QMKMSUB/WULatpAM4mlnC+fgpfRlXY0Rn8n5V3gI
         k0TT5mgGjuGibBOV/O79L9ugBH8BU/F64viwdB1CoXiuVNfWs3CgHTTVTTol5bb5htA8
         t7gw==
X-Forwarded-Encrypted: i=1; AJvYcCVvfWXWSyMab1ZIkjxcodzoR8QTcJXBo89EZIjEEpVkrnOEEAcy5WiG2CwF4ZF7TW+FlfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx4/2yIiYOlytbgYnWaf40gA0bGbc3NeasRzOKNLgBhjiccPZp
	GTOETvt28fXEkQ6Mig5FB6kWMhZfqtK8Z20hC9/vFwbJaV+iBT9g4d+F
X-Gm-Gg: ATEYQzy4iTIzQQrRVBAjaAki+rEqrHoezkayvM/72F0d9lENMV6Xz9bSAheRcS5Q28C
	Yvi5bHpz1CBkSRRefspQi3Q18ZzDwGk9gpgKi1nT6kGGXZb6RSWUcZ1YU+Df5ZfIGyRqa+s1v+v
	eBtpOXFCS/Npm7Vt0vstzsdDwWREt24753haXoafzDEEX1j05T3hd/SztVpsZEMs+Qv9kWipwSy
	eA0TrRJ/CPule99kwgW1x0YJB2j7S0todApcZbPE/fbzS0QjPX+tmDnTBkPPTk3qDRRUo6zM/te
	qvZBCqLwWt9I0fk4UOeevSLUV4IRxH/zhZ4SXNaaxrSOpygaqZ/E7MO+Lfx7fyXz5G0h6AsJ0Pi
	RS1MpzOffYu1McskYINRCoYSjYVPJ9u39cGG4oo4ksRwO6menFUFrayPaQrf5viNiskUm+uSF+D
	vOwyUu18BMmmCE7eYVDKVMRt7K2TpAtnOQ45/H9MescPsxjXGOUwbzZLNeZn0=
X-Received: by 2002:a05:7301:37c3:b0:2b7:1d38:3596 with SMTP id 5a478bee46e88-2bea53a9dd1mr4886901eec.4.1773680950359;
        Mon, 16 Mar 2026 10:09:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::7bc? ([2620:10d:c090:600::76f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bded43e2sm6857756eec.9.2026.03.16.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:09:09 -0700 (PDT)
Message-ID: <7a9255803fdfef52d86c257ccb00d3b1d37de5cc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Mon, 16 Mar 2026 10:09:07 -0700
In-Reply-To: <CAM=Ch06pLOWKx4D=sVJ5oqCCy6R_N9Lxv7t-UV_yQCjFhBtO+Q@mail.gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
	 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
	 <a41262218c37af754dda48811b3a165341c92028.camel@gmail.com>
	 <CAM=Ch06pLOWKx4D=sVJ5oqCCy6R_N9Lxv7t-UV_yQCjFhBtO+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-14 at 01:01 -0400, Harishankar Vishwanathan wrote:

[...]

> > > +     /* Fallthrough (FALSE) branch */
> > > +     regs_refine_cond_op(&false_reg1_c, &false_reg2_c, rev_opcode(op=
code), is_jmp32);
> > > +     /* If there is a range bounds violation in *any* of the abstrac=
t values in either
> > > +      * reg_states in the FALSE branch (i.e. false_reg1, false_reg2)=
, the FALSE branch must be
> > > +      * dead. Only TRUE branch will be taken.
> > > +      */
> > > +     if (range_bounds_violation(&false_reg1_c) || range_bounds_viola=
tion(&false_reg2_c))
> > > +             return 1;
> >=20
> > How hard would it be to modify reg_bounds_sync() such that it
> > preserves invariant violation? Thus avoiding the first round of
> > range_bounds_violation() checks.
>=20
> We can exit early in reg_bounds_sync by detecting ill-formed inputs
> (using reg_bounds_violation itself), and have reg_bounds_sync preserve
> the invalid bounds.
> Unsure if preserving invalid inputs is a good idea for
> reg_bounds_sync. Or if we should be
> calling __mark_reg_unbounded on invalid inputs.

Agree, early exit is a good option.
