Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C932DEA61
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277638; cv=pass; b=YPge0u1Vh6mGz8ZTdQxcG6IOhCV+ML+HcKRKXL9ImUBjQ4EDig+7IiLt+BmOchMDB8NkxJtXn2tcX7oiHRaCQMGaLFF+ufm0D66NOqhEud8Dz1zgvi8mY67if4FSAV0lSbgBPsaS10RlJJHF2NDdM8v/pOOcEOpP0ekFDYVKX/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277638; c=relaxed/simple;
	bh=q05ryQ6x2sO8cTzsw635KyRO0xWh/j4v+/MdYH8lnCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpYlfzqBEF2CVZ/XayVmqBYWY4bEf5R8IfuQuK/EQToY7/l3Mze77QzjlOfyDHYTjkC2VPeL9LywJqAhy2OsZutx3OhJA0qoyMDQSCHuhykKC1j+7kV4Fvri3A/pLIG52s3mkf8hsVggyHhNnqvc/ALMhZjkVgxxg1kAgjEg5dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx8Pb/+D; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx8Pb/+D"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c855599a77aso601898a12.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 08:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781277637; cv=none;
        d=google.com; s=arc-20240605;
        b=igJGcRsRTDUkkxznHOMuQvvcFU2dXZzB0r+P4PeXgil+kTEnEn6Z27qedtz/vT+8B6
         TEadT4PkYRwkMsfOCx++NaEf4Y6n/lcX8a8nfeY9//zK/0bRcWALep1E5O8qf+IWQx3p
         4BZFohyDbQdAv5INvnR1tLLL+VnkQT8OO+dqxxDGmvhMPa81zk0RdQrc5A0uM1PzqiKN
         k2pbfQZF6Ftzday/i/f0qzVHhyF/bdMIc9lhGO4BL0bHwAlQzievq4a+S2Ah3LiyuJJX
         1soSRhpwrCbqD2zpGXvfB3ACGPmPVum/jZy5MEwhZek8LgKER8zMfr03G3N46exKvjKs
         5a5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        fh=El/OVcSKYYE6a6Fs076uaVAUlNawokdaoyf4p2TU7kw=;
        b=RLFbpU7SjddEklTu9WEEJLSUnYmF3Y5QifhckrlL3RMu/pVZe1jBwUVx71TTubZaHn
         Ri9qdBO16A64YTwirqvuuyEOTM0yDQ6Bi7/tjiOzlBhYBOvDepCChqLjtNfTbKjlK7ce
         89kkKbTB1Sh4+nXq8P9yXxgV/d+fLnecK/CZXq3wSq6s3+Ux2gjqRTKj4AkuMywCz/Re
         oBa4mAQXNoKwZolT5DwlrEHMhzf5Ed1IE/DFnipgb+0wLvSyX1A42nXodbtMth6Xa+m9
         3UarqhGY85IQC8P4DQUcriSerPN8VVg2R+Ij894PCUdI6r/xljOd6UGiCjI2210cYYkd
         ngwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781277637; x=1781882437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        b=Fx8Pb/+Dytu6Zy/hcEzNWmg90Mk6CuxUcP2Wq8oERDxgFZu+bTVK8ifEY7zpRyn6MD
         wI8DVHA6YrX8pl8ABY+cjGONxn6bixmi7AqrXgW1gC8I+PbizPpkH+3woGI7ZH85di/P
         MAr9k7jCfrD7Q699MS+23oR83ThWygc5unvCkjz7QAQMsBE4EVtB5Ml2xBbRa/7yvAHt
         unncnamZ2zixlhHdHPYJaSx1ze0Tx5BUMPuocqBTMLVY5FIsDdYdzEYQZqE0WnrckwBr
         h1zayfzXbGlYEvWc0KdYxOJUymy37ZckPFRfo9bLK7Uyqjt96xc1uJYu2HKfuvURS9cU
         +1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277637; x=1781882437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        b=OQBTVnfWHOmZxFLUCoXw1xDeYBmkZA95g7+CZzOy4lWDFdj4Xu5lT0aHd4wZVD915p
         pub/tGuDVkboYci5IsQpnjRMJyENnux1BneGRe2B653VRnk6ugxrG3Sdr8KF2u1K50jQ
         6t/QgMlAI3ANvQhidLPnJJhgbXH5ddPrComVVC3wJc6fC9VaYRqCLyaaxDUB49OveuiI
         FFCumotpGdhs9FT8jhwaQ6k8dkf0WcM9KNLWvcV8upuQ/KaaVRTNrgKqVJs3Rytbksu8
         KKU7uEoMWvTzQPnNN3syqpsBAo8D+6sSY5FJXWJdgoGOIXIRrmjVIl0elpDFnhM7wnos
         bX8A==
