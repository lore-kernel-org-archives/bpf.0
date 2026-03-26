Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891F40F8CB
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542672; cv=pass; b=Kj5ll+ZpUB5qaGKmICGI9DLX1i4VaSd0GMn6E4awgDlRAwNLSWikE+BVPpYGer8L+CcjG+xnQUApUL/V1oTicAR46j+GG9VCAH56RUfQgvDSWQ0fft225YgECDMtYohw18ywJBqxp4mpIxHCTe46Q8QMxjnRFPAwrkggkdNoXPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542672; c=relaxed/simple;
	bh=BZbMBwHrp8whhIaCRPg1ZjbDngDwiMRAEfXI7t9rAFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVQuKBHTt8pkSywdA6PaAJy/IaC1qQ6ba0SAO58u5B+MGHtiU44njcZk5NWTka7HyIu01VCMatMUzTiF9gNCB38WxHN2AOdCwMV88tFShZMQPD1q1A8klWlPwTR2sxi68c/yjpqZp4AeIM1MrPCgR3fEQKOaZKejp9QIjwjhJT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEcoCK16; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEcoCK16"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so1070916f8f.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542668; cv=none;
        d=google.com; s=arc-20240605;
        b=DUjywBfNExmoIUiyQKN7iTEJzU+zlRWZPYs9UyKhqaLmoJzdgLb7pPfNiOmugIAAlE
         JV8kqpaxSjQm4WXOCYw3re7Xw9VhMezcSsh6Fq/ykUgpjH0qWal7SCNcNuiAWKCl31VQ
         rhJHJk3742FejyAKUQZ1NIPMjRPGEkKOHYuSWudrH4SaFmyKbiOcfqctagyhnB39JgFp
         QrJ/j7rwELyQQ4FIrNlqS4B9gYJVjUB+EU13xk1THlewzHSCT0SWUcAKZa5O+B3cHaMd
         v/VFNF7UapN//vQSyCbdpQvLMGqyQ54EBHFKE+5D8zciGrcA5ctQ7cr8sLQteooIYnxG
         /BoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        fh=6epwpmsTIlDxaEGFGS0aey60RtP/6wGCrH2978Bk6Z0=;
        b=FV2xAfTo7dqowbqL10IOFBDTDkTvcSvdN0X+SdiwhfAZXGKYpmDXSh2/KtnXyHMmgI
         9vb9QCtJOUynG08hF+83K9V78sf4JjCFWq7QN7dxtx8Zik0FcRXFyzbzUJ/1aqHI7/XR
         +pAsdEiLgtzRkzUImvadmW4ASbXmskc38n9CRKr+qsgpvGcEKUtzY1xnjaM5Ckq0jQqh
         1TvMSNmN0YKTQeM//hD26Cjq5wamTm74Y2ZvoFdzv9oamdpn1EpvIYOXbWjSxbmD+yKE
         GEwOgj3YIsFlsAHsPiwvv7tQB9hVOUf5tlJSjoh7E/mWCeevIgwpwB1oJrgQhBlr5Oql
         iAdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542668; x=1775147468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        b=UEcoCK16VvEhwgTWUb7DEymNbHkAuR2Bvi2cRcfRLUatm9fDCEXXSn8Q1V5742uhGA
         R6gnsW/rzrdfHepwh8x8bUDEfG1PwsO4eZIKmsKf0R37H2z1qr1yJT+XpjIWxxmZe3Q4
         aO0jysZgUPMJoJTOdUCI513mPtjQQ8wCW8tquZI8m0A2npiIMVJ/2ES7daPpw5KGm4pO
         vp0/yopINYEQMkxzRODW5jy546/II9ylviTu32nBNRUJ/CXC3Homjh449HkD8nAOs4Yu
         syrK23a6PHKQONTsYTfmjEeOFgKwFu9frvL44O5HCjxeUW74xyozGobyRbOPXfPUjYMG
         CG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542668; x=1775147468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfNm/O6t2ZnE/ns6CNZugk+zk3ym9aOAJX1Hxzo1H/I=;
        b=kgyUSwHJNXBsSOfXDz0E+02EljInMgId0ptDPY09FIQ+2bkrD/wtP4E1w7ztgAe28U
         iGqk6dqFFgyKHqFWE3Md39ybxn6f8WZt9ueakAeVzpO9fvdwY6x2rK5Rdg7/iepsr460
         kf4RzM7k8EWFjGeVCHFZZFw7CZXbmR5+WZ/ekhDwYaBB6Ga2BiqIEoSYy5UDWWPIyI5v
         XEUVRl4aPJWVRg75ecjZqFNyXARuzYubSb0D/FXfMQt/M4NHb4Vl6EofTIhr1a7V4ryp
         ZysS98w9LvaOnLq6PjTn7SyTR/xTrOIST+qBg3OicyWUf1vCX4Ky+aF+pMJfFi7LckNd
         aQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU26LlzgJrSnQfRH3e+PvnZmkMkHhY8Y/tlvojEMCDcH4Vm/s14ZTWxeBaiMP/wuu2IyWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6RUAtNNjyEjlG3SfROdxcjA3YyxqGKMHFqRXL2rBu6TpOj7G
	ySFyxR5xCuZM0gN4OTYx9ykN4kj4qb02zp6QlYeFcvar6RZyN+h7m8KjTFt9iAO3r8NPRUaW6D/
	C7tRyMElDlDcg11hMzs2pVYo5FAnIqqQ=
