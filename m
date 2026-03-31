Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FE1A5B8A
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921868; cv=none; b=nt2mQ3JEYsNogrqs5q6wBcNV3Npz9ymlfjmHqLWgFAfQRk5I0FCD2dn+c9JSYnjRWpsVoxosn9xCH0w4DWkB6brtqlSCOwYCSdEqWDis/KGop3j5xxCeGqA+i6vaPwhhZxdfmWvxyZYYYK6kZD5HxSa+tgOggfio06xigLB9QEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921868; c=relaxed/simple;
	bh=YSQllMGhQ3RJczQso5QKvR0T9W2OXtoo1V9ONhKYqFQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0ZkUYKGHqHgXADsHOHO2625Xc9cuMaDk3TY44Mu87W7xPyPxLxYrK4y32hs2WK7r0lUPVTk3msOJljhMO/2rrrAci/5v8ZaljPp2q1FRCefmGU1q6hU5rcQw9xuQyhbXGI0WKrwfoCqE7SGtG+eFbobi/KQrOpzd/sU4OqLYqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiahWBin; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiahWBin"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a9296b3926so33441605ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774921867; x=1775526667; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTolLyEwLtHeb7v1wUJn8ow9+nJnaE99vjobiNhcyxk=;
        b=KiahWBinHXhkwzR+lg4fF9nnv6u84cWPhdau/tGdJ6zSP9GsgapZk+MID0sxQqt5/K
         QQcuMbJsiJQAU3ykfWXfHdMJYcX2Qa+wypbBx88k6p1STBrtyBUZIkJYqhnWK71aAo3z
         YAzqDbR10EHRvLBoNoS8bAoMJWn/XQgQMykchK3Q4lgfe24aZLhVZ26vAsU5mdyWMZ43
         QS2jhuELIaiLfl6RfOWQD/ugJ/y+Bs4lckKCV4G0Fu13yXXoep/pM+o+KbfzRhlDUYdi
         MxKloBsiQyAKV8beUv6Fe21j3GwcIFnPhqQ8RcS0JXadIam2HIne40F/Ea8BfDKNWor7
         v+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921867; x=1775526667;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTolLyEwLtHeb7v1wUJn8ow9+nJnaE99vjobiNhcyxk=;
        b=FrI+eIa36BY6YUu8fvijylFHgGJ6raZWNb6SeqGITnbtW/hSFnb0THlCXga/j8e5cW
         zTNLLoEQ2pc3M5HLQJlcT3oVa3iwqeo6RA9XCTGlrwlYvzpRAhOBW+8fxgmolDVt1uUK
         ox5SjTvfqpNsPL9Byaic2zyJYewGi/bQtLByk0kzri+9Q1yOVRqVN3m4aAfXQcG58s+N
         Q/E4VjRIfTC2YfFPPDrm0LqKcJwL6njxjQXdDTGI+IUkmr+m/cRicpk8RfvRzqPE8VNt
         j4N4z2Gcu8xvNpgEzw1yXrrEDBQwzV8hbY5BQCad2+dFP1s34d/5bDhxNioVg5YnMhHb
         bOHw==
X-Forwarded-Encrypted: i=1; AJvYcCXdWbuV3V6q+iNNWf+bbx/6O7P0q0j8bxeKwjEhdM2HvYis684wfIefHWyYb4vSXlugZ6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSTwKH51goJjB8v1EPAqgs01PZHnAqdbS+6ZH8HlW9Ywq4pb4L
	+a7NiINlX7Fj9rEhvf8EdGREPXVFIR60F9KI5QJQ4zaMGhA6BLbjZGO+
