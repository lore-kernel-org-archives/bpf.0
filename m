Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616564BFE9D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497593; cv=none; b=LCX62PSteBHyNaxnPhHRqoDo+aiuvt0bdxSFLLOz0GtkyFAUYszHCW4d8CCI4/FtKOS42Ps0lltA6Ulnk5WGpHmmd++oX59uBCFzTZEw9rHIDxJFW9H+QTBF2PfR46cXHUjQ4DIzH9ov87WH0W31GYysQgiib6gL5Vmm4gWxrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497593; c=relaxed/simple;
	bh=r7pT69vfL8KLaY3d/Q2bjsDbJ9zI0lbKl6VgdFFxXrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LMif1S12wS45LO9iengizw560dVdDKdEXyH7xy4JkdNn9SefW+KwDaUdQqtzdAqSHehOo9ZATtzRz9RQdcpEDan+pivqVQzh12GEyYKxTRHGW+/8gZYziQCph0ZyEkvrLkYuSqOX9IYvvujIhq4Q1zCgmH6KlZNEOzTjLa1IfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f7oEgX7M; arc=none smtp.client-ip=91.218.175.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7oEgX7M"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r7pT69vfL8KLaY3d/Q2bjsDbJ9zI0lbKl6VgdFFxXrI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789497589; v=1; x=1790102389;
 b=f7oEgX7MXk+DeSMq9wevk5JkhQa0iHRF4pSVPMyTqi3Fr7FFDXD5fG0vsRwB4uoY7e13SZmK
 zeUNhwKyCEceeLanKDsV/R1vRbKJfDLw729LS0aXQq9Now8ge6XfnRwelX8rr1yaffFyW0WD1RF
 llrV5LeICH3ri8QR+BlgniLY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 429d9ecf31e9208d;
	Tue, 15 Sep 2026 18:39:39 +0000
X-Mizu-Trace-ID: 429d9ecf31e9208d
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 18:39:30 +0000
Message-Id: <DLG3Y32QQ9JU.3LNSYXLJIGH17@linux.dev>
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Leon Hwang" <leon.hwang@linux.dev>, "Junseo
 Lim" <zirajs7@gmail.com>, "Sechang Lim" <rhkrqnwk98@gmail.com>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Pu Lehui" <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>,
 "Hengqi Chen" <hengqi.chen@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
 <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>
In-Reply-To: <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>

On Sat Sep 12, 2026 at 4:42 PM UTC, Alexei Starovoitov wrote:
> On Sat Sep 12, 2026 at 2:59 AM PDT, Florent Revest (Anthropic) wrote:
> > +struct bpf_tramp_skip {
> > +	struct bpf_prog *prog;
>
> prog pointer shouldn't be necessary.

[...]

> > +	void *nop;
> > +	void *target;
> > +};
> > +
> >  struct bpf_tramp_image {
> >  	void *image;
> >  	int size;
> > @@ -1374,8 +1389,27 @@ struct bpf_tramp_image {
> >  		struct rcu_head rcu;
> >  		struct work_struct work;
> >  	};
> > +	/* entry in tr->images, the image holds a reference on tr */
> > +	struct bpf_trampoline *tr;
> > +	struct list_head list;
> > +	struct bpf_tramp_skip *skips;
> > +	int nr_skips;
>
> I don't follow why you need link list and 'tr' pointer here.
> Also why keep ip_after_call ?
>
> Replace ip_after_call with array of bpf_tramp_skip { void *nop, *target; =
}
> and then in bpf_tramp_image_put() instead of ip_after_call do:
> for (i =3D 0; i < im->nr_skips; i++) {
> 	struct bpf_tramp_skip *skip =3D &im->skips[i];
>
> 	err =3D bpf_arch_text_poke(skip->nop, BPF_MOD_NOP, BPF_MOD_JUMP,
> 				 NULL, skip->target);
> }
>
> what am I missing?

Ah yeah, I tried to address that in the cover letter. Basically, if we patc=
h
all the nops, tasks running in the old image could skip some progs that are
still attached. For fexit, that's already what happens with ip_after_call b=
ut
for fmod_ret it would be new and this would cause for example an LSM prog's
verdict to get skipped when another prog gets attached to the same hook. Th=
at's
why I thought that patching only the detached prog's nop would be better an=
d
needed these extra pointers. But it's a bit of an edge case and I don't hav=
e a
strong opinion on it.

If you'd prefer the simpler version, I can do what you suggested here in v3=
. If
you'd rather only skip the detached progs, then yeah, I think ip_after_call
wasn't needed anymore and I should have dropped it too.
