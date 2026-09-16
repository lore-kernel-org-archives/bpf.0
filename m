Received: from mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F744B69C
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545160; cv=none; b=mVnsnvyhsKR19LH5XskLmRE495gCOl7RLeQAn1sU4r9hgRi8WPEpLBRTDuOEk6z8sV5cPDYdOidNZILKcF8Fl4jz5mYKm/XG3TxNkwSxVdLTwmweiMG2o/Us/CsBovwEMsP1pw9RPw2dqWcov2qPVX29oAL4g0UYpXaynW3ZBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545160; c=relaxed/simple;
	bh=AGXORyCsk913kO+VsFSEHaTAWEdeNo95eaqf+tbuC7g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=SJppreV2cNhAk3pSe/Q/RF0pEmaABhSdA1Ptu71t/+Rlf2jHhmH6njxjE+f25Bfal9iqdOeXR+FBeciQ3Wj8sBFTb+FuqT3ascJ5yQBYc3/YUFA0C1JN7ZOgOnQDng8Ik+wh/wESJPsmFlqsQqMyBIaX4VCqYBFog9DYDWNM6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWyFe70O; arc=none smtp.client-ip=91.218.175.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWyFe70O"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AGXORyCsk913kO+VsFSEHaTAWEdeNo95eaqf+tbuC7g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789545151; v=1; x=1790149951;
 b=cWyFe70OeV2xQGvwFQjwL6/lsjhK3XyqtfJ8LfMHNln2rd+f6l5w4FHSIDbsmB5i2lngP09W
 ALzjCoJo3EM51fC8+cFPdkmfmOhhMzXPDdbfViihDU0d8knX24RPjC8Ydsd8cE1XA98mhCa2dMg
 w1dNFVdBOTErBCpvmfbOeAzs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4d980cb76d01b755;
	Wed, 16 Sep 2026 07:52:31 +0000
X-Mizu-Trace-ID: 4d980cb76d01b755
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 07:52:26 +0000
Message-Id: <DLGKT6Z7ULBJ.3SKG7CYVTUAJF@linux.dev>
From: "Florent Revest" <florent.revest@linux.dev>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "KP Singh"
 <kpsingh@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>, "Leon
 Hwang" <leon.hwang@linux.dev>, "Junseo Lim" <zirajs7@gmail.com>, "Sechang
 Lim" <rhkrqnwk98@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
 <DLDHKKLCOAVR.3PHQ832S121Q2@gmail.com>
 <DLG3Y32QQ9JU.3LNSYXLJIGH17@linux.dev>
 <CAADnVQL=sW1-UOUbP_j98G2eY4MPzQd=HbP-7q5-sjqFQya=Rw@mail.gmail.com>
In-Reply-To: <CAADnVQL=sW1-UOUbP_j98G2eY4MPzQd=HbP-7q5-sjqFQya=Rw@mail.gmail.com>

On Wed Sep 16, 2026 at 5:29 AM UTC, Alexei Starovoitov wrote:
> On Tue, Sep 15, 2026 at 11:39=E2=80=AFAM Florent Revest
> <florent.revest@linux.dev> wrote:
> >
> >
> > Ah yeah, I tried to address that in the cover letter. Basically, if we =
patch
> > all the nops, tasks running in the old image could skip some progs that=
 are
> > still attached. For fexit, that's already what happens with ip_after_ca=
ll but
> > for fmod_ret it would be new and this would cause for example an LSM pr=
og's
> > verdict to get skipped when another prog gets attached to the same hook=
. That's
> > why I thought that patching only the detached prog's nop would be bette=
r and
> > needed these extra pointers. But it's a bit of an edge case and I don't=
 have a
> > strong opinion on it.
>
> Hmm. Not sure I agree with your reasoning.
> fmod_ret progs are called _before_ orig_call.
> So fentry+fmod_ret are in the same category.
> Adding/removing a prog to the trampoline causes regeneration
> of the trampoline.
> So cpus may execute different numbers of progs already.
> The race is inevitable.
> With 'patch all nops in old tramp' approach the only
> additional race is some of the fentry/fmod_ret progs
> will get skipped in old tramp.
>
> If the concern of a tiny window where old tramp is started
> to be destroyed, then fentry prog is called and we patched
> another fentry, but tramp will continue and execute orig_call,
> then, yes, I see the issue, but it's a lot more subtle.
> If I understood the concern correctly then let's add
> another 'jump over the call' nop in addition to
> 'patch nops in front of all progs' and
> let's patch 'jump over the call' _first_.
> This way fentry/fmod_ret progs can never miss
> execution of orig_call. They can be invoked "unncessarily".
> They may execute though orig_call will not fire.
> but that's an acceptable race. Better than not executing
> fmod_ret while letting orig_call to go through.
>
> This is still simpler implementation than link-list all all extra book ke=
eping.

My concern wasn't orig_call running but rather progs that are still attache=
d
getting skipped. Say, fentry progs A and B are attached to a function and a
task is sleeping in A. Someone attaches C, the old image gets all its nops
patched, the task wakes up and skips B even though B was never detached.

But it's a narrow window and it needs an attach/detach on that function to =
race
with, so if you're OK with that behavior I'll respin v3 with your simpler
version.
