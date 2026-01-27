Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8B28727D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769547732; cv=pass; b=nip9Zx5ZuqMCRHhwmH7CZAlWeL0yX82pKPQqUA+JqBWR+sJN3flzSwgYk7FsT3pcgoJt1gaSa3n+r19+GbRAaXQVxhmDjprJECPEGbjJGfy+CipeyIiwDLYDMClX/my3BwbvVE93cjLBj9ekc9R4CVGDzDU5Xlez2hlzJHtPwWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769547732; c=relaxed/simple;
	bh=KNHweNGDpGm4ZnN7aPhScDNOmJdoPwpco4xhVuTp8Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPmKbQ+e4dfGm2hv0+88e1M4sCMxjrhxUXxQWVLz85k8kkvmlE0xTOGiEScb0HfCDktGJONCTMPxIEDeULTeHY6nab0adTRDhhnR9iEc+omDXYywxLnnJPXfL5z6Zzk5NCAaX+GFA6R/viHXGasfEVNWdPSw/V8PN1rAEEAq140=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW8G5L6O; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW8G5L6O"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7786d7895so41014735ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 13:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769547730; cv=none;
        d=google.com; s=arc-20240605;
        b=bx6hxG72xtM3WfNXEIyI4AIIyD32HXsrMAkl4qTFXgz0d8fGP6rTR4b621Ofg8OA66
         Wz7I/Tu+10jUMVJX+/Rg6AyJ9zpEUOJjodKyH/NpEopXy/gJIR8I5eoQ57q+KZTQyba0
         7PZUnudddsxQPYrI5PQmqpNOSTab1bM4PipqHmcXDzGlu7+zwIbAk3joKl4tc2rcxLTY
         qEgX8md5PPyehb5H2DMp8kkOOdwb/yGZgjyzeVMZQ0sS7PTHd2JL453yEkMWnOUIk0lp
         gVCRYrJZz2z4ZKuCGyiRxjGPauScGTcEg7RbWfAtu694YgQOdECv8iF7AFvqrtS7DoAD
         7BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        fh=UTrsxEaUQGcin+Cp+ATSD4K8JuyvKScrL+ZHSi6h/7o=;
        b=jARU8sHpeShfzj8AB4QV7jDN26NSZKp4ANLzDjur8a96MUqnxTUB7Hso8ALIbahvOj
         zwb3DCsTS/FClYUDD6sKjP3ll4cWx/rGCncGu+0/q5tOi++4gyLfAtTb7KWT/7sV1fqv
         G2jBBe9qIdgO9TlETNeozs8D+5BzT0OGygUVcqNStePGFNKAtS/lxwqQt9A2HVtsIUmv
         ChuP79NKzqvvC7nNxn0wavER9vA0qcjZiUQ2FdVhcZSfsBK/ifPFk5Y6dCPe2mqCWfbc
         CiAyagJKLlSD88zxDQcGoNjxOvJZsOYdh7ilgF7wQnAhgANLgye5nO/WoGXpwXDUQhDW
         AOHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769547730; x=1770152530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        b=kW8G5L6OGTDC2fT71IgmhdQlmnnY3WcCSBJi7VMyPbyjSH5XIPCRpgP5LnigLZiJnv
         Sb540/QrLr9BIGVr5sOQVPsh5uPqPEpP+earoA6vsAWFAEB9a1kH2hG7dWY/IhWJhYdf
         /Dxt5bE4uz1FkEE+eK9oLSIX+KAuOmRFpLS2L1RErGyTqnc+ymNSd7Wy3WgQpdWfx9U0
         tM/AlVZ9sQKFbCkLd28siJg9gJ5au2jG3133nd0TysVxHormt2DnDC3FYxEDIcPI3s+n
         u9n6VWH1D73oElT3zWB7W2dYejeo+pCT+mXauqTqMjhc+0LL++qCy+bW43TUIP1p3rYG
         Jnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769547730; x=1770152530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7j3CPHQIsc5Yl3UjDGx4jct6io3dDzxCr4YX/1yUAg=;
        b=q8Ys2sOtox4+KIngnNhxi8MTefcgyJuTDNOAGdBiyf1hUNaljvAb2WM3Tgj54rLKlR
         gXdSTst7aZ3zReT9ZFHje01el1mB20l3DcRGLh7FW9/Gd5EQV1cu2y7mvxwBmtClEiMJ
         xJyc7CP4XfI7CxVuGnkT/HbLeznUp+EIklw3ijAGEp0SzT4+zG5oBT65bhCM7Ouimh0T
         RpLOQuOYmx2iBvRI6+Qv3F1c86VEpxCQ6uAeSmIGwe26GN6F2llOZMJrEels/8flBJH1
         m3DstvCmAoEOuWGQ5QS+FTpmzWMYnLfRwUG97GvII1qLyafYTUj/Sgslz3+1xZRjV17Q
         2sKg==