X-Gm-Gg: ATEYQzxDekW31cG5DfiDcno33f1/WVRVm004bCbR2xwNbxdVbyybJFUBrdwIXADsN5h
	SjCZH6kISHo970OXXuNuHd/nf4iUBcK9dXZtNnHR6usV1GzyNSNasMLcnjzl0Ar602P5iHiSglB
	NobDk/XqtF26VMWEwDwqk1HZWdhTIioSQOPVkH5ymOCj09lQ1PBy//TbmL64hnELWCKT47jmw7M
	f8evnulMmSANaXPXzkoaCh0uHSUDo8NSye4BLs7sTHhCiIrilT5d1w949S8bWwHU5yULaDEPyRl
	cLO/dxxDUrHeI08g21l0mt1w0DhwPZanXVatfgI3hBZVtw/jOh7oP5k1okbeQ2QxIS9ZLqPtthK
	0NiSTfvrzNiBQbxBO3kdEZKWfq/eTEmQlteSo5fGqQtnlKmlVfc4RkrdTdkYubfTQJ/12BXLuI8
	qu0Ar3FDNCkZYkbs4JzZjCc8jBSIJqtXdlv6Ej4BcsQApqstVw2Ew=
X-Received: by 2002:a17:903:240c:b0:2ae:c5fc:b2ef with SMTP id d9443c01a7336-2b0cdd3ec4emr136389525ad.30.1774921867179;
        Mon, 30 Mar 2026 18:51:07 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24267397bsm102031685ad.27.2026.03.30.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:51:06 -0700 (PDT)
Message-ID: <d766f85ad5617da8af16a64f8903edfa3442e6d7.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: KaFai Wan <kafai.wan@linux.dev>, bpf@vger.kernel.org, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko	
 <andrii@kernel.org>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
  Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Mon, 30 Mar 2026 18:51:04 -0700
In-Reply-To: <acpnHDASo5QGw7BZ@mail.gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
	 <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
	 <acpnHDASo5QGw7BZ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-30 at 14:05 +0200, Paul Chaignon wrote:
> On Mon, Mar 23, 2026 at 11:42:11AM -0700, Eduard Zingerman wrote:
> > On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
>=20
> [...]
>=20
> > > @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verif=
ier_env *env,
> > > =C2=A0	 * variable offset from the compare (unless they were a pointe=
r into
> > > =C2=A0	 * the same object, but we don't bother with that).
> > > =C2=A0	 */
> > > -	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCA=
LAR_VALUE)
> > > -		return 0;
> > > -
> > > -	/* We compute branch direction for same SCALAR_VALUE registers in
> > > -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., B=
PF_JSET)
> > > -	 * on the same registers, we don't need to adjust the min/max value=
s.
> > > -	 */
> > > -	if (false_reg1 =3D=3D false_reg2)
> >=20
> > A side note:
> >=20
> > The above hunk was added as a part of [1] to mitigate some invariant
> > violation errors. Surprisingly, none of the tests added in [1] fail
> > on current master if above hunk is commented out. Probably due to
> > recent improvements in bounds deduction. Should we remove these
> > tests as a part of the series?
> >=20
> > [1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linu=
x.dev/
>=20
> Nice catch! Out of those five new tests, the three "jset on same
> register, scalar value unknown branch" never fail if you revert the
> commit they were testing, even at the time they were added.

When I get back to [1] and revert [2] I see the following test failing:

  verifier_bounds/jset on same register, scalar value branch taken

The other two indeed pass.

[1] 9f32bfec545c ("selftests/bpf: Add test for conditional jumps on same sc=
alar register")
[2] d43ad9da8052 ("bpf: Skip bounds adjustment for conditional jumps on sam=
e scalar register")

> I believe
> these three tests were intended to cover the above "false_reg1 =3D=3D
> false_reg2" check and supposed to fail with an invariant violation when
> the check is missing.
>=20
> I believe this check was never actually needed. For an invariant
> violation to happen, we need regs_refine_cond_op to refine a register
> based on a incorrectly-detected branch being verified. For jset, that
> can only happen if one of the two registers is constant. In our case,
> that would mean both registers are constant. But if both registers are
> constant, then is_scalar_branch_taken is always able to precisely
> deduce the outcome of the jset. Hence, we wouldn't even reach this
> "false_reg1 =3D=3D false_reg2" check.
>=20
> I think I'll remove this check in a preparatory commit, along with the
> related selftests and an explanation why it's all not-needed. Cc'ing
> KaFai Wan in case I missed something.
>=20
> >=20
> > [...]
