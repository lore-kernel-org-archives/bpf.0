Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53E3AA50B
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788096114; cv=pass; b=TtuVs4E06nEgiCjfUtxf9Tm/mZ/p2RnGWgSAtCnr3QxNGsiV68ghT9jNqsl+KemGSLGCp3UZDBOFCU88Z22GFyvZWYbapTqndFtPmmPtfD5NXnVQxK6DHmJ23sQdLLjKCKrZVNoZdvjUR1HMH6femslpRW6oNpUN5MKAabWteL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788096114; c=relaxed/simple;
	bh=haDrEQBXtfEJ9vf9T47dmO/EO6kiwNuFMCqiWp38q6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqgC9eEP9hytmf2tmogACwzxixMAHwDLA2ZenB/rbc7qg04JASBMb2Fj9URa6y9290P/qHoBVQVmmisAfATwubpORLQK+yJ3hm5gSKukcGNCtwnabW2S9doDzSoJiMGmC/RDbs0H6TJHaRobUEC+8/LoZP0NB2Z9oNubJgX/pi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3R1Pg/f; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3R1Pg/f"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d91518a63fso2401585ad.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 06:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788096113; cv=none;
        d=google.com; s=arc-20260327;
        b=pD4Fup+5c3u0D7lODo6TNQBSNTbeDkopoaj3J+GtwgTnwujD2qE4dW83B3pHKQRDoI
         BNWmgucq35ROh93F/fSWF7UPSwBRORkPBoI3nHU5xx1sjaEHYf5O75GIf8AElmqln/sP
         sThy8OSMHk1KWTPpB0Gz9LbB37KnqsAoe9yLkJlNxqf4WFiQMoxdFZnUlC/JuJFTrA2G
         o550USrOGXYCsQOGlE30sN4PXCj8+TyiBHyJHSDrhICGQkB1eItXAb0/0WwZPMIlNCvG
         1Y0gxGo8a6XPK/lN8uLhTjfOFIHL26gzVEY+1UE7Z+oFCK9IaNW+T3dVQmKn2Y9fzT5s
         31Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+K2z9Ta+4TdMmha79eI5i9q8koewd9m0IZModZ8QSYM=;
        fh=99NZhs9yOl5y9BjK0MWZkqxjQkNIspQk4afsTHUgKB4=;
        b=CbV60MBi6JZuQqaSe9MjQ5hsZ/DRkvJductAEFg6dLTFrqwvFZs+koGKdZqQMw1WCH
         ehFWecAOl28bWs4IJC/QHBkEaahLrBqI3lmzxmB1J1hqmkDlb0shEgYU/lYfNZ/drjwX
         eR00eHPJf0qgDACYAZI+E0W9bjHo5Q/vGJ0aiCoN4UHJeVyvGZhtCfchQhBswa60yKWD
         BMY6x3UK8ycBJsLN5PGfgA45sLnU5GWYsFc+y17/HSXUDU0llmGBWb5ZWCIvaQqDODuf
         KSKfFqUcp6G77FrKWNgk26ieRXE2VkJ7ul1BTw5UwXmI62gumXEVsmnjbNWm00HKAm7d
         lizg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788096113; x=1788700913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+K2z9Ta+4TdMmha79eI5i9q8koewd9m0IZModZ8QSYM=;
        b=C3R1Pg/f6aOGWETjnhjjJfSZZtM8EoT/MYCeKbuJz8wrEfZzayuTQ7ysPccmSWWd1F
         nnjZEj/dwsIO8g5SQmyJstEDk2kC3RyT7pSovU11yU0r5oSX2kZjRG2IxuQAuOGcS2+T
         WMW3UVKDa3rXmAlkROEaCL3llAxuDxKO2NhSC02srVk3TolUUsgITh7nsMfXOCD2y3U0
         xMjj1pdi/+T80JZjnWHZdUSkRh3tZoeTgAa5XcuyjuZfdzXPLVOK/iqnXSAaEOWXP6tb
         S+JXdbAE9ISbwgzEQLIeE53PylJjzdmW8sN4Ui4Mt2tABk7iBJ/+paNnq3z8pZR+8O7Q
         9Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788096113; x=1788700913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+K2z9Ta+4TdMmha79eI5i9q8koewd9m0IZModZ8QSYM=;
        b=oiaIM+Kx1vGvXL4GwdHWLSJQWJooSgMerhm39qv7IzI32OeNNHGkiH+opuhtGMvDJ7
         l+ACRM3Sr/DgmRaUGlV55rBVKjR4AbmcURSInIa+Hbz81lzaKHB2JtoZv/RNtQF0wZXf
         CUmZt8ifeH2lSlILsKJRV50hOrMWIhZUHCCNiPCTUEFuh7eHs2vDnhwNAGykx5Kugzb/
         fji4owveF9wKgjCF0belsg2uN0YzO3X2n/9ls9oUNBSwI0Mrw/dlgyf/KUSaFW7XeNXb
         RVbq4yHHa95+V3AghFv0/fr2//J0hGdETYYahPOvWLbqSzrvw4+oZil/Y44qJUQXyBbb
         7f0g==
X-Forwarded-Encrypted: i=1; AKwUvByuzA9zKaccBtIN1Y6iE+INjw5UKjTVe5PdpIq4opT397rJ7o2Ufanx7bL0wB0oR0DtLWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mRNJKP325aDpW1oPsKE1Yk9BjdmT9JVyOc1Oox9jCRjOU9rW4u
	AgW9Uoj1v60evZlG9dpTJ7zPnJ2q15fFGxFQlbk0xpuvUYNzNLU/A8s718ODhTAP8FfCeYAUUvN
	bfNej1HemoOR7Kybvd/g+9jTPgnd/eyB6wA==
