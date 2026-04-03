Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B22749E6
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 01:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775178351; cv=none; b=nYxAGrokTSFozP58RPLEsDPYtidy9WGVXbvu1zU/t0FTgWGL0RWWRFb7OdfsP1bgX1AA8PKC/+7+VMjtF6S33d3XN8JeMM7p7lS2oMdlJarc7e0v6+sZ7C42cRaMfwN98aSHoubKRdL6Nc6NAuj6dcPSGAp9G56qAV/ovdhzScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775178351; c=relaxed/simple;
	bh=cKNSzZXvgDgsnPvA45phcHvoGVU/hZ9MHWN2Jcmumwo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/x2FDlIUQ8DZMQNb1xS40vj4GsLkNYpKjwwfQ/N+gDxQeYXCbnuT0dNTrIGIaRJk3xP6N2Ei3sVqKJTo1INYm1J29xv7eQ0efR/La2Fc9jnXPIRm2YpQdIP3RR95VuwZEqrQftb9Jp9jvUYDrfJqhqwWjwzBRtfQvQvGd/Pm+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEBq4dJJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEBq4dJJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82cf636dac8so674303b3a.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 18:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775178349; x=1775783149; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dyS/U/3nMD9X7VItnxvWGKom5NzqOvac6qgCSh7nefY=;
        b=FEBq4dJJ8b31yIJzXLG1s38+PFaNPrvSCq1tk0/JXFkWtBTCSYOf5R54p8XiKBG4Yj
         uU/otL57tlO0VzOLeKzHC3xI9g/i/qZcvmJFTjXATWghaggqb6TwZmt0sPdCK7b5n0th
         uySmC5P5Tah8YA1VddbFyFhBWkMoy101ZPYx1Q6l+4rItNRwPSgSQTdrT2JDTVX9qh+3
         Qh7g2tzwnIxob3V1fKRCNUKqSRtG1/wAx0psq6cKjwVwQ6s0mSbF/LZsHC/IrUeCREe1
         FiZiNdejiimA+/EMYlCGAPl11huQN+sqweeeWFmpz1Uz8gymJeJfQkEzB30UPub58g/m
         LPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775178349; x=1775783149;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyS/U/3nMD9X7VItnxvWGKom5NzqOvac6qgCSh7nefY=;
        b=eAmzc/zv60XML1SNRSquWmqPEVeQWSNoBTJRrClsPVdjv74oXLCceka6tiB79FfvQK
         +6s8z9F58oOADunS3Wkkx00iNaM3Z+lBj2eSZqsJvH903oCr4LIphIeOUWAB+xrVrbPn
         2scAIE5F2xPY5jWYFr6vt3m6TovlavmMRCzp9XLT5ZvXXKfMLfSDIk5/QvK7m2Rk6fP+
         zPwF7lWfBykHvOZGgV6KoRXLSPiXlS1DI0oPQ3zLrIIvU1DQIHYO4cnr/oP2zKaFxMvD
         l/o82fAXQmsmOjw5g7IRJT2nl1wT4kw6eUL4LM7xbCP21klI+DSUN8oVJf7mvIp5p47a
         3WDA==
X-Forwarded-Encrypted: i=1; AJvYcCUYRrmU4LxIq3iTJ+DfwgVJMLa6MWTs1grdNTkQg/kWwFRjl+vyrRjLQVovYv/8QHpI8PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydhdfwceSjNc2Yy6/REpLA2yXT5wNg1gbDAB2Ow+00kYlHa1m+
	WIA8a+hEbDTrQo/qmHPcsbuvcQl/bZeRUzI9lgh9wqqDUKE1VuOBXYseNsJql9BJ
