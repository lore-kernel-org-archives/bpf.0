Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D530B508
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 22:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034152; cv=pass; b=ogE3iT/EMHVz98WDxfTs6ox70FNg7+G1bkDrBqC2nM9omM8BWnCJUMjJCXPNpIjidDO8n8bi1kPC2t2inyhrpQvI5faOLHZPljWIKrA96JTV2sxpqwnCM4TskEMF97vA0P7cbg5e6B9T2S60gwLKYFpiM7H4uorQ/IDiKfPp45s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034152; c=relaxed/simple;
	bh=O5OVsiCKYjUkVc/4Ce0JG9hbx01UZGanAjUUxH4B9a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsWbO0eu0eA6goe6Ul8aO/7TnGnG29qK4wy00lpRWLviZJWcugqIsuRTaLEobotNjV9bAisynyxqPMxYxIXtD7s2sj4h61YEP2/YKBiDmNhjEr/Vi4PTSRpRU5Z91TmUuAlLrEKWEpTxz10ExfB6DM8omUUl0ExnB8Ag2eb2VyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzGPmV6G; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzGPmV6G"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so61415815e9.2
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776034149; cv=none;
        d=google.com; s=arc-20240605;
        b=T58rbfLDUg8nU2vOpWW9x/h1JwaWLMWr1r4a8DY4tMhPiysaQz0ps6XrB6wx/Py5Sd
         AKby8SBugN1WG2hb/aBc+GjX+6utE63tA0kklTZK2MJrkB8LkFcT0L+EANv9jrQainca
         wY1qNRDp7pqgC2FhH8aGtB4do2MF5K/Ctjr2GrvuAxi3WtWAfOiUI0ntS2YKnjgVP3Q9
         4eS2izicoeTtrhU3nkBHU88egR8Cwmm3VcUmC7g50bdm4Q54jHnJyF4MFbkbUWkj6ehS
         OJmwxUaZ2acoMZG/SEkLaMgpHp9uPRDuicX8CeHj98ZZauEtW9J9migFbsIeovsj0+sX
         Xwsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O5OVsiCKYjUkVc/4Ce0JG9hbx01UZGanAjUUxH4B9a0=;
        fh=GlY4OVTdokhQS+qu53YI8pESuza2mOlqhVGXg0PoTLc=;
        b=IVj8Fdz96CIapScJyTeXzgQR5Imdx3XNRIXzDcWYXYMg7nH/Pdete0EqQtBS8lsiFn
         lKxpnt3U3XYMHdGiuIJ8BhxFuVDJhznUeKegTlLFvahoGNqu36V/rchU5jtZAHNjLwgs
         bLDi8Z0YYWbOaRE1B1yN2vbyH8n+ueZnc1CyE2+FrZ3qytTjTc0ZGCRY6uu/j9EtntUd
         ZMUiXe1d8NAsaSgNOVm47D15qPKmY6EOa1ZSH75MDFBLrAoi0DLEJDiiL9nq/OJaReBN
         jVpooYdH4yPGdkiA6Xjv7AvKsIF7FvgENfbhi7Yn6Q1OmNcjOu3TGW4Q7gZXuqDLXEQw
         IQxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776034149; x=1776638949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5OVsiCKYjUkVc/4Ce0JG9hbx01UZGanAjUUxH4B9a0=;
        b=JzGPmV6G7blQOWDYd28cCLXXkn5AbGxMqcXp+JvqQ0zefugE7AKxmcExlbXyk1sH8H
         vJfCJJSC/vEayTpdcQUTtCWo56S+myiARavQHrZWO8NgvWaJI5HMcQ9t0hT8pxl8EHSk
         UAjidL2TxSPvgbRm7esxfiEhLwZjiamnf6B+kMV/PBj8vlsCEO/xoFCGYyk8Y32t1TY3
         r1zbLfXqDWCnYHEOqMAk1nLXR3WGkKWuUzGwPaGAPl72Sh8ERDGFzUHF9zqo7bs9SfX4
         qtfkftcoRxHbNX1kik2Emwn04lmgaslaB5dNOZkWDe0JEwlOSETphhvbaEH4QCYBk+Zr
         +rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034149; x=1776638949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5OVsiCKYjUkVc/4Ce0JG9hbx01UZGanAjUUxH4B9a0=;
        b=gVsDPY1bQEOGpFR4q2SisaqfHNoHvhrzBzEzMYFJPo68/0tPsP3Y00FoKywGFMcNeM
         hP2Cmwh7Dzuj3UZpZqvj+BdPPaBkuJhC4DKujA/aQk/FM9sWAA+rPA1cFEx9S2Y5N+Ip
         FvbHmAxGF8CJQDLUBN9fPjELXEx5w9HImWNko9rFLhgOATRwnvqlq9SPQZwitn2+LDHJ
         bsNsyn03n0Kvm+mZNI1rsx1kdz/BlwgJaQy5MK52fkmR0G10DA126QCTBaCPrKunAQs4
         UpWiwnW4eRmMskk8su7ONYMUZCP6hrWpKb9b6SHmSsnFpF5RH59S+nYd/yeQ4WD2n6nR
         kFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWnMUFdOysgcD0JfDJHiaH8G16qfcZDN6dKUoAmkEFUrGOVmDUoLpan/EhP7fo+yAdwoGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycM61DD+aGFbgmXzecgm8iFQnoDqvWsIQU99Ho5AZtL3yZb9sc
	dJmi9d7wDUFmr+9ynhCubHnIewTQb9gjPv2QkUa2eAblOoPhNPuutH4qQjtTpDHltkKGESPYHrr
	Ew446HTtrxtjkRqvAw3q0GlehHFvt3TY=
