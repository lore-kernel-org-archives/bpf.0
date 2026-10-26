Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055393;
	b=NaG37efTFJYhupU63NBHKecjTa6OUY3xrtXhdej/+33Y9I3UQUPYUb3Wkgtfljai5FpE
	 QVP/ku0z10GltS4isyNDYUMg96Ak7GfCvwGjERONwGYbzXao2igsUCaHyQMHBOzWHC/3J
	 hEek2Ut8KXqnocat6luqia3r1vXfd35NCzG3cTR9gskYzTosZej4AUzQKTIZN5sk+Y0+t
	 STTrGSSNAvznSf7IJbKLWJWhGCG7cHFCXl/FEDWglJDi3gXyi+1un/fIGZnanZ50Sgc6b
	 u3CjPp7i0vTBYNHDSGnXr1AdePm/U9jGf/Q5hGBUAXtzEdp5JZnOMHQ6tGiFgwHo2qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
	b=RrS4t5skiwP0YfzNs98jdwKD+0nUswiEADUn2E5zSG7ElkwyIkYSsuwc+Vibp354rT96
	 jNoCdVCbSgNWWi5sh1Pc17IjdPhC3znvAHdRkE2VZko9zlMJfUqH+CMsBPc0KZm5jp6Sj
	 Uc9E4xyu/LCMd9htR9TIxky9azQsRub22dBFrsmg42h0pep2kUpThwjG4T7MpeQuWg7yK
	 HhvPTO4r31kW7ObSGfYykodZSrHOzqRMvWUVSKMX0yA3Mqe0hO0UaTHu/t+VTGUsT3PSK
	 +U5tx1xGsiOkQFwtzbi1Hj2TezW6vAApPZEXIPqi5BH3oBGFjVTcpap5tqFm/pjeGDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9E606A31F
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED9E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c423b145922so479997566b.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055391; cv=none;
        d=google.com; s=arc-20260327;
        b=L8QZEdQwZz2860FoZJhTZNBqvH4Ty9vFqD9EJ1f/92Sk4gOEiHczPgcHXvAXuVZpnH
         Pd1DcGlfAt0PDKSTJa7PCBjG9DyRe/hlwB8LvoVmbbkg3LWcBy1dSvE0drAYUaOPte47
         89x7w+3skvTZjSSWKo4/dmajWbjhPJ6L0tRtDgEnFgOwfkAtvU9f/dD1+2zO8aThaJCU
         UIDgxkBWAzchDHhGbbVOzFNUA90b859efqVGauCahahRpPJXh5HAJTokfH7Sebr3+laB
         riBppfSo3KHgarHbK0XS6dsnsGuMnPRtc3vcS/tz75JwT6ks+tlKnNpEk6v39ZOszmen
         9PqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        fh=A5NM2DIl9E3TfdnYTvWfBwhOsh3bm5gBhj20Mhi+GbQ=;
        b=lp0BVyF9IHCr36vn8ukNuWuGeN3fCiFM/6cjXWmecYfCiRg7JfBXT7QQlDqLKcJYLH
         FAG9bzPzLfrOTr1G/WB9/y+DhgF5AfFFKHR9abMmXMmzvKZwjok5wlPg4WWrro0qRGoz
         B2Yd71wmnIG5bp5yxn034BbUVxv4injHRMYUy/Mfq+9k+cG1bX+pn06S45xneRQPANr+
         x3aEHUtM5Tn07L1ht61vPc3XjJAOufolLi2r7ZKHO/AuUUwE5FKj4ImNYS/+RZHLy9xz
         iUDSzzHq/xP0mlAE1jBszBl3Tg67+APTieDHC6V3gZxkTkRxvr+rHvzhF4kLrG7KpX4g
         y9PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793055391; x=1793660191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=s8grGiR3jmOk9ry50/nEnZjaxWjWOPyppi2m4MHQTMfb5el8k0obk5/UMSWfPsQmIM
         HPtLzsEa12OcSsVXiRmiCNw+UUDDo1UYyS6DiU9bwXoKmoGF82ns9DjJzrfs9pJWdjkT
         dIxIeAf/R+LNQl/XTj1bdocyLOLlTkNfh75pW2KuZcZpn6JGMaXwZms8i83nnm2msMhG
         qxuIapSALuC5I4z0EKwNizZvGG6PaVYwrsYFc03clQ+zaffY9Yi7+Rd9DeVq8TqQMsPo
         mOa9KjkQgAnBHYiQJzjduIMO8ab1In9zxpTDESz20wql691IHa3z4eYMgIiR+VfFmdpS
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055391; x=1793660191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=Tq4B8e7YGWjjgGRLj8dcWs89K8AU1qa7dNu0/EWXeLHmqOO8wqHGsVA/NNZ1Bp4AmC
         2wR3F+kBo/wVoYLHf4/If3Z1hAx9TgCiAg++mEKK67Rxz0jjntlw+3Rb+m/aaUqIoMrr
         BWZQKaGmPP2R9cF64942SzfgkUuIfG8snzx3+bCz3dbCr9CX5hKaZlarVDYN4jni+778
         nZr/tRCn+Q0qI8UtndEqB/frmRqaKQJJX5wFihYsZ/miGt7t0wVhiUzKJb33a2gBfyyO
         2GIzDDHcCzIaclUCyXS43BbIZF/tDQG7twAu5UW5yOD+KzOx+mBp9X7VkHkOjptJMVB9
         Eq9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwS/uRkEldv88EpeZ4fa74FCo6sEJ3qiSfQZ4CpXNFS2hfWn1XnNa0JfCMtrrPaSKoodkk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIsyKzo++S+kMnarXMrxLwU37RpN086TKOlMU5fc2hAcR+SCOSG
	bQ/GzqWre5rxaVqdIMio5ICozUvN7jmvjKI+chot/RLPyGAiJUeH/VekXJ1e2Q37o4FCEhaWhv8
	Ajks1R3F08JAZikmovGuE1ItYPGyYktu0D3ecCcgC
