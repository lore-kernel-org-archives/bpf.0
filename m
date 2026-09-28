Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA048F82E
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585462; cv=none; b=H9kTFMfn3+7HkfzbPqr3Gfe0kM389bU3E5wc/fMEU//71WwaII/PPIjQC6h/jac4rEUFpOE3gnvbvixaYQhAhMxUEE2J2pfXH2ekFn4hna/rSUt8N+0Wou5cNDWlKCGAXK5dpWv+Ihbg8bm1ilVEhhdA6LuSwIX7SBPZ5Ty3CaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585462; c=relaxed/simple;
	bh=09WBzyqcOHBSt5hLHqAwbTciP1G0S+c8iry/IFi/HlI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NB01grjr1Xr2KFuMFOsl91MX7ip78eEHj76P6M9KLQn0fIBQ8V7J8aePOLNRJge+ltHrleNJbu2xneFOiOn+Sk1WcMLYuMtlyeBqRKXKUPc5sfvDjMgRZ/8Do6C9oV6n2ZdfE62SBWmiV6B/7SBedl7v9bkC7wJSFLADCBG1GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CgWoLLGC; arc=none smtp.client-ip=95.215.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CgWoLLGC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=09WBzyqcOHBSt5hLHqAwbTciP1G0S+c8iry/IFi/HlI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790585458; v=1; x=1791190258;
 b=CgWoLLGCEWvFIpu2stwYKXLjwNJHsGBKgRrsOVAXsJX4m5XtA2uHzqbFI6j0QwaUo+OOXceN
 DkrP+8DVXSdE0Eca5n5ZtakjSjb50fy6UumPnNCjYGxAj3JPtQr29aN4vobT6FsFchCRR+y7eYP
 2Y9RLM4bjDNXIiqIdytCBFV8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dcca5a333ecbdbdc;
	Mon, 28 Sep 2026 08:50:58 +0000
X-Mizu-Trace-ID: dcca5a333ecbdbdc
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 08:50:55 +0000
Message-Id: <DLQTKIGNXKLS.1E0Y9RS93S82N@linux.dev>
From: "Florent Revest" <florent.revest@linux.dev>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <kpsingh@kernel.org>, <john.fastabend@gmail.com>, <leon.hwang@linux.dev>,
 <zirajs7@gmail.com>, <rhkrqnwk98@gmail.com>, <puranjay@kernel.org>,
 <xukuohai@huaweicloud.com>, <iii@linux.ibm.com>, <hbathini@linux.ibm.com>,
 <chleroy@kernel.org>, <naveen@kernel.org>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <yangtiezhu@loongson.cn>, <hengqi.chen@gmail.com>,
 <linux-kernel@vger.kernel.org>, <aou@eecs.berkeley.edu>,
 <agordeev@linux.ibm.com>, <alex@ghiti.fr>, <bp@alien8.de>,
 <catalin.marinas@arm.com>, <borntraeger@linux.ibm.com>,
 <dave.hansen@linux.intel.com>, <emil@etsalapatis.com>, <hca@linux.ibm.com>,
 <hpa@zytor.com>, <chenhuacai@kernel.org>, <ihor.solodrai@linux.dev>,
 <mingo@redhat.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kselftest@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
 <loongarch@lists.linux.dev>, <maddy@linux.ibm.com>, <mark.rutland@arm.com>,
 <mpe@ellerman.id.au>, <npiggin@g>
Subject: Re: [PATCH bpf v5 1/3] bpf: Wait for an RCU tasks grace period
 before freeing trampoline progs
X-Mailer: aerc 0.17.0
References: <20260926135605.1217928-2-florent.revest@linux.dev>
 <9d932a22ca908da9378ea281633ddb749453911ac6ae7a27a09e376f9ad02ff7@mail.kernel.org>
In-Reply-To: <9d932a22ca908da9378ea281633ddb749453911ac6ae7a27a09e376f9ad02ff7@mail.kernel.org>

On Sun Sep 27, 2026 at 8:41 PM UTC,  wrote:
> > bpf: Wait for an RCU tasks grace period before freeing trampoline progs
> >
> > When a prog is detached from a trampoline, it is freed after an RCU
> > grace period, or an RCU tasks trace one if it is sleepable. This covers
> > the tasks that are running the prog, since the prog's enter helper take=
s
> > the matching read lock before the prog is called. On a preemptible
> > kernel, it doesn't cover a task that was preempted in the trampoline
> > just before the enter helper. That task holds no lock yet, and it calls
> > the prog after it was freed:
> >
> >   BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x3=
f0
> >   Read of size 8 at addr ffffc90000055040 by task candidate/110
> >   CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g1=
5071f2a1263-dirty #2 PREEMPT(full)
> >   Call Trace:
> >    <TASK>
> >    __bpf_prog_enter_recur+0x3a5/0x3f0
> >    bpf_trampoline_6442509193+0x37/0xf1
> >    __x64_sys_futex+0x9/0x410
> >    do_syscall_64+0xb0/0x530
> >    ...
> >
> > Wait for an RCU tasks grace period before the existing one when freeing
> > a prog that was linked to a trampoline. An RCU tasks grace period only
> > ends once the tasks that were preempted have run again, and
> > bpf_tramp_image_put() already relies on it to free the image. It doesn'=
t
> > wait for tasks that sleep in the trampoline, the next commit takes care
> > of those.
> >
> > Only progs that were linked to a trampoline can be called this way, so
> > bpf_trampoline_add_prog() marks them and other progs are still freed as
> > before.
> >
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
>
> Is this the right Fixes: target?
>
> The race being closed here (a task preempted inside the trampoline image
> before __bpf_prog_enter*() takes its RCU read lock, while the prog is fre=
ed
> after only a regular RCU or RCU tasks trace grace period) appears to pred=
ate
> e21aa341785c.
>
> In fec56f5890d9 ("bpf: Introduce BPF trampoline") bpf_trampoline_update()
> switched images with no tasks RCU wait, and __bpf_prog_put_noref() freed =
the
> prog with a plain call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu).
>
> Just before e21aa341785c, the synchronize_rcu_mult(call_rcu_tasks,
> call_rcu_tasks_trace) in bpf_trampoline_update() ran before
> arch_prepare_bpf_trampoline() rather than after the new image was install=
ed,
> and the total =3D=3D 0 unregister_fentry() path had no wait at all, so a =
task
> preempted in the old image could already reach a freed prog.
>
> Would Fixes: fec56f5890d9 ("bpf: Introduce BPF trampoline") be more
> accurate, so that stable trees without e21aa341785c also pick this up? Th=
e
> follow-up 49ca60187380 in this series uses the same tag.

Yeah, that seems right. It shouldn't make much of a difference for stable
because both have been introduced in the same 5.10.y. I can either switch t=
his
if there's a v6 or a maintainer can change when applying.
