Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B73A3816
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851626; cv=none; b=axvO6qHa3lWaX9f84N9zRpf++DQmOb6NuBEMllgnttSHxCEqM2kv/4tUywSPdvZjC7cFM8n04Hn+7EVMq14FEY8xITLrJrXwN3SS3cxC8dnYHzs6GgpbGTmWKe0q7iB47UzSawr3nBLp3xJY24Wz1Avb5fiF95O0v7+gyzLbEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851626; c=relaxed/simple;
	bh=l27s0J/y3Yf9D+zqfTOZCaLdxIAArarBG5pm21qnnkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWd5J/L1rUTGb6o5bTX86szYhJImhHahIHNAmib0P9Lu70I94DiuhfzFVBkPmGS5SbaeSAoi4dRvkvjr7xuR8c4qxv3ieVdStEqEL18YQkrayWZR8MXQ2lMM4Ybnpz4Rv9Z4DM5ZjCGrSR98ZPvcCbux87CGC3VksyEGgICRmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfKtBab4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfKtBab4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7001F00A3A;
	Tue,  8 Sep 2026 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788851625;
	bh=AuWUVeGjWCR153Ahxdn/vXPiG5DzskJUlpa4vLdJEJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PfKtBab4imHjweSJJCDIaw6n7r23XbzOrQC0yKF2JcG5GfA0kldotGHCDLZinMQS5
	 bl4SnOdGVdytcw5n1iAt1gEDoCJ25fspO5TD5jYgvQkMc+w9eYi7CNlxlAgcUoA2hI
	 Njei5ELUVxSHc9EwTbdy4tcaSBCI/DeKLtd1wcgRCfskH8AUpNsZAW4068p9gnw1pO
	 RwnpGPNn8KSz6I47H+DwnfVoifsLm2fp9Xwma8W4UhZzo9kGi8YYnY1wpUq0vPN52a
	 9dqtPYjyGSSy87q3M8w3fXTnGWQL/xi7fEs0+tz+tCCoKuIHY/oJTEMH0SkrB+1fJv
	 BD4Fal+j3c0Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpftool: Skip non-autoload programs when
 generating light skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260908065529.901593-1-tweek@google.com>
References: <20260908065529.901593-1-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 07:13:44 +0000
Message-Id: <20260908071345.6A7001F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Low] Generated light skeleton header fails to compile for objects with o=
nly non-autoload programs due to a missing `links` struct.
--

commit 476d6487301750ab1f480a6655fe84b67748df84
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

bpftool: Skip non-autoload programs when generating light skeletons

This commit modifies bpftool to skip non-autoload programs when generating
light skeletons (-L). This prevents the generated loader program from recor=
ding
file descriptors into incorrect skeleton struct fields.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521c..0fcfe20ff5158 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
[ ... ]
> @@ -1415,6 +1428,8 @@ static int do_skeleton(int argc, char **argv)
>  	if (prog_cnt + attach_map_cnt) {
>  		printf("\tstruct {\n");
>  		bpf_object__for_each_program(prog, obj) {
> +			if (use_loader && !bpf_program__autoload(prog))
> +				continue;
>  			if (use_loader)
>  				printf("\t\tint %s_fd;\n",
>  				       bpf_program__name(prog));

[Severity: Low]
This isn't a bug introduced by this patch, but by skipping non-autoloaded
programs, this patch can reduce prog_cnt to 0 for objects where all programs
are marked as non-autoload.

If prog_cnt + attach_map_cnt evaluates to 0, the links struct is omitted
from the generated skeleton. However, gen_trace() unconditionally generates
code that relies on the links member:

tools/bpf/bpftool/gen.c:gen_trace() {
    ...
	codegen("\
		\n\
		...
			skel->ctx.sz =3D (char *)&skel->links - (char *)skel; \n\
		...
    ...
}

Can this cause the generated light skeleton header to fail to compile for
objects with only non-autoload programs? Does gen_trace() need to be updated
to handle the case where the links struct is missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908065529.9015=
93-1-tweek@google.com?part=3D1