X-Gm-Gg: AeBDieudaVUlEORu+XaHm3W8EMWO6+8o8gxr1FsJ0k7m8x+muKysJAOeiRsddir6rJF
	u2BlbjAQw3tR/1ECU1In0eykQu8GaQWnNymJJ7KITBy7jyRK8R3eMzeDDdfRnikMVfUp1vCzqdS
	52ZN7jyt3LKtr7UCh8jN1OW7+j8Gd25+8v/mbRITndZPz4B9sXbw0oQR6nmuN7luhH7zDpG2/qm
	5nXQRPlCmv2EfSxfV0Gs9QeaUoeeEtGTbUTCScZdI4p8R1H5zO8rZ0c6I43kGXSxiYCbNtodHcp
	EveJROVx/4bB2PLxzxeOSyfeYhPUVqxWfkLxJcOcVgdFUplxpGet+0S2Z6X24lTd25/Ydn8AX4U
	tKK+ezZsnhCGAiQ3DqwBlsQU1MQ==
X-Received: by 2002:a05:600c:6990:b0:488:a2ac:a34c with SMTP id
 5b1f17b1804b1-488d67f5bf5mr154924175e9.12.1776034149238; Sun, 12 Apr 2026
 15:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh> <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh> <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
In-Reply-To: <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 15:48:58 -0700
X-Gm-Features: AQROBzBmpL408c1tkfYuNTafpAd5aZMliRFfez61VTABAQ1oaYAiYAqJdTmdInY
Message-ID: <CAADnVQLELWyv0kuv8wK3FJVFdJPbp-tD8d3p2pgCiVrcw_cVNA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Samuel Wu <wusamuel@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:28=E2=80=AFAM Samuel Wu <wusamuel@google.com> wrot=
e:
>
> On Fri, Apr 3, 2026 at 3:04=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > > On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
>
> [ ... ]
>
> > > The data is fundamental for debugging and improving power at scale.
> > > The original discussion and patch [1] provide more context of the
> > > intent. To summarize the history, debugfs was unstable and insecure,
> > > leading to the current sysfs implementation. However, sysfs has the
> > > constraint of one attribute per node, requiring 10 sysfs accesses per
> > > wakeup source.
> >
> > Ok, as the sysfs api doesn't work your use case anymore, why do we need
> > to keep it around at all?
> >
> > > That said, I completely agree that reading 1500+ sysfs files at once
> > > is unreasonable. Perhaps the sysfs approach was manageable at the tim=
e
> > > of [1], but moving forward we need a more scalable solution. This is
> > > the main motivator and makes BPF the sane approach, as it improves
> > > traversal in nearly every aspect (e.g. cycles, memory, simplicity,
> > > scalability).
> >
> > I'm all for making this more scalable and work for your systems now, bu=
t
> > consider if you could drop the sysfs api entirely, would you want this
> > to be a different type of api entirely instead of having to plug throug=
h
> > these using ebpf?
>
> Almost all use cases want all this data at once, so AFAICT BPF offers
> the best performance for that. But of course, open to discussion if
> there is an alternative API that matches BPF's performance for this
> use case.
>
> I'm not opposed to dropping the sysfs approach, and I attempted to do
> so in the v1 patch [1]. I'm not sure who else currently uses those
> sysfs nodes, but a config flag should remove friction and could be a
> stepping stone toward deprecation/removal.
>
> [1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@google=
.com/

The patches make sense to me.

Patch 2 adds a bpf selftest and corresponding:
+CONFIG_DIBS_LO=3Dy
+CONFIG_PM_WAKELOCKS=3Dy

and almost green in BPF CI.

Except s390 that fails with:

Error: #682/1 wakeup_source/iterate_and_verify_times
Error: #682/1 wakeup_source/iterate_and_verify_times
libbpf: extern (func ksym) 'bpf_wakeup_sources_get_head': not found in
kernel or module BTFs
libbpf: failed to load BPF skeleton 'test_wakeup_source': -EINVAL
test_wakeup_source:FAIL:skel_open_and_load unexpected error: -22

We can still land it into bpf-next for this merge window.

Greg,
any objection ?

If not, Samuel, could you resend and address s390 issue?
I'm guessing wakeup sources just don't exist there.
