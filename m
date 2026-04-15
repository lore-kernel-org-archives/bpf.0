Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC933257844
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 05:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229272; cv=pass; b=UhO4nuirvRVGoVRI/LpmwgISVc8jPpL61T9c9XfV7MX5Mss1vEM6Tn/gWObPwMjrMOOnryVTFJLHKw6VY+39hkHgVTRm+rjkxBE+HqWfnCg/SwoRvS0Ilxq+IDZOZrg8trowRbYUOkTqBTlXARYW3azN7e5oBqe8FZwfCQgD/fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229272; c=relaxed/simple;
	bh=QirJl8WaHQwps9j/tILNSlI86dQugmXMvOp8MaLT63M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQJGh7kKR0MLzlNh9ybP8FCgFCCk7LJPYQLlpCUQCHmrvfxAb/6jffVqHmNlMh4smOOyQjSGSxyyaDE4duyDmaXWhYNRvIW4VpBQbLUKVDtrvUIt494KUuMH/ZAQL7QlSy9B0g/gjk3dGw8GWY/G5E5jZoqXAFWB7VTJEqoO1zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWQcCQIa; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWQcCQIa"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488b0046078so61996755e9.1
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:01:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229269; cv=none;
        d=google.com; s=arc-20240605;
        b=TWDn3d8cP3kRfldy2iOxf8PCTKzviPBJ6zQMDJIRjiLefjbL+a0SBJnowuGkWdYhxa
         ZisbXnqTSSyfStpvh31c4FbBqmuo+huH252XlRj11p0qprMsK4RgnDWqpA5ExBMiLoej
         OEd7aR4BgqCscNjRBZkj9jj8ygaYu1Xrxo9Qh1RusRtpKfeipEG7OvSyIBZKHPoY/1xK
         85swVqMqlygc3RIRy0x2NI8quVeYMcqntpbmYrqxAw/fUiK+PG+2JfcHmAbEvkmID9sN
         1iRFK0y8WS6jkcXvoifj/h5irhmfAUf3U+b1H4z94hNVaVu/g6Cy0aPFHX6AGXA6/heK
         vINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/R0lXhcdlyAHMwvVaEktsJ3MuKMkE8nhJLOBnUnfFiw=;
        fh=jHthAA/dH79rylRn08wgLJj09W5+8yPfVKmuZgwRuBI=;
        b=Ndp65IYFYO4kgm40vd4PHHn2J5uRtHI9Tdd4RysHiS3DZnqNXK7ECIToUcDv4hFiM6
         VjQ3uektikYuoBK4ikmpe5Ub9uS8Yo+LuUfR3+P91NwjjhIPG67ackBabfYKmApoxFu6
         MlYfJWdrCvEPEozn0YACUKGcs0UNSL4Fsk5rJ2cQ0RlUrveqf4FYeWPCpfELBUf1j5/P
         tKKn1+fVuph8XS06J6mFtdw6PR1DrPfQOMdtd4TLK0X+2X5DGw1ZXTneaYdGSfkxHiAz
         nAPGN4HUi4ZgKTwb4vIOLS45FhyERJKuy+fO6ztjki76N8x+KX+1iaI5GDjh14OAgLIc
         x3mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229269; x=1776834069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0lXhcdlyAHMwvVaEktsJ3MuKMkE8nhJLOBnUnfFiw=;
        b=nWQcCQIa1xEfGCEqPnLXD30KIKJWg6YnTHAqWst/U3WiA/eJGvfLeWRH/g8yPcS2Gr
         SzpXLXY85kEpscidfhn0tYP1xGc+P33KXUNUgeAp9PG5zfaxOiXVlJDFRynjs5NmepiS
         hDBn8rnGDihackeEaQs48upxwvdAxmikkPBGPSH+QdlGvkv2XIWySHn2whPWjWtQHiaK
         UKbLDvi24nOpp+dNnbUcqfRN5fyCLU9zAhyNmAKd9kAPmUJWT+dfRNY3LRu4W3/wHlAw
         9vm2Z4FWjDlFexTgBRACKhKs2GANcCdkNq+wfnELk5HOoqW+CjeapxBDsWJO27k2JRoM
         ymig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229269; x=1776834069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/R0lXhcdlyAHMwvVaEktsJ3MuKMkE8nhJLOBnUnfFiw=;
        b=i75sGnAskRtAaYw2jGlspx+kUkRvPhihybtUMUAMSh5rB83taDAZRJ3s2Ormx+tei4
         HYKroaU34HjnrgfBE0PPMzh7v8MgV+62VLCDaJKl6qNQTHRzL3fWnWqRbtYOLWTMDkvc
         UZCHl4ApJujDI06qeZZglw+ceTWdaetGe2eb1JKjrYvqE5B6uBrBb5VX8RqzRDNVk6+J
         j5/jdPuhnJwCr3uvJb7ZrEbLzMXybN4kfpo0xp/kssDqkyt6yncDKBzJaQwcNAj0c1+t
         CeJp1/P7DZBQRSOvh8AvGQ/ynd6Sl2clkgVlwV5tiVAzz5uGaU1e3mUMot3GelQDQdPL
         WmBw==