X-Gm-Gg: ATEYQzzIoFtgEn214HxsLsCsYqOOimeYOgeN74BYkr8Io+9Nk9qCY99HNhNbmxLOlOO
	IGEO+cx9mxakWcVoabBbRIRzLKQZjRi8NTYaVT5rEj8U/L+avy1CggjwZsW+QN7qYWRlXeSY0i5
	T7x90GUWxnyRCEaTSLKTYKimJ9DLxEMA3HXFAU10yLS2svpJz1lFX4kFLE0cwNQAMj9toPyykN9
	AisfhKoMqHdDSecInbmD84jWDk3FSgXmBz8b2Vn2zB26DyNEVi96RJJKgAC1uX6MErPSwokwYfA
	wzsRHWeoBkELM5dTSComZqe3Ae2Tw+It8pARkASP0LiAewD9CxQGRWdWr0dn
X-Received: by 2002:a05:6000:2481:b0:43b:801e:488e with SMTP id
 ffacd0b85a97d-43b889a8389mr12816871f8f.15.1774542665963; Thu, 26 Mar 2026
 09:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
 <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
 <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com> <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
In-Reply-To: <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 26 Mar 2026 17:30:29 +0100
X-Gm-Features: AQROBzDVtUgfqATd7rCHJdNRaOBCw4LGtIxgfT_E050yYf4i43poQlTnNZclS14
Message-ID: <CAP01T76nRgXf9XW+6SGaJ-N2iZSFj6E8--p5mtBB__czwvDUag@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Samuel Wu <wusamuel@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Mar 2026 at 17:26, Samuel Wu <wusamuel@google.com> wrote:
>
> On Thu, Mar 26, 2026 at 8:02=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 26, 2026 at 7:54=E2=80=AFAM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wr=
ote:
> > > >
> > > > Samuel Wu <wusamuel@google.com> writes:
> > > >
> > > > > This patchset adds requisite kfuncs for BPF programs to safely tr=
averse
> > > > > wakeup_sources, and puts a config flag around the sysfs interface=
.
> > > > >
> > > > > Currently, a traversal of wakeup sources require going through
> > > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls=
 to query
> > > > > sysfs is inefficient, as there can be hundreds of wakeup_sources,=
 with each
> > > > > wakeup source also having multiple attributes. debugfs is unstabl=
e and
> > > > > insecure.
> > > > >
> > > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to=
 safely
> > > > > traverse the wakeup sources list. The head address of wakeup_sour=
ces can
> > > > > safely be resolved through BPF helper functions or variable attri=
butes.
> > > > >
> > > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing=
 ~34x
> > > > > speedup (sampled 75 times in table below). For a device under loa=
d, the
> > > > > speedup is greater.
> > > > > +-------+----+----------+----------+
> > > > > |       | n  | AVG (ms) | STD (ms) |
> > > > > +-------+----+----------+----------+
> > > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > > +-------+----+----------+----------+
> > > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > > +-------+----+----------+----------+
> > > > >
> > > > > The initial attempts for BPF traversal of wakeup_sources was with=
 BPF
> > > > > iterators [1]. However, BPF already allows for traversing of a si=
mple list
> > > > > with bpf_for(), and this current patchset has the added benefit o=
f being
> > > > > ~2-3x more performant than BPF iterators.
> > > >
> > > > I left some inline comments on patch 1, but the high level concern =
is
> > > > that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> > > > KF_RELEASE tracking is working against the verifier rather than wit=
h it.
> > > > Nothing actually prevents a BPF program from walking the list witho=
ut
> > > > the lock, and the whole pointer encoding trick goes away if this is=
 done
> > > > as an open-coded iterator instead.
> > >
> > > Which is fine, the critical section is only doing CO-RE accesses, and
> > > the SRCU lock is just to be able to read things in a valid state whil=
e
> > > walking the list. It is all best-effort.
> > > Open coded iterators was already explored as an option in earlier
> > > iterations of the series and discarded as no-go.
> >
> > kinda best-effort...
> > the way it's written bpf_wakeup_sources_get_head() returns
> > trusted list_head. It's then core-read-ed anyway.
> > Ideally it should be trusted only within that srcu CS
> > and invalidated by the verifier similar to KF_RCU_PROTECTED,
> > but that's bigger task.
> > Instead let's make bpf_wakeup_sources_get_head() return 'void *',
> > so it's clearly untrusted.
>
> Thanks all for the fruitful discussion; this is more rigorous. I'll
> update v3 so that `bpf_wakeup_sources_get_head()`'s return type is
> `void *` and I can add a corresponding selftest that directly
> dereferences the head and expects a verifier failure.

You could also use bpf_core_cast() instead of using macros to read
every field, should be equivalent. You may still need the macros for
bitfields but it should work otherwise.