X-Gm-Gg: AYBFou0jqMM6GqUj3XUj+8CB30uXu9GEOwkxjZ/A8x+9BWx67sLVhXPgnTJO4TE5cna
	Wwyg0d2DLFMLP78FL1AFZy3RqFVPB13q4cmNeYOo6DE3Ij9vLRJ7PRmfjs7AYdrlxfj+9nKKyoh
	vC4Ff58jg3DxOfKkV1vkpmaAq6e5XR/YZ+pIpuPC+2phsZLt1lXeHScM+y5EQ6Sx/1QD+jQImbJ
	wmf/5sfVdGWhoV2E5RRUKoDKEN2les/W6iA2/f/jUEx1en1NF6NASq81D0uMi7++zBfIHlpqHwk
	uc7HUk0wy6wpg+G+QZgOl/J4pXIYTHCzTzR760gnKB079GOXnuTbWEzcRhmqprUfgSCZPKwTBLM
	V0kT33LbiTwij9vyrD5umVbNij3Rn9AP0uaBBtpRiJH6ca/FGvXqw/uz+X11oUBvqF2EOeTsZUU
	9szODP/+XTDGTyq7KDB0w3G/tXNTWsqYQfRYAxenZmWGuGt3NfRXnLrM7ODu8vPjebVd0R81HMn
	W5Vbb3u
X-Received: by 2002:a17:906:9c8a:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c46bde874d7mr911731866b.38.1793055390933; Mon, 26 Oct 2026
 15:56:30 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-5-jthoughton@google.com> <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
In-Reply-To: <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:55:53 -0700
X-Gm-Features: AclHuK_4pEIR4EnpfJkK690R4CHqdS4wt-7zneGKcf5MW03i114xuH5q5kcZiJk
Message-ID: <CADrL8HXeYRC8w7F7e_6ZXK6MHd6FRepN_zD632j0JPjNUDrLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without
 an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > stacktrace: Don't unwind the user stack without an mm
>
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> 7e8e6816c649, which dropped the !current->mm check, looks like the real
> culprit rather than 214d8ca6ee85.
>
> > stacktrace: Don't unwind the user stack without an mm
> >
> > stack_trace_save_user() only refuses to unwind the user stack of tasks
> > with PF_KTHREAD set. That doesn't cover all tasks without an mm:
> >  - A user task that has already gone through exit_mm(), e.g. when an
> >    event fires from exit_files(), exit_task_work() or the final context
> >    switch in do_exit().
> >  - PID 1 before it execs init, and usermode helper children before they
> >    exec, which are created with user_mode_thread() and don't have
> >    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
> >    an event enabled with trace_event=3D unwinds PID 1's "user stack"
> >    during initcalls.
> > With the ftrace userstacktrace option enabled, the architecture
> > unwinders then read the user stack without an mm. That access does not
> > reliably fail: the user half of the address space belongs to whatever
> > mm happens to be lazily loaded, if any, so the unwinder may read
> > another task's memory.
> > Use is_user_task() instead, which also checks current->mm, as perf
> > already does for the same reason since commit 76ed27608f7d ("perf:
> > sched: Fix perf crash with new is_user_task() helper"). This also stops
> > unwinding the user stack of PF_USER_WORKER threads, which never run in
> > user space, matching perf.
> > Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Is the Fixes: tag pointing at the right commit?
>
> When 214d8ca6ee85 added the ARCH_STACKWALK version of
> stack_trace_save_user(), it guarded the unwind with:
>
>         /* Trace user stack if not a kernel thread */
>         if (!current->mm)
>                 return 0;
>
> That check already covers both cases described above (a task past exit_mm=
(),
> and PID 1 or usermode helpers before exec, which have mm =3D=3D NULL).
>
> The check was replaced by commit 7e8e6816c649 ("stacktrace: Use PF_KTHREA=
D to
> check for kernel threads"), which switched it to:
>
>         if (current->flags & PF_KTHREAD)
>                 return 0;
>
> That dropped the no-mm protection, which looks like what this patch resto=
res
> via is_user_task().
>
> Should this be:
>
>   Fixes: 7e8e6816c649 ("stacktrace: Use PF_KTHREAD to check for kernel th=
reads")

Thank you, yes that appears to be correct. Updated in v2.
