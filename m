Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520826FC3
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027949; cv=pass; b=fWfvuT92PQ3WAWiBnIec/iFMGiEd2dTWiVvDgMfdfqnVHrGdJXeRhWpWc3XofIfJA4WU4kNjUEFR20c/6IG7ctzx9E4lD1XDo0su3Ysu26DJq5BPBy1DbOP1fgGx1x6OdGsStBg48YAM4WF/6yPwItmQ9xGcuAJI0HXus0ly7rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027949; c=relaxed/simple;
	bh=IrlVMrCpxU7qFxB8xMuPEjKWpcgvJ6TgZ/UtuwM1idg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFq2nTbzU/EN7z2wvF+Jg9RnPFAHYDE3SOZlepvGbpBkn03D1yweqkGICTXoUM6mp+5O7ulw4IRzL7+BLzJKNtl+QqPjtjjYRNEwmDB0vJFpl+3V/PPBniRWEl5GzX5bqFUcbirMKNp4pMlp7jXVC3Gnmz2un8pYMefdSLvAgEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH6hizl0; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH6hizl0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43596062728so891103f8f.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 12:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769027945; cv=none;
        d=google.com; s=arc-20240605;
        b=gOgzSHqiE9aJPq3108Vwe9kj/MbJAU/fsyoBzZrXNu/kMiM9JPh2kQI6SzzgL8Xc2d
         Xq/C3tjsEKij3scJGrs6wB6WTQGi12FD94l9w4PyJTg9iMzdZQpALieyWCc/Sy9ZdYzy
         4o4oN8WWYFzYBb3zNQtmmdNmodyTkaM+FBGDYMDFlOKKgQrJM0vqAEHgSp48xTXPH27E
         7D17ehtgeZ1orerkrqFFcubA1QSUWDC8vng6zJfpBMbNHUFYKLt1CRT2ys3JInt6D847
         k24392iquIeMLEo0rJ5YYesyl/BbiangbWRzmi3jP/vUZPpNaYxrn+CaTwhnmnj/5bk4
         EVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IrlVMrCpxU7qFxB8xMuPEjKWpcgvJ6TgZ/UtuwM1idg=;
        fh=HtqK6+byu0EfD7yPXbhbsbKvXDGMDeV1f8hLROsaWFg=;
        b=fs/7cAII0snJ0ByXzjr5W01Jo/q5qjDkXNI4TDwVUb9v3G9T4ovNMVJ1LeMkoFVMMU
         BLaj7qlMRLse4TzzVb42i03trp2o1/7pkcTIeP6L0SalYChac7PTl2gjf8hsrshzPDmR
         0BmzH9GpueVzQjSPcZzWjw3lBJPWHGiLCxBAUW40gDHw5qpE/CDTI4pipBTHM/gBPIFi
         ZV02/tscVidx0TIKmEoaO2hMmgHkff89okXJrKDk1PIcu0/wWwk3tFZunYxGuIpWWXzt
         7DQgzGv4wjfjXfZY9U08tXzSjm7C6cu7j7MNNk3nIMNEwYZDZ1dT3fryy3/oGAHoY/+s
         CsLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769027945; x=1769632745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrlVMrCpxU7qFxB8xMuPEjKWpcgvJ6TgZ/UtuwM1idg=;
        b=PH6hizl0UVkZj1GoNmUqISV/X/4uAPDMap4PFOmUQl+ix6uqWL3yOfDhO46xDbR1M+
         ejCq66Opxc7w+Epk2j7vGYU1i0hxz96PBC6o+ODVvmpWT0CGMR8yqY5UbCEMkXClTu3R
         ySoQbPd98POr3ZuIh+V5DnJB969gaJ34HiG4iTfEUnMq9Rj9Niuauj9DWgi2lJT25PVd
         EBBztZHpBbaPOK8OjTsRsDDhqSxh0XMUYfecueqaRf8Fvgu2xo1b+47le1iGFBt9RFEn
         G2bfbj5yYNYak2acgwaVWcDuF5eEgg3Qsini6mb+E6Y3J2X1xKPl6gaqswzsiTzzVjPm
         TGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769027945; x=1769632745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IrlVMrCpxU7qFxB8xMuPEjKWpcgvJ6TgZ/UtuwM1idg=;
        b=XZubJN1PIkZKcYec7UQ1BeMcMmXlvYxvSwbTJEEEvfdN9Zzzn1O07jQC4aqvFFPOoZ
         5jZqI1oMZ4XBLjDCwjgCuXe8XIvhhwa/VJC3wb3Hj18UYyFGtXetyjcj8A430syFELMR
         iqSFTY5nG0E+IhSPuQNvbERQuotYXEyV/uNMLVJbI4yj8Mjfggst8jCadk/2nxp8lbL5
         YQhjPRvaIJjtKj4x8fBlXM7JAM7h3RgfguopIcnkZeMGPiB5rkEBBzGJPsDjoVCyqNo3
         VMulziAVhVb6K6JXQRyIJPzshSBo/IfxxIoVbPsjN05Zrs4ktktUKZ4gQAxhfbsM+Jpw
         AOYg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzGWIzzitpICV8ZGFEXtXyKEBLBWPN7+lq4tnJGt+2rcavqaHkajHzwYmN0zr+EeLsiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDfZvMpWSRQmBkS9OvJZoUxZiaq3ii6b4saWZi9/Wp/HF7MbW
	QoeSjQNzBTgyj6OMS7cdQ+rGE3nGCOaJFczANDq7ibe7Npn1oyu7Ru7sB9XFtrGUICRol+wn/Q8
	rDM4kgHBV8XX7CgvcIU6gBPrTN5PV9JY=
