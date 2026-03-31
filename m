Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAD9371071
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936547; cv=pass; b=CNSZURQeskw/5PL0JumKudUEs6DDJDzYvOvcs3L44i4dH4rSekqtmxKEgIpDlzkfuIzC0M8R3hSwZdBiOsZSRQRxSWPbIVr0tGhA6LVTej5c94zLTjlVmpiQxu2h4cO4sxuJD3bdZOFi4acEOscw0V7XvCyFJrSCRPm5Uam8Si0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936547; c=relaxed/simple;
	bh=Q9HaptTjsKPWbCfMjIEzsQRA1W9CtWYq6rtsgvNqDkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/eI/aD6x2LYf1Adf/+SxWMxjr1Zbl7i9u3KgCbMUElnRn9bES2HVgpQh0G7PpBoxLkTxxq/jvtlnPKiU1oh9LrPQ8gCHJrSip+zL1K7LYIyCIlPIuKeP0MIohXR9kUWE/E9jpRMDIlkKHJewDTQjy/KFncYuM1tKq6VjK7IXAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OTjgXySz; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OTjgXySz"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a13e1cfa45so6198964e87.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774936544; cv=none;
        d=google.com; s=arc-20240605;
        b=dLDk/Nfr8qQ6BZNjTzhrXND+NxZSkfrY+0XiQLcaIMP67NLLc3gUtShDip1Hiy/zUE
         16qlK4rCCirq1zE6jFT/uNNMvZDigkHSA6dHDfkGXh8f/0Kq+4WihWQuSLN0NWaGWWkd
         SVhd7zENY0GnizZQP2OtVQLCCkyb1tVgnKDjUY3dzID2yZl36KGoTkPLWyj3wX/PSVxa
         VfBvrJimRtthpHTg1ZGUaz2NSD2wAEaoofTkVoYnimGWXifD4Dv5LGEiuWc+UYKdMmcP
         mUdPZ1qaTOJfbCk4zls3EFJwX5XrHXgPaC/BRpytKvQXBL7/WSq5BCd9zBn6MnN4BM1n
         29FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENb7aZHZFh+s0dFFQdWThuyfZVDywz8et+r9uLmI580=;
        fh=S9ePz+PfzZkgN0qofjJCcOlOgf2Oe98PePaHWz0zYRs=;
        b=eAdaPljm7M9t6oPG6GtWYcCqgKZwuJwusaDktC5zwyN3nscIl7bMQDWKsJ6OID1/Pz
         IjycCkVFXv+wl0E0n8k04d10ku361rr41hyC9aC80a4WQSyEjcp1SRF+NDuCLcQsFKjp
         vPQB/YGQMt1Cb2UPMFD3yDPaWP6uNhQPjEJ85Zq0zUkmyH34SNQrvkYgC/fmShpC6ViP
         yMsTDgOWW/u0lt3bVPrRzJF3LVB5sU1zalurrgG3PPgC02zDOAzgF9anCd1yEkZPJVor
         9RROM6vors3nwdZY8mEJ0obtlWKE5n2/wNOk4NJHve0KYwDNT4cweV1xwGRu+M68QJ24
         CLrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774936544; x=1775541344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENb7aZHZFh+s0dFFQdWThuyfZVDywz8et+r9uLmI580=;
        b=OTjgXySz06HSzGMJwK4oKk25VX/7qACER1QZDT82VphulNf748CyA5/OZh8duvN0J9
         MRuJscaVnWoFkr0feEiV+NOAftt/8CkoX+KK4JHZSsZvQ/vYhhnCoGntdfVKSc3tADHs
         mEGwThHbnR/mQAd/W/ocrTvM+FHc9Dk6NfM3EDUtayvNZPGMlz5QdL08SCS9JsXFVrUI
         BAblg0uNOhYN4lImE7Ggf0KjkFBsT5fSXM/rsOQIJUJyWUopLyI42iPTqV8FfWyi7YkE
         ieVkCanZuxcFkxB4P0OvD46UmmpkqnCO3Uxjs3jK7frOnM0CdN7V9GylRKFL7PMF2JNg
         QBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936544; x=1775541344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENb7aZHZFh+s0dFFQdWThuyfZVDywz8et+r9uLmI580=;
        b=mrJLUbJUrFSj819bCwXe2zGwIieyxX+0UHD/KIt9UMPW1BSYU4bpsD6DaqjCA6Malu
         cdtCleEtMh3aHDGimr4n6dmDGzFkRX4uipfGlpv4iUOsiMxrENjver1IU/HZZFT3nakt
         320B3CS5vYX/A/yJ4pzptEnwAbfYJNxMspSTLFWs0k1rFBe+GgdpagQXrGBFbTOroOgB
         1rGN8x2PmzvJlE4BOdQsV9WDC3oIUt5aeLqxdSUVjVUSsn09O9r01BOGbmJeSmUq5fyr
         89Dr5nBXWAOIpUO5Qi775wTelL/NmPi9WKHUnYawDN869QLmughR71zspXW74QBUNAvH
         jwdg==
