Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79953803EB
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848535; cv=pass; b=ElKiPDux0TK5mSU8JY5jC3gtx28yMAicjXt0/eCiYAxa7lk6L98jtYxYJUo5rMpinC3eIfinHIKHGTYPgQ2rexY/gpMCKJk/UFGEdDFQ88WywoDvZ1PyEab3xQlnYJkW9dQqnp0LaWaWoJFaCARwprXvsUZEkoIKEhj44KO4TBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848535; c=relaxed/simple;
	bh=A8g4Pymc1MEXz3s6wr9IMDJPVnfJWtg9yfQCM6OV9iA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrdNO9hKuCfz1D/Vd7Zr+42l17zrCsgpIj2iiLT9vhLNU7ltvFcViUWZVYBvyYwaaDYeMLXkLoVNB+1TmiZBjXLBaSlluv/dervOm8MdgcAaGaL4Z6wPbK8algYeCCudYeF+3BKJPtXOfB1K69CIoozpTVor1QW8HgxVG+e1sKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzT4efA2; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzT4efA2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d049069377so849965ad.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 09:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848533; cv=none;
        d=google.com; s=arc-20260327;
        b=Rc7Ii16btDJajEs5GEgZs6jDoGsbV1SFnn7/u/69HGNge2AHLi+YCyzEnjQhmhDnPn
         FDySakJyJ2b+vVXDRxbssKbBqsqeLfb/FhMT/bfyJaoBtVKtEuxADQc65dRNb04Ud3KC
         5J7tXazWbdY2xnmODS5Ol++BiyfOdikamhew9kPjWcK3wNOrX3qAN6WhZberLPLUPWPb
         OzvAsGtgQjFenR0TtoFXsnp8hTRefdtTjUyMfNZHfymh0dlvlAthL7ajyr87nxxrDAjy
         Ub0eMtDgYFg3Ae1wcAu3j6l41cGVwe8UIHaE5aDJcYLFSbm2MVs8U+EWtYHP1v6bP7hR
         YidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        fh=51GwTH+QHa/dRBZnNtd5MZVqZKR3LW3ZWSdnM5igCBg=;
        b=dpRLWuXs78trOSdQ7IEWk3pA45K9xSfjN+DqK1JyrPjPa37YGF1PFOEm+oWYmLuVOm
         67VdbeHpq23JGUZFoksCcJtmsXJR5/Kw7T6Ro/dqSs8fqHfWVonkoyxDQ4n0C+F18eg7
         NQs6AlAAiviaP05gHwoG2b3RRDCRAIX+jlGrukZzbXyMHWC/BBh2jV87WiV0G4GN1heU
         RsUgIj7hW4BfwWHpgU3/DTB1UO2akQ1L3GJD9xwqkzmhAa7H88nOEwfOsIG8FdcCd/6p
         VXLQq8V5CeTufHKN0wdc9OSG/U0Xkiu71NCmJZRCmAs6rdX/+Uem6aqjgviI3dhcXJId
         4pKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787848533; x=1788453333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        b=UzT4efA2fiprP1kC8M2qprS74ZTn4n5B6AFBj/UOpsa8GwN310l3PA3oeyIYoOax9I
         6JmTbaGrHL0cX/aLbB1tcoBRgQjZJpoRN52OomnLCmYYBCecqLz9QkCYPLC8s7bSo5cy
         qMD8wn1UPo01BpZcBN6hq87rWVDcLkmjiK2uNRgO5VWbmcZnYikHZ/G8S8cyPU/ZdlbX
         kBIpxXG/T8P4Tq6lS0LNXCpbVRlZn5PTM0dGDfkQJCITFK/GO9S3/o1C79DVFSsc16pD
         zV2NDtdlfVc6mgrXBvYxvsSEt9BNeLYgDFFtQNSsAjbv8I+ZBdpKwAoVfMiqtcVM+Ucs
         9KLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848533; x=1788453333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rpc0eHrdIxpOXoVsl6L+vsh/x6xcGHAy9PMg+4n6EIU=;
        b=ezLAkOFaro89MQrTpLe5gMjhN9GZH+gb432WE8luEw+zlU+WlB5ieFccRei5FrC9bU
         GLofYraTkiqdAxuTqkIkNBUD1fM3ZTkily0r5fHOhQnt1N54SZxpP+f1chp5ah5Z3oYe
         eMBZw8YrDMJuEhOaJWeqhHMkYfFcggLWfviLY6xGwGwPmWKUZj7JFN5a8C36HGly8s4v
         3rUtPI9Bd5QfOFbfCmBUEao7+KglslkjWlL2XsWUEtuQv/4dSSWGdMjbpIfkQgYP/uk9
         PuZ5SGNZfB/LRAykBdUAxwNwkHTN/ghb6F8nGiOawnLcF/vq7plxSQYWvUNDmeDXjyx7
         eQng==
X-Forwarded-Encrypted: i=1; AHgh+RoJe0RAHgMUa7eXSpHjiyrN3yVpwkuN9akeg2jRtaiYZzpwdM7mm4/sevCl35hEcCMpOcM=@vger.kernel.org
X-Gm-Message-State: AFuF++ldqQT8I9C52Rg8QM1X5YW/zScMliegXEyxuo4o10cbPoj8ONZo
	BwTJkSiu14XW6lhjN16uuH0AzrrE4wv1DAjzD3YlXISH5OJOqAYTko3EXycXUoFJc0NlW4JCNGy
	RK4WdwwiUJrSjdPbaG08RxDHjJRlHDIQ=
