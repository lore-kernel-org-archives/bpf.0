Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F142D949F
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023891; cv=pass; b=lo7LwzfHQHP76Z9R12HXm78WgxTCaa4J3G8UoSEUFNgYhgvqZHaRdHbl2c5VjUauDyxVmK34f9hzOsAf4qBvmsmomWlMYJ19XPnw2rvWthoQTtFHiKFaSoja6OlXYAPoGVI0MDMDMGaSucQyK3GInIipnvKk+L4f/bz+Wwu7Ksw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023891; c=relaxed/simple;
	bh=f3QRt2O5Y9LT+uY1IYZtzn1bTpPVzR1wAbI8pf59ThU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+nISDzSUN14wGkE5DSx2nV+PgSekwx1IhyqfOucIWqf4YmlK6J8WJK8SzRrT+7R0dxKRGWOdrneAiMNMkluuBtG83IOs1HYVEoIxWZ2pEz3sX02NnEQj4ZJbBK4Zw6QknM9YpJAFFCCVVFNKkycoASTcGkWPJISst0AcchA1fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7iULwTB; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7iULwTB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso142854f8f.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 20:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780023888; cv=none;
        d=google.com; s=arc-20240605;
        b=YG1nbsb3J/8h4EV0NFg2N28GEnAWIeL9JLbEW05c61wdQ/ZV47LZypnFl9NifvosNy
         EipnZOZ7RK/63DkhAzsFQ0QyT98PgB3DqfsdRtB8939Pv+b0HrwC42HnEfzjGJVD61nZ
         SjUpyxh6kNZHUtSdhqZcGu9jPTDOw8DAbgV/cUuaj0M69XiP3Wqch8C5ZAqw36bJGKFm
         CR2FosjxwWOxyDQpVMwxx+zYbjb4CkExJ9g3F8Rh4eS2yrNpez8cy7A9emPhODzgrEkU
         8hPj0BGMMrdb45dgof+FGsci7hpCHaE+KVes0SSp4n+0hxMq72YTsyJ5pi/wHJ7ADm4V
         fbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7r0aaqsLhS65Q+bVWhJs4NuEZPllSbFtrlMPMMOInkk=;
        fh=OIL9rdtw3QuKYn1xVL2lEAIB992dTAgMWZjjddm7vTk=;
        b=AouM/ExuLZ7KOIce0TqZJPL/7Dg8OP+f+mh5iR+n8gvSq97a7G90o1yENKRivZPVtZ
         cbk2lLYG+FBpnWJ3kGMKGQloPmoiNrhgGxwoMdulHSFUrQG6NQI62rzPvBL3XmvylHWb
         uoYnZ5K9YBTUwXQRsack7EDVKKJ8Om8k6fgwYDCXTXGgcfBxxOzXM46aV3ZZEKT9X+lA
         As/MZbOa/lPXJwakmbI1kMfXwLNbP2viNyDERwQh4c6y4kdMpilj7uXxbskskqhZTyb/
         PN3qLwQq7lIIIcj1ZvEOA17uALC57nfS3nh//zf5jrvJr2RknEO4DjbvVmHgZawS5u5q
         ixKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780023888; x=1780628688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r0aaqsLhS65Q+bVWhJs4NuEZPllSbFtrlMPMMOInkk=;
        b=E7iULwTBMhXO4CE7sNajOOojnMnDfltrY5BmdxNmIpfBq2nE3yPXyeWpMuYxa1ExU/
         O52aM4zBkZbjbJ9vgYONA1Fe9r2JizSqPYvNymSAA9Kpb4jrmBdrlfnA+LbK9lJIWlYq
         cuCj2jCyMhKZY7C7rrUjFj9r3sVtvLsrn0u5HUfgQ1AsagpfTyHzdAAG53Ohfsbnr+RR
         /+QJ32enaEVLgOZbYIqpf8nDRjm5+8uSy6SpKjhmH6KujEKeKo8YDw7tYZuKNZz0GiOe
         WPVqCXLTCI4ge8oTxEtr+A1KxKNNqVTB0H0PvR7nojqpECrtaeRUZbHvuMcvsvWdekGx
         mMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780023888; x=1780628688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7r0aaqsLhS65Q+bVWhJs4NuEZPllSbFtrlMPMMOInkk=;
        b=Gl7p+RdqhecrxsCQ50Fcd24Y22DnwkJxBNluexEGTFIGosHMzMhG3aHLQiowXuIjkg
         rVVpN5cFecqUc1XUKFAHp4dLNmDWl11KjRioAS4pyjwSR1OC0eoAk5wcFouUOsc5siQg
         8nzEpedeuzfagToEyQ8Ue1eqNX21IkMXaXnJC5krGOHMX+c/ED7Pa69Tt8qipFhpu1Ws
         XR0bw+f+rMaSYvmhhZhMgkNHNNQOx4gJXKCr3wpsDF0XrpQSjZ44sg/PimaSWhGjMd4a
         Fi5Ati0sCA6ZBGRkQobuRftPxCcoeGlasGEzVd62lnlRjZXWOab5poMxJDa73782YbkR
         GffA==
