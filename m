Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03143C37A9
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367310; cv=pass; b=ttp43Zj6LOMBdMf8H1n8kaEHyLZgtemD85z6Em513nnCl8eMnJDAj/6LWgAYGqN7afOmL/jfPcIJn4IPytqjJBiwqBIJ9jzhc6Sf9USEsS2Y9W8g5AQU/LdVqsrjCrxhwCjRQLJkLPGIBTbj34BAVhMZqfTBD8EvYZan36VfVuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367310; c=relaxed/simple;
	bh=ajNsPFWxi67i4bgMw3vkYCZO61HQjPsFiGOsP8Gh2kE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhR/c34PhFdIOkPLT4dLdTxyuEncLmGdZNauxO1dwgqNZ1NkUdaAHex5/tITIJdCMJYIpEclfDlMGC/C3iyQTT4P32VLvKyLg6sdhEf+cAxOTlYoR6KAq/a218sgw+dYW3T392TlFnfAucQsLhvUMTcSY232DXSuGReYr3rzQqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2eALK4U; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2eALK4U"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8891febd2so8462607e87.1
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 05:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367306; cv=none;
        d=google.com; s=arc-20240605;
        b=XtRrefYNDLXbFy85eQUNMsH1qZE3kx91qBpwax5F4lRVxiseJz2pmhxvpnCVHIksxs
         CBo6BQf4WhtubxASmztkDgx8tHC1Prp9OOfm4kuPVDvZL2RblJa0vpA0ApeNZkNQ0mH6
         EsbB2JdTB4nZD6WQbOudt2n6ZvWpKVpt3h5BDmzKz2hBuoj8LOFFcmSOaZeBAjQTikDe
         Pq5TrebvY7+ey5FS4PzNnW9eywIcx3PgD1ySkATy5UQSanhqxff7e7LpnV8pipz3qTEr
         5pxWVXUOMsXaQtgNRZsRqOZ99xJc6eApXj/H4qJzx3I3ImGWDWHVYd20mupE4QLtowZm
         anAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        fh=lIkV5aG5caOYPdBwtfGACMJMVWCrEH5fgbPyD8ICf+o=;
        b=bLa3s+JUx+nT/zBFa4/cicb1MMZlmKA77pJAQZN6/vshylxSlMTmElv6TnCrpdKp4b
         fcZEA4p5gno2Is5wHtC390yb9zK4FKemaZjhMTNRaZ6C/CHMINg7GftS+Qc9kV69Nopc
         xbN6qVmEgYhIH04DdJcer/P+A5G+Dbur5AqwZkZinK6wdz4fIjHgMElZWzbOX2rlt1E+
         y0E2JI1aCbF3Q3KzKYgDI7OKdHJ3LdXf1Z5H/EQoVbg8O9bXvWGADHm0K6RRtFCILbWG
         9Pdkp03BKJF1fUEMfsuxAltCFOFbAaM93X7FwI/FQq3/vVJN7ge4oWeKPRlNMpD96rQb
         MwMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367306; x=1779972106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        b=E2eALK4UF2oNJKugR9N1qHNCiMYZg/DM/jpGJvKDKGpinboLNX+gDFNdSDKMlXVCuJ
         8hMOpJB0SR6YBr12CRFIoZsNsQGNGZLG0WEylFAlsuwCNv9O9MHNgt+6RYjI84mccAIL
         JaTeWlpTEJyBO5uY9ZcP3yVz80pJfbDXGG+Pmrq6jqgD0VrCx9kLRKDr8f4/1E4r9joS
         8NKuYa25+J1Q0gOA+0zYdoUMJx7Q4m0h2wNY1HXW3eVpVyFYM6evlAbRDeA+hNTr5ang
         uI6A9R9VyNuFzCozLDCB8aKREM9uDAnXv1QXcHamFkerYdbMIMy6WwobrDtlqg5UxSPn
         5Jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367306; x=1779972106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wj8b0PInlbwEaQL2WeFM+DLmcZXYoekAuC/bTMttwzY=;
        b=mJu+4skX16IgfTB8QiQU7oEtmrYgpN5GiLjgftn4ehaQYATjpQZfar4Zif8og7c/9V
         Z/FQ2sRRoM+Z/z0knRyPYKJbgwZ0fSPWWb70zBOKexK1IwcnFHmb+jWMrjtaX1fNO4uA
         UWgUQcWtuSslhJ1nrw19MJ8b4YMevfMEPnYnHwjdsqU/Y259ckYM0Zx5U+6QQ+uGGliw
         ZV5PMridp31A5QzTFrfehTJMLIUKd++8B45n47J9Qmo3JXb4/e/GAQ4UxHh1wdtphZAf
         3DfsbjXgCZ6WfXBTBCMXDcqX+0nkqOM2w8xGL+s6O4bTujRr4NLNjPpK/nPyJNVqfzsi
         aSIA==