X-Gm-Gg: AZuq6aJO2x3FqBAmEGNKhZtoEhoZ/kOzXpd7jJrTL+Y3MZ6rnTpbONXHdqTOZC2YxxF
	FSDD4eVVT4236pnsHACspGw4bL/GnXXyOxkvchw2sHL9LlIx/8Ga13tpcy0ML4Vehfz9uRPD1sW
	/lCWlFE6Lnp5hCE0tZs2L1VP1XYEAZ8sbvQR9OhG977zLnE8bHa3Q4qhFibBP4Mh68cU29FoMon
	CfJf3HzGykRmQ8gFMw23mNgXwJKTxZzk7OcSI1UqBJgfKVGTSAtKIkYZY11wcMiOS8U/usG5UGO
	ltWUoHNDFR6FbQ8yxiau1Bet0Dwk+ILtONTcI+fxqIiZsbuNqVTDS8Eq6UHwJFFRdivolw==
X-Received: by 2002:a05:6000:18a6:b0:435:9336:21f3 with SMTP id
 ffacd0b85a97d-435a5f6d879mr1487785f8f.10.1769027945439; Wed, 21 Jan 2026
 12:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121181617.820300-1-ihor.solodrai@linux.dev>
 <DFUH7UI3MM6F.1B30NTZ5NFSKR@garyguo.net> <44168005-28df-4b5b-96a7-b6b9e7494aed@linux.dev>
In-Reply-To: <44168005-28df-4b5b-96a7-b6b9e7494aed@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jan 2026 12:38:54 -0800
X-Gm-Features: AZwV_Qgx80ntX9zcVrtDFMlR4B0eTCQDAPf9dXFhXan_QLDrY_rXv7gtVvSl1eQ
Message-ID: <CAADnVQKuOyDrp9=tw78UdnjfxATw38Xm0=UkDGdz=N16mY4Crg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] scripts/gen-btf.sh: Use CONFIG_SHELL for execution
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Gary Guo <gary@garyguo.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:30=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 1/21/26 10:24 AM, Gary Guo wrote:
> > On Wed Jan 21, 2026 at 6:16 PM GMT, Ihor Solodrai wrote:
> >> According to the docs [1], kernel build scripts should be executed via
> >> CONFIG_SHELL, which is sh by default.
> >>
> >> Fixup gen-btf.sh to be runnable with sh, and use CONFIG_SHELL at every
> >> invocation site.
> >>
> >> See relevant discussion for context [2].
> >>
> >> [1] https://docs.kernel.org/kbuild/makefiles.html#script-invocation
> >> [2] https://lore.kernel.org/bpf/CAADnVQ+dxmSNoJAGb6xV89ffUCKXe5CJXovXZ=
t22nv5iYFV5mw@mail.gmail.com/
> >>
> >> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> >
> > I can indeed build again when applying this on top of linux-next. Thank=
s.
> >
> > Tested-by: Gary Guo <gary@garyguo.net>
> >
> > You probably also want to carry some Reported-by, Suggested-by and Fixe=
s tags here.
>
> You're right. This should do it:
>
> Reported-by: Gary Guo <gary@garyguo.net>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw bin=
ary output")
>
> Alexei, please lmk if I should re-send with tags.

All good. Applied manually.
