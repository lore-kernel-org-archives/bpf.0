Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA0C3CB551
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538587; cv=none; b=Bsj9RZRSLT834aytuWKvmERfj5+Kr8DkiP0ThBacFCkE6U6bho/1UdMfwbsOz7zJNqSLajWaQIqrvVbFqkNFtsp8mRq7dIQu+Ay6j7yDChyfbDftcndD7B/Qs8Q+vVBDWOOcAZ/ORzTPz1Ti33OARu1TMDSI7btp/Futxlw+ESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538587; c=relaxed/simple;
	bh=yetjLlsiC4cpPgypqV5930Zvm9ngmx6a3EUk35TIBqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smsnr0XDBjxQ+dy6KaM9H98vEL1ZR9yuXfgN2LIhRWf9BJWXOcNfaI7Plw6Ye0oWmOTeml2jCCFC8Nm3SUVwyxOlk7ohKtx5/SqfAWWwQwUViXXSMsqjYbcFCJ0Rx2jLeZ6f0CQOUSRh4pUM62HupLCBfhSPt7nJPWuxDBb7jbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+wSCl4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+wSCl4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C778F1F000E9;
	Mon, 20 Jul 2026 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784538586;
	bh=W8DOvGJh4vDjtUp0U+iyLTR+jzaaepZ3O7y+GkIpCnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+wSCl4nikUdIGdJdRrPbBlGhyjSUcKU8uPid6HgFjz9ue/HGTF/dZhk0SmkYkBpi
	 TtFANVYKb/wJ5/iP4gtOSC+93Uc54gcAew78vAyktiFrUESgarqRvTm6EwLq/Lg0Cl
	 A0MRi6KGo/HWX5j+kskoaxtc65E+yuO1iFrLjVsGhiZ5ca5m5mkJnCEe/sWMIUsebY
	 qL+jEQ1VXSWwF8b2H/fX+NLVAGiTHzHmy0Kj8OipGOVZkNMV90duTgZ75Y2h0zdlv4
	 wALAN2G5JqsxZVQ5+32geR6wuNgEIk5r22+ineg7vsD1ipAkKy73/3oaaVmOmyktLR
	 c1fQCrKzSCXrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 8/9] bpf: Remove trace_in argument from
 __bpf_get_stack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720085351.655075-9-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
 <20260720085351.655075-9-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 09:09:45 +0000
Message-Id: <20260720090945.C778F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_get_stack_pe permanently truncates the shared perf event callc=
hain for user stacks.
--

--- Patch [8]: [PATCH bpf-next 8/9] bpf: Remove trace_in argument from __bp=
f_get_stack ---
commit 42ed70b803080e71468d115e2948bdba98a800f5
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Remove trace_in argument from __bpf_get_stack

This commit removes the trace_in argument from __bpf_get_stack and
handles the trace_in case directly in a new __bpf_get_stack_pe function.
This simplifies __bpf_get_stack for upcoming preemption fixes.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index eea7b781300ca..57cd4c33403bd 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -978,14 +1001,13 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event=
_data_kern *, ctx,
>  		skip +=3D nr_kernel;
>  		if (skip > BPF_F_SKIP_FIELD_MASK)
>  			goto clear;
> -
>  		flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
> -		err =3D __bpf_get_stack(regs, NULL, trace, buf, size, flags, false /* =
!may_fault */);
> +		err =3D __bpf_get_stack_pe(trace, buf, size, flags);

[Severity: High]
This is a pre-existing issue, but does this permanently truncate the shared
perf event callchain for user stacks?

In bpf_get_stack_pe(), the kernel stack branch explicitly saves and restores
trace->nr around the call to __bpf_get_stack_pe().

However, the user stack branch directly calls __bpf_get_stack_pe() without
saving the original trace->nr value. Inside __bpf_get_stack_pe(), the trace
size is modified in place:

static int __bpf_get_stack_pe(...)
{
        ...
        max_depth =3D stack_map_calculate_max_depth(size, elem_size, flags);
        trace->nr =3D min_t(u32, trace->nr, max_depth);
        ...
}

If a BPF program attached to a perf event requests a user stack trace and
provides a buffer smaller than the actual callchain length, trace->nr is
truncated.

When the perf subsystem later processes this event and outputs it to the
perf ring buffer, could this result in incomplete or corrupted profiling
data due to the truncated user space callchain length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720085351.6550=
75-1-jolsa@kernel.org?part=3D8
