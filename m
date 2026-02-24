Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A403AA1B0
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960574; cv=none; b=FTIeUSXOwqrJTOMbghrgr8QIbzyc3XHCz0TCV00FGlk1yDoj3Ppw7uGb7oXAItIV5Wk5EeVMoaFrzPgDyhMb1hPNtrJveThvRLjTjCtP1BzAPW8JUS1Z7UswmR4L/4nD2WBsCZsn1Z3cJxv1f1fF0awpGQrxDIsILVhJ9mTpem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960574; c=relaxed/simple;
	bh=P0ecoVdzzF+UeZsQUFTFtuTEYrAgVExTmjzHqFnPKd4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYXOtoGxX84PXJlsCTpNCyfZno0Dg2ai12bPhlId9t8abY441gd7j4aUOYDhTtumaycfLZC0mL2T2Wv+lnfGxrq8bJXNwmBQhGHcDeSTkZW4tqQnvmySAw/bdnj6kj3z/kFggcM5QVx6iFOQsg6474/CHJx3kZlSaL4H4ka9Prg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmHw+uOK; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmHw+uOK"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-126ea4e9694so913461c88.1
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960572; x=1772565372; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vc/fynKjeQZbMJU1181WaQ+2QzBtNM1bPyWBGkubtc8=;
        b=mmHw+uOKssAg6LJLEcdXRn4DrpTLNgl65JoJcrabD+vYPbiFYHrOSk8n+1T3c6Jwwb
         dAD3QraWCfFPnpqD8q18S217+Cox2tIg6XkgHThuvi0U3YIjjqQIDLYec5y9RAN/CSV8
         Oi2ps+bWRUtvHbernO5xXm4oIlzdevtWFO/P6h5a71KLyiMjc5jjywSOAkql2jh+pm7o
         NuKIZHZ7oypzeSzxToeGqwAmVwxdvBsQm6PnwIPp93gMahTtlfeX6C1rlh4RaqxNDsr0
         TW7Em0MMDPTiF+TXD4b+QJzELOJ9gUnuZ+swupV9TR+4ORiYwZF4+hw30obkbVqO4MzW
         ytbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960572; x=1772565372;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc/fynKjeQZbMJU1181WaQ+2QzBtNM1bPyWBGkubtc8=;
        b=Dc2zhQhctj7sVNZvuYH5zmfHeZnQBMt4Ata/lBPdgCVTN7isV5tiJwv/xwh5t/SarC
         YkJiS5ydknOcBS2oD7KAkbv5jFdaX6XCKqpz+Iytem4bBa3QX3446w27THi7csnWkSR8
         RI/XTuOIpf9/27OCr9P/orMw0g00ayMd/HldUXP7EKQhxV72nmB4RNH51m36TlHrXb5O
         kdQXDwxnSA48skNwUG/oxHw/naadtYuIHGgRY2Dk9l8Na78JZR4gFgS0rQWDBHSiVe5+
         5QXXPsmHnXbd8/dioV5JwW+7fN0Kx1kcvgpSoIM+Ws1WqQTNEso1Pb63aZrSPFo75WZM
         dkng==
X-Forwarded-Encrypted: i=1; AJvYcCVMn84vYGal3koSDQHAwnxj64qoYnrpWecRNxACMDK/ruQBuystpws80AOmo9l/1elKg0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKrtY/wlxTC0kGgEtdw3tDJpNFCDJ6FaUUWuEsgRrfk2rphLW
	PgsN1ZAel1I/cps/ef0jPT6SYueIE8uOS8en/Uj/XU7yCQV2plNE9uqv