X-Forwarded-Encrypted: i=1; AFNElJ+5jqqABggTTOo37D14zMBQrjJLixza6Qoi5UXC9e2r2r87OixbCt9rtGmVUx4jeebKGN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKEy1ientinv4nJdXHA4i62Sma7l4m9kSjyiH8yEQQLu8hIUC
	G4pfhUD9jARYW4/PLlabC4zrv3zeKYHp98OvjZlagooR3SwkItR6dsmLVsHknmUg4ZpOhAkEuSV
	gQ40SWdLunQuKK3GbXoBFvghmDkgCx0s=
X-Gm-Gg: Acq92OFsvRU4kvS+IgUxBu/CaJbvUKQj3CX8ZLpt30MjtT4mhvLqTeRwPLC+DpW9xHY
	qVsOVLz/yi3IpZD0gWzwZXEBV+5p34OkVprukhCYmF5W6yGREJHeaKBqmLmReO86/ivN0XnRalv
	ibGXqghXUwzHEFYqePZoiKITYkXmHK+V7hyRjATWSVztYJ9DQuSnaYFpjGCZ38YdIVb/gvSz793
	1k9KpgZnI37fbEUzXK8UAuJdpOHumhN+8AnZVZFAI1WxUgsrwvXLLwwuzFMk3FLkjn+0Q2cnIP/
	w3GLPbzTJJ5MtWc884gDA4EYBhcBVncpxI5KWnFTF3k/A1c3vvGid+9mGkeNUMZqFzAXWCLpzK5
	+ynqjZcdCLOfUcLjJqZTiuRaCGbaa+e+aQayX
X-Received: by 2002:a05:6000:469b:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-45ef145ab6fmr920887f8f.35.1780023887833; Thu, 28 May 2026
 20:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA-VZPk5=sQMCkngpXBo34v6=Ut5YmxNiTKSLfS6-GiSvUZUEQ@mail.gmail.com>
 <5bd0c7b135559943f3abccda6390705da5e493d5.camel@gmail.com>
 <9d1dc36948ea9cfdf48f643f9b34ccaf51411847.camel@gmail.com>
 <CAADnVQKfjaro6PMyd=2qaU9UeecLmTbzfj-f5ULUpfobhsbUgQ@mail.gmail.com> <43d76deec1c5aa8a2029f907ad9c119d83b9966e.camel@gmail.com>
