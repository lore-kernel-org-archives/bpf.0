Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BD3B1035
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068028; cv=none; b=eyaVyW68GgiCSK7TzBjPCEQ69ypnhKWo5o3eQiPd+09VJbnkbvEGETQ4ODyNn1FCEkoxtdyxfml8dbtMKZyyRp31IqEeNuGHIpqz1y63anNVWyde8WahqWWCxGdDHpqFsCk8XZZhj/K97PZMZzcUdTN760v3v7+vnbepkJEX0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068028; c=relaxed/simple;
	bh=bSXk7KOXPR+3IUX3cqw8JHhdVivrK9r9VZngI9cV3cY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=e2BTZ6w2NMbNWG/VhphyXz8sYQHyBUCst8ded0B4i/h2cD7g/nxdPjBrGwZMn4PA1j3T/yt3WGs7X6OycryYE1/VfhsrXSyihA8lZo05pms5vz88u2gUCUNQYwf7ZnLqH9cPBCYg2wU/O9sM2ZV4/RDcIWkeb67FUAHWR4QhJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gsOBc82i; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gsOBc82i"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786068014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L388HzKXjWWS1JR+DZhWZmkNa/DQHIGZ/f0Zx+Y1zyQ=;
	b=gsOBc82i1wokBnSYxyPeeJpTF+byqm5Nc1P8jfDxCxOo2hz4wEVDGzJQHx5RC4qKw03du0
	imMo/z6o+ETzBuMwOlgWOuZYd9aU03P97ok7jnzw1onlUCsuLYK+WCbdqblTCVnsUhG2kP
	6nYeIC01+fadmTl5W4MMqVhI0U+PT9s=
Date: Fri, 07 Aug 2026 02:00:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Hui Zhu" <hui.zhu@linux.dev>
Message-ID: <4a6ee31b46b732eaad76b955d95c8cc261941894@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2 0/3] bpf: Fix UAF in
 bpf_trampoline_multi_attach/detach on update failure
To: "Jiri Olsa" <olsajiri@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Matt Bobrowski" <matt@bobrowski.net>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Hui
 Zhu" <zhuhui@kylinos.cn>
In-Reply-To: <anRE9L9HgOIYVCtj@krava>
References: <cover.1785902527.git.zhuhui@kylinos.cn> <anRE9L9HgOIYVCtj@krava>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, Aug 05, 2026 at 12:04:05PM +0800, Hui Zhu wrote:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  This series fixes several use-after-free issues in the BPF trampol=
ine
> >  multi-attach/detach error paths, where ftrace direct-call updates ca=
n
> >  fail and leave ftrace pointing at freed memory.
> >=20
>=20hi,
> I need to stare at it bit more, but tbh I'm not sure the benefit of
> preventing hypothetical crash is worth the extra complexity on the
> detach side
>=20
>=20IIUC we can't reproduce this error without instrumenting the code, ri=
ght?
>=20
>=20jirka

Hi Jiri,

You're right. I went through the failure paths and the realistic
triggers basically don't exist for a normal user:

The allocations are all GFP_KERNEL (reclaim + OOM handle them),
and bpf_jit_charge_modmem() lets CAP_BPF callers exceed the JIT
limit, so ENOMEM doesn't get there.
-E2BIG is attach-time, before cur_image is set, so no UAF.
SHARE_IPMODIFY -EAGAIN needs livepatch on the same function and
is retried in bpf_trampoline_update(); the multi path where it
could escape needs a second failure on the undo del, which doesn't
do ipmodify negotiation, so it doesn't reach the UAF either.
The rest is bugs or not user-driven.

So this is fault-injection territory, and I won't claim it's
a customer bug.

I'd like to drop patches 2 and 3 and the prog-side machinery
(pinned_prog + rollback + the trampoline leak).
And keep only the one-line image-side fix in patch 1: only free
old_image when it differs from cur_image.
It's obviously correct: if cur_image =3D=3D old_image, ftrace is still
calling into it, so freeing it is wrong. And it costs almost nothing.

Would you prefer I proceed with just this single patch,
or drop the entire series instead?

Best,
Hui

>=20
>=20>=20
>=20> Patch 1 addresses two UAF scenarios in bpf_trampoline_multi_detach(=
):
> >  the single-point unlink failure path (old_image =3D=3D cur_image) an=
d the
> >  batch ftrace update failure path. A new pinned_prog field in struct
> >  bpf_tramp_image keeps the bpf_prog alive while ftrace may still
> >  reference its image. bpf_trampoline_multi_detach() is made to return
> >  void, since callers cannot usefully react to failures, and
> >  bpf_trampoline_put() is taught to leak the trampoline when cur_image
> >  was left behind by a rollback, so ftrace keeps a valid target.
> >=20=20
>=20>  Patch 2 fixes a similar UAF in bpf_trampoline_multi_attach() rollb=
ack:
> >  when the register-path undo fails, ftrace still calls into cur_image=
,
> >  so the prog is pinned on cur_image instead of being rolled back.
> >=20=20
>=20>  Patch 3 fixes the common __bpf_trampoline_unlink_prog() path, cove=
ring
> >  both multi (bpf_trampoline_multi_detach) and non-multi
> >  (bpf_tracing_link_release, bpf_shim_tramp_link_release) callers.
> >=20=20
>=20>  Hui Zhu (3):
> >  bpf: Fix UAF in bpf_trampoline_multi_detach on update failure
> >  bpf: Fix prog UAF in bpf_trampoline_multi_attach() register-path
> >  rollback
> >  bpf: Fix prog UAF in __bpf_trampoline_unlink_prog() on update failur=
e
> >=20=20
>=20>  include/linux/bpf.h | 20 +++--
> >  kernel/bpf/trampoline.c | 183 +++++++++++++++++++++++++++++++++++---=
-
> >  kernel/trace/bpf_trace.c | 2 +-
> >  3 files changed, 183 insertions(+), 22 deletions(-)
> >=20=20
>=20>  Changelog:
> >  v2:
> >  Folded v1's two detach patches into patch 1.
> >  According to the comments of Jiri Olsa, Pin the prog (pinned_prog) o=
n
> >  cur_image so it stays alive while ftrace may still call into it.
> >  Make bpf_trampoline_multi_detach() return void.
> >  Fix the same UAF in standard (non-multi) trampolines.
> >  According to the comments of sashiko, Fix the prog UAF in
> >  bpf_trampoline_multi_attach() rollback.
> >  Leak the trampoline in bpf_trampoline_put() when cur_image is left
> >  by a rollback.
> >=20=20
>=20>  --=20
>=20>  2.53.0
> >
>