X-Forwarded-Encrypted: i=1; AJvYcCWj7e7lHjEVOSCrtk1nCT1beoX7c2zw9I493zug5MlDt1kEOaBkpFZ+2w1uK21bis1Cqu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zmyLA4lnmSF2XyHpFeNBFHXZWlHECkID1bXTRbSKq2OcysPX
	t41QoDe3CQhGoZM4i7K6ctLCMdi8uRg/mJeFcXoUwUjZi4f3EDw1S3PG5iHEpt/KaC+lvxvGO90
	496Ww2lRg60qOLj32a8w8W4wop1qhHDfGhleaBnp5GQ==
X-Gm-Gg: ATEYQzyAeAom+FIvzCDQVk4m1kIJWLBk09QoHd5Sn0VhvUKa1sR1EYX3WUpZ3uH8Nt5
	yP4twWVV2Zla6hsbjgnLpiCL4gSwwSog4eD1LxEBUMtAPeGubeDAc5+uM9QUl6pnU6S7OerlFFD
	vrVbxzRf/KUOFeyAZJUpiARTuCIzDgCXyRJ69qiNDQXRN9M6tnkN78TZ1xcwt5NeiXI/I1vOqs9
	2ESSrzCe1pF9MPpyj7uJEzw/sFizorv5z4bGi9ROX47AivCqpSOLtdlVuCnqgKpLHbZKH8EsBN0
	S440ubdhrNLIYRP2qgVB5POariv50p7E3g0aSoNcIw==
X-Received: by 2002:ac2:50b5:0:b0:5a2:abe6:7bca with SMTP id
 2adb3069b0e04-5a2abe67cb3mr3325609e87.34.1774936544330; Mon, 30 Mar 2026
 22:55:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329124429.689912-1-hoyeon.lee@suse.com> <20260329124429.689912-2-hoyeon.lee@suse.com>
 <CAEf4BzbA=drhPq9tsD1Dj1wt_P0q4LNtuNSM96CWVuAVBrKrvg@mail.gmail.com>
 <CAK7-dKZMjW0t=CSkRYuUudnAY--BviwVBJCGH11g6csTKBwRNw@mail.gmail.com> <CAADnVQLN4mNZWMsf0+1999JuzRgjAV19CoC0Wd638v+qhPUy0g@mail.gmail.com>
In-Reply-To: <CAADnVQLN4mNZWMsf0+1999JuzRgjAV19CoC0Wd638v+qhPUy0g@mail.gmail.com>
From: Hoyeon Lee <hoyeon.lee@suse.com>
Date: Tue, 31 Mar 2026 14:55:28 +0900
X-Gm-Features: AQROBzDJDHIcVs80mogGdqAYd7FbF56lJpJEX38wz3UaDlqbVQ38msTmiWrIR6I
Message-ID: <CAK7-dKb2DHMjDp4RGPKjOFsd1-nLz=TM8yaCz-zaVCQL8E1hhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 11:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 6:49=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >
> > On Tue, Mar 31, 2026 at 9:33=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, Mar 29, 2026 at 5:44=E2=80=AFAM Hoyeon Lee <hoyeon.lee@suse.c=
om> wrote:
> > > >
> > > > bpf_program__attach_kprobe_opts() currently attaches a single kprob=
e only
> > > > by func_name, with an optional offset. This covers only the symbol-
> > >
> > > have you tried passing NULL for func_name and specifying absolute
> > > address in opts.offset? Looking at the code I don't see why that won'=
t
> > > work, we don't enforce func_name to be non-NULL
> > >
> > > This NULL will turn into config1 =3D 0, and offset will be config 2,
> > > which I think is what you want to attach by address, according to
> > > perf_event_open documentation
> > >
> > >                union {
> > >                    __u64 bp_addr;          /* breakpoint address */
> > >                    __u64 kprobe_func;      /* for perf_kprobe */
> > >                    __u64 uprobe_path;      /* for perf_uprobe */
> > >                    __u64 config1;          /* extension of config */
> > >                };
> > >
> > >                union {
> > >                    __u64 bp_len;           /* breakpoint size */
> > >                    __u64 kprobe_addr;      /* with kprobe_func =3D=3D=
 NULL */
> > >                    __u64 probe_offset;     /* for perf_[k,u]probe */
> > >                    __u64 config2;          /* extension of config1 */
> > >                };
> > >
> > > This is the same approach as with uprobes, btw.
> > >
> > >
> >
> > I tested this after your comment, and you are right. For PMU-based
> > non-legacy attach, func_name =3D NULL with opts.offset =3D <raw-address=
>
> > already works today.
> >
> > However, this does not work for legacy tracefs/debugfs kprobes, because
> > the tracefs event string formatting still expects symbol-based input.
> >
> > So for v3, instead of adding new field to bpf_kprobe_opts(), I'll docum=
ent
> > that offset can be treated as an absolute address when func_name =3D NU=
LL,
>
> This is fine.
>
> > and make legacy path support the same raw-address form as well.
>
> but not this. libbpf doesn't need to support legacy interfaces.

Understood. I'll make the legacy kprobe attach API reject func_name =3D
NULL with offset set to a raw address in v3.