X-Forwarded-Encrypted: i=1; AJvYcCXA4cN271dbWA9BeOHwI5ZliystOAoddapJQ4nfh8XRvfEMZiVzSYM2X3WxjeYEBEKpOtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvCiq8H1xRRWop29RGxwNW6MMjQBewVZJqbPQKz8lv7eTgDZH
	CTsNilqrsA+icNqvGsvIPFMhlPrOvD1YupstoD65p9fh51Ek5guaAvaUitQ0W3cjY69E+lUV3tL
	b/KTKeoI23JCAg5ndVpePePoy2EOHtSU=
X-Gm-Gg: AZuq6aIcJLquWmsqnDDNsc5czxdA46H12Iv8SnskwApPwvM7lY2bbN3eDcBHuIdmJAc
	313CuW4Z3KEX1+MhrvxOxZmF59t1rS8XK6jP7Gs1LrAOv1Pm5Tg5gkCgoNKWu0l6m0czXkBh9pM
	rcohbHEhgx+/leWId1Zw4Bfh947vlSlAsFl6SXEodkqalVV4cfUW1LCirS8hFMHIhi+rcoUQm2J
	KITxtyg0w2/IiX1ff459hvf97ldf/+o5jIukrEzToPlrcTqHee/+i01CKicX3Ejc6RpYd4EVaBU
	FK6g/87KOic=
X-Received: by 2002:a17:902:e552:b0:2a7:683c:afd0 with SMTP id
 d9443c01a7336-2a870d64dcdmr28661495ad.14.1769547729520; Tue, 27 Jan 2026
 13:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-2-chen.dylane@linux.dev>
 <89d94076412b6fc7e05e4d4884f3830601b390d3dcbee91aff2ec214117411fb@mail.kernel.org>
 <0b02943b-4ec7-4be3-b0e2-6c77531c4cbe@linux.dev>
In-Reply-To: <0b02943b-4ec7-4be3-b0e2-6c77531c4cbe@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:01:57 -0800
X-Gm-Features: AZwV_Qiafbe3wvAF3yuuyiNfBzRGkFBNphWOyUKpFvlJjyIdmXRufFUurygsAkg
Message-ID: <CAEf4Bzb776Sc7ByYF=AEFYw7mXoXVJTGAD-3QY49yBtuqrchuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Tao Chen <chen.dylane@linux.dev>
Cc: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 12:51=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/1/26 16:03, bot+bpf-ci@kernel.org =E5=86=99=E9=81=93:
> >> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> >> index 9ded2e582c60..0330f265173d 100644
> >> --- a/include/linux/perf_event.h
> >> +++ b/include/linux/perf_event.h
> >> @@ -57,6 +57,7 @@
> >>   #include <asm/local.h>
> >>
> >>   struct perf_callchain_entry {
> >> +    int                             rctx;
> >>      u64                             nr;
> >>      u64                             ip[]; /* /proc/sys/kernel/perf_ev=
ent_max_stack */
> >>   };
> >
> > Adding rctx before nr changes the structure layout in a way that
> > appears to break the perf userspace ABI.
> >
> > In perf_output_sample() in kernel/events/core.c, when PERF_SAMPLE_CALLC=
HAIN
> > is set, the code does:
> >
> >      int size =3D 1;
> >      size +=3D data->callchain->nr;
> >      size *=3D sizeof(u64);
> >      __output_copy(handle, data->callchain, size);
> >
> > This copies (1 + nr) * 8 bytes starting from the beginning of the
> > structure. Before this patch, offset 0 contained nr (u64), followed
> > by ip[]. After this patch, offset 0 contains rctx (int) + 4 bytes
> > padding, then nr at offset 8, then ip[] at offset 16.
> >
> > With the new layout, this copy sends the following to userspace:
> > - First 8 bytes: rctx + padding (kernel-internal data) instead of nr
> > - Remaining bytes: nr + ip[0..nr-2] instead of ip[0..nr-1]
> >
> > This means the callchain data sent to userspace is shifted by 8 bytes,
> > the last IP is truncated, and the rctx value is leaked to userspace.
> >
> > Is there a plan to update perf_output_sample() to output starting from
> > &entry->nr instead of the structure start? Or am I missing something
> > about how this structure is used for userspace output?
> >
>
> As AI said, this change shifts the memory layout, which effectively
> breaks the userspace ABI.
>
> Maybe we can use __output_copy(handle, &data->callchain->nr, size);

yep, very impressive for AI to notice this. I agree that
&data->callchain->nr seems like the best way forward.

>
> > [ ... ]
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2135=
0234831
>
>
> --
> Best Regards
> Tao Chen