X-Gm-Gg: AR+sD11AbMxr9fEI82clU0iItXTXUkDHZoI+1nsaETIcn9irk8G1tfd2tR8spYgPhjL
	IbiM8Wuts+zVnm7u3w3TRexid5kigNnYnf/pYfB5H3uX/HUeYgtqt8W8cY5x9KTsSseh4E7JdfV
	L+czBbidit8v4GQ91/uEqPktzEAqchu/eU9ZuI3hULpyix0RUCwA2FZbEwBNamctpZG2TdWv5U5
	qtH3UBvFyn7VmPE1gebKXjmpSjwGunwnoH7zdL1K3utSDplBnCaS0mXfUaf72kMiTWaH6avY1a3
	G7rP9qRdJa2abKImUVMZYwGbHC+4TZcBYbxoy5OZyh37rRKLxGkvzz3WmyTrFw1abV5jYgdPCIk
	DLMOrs3ViOxqyDxOuPmBSidIrb53z37/3qc4r8dD3j/9uCqme0HVEU58snEZ10fAgOxVR9hc=
X-Received: by 2002:a17:902:f70f:b0:2d0:cc92:f7a9 with SMTP id
 d9443c01a7336-2d74dc0da0bmr5053105ad.4.1787848533014; Thu, 27 Aug 2026
 09:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822225444.2774461-1-simon@swine.de> <20260822225444.2774461-2-simon@swine.de>
 <DKYHBHNAMR03.B8SKDLC9FQ94@gmail.com> <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
In-Reply-To: <CAEf4Bzb0YOku2mgpASY_e-tMHfFtEzz4S01ZviH5QBsgzQmx_g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Aug 2026 09:35:21 -0700
X-Gm-Features: AcwNN1UD7kCYmFQWu6pjFf0INYDYIBRN0LWvAetdFdlQdjr9z-bGvTU59CvqtiY
Message-ID: <CAADnVQKD1eOG7cnDHvFwfJOEGZ0g8wZKEzMri27en7uoA-MT5A@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable programs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Christian Simon <simon@swine.de>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, stable <stable@vger.kernel.org>, 
	Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 7:56=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Aug 25, 2026 at 6:20=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat Aug 22, 2026 at 3:54 PM PDT, Christian Simon wrote:
> > > A JITed BPF program can use one private stack per program and CPU.
> > > Sleepable programs can be preempted, allowing another task to run the
> > > same program on the same CPU. The second invocation then reuses and c=
an
> > > overwrite the first invocation's private stack.
> >
> > I'm confused by this. sleepable progs go through __bpf_prog_enter_sleep=
able_recur()
> > which has per-prog recurison counter. So preemption of the prog
> > doesn't break private stack.
> > If the same prog attemps to execute on the same cpu it will be skipped.
> >
> > syscall prog types go via bpf_prog_run_array_sleepable()
> > that have per prog recursions counter.
> >
> > Looks like we're not doing it for bpf_prog_run_array_uprobe().
> > I'm not sure what the right trade off here.
> > I feel universally checking for recursion is better
> > then selectively disabling private stack for uprobe.
>
> I'd really like to avoid adding this "recursion protection" to uprobe.
> With uprobes, there is no recursion, it's called from well defined
> context in the kernel and you can't have recursive uprobe BPF
> programs.
>
> All you can have is a very valid and possible sleepable uprobe
> interleaving, which the user cannot prevent or work around, they have
> no control over this and it's just a fact of life.
>
>  E.g., a simple scenario, we attach one bpf program (let's call it U)
> to some USDT. BPF program U is sleepable and actually can sleep due to
> page faults (e.g., unwinding Python stack trace requires sleepable
> mode for reliably getting filename strings from Python runtime, which
> are not always paged in).
>
> In such a case, you can have thread A and thread B both hitting the
> same USDT (e.g., somewhere in memory allocator or whatnot). Let's say
> thread A hits it first on CPU X, BPF program U starts executing and
> unwinding Python stack, does bpf_copy_from_user() for string contents
> and causes page fault, is taken off CPU X. Meanwhile thread B hits
> USDT on the same CPU X, kernel runs program U, and it is supposed to
> work completely independently and concurrently (no shared state or
> whatever) from U's execution in thread A.
>
> Yet, if we add this per-CPU "recursion check", we'll just skip U's
> execution for thread B. This is data loss, and it's very bad in
> practice because it frequently just invalidates the entire data
> collection trustworthiness.

ok. fair

> So I think we should disable private stack for uprobes (sleepable or
> not) instead. I'm not sure private stack buys us anything for uprobe
> cases.

why disable priv stack for non-sleepable uprobes?
While non-sleepable bpf prog is executing the same or different
uprobe cannot execute on the same cpu.
So bpf prog can be preempted by kernel execution,
but a user task cannot start preempt bpf prog,
so 2nd uprobe cannot start running,
no?

> As Jiri mentioned, at verification/jitting time we can't tell kprobe
> from uprobe, though, so that's a bit of a problem, but it's a separate
> discussion we should have. Perhaps having an extra expected attach
> type, or type, or some program flag to designate uprobe program as
> such would be appropriate, not sure. Let's discuss that.

we don't have sleepable kprobes.
So disable sleepable && [ku]probe type is enough. no?