X-Forwarded-Encrypted: i=1; AFNElJ+KIk07YYihApdb2dA6lx00ZKq/RX6oP2r64zsgdZo1/mAQ/YDzOFV2aOSh+8XwnStAMwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Xyp3FP+hKH95zkrBeWWpLN0SkMuQcUU49l1rB5Vmvne0YylC
	qpL3tFsYTp+B1F9dOnBrDU/+8XNy61yqkDVhkLWx4/0ekYu9oGrhK8VwJJcJoqks1n3pT7QqaO6
	ujGlWNxr7lwn1ViogcatTyoSoXFvp0dM=
X-Gm-Gg: AeBDiesEvG4gYEw07N/x5Ulbw2uE+Amtgd9p+CqCsX2Ubn4OaKRNxdGSKdUJGgc7uHK
	5uzTY3QTClxtMo8QHLmISnbe6S772jMyU98aiIvYPXBIO7ZPz6Z39fp+LCJxztXNwKbnUSUzgrI
	R461tVz1YzqgmAEBm8aN9ZQV+usGjbjIIkuxa+wkrIAnw05tLHAyc2vAk3xyis0DUWg/BRQAqoQ
	8v0p/YVu9UgLM/52Bv8KJWszaT9JT+o4FvjDxdybAMOyjb9s722agrc66dYIE1wvaP4q4pa7bCD
	EFg4Q7iBHAmWsxqCMhkz/lrgDVhqO612oyYYHeLH/BOx5OEl9ONX/UYhGjF90u4NN2tkhVPb3vD
	ygMd2kTqac7efxGQpKynHGIb+hEy4x2eJtmbo
X-Received: by 2002:a05:6000:26cf:b0:43b:9903:2ba3 with SMTP id
 ffacd0b85a97d-43d642c083cmr30903697f8f.33.1776229269096; Tue, 14 Apr 2026
 22:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177601563477.7932.4081917600853246368.tglx@xen13>
 <177601564263.7932.2238613098642404049.tglx@xen13> <ad8OGZmCVRc1C-Ck@MacBook-Pro-49.local>
 <CAHk-=wj56cA+_m8YL-5HuHeSDsA_pvuH8Lu=K4JG82iw=G6bAA@mail.gmail.com> <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
In-Reply-To: <CAADnVQK4MOCe=oJPgUXwZdwTu7ZK_WjmpO0jk87A+j0zJeaCTg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 14 Apr 2026 22:00:57 -0700
X-Gm-Features: AQROBzB7r4OnZywLpOrxZt0D9_hUc72jZgDJjTr9NUKwYgtZC9MJHhEXX72Bc-I
Message-ID: <CAADnVQJ=MoiX4=guPWhL9vtnAELkpNx=GNm8RA1-aV424UFz2A@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v7.1-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	X86 ML <x86@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009fe70e064f789ae2"

--0000000000009fe70e064f789ae2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:40=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 14, 2026 at 9:38=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 14 Apr 2026 at 21:10, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Looks like it breaks the boot for me.
> >
> > I can confirm.
> >
> > Trying to narrow it down now.
>
> Instead of full revert. the following helped:
>
>  config HRTIMER_REARM_DEFERRED
> -       def_bool y
> -       depends on GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
> -       depends on HIGH_RES_TIMERS && SCHED_HRTICK
> +       bool
> +       default n

and here is a fix mainly by claude with a lot of nudging
from my side.

Fixes the boot for me and looks correct.

--0000000000009fe70e064f789ae2
Content-Type: application/octet-stream; 
	name="0001-hrtimer-Rearm-deferred-hrtimer-on-kernel-interrupt-r.patch"
Content-Disposition: attachment; 
	filename="0001-hrtimer-Rearm-deferred-hrtimer-on-kernel-interrupt-r.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mnzl18m50>
X-Attachment-Id: f_mnzl18m50

