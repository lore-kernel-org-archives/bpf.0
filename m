Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E4384232
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786650183; cv=none; b=FSIj4HYJJaBWee3Jn9336FmW4XnrrkZjtlVbIgs4zDClnrxHL30ITgu91232DSsoUrSavL+/oNsCbDL4vPTw2cIo7xiaabhVYCd9TPaeaKLTBKS1QJEhDuWSknKoQSajd00AnIhBf5KppotwFxL9yV8n25TtuLADPgU90V0km0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786650183; c=relaxed/simple;
	bh=vNqTXa4f3kXod9xt7uHR1kOJfCPzakyofaeNGI2BCXo=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=DdL2wjXdImxWxLeR9zy8EUit5v8qhwKRzvHh6NQdetsiSd9AEBl2v538rqRVpeHsO8VQAWKGFmqWtgoFPUwBaZpScUsuQgX/TQqokJ0o1GOkDikxoPZFGXR4+1kzAcveSveY0Bqu8DRiZDoY1rfBht42MsCLVq9d+ChWuQgS6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TIxdaUi0; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TIxdaUi0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1786650178; x=1786909378;
	bh=vNqTXa4f3kXod9xt7uHR1kOJfCPzakyofaeNGI2BCXo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TIxdaUi0CXtAfa47tOubD77chAguojHePRaCOgSJIPpMUEpOFP/317Ok5M3qOjEyv
	 q/GH70C5Eg9s8PuAyA8sqnZfEh+IuL9YgV69AkpmwPU/d3BP4LBO11BBdEEtPfW3p+
	 lxfNhbK0x9sYl1ld49nsoXndRk4T3C7D8IR5nlf646MvCHeRLXj2FmtoR3aeIR8p7N
	 UQb9Un+bnKXaqx73Wue8opYeW0PU+GpuYWojU58TiQR/EDKqpJEqiHh213Jjo1SBGC
	 8iek0Id6D1rTI9OIOb1zKB8am/d4hBzzrr3a1QhecL/27Nnl7ASGVRbWpcQPBHVnms
	 luKQqVE1iNRSg==
Date: Thu, 13 Aug 2026 19:42:53 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: tkwu@pm.me
Subject: BUG: bpf: freplace of iterator global function requires bpf_iter_<type> name
Message-ID: <AyAj3bTqZ30lo9rs1fqBKO0Vk7CJqGfxcmHqHhmmEBpxlQxf0M4lfKOmSE_MbTVLhhxeFUx1PbyX6oZKq8Jh54h0pzjEFtXlRSqi4m6DcQA=@pm.me>
Feedback-ID: 180442703:user:proton
X-Pm-Message-ID: 582f61167f650530994648de8d79a79f9bea86a6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I believe there's an unintended behavior when an EXT prog attaches to a BPF=
 global function used by an ITER prog. The global function name is required=
 to match a registered iter type (e.g. `bpf_iter_task`, etc.) in order to p=
ass the verifier. However the freplace target is just a BPF global function=
, so I don't think its name should be subject to the name validation in `bp=
f_iter_prog_supported()`.

For example, an ITER prog that uses:
`__noinline int foo(struct task_struct *t) { /* .. */ return 0; }`

an EXT prog freplace'ing `foo` is rejected unless `foo` is instead named so=
mething like `bpf_iter_task`, `bpf_iter_tcp`, etc.

It looks like this happens bc the verifier path for EXT prog sets `expected=
_attach_type` to the target prog's attach type:
if (tgt_prog && prog->type =3D=3D BPF_PROG_TYPE_EXT) {
=09env->ops =3D bpf_verifier_ops[tgt_prog->type];
=09prog->expected_attach_type =3D tgt_prog->expected_attach_type;
}

in this case `BPF_TRACE_ITER`, which funnels into `bpf_iter_prog_supported(=
)`:
} else if (prog->expected_attach_type =3D=3D BPF_TRACE_ITER) {
=09if (!bpf_iter_prog_supported(prog))
=09=09return -EINVAL;
=09return 0;
}
`bpf_iter_prog_supported()` then does checks on the attach function as if t=
he EXT prog were a full ITER prog.

I'm not entirely sure if the EXT prog should inherit all of the ITER-specif=
ic verifier checks, but I believe the global function name shouldn't need t=
o match a `bpf_iter_<type>` name.

I also noticed another related issue involving `cache_btf_id()`. After usin=
g a valid `bpf_iter_<type>` name, subsequent changes to the global function=
 name only appear to require the `BPF_ITER_FUNC_PREFIX` prefix. So for exam=
ple, after using `bpf_iter_task` as name, changing name to `bpf_iter_foo` o=
r even just `bpf_iter_` now passes verification when it previously did not.
I'm not completely sure I understand what `cache_btf_id()` does, but it app=
ears to make passing/failing verifier dependent on whether a "valid" `bpf_i=
ter_<type>` name was loaded and cached first.

If what I'm observing is a bug, I can put together a patch and selftest.

Thanks.