X-Forwarded-Encrypted: i=1; AFNElJ8hu+cASNdVd1+sJM504ByIOP2EKJbh3+QtEdoIiZ3s1bnNjVJIhKtuV9YaofSUkFTE3kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSmE4I1FlEtEqogK8gJzORK/37g2WB663byNnHGJf4IOMeDI1y
	WD1cApebOGdrA4IkjVI2c61w4MDF6xnUEc6NbeJWlg5cU4incQP2Dq/oJ7+MkDO2k6VcdtUX7iu
	43/bpIOm+lhMSxtkCFVbK1zViOLA51RY=
X-Gm-Gg: Acq92OHprWICUMBlxEtwioxk7LxfEzDwdz98CivDN0sLqWydoS2GSVt1nbYTF+ExFz3
	8Fx88GdgvN0DtBOFqjW3MJ6rMEWl81w+w1CCFLU/3AG5Iu94XX8Yg3dBQfcdO2v2R0O+vAGNx9S
	cZcpE6d43Or20x+piLx7VjijNhbuwPg7I7dv6Ardi5HM7CsATKyBdmy9K8y9MQS3UEtuxxWVzOq
	1784ygiZMbyDEIUXCM4s44zqCtEFqd/QGfMue+Eo9TRnaHnw/cWRvJcBHGKgsmuUh9VmJ6x4d2g
	hC6octsYeekuZjDeR/5W7jnrYfzxbfpLvbYvuAQ=
X-Received: by 2002:ac2:5312:0:b0:5aa:b6b:f6ef with SMTP id
 2adb3069b0e04-5aa2ba9ab5amr790697e87.45.1779367306048; Thu, 21 May 2026
 05:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com> <ag75Xicuk6JwkTkC@boxer>
In-Reply-To: <ag75Xicuk6JwkTkC@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 20:41:08 +0800
X-Gm-Features: AVHnY4IBkmqbEX6oQILxsI_k8WLwSb3ijz5RH1EQPp_csx8ed2JTaWMUk7p7OIc
Message-ID: <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > The series is the product of previous review from sashiko[1].
> >
> > 1) META
> > patch 1: address TOCTOU around metadata.
> >
> > 2) PUBLISH of CQ
> > patch 2: make sure xsk_addr->addrs[] can be published to cq when
> >          overflow occurs.
> > patch 3: keep cleaning up the continuation descs (more than 17) and
> >          publish its address when overflow occurs.
> > patch 4: like patch 3, but only handles the invalid descs cases.
> >
> > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kerneljasonxing=
@gmail.com/
> >
> > ---
> > V4
> > Link: https://lore.kernel.org/all/20260517063311.28921-1-kerneljasonxin=
g@gmail.com/
> > 1. correct the description of xmit path in patch 3 (sashiko)
> > 2. move set logic into xmit path in patch 3 (Stan)
> >
> > V3
> > Link: https://lore.kernel.org/all/20260515123018.80147-1-kerneljasonxin=
g@gmail.com/
> > 1. avoid breaking previous usage of sendto, and siliently handle
> > overflow case (Stan, sashiko)
> > 2. add one particular exception process in patch 4 (sashiko)
> > 3. adjust the selftest to make sure it passes in either virutal or
> > physical machines, which includes add usleep to support physical machin=
e.
> >
> > V2
> > Link: https://lore.kernel.org/all/20260510012310.88570-1-kerneljasonxin=
g@gmail.com/
> > 1. adjust selftests (Jakub)
> > 2. add READ_ONCE in patch 1 (Stan)
>
> FWIW I still get test failures (yes with patch 5 applied). PTAL.

Thanks for the test. But I've tried with ixgbe driver...

I noticed there are some flaky tests which have nothing to do with the
series. Can you confirm that it's not caused because of the series?

Thanks,
Jason


>
> >
> >
> > Jason Xing (5):
> >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
> >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
> >   xsk: drain continuation descs after overflow in xsk_build_skb()
> >   xsk: drain continuation descs on invalid descriptor in
> >     __xsk_generic_xmit()
> >   selftests/xsk: drain CQ to wait for TX completion
> >
> >  include/net/xdp_sock.h                        |  1 +
> >  net/xdp/xsk.c                                 | 44 +++++++++++++----
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
> >  3 files changed, 63 insertions(+), 30 deletions(-)
> >
> > --
> > 2.43.7
> >