RnJvbSAzYjU3ZTI0NzdkMWUwYzc0ZTkxYzZjZTdlN2I2N2EyZjYzZGEyYTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDE0IEFwciAyMDI2IDIxOjQyOjA0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gaHJ0
aW1lcjogUmVhcm0gZGVmZXJyZWQgaHJ0aW1lciBvbiBrZXJuZWwgaW50ZXJydXB0IHJldHVybgog
cGF0aAoKMGU5OGViMTQ4MTRlICgiZW50cnk6IFByZXBhcmUgZm9yIGRlZmVycmVkIGhydGltZXIg
cmVhcm1pbmciKSBhZGRlZApocnRpbWVyX3JlYXJtX2RlZmVycmVkKCkgdG8gaXJxZW50cnlfZXhp
dF90b19rZXJuZWxfbW9kZSgpLiBUaGVuCjA0MWFhN2E4NTM5MCAoImVudHJ5OiBTcGxpdCBwcmVl
bXB0aW9uIGZyb20KaXJxZW50cnlfZXhpdF90b19rZXJuZWxfbW9kZSgpIikgc3BsaXQgdGhhdCBm
dW5jdGlvbiBpbnRvCmlycWVudHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfcHJlZW1wdCgpIGFuZApp
cnFlbnRyeV9leGl0X3RvX2tlcm5lbF9tb2RlX2FmdGVyX3ByZWVtcHQoKS4gV2hlbiB0aGUgdHdv
IHdlcmUKbWVyZ2VkIGluIGM0MzI2N2U2Nzk0YSwgaHJ0aW1lcl9yZWFybV9kZWZlcnJlZCgpIGVu
ZGVkIHVwIGFmdGVyIHRoZQpyZWdzX2lycXNfZGlzYWJsZWQoKSBlYXJseSByZXR1cm4gaW4gdGhl
IF9wcmVlbXB0KCkgcGF0aC4KCldoZW4gdGhlIHN5c3RlbSBpcyBleGVjdXRpbmcgb25seSBpbiBr
ZXJuZWwgbW9kZSAoZS5nLiBkdXJpbmcgYm9vdCksCmhydGltZXIgaW50ZXJydXB0cyByZXR1cm4g
dG8ga2VybmVsIGNvbnRleHQgZXhjbHVzaXZlbHkuIFdpdGhvdXQgdGhlCnJlYXJtIGNhbGwgb24g
dGhpcyBwYXRoLCB0aGUgY2xvY2sgZXZlbnQgZGV2aWNlIGlzIG5ldmVyIHJlcHJvZ3JhbW1lZAph
ZnRlciB0aGUgZmlyc3QgaHJ0aW1lciBpbnRlcnJ1cHQgYW5kIHRoZSB0aWNrIGRpZXMuCgpPbiBL
Vk0gZ3Vlc3RzIHRoaXMgaGFwcGVucyByZWxpYWJseSBiZWNhdXNlIHZpcnR1YWwgaW50ZXJydXB0
CmluamVjdGlvbiB0aW1pbmcgY2F1c2VzIHRoZSBocnRpbWVyIGludGVycnVwdCB0byBmcmVxdWVu
dGx5IGFycml2ZQp3aGlsZSB0aGUgaW50ZXJydXB0ZWQga2VybmVsIGNvZGUgaGFzIElSUXMgZGlz
YWJsZWQuCgpNb3ZlIGhydGltZXJfcmVhcm1fZGVmZXJyZWQoKSBiZWZvcmUgdGhlIGVhcmx5IHJl
dHVybi4KCkZpeGVzOiBjNDMyNjdlNjc5NGEgKCJNZXJnZSB0YWcgJ2FybTY0LXVwc3RyZWFtJyBv
ZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtNjQvbGlu
dXgiKQpTaWduZWQtb2ZmLWJ5OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPgot
LS0KIGluY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oIGIvaW5jbHVkZS9saW51eC9pcnEtZW50cnktY29t
bW9uLmgKaW5kZXggN2FiNDFlZWM1NDlmLi4wOGY2NzFjYmQxYTUgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oCisrKyBiL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5
LWNvbW1vbi5oCkBAIC00NjksMTMgKzQ2OSwxMyBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIGly
cWVudHJ5X3N0YXRlX3QgaXJxZW50cnlfZW50ZXJfZnJvbV9rZXJuZWxfbW9kZShzdHJ1Y3QgcAog
c3RhdGljIGlubGluZSB2b2lkIGlycWVudHJ5X2V4aXRfdG9fa2VybmVsX21vZGVfcHJlZW1wdChz
dHJ1Y3QgcHRfcmVncyAqcmVncywKIAkJCQkJCQlpcnFlbnRyeV9zdGF0ZV90IHN0YXRlKQogewor
CWhydGltZXJfcmVhcm1fZGVmZXJyZWQoKTsKKwogCWlmIChyZWdzX2lycXNfZGlzYWJsZWQocmVn
cykgfHwgc3RhdGUuZXhpdF9yY3UpCiAJCXJldHVybjsKIAogCWlmIChJU19FTkFCTEVEKENPTkZJ
R19QUkVFTVBUSU9OKSkKIAkJaXJxZW50cnlfZXhpdF9jb25kX3Jlc2NoZWQoKTsKLQotCWhydGlt
ZXJfcmVhcm1fZGVmZXJyZWQoKTsKIH0KIAogLyoqCi0tIAoyLjUyLjAKCg==
--0000000000009fe70e064f789ae2--