X-Gm-Gg: AZuq6aKUC1Za56UCWJypdTXQmAWvzVh3zGAhsssGrm6fUKK3Ce3sjGCBhn7HFiOUIeA
	8pVQO7r9xixpFw+oMMX99gkOI62m0mI0hu5UHMnkZhcGMhJJZoyJbL7QkUgM3B0nfZxVbSReu3F
	SIE8m1rHIzuyqX6a9zinsn/4a5T9+W/qrHi70Ju79ULp7zwjy28UcM1nyxBxamQOAZbvK4eEAgh
	qWf7GsVcgZwapejqKniWwVegB57Lm9AazUfZYBnsgJJNR1wKSHQYZT7w4TmvPvUo43lsv7ZT21k
	szDwFLZYaiUiTgeTgMS9Xoi7bkqWzVZXlLJZfBqdZ3Ng21pPziICftrlzVdlSEL6jXflN1WxEId
	QYVSaRG0xbj8L4IWNLs0QuPJduPXMymFzeYZ5qeS5DkbaXFnBx2sttwFbz4YNnNvzJpRJPrfmiu
	sgsKTauzeXHixiFludbw9IJrnpp4NQZ5/qIvzVufeDQZKBhmPs+q75qDDv+KEDoGwUt7o267uan
	aRp0g==
X-Received: by 2002:a05:7022:e1e:b0:124:8d7d:2d63 with SMTP id a92af1059eb24-1276ad37c89mr5508233c88.35.1771960572361;
        Tue, 24 Feb 2026 11:16:12 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:79f3:c942:f01f:96aa? ([2620:10d:c090:500::1f1f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc164e3sm7304718eec.25.2026.02.24.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 11:16:12 -0800 (PST)
Message-ID: <43efe1142fbc695b3fc7ab0c814fd32e2a6850bb.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Use bpf_program__clone()
 in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 24 Feb 2026 11:16:10 -0800
In-Reply-To: <057a7b17-6ecb-4c0f-b176-1e6349b641db@gmail.com>
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
	 <20260220-veristat_prepare-v2-2-15bff49022a7@meta.com>
	 <927e23c543aee236c8f9513930ba6f1791bc5933.camel@gmail.com>
	 <474b3520-f5cf-45b3-be01-d14708cc9a14@gmail.com>
	 <37d63e5e33cc9ba0b7e042b982207de2146d07ad.camel@gmail.com>
	 <057a7b17-6ecb-4c0f-b176-1e6349b641db@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-24 at 19:12 +0000, Mykyta Yatsenko wrote:
> On 2/24/26 19:08, Eduard Zingerman wrote:
> > On Tue, 2026-02-24 at 12:20 +0000, Mykyta Yatsenko wrote:
> >=20
> > [...]
> >=20
> > > > I run selftests binaries through old and new veristat versions and =
see
> > > > some discrepancies. csv files attached.
> > > > It looks like there are some failures that are now not logged.
> > > > There is also at-least one success -> failure transition and
> > > > a bunch of failure -> success transitions.
> > > > I see no such differences for sched_ext programs.
> > > > Is this an expected behavior?
> > > yes, the regressions are explained in the cover letter:
> > > """
> > > Known regression:
> > > - Program-containing maps (PROG_ARRAY, DEVMAP, CPUMAP) track
> > > owner program type. Programs with incompatible attributes
> > > loaded against a shared map will be rejected. This is
> > > expected kernel behavior.
> > > """
> > > in the previous version of this series, there were no regressions,
> > > but to achieve that we had to be a little bit creative with maps
> > > loading, have a look:
> > > https://lore.kernel.org/all/20260212-veristat_prepare-v1-1-c351023fb0=
db@meta.com/
> > > clone_prog_maps()
> > >=20
> > > The improvements are explained in the sibling thread with Alexei
> > > (again because of PROG_ARRAY type of maps)
> > Are you sure that's what happens?
> > Looking at 'failure -> N/A' transitions, it appears that this is
> > caused by the early exit from process_obj() if bpf_object__prepare() fa=
ils.
> > Previously each program in the object failing the __prepare() was
> > reported as 'failed', now these are skipped entirely.
> > I think it would be nice to have an additional logic in process_obj()
> > marking programs as failed if __prepare() fails.
> Ah, you mean those ones, I don't consider these regressions,
> because they failed in the base version anyways. I discussed this case
> with Andrii:
> https://lore.kernel.org/all/7990bafe-d72c-47de-a711-0c8a888d4ed9@gmail.co=
m/
>=20
> What I was talking is the case where it goes from
> success to failure with these changes.

I think this part is worth doing:

  > If we really need to be on par, I can iterate over progs if=20
  > bpf_object__prepare()
  > fails, it just looks a bit awkward.

Because otherwise these programs would be completely invisible in the
csv output.
