Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9037F8A9
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984835; cv=none; b=Wo3qm3Aa7WETkapyIMru+tC+OoFx+5DgNUXjH0MhYQFqYURi+zVYfULQTNGIsZZP3cP+XTMp3jGVnGo5Gyuvzz7PHvAEFuIvynU53tPMJ3b1+UeA0zkqlwc0BSnD/Du5IRgvgz2Np0ha4ex5CfEi/vM8ewmcwxwgVYM896JMmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984835; c=relaxed/simple;
	bh=EltVhwcSqhbNXlv/OFk0lsNbmYBXcj784F/MlaF4Kyc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vtlq0V+oK07gkp9JDQw8THXNtnx12nwPsmSO+2AGAsC3MBYPFgtdaT+v3Z/nmucybRBxvTHIcdVusif4oa0onedWxOtCcLQMzHdJ2wJZutOSev3IvkXelESwGAiWq6DHqDIrFf5RPPyPqxHY/g/kOKoXsh2fP4Id/PJrqmQerOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKB8egic; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKB8egic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B339EC2BCB4;
	Tue,  5 May 2026 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984834;
	bh=EltVhwcSqhbNXlv/OFk0lsNbmYBXcj784F/MlaF4Kyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aKB8egicY0DWoAhLZqh6pr347RAE78rFUxTuIzJ5BxYk5ppY86zp2PQ4PvDuN0+0p
	 YVaYy+D3tVW6N9l88EFdATM4TwW8jWjqZGKeGOln5typuWLMdN5WCRTkhMvPUNOMjq
	 I9hjcYV/Sc+G3oAjp/6sJJr+hnnzUdUcHFpfrKWfmojvEtTKwT0YLtEAaLkTVpgRkI
	 ACGSsw9dXthf9LVBXjSD5Om+oMsNDmpoM3cBMAY2ynvkg1r6QLV7SoYYI9x12QLFaU
	 IhsTtdoCJF3xLjB4p8+zuvoA60+DgKMdeM0DTTyptjPGSUh8n0d0QrBxDDc0wfnjvX
	 dwS8iNWIWiNcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 08/19] unwind_user: Stop when reaching an outermost
 frame
Reply-To: sashiko@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260505121718.3572346-9-jremus@linux.ibm.com>
References: <20260505121718.3572346-9-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 12:40:34 +0000
Message-Id: <20260505124034.B339EC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `outermost` field in `struct unwind_user_frame` =
is read uninitialized during SFrame unwinding, which can randomly truncate =
stack traces.
--

commit 84ee374fd6a62072e8d61545c4ceae42822e4e37
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user: Stop when reaching an outermost frame

This commit adds an outermost frame indicator to the unwind user frame
structure, and modifies the unwinder to stop when it is reached.

> diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
> index 1fb2724197332..fdb1001e37505 100644
> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c
> @@ -32,6 +32,12 @@ static int unwind_user_next_common(struct unwind_user_=
state *state,
>  {
>  	unsigned long cfa, fp, ra;
> =20
> +	/* Stop unwinding when reaching an outermost frame. */
> +	if (frame->outermost) {

Could this evaluate uninitialized stack memory during SFrame unwinding?

In kernel/unwind/user.c, unwind_user_next_sframe() declares the frame
variable on the stack without zero-initializing it:

unwind_user_next_sframe() {
        struct unwind_user_frame frame;
        ...
        err =3D sframe_find(..., &frame);
        ...
        return unwind_user_next_common(state, &frame);
}

Since sframe_find() does not populate the newly added outermost field at th=
is
point in the patch series, frame->outermost contains uninitialized memory
when checked here.

If this evaluates to true, does it erroneously set state->done and silently
truncate stack traces?

I note that this is fixed later in the series by the commit
"unwind_user/sframe: Add support for outermost frame indication", but
introducing the uninitialized read in this commit could break kernel
bisectability.

> +		state->done =3D true;
> +		return 0;
> +	}
> +
>  	/* Get the Canonical Frame Address (CFA) */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505121718.3572=
346-1-jremus@linux.ibm.com?part=3D8