X-Forwarded-Encrypted: i=1; AFNElJ+57qdKuifCuB12CZ7vX5QDBEqEnzJSFdS1ceiuzz3tVzpQKtG8Ny/eATI2Nkl0/qkAsWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aFL1JxJnoYEmAMwxnP8kMRU12IlqVwCSccd21y8pCIZE4e30
	9DbGRdIftcmHDBRX6P1wCeK4fPmyNAaocJr0FDsTYYcwI59jF7QZJzdr9CzmXLs6Y4LIPtc7vxl
	FG5R7eoeJXPLEpxw/hN0OmhSo0KYSrtI=
X-Gm-Gg: Acq92OEfVugEOa8LBVDTtg+ZQvGVJzPB4O5aS/EnbtQ5BtvupYucdDNc3M6Duil39vY
	lAFGfxM6fuiVZDDyYJyhYGlAJf3d20Ak+aaCgHAG/0wId9JFKCWQWcZYv5/sfuDlUGHW2phzwr+
	6ufB+9m7Q4lMvKghKxRF1Pe+nPO3Baq1h7sGKxM1Zb7Y+wbACDnMK5Z7DHJZP3p5FsjyxWBKPnL
	MQ8DHIc+xye2LMoTYOX2q1RdKHodw0HtsdziFJu0W5EoFRPEaIjUaJkVDjBq1/POwRep2hwMhNZ
	OlVrTYmsd/mkU2EPQl61G/W9hchD6S+Frj3vBSdFHVXRE590/FHPpwEvOtaj1lCNh0iS7I664sj
	gagJk2I0iDyFNlcAAYc8ng8RG
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id
 d9443c01a7336-2c4105092a4mr43638605ad.15.1781277636625; Fri, 12 Jun 2026
 08:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com> <20260612000825.105100-1-dwindsor@gmail.com>
In-Reply-To: <20260612000825.105100-1-dwindsor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 08:20:25 -0700
X-Gm-Features: AVVi8CfjbbJ9NP2806R-zYhI-lIJTK8hbauQkHIEdP7hO_raPyV_nSTdTdG6xJw
Message-ID: <CAADnVQL9CJMY9h8haj5+99x-0GmiaHv3wDWuZ_YCYETKTznBbw@mail.gmail.com>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
To: David Windsor <dwindsor@gmail.com>
Cc: alex.roberts109@outlook.com, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:08=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 01:59:10PM -0500, Alex Roberts wrote:
> > +static int loadpin_bpf_prog_load(struct bpf_prog *prog, union bpf_attr=
 *attr,
> > +                               struct bpf_token *token, bool is_kernel=
)
> > +{
> > +     int res =3D 0;
> > +     struct file *exe_file =3D NULL;
> > +     struct mm_struct *mm =3D current->mm;
> > +
> > +     if (is_kernel || !mm)
> > +             return 0;
> > +
> > +     exe_file =3D get_mm_exe_file(mm);
> > +     if (!exe_file)
> > +             return 0;
> > +
> > +     res =3D loadpin_check(exe_file, READING_EBPF);
>
> Why are we checking current here? IIUC this will be whoever calls
> bpf(2), which would be the loader, which would then be able to load bpf
> programs from an untrusted source.
>
> In the kmod case loadpin_check() sees the .ko itself.

See sashiko comments:
- [High] The LoadPin eBPF trust mechanism can be trivially bypassed
using standard system interpreters like the dynamic linker (`ld.so`).
- [High] The LoadPin eBPF trust mechanism can be bypassed by a
privileged attacker using prctl(PR_SET_MM_EXE_FILE).

and the bot is correct.
This patch is pointless.
