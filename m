Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825380;
	b=dqxwQxC3t72vT5Ogi7Nk3Q7C1/U+450b1Hc7JzkOQlxnk+Au8OY4onncbgpghZC0Kbby
	 V7VnSch46ycTfhZwx8v+7CG21DwOu9CJXOyo8bUWWBG5anun0ItcnYCMwHZi58q3CprDG
	 yLTbhiNcKtqw7JgNiAusLzuDlwJyvEisxoX1ETF3h4VD5XegOv8ayGlyBc3Xect7T4FYA
	 0qaj1GU6xtVZsImuPKU1iUNWUMuRMPL78ESvxvB7XN2eY4aAxUYi3FPKF6dyRce03MBcE
	 YMQ3V8UjbRD0VaSeD37mYPqRKLbjBkhRaAZYJKN6ZYfiAO8otWlPKuozQdHEm72esuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825380;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=KWiRV1sGkuoDXhM09Z+91Z+gqhSc78puMi7yQgR1TGE=;
	b=NcTrOW18xxL9EM/jO8YiG5torkkB99TioKFeEIM204Okv63E1FfMC3wT2Q9Q66TGISKn
	 UWQY/BYHBcQNXo1DENVWhL21r3Z2aj6W+7Abm39z8x3bjaEZfElTrY/kJLDZPDgjGKhsE
	 wT5Xz62sxqOFAsv3bFQdm27nkT19pZu+2iEAi4xqmwyHiSsnnPBJVQ2+RPU4/Seo8A5pT
	 yHiF1C2rSuIiD9VvL9WMgo2Gwg8gD9uwpj7W1zBOAoGhVvF6nw+EELAKXE3Zp4UTWWYif
	 XGne76xiHQI9EPjZSxON+tKjSml/lhDpDywts2baAkZlq2qYpx2Rf52EWEhw5uym+9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3lud85Yp;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=gIjKeGI7;
	arc=none smtp.remote-ip=160.80.4.35
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AC606B2E4;
	Wed,  4 Nov 2026 20:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 508AC606B2E4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=3lud85Yp;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=gIjKeGI7
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A4Kmwv7026955;
	Wed, 4 Nov 2026 21:49:03 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 3A5D8121681;
	Wed,  4 Nov 2026 21:48:53 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793825333; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWiRV1sGkuoDXhM09Z+91Z+gqhSc78puMi7yQgR1TGE=;
	b=3lud85Ypuk1tJ4tH2Yskpq8GzXEWvWfGmN9+7cebU6nDqyMHSirqd70IOiIm/74cz/PBeg
	jLQkFeBqdmDRtaDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793825333; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWiRV1sGkuoDXhM09Z+91Z+gqhSc78puMi7yQgR1TGE=;
	b=gIjKeGI7fmepMSDdBPAlik4cT5XZmFCK5v/N/c5pedyglD8RjJJr/NOmaJ01XH904Vu+xZ
	9sjCp9XD/QzLFvudkjfrFM7ku642bphdwieD9vqn0D2MkOjX4O8Gpv0K2N19MXGh0DamjS
	p5z1qyxWzfxl6H5o6jyO/gFN3kYtYoP+QZNICk/l/QypChvSHz6M2zbcKA7ACKvy61IikD
	FpL/nILSAQC12OE8NTobXZm/gTvou1yZMIjNHxUidllVDFySilBE09vEKxybns9UBLXKpe
	cEPbLllIc7QziULnLD6LibaeiCdAZxW6/AgU2huu7TFG3Me21r5jubtRz0qwUg==
Date: Wed, 4 Nov 2026 21:48:52 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, David Lebrun
 <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer
 <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 6/6] selftests: seg6: add test for skb checksum with
 CHECKSUM_COMPLETE
Message-Id: <20261104214852.853a936a50a49e2cf2acbbd4@uniroma2.it>
In-Reply-To: <aulUayPCDOYwAm1e@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-7-andrea.mayer@uniroma2.it>
 <aulUayPCDOYwAm1e@fedora>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 3 Nov 2026 11:26:35 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> [snip]
> > +
> > +log_test()
> > +{
> > +	log_test_expected "$1" "$2" "$3"
> > +}
> 
> We'd better use log_test_expected directly, otherwise the log_test in
> lib.sh will be overwrite.

Hi Hangbin,

Right, I will call log_test_expected() directly in v2.

> > +
> > +test_command_or_ksft_skip()
> > +{
> > +	local cmd="$1"
> > +
> > +	if [ ! -x "$(command -v "${cmd}")" ]; then
> > +		echo "SKIP: Could not run test without \"${cmd}\" tool"
> > +		exit "${ksft_skip}"
> > +	fi
> > +}
> 
> Then we can use require_command() in lib.sh here, which will call
> log_test() in lib.sh.

Yes, I will use require_command() too.

> [snip]
> > +
> > +if [ "$(id -u)" -ne 0 ]; then
> > +	echo "SKIP: Need root privileges"
> > +	exit "${ksft_skip}"
> > +fi
> 
> I wonder if there is any one run the selftest with none root privileges.
> Cause almost all the selftests need ip configurations.
> [snip]

The test needs root privileges to create the namespaces, write the
sysctls, add the tc filters and load the BPF programs. Without the
check, a non-root user without these privileges gets a SKIP from a later
check, for example "SKIP: dummy dev not supported", which does not say
that the privileges are missing. With the check, that user gets "SKIP:
Need root privileges". I would prefer to keep it.

Thanks for the review,
Andrea