X-Gm-Gg: ATEYQzwT/ZUFkcnqMLrMOarD1jYHv00v9MBgDaOs/C34UmNorMIomf1ji2t/qfhybmE
	a/G0rAOmkKVryVmatZVYVcyvP09Sps0crkLHRXDr6f7QGgzi9+BKJ1v6SD11wJjxpDFCKujLhYk
	XIIWq6Vg35tCaJ0Hvm1spoWhdiD6YYQPXDPsNslf4QBG8klXt4T9zcAk83+I8FUesbram3JbijM
	C7Gft6D3jWJP05pXsenfXns6NfqY5PGPOtD8+1gcaFNPsc+uWkvAwYAUJgYmmIu4/hYl90Ekopm
	iw7/wcykIO6ABEE2nWlIbitezINSDZ1vNjF8GMBFHNLFPG2JA/mMPpAewxs3q432rpGozUHF5rR
	nk4mRYeK/52/dc54KbCvqJmlEu04JWIGmICZscgsJAoLqF3cyxQ9GL8YUkNJ7oyvU/B/p07w7JV
	O8cZHhAw0RMZJZd7zZG70C/ZUsw62POZEGNvTwen+QKzgMZsEwdq3n
X-Received: by 2002:a05:6a00:2e22:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-82d0db72eb0mr1206283b3a.33.1775178349079;
        Thu, 02 Apr 2026 18:05:49 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c4387esm4535633b3a.31.2026.04.02.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 18:05:48 -0700 (PDT)
Message-ID: <56b5fcf088d0c9df02cca56af327d7e083011340.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Simulate branches to prune based
 on range violations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>,
 Srinivas Narayana <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Thu, 02 Apr 2026 18:05:46 -0700
In-Reply-To: <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
References: <cover.1775142354.git.paul.chaignon@gmail.com>
	 <a166b54a3cbbbdbcdf8a87f53045f1097176218b.1775142354.git.paul.chaignon@gmail.com>
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
> This patch fixes the invariant violations that can happen after we
> refine ranges & tnum based on an incorrectly-detected branch condition.
> For example, the branch is always true, but we miss it in
> is_branch_taken; we then refine based on the branch being false and end
> up with incoherent ranges (e.g. umax < umin).
>=20
> To avoid this, we can simulate the refinement on both branches. More
> specifically, this patch simulates both branches taken using
> regs_refine_cond_op and reg_bounds_sync. If the resulting register
> states are ill-formed on one of the branches, is_branch_taken can mark
> that branch as "never taken".
>=20
> On a more formal note, we can deduce a branch is not taken when
> regs_refine_cond_op or reg_bounds_sync returns an ill-formed state
> because the branch operators are sound (verified with Agni [1]).
> Soundness means that the verifier is guaranteed to produce sound
> outputs on the taken branches. On the non-taken branch (explored
> because of imprecision in the bounds), the verifier is free to produce
> any output. We use ill-formedness as a signal that the branch is dead
> and prune that branch.
>=20
> This patch moves the refinement logic for both branches from
> reg_set_min_max to their own function, simulate_both_branches_taken,
> which is called from is_scalar_branch_taken. As a result,
> reg_set_min_max now only runs sanity checks and has been renamed to
> reg_bounds_sanity_check_branches to reflect that.
>=20
> We have had five patches fixing specific cases of invariant violations
> in the past, all added with selftests:
> - commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
>   min/max boundary")
> - commit efc11a667878 ("bpf: Improve bounds when tnum has a single
>   possible value")
> - commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
>   logic")
> - commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
>   boundary")
> - commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
>   JSET")
>=20
> To confirm that this patch addresses all invariant violations, we have
> also reverted those five commits and verified that their related
> selftests don't cause any invariant violation warnings anymore. Those
> selftests still fail but only because of misdetected branches or
> less-precise bounds than expected. This demonstrates that the current
> patch is enough to avoid the invariant violation warning AND that the
> previous five patches are still useful to improve branch detection.
>=20
> In addition to the selftests, this change was also tested with the
> Cilium complexity test suite: all programs were successfully loaded and
> it didn't change the number of processed instructions.
>=20
> Link: https://github.com/bpfverif/agni [1]
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc950cc277150935cc0b5
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Co-developed-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Signed-off-by: Srinivas Narayana <srinivas.narayana@rutgers.edu>
> Co-developed-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