X-Gm-Gg: AYBFou0VlQYN3cj32CpXBjN5sHMwXkRZiD9iWNjx6+XixObLKeYqkpuXzBPUGL3zx0b
	qqDfy13d3xtE6kWpyH6VuyVIO6i5PClaXOdDg0zVofhHAY+HGZTH3/Z7cDO466jj3e5P+hFRZiN
	GGcos6dOxF4yQKaTMteaKXANKqt7D9F0V0gxBkWtdCXBXc147Xck+LQcnXh+b7b5ReRheikvoI+
	NgGtw08PPKFfG1csKsVDEmKzKvPashnrbtGkl0PViSQzQHXtFIRig3ORP9IYfXay2Z23j4bqYR+
	GfqUXU1Q0gmbkEf2X1v3K/oTPvpoEI5HPdyLwvs32Mp1OSCdPD2YD7YVVB2bBJBVqPS58Xbmry6
	CeTabX/tObFpRIHO4WF7n5V8110Jg
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2d74dca2281mr301125665ad.2.1788096112529; Sun, 30 Aug 2026
 06:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819122252.1782790-1-florent.revest@linux.dev> <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
In-Reply-To: <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Aug 2026 06:21:40 -0700
X-Gm-Features: AcwNN1V77NpzupfrZRTf-r7nZ8aENXPYboXW_s1oiE-74fHmSTulmHRLnx4rpiA
Message-ID: <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jose Fernandez <jose.fernandez@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 3:41=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Aug 19, 2026 at 2:22 PM CEST, Florent Revest (Anthropic) wrote:
> > bpf_tramp_image_put() makes sure a trampoline image is not freed while
> > a task may still be running in it (call_rcu_tasks() + im->pcref), but
> > nothing similar is done for the progs called by that image. Since
> > commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> > return path so that a task still in the original function skips the
> > fexit progs when it comes back, and counts on the prog's own RCU flavor
> > to cover a task that is inside a prog. On that basis the last prog
> > reference is dropped right away and the prog is freed after a single
> > RCU / RCU tasks trace grace period.
> >
> > That leaves out a task in the trampoline glue itself: between two
> > progs, or already past the patched jump but not yet in the first fexit
> > prog's enter helper. On !PREEMPT kernels this is a few instructions
> > that cannot be preempted, so it did not matter. With CONFIG_PREEMPTION
>
> I guess it would make sense to highlight why it may not have mattered. I =
think
> the real reason was that on !PREEMPT kernels, the execution in the trampo=
line
> image counted as (implicit) RCU read section which caused program free pa=
th to
> wait for someone executing the trampoline image? For non-sleepable progs,=
 they
> wait for RCU grace period already, for sleepable, RCU tasks trace has imp=
licit
> RCU grace period wait as well, hence this never showed up on !PREEMPT.
>
> > a task can sit there, in no RCU read section of any flavor and holding
> > only im->pcref, for longer than it takes to free the prog it is about
> > to call:
> >
> >   CPU 0                               CPU 1
> >   in image I, orig_call() returned
> >   [preempted before lsm.s prog A]
> >                                       bpf_tracing_link_release()
> >                                        -> bpf_tramp_image_put(I)
> >                                       bpf_link_dealloc()
> >                                        bpf_prog_put(A), last ref
> >                                       tasks trace GP, A's text freed
> >   __bpf_prog_enter_sleepable(A)
> >   call A->bpf_func
> >
> > On x86 this is an int3 in poisoned bpf_prog_pack memory:
> >
> >   Oops: int3: 0000 [#1] SMP NOPTI
> >   CPU: 18 UID: 0 PID: 94573 Comm: x169 Not tainted 6.18.44 #1 PREEMPT(l=
azy)
> >   RIP: 0010:0xffffffffc0601d8d
> >   Call Trace:
> >    <TASK>
> >    ? bpf_trampoline_6442515411+0x1a4/0x21b
> >    bpf_lsm_bprm_committed_creds+0x5/0x10
> >    security_bprm_committed_creds+0x5f/0x70
> >    begin_new_exec+0x2d6/0x410
> >    ...
> >
> > We hit this in production on preemptible kernels when progs attached
> > through trampolines got detached while their hooks were busy. Adding
> > grace periods before the prog free would not help with sleepable progs:
> > neither RCU tasks nor RCU tasks trace waits for a task that slept in a
> > prog and then got preempted in the gap after it.
> >
> > Fix it by having the image take a reference on every prog it calls, in
> > bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
> > detached prog now stays loaded until the old image is gone, which
> > reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
> > trampoline."). Detached fexit progs still stop being called right away
> > since the return path is patched.
> >
> > Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> > Assisted-by: Claude:unspecified
> > Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
> > ---
>
> Overall, looks good to me. Thanks for the fix!
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Note for whoever applies this: please add Reported-by: tag for Sechang as=
 well.
> Optionally, wordsmith the commit log with the suggestion above.

Hold on. I don't think we can proceed with this fix.
It defeats the point of fexit jmp patching and keeps progs
pinned until a sleepable kernel function that were attached to
will return. Which means that the tracing prog attached to "unlucky" kernel
function that sleeps for an hour will stay pinned for an hour.
Let's think of a different way of fixing the race.

pw-bot: cr