In-Reply-To: <43d76deec1c5aa8a2029f907ad9c119d83b9966e.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 May 2026 20:04:36 -0700
X-Gm-Features: AVHnY4JpDXezHoTCbmIhhfPo79sGbPm5HAWOwf_pcvPxa66Ed-FVDZm1l9nV3ig
Message-ID: <CAADnVQKyj_QHfsp7COv5-RUFE03FDYOE4VTNhY-_YgvTiDCKPw@mail.gmail.com>
Subject: Re: bpf-next verifier regression on unsigned bound checking
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: YiFei Zhu <zhuyifei@google.com>, bpf <bpf@vger.kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:03=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2026-05-28 at 18:05 -0700, Alexei Starovoitov wrote:
> > On Thu, May 28, 2026 at 4:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > [2] https://github.com/eddyz87/bpf/tree/cnum-split-at-zero
> > >
> > > Approach [2] fixes the issue at hand and has almost no impact on
> > > verification performance when tested on a set of
> > > selftest/scx/meta/cilium programs.
> >
> > pls quantify "almost not impact" and send that patch.
> > Looks small enough.
>
> Here are the stats comparing current master to this patch.
> Results are filtered by programs taking >=3D 10K instructions to verify.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: master vs experiment2 =3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> -rw-r--r-- 1 ezingerman users 504K May 28 03:21 selftests.master.veristat=
.csv
> -rw-r--r-- 1 ezingerman users 504K May 28 03:07 selftests.experiment2.ver=
istat.csv
> File  Program  Insns (A)  Insns (B)  Insns (DIFF)
> ----  -------  ---------  ---------  ------------
>
> Total progs: 4707
> Old success: 2952
> New success: 2955
> total_insns diff min:    0.00%
> total_insns diff max:   32.41%
> 0 -> value: 0
> value -> 0: 0
> total_insns abs max old: 837,487
> total_insns abs max new: 837,487
>    0 .. 5    %: 4702
>   20 .. 30   %: 3
>   30 .. 35   %: 2
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D scx: master vs experiment2 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> -rw-r--r-- 1 ezingerman users 38K May 28 03:22 scx.master.veristat.csv
> -rw-r--r-- 1 ezingerman users 38K May 28 03:07 scx.experiment2.veristat.c=
sv
> File  Program  Insns (A)  Insns (B)  Insns (DIFF)
> ----  -------  ---------  ---------  ------------
>
> Total progs: 376
> Old success: 351
> New success: 351
> total_insns diff min:    0.00%
> total_insns diff max:    0.00%
> 0 -> value: 0
> value -> 0: 0
> total_insns abs max old: 233,696
> total_insns abs max new: 233,696
>    0 .. 5    %: 376
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D meta: master vs experiment2 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -rw-r--r-- 1 ezingerman users 234K May 28 03:28 meta.master.veristat.csv
> -rw-r--r-- 1 ezingerman users 234K May 28 03:14 meta.experiment2.veristat=
.csv
> File  Program  Insns (A)  Insns (B)  Insns (DIFF)
> ----  -------  ---------  ---------  ------------
>
> Total progs: 1540
> Old success: 1448
> New success: 1448
> total_insns diff min:    0.00%
> total_insns diff max:    2.08%
> 0 -> value: 0
> value -> 0: 0
> total_insns abs max old: 666,036
> total_insns abs max new: 666,036
>    0 .. 5    %: 1540
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D cilium: master vs experiment2 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> -rw-r--r-- 1 ezingerman users 16K May 28 03:28 cilium.master.veristat.csv
> -rw-r--r-- 1 ezingerman users 16K May 28 03:14 cilium.experiment2.verista=
t.csv
> File             Program                            Insns (A)  Insns (B) =
 Insns  (DIFF)
> ---------------  ---------------------------------  ---------  --------- =
 -------------
> bpf_host.o       tail_nodeport_nat_ingress_ipv4         19858      20170 =
 +312 (+1.57%)
> bpf_lxc.o        tail_nodeport_nat_ingress_ipv4         10510      11457 =
 +947 (+9.01%)
> bpf_overlay.o    tail_handle_inter_cluster_revsnat      10857      11437 =
 +580 (+5.34%)
> bpf_overlay.o    tail_nodeport_nat_ingress_ipv4         11768      12729 =
 +961 (+8.17%)
> bpf_wireguard.o  tail_nodeport_nat_ingress_ipv4         11811      12769 =
 +958 (+8.11%)

ship it.
